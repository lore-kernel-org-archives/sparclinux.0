From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 14 Sep 2020 07:00:29 +0000
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
Message-Id: <1600066040.vnmz9nxhwt.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
In-Reply-To: <20200914045219.3736466-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, "David S . Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <peterz@infradead.org>, sparclinux@vger.kernel.org

Excerpts from Nicholas Piggin's message of September 14, 2020 2:52 pm:

[...]

> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
> optimisation could be effectively restored by sending IPIs to mm_cpumask
> members and having them remove themselves from mm_cpumask. This is more
> tricky so I leave it as an exercise for someone with a sparc64 SMP.
> powerpc has a (currently similarly broken) example.

So this compiles and boots on qemu, but qemu does not support any
sparc64 machines with SMP. Attempting some simple hacks doesn't get
me far because openbios isn't populating an SMP device tree, which
blows up everywhere.

The patch is _relatively_ simple, hopefully it shouldn't explode, so
it's probably ready for testing on real SMP hardware, if someone has
a few cycles.

Thanks,
Nick

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/sparc/kernel/smp_64.c | 65 ++++++++------------------------------
>  1 file changed, 14 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index e286e2badc8a..e38d8bf454e8 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1039,38 +1039,9 @@ void smp_fetch_global_pmu(void)
>   * are flush_tlb_*() routines, and these run after flush_cache_*()
>   * which performs the flushw.
>   *
> - * The SMP TLB coherency scheme we use works as follows:
> - *
> - * 1) mm->cpu_vm_mask is a bit mask of which cpus an address
> - *    space has (potentially) executed on, this is the heuristic
> - *    we use to avoid doing cross calls.
> - *
> - *    Also, for flushing from kswapd and also for clones, we
> - *    use cpu_vm_mask as the list of cpus to make run the TLB.
> - *
> - * 2) TLB context numbers are shared globally across all processors
> - *    in the system, this allows us to play several games to avoid
> - *    cross calls.
> - *
> - *    One invariant is that when a cpu switches to a process, and
> - *    that processes tsk->active_mm->cpu_vm_mask does not have the
> - *    current cpu's bit set, that tlb context is flushed locally.
> - *
> - *    If the address space is non-shared (ie. mm->count == 1) we avoid
> - *    cross calls when we want to flush the currently running process's
> - *    tlb state.  This is done by clearing all cpu bits except the current
> - *    processor's in current->mm->cpu_vm_mask and performing the
> - *    flush locally only.  This will force any subsequent cpus which run
> - *    this task to flush the context from the local tlb if the process
> - *    migrates to another cpu (again).
> - *
> - * 3) For shared address spaces (threads) and swapping we bite the
> - *    bullet for most cases and perform the cross call (but only to
> - *    the cpus listed in cpu_vm_mask).
> - *
> - *    The performance gain from "optimizing" away the cross call for threads is
> - *    questionable (in theory the big win for threads is the massive sharing of
> - *    address space state across processors).
> + * mm->cpu_vm_mask is a bit mask of which cpus an address
> + * space has (potentially) executed on, this is the heuristic
> + * we use to limit cross calls.
>   */
>  
>  /* This currently is only used by the hugetlb arch pre-fault
> @@ -1080,18 +1051,13 @@ void smp_fetch_global_pmu(void)
>  void smp_flush_tlb_mm(struct mm_struct *mm)
>  {
>  	u32 ctx = CTX_HWBITS(mm->context);
> -	int cpu = get_cpu();
>  
> -	if (atomic_read(&mm->mm_users) == 1) {
> -		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
> -		goto local_flush_and_out;
> -	}
> +	get_cpu();
>  
>  	smp_cross_call_masked(&xcall_flush_tlb_mm,
>  			      ctx, 0, 0,
>  			      mm_cpumask(mm));
>  
> -local_flush_and_out:
>  	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
>  
>  	put_cpu();
> @@ -1114,17 +1080,15 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
>  {
>  	u32 ctx = CTX_HWBITS(mm->context);
>  	struct tlb_pending_info info;
> -	int cpu = get_cpu();
> +
> +	get_cpu();
>  
>  	info.ctx = ctx;
>  	info.nr = nr;
>  	info.vaddrs = vaddrs;
>  
> -	if (mm == current->mm && atomic_read(&mm->mm_users) == 1)
> -		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
> -	else
> -		smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
> -				       &info, 1);
> +	smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
> +			       &info, 1);
>  
>  	__flush_tlb_pending(ctx, nr, vaddrs);
>  
> @@ -1134,14 +1098,13 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
>  void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
>  {
>  	unsigned long context = CTX_HWBITS(mm->context);
> -	int cpu = get_cpu();
>  
> -	if (mm == current->mm && atomic_read(&mm->mm_users) == 1)
> -		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
> -	else
> -		smp_cross_call_masked(&xcall_flush_tlb_page,
> -				      context, vaddr, 0,
> -				      mm_cpumask(mm));
> +	get_cpu();
> +
> +	smp_cross_call_masked(&xcall_flush_tlb_page,
> +			      context, vaddr, 0,
> +			      mm_cpumask(mm));
> +
>  	__flush_tlb_page(context, vaddr);
>  
>  	put_cpu();
> -- 
> 2.23.0
> 
> 
