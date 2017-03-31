From: David Miller <davem@davemloft.net>
Date: Fri, 31 Mar 2017 03:34:55 +0000
Subject: Re: tlb_batch_add_one()
Message-Id: <20170330.203455.460688401687414609.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170328.175226.210187301635964014.davem@davemloft.net>
In-Reply-To: <20170328.175226.210187301635964014.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 30 Mar 2017 20:12:03 -0700

> On 3/30/17 7:57 PM, David Miller wrote:
>> From: Nitin Gupta <nitin.m.gupta@oracle.com>
>> Date: Thu, 30 Mar 2017 17:42:51 -0700
>> 
>>> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
>>> index 0a04811..bedf08b 100644
>>> --- a/arch/sparc/mm/tsb.c
>>> +++ b/arch/sparc/mm/tsb.c
>>> @@ -122,7 +122,7 @@ void flush_tsb_user(struct tlb_batch *tb)
>>>
>>>  	spin_lock_irqsave(&mm->context.lock, flags);
>>>
>>> -	if (tb->hugepage_shift < HPAGE_SHIFT) {
>>> +	if (tb->hugepage_shift < REAL_HPAGE_SHIFT) {
>>>  		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
>>>  		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
>>>  		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
>>> @@ -155,7 +155,7 @@ void flush_tsb_user_page(struct mm_struct *mm,
>>> unsigned long vaddr,
>>>
>>>  	spin_lock_irqsave(&mm->context.lock, flags);
>>>
>>> -	if (hugepage_shift < HPAGE_SHIFT) {
>>> +	if (hugepage_shift < REAL_HPAGE_SHIFT) {
>>>  		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
>>>  		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
>>>  		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
>>> -- 
>> 
>> I think if we do it like this, it will only flush one half of the huge
>> page.
>>
> 
> Flushing only half the 8M page is the intended behavior: after the
> initial allocation of 8M hugepage, the page is handled exactly as if two
> independent 4M hugepages were allocated (that happen to be physically
> contiguous). So, for each 4M chunk, flushing from TLB and TSB is done
> independently. For instance, in set_huge_pte_at() we added special case
> for (size = HPAGE_SIZE) to flush the "second half" of 8M page.
> Similarly in huge_ptep_get_and_clear() and in set_pmd_at().

Indeed, the set_pmd_at() code path does the same thing.

Ok so your patch is more correct.

Please submit it formally with a proper commit log message and
signoff, thanks!
