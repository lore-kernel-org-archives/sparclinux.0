From: Alex Ghiti <alex@ghiti.fr>
Date: Mon, 18 Mar 2019 07:00:47 +0000
Subject: Re: [PATCH v7 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
Message-Id: <525d6c00-012f-c6dd-abf0-fa5e1ffc12be@ghiti.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20190317162847.14107-1-alex@ghiti.fr>
 <20190317162847.14107-5-alex@ghiti.fr>
 <f434892d-80b2-f09d-31d6-754a1be0b97a@c-s.fr>
In-Reply-To: <f434892d-80b2-f09d-31d6-754a1be0b97a@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: christophe leroy <christophe.leroy@c-s.fr>, aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On 3/17/19 2:31 PM, christophe leroy wrote:
>
>
> Le 17/03/2019 à 17:28, Alexandre Ghiti a écrit :
>> On systems without CONTIG_ALLOC activated but that support gigantic 
>> pages,
>> boottime reserved gigantic pages can not be freed at all. This patch
>> simply enables the possibility to hand back those pages to memory
>> allocator.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
>> ---
>>   arch/arm64/Kconfig                           |  2 +-
>>   arch/arm64/include/asm/hugetlb.h             |  4 --
>>   arch/powerpc/include/asm/book3s/64/hugetlb.h |  7 ---
>>   arch/powerpc/platforms/Kconfig.cputype       |  2 +-
>>   arch/s390/Kconfig                            |  2 +-
>>   arch/s390/include/asm/hugetlb.h              |  3 --
>>   arch/sh/Kconfig                              |  2 +-
>>   arch/sparc/Kconfig                           |  2 +-
>>   arch/x86/Kconfig                             |  2 +-
>>   arch/x86/include/asm/hugetlb.h               |  4 --
>>   include/asm-generic/hugetlb.h                | 14 +++++
>>   include/linux/gfp.h                          |  2 +-
>>   mm/hugetlb.c                                 | 54 ++++++++++++++------
>>   mm/page_alloc.c                              |  4 +-
>>   14 files changed, 61 insertions(+), 43 deletions(-)
>>
>
> [...]
>
>> diff --git a/include/asm-generic/hugetlb.h 
>> b/include/asm-generic/hugetlb.h
>> index 71d7b77eea50..aaf14974ee5f 100644
>> --- a/include/asm-generic/hugetlb.h
>> +++ b/include/asm-generic/hugetlb.h
>> @@ -126,4 +126,18 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>>   }
>>   #endif
>>   +#ifndef __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> +static inline bool gigantic_page_runtime_supported(void)
>> +{
>> +    return true;
>> +}
>> +#else
>> +static inline bool gigantic_page_runtime_supported(void)
>> +{
>> +    return false;
>> +}
>> +#endif /* CONFIG_ARCH_HAS_GIGANTIC_PAGE */
>
> What about the following instead:
>
> static inline bool gigantic_page_runtime_supported(void)
> {
>     return IS_ENABLED(CONFIG_ARCH_HAS_GIGANTIC_PAGE);
> }
>

Totally, it already was like that in v2 or v3...


>
>> +#endif /* __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED */
>> +
>>   #endif /* _ASM_GENERIC_HUGETLB_H */
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 1f1ad9aeebb9..58ea44bf75de 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -589,8 +589,8 @@ static inline bool pm_suspended_storage(void)
>>   /* The below functions must be run on a range from a single zone. */
>>   extern int alloc_contig_range(unsigned long start, unsigned long end,
>>                     unsigned migratetype, gfp_t gfp_mask);
>> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
>>   #endif
>> +extern void free_contig_range(unsigned long pfn, unsigned int 
>> nr_pages);
>
> 'extern' is unneeded and should be avoided (iaw checkpatch)
>

Ok, I did fix a checkpatch warning here, but did not notice the 'extern' 
one.


Thanks for your time,


Alex


> Christophe
>
>>     #ifdef CONFIG_CMA
>>   /* CMA stuff */
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index afef61656c1e..4e55aa38704f 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1058,6 +1058,7 @@ static void free_gigantic_page(struct page 
>> *page, unsigned int order)
>>       free_contig_range(page_to_pfn(page), 1 << order);
>>   }
>>   +#ifdef CONFIG_CONTIG_ALLOC
>>   static int __alloc_gigantic_page(unsigned long start_pfn,
>>                   unsigned long nr_pages, gfp_t gfp_mask)
>>   {
>> @@ -1142,11 +1143,20 @@ static struct page 
>> *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>>     static void prep_new_huge_page(struct hstate *h, struct page 
>> *page, int nid);
>>   static void prep_compound_gigantic_page(struct page *page, unsigned 
>> int order);
>> +#else /* !CONFIG_CONTIG_ALLOC */
>> +static struct page *alloc_gigantic_page(struct hstate *h, gfp_t 
>> gfp_mask,
>> +                    int nid, nodemask_t *nodemask)
>> +{
>> +    return NULL;
>> +}
>> +#endif /* CONFIG_CONTIG_ALLOC */
>>     #else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
>> -static inline bool gigantic_page_supported(void) { return false; }
>>   static struct page *alloc_gigantic_page(struct hstate *h, gfp_t 
>> gfp_mask,
>> -        int nid, nodemask_t *nodemask) { return NULL; }
>> +                    int nid, nodemask_t *nodemask)
>> +{
>> +    return NULL;
>> +}
>>   static inline void free_gigantic_page(struct page *page, unsigned 
>> int order) { }
>>   static inline void destroy_compound_gigantic_page(struct page *page,
>>                           unsigned int order) { }
>> @@ -1156,7 +1166,7 @@ static void update_and_free_page(struct hstate 
>> *h, struct page *page)
>>   {
>>       int i;
>>   -    if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> +    if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>>           return;
>>         h->nr_huge_pages--;
>> @@ -2276,13 +2286,27 @@ static int adjust_pool_surplus(struct hstate 
>> *h, nodemask_t *nodes_allowed,
>>   }
>>     #define persistent_huge_pages(h) (h->nr_huge_pages - 
>> h->surplus_huge_pages)
>> -static unsigned long set_max_huge_pages(struct hstate *h, unsigned 
>> long count,
>> -                        nodemask_t *nodes_allowed)
>> +static int set_max_huge_pages(struct hstate *h, unsigned long count,
>> +                  nodemask_t *nodes_allowed)
>>   {
>>       unsigned long min_count, ret;
>>   -    if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> -        return h->max_huge_pages;
>> +    spin_lock(&hugetlb_lock);
>> +
>> +    /*
>> +     * Gigantic pages runtime allocation depend on the capability 
>> for large
>> +     * page range allocation.
>> +     * If the system does not provide this feature, return an error 
>> when
>> +     * the user tries to allocate gigantic pages but let the user 
>> free the
>> +     * boottime allocated gigantic pages.
>> +     */
>> +    if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>> +        if (count > persistent_huge_pages(h)) {
>> +            spin_unlock(&hugetlb_lock);
>> +            return -EINVAL;
>> +        }
>> +        /* Fall through to decrease pool */
>> +    }
>>         /*
>>        * Increase the pool size
>> @@ -2295,7 +2319,6 @@ static unsigned long set_max_huge_pages(struct 
>> hstate *h, unsigned long count,
>>        * pool might be one hugepage larger than it needs to be, but
>>        * within all the constraints specified by the sysctls.
>>        */
>> -    spin_lock(&hugetlb_lock);
>>       while (h->surplus_huge_pages && count > 
>> persistent_huge_pages(h)) {
>>           if (!adjust_pool_surplus(h, nodes_allowed, -1))
>>               break;
>> @@ -2350,9 +2373,10 @@ static unsigned long set_max_huge_pages(struct 
>> hstate *h, unsigned long count,
>>               break;
>>       }
>>   out:
>> -    ret = persistent_huge_pages(h);
>> +    h->max_huge_pages = persistent_huge_pages(h);
>>       spin_unlock(&hugetlb_lock);
>> -    return ret;
>> +
>> +    return 0;
>>   }
>>     #define HSTATE_ATTR_RO(_name) \
>> @@ -2404,7 +2428,7 @@ static ssize_t __nr_hugepages_store_common(bool 
>> obey_mempolicy,
>>       int err;
>>       NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | 
>> __GFP_NORETRY);
>>   -    if (hstate_is_gigantic(h) && !gigantic_page_supported()) {
>> +    if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
>>           err = -EINVAL;
>>           goto out;
>>       }
>> @@ -2428,15 +2452,13 @@ static ssize_t 
>> __nr_hugepages_store_common(bool obey_mempolicy,
>>       } else
>>           nodes_allowed = &node_states[N_MEMORY];
>>   -    h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
>> +    err = set_max_huge_pages(h, count, nodes_allowed);
>>   +out:
>>       if (nodes_allowed != &node_states[N_MEMORY])
>>           NODEMASK_FREE(nodes_allowed);
>>   -    return len;
>> -out:
>> -    NODEMASK_FREE(nodes_allowed);
>> -    return err;
>> +    return err ? err : len;
>>   }
>>     static ssize_t nr_hugepages_store_common(bool obey_mempolicy,
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index ac9c45ffb344..a4547d90fa7a 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8234,8 +8234,9 @@ int alloc_contig_range(unsigned long start, 
>> unsigned long end,
>>                   pfn_max_align_up(end), migratetype);
>>       return ret;
>>   }
>> +#endif /* CONFIG_CONTIG_ALLOC */
>>   -void free_contig_range(unsigned long pfn, unsigned nr_pages)
>> +void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>>   {
>>       unsigned int count = 0;
>>   @@ -8247,7 +8248,6 @@ void free_contig_range(unsigned long pfn, 
>> unsigned nr_pages)
>>       }
>>       WARN(count != 0, "%d pages are still in use!\n", count);
>>   }
>> -#endif
>>     #ifdef CONFIG_MEMORY_HOTPLUG
>>   /*
>>
>
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le 
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
