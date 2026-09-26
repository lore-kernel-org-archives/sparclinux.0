Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4B126C02;
	Sat, 26 Sep 2026 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790426236; cv=none; b=jdYo1pfjzULhUuVcjqR5nnH40EUg6UuCjPeztMO5NXRO3CMVjlXPFgAMulcUW2z0jvLJSXyHiOaplCYHw81FL9d+o5p8gjWizPFxgJ4Y9lnPAM6rRms080FMvmLSxdbSIgfa6Ea5lx94RFfji/Pajk04sPFnrRLHDpsx6yMUAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790426236; c=relaxed/simple;
	bh=fqT9PsOPp+2UAi28FvcReu9QnVXrk/rtw2WCU8QbKrg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ev8AwitXe+4DAczM651FlZeBL3001bmnzRbz47O1AdzS0OB6P3/V11pd8abzSJ9Os53NI1kUroZqMW3fsBOnD/zGJqdsJ9+AIETD5Xot9/kD/pVQPJt0vD0Y2RARwevoLk7zYtv47dAJCrrhZH/bDNp/AFppKOxvXQqYshl9m5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lU+wYF8y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lU+wYF8y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2623D1570;
	Sat, 26 Sep 2026 05:37:08 -0700 (PDT)
Received: from [10.164.11.10] (unknown [10.164.11.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC5E53F632;
	Sat, 26 Sep 2026 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790426231; bh=fqT9PsOPp+2UAi28FvcReu9QnVXrk/rtw2WCU8QbKrg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lU+wYF8yFaTlGPXksx5u+jeRufLOFvI4NZk4d8f9t+ppVkYT/y/nC0a2E9bNnmNeY
	 EE+7xQcofWP/XBFcEpj22pkNwua73qXM9jRJKp+vUXSisFPSTUb2jnWpXutJHggSXq
	 hQjxxzj6WpGYg4R+vkhUz7wyEE8akuAYyOGrjc+4=
Message-ID: <7a2445ed-0e56-4a87-b4ba-6cf1dabd07d2@arm.com>
Date: Sat, 26 Sep 2026 18:07:01 +0530
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] mm/rmap: batch unmap anonymous swap-backed large
 folios
From: Dev Jain <dev.jain@arm.com>
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 hughd@google.com, chrisl@kernel.org, kasong@tencent.com,
 davem@davemloft.net, andreas@gaisler.com, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, baolin.wang@linux.alibaba.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev,
 youngjun.park@lge.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, pfalcato@suse.de,
 jgg@ziepe.ca, thuth@redhat.com, sparclinux@vger.kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com
References: <20260924131106.1730494-1-dev.jain@arm.com>
 <20260924131106.1730494-9-dev.jain@arm.com>
 <CAGsJ_4xhGwxQCH4sG4=dyomRkN_PGHeW7e0uz1MsQHFW-Gs6VA@mail.gmail.com>
 <f61fa70f-882a-4787-918e-4b6959062c9c@arm.com>
Content-Language: en-US
In-Reply-To: <f61fa70f-882a-4787-918e-4b6959062c9c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/09/26 4:55 pm, Dev Jain wrote:
> 
> 
> On 25/09/26 11:45 am, Barry Song wrote:
>> On Thu, Sep 24, 2026 at 9:12 PM Dev Jain <dev.jain@arm.com> wrote:
>>>
>>> Enable batch clearing of PTEs and batch swap setting of PTEs for anon
>>> swap-backed folio unmapping.
>>>
>>> Processing all PTEs of a large folio in one go helps us batch across
>>> atomics (add_mm_counter() etc), barriers in __folio_try_share_anon_rmap(),
>>> and repeated calls to page_vma_mapped_walk(). In general, batching helps
>>> execute similar code together, making the path more memory and CPU
>>> friendly.
>>>
>>> On arm64-contpte, batching also helps avoid redundant ptep_get() calls
>>> and TLB flushes while breaking the contpte mapping.
>>>
>>> The handling of anon-exclusivity is very similar to commit cac1db8c3aad
>>> ("mm: optimize mprotect() by PTE batching"). Since
>>> folio_unmap_pte_batch() does not look at the bits of the underlying page,
>>> process sub-batches of PTEs pointing to pages with the same exclusivity
>>> state, and batch set only those PTEs to swap PTEs in one go.
>>>
>>> Disable batching for sparc (because of arch_unmap_one), we will batch this
>>> later.
>>>
>>> Rmap accounting and reference accounting must happen when anon folio unmap
>>> succeeds. If a large folio is only partially batched or a later sub-batch
>>> fails, account only the pages that were actually unmapped. Put that
>>> accounting in __ttu_anon_swapbacked_folio() itself instead of using goto
>>> jumps at the try_to_unmap_one() callsite.
>>>
>>> Similarly, do the finish_folio_unmap_batch() in ttu_anon_folio() itself for the
>>> non-swapbacked lazyfree case.
>>>
>>> If the batch length is less than the number of pages in the folio, skip
>>> over this batch. page_vma_mapped_walk() handles this: check_pte() returns
>>> true only if any of [pvmw->pfn, pvmw->pfn + nr_pages) is mapped by the
>>> PTE. Swap PTEs have no underlying PFN, so check_pte() returns false until
>>> the walk reaches the next present PTE to unmap.
>>>
>>> Remove the finish_unmap label since no goto callers are left now.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>  mm/rmap.c | 109 +++++++++++++++++++++++++++++++++++++++---------------
>>>  1 file changed, 80 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index fa9fc8374fc26..cdda9efd80bc3 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1966,12 +1966,13 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
>>>         end_addr = pmd_addr_end(addr, vma->vm_end);
>>>         max_nr = (end_addr - addr) >> PAGE_SHIFT;
>>>
>>> -       /* We only support lazyfree or file folios batching for now ... */
>>> -       if (folio_test_anon(folio) && folio_test_swapbacked(folio))
>>> +       if (pte_unused(pte))
>>>                 return 1;
>>>
>>> -       if (pte_unused(pte))
>>> +#ifdef __HAVE_ARCH_UNMAP_ONE
>>> +       if (folio_test_anon(folio) && folio_test_swapbacked(folio))
>>>                 return 1;
>>> +#endif
>>>
>>>         /*
>>>          * If unmap fails, we need to restore the ptes. To avoid accidentally
>>> @@ -2141,16 +2142,25 @@ static pte_t swp_pte_prepare(swp_entry_t entry, pte_t old_pte,
>>>         return swp_pte;
>>>  }
>>>
>>> -static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
>>> +static void finish_folio_unmap_batch(struct vm_area_struct *vma,
>>> +               struct folio *folio, struct page *page, unsigned long nr_pages)
>>> +{
>>> +       folio_remove_rmap_ptes(folio, page, nr_pages, vma);
>>> +       if (vma->vm_flags & VM_LOCKED)
>>> +               mlock_drain_local();
>>> +       folio_put_refs(folio, nr_pages);
>>> +}
>>> +
>>> +static bool __ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
>>>                 struct folio *folio, struct page *page, unsigned long address,
>>> -               pte_t *ptep, pte_t pteval)
>>> +               pte_t *ptep, pte_t pteval, unsigned long nr_pages,
>>> +               bool anon_exclusive)
>>>  {
>>> -       const bool anon_exclusive = folio_test_anon(folio) &&
>>> -                                   PageAnonExclusive(page);
>>>         swp_entry_t entry = folio_page_swap_entry(folio, page);
>>>         struct mm_struct *mm = vma->vm_mm;
>>> +       pte_t swp_pte;
>>>
>>> -       if (folio_dup_swap_pages(folio, page, 1) < 0)
>>> +       if (folio_dup_swap_pages(folio, page, nr_pages) < 0)
>>>                 return false;
>>>
>>>         /*
>>> @@ -2159,21 +2169,57 @@ static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
>>>          * so we'll not check/care.
>>>          */
>>>         if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>>> -               folio_put_swap_pages(folio, page, 1);
>>> +               VM_WARN_ON(nr_pages != 1);
>>> +               folio_put_swap_pages(folio, page, nr_pages);
>>>                 return false;
>>>         }
>>>
>>>         /* See folio_try_share_anon_rmap(): clear PTE first. */
>>> -       if (anon_exclusive && folio_try_share_anon_rmap_pte(folio, page)) {
>>> -               folio_put_swap_pages(folio, page, 1);
>>> +       if (anon_exclusive &&
>>> +           folio_try_share_anon_rmap_ptes(folio, page, nr_pages)) {
>>> +               folio_put_swap_pages(folio, page, nr_pages);
>>>                 return false;
>>>         }
>>>
>>>         mm_prepare_for_swap_entries(mm);
>>> -       dec_mm_counter(mm, MM_ANONPAGES);
>>> -       inc_mm_counter(mm, MM_SWAPENTS);
>>> -       set_pte_at(mm, address, ptep,
>>> -                  swp_pte_prepare(entry, pteval, anon_exclusive));
>>> +       add_mm_counter(mm, MM_ANONPAGES, -nr_pages);
>>> +       add_mm_counter(mm, MM_SWAPENTS, nr_pages);
>>> +       swp_pte = swp_pte_prepare(entry, pteval, anon_exclusive);
>>> +       set_softleaf_ptes(mm, address, ptep, swp_pte, nr_pages);
>>> +       finish_folio_unmap_batch(vma, folio, page, nr_pages);
>>> +       return true;
>>> +}
>>> +
>>> +static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
>>> +               struct folio *folio, struct page *first_page,
>>> +               unsigned long address, pte_t *ptep, pte_t pteval,
>>> +               unsigned long nr_pages)
>>> +{
>>> +       unsigned long batch_idx = 0;
>>> +
>>> +       while (nr_pages) {
>>> +               bool anon_exclusive = PageAnonExclusive(first_page + batch_idx);
>>> +               unsigned long len = page_anon_exclusive_batch(batch_idx,
>>> +                               nr_pages, first_page, anon_exclusive);
>>> +
>>> +               if (!__ttu_anon_swapbacked_folio(vma, folio,
>>> +                               first_page + batch_idx, address, ptep, pteval,
>>> +                               len, anon_exclusive)) {
>>> +                       /* Restore the remaining PTEs that were cleared. */
>>> +                       set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
>>> +                       return false;
>>> +               }
>>> +
>>> +               nr_pages -= len;
>>> +               if (!nr_pages)
>>> +                       break;
>>> +
>>> +               pteval = pte_advance_pfn(pteval, len);
>>> +               address += len * PAGE_SIZE;
>>> +               batch_idx += len;
>>> +               ptep += len;
>>> +       }
>>> +
>>>         return true;
>>>  }
>>>
>>> @@ -2186,15 +2232,22 @@ static bool ttu_anon_folio(struct vm_area_struct *vma, struct folio *folio,
>>>          * See handle_pte_fault() ...
>>>          */
>>>         if (WARN_ON_ONCE(folio_test_swapbacked(folio) !=
>>> -                        folio_test_swapcache(folio)))
>>> +                        folio_test_swapcache(folio))) {
>>> +               set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
>>>                 return false;
>>> +       }
>>>
>>> -       if (!folio_test_swapbacked(folio))
>>> -               return ttu_anon_lazyfree_folio(vma, folio, nr_pages);
>>> +       if (!folio_test_swapbacked(folio)) {
>>> +               if (!ttu_anon_lazyfree_folio(vma, folio, nr_pages)) {
>>> +                       set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
>>> +                       return false;
>>> +               }
>>> +               finish_folio_unmap_batch(vma, folio, page, nr_pages);
>>> +               return true;
>>> +       }
>>
>> Hi Dev,
>>
>> if we look at the whole `ttu_anon_folio()` code:
>>
>> static bool ttu_anon_folio(struct vm_area_struct *vma, struct folio *folio,
>>                 struct page *page, unsigned long address, pte_t *ptep,
>>                 pte_t pteval, unsigned long nr_pages)
>> {
>>         /*
>>          * Store the swap location in the pte.
>>          * See handle_pte_fault() ...
>>          */
>>         if (WARN_ON_ONCE(folio_test_swapbacked(folio) !=
>>                          folio_test_swapcache(folio))) {
>>                 set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
>>                 return false;
>>         }
>>
>>         if (!folio_test_swapbacked(folio)) {
>>                 if (!ttu_anon_lazyfree_folio(vma, folio, nr_pages)) {
>>                         set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
>>                         return false;
>>                 }
>>                 finish_folio_unmap_batch(vma, folio, page, nr_pages);
>>                 return true;
>>         }
>>
>>         return ttu_anon_swapbacked_folio(vma, folio, page, address, ptep,
>>                                          pteval, nr_pages);
>> }
>>
>> The comment "Store the swap location in the pte" is really out of
>> place. Since we are already here, can we move it to the right place?
> 
> I am not sure what is the "right place" you are referring to : ) More
> than that, this comments feels very out of date - it is well-know that
> the "swap location" is stored in the pte.
> 
> In fact, this comment starts on top of the wrong block, which is a
> debug assertion for "when we are here, swapbacked if and only if swapcache".
> So I'd rather just remove it.
> 
>>
>>>
>>> -       /* nr_pages > 1 not supported yet */
>>>         return ttu_anon_swapbacked_folio(vma, folio, page, address, ptep,
>>> -                                        pteval);
>>> +                                        pteval, nr_pages);
>>>  }
>>>
>>>  /*
>>> @@ -2374,13 +2427,14 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>                          */
>>>                         dec_mm_counter(mm, mm_counter(folio));
>>>                 } else if (folio_test_anon(folio)) {
>>> +                       /* finish_folio_unmap_batch handled internally */
>>
>>
>> let me paste the final code here:
>>
>>                 } else if (folio_test_anon(folio)) {
>>                         /* finish_folio_unmap_batch handled internally */
>>                         if (!ttu_anon_folio(vma, folio, page, address,
>>                                             pvmw.pte, pteval, nr_pages))
>>                                 goto walk_abort;
>>
>>                         if (nr_pages == folio_nr_pages(folio))
>>                                 goto walk_done;
>>                         continue;
>>                 } else {
>>                         ...
>>                 }
>>
>>                 finish_folio_unmap_batch(vma, folio, page, nr_pages);
>>
>>                 /*
>>                  * If we are sure that we batched the entire folio and cleared
>>                  * all PTEs, we can just optimize and stop right here.
>>                  */
>>                 if (nr_pages == folio_nr_pages(folio))
>>                         goto walk_done;
>>                 continue;
>>
>> I am really struggling to read the code here. For anon folios, we
>> handle `finish_folio_unmap_batch()` internally, while for other folios
>> we still do it outside. This feels a bit inconsistent.
>>
>> Also, we are duplicating the code below twice:
>>
>>                 if (nr_pages == folio_nr_pages(folio))
>>                         goto walk_done;
>>
>> Can't we just do `finish_folio_unmap_batch()` like the other cases?
> 
> The core problem is that we may succeed on a partial range.
> 
> ttu_anon_swapbacked_folio can succeed on x < nr_pages. So for x, we
> should call finish_folio_unmap_batch. Either we do it my way, or,
> ttu_anon_folio returns the number of pages successfully unmapped = x,
> and then even in case of "failure" (we should now jump to
> walk_abort since we failed to unmap 'nr_pages - x' pages) we call
> finish_folio_unmap_batch for x pages.
> 
> IMHO that is uglier. I wanted to avoid this label jumping. I would
> be interested in hearing a better alternate : )

I did try this and it looks nicer actually. Will shift to this in v4,
thanks!


>>
>> That would also avoid the duplication.
>>
>> Best Regards
>> Barry
> 

