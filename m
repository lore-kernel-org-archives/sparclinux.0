From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 23:15:05 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170726231505.GG3730@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726.095432.169004918437663011.davem@davemloft.net>
 <20170726175013.GT3730@linux.vnet.ibm.com>
 <20170726223658.GA27617@linux.vnet.ibm.com>
 <20170726.154540.150558937277891719.davem@davemloft.net>
In-Reply-To: <20170726.154540.150558937277891719.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 26, 2017 at 03:45:40PM -0700, David Miller wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Wed, 26 Jul 2017 15:36:58 -0700
> 
> > And without CONFIG_SOFTLOCKUP_DETECTOR, I see five runs of 24 with RCU
> > CPU stall warnings.  So it seems likely that CONFIG_SOFTLOCKUP_DETECTOR
> > really is having an effect.
> 
> Thanks for all of the info Paul, I'll digest this and scan over the
> code myself.
> 
> Just out of curiousity, what x86 idle method is your machine using?
> The mwait one or the one which simply uses 'halt'?  The mwait variant
> might mask this bug, and halt would be a lot closer to how sparc64 and
> Jonathan's system operates.

My kernel builds with CONFIG_INTEL_IDLE=n, which I believe means that
I am not using the mwait one.  Here is a grep for IDLE in my .config:

	CONFIG_NO_HZ_IDLE=y
	CONFIG_GENERIC_SMP_IDLE_THREAD=y
	# CONFIG_IDLE_PAGE_TRACKING is not set
	CONFIG_ACPI_PROCESSOR_IDLE=y
	CONFIG_CPU_IDLE=y
	# CONFIG_CPU_IDLE_GOV_LADDER is not set
	CONFIG_CPU_IDLE_GOV_MENU=y
	# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
	# CONFIG_INTEL_IDLE is not set

> On sparc64 the cpu yield we do in the idle loop sleeps the cpu.  It's
> local TICK register keeps advancing, and the local timer therefore
> will still trigger.  Also, any externally generated interrupts
> (including cross calls) will wake up the cpu as well.
> 
> The tick-sched code is really tricky wrt. NO_HZ even in the NO_HZ_IDLE
> case.  One of my running theories is that we miss scheduling a tick
> due to a race.  That would be consistent with the behavior we see
> in the RCU dumps, I think.

But wouldn't you have to miss a -lot- of ticks to get an RCU CPU stall
warning?  By default, your grace period needs to extend for more than
21 seconds (more than one-third of a -minute-) to get one.  Or do
you mean that the ticks get shut off now and forever, as opposed to
just losing one of them?

> Anyways, just a theory, and that's why I keep mentioning that commit
> about the revert of the revert (specifically
> 411fe24e6b7c283c3a1911450cdba6dd3aaea56e).
> 
> :-)

I am running an overnight test in preparation for attempting to push
some fixes for regressions into 4.12, but will try reverting this
and enabling CONFIG_HZ_PERIODIC tomorrow.

Jonathan, might the commit that Dave points out above be what reduces
the probability of occurrence as you test older releases?

							Thanx, Paul

