From: Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 20 Aug 2017 13:00:40 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170820230040.706b62ac@roar.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170728182053.000072aa@huawei.com>
 <20170728190349.GM3730@linux.vnet.ibm.com>
 <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
 <20170816125617.GY7017@linux.vnet.ibm.com>
 <20170816162731.GA22978@linux.vnet.ibm.com>
 <20170820144553.2ab2727b@ppc64le>
In-Reply-To: <20170820144553.2ab2727b@ppc64le>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, 20 Aug 2017 14:45:53 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Wed, 16 Aug 2017 09:27:31 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
> > 
> > Thomas, John, am I misinterpreting the timer trace event messages?  
> 
> So I did some digging, and what you find is that rcu_sched seems to do a
> simple scheudle_timeout(1) and just goes out to lunch for many seconds.
> The process_timeout timer never fires (when it finally does wake after
> one of these events, it usually removes the timer with del_timer_sync).
> 
> So this patch seems to fix it. Testing, comments welcome.

Okay this had a problem of trying to forward the timer from a timer
callback function.

This was my other approach which also fixes the RCU warnings, but it's
a little more complex. I reworked it a bit so the mod_timer fast path
hopefully doesn't have much more overhead (actually by reading jiffies
only when needed, it probably saves a load).

Thanks,
Nick

--
[PATCH] timers: Fix excessive granularity of new timers after a nohz idle

When a timer base is idle, it is forwarded when a new timer is added to
ensure that granularity does not become excessive. When not idle, the
timer tick is expected to increment the base.

However there is a window after a timer is restarted from nohz, when it
is marked not-idle, and before the timer tick on this CPU, where a timer
may be added on an ancient base that does not get forwarded (beacause
the timer appears not-idle).

This results in excessive granularity. So much so that a 1 jiffy timeout
has blown out to 10s of seconds and triggered the RCU stall warning
detector.

Fix this by keeping track of whether the timer has been idle since it was
last run or forwarded, and allow forwarding in the case that is true (even
if it is not currently idle).

Also add a comment noting a case where we could get an unexpectedly
large granularity for a timer. I debugged this problem by adding
warnings for such cases, but it seems we can't add them in general due
to this corner case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/time/timer.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8f5d1bf18854..ee7b8b688b48 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -203,6 +203,7 @@ struct timer_base {
 	bool			migration_enabled;
 	bool			nohz_active;
 	bool			is_idle;
+	bool			was_idle;
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
 
@@ -1499,8 +1513,10 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
 
@@ -1587,6 +1603,12 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
+	/*
+	 * was_idle must be cleared before running timers so that any timer
+	 * functions that call mod_timer will not try to forward the base.
+	 */
+	base->was_idle = false;
+
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
-- 
2.13.3

