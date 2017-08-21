From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 21 Aug 2017 14:19:28 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170822001928.74f01322@roar.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
 <20170816125617.GY7017@linux.vnet.ibm.com>
 <20170816162731.GA22978@linux.vnet.ibm.com>
 <20170820144553.2ab2727b@ppc64le>
 <20170820230040.706b62ac@roar.ozlabs.ibm.com>
 <20170820183514.GM11320@linux.vnet.ibm.com>
 <20170820211429.GA27111@linux.vnet.ibm.com>
 <20170821105258.191d04b1@roar.ozlabs.ibm.com>
 <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
In-Reply-To: <20170821111833.00006753@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 21 Aug 2017 11:18:33 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 21 Aug 2017 16:06:05 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > On Mon, 21 Aug 2017 10:52:58 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> >   
> > > On Sun, 20 Aug 2017 14:14:29 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >     
> > > > On Sun, Aug 20, 2017 at 11:35:14AM -0700, Paul E. McKenney wrote:      
> > > > > On Sun, Aug 20, 2017 at 11:00:40PM +1000, Nicholas Piggin wrote:        
> > > > > > On Sun, 20 Aug 2017 14:45:53 +1000
> > > > > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > > >         
> > > > > > > On Wed, 16 Aug 2017 09:27:31 -0700
> > > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:        
> > > > > > > > On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
> > > > > > > > 
> > > > > > > > Thomas, John, am I misinterpreting the timer trace event messages?          
> > > > > > > 
> > > > > > > So I did some digging, and what you find is that rcu_sched seems to do a
> > > > > > > simple scheudle_timeout(1) and just goes out to lunch for many seconds.
> > > > > > > The process_timeout timer never fires (when it finally does wake after
> > > > > > > one of these events, it usually removes the timer with del_timer_sync).
> > > > > > > 
> > > > > > > So this patch seems to fix it. Testing, comments welcome.        
> > > > > > 
> > > > > > Okay this had a problem of trying to forward the timer from a timer
> > > > > > callback function.
> > > > > > 
> > > > > > This was my other approach which also fixes the RCU warnings, but it's
> > > > > > a little more complex. I reworked it a bit so the mod_timer fast path
> > > > > > hopefully doesn't have much more overhead (actually by reading jiffies
> > > > > > only when needed, it probably saves a load).        
> > > > > 
> > > > > Giving this one a whirl!        
> > > > 
> > > > No joy here, but then again there are other reasons to believe that I
> > > > am seeing a different bug than Dave and Jonathan are.
> > > > 
> > > > OK, not -entirely- without joy -- 10 of 14 runs were error-free, which
> > > > is a good improvement over 0 of 84 for your earlier patch.  ;-)  But
> > > > not statistically different from what I see without either patch.
> > > > 
> > > > But no statistical difference compared to without patch, and I still
> > > > see the "rcu_sched kthread starved" messages.  For whatever it is worth,
> > > > by the way, I also see this: "hrtimer: interrupt took 5712368 ns".
> > > > Hmmm...  I am also seeing that without any of your patches.  Might
> > > > be hypervisor preemption, I guess.      
> > > 
> > > Okay it makes the warnings go away for me, but I'm just booting then
> > > leaving the system idle. You're doing some CPU hotplug activity?    
> > 
> > Okay found a bug in the patch (it was not forwarding properly before
> > adding the first timer after an idle) and a few other concerns.
> > 
> > There's still a problem of a timer function doing a mod timer from
> > within expire_timers. It can't forward the base, which might currently
> > be quite a way behind. I *think* after we close these gaps and get
> > timely wakeups for timers on there, it should not get too far behind
> > for standard timers.
> > 
> > Deferrable is a different story. Firstly it has no idle tracking so we
> > never forward it. Even if we wanted to, we can't do it reliably because
> > it could contain timers way behind the base. They are "deferrable", so
> > you get what you pay for, but this still means there's a window where
> > you can add a deferrable timer and get a far later expiry than you
> > asked for despite the CPU never going idle after you added it.
> > 
> > All these problems would seem to go away if mod_timer just queued up
> > the timer to a single list on the base then pushed them into the
> > wheel during your wheel processing softirq... Although maybe you end
> > up with excessive passes over big queue of timers. Anyway that
> > wouldn't be suitable for 4.13 even if it could work.
> > 
> > I'll send out an updated minimal fix after some more testing...  
> 
> Hi All,
> 
> I'm back in the office with hardware access on our D05 64 core ARM64
> boards.
> 
> I think we still have by far the quickest test cases for this so
> feel free to ping me anything you want tested quickly (we were
> looking at an average of less than 10 minutes to trigger
> with machine idling).
> 
> Nick, I'm currently running your previous version and we are over an
> hour so even without any instances of the issue so it looks like a
> considerable improvement.  I'll see if I can line a couple of boards
> up for an overnight run if you have your updated version out by then.
> 
> Be great to finally put this one to bed.

Hi Jonathan,

Thanks here's an updated version with a couple more bugs fixed. If
you could try testing, that would be much appreciated.

Thanks,
Nick

---
 kernel/time/timer.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8f5d1bf18854..2b9d2cdb3fac 100644
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
 
@@ -1611,6 +1627,17 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
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


