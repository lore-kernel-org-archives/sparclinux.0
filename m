From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 10:32:07 +0000
Subject: Re: [PATCH v3 2/2] mm: remove odd HAVE_PTE_SPECIAL
Message-Id: <32655c37-91cb-17aa-58e7-74254e2673a0@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <de6ee514-8b7e-24d0-a7ee-a8887e8b0ae9@c-s.fr>
 <93ed4fe4-dd1e-51be-948b-d53b16de21c5@linux.vnet.ibm.com>
 <278a5212-b962-9a3a-cc86-76cac744afab@c-s.fr>
In-Reply-To: <278a5212-b962-9a3a-cc86-76cac744afab@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On 11/04/2018 11:09, Christophe LEROY wrote:
> 
> 
> Le 11/04/2018 à 11:03, Laurent Dufour a écrit :
>>
>>
>> On 11/04/2018 10:58, Christophe LEROY wrote:
>>>
>>>
>>> Le 11/04/2018 à 10:03, Laurent Dufour a écrit :
>>>> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
>>>> CONFIG_ARCH_HAS_PTE_SPECIAL.
>>>>
>>>> There is no functional change introduced by this patch
>>>>
>>>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>>> ---
>>>>    mm/memory.c | 19 ++++++++-----------
>>>>    1 file changed, 8 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 96910c625daa..7f7dc7b2a341 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -817,17 +817,12 @@ static void print_bad_pte(struct vm_area_struct *vma,
>>>> unsigned long addr,
>>>>     * PFNMAP mappings in order to support COWable mappings.
>>>>     *
>>>>     */
>>>> -#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>>> -# define HAVE_PTE_SPECIAL 1
>>>> -#else
>>>> -# define HAVE_PTE_SPECIAL 0
>>>> -#endif
>>>>    struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long
>>>> addr,
>>>>                     pte_t pte, bool with_public_device)
>>>>    {
>>>>        unsigned long pfn = pte_pfn(pte);
>>>>    -    if (HAVE_PTE_SPECIAL) {
>>>> +    if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
>>>>            if (likely(!pte_special(pte)))
>>>>                goto check_pfn;
>>>>            if (vma->vm_ops && vma->vm_ops->find_special_page)
>>>> @@ -862,7 +857,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma,
>>>> unsigned long addr,
>>>>            return NULL;
>>>>        }
>>>>    -    /* !HAVE_PTE_SPECIAL case follows: */
>>>> +    /* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
>>>>          if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
>>>>            if (vma->vm_flags & VM_MIXEDMAP) {
>>>> @@ -881,7 +876,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma,
>>>> unsigned long addr,
>>>>          if (is_zero_pfn(pfn))
>>>>            return NULL;
>>>> -check_pfn:
>>>> +
>>>> +check_pfn: __maybe_unused
>>>
>>> See below
>>>
>>>>        if (unlikely(pfn > highest_memmap_pfn)) {
>>>>            print_bad_pte(vma, addr, pte, NULL);
>>>>            return NULL;
>>>> @@ -891,7 +887,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma,
>>>> unsigned long addr,
>>>>         * NOTE! We still have PageReserved() pages in the page tables.
>>>>         * eg. VDSO mappings can cause them to exist.
>>>>         */
>>>> -out:
>>>> +out: __maybe_unused
>>>
>>> Why do you need that change ?
>>>
>>> There is no reason for the compiler to complain. It would complain if the goto
>>> was within a #ifdef, but all the purpose of using IS_ENABLED() is to allow the
>>> compiler to properly handle all possible cases. That's all the force of
>>> IS_ENABLED() compared to ifdefs, and that the reason why they are plebicited,
>>> ref Linux Codying style for a detailed explanation.
>>
>> Fair enough.
>>
>> Should I submit a v4 just to remove these so ugly __maybe_unused ?
>>
> 
> Most likely, unless the mm maintainer agrees to remove them by himself when
> applying your patch ?

That was my point.

Andrew, should I send a v4 or could you wipe the 2 __maybe_unsued when applying
the patch ?

Thanks,
Laurent.

