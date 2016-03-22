From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 22 Mar 2016 01:47:41 +0000
Subject: Re: [PATCH v2] sparc64: Reduce TLB flushes during hugepage unmap
Message-Id: <56F0A43D.3090904@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454540423-67071-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1454540423-67071-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 03/20/2016 09:28 PM, David Miller wrote:
> From: Nitin Gupta <nitin.m.gupta@oracle.com>
> Date: Wed,  3 Feb 2016 15:00:23 -0800
> 
>> During hugepage unmap, TSB and TLB flushes are currently
>> issued at every PAGE_SIZE'd boundary which is unnecessary.
>> We now issue the flush at REAL_HPAGE_SIZE boundaries only.
>>
>> Without this patch workloads which unmap a large hugepage
>> backed VMA region get CPU lockups due to excessive TLB
>> flush calls.
>>
>> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> 
> I thought a lot about this stuff tonight, and I think we need to be
> more intelligent about this.
> 
> Doing a synchronous flush unconditionally is not good.  In particular,
> we aren't even checking if the original PTE was mapped or not which
> is going to be the most common case when a new mapping is created.
> 
> Also, we can't skip the D-cache flushes that older cpus need, as done
> by tlb_batch_add().
> 
> Therefore let's teach the TLB batcher what we're actually trying to do
> and what the optimization is, instead of trying so hard to bypass it
> altogether.
> 
> In asm/pgtable_64.h provide is_hugetlb_pte(), I'd implement it like
> this:
> 
> static inline unsigned long __pte_huge_mask(void)
> {
> 	unsigned long mask;
> 
> 	__asm__ __volatile__(
> 	"\n661:	sethi		%%uhi(%1), %0\n"
> 	"	sllx		%0, 32, %0\n"
> 	"	.section	.sun4v_2insn_patch, \"ax\"\n"
> 	"	.word		661b\n"
> 	"	mov		%2, %0\n"
> 	"	nop\n"
> 	"	.previous\n"
> 	: "=r" (mask)
> 	: "i" (_PAGE_SZHUGE_4U), "i" (_PAGE_SZHUGE_4V));
> 
> 	return mask;
> }
> 
> Then pte_mkhuge() becomes:
> 
> static inline pte_t pte_mkhuge(pte_t pte)
> {
> 	return __pte(pte_val(pte) | __pte_huge_mask());
> }
> 
> and then:
> 
> static inline bool is_hugetlb_pte(pte_t pte)
> {
> 	return (pte_val(pte) & __pte_huge_mask());
> }
> 
> And then in tlb_batch_add() can detect if the orignal PTE is huge:
> 
> 	bool huge = is_hugetlb_pte(orig);
> 
> and then the end of the function is:
> 
> 	if (huge & (vaddr & (REAL_HPAGE_SIZE - 1)))
> 		return;
> 	if (!fullmm)
> 		tlb_batch_add_one(mm, vaddr, pte_exec(orig), huge);
> 
> and tlb_batch_add_one() takes 'huge' and uses it to drive the flushing.
> 
> For a synchronous flush, we pass it down to flush_tsb_user_page().
> 
> For a batched flush we store it in tlb_batch, and any time 'huge'
> changes, we do a flush_tlb_pending(), just the same as if tb->tlb_nr
> hit TLB_BATCH_NR.
> 
> Then flush_tsb_user() uses 'tb->huge' to decide whether to flush
> MM_TSB_BASE or not.
> 

Thanks for detailed notes.  I will now combine my last two patches
which fix TLB flushing on PTE change and zero'ing out resp., along
with changes you suggested and send a v2 soon.

Thanks,
Nitin

