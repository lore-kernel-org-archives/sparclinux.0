From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 19 Apr 2013 14:46:26 +0000
Subject: Re: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <517158C2.1090304@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <516F0B8A.5070407@oracle.com>
In-Reply-To: <516F0B8A.5070407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/18/2013 07:51 PM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 17 Apr 2013 18:44:45 -0400 (EDT)
> 
>> It's not that difficult, I implemented a patch and will post it
>> after I'm done debugging it.
> 
> Here's what I've been stress testing.
> 
> This deals with a whole slew of problems all in one go.
> 
> 1) Use generic smp_call_function_many() so that we don't have to write
>    our own synchronization mechanism.  This function does not return
>    until all cross call siblings finish their work.
> 
> 2) Use the paravirtualization hooks arch_{enter,leave}_lazy_mmu_mode,
>    to guard when we actually do batching.  This also makes sure we do
>    batching inside of the page table locks which will be beneficial in
>    the future.
> 
>    This idea is taken from powerpc.
> 
> 3) When the batcher is not active, we flush a page at a time,
>    synchronously.
> 
> 4) Another side effect is that the batch cross call now runs with a
>    full environment rather than within an interrupt vector trap
>    handler.  There has been talk of adding support for batched TLB
>    flushes in the sun4v hypervisor, so that we don't have to perform a
>    full hypervisor trap for every page, and having more registers to
>    work with will facilitate being able to take advantage of that.
> 
> 5) We no longer flush the batch from switch_to() which means we don't
>    do it with interrupts disabled and the runqueue locks held.
> 
> This passed a loop of make -j128 kernel builds on a SPARC-T4 as well
> as a gcc bootstrap and testsuite run.  I plan to do some quick testing
> on a cheetah based system tomorrow in order to make sure the non-sun4v
> code paths work fine.
> 
> Dave, can you see if this patch fixes your test case?

It does fix it. I do have one concern though...

> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 537eb66..33bd996 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -849,7 +849,7 @@ void smp_tsb_sync(struct mm_struct *mm)
>  }
>  
>  extern unsigned long xcall_flush_tlb_mm;
> -extern unsigned long xcall_flush_tlb_pending;
> +extern unsigned long xcall_flush_tlb_page;
>  extern unsigned long xcall_flush_tlb_kernel_range;
>  extern unsigned long xcall_fetch_glob_regs;
>  extern unsigned long xcall_fetch_glob_pmu;
> @@ -1074,23 +1074,47 @@ local_flush_and_out:
>  	put_cpu();
>  }
>  
> +struct tlb_pending_info {
> +	unsigned long ctx;
> +	unsigned long nr;
> +	unsigned long *vaddrs;
> +};
> +
> +static void tlb_pending_func(void *info)
> +{
> +	struct tlb_pending_info *t = info;
> +
> +	__flush_tlb_pending(t->ctx, t->nr, t->vaddrs);
> +}
> +
>  void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long *vaddrs)
>  {
>  	u32 ctx = CTX_HWBITS(mm->context);
> +	struct tlb_pending_info info;
>  	int cpu = get_cpu();
>  
> +	info.ctx = ctx;
> +	info.nr = nr;
> +	info.vaddrs = vaddrs;
> +
>  	if (mm = current->mm && atomic_read(&mm->mm_users) = 1)
>  		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
>  	else
> -		smp_cross_call_masked(&xcall_flush_tlb_pending,
> -				      ctx, nr, (unsigned long) vaddrs,
> -				      mm_cpumask(mm));
> +		smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
> +				       &info, 1);
>  
>  	__flush_tlb_pending(ctx, nr, vaddrs);
>  
>  	put_cpu();
>  }
>  
> +void smp_flush_tlb_page(unsigned long context, unsigned long vaddr)
> +{
> +	smp_cross_call(&xcall_flush_tlb_page,
> +		       context, vaddr, 0);
> +	__flush_tlb_page(context, vaddr);
> +}
> +

Why not pass mm into smp_flush_tlb_page() and use mm_cpumask(mm) as is
done in smp_flush_tlb_pending()? I don't see why we wouldn't want to
duplicate that logic to avoid cross calls to every cpu for every
non-batched flush.

>  void smp_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
>  	start &= PAGE_MASK;
