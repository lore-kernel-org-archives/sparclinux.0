From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 26 Jul 2017 18:35:28 +0000
Subject: Re: [PATCH 2/3] sparc64: Add 16GB hugepage support
Message-Id: <d2438f2d-87ca-c09a-1891-ed39f4139089@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1499982815-183450-1-git-send-email-nitin.m.gupta@oracle.com>
 <1499982815-183450-3-git-send-email-nitin.m.gupta@oracle.com>
 <20170720.130435.1273416665807575517.davem@davemloft.net>
In-Reply-To: <20170720.130435.1273416665807575517.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mike.kravetz@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, mhocko@suse.com, mingo@kernel.org, akpm@linux-foundation.org, steve.capper@arm.com, hughd@google.com, punit.agrawal@arm.com, bob.picco@oracle.com, pasha.tatashin@oracle.com, steven.sistare@oracle.com, paul.gortmaker@windriver.com, thomas.tai@oracle.com, atish.patra@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 07/20/2017 01:04 PM, David Miller wrote:
> From: Nitin Gupta <nitin.m.gupta@oracle.com>
> Date: Thu, 13 Jul 2017 14:53:24 -0700
> 
>> Testing:
>>
>> Tested with the stream benchmark which allocates 48G of
>> arrays backed by 16G hugepages and does RW operation on
>> them in parallel.
> 
> It would be great if we started adding tests under
> tools/testing/selftests so that other people can recreate
> your tests/benchmarks.
> 

Yes, I would like to add the stream benchmark to selftests too.
I will check if our internal version of stream can be released.


>> diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
>> index 32258e0..7b240a3 100644
>> --- a/arch/sparc/include/asm/tsb.h
>> +++ b/arch/sparc/include/asm/tsb.h
>> @@ -195,6 +195,35 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
>>  	 nop; \
>>  699:
>>  
>> +	/* PUD has been loaded into REG1, interpret the value, seeing
>> +	 * if it is a HUGE PUD or a normal one.  If it is not valid
>> +	 * then jump to FAIL_LABEL.  If it is a HUGE PUD, and it
>> +	 * translates to a valid PTE, branch to PTE_LABEL.
>> +	 *
>> +	 * We have to propagate bits [32:22] from the virtual address
>> +	 * to resolve at 4M granularity.
>> +	 */
>> +#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
>> +#define USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
>> +	brz,pn		REG1, FAIL_LABEL;		\
>> +	 sethi		%uhi(_PAGE_PUD_HUGE), REG2;	\
>> +	sllx		REG2, 32, REG2;			\
>> +	andcc		REG1, REG2, %g0;		\
>> +	be,pt		%xcc, 700f;			\
>> +	 sethi		%hi(0x1ffc0000), REG2;		\
>> +	sllx		REG2, 1, REG2;			\
>> +	brgez,pn	REG1, FAIL_LABEL;		\
>> +	 andn		REG1, REG2, REG1;		\
>> +	and		VADDR, REG2, REG2;		\
>> +	brlz,pt		REG1, PTE_LABEL;		\
>> +	 or		REG1, REG2, REG1;		\
>> +700:
>> +#else
>> +#define USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
>> +	brz,pn		REG1, FAIL_LABEL; \
>> +	 nop;
>> +#endif
>> +
>>  	/* PMD has been loaded into REG1, interpret the value, seeing
>>  	 * if it is a HUGE PMD or a normal one.  If it is not valid
>>  	 * then jump to FAIL_LABEL.  If it is a HUGE PMD, and it
>> @@ -242,6 +271,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
>>  	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
>>  	andn		REG2, 0x7, REG2; \
>>  	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
>> +	USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, 800f) \
>>  	brz,pn		REG1, FAIL_LABEL; \
>>  	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
>>  	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
> 
> This macro is getting way out of control, every TLB/TSB miss is
> going to invoke this sequence of code.
> 
> Yes, it's just a two cycle constant load, a test modifying the
> condition codes, and an easy to predict branch.
> 
> But every machine will eat this overhead, even if they don't use
> hugepages or don't set the 16GB knob.
> 
> I think we can do better, using code patching or similar.
> 
> Once the knob is set, you can know for sure that this code path
> will never actually be taken.

The simplest way I can think of is to add CONFIG_SPARC_16GB_HUGEPAGE
and exclude PUD check if not enabled.  Would this be okay?

Thanks,
Nitin

