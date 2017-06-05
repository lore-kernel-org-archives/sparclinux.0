From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 05 Jun 2017 03:50:55 +0000
Subject: Re: [v1 5/6] sparc64: new context wrap
Message-Id: <43c4e1cf-598e-cad6-dbeb-9aae5d70ae38@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496244325-180257-6-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1496244325-180257-6-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2017-06-04 22:01, David Miller wrote:
> From: Pavel Tatashin <pasha.tatashin@oracle.com>
> Date: Wed, 31 May 2017 11:25:24 -0400
> 
>> +	for_each_online_cpu(cpu) {
>> +		/*
>> +		 * If a new mm is stored after we took this mm from the array,
>> +		 * it will go into get_new_mmu_context() path, because we
>> +		 * already bumped the version in tlb_context_cache.
>> +		 */
>> +		mm = per_cpu(per_cpu_secondary_mm, cpu);
>> +
>> +		if (unlikely(!mm || mm = &init_mm))
>> +			continue;
>> +
>> +		old_ctx = mm->context.sparc64_ctx_val;
>> +		if (likely((old_ctx & CTX_VERSION_MASK) = old_ver)) {
>> +			new_ctx = (old_ctx & ~CTX_VERSION_MASK) | new_ver;
>> +			set_bit(new_ctx & CTX_NR_MASK, mmu_context_bmap);
>> +			mm->context.sparc64_ctx_val = new_ctx;
> 
> I wonder if there is a potential use after free here.
> 
> What synchronizes the per-cpu mm pointers with free_mm()?
> 
> For example, what stops another cpu from exiting a thread
> and dropping the mm between when you do the per_cpu() read
> of the 'mm' pointer and the tests and sets you do a few
> lines later?

Hi Dave,

ctx_alloc_lock in destroy_context() synchronizes wrap with free_mm(). By 
the time destroy_context() is called, we know that the last user of mm 
is freeing it, and we take the same lock that is owned during wrap.

I had the following asserts in destroy_context() for testing purposes:

	for_each_cpu(cpu, mm_cpumask(mm)) {
		mmp = per_cpu_ptr(&per_cpu_secondary_mm, cpu);
		if (*mmp = mm) {
			cmpxchg(mmp, mm, NULL);
			panic("BUG: mm[%p] in per_cpu_secondary_mm
			  CPU[%d, %d]", mm, smp_processor_id(), cpu);
		}
	}

And never hit it.

Pasha
