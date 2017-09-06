From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 06 Sep 2017 12:28:44 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170906122844.GA30180@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
 <20170822001928.74f01322@roar.ozlabs.ibm.com>
 <20170821.135504.1392954698746959868.davem@davemloft.net>
 <20170822084911.00000c23@huawei.com>
 <1503391892.3629.28.camel@abdul.in.ibm.com>
 <20170822152637.GA11320@linux.vnet.ibm.com>
In-Reply-To: <20170822152637.GA11320@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 22, 2017 at 08:26:37AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 22, 2017 at 02:21:32PM +0530, Abdul Haleem wrote:
> > On Tue, 2017-08-22 at 08:49 +0100, Jonathan Cameron wrote:

[ . . . ]

> > No more RCU stalls on PowerPC, system is clean when idle or with some
> > test runs.
> > 
> > Thank you all for your time and efforts in fixing this.
> > 
> > Reported-and-Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> 
> I am still seeing failures, but then again I am running rcutorture with
> lots of CPU hotplug activity.  So I am probably seeing some other bug,
> though it still looks a lot like a lost timer.

So one problem appears to be a timing-related deadlock between RCU and
timers.  The way that this can happen is that the outgoing CPU goes
offline (as in cpuhp_report_idle_dead() invoked from do_idle()) with
one of RCU's grace-period kthread's timers queued.  Now, if someone
waits for a grace period, either directly or indirectly, in a way that
blocks the hotplug notifiers, execution will never reach timers_dead_cpu(),
which means that the grace-period kthread will never wake, which will
mean that the grace period will never complete.  Classic deadlock.

I currently have an extremely ugly workaround for this deadlock, which
is to periodically and (usually) redundantly wake up all the RCU
grace-period kthreads from the scheduling-interrupt handler.  This is
of course completely inappropriate for mainline, but it does reliably
prevent the "kthread starved for %ld jiffies!" type of RCU CPU stall
warning that I would otherwise see.

To mainline this, one approach would be to make the timers switch to
add_timer_on() to a surviving CPU once the offlining process starts.
Alternatively, I suppose that RCU could do the redundant-wakeup kludge,
but with checks to prevent it from happening unless (1) there is a CPU
in the process of going offline (2) there is an RCU grace period in
progress, and (3) the RCU grace period kthread has been blocked for
(say) three times longer than it should have.

Unfortunately, this is not sufficient to make rcutorture run reliably,
though it does help, which is of course to say that it makes debugging
slower.  ;-)

What happens now is that random rcutorture kthreads will hang waiting for
timeouts to complete.  This confused me for awhile because I expected
that the timeouts would be delayed during offline processing, but that
my crude deadlock-resolution approach would eventually get things going.
My current suspicion is that the problem is due to a potential delay
between the time an outgoing CPU hits cpuhp_report_idle_dead() and the
timers get migrated from timers_dead_cpu().  This means that the CPU
adopting the timers might be a few ticks ahead of where the outgoing CPU
last processed timers.  My current guess is that any timers queued in
intervening indexes are going to wait one good long time.  And I don't see
any code in the timers_dead_cpu() that would account for this possibility,
though I of course cannot claim to fully understand this code..

Is this plausible, or am I confused?  (Either way, -something- besides
just me is rather thoroughly confused!)

If this is plausible, my guess is that timers_dead_cpu() needs to check
for mismatched indexes (in timer->flags?) and force any intervening
timers to expire if so.

Thoughts?

							Thanx, Paul

