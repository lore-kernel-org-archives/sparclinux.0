From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 28 Mar 2017 22:08:06 +0000
Subject: Re: [PATCH v6 2/4] mm: Add functions to support extra actions on swap in/out
Message-Id: <0f1c17ef-cd40-77b0-61ee-8c5043caf02a@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1488232591.git.khalid.aziz@oracle.com>
 <4c4da87ff45b98e236cdfef66055b876074dabfb.1488232597.git.khalid.aziz@oracle.com>
 <8665482b-f808-e995-cda1-99011be6ee34@linux.intel.com>
In-Reply-To: <8665482b-f808-e995-cda1-99011be6ee34@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@linux.intel.com>, akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de
Cc: kirill.shutemov@linux.intel.com, mhocko@suse.com, jmarchan@redhat.com, vbabka@suse.cz, dan.j.williams@intel.com, lstoakes@gmail.com, hannes@cmpxchg.org, mgorman@suse.de, hughd@google.com, vdavydov.dev@gmail.com, minchan@kernel.org, namit@vmware.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 03/24/2017 12:45 PM, Dave Hansen wrote:
> On 02/28/2017 10:35 AM, Khalid Aziz wrote:
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 6bf2b47..b086c76 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2658,6 +2658,7 @@ int do_swap_page(struct vm_fault *vmf)
>>  	if (pte_swp_soft_dirty(vmf->orig_pte))
>>  		pte = pte_mksoft_dirty(pte);
>>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>> +	arch_do_swap_page(vma->vm_mm, vmf->address, pte, vmf->orig_pte);
>>  	vmf->orig_pte = pte;
>>  	if (page = swapcache) {
>>  		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 91619fd..192c41a 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1538,6 +1538,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  		swp_pte = swp_entry_to_pte(entry);
>>  		if (pte_soft_dirty(pteval))
>>  			swp_pte = pte_swp_mksoft_dirty(swp_pte);
>> +		arch_unmap_one(mm, address, swp_pte, pteval);
>>  		set_pte_at(mm, address, pte, swp_pte);
>>  	} else if (PageAnon(page)) {
>>  		swp_entry_t entry = { .val = page_private(page) };
>> @@ -1571,6 +1572,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  		swp_pte = swp_entry_to_pte(entry);
>>  		if (pte_soft_dirty(pteval))
>>  			swp_pte = pte_swp_mksoft_dirty(swp_pte);
>> +		arch_unmap_one(mm, address, swp_pte, pteval);
>>  		set_pte_at(mm, address, pte, swp_pte);
>>  	} else
>>  		dec_mm_counter(mm, mm_counter_file(page));
>
> From a core VM perspective, I'm fine with these hooks.  It's minimally
> invasive.  It is missing some explanation in the *code* of why sparc is
> doing this and when/why other architectures might want to use these
> hooks.  I think that would be awfully nice.

Hi Dave,

Thanks for the review.

I will add explanation for these hooks.

>
> I still think the _current_ SPARC implementation of these hooks is
> pretty broken because it doesn't allow more than one ADI tag within a
> given page.  But, fixing that is confined to sparc code and shouldn't
> affect the core VM or these hooks.

Yes, this initial implementation is limited and can be expanded to 
support more than one tag per page in sparc code.

>
> I suspect these hooks are still quite incomplete.  For instance, I do
> not think KSM goes through these paths.  Couldn't a process *lose* its
> ADI tags when KSM merges an underlying physical page?

Good point. I will look into KSM integration. KSM could possibly merge 
two physical pages that have identical contents but different ADI tags 
although that comes into play only if userspace sets the VM_MERGEABLE 
flag on pages it has enabled ADI on. It should be addressed nevertheless.

>
> I think you need to resolve your outstanding issues (from your 0/4
> patch) before anyone can really ack these.  I suspect solving your
> issues will change the number and placement of these hooks.
>
> There is no mention in these patches of the effectively reduced virtual
> address space.  Why?

ADI uses bits 63-60 of VA. VA is already limited to only 56 bits by the 
MMU, so virtual address space is not reduced by this patch. I will add 
this explanation to the patch.

Thanks,
Khalid


