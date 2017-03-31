From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 31 Mar 2017 00:42:51 +0000
Subject: Re: tlb_batch_add_one()
Message-Id: <d71c45e6-a54a-517f-b347-89ee4e7b196e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170328.175226.210187301635964014.davem@davemloft.net>
In-Reply-To: <20170328.175226.210187301635964014.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/30/17 4:59 PM, Nitin Gupta wrote:
> On 3/30/17 2:54 PM, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Thu, 30 Mar 2017 14:25:53 -0700 (PDT)
>>
>>> From: Nitin Gupta <nitin.m.gupta@oracle.com>
>>> Date: Thu, 30 Mar 2017 13:47:11 -0700
>>>
>>>> I will be sending a fix for these call-sites today.
>>>
>>> I already have a fix I'm testing now which I'll check in after my
>>> regression test passes.
>>
>> So even with the shifts fixed, as per the patch below, I'm still getting
>> corruptions during gcc bootstraps.
>>
>> If I cannot figure out what the problem is by the end of the day I'm
>> reverting the change.  I've already spend a week trying to figure out
>> what introduced these regressions...
>>
>> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
>> index afda3bb..ee8066c 100644
>> --- a/arch/sparc/mm/tlb.c
>> +++ b/arch/sparc/mm/tlb.c
>> @@ -154,7 +154,7 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
>>  		if (pte_val(*pte) & _PAGE_VALID) {
>>  			bool exec = pte_exec(*pte);
>>  
>> -			tlb_batch_add_one(mm, vaddr, exec, false);
>> +			tlb_batch_add_one(mm, vaddr, exec, PAGE_SHIFT);
>>  		}
>>  		pte++;
>>  		vaddr += PAGE_SIZE;
>> @@ -209,9 +209,9 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>  			pte_t orig_pte = __pte(pmd_val(orig));
>>  			bool exec = pte_exec(orig_pte);
>>  
>> -			tlb_batch_add_one(mm, addr, exec, true);
>> +			tlb_batch_add_one(mm, addr, exec, REAL_HPAGE_SHIFT);
>>  			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec,
>> -					true);
>> +					  REAL_HPAGE_SHIFT);
> 
> 
> Shifts are still wrong: tlb_batch_add_one -> flush_tsb_user_page expects
> HPAGE_SHIFT to be passed for 8M pages so that 'HUGE' tsb is flushed
> instead of the BASE one. So, we need to pass HPAGE_SHIFT here.
> 
> Also, I see that sun4v_tte_to_shift() should return HPAGE_SHIFT for 4MB
> case instead of REAL_HPAGE_SHIFT (same for sun4u version).
> 
> And finally, huge_tte_to_shift() can have the size check removed after
> fixing huge_tte_to_shift() as above.
> 
> Currently my test machine is having some disk issues, so I will be back
> with results once the machine is back up.
> 

Or more simply, the check in flush_tsb_user() and flush_tsb_user_page()
can be fixed. Below is the full patch (including your changes):

The patch is untested and my test machine is still not ready, so would
be testing it tonight/tomorrow.



 arch/sparc/mm/tlb.c | 6 +++---
 arch/sparc/mm/tsb.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index afda3bb..ee8066c 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -154,7 +154,7 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm,
unsigned long vaddr,
 		if (pte_val(*pte) & _PAGE_VALID) {
 			bool exec = pte_exec(*pte);

-			tlb_batch_add_one(mm, vaddr, exec, false);
+			tlb_batch_add_one(mm, vaddr, exec, PAGE_SHIFT);
 		}
 		pte++;
 		vaddr += PAGE_SIZE;
@@ -209,9 +209,9 @@ void set_pmd_at(struct mm_struct *mm, unsigned long
addr,
 			pte_t orig_pte = __pte(pmd_val(orig));
 			bool exec = pte_exec(orig_pte);

-			tlb_batch_add_one(mm, addr, exec, true);
+			tlb_batch_add_one(mm, addr, exec, REAL_HPAGE_SHIFT);
 			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec,
-					true);
+					  REAL_HPAGE_SHIFT);
 		} else {
 			tlb_batch_pmd_scan(mm, addr, orig);
 		}
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 0a04811..bedf08b 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -122,7 +122,7 @@ void flush_tsb_user(struct tlb_batch *tb)

 	spin_lock_irqsave(&mm->context.lock, flags);

-	if (tb->hugepage_shift < HPAGE_SHIFT) {
+	if (tb->hugepage_shift < REAL_HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
@@ -155,7 +155,7 @@ void flush_tsb_user_page(struct mm_struct *mm,
unsigned long vaddr,

 	spin_lock_irqsave(&mm->context.lock, flags);

-	if (hugepage_shift < HPAGE_SHIFT) {
+	if (hugepage_shift < REAL_HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
-- 
2.9.2


