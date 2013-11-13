From: Bob Picco <bpicco@meloft.net>
Date: Wed, 13 Nov 2013 14:42:47 +0000
Subject: Re: [PATCH v3 9/9] sparc64: Encode huge PMDs using PTE encoding.
Message-Id: <20131113144247.GV29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20131113.021856.1528152135184652144.davem@davemloft.net>
In-Reply-To: <20131113.021856.1528152135184652144.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

The change below in tlb.c caused issue with v3.
David Miller wrote:	[Wed Nov 13 2013, 02:18:56AM EST]
> 
> Now that we have 64-bits for PMDs we can stop using special encodings
> for the huge PMD values, and just put real PTEs in there.
> 
> We allocate a _PAGE_PMD_HUGE bit to distinguish between plain PMDs and
> huge ones.  It is the same for both 4U and 4V PTE layouts.
> 
> We also use _PAGE_SPECIAL to indicate the splitting state, since a
> huge PMD cannot also be special.
> 
> All of the PMD --> PTE translation code disappears, and most of the
> huge PMD bit modifications and tests just degenerate into the PTE
> operations.  In particular USER_PGTABLE_CHECK_PMD_HUGE becomes
> trivial.
> 
> As a side effect, normal PMDs don't shift the physical address around.
> This also speeds up the page table walks in the TLB miss paths since
> they don't have to do the shifts any more.
> 
> Another non-trivial aspect is that pte_modify() has to be changed
> to preserve the _PAGE_PMD_HUGE bits as well as the page size field
> of the pte.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/pgtable_64.h | 181 ++++++++++++++++++++++--------------
>  arch/sparc/include/asm/tsb.h        |  92 +++---------------
>  arch/sparc/mm/gup.c                 |   9 +-
>  arch/sparc/mm/init_64.c             | 102 +-------------------
>  arch/sparc/mm/tlb.c                 |   9 +-
>  5 files changed, 131 insertions(+), 262 deletions(-)
> 
<<<snip>>>
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 97d1e56..6c0cd73 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -161,8 +161,8 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  	if (mm = &init_mm)
>  		return;
>  
> -	if ((pmd_val(pmd) ^ pmd_val(orig)) & PMD_ISHUGE) {
> -		if (pmd_val(pmd) & PMD_ISHUGE)
> +	if ((pmd_val(pmd) ^ pmd_val(orig)) & _PAGE_PMD_HUGE) {
> +		if (pmd_val(pmd) & _PAGE_PMD_HUGE)
>  			mm->context.huge_pte_count++;
>  		else
>  			mm->context.huge_pte_count--;
> @@ -178,10 +178,11 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  	}
>  
>  	if (!pmd_none(orig)) {
> -		bool exec = ((pmd_val(orig) & PMD_HUGE_EXEC) != 0);
> +		pte_t orig_pte = __pte(pmd_val(orig));
> +		bool exec = pte_exec(orig_pte);
>  
>  		addr &= HPAGE_MASK;
> -		if (pmd_val(orig) & PMD_ISHUGE) {
						^^
					The left curly bracket was dropped.
bob
> +		if (pmd_trans_huge(orig))
>  			tlb_batch_add_one(mm, addr, exec);
>  			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec);
>  		} else {
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
