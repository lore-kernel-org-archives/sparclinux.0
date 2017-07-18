From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2017 18:28:21 +0000
Subject: Re: [PATCH v3] sparc64: Prevent perf from running during super critical sections
Message-Id: <20170718.112821.1467709423676340083.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500304947-60133-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1500304947-60133-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 17 Jul 2017 09:22:27 -0600

> This fixes another cause of random segfaults and bus errors that may
> occur while running perf with the callgraph option.
> 
> Critical sections beginning with spin_lock_irqsave() raise the interrupt
> level to PIL_NORMAL_MAX (14) and intentionally do not block performance
> counter interrupts, which arrive at PIL_NMI (15).
> 
> But some sections of code are "super critical" with respect to perf
> because the perf_callchain_user() path accesses user space and may cause
> TLB activity as well as faults as it unwinds the user stack.
> 
> One particular critical section occurs in switch_mm:
> 
>         spin_lock_irqsave(&mm->context.lock, flags);
>         ...
>         load_secondary_context(mm);
>         tsb_context_switch(mm);
>         ...
>         spin_unlock_irqrestore(&mm->context.lock, flags);
> 
> If a perf interrupt arrives in between load_secondary_context() and
> tsb_context_switch(), then perf_callchain_user() could execute with
> the context ID of one process, but with an active TSB for a different
> process. When the user stack is accessed, it is very likely to
> incur a TLB miss, since the h/w context ID has been changed. The TLB
> will then be reloaded with a translation from the TSB for one process,
> but using a context ID for another process. This exposes memory from
> one process to another, and since it is a mapping for stack memory,
> this usually causes the new process to crash quickly.
> 
> This super critical section needs more protection than is provided
> by spin_lock_irqsave() since perf interrupts must not be allowed in.
> 
> Since __tsb_context_switch already goes through the trouble of
> disabling interrupts completely, we fix this by moving the secondary
> context load down into this better protected region.
> 
> Orabug: 25577560
> 
> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>

Applied and queued up for -stable, thanks Rob.
