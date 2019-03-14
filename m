From: Alexandre Ghiti <alex@ghiti.fr>
Date: Thu, 14 Mar 2019 13:52:41 +0000
Subject: Re: [PATCH v6 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
Message-Id: <b6259684-ddc0-ade4-1881-016b5e7fff66@ghiti.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20190307132015.26970-1-alex@ghiti.fr>
 <20190307132015.26970-5-alex@ghiti.fr> <87va0movdh.fsf@linux.ibm.com>
 <e39f5b5b-efa1-c7b1-c1d8-89155b926027@ghiti.fr>
 <972208b7-5c05-cc05-efbf-0d48bff4cf77@linux.ibm.com>
In-Reply-To: <972208b7-5c05-cc05-efbf-0d48bff4cf77@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org



On 03/14/2019 02:17 PM, Aneesh Kumar K.V wrote:
> On 3/14/19 5:13 PM, Alexandre Ghiti wrote:
>> On 03/14/2019 06:52 AM, Aneesh Kumar K.V wrote:
>>> Alexandre Ghiti <alex@ghiti.fr> writes:
>>>
>>>> On systems without CONTIG_ALLOC activated but that support gigantic 
>>>> pages,
>>>> boottime reserved gigantic pages can not be freed at all. This patch
>>>> simply enables the possibility to hand back those pages to memory
>>>> allocator.
>>>>
>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>>> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
>>>> ---
>>>>   arch/arm64/Kconfig                           |  2 +-
>>>>   arch/arm64/include/asm/hugetlb.h             |  4 --
>>>>   arch/powerpc/include/asm/book3s/64/hugetlb.h |  7 ---
>>>>   arch/powerpc/platforms/Kconfig.cputype       |  2 +-
>>>>   arch/s390/Kconfig                            |  2 +-
>>>>   arch/s390/include/asm/hugetlb.h              |  3 --
>>>>   arch/sh/Kconfig                              |  2 +-
>>>>   arch/sparc/Kconfig                           |  2 +-
>>>>   arch/x86/Kconfig                             |  2 +-
>>>>   arch/x86/include/asm/hugetlb.h               |  4 --
>>>>   include/linux/gfp.h                          |  2 +-
>>>>   mm/hugetlb.c                                 | 57 
>>>> ++++++++++++--------
>>>>   mm/page_alloc.c                              |  4 +-
>>>>   13 files changed, 44 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 091a513b93e9..af687eff884a 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -18,7 +18,7 @@ config ARM64
>>>>       select ARCH_HAS_FAST_MULTIPLIER
>>>>       select ARCH_HAS_FORTIFY_SOURCE
>>>>       select ARCH_HAS_GCOV_PROFILE_ALL
>>>> -    select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
>>>> +    select ARCH_HAS_GIGANTIC_PAGE
>>>>       select ARCH_HAS_KCOV
>>>>       select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>>>       select ARCH_HAS_PTE_SPECIAL
>>>> diff --git a/arch/arm64/include/asm/hugetlb.h 
>>>> b/arch/arm64/include/asm/hugetlb.h
>>>> index fb6609875455..59893e766824 100644
>>>> --- a/arch/arm64/include/asm/hugetlb.h
>>>> +++ b/arch/arm64/include/asm/hugetlb.h
>>>> @@ -65,8 +65,4 @@ extern void set_huge_swap_pte_at(struct mm_struct 
>>>> *mm, unsigned long addr,
>>>>   #include <asm-generic/hugetlb.h>
>>>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>>>> -static inline bool gigantic_page_supported(void) { return true; }
>>>> -#endif
>>>> -
>>>>   #endif /* __ASM_HUGETLB_H */
>>>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h 
>>>> b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>>>> index 5b0177733994..d04a0bcc2f1c 100644
>>>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>>>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>>>> @@ -32,13 +32,6 @@ static inline int hstate_get_psize(struct hstate 
>>>> *hstate)
>>>>       }
>>>>   }
>>>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>>>> -static inline bool gigantic_page_supported(void)
>>>> -{
>>>> -    return true;
>>>> -}
>>>> -#endif
>>>> -
>>>>   /* hugepd entry valid bit */
>>>>   #define HUGEPD_VAL_BITS        (0x8000000000000000UL)
>>> As explained in https://patchwork.ozlabs.org/patch/1047003/
>>> architectures like ppc64 have a hypervisor assisted mechanism to 
>>> indicate
>>> where to find gigantic huge pages(16G pages). At this point, we 
>>> don't use this
>>> reserved pages for anything other than hugetlb backing and hence there
>>> is no runtime free of this pages needed ( Also we don't do
>>> runtime allocation of them).
>>>
>>> I guess you can still achieve what you want to do in this patch by
>>> keeping gigantic_page_supported()?
>>>
>>> NOTE: We should rename gigantic_page_supported to be more specific to
>>> support for runtime_alloc/free of gigantic pages
>>>
>>> -aneesh
>>>
>> Thanks for noticing Aneesh.
>>
>> I can't find a better solution than bringing back 
>> gigantic_page_supported check,
>> since it is must be done at runtime in your case.
>> I'm not sure of one thing though: you say that freeing boottime 
>> gigantic pages
>> is not needed, but is it forbidden ? Just to know where the check and 
>> what its
>> new name should be.

You did not answer this question: is freeing boottime gigantic pages 
"forbidden" or just
not needed ?


>> Is something like that (on top of this series) ok for you (and 
>> everyone else) before
>> I send a v7:
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h 
>> b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> index d04a0bc..d121559 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> @@ -35,4 +35,20 @@ static inline int hstate_get_psize(struct hstate 
>> *hstate)
>>   /* hugepd entry valid bit */
>>   #define HUGEPD_VAL_BITS                (0x8000000000000000UL)
>>
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> +#define __HAVE_ARCH_GIGANTIC_PAGE_SUPPORTED
>> +static inline bool gigantic_page_supported(void)
>> +{
>> +       /*
>> +        * We used gigantic page reservation with hypervisor assist 
>> in some case.
>> +        * We cannot use runtime allocation of gigantic pages in 
>> those platforms
>> +        * This is hash translation mode LPARs.
>> +        */
>> +       if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>> +               return false;
>> +
>> +       return true;
>> +}
>> +#endif
>> +
>>   #endif
>> diff --git a/include/asm-generic/hugetlb.h 
>> b/include/asm-generic/hugetlb.h
>> index 71d7b77..7d12e73 100644
>> --- a/include/asm-generic/hugetlb.h
>> +++ b/include/asm-generic/hugetlb.h
>> @@ -126,4 +126,18 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>>   }
>>   #endif
>>
>> +#ifndef __HAVE_ARCH_GIGANTIC_PAGE_SUPPORTED
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>
>
> The pattern i like is
>
> #ifndef gigantic_page_supported
> #define gigantic_page_supported gigantic_page_supported
>
> static inline bool gigantic_page_supported(void)
> {
>         return true;
> }
>
> #endif
>
> instead of _HAVE_ARCH_GIGANTIC_PAGE_SUPPORTED.
>

I see, that avoids a new define. However, it is not consistent with the 
rest of function definitions
in generic hugetlb.h. What do you think ? Should I follow the same 
format ? Or use yours ?

>
>> +static inline bool gigantic_page_supported(void)
>> +{
>> +        return true;
>> +}
>> +#else
>> +static inline bool gigantic_page_supported(void)
>> +{
>> +        return false;
>> +}
>> +#endif /* CONFIG_ARCH_HAS_GIGANTIC_PAGE */
>> +#endif /* __HAVE_ARCH_GIGANTIC_PAGE_SUPPORTED */
>> +
>>   #endif /* _ASM_GENERIC_HUGETLB_H */
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 9fc96ef..cfbbafe 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2425,6 +2425,11 @@ static ssize_t 
>> __nr_hugepages_store_common(bool obey_mempolicy,
>>          int err;
>>          NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | 
>> __GFP_NORETRY);
>>
>> +       if (hstate_is_gigantic(h) && !gigantic_page_supported()) {
>> +               err = -EINVAL;
>> +               goto out;
>> +       }
>
>
> you should restore other users of gigantic_page_supported() not just 
> this. That will just make your earlier patch as removing 
> gigantic_page_supported from every architecture other than ppc64 and 
> have a generic version as above.
>
>

I'll restore the check in update_and_free_page too depending on your 
answer to the above question,
since adding this check back would not allow to free boottime gigantic 
pages.

>> +
>>          if (nid = NUMA_NO_NODE) {
>>                  /*
>>                   * global hstate attribute
>> @@ -2446,6 +2451,7 @@ static ssize_t __nr_hugepages_store_common(bool 
>> obey_mempolicy,
>>
>>          err = set_max_huge_pages(h, count, nodes_allowed);
>>
>> +out:
>>          if (nodes_allowed != &node_states[N_MEMORY])
>>                  NODEMASK_FREE(nodes_allowed);
>>
>>
>>
>>
>
> -aneesh.
>
