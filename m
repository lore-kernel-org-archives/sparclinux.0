From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 11 Dec 2019 06:26:51 +0000
Subject: Re: [PATCH] sparc64: add support for folded p4d page tables
Message-Id: <20191211062649.GA28255@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <20191124085720.6201-1-rppt@kernel.org>
In-Reply-To: <20191124085720.6201-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

Any updates on this?

On Sun, Nov 24, 2019 at 10:57:20AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate and replace 5leve-fixup.h with pgtable-nop4d.h.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/sparc/include/asm/pgalloc_64.h |  6 +++---
>  arch/sparc/include/asm/pgtable_64.h | 24 ++++++++++-----------
>  arch/sparc/kernel/signal32.c        |  6 +++++-
>  arch/sparc/kernel/smp_64.c          | 13 +++++++++++-
>  arch/sparc/mm/fault_64.c            |  6 +++++-
>  arch/sparc/mm/hugetlbpage.c         | 28 +++++++++++++++---------
>  arch/sparc/mm/init_64.c             | 33 +++++++++++++++++++++++++----
>  7 files changed, 84 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
> index 9d3e5cc95bbb..264e76ceccf6 100644
> --- a/arch/sparc/include/asm/pgalloc_64.h
> +++ b/arch/sparc/include/asm/pgalloc_64.h
> @@ -16,12 +16,12 @@
>  
>  extern struct kmem_cache *pgtable_cache;
>  
> -static inline void __pgd_populate(pgd_t *pgd, pud_t *pud)
> +static inline void __p4d_populate(p4d_t *p4d, pud_t *pud)
>  {
> -	pgd_set(pgd, pud);
> +	p4d_set(p4d, pud);
>  }
>  
> -#define pgd_populate(MM, PGD, PUD)	__pgd_populate(PGD, PUD)
> +#define p4d_populate(MM, P4D, PUD)	__p4d_populate(P4D, PUD)
>  
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 6ae8016ef4ec..34ff3b43afbb 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -13,7 +13,7 @@
>   * the SpitFire page tables.
>   */
>  
> -#include <asm-generic/5level-fixup.h>
> +#include <asm-generic/pgtable-nop4d.h>
>  #include <linux/compiler.h>
>  #include <linux/const.h>
>  #include <asm/types.h>
> @@ -810,9 +810,9 @@ static inline int pmd_present(pmd_t pmd)
>  
>  #define pud_bad(pud)			(pud_val(pud) & ~PAGE_MASK)
>  
> -#define pgd_none(pgd)			(!pgd_val(pgd))
> +#define p4d_none(p4d)			(!p4d_val(p4d))
>  
> -#define pgd_bad(pgd)			(pgd_val(pgd) & ~PAGE_MASK)
> +#define p4d_bad(p4d)			(p4d_val(p4d) & ~PAGE_MASK)
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> @@ -859,13 +859,13 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
>  #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
>  #define pud_present(pud)		(pud_val(pud) != 0U)
>  #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
> -#define pgd_page_vaddr(pgd)		\
> -	((unsigned long) __va(pgd_val(pgd)))
> -#define pgd_present(pgd)		(pgd_val(pgd) != 0U)
> -#define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
> +#define p4d_page_vaddr(p4d)		\
> +	((unsigned long) __va(p4d_val(p4d)))
> +#define p4d_present(p4d)		(p4d_val(p4d) != 0U)
> +#define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
>  
>  /* only used by the stubbed out hugetlb gup code, should never be called */
> -#define pgd_page(pgd)			NULL
> +#define p4d_page(p4d)			NULL
>  
>  static inline unsigned long pud_large(pud_t pud)
>  {
> @@ -884,8 +884,8 @@ static inline unsigned long pud_pfn(pud_t pud)
>  /* Same in both SUN4V and SUN4U.  */
>  #define pte_none(pte) 			(!pte_val(pte))
>  
> -#define pgd_set(pgdp, pudp)	\
> -	(pgd_val(*(pgdp)) = (__pa((unsigned long) (pudp))))
> +#define p4d_set(p4dp, pudp)	\
> +	(p4d_val(*(p4dp)) = (__pa((unsigned long) (pudp))))
>  
>  /* to find an entry in a page-table-directory. */
>  #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> @@ -896,8 +896,8 @@ static inline unsigned long pud_pfn(pud_t pud)
>  
>  /* Find an entry in the third-level page table.. */
>  #define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> -#define pud_offset(pgdp, address)	\
> -	((pud_t *) pgd_page_vaddr(*(pgdp)) + pud_index(address))
> +#define pud_offset(p4dp, address)	\
> +	((pud_t *) p4d_page_vaddr(*(p4dp)) + pud_index(address))
>  
>  /* Find an entry in the second-level page table.. */
>  #define pmd_offset(pudp, address)	\
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index a237810aa9f4..2a734ecd0a40 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -299,6 +299,7 @@ static void flush_signal_insns(unsigned long address)
>  	unsigned long pstate, paddr;
>  	pte_t *ptep, pte;
>  	pgd_t *pgdp;
> +	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  
> @@ -318,7 +319,10 @@ static void flush_signal_insns(unsigned long address)
>  	pgdp = pgd_offset(current->mm, address);
>  	if (pgd_none(*pgdp))
>  		goto out_irqs_on;
> -	pudp = pud_offset(pgdp, address);
> +	p4dp = p4d_offset(pgdp, address);
> +	if (p4d_none(*p4dp))
> +		goto out_irqs_on;
> +	pudp = pud_offset(p4dp, address);
>  	if (pud_none(*pudp))
>  		goto out_irqs_on;
>  	pmdp = pmd_offset(pudp, address);
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index a8275fea4b70..eb9455798338 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1621,6 +1621,7 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
>  static void __init pcpu_populate_pte(unsigned long addr)
>  {
>  	pgd_t *pgd = pgd_offset_k(addr);
> +	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
>  
> @@ -1633,7 +1634,17 @@ static void __init pcpu_populate_pte(unsigned long addr)
>  		pgd_populate(&init_mm, pgd, new);
>  	}
>  
> -	pud = pud_offset(pgd, addr);
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d)) {
> +		pud_t *new;
> +
> +		new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
> +		if (!new)
> +			goto err_alloc;
> +		p4d_populate(&init_mm, p4d, new);
> +	}
> +
> +	pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud)) {
>  		pmd_t *new;
>  
> diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
> index 2371fb6b97e4..8b7ddbd14b65 100644
> --- a/arch/sparc/mm/fault_64.c
> +++ b/arch/sparc/mm/fault_64.c
> @@ -80,6 +80,7 @@ static void __kprobes bad_kernel_pc(struct pt_regs *regs, unsigned long vaddr)
>  static unsigned int get_user_insn(unsigned long tpc)
>  {
>  	pgd_t *pgdp = pgd_offset(current->mm, tpc);
> +	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep, pte;
> @@ -88,7 +89,10 @@ static unsigned int get_user_insn(unsigned long tpc)
>  
>  	if (pgd_none(*pgdp) || unlikely(pgd_bad(*pgdp)))
>  		goto out;
> -	pudp = pud_offset(pgdp, tpc);
> +	p4dp = p4d_offset(pgdp, tpc);
> +	if (p4d_none(*p4dp) || unlikely(p4d_bad(*p4dp)))
> +		goto out;
> +	pudp = pud_offset(p4dp, tpc);
>  	if (pud_none(*pudp) || unlikely(pud_bad(*pudp)))
>  		goto out;
>  
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index f78793a06bbd..7b9fa861b67c 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -277,11 +277,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>  			unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgd;
> +	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
>  
>  	pgd = pgd_offset(mm, addr);
> -	pud = pud_alloc(mm, pgd, addr);
> +	p4d = p4d_offset(pgd, addr);
> +	pud = pud_alloc(mm, p4d, addr);
>  	if (!pud)
>  		return NULL;
>  	if (sz >= PUD_SIZE)
> @@ -298,13 +300,17 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgd;
> +	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
>  
>  	pgd = pgd_offset(mm, addr);
>  	if (pgd_none(*pgd))
>  		return NULL;
> -	pud = pud_offset(pgd, addr);
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return NULL;
> +	pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud))
>  		return NULL;
>  	if (is_hugetlb_pud(*pud))
> @@ -449,7 +455,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>  	mm_dec_nr_pmds(tlb->mm);
>  }
>  
> -static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
> +static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>  				   unsigned long addr, unsigned long end,
>  				   unsigned long floor, unsigned long ceiling)
>  {
> @@ -458,7 +464,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
>  	unsigned long start;
>  
>  	start = addr;
> -	pud = pud_offset(pgd, addr);
> +	pud = pud_offset(p4d, addr);
>  	do {
>  		next = pud_addr_end(addr, end);
>  		if (pud_none_or_clear_bad(pud))
> @@ -481,8 +487,8 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
>  	if (end - 1 > ceiling - 1)
>  		return;
>  
> -	pud = pud_offset(pgd, start);
> -	pgd_clear(pgd);
> +	pud = pud_offset(p4d, start);
> +	p4d_clear(p4d);
>  	pud_free_tlb(tlb, pud, start);
>  	mm_dec_nr_puds(tlb->mm);
>  }
> @@ -492,6 +498,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  			    unsigned long floor, unsigned long ceiling)
>  {
>  	pgd_t *pgd;
> +	p4d_t *p4d;
>  	unsigned long next;
>  
>  	addr &= PMD_MASK;
> @@ -511,10 +518,11 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  		return;
>  
>  	pgd = pgd_offset(tlb->mm, addr);
> +	p4d = p4d_offset(pgd, addr);
>  	do {
> -		next = pgd_addr_end(addr, end);
> -		if (pgd_none_or_clear_bad(pgd))
> +		next = p4d_addr_end(addr, end);
> +		if (p4d_none_or_clear_bad(p4d))
>  			continue;
> -		hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
> -	} while (pgd++, addr = next, addr != end);
> +		hugetlb_free_pud_range(tlb, p4d, addr, next, floor, ceiling);
> +	} while (p4d++, addr = next, addr != end);
>  }
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index e6d91819da92..1cf0d666dea3 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -530,7 +530,8 @@ void __kprobes flush_icache_range(unsigned long start, unsigned long end)
>  				paddr = kaddr & mask;
>  			else {
>  				pgd_t *pgdp = pgd_offset_k(kaddr);
> -				pud_t *pudp = pud_offset(pgdp, kaddr);
> +				p4d_t *p4dp = p4d_offset(pgdp, kaddr);
> +				pud_t *pudp = pud_offset(p4dp, kaddr);
>  				pmd_t *pmdp = pmd_offset(pudp, kaddr);
>  				pte_t *ptep = pte_offset_kernel(pmdp, kaddr);
>  
> @@ -1653,6 +1654,7 @@ static unsigned long max_phys_bits = 40;
>  bool kern_addr_valid(unsigned long addr)
>  {
>  	pgd_t *pgd;
> +	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte;
> @@ -1674,7 +1676,11 @@ bool kern_addr_valid(unsigned long addr)
>  	if (pgd_none(*pgd))
>  		return 0;
>  
> -	pud = pud_offset(pgd, addr);
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return 0;
> +
> +	pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud))
>  		return 0;
>  
> @@ -1800,6 +1806,7 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
>  	while (vstart < vend) {
>  		unsigned long this_end, paddr = __pa(vstart);
>  		pgd_t *pgd = pgd_offset_k(vstart);
> +		p4d_t *p4d;
>  		pud_t *pud;
>  		pmd_t *pmd;
>  		pte_t *pte;
> @@ -1814,7 +1821,20 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
>  			alloc_bytes += PAGE_SIZE;
>  			pgd_populate(&init_mm, pgd, new);
>  		}
> -		pud = pud_offset(pgd, vstart);
> +
> +		p4d = p4d_offset(pgd, vstart);
> +		if (p4d_none(*p4d)) {
> +			pud_t *new;
> +
> +			new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE,
> +						  PAGE_SIZE);
> +			if (!new)
> +				goto err_alloc;
> +			alloc_bytes += PAGE_SIZE;
> +			p4d_populate(&init_mm, p4d, new);
> +		}
> +
> +		pud = pud_offset(p4d, vstart);
>  		if (pud_none(*pud)) {
>  			pmd_t *new;
>  
> @@ -2612,13 +2632,18 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>  	for (; vstart < vend; vstart += PMD_SIZE) {
>  		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
>  		unsigned long pte;
> +		p4d_t *p4d;
>  		pud_t *pud;
>  		pmd_t *pmd;
>  
>  		if (!pgd)
>  			return -ENOMEM;
>  
> -		pud = vmemmap_pud_populate(pgd, vstart, node);
> +		p4d = vmemmap_p4d_populate(pgd, vstart, node);
> +		if (!p4d)
> +			return -ENOMEM;
> +
> +		pud = vmemmap_pud_populate(p4d, vstart, node);
>  		if (!pud)
>  			return -ENOMEM;
>  
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.
