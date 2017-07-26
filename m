From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 22:45:40 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170726.154540.150558937277891719.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726.095432.169004918437663011.davem@davemloft.net>
 <20170726175013.GT3730@linux.vnet.ibm.com>
 <20170726223658.GA27617@linux.vnet.ibm.com>
In-Reply-To: <20170726223658.GA27617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 15:36:58 -0700

> And without CONFIG_SOFTLOCKUP_DETECTOR, I see five runs of 24 with RCU
> CPU stall warnings.  So it seems likely that CONFIG_SOFTLOCKUP_DETECTOR
> really is having an effect.

Thanks for all of the info Paul, I'll digest this and scan over the
code myself.

Just out of curiousity, what x86 idle method is your machine using?
The mwait one or the one which simply uses 'halt'?  The mwait variant
might mask this bug, and halt would be a lot closer to how sparc64 and
Jonathan's system operates.

On sparc64 the cpu yield we do in the idle loop sleeps the cpu.  It's
local TICK register keeps advancing, and the local timer therefore
will still trigger.  Also, any externally generated interrupts
(including cross calls) will wake up the cpu as well.

The tick-sched code is really tricky wrt. NO_HZ even in the NO_HZ_IDLE
case.  One of my running theories is that we miss scheduling a tick
due to a race.  That would be consistent with the behavior we see
in the RCU dumps, I think.

Anyways, just a theory, and that's why I keep mentioning that commit
about the revert of the revert (specifically
411fe24e6b7c283c3a1911450cdba6dd3aaea56e).

:-)
