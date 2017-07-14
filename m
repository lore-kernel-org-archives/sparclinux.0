From: David Miller <davem@davemloft.net>
Date: Fri, 14 Jul 2017 18:17:36 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <20170714.111736.1772446071468322462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>
Date: Tue, 11 Jul 2017 12:00:54 -0600

BTW, for sparc64 specific changes, please use the "sparc64: " subsystem
prefix in your Subject lines.  I've fixed it up for you this time.

> But a busy system is not a broken system. In the above scenario, as long
> as the receiver is making forward progress processing mondo interrupts,
> the sender should continue to retry.

So I'm going to apply this patch, but I absolutely, fundamentally disagree
with this statement.

Making forward progress only processing mondo interrupts _IS_ broken.

A cpu stuck doing nothing but processing mondo interrupts is in an error
state.

I repeat, it is not valid for a cpu to be stuck doing mondo interrupt
processing.  This is true, even if it is making "forward progress"
within that backlog of mondo interrupts.

A cpu must always, somehow, continually make forward progress in it's
primary instruction stream.

In the kernel, for example, when we have so many software interrupts
that the cpu is not making forward progress on anything else, we defer
the software interrupt processing to a kernel thread instead of doing
it immediately.  This is absolutely required, so that the primary
exectuion stream of the cpu always makes forward progress.

We must do something similar here with MONDOs.

Either we find a way to decrease the cost of the individual mondos
(and this makes sense, mondos should be something that executes in an
extremely small, finite, amount of time) so that these backlogs can't
happen in the first place.

Or, we make some kind of deferral mechanism for the most expensive
kinds of mondos.

I'm still pretty sure that unmaps are taking an unreasonable amount of
time to execute.  Our current range flush implementation is incredibly
stupid, and could be improved by orders of magnitude.  It allocates an
entire kernel stack frame, just so that it can call __flush_tlb_pending().

In fact, we can end up doing this full trap entry/exit just for
purging 2 or 3 pages.

So this means we need an in-assembler cross-call trap handler that can
do the TLB pending flush directly.  And, we also need a limiter that
says "if the number of pages pending to TLB purge is greater than X,
do an MM context TLB flush instead".  X should probably be something
on the order of the number of entries in the hardware TLB CAM.

To me this all is a huge red flag, and probably causes all of the
mondo timesouts you've seen except for the PCI-E hotplug cases.
