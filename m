From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 17:50:13 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170726175013.GT3730@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726152315.00003d61@huawei.com>
 <20170726163340.0000014f@huawei.com>
 <20170726154900.GQ3730@linux.vnet.ibm.com>
 <20170726.095432.169004918437663011.davem@davemloft.net>
In-Reply-To: <20170726.095432.169004918437663011.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 26, 2017 at 09:54:32AM -0700, David Miller wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Wed, 26 Jul 2017 08:49:00 -0700
> 
> > On Wed, Jul 26, 2017 at 04:33:40PM +0100, Jonathan Cameron wrote:
> >> Didn't leave it long enough. Still bad on 4.10-rc7 just took over
> >> an hour to occur.
> > 
> > And it is quite possible that SOFTLOCKUP_DETECTOR=y and HZ_PERIODIC=y
> > are just greatly reducing the probability of the problem rather than
> > completely preventing it.
> > 
> > Still, hopefully useful information, thank you for the testing!
> 
> I guess that invalidates my idea to test reverting recent changes to
> the tick-sched.c code... :-/
> 
> In NO_HZ_IDLE mode, what is really supposed to happen on a completely
> idle system?
> 
> All the cpus enter the idle loop, have no timers programmed, and they
> all just go to sleep until an external event happens.
> 
> What ensures that grace periods get processed in this regime?

There are several different situations with different mechanisms:

1.	No grace period is in progress and no RCU callbacks are pending
	anywhere in the system.  In this case, some other event would
	need to start a grace period, so RCU just stays idle until that
	happens, possibly indefinitely.  According to the battery-powered
	embedded guys, this is a feature, not a bug.  ;-)

2.	No grace period is in progress, but there is at least one RCU
	callback somewhere in the system.  In this case, the mechanism
	depends on CONFIG_RCU_FAST_NO_HZ:

	CONFIG_RCU_FAST_NO_HZ=n:  The CPU on which the callback is
		queued will return "true" in response to the call to
		rcu_needs_cpu() that is made shortly before that CPU
		enters idle.  This will cause the scheduling-clock
		interrupt to remain on, despite the CPU being idle,
		which will in turn allow RCU's state machine to continue
		running out of softirq, triggered by the scheduling-clock
		interrupts.

	CONFIG_RCU_FAST_NO_HZ=y:  The CPU on which the callback is queued
		will return "false" in response to the call to
		rcu_needs_cpu() that is made shortly before that CPU
		enters idle.  However, it will also request a next event
		about six seconds in the future if all callbacks do
		nothing but free memory (kfree_rcu()), or about four
		jiffies in the future if at least one callback does
		something more than just free memory.

		There is also a rcu_prepare_for_idle() function that
		is invoked later in the idle-entry process in this case
		which will wake up the grace-period kthread if need be.

3.	A grace period is in progress.  In this case the grace-period
	kthread is either currently running (in which case there will be
	at least one non-idle CPU) or is in a timed wait for its next
	scan for idle/offline CPUs (such CPUs need the grace-period
	kthread to report quiescent states on their behalf).  In this
	latter case, the timer subsystem will post a next event that
	will be the wakeup time for the grace-period kthread, or some
	earlier event.

	This is where we have been seeing trouble, if for no other
	reason because RCU CPU stall warnings only happen when there
	is a grace period in progress.

That is the theory, anyway...

And when I enabled CONFIG_SOFTLOCKUP_DETECTOR, I still see failures.
I did 24 half-hour rcutorture runs on the TREE01 scenario, and two of them
saw RCU CPU stall warnings with starvation of the grace-period kthread.
I just now started another test but without CONFIG_SOFTLOCKUP_DETECTOR
to see if it makes a significance difference for my testing.  I do have
CONFIG_RCU_FAST_NO_HZ=y in my runs.

							Thanx, Paul

