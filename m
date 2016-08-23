From: David Miller <davem@davemloft.net>
Date: Tue, 23 Aug 2016 18:19:37 +0000
Subject: Re: Cascading crash on ECC error
Message-Id: <20160823.111937.1705515382461601128.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1608231319140.14842@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1608231319140.14842@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 23 Aug 2016 13:28:00 +0300 (EEST)

> This happens on my trusty Ultra 5. The root cause seems to be a failing 
> DIMM. Where it gets interesting is how this failure is detected and how 
> it causes a full crash up to RED state exception.
> 
> What should actually happen when uncorrectable memory error happens? If 
> this happens from IRQ context, not process context, this should cause 
> kernel panic, right?
> 
> But why do we detect this error from IRQ context - is it just random or 
> do we get an error interrupt and therefore always detect this in IRQ 
> context, and always get kernel panic?
> 
> Second, why do we get to RED state exceptioin from here?

We're in a hrtimer, that's why we're in an interrupt.  This cpu was
in the idle loop and took a timer interrupt, then tried to deliver
a signal to the user from the timer interrupt.

This one is really hard to recover from, because the address that took
the error was in the area the cpu was executing instructions.

> CPU[0]: Uncorrectable Error AFSR[180300000] AFAR[468980] UDBL[8c000] UDBH[560] TT[a] TL>1[0]

AFAR 0x468980

> TSTATE: 0000009980e01600 TPC: 0000000000468980 TNPC: 0000000000468990 Y: 00000000    Tainted: G        W      

TPC 0x468980
