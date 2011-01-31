From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 31 Jan 2011 17:00:21 +0000
Subject: Re: [PATCH 1/2] SPARC32: implement SMP IPIs using the generic functions
Message-Id: <4D46EAA5.1030704@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Wed, 26 Jan 2011 17:38:30 +0100
>
>  
>
>>The current SPARC32 SMP IPI generation is implemented the
>>cross call function. The cross call function uses IRQ15 the
>>NMI, this is has the effect that IPIs will interrupt IRQ
>>critical areas and hang the system. Typically on/after
>>spin_lock_irqsave calls can be aborted.
>>
>>The cross call functionality must still exist to flush
>>cache/TLBS.
>>
>>This patch provides CPU models a custom way to implement
>>generation of IPIs on the generic code's request. The
>>typical approach is to generate an IRQ for each IPI case.
>>
>>After this patch each SPARC32 SMP CPU model needs to
>>implement IPIs in order to function properly.
>>
>>Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>    
>>
>
>Overall this looks fine, but there are some things we need to
>fix up before we can consider applying this.
>
>First off, since you do the:
>
>	select USE_GENERIC_SMP_HELPERS if SMP
>
>under "SPARC", you can remove the select line for this that
>exists under "SPARC64" since that is no longer needed.
>  
>
Of course, will change before submitting next time.

>As per the implementation, I think there are implicit races
>which come to be shown more explicitly in your LEON implementation.
>
>You can't have a per-cpu blob of status and modify remote cpu
>values the way you do, it's racy.
>
>Let's say cpu 1 sends to cpu 2, and cpu 3 tries to send to cpu 2
>at the same time.  It's possible for events to be lost since the
>setting and clearing of the per-cpu masks are done non-atomically.
>
>The solution, I think, is to use multiple software interrupt vectors
>to distinguish the various cases.
>  
>
For now I have changed the code to use a spinlock around the 
"work->msk=1 and IRQ generation" and the clearing of the "work->msk" in 
the interrupt handler.

But I disagree for the moment.. I used three IRQs to implement it the 
very first time because all other architectures does so and I also 
suspected races at first, however I think using memory barriers this way 
is enough. Since the clearing of the work->msk flag is always done after 
it has been checked and will will result in a call to the generic 
handler, so if a write to it was lost due to race does not really matter 
since it will reach the generic handler anyway (that was why it cleared it).

Note that events will be lost when using 3 separate IRQs as well, when 
two CPUs are writing the soft-IRQ generate register when the target CPU 
is already is in an interrupt context only one IRQ will be generated. 
But I don't think it is the number of events that is the important thing 
here, rather one must make sure to enter the generic IPI-handler as long 
as there is something in the generic IPI-queue.

Anyway, I think using 3 IRQs is not a good option for the LEON 
architecture since it is a shortage of IRQs. And different LEON chips 
has different IRQ sources assign making it impossible to use the same 
kernel on multiple chips. If 3 IRQs will be required... so be it.

>I think we need 3, plus IRQ 15 for the cache/tlb flush IPIs.
>
>I tried to figure out if we have enough on LEON, but because the
>per-cpu timer is variable, I can't figure that out.  Does that per-cpu
>timer use IRQ 14?
>  
>
This varies slightly from design/chip to design unfortunatly. I will 
probably need to make this configurable from the GUI.

There are no per-cpu timers on the LEON, however there are multiple 
"global general purpose timers" which can generate IRQ that the IRQ 
controller can broadcast to all CPUs and/or individual CPUs by a 
mask-setting. That is why I can use only one timer for system clock and 
cpu profiling.

>I think we can make this work on sun4m/sun4c/sun4d, which have several
>software interrupt vectors available.
>  
>
Ok, good.

>sun4m has 15 soft interrupts, in the sun4m_irq_percpu->{pending,clear,set}
>registers, these live sequentially starting at bit 16, as per the definition
>of the SUN4M_SOFT_INT() macro.
>
>The only catch is that we'll need to peek at the ->pending register(s) to
>determine if we have a hardware or software interrupt pending at a given
>PIL level (or both).
>  
>
sounds nice.

>I'm not sure how the software interrupt triggering works on sun4c, but that
>doesn't matter since we only need this on SMP.
>
>The sun4d code has a sun4d_send_ipi() interface from which the necessary
>code can be constructed.
>  
>




