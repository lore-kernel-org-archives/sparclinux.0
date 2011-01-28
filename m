From: David Miller <davem@davemloft.net>
Date: Fri, 28 Jan 2011 23:33:19 +0000
Subject: Re: [PATCH 1/2] SPARC32: implement SMP IPIs using the generic
Message-Id: <20110128.153319.35042623.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 26 Jan 2011 17:38:30 +0100

> The current SPARC32 SMP IPI generation is implemented the
> cross call function. The cross call function uses IRQ15 the
> NMI, this is has the effect that IPIs will interrupt IRQ
> critical areas and hang the system. Typically on/after
> spin_lock_irqsave calls can be aborted.
> 
> The cross call functionality must still exist to flush
> cache/TLBS.
> 
> This patch provides CPU models a custom way to implement
> generation of IPIs on the generic code's request. The
> typical approach is to generate an IRQ for each IPI case.
> 
> After this patch each SPARC32 SMP CPU model needs to
> implement IPIs in order to function properly.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

Overall this looks fine, but there are some things we need to
fix up before we can consider applying this.

First off, since you do the:

	select USE_GENERIC_SMP_HELPERS if SMP

under "SPARC", you can remove the select line for this that
exists under "SPARC64" since that is no longer needed.

As per the implementation, I think there are implicit races
which come to be shown more explicitly in your LEON implementation.

You can't have a per-cpu blob of status and modify remote cpu
values the way you do, it's racy.

Let's say cpu 1 sends to cpu 2, and cpu 3 tries to send to cpu 2
at the same time.  It's possible for events to be lost since the
setting and clearing of the per-cpu masks are done non-atomically.

The solution, I think, is to use multiple software interrupt vectors
to distinguish the various cases.

I think we need 3, plus IRQ 15 for the cache/tlb flush IPIs.

I tried to figure out if we have enough on LEON, but because the
per-cpu timer is variable, I can't figure that out.  Does that per-cpu
timer use IRQ 14?

I think we can make this work on sun4m/sun4c/sun4d, which have several
software interrupt vectors available.

sun4m has 15 soft interrupts, in the sun4m_irq_percpu->{pending,clear,set}
registers, these live sequentially starting at bit 16, as per the definition
of the SUN4M_SOFT_INT() macro.

The only catch is that we'll need to peek at the ->pending register(s) to
determine if we have a hardware or software interrupt pending at a given
PIL level (or both).

I'm not sure how the software interrupt triggering works on sun4c, but that
doesn't matter since we only need this on SMP.

The sun4d code has a sun4d_send_ipi() interface from which the necessary
code can be constructed.
