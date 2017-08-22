From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 22 Aug 2017 01:54:39 +0000
Subject: [PATCH resend] timers: Fix excessive granularity of new timers after a nohz idle
Message-Id: <20170822015439.11263-1-npiggin@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

When a timer base is idle, it is forwarded when a new timer is added
to ensure that granularity does not become excessive. When not idle,
the timer tick is expected to increment the base.

However there are several problems:

- If an existing timer is modified, the base is forwarded only after
  the index is calculated.

- The base is not forwarded by add_timer_on.

- There is a window after a timer is restarted from a nohz ide, after
  it is marked not-idle and before the timer tick on this CPU, where a
  timer may be added but the ancient base does not get forwarded.

These result in excessive granularity (a 1 jiffy timeout can blow out
to 100s of jiffies), which cause the rcu lockup detector to trigger,
among other things.

Fix this by keeping track of whether the timer base has been idle
since it was last run or forwarded, and if so then forward it before
adding a new timer.

There is still a problem where the mod_timer optimization where it's
modified with the same expiry time can result in excessive granularity
relative to the new shorter interval. That is not addressed by this
patch because checking base->was_idle would increase overhead and it's
a rather special case (you could reason that the caller should not
expect change in absolute expiry time due to such an operation). So
that is noted as a comment.

As well as fixing the visible RCU softlockup failures, I tested an
idle system (with no lockup watchdogs running) and traced all
non-deferrable timer expiries for 1000s, and analysed wakeup latency
relative to requested latency.  1.0 means we slept for as many jiffies
as requested, 2.0 means we slept 2x the time (this suffers jiffies
round-up skew at low absolute times):

             max     avg      std
upstream   506.0    1.20     4.68
patched      2.0    1.08     0.15

This was noticed due to the lockup detector Kconfig changes dropping it
out of people's .configs. When the lockup detectors are enabled, no CPU
can go idle for longer than 4 seconds, which limits the granularity
errors. Sub-optimal timer behaviour is observable on a smaller scale:

             max     avg      std
upstream     9.0    1.05     0.19
patched      2.0    1.04     0.11

Tested-by: David Miller <davem@davemloft.net>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Hi Andrew,

I would have preferred to get comments from the timer maintainers, but
they've been busy or away for the past copule of weeks. Perhaps you
would consider carrying it until then?

Thanks,
Nick

 kernel/time/timer.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8f5d1bf18854..dd7be9fe6839 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -203,6 +203,7 @@ struct timer_base {
 	bool			migration_enabled;
 	bool			nohz_active;
 	bool			is_idle;
+	bool			was_idle; /* was it idle since last run/fwded */
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
@@ -856,13 +857,19 @@ get_target_base(struct timer_base *base, unsigned tflags)
 
 static inline void forward_timer_base(struct timer_base *base)
 {
-	unsigned long jnow = READ_ONCE(jiffies);
+	unsigned long jnow;
 
 	/*
-	 * We only forward the base when it's idle and we have a delta between
-	 * base clock and jiffies.
+	 * We only forward the base when we are idle or have just come out
+	 * of idle (was_idle logic), and have a delta between base clock
+	 * and jiffies. In the common case, run_timers will take care of it.
 	 */
-	if (!base->is_idle || (long) (jnow - base->clk) < 2)
+	if (likely(!base->was_idle))
+		return;
+
+	jnow = READ_ONCE(jiffies);
+	base->was_idle = base->is_idle;
+	if ((long)(jnow - base->clk) < 2)
 		return;
 
 	/*
@@ -938,6 +945,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 	 * same array bucket then just return:
 	 */
 	if (timer_pending(timer)) {
+		/*
+		 * The downside of this optimization is that it can result in
+		 * larger granularity than you would get from adding a new
+		 * timer with this expiry. Would a timer flag for networking
+		 * be appropriate, then we can try to keep expiry of general
+		 * timers within ~1/8th of their interval?
+		 */
 		if (timer->expires = expires)
 			return 1;
 
@@ -948,6 +962,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 		 * dequeue/enqueue dance.
 		 */
 		base = lock_timer_base(timer, &flags);
+		forward_timer_base(base);
 
 		clk = base->clk;
 		idx = calc_wheel_index(expires, clk);
@@ -964,6 +979,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 		}
 	} else {
 		base = lock_timer_base(timer, &flags);
+		forward_timer_base(base);
 	}
 
 	ret = detach_if_pending(timer, base, false);
@@ -991,12 +1007,10 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 			raw_spin_lock(&base->lock);
 			WRITE_ONCE(timer->flags,
 				   (timer->flags & ~TIMER_BASEMASK) | base->cpu);
+			forward_timer_base(base);
 		}
 	}
 
-	/* Try to forward a stale timer base clock */
-	forward_timer_base(base);
-
 	timer->expires = expires;
 	/*
 	 * If 'idx' was calculated above and the base time did not advance
@@ -1112,6 +1126,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 		WRITE_ONCE(timer->flags,
 			   (timer->flags & ~TIMER_BASEMASK) | cpu);
 	}
+	forward_timer_base(base);
 
 	debug_activate(timer, timer->expires);
 	internal_add_timer(base, timer);
@@ -1499,8 +1514,10 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		/*
 		 * If we expect to sleep more than a tick, mark the base idle:
 		 */
-		if ((expires - basem) > TICK_NSEC)
+		if ((expires - basem) > TICK_NSEC) {
+			base->was_idle = true;
 			base->is_idle = true;
+		}
 	}
 	raw_spin_unlock(&base->lock);
 
@@ -1611,6 +1628,17 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
+	/*
+	 * was_idle must be cleared before running timers so that any timer
+	 * functions that call mod_timer will not try to forward the base.
+	 *
+	 * The deferrable base does not do idle tracking at all, so we do
+	 * not forward it. This can result in very large variations in
+	 * granularity for deferrable timers, but they can be deferred for
+	 * long periods due to idle.
+	 */
+	base->was_idle = false;
+
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
-- 
2.13.3

