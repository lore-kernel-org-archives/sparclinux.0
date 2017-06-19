From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 19 Jun 2017 21:52:24 +0000
Subject: Re: From: Nitin Gupta <nitin.m.gupta@oracle.com>
Message-Id: <94e9868c-9cd3-17dd-5aa7-c1a999d440f5@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497908927-93636-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1497908927-93636-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Mike Kravetz <mike.kravetz@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tom Hromatka <tom.hromatka@oracle.com>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>, Hugh Dickins <hughd@google.com>, bob picco <bob.picco@oracle.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Steven Sistare <steven.sistare@oracle.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Thomas Tai <thomas.tai@oracle.com>, Atish Patra <atish.patra@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Please ignore this patch series. I will resend again with correct email 
headers.

Nitin


On 6/19/17 2:48 PM, Nitin Gupta wrote:
> Adds support for 16GB hugepage size. To use this page size
> use kernel parameters as:
>
> default_hugepageszG hugepageszG hugepages
>
> Testing:
>
> Tested with the stream benchmark which allocates 48G of
> arrays backed by 16G hugepages and does RW operation on
> them in parallel.
>
> Orabug: 25362942
>
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> ---
>
> Changelog v2 vs v1:
>   - Remove redundant brgez,pn (Bob Picco)
>   - Remove unncessary label rename from 700 to 701 (Rob Gardner)
>   - Add patch description (Paul)
>   - Add 16G case to get_user_pages()
>
>   arch/sparc/include/asm/page_64.h    |  3 +-
>   arch/sparc/include/asm/pgtable_64.h |  5 +++
>   arch/sparc/include/asm/tsb.h        | 30 +++++++++++++++
>   arch/sparc/kernel/tsb.S             |  2 +-
>   arch/sparc/mm/hugetlbpage.c         | 74 ++++++++++++++++++++++++++-----------
>   arch/sparc/mm/init_64.c             | 41 ++++++++++++++++----
>   6 files changed, 125 insertions(+), 30 deletions(-)
>
> diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
> index 5961b2d..8ee1f97 100644
> --- a/arch/sparc/include/asm/page_64.h
> +++ b/arch/sparc/include/asm/page_64.h
> @@ -17,6 +17,7 @@
>   
>   #define HPAGE_SHIFT		23
>   #define REAL_HPAGE_SHIFT	22
> +#define HPAGE_16GB_SHIFT	34
>   #define HPAGE_2GB_SHIFT		31
>   #define HPAGE_256MB_SHIFT	28
>   #define HPAGE_64K_SHIFT		16
> @@ -28,7 +29,7 @@
>   #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
>   #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
>   #define REAL_HPAGE_PER_HPAGE	(_AC(1,UL) << (HPAGE_SHIFT - REAL_HPAGE_SHIFT))
> -#define HUGE_MAX_HSTATE		4
> +#define HUGE_MAX_HSTATE		5
>   #endif
>   
>   #ifndef __ASSEMBLY__
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 6fbd931..2444b02 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -414,6 +414,11 @@ static inline bool is_hugetlb_pmd(pmd_t pmd)
>   	return !!(pmd_val(pmd) & _PAGE_PMD_HUGE);
>   }
>   
> +static inline bool is_hugetlb_pud(pud_t pud)
> +{
> +	return !!(pud_val(pud) & _PAGE_PUD_HUGE);
> +}
> +
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   static inline pmd_t pmd_mkhuge(pmd_t pmd)
>   {
> diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
> index 32258e0..7b240a3 100644
> --- a/arch/sparc/include/asm/tsb.h
> +++ b/arch/sparc/include/asm/tsb.h
> @@ -195,6 +195,35 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
>   	 nop; \
>   699:
>   
> +	/* PUD has been loaded into REG1, interpret the value, seeing
> +	 * if it is a HUGE PUD or a normal one.  If it is not valid
> +	 * then jump to FAIL_LABEL.  If it is a HUGE PUD, and it
> +	 * translates to a valid PTE, branch to PTE_LABEL.
> +	 *
> +	 * We have to propagate bits [32:22] from the virtual address
> +	 * to resolve at 4M granularity.
> +	 */
> +#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +#define USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
> +	brz,pn		REG1, FAIL_LABEL;		\
> +	 sethi		%uhi(_PAGE_PUD_HUGE), REG2;	\
> +	sllx		REG2, 32, REG2;			\
> +	andcc		REG1, REG2, %g0;		\
> +	be,pt		%xcc, 700f;			\
> +	 sethi		%hi(0x1ffc0000), REG2;		\
> +	sllx		REG2, 1, REG2;			\
> +	brgez,pn	REG1, FAIL_LABEL;		\
> +	 andn		REG1, REG2, REG1;		\
> +	and		VADDR, REG2, REG2;		\
> +	brlz,pt		REG1, PTE_LABEL;		\
> +	 or		REG1, REG2, REG1;		\
> +700:
> +#else
> +#define USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
> +	brz,pn		REG1, FAIL_LABEL; \
> +	 nop;
> +#endif
> +
>   	/* PMD has been loaded into REG1, interpret the value, seeing
>   	 * if it is a HUGE PMD or a normal one.  If it is not valid
>   	 * then jump to FAIL_LABEL.  If it is a HUGE PMD, and it
> @@ -242,6 +271,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
>   	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
>   	andn		REG2, 0x7, REG2; \
>   	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
> +	USER_PGTABLE_CHECK_PUD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, 800f) \
>   	brz,pn		REG1, FAIL_LABEL; \
>   	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
>   	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
> diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
> index 07c0df9..5f42ac0 100644
> --- a/arch/sparc/kernel/tsb.S
> +++ b/arch/sparc/kernel/tsb.S
> @@ -117,7 +117,7 @@ tsb_miss_page_table_walk_sun4v_fastpath:
>   	/* Valid PTE is now in %g5.  */
>   
>   #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
> -	sethi		%uhi(_PAGE_PMD_HUGE), %g7
> +	sethi		%uhi(_PAGE_PMD_HUGE | _PAGE_PUD_HUGE), %g7
>   	sllx		%g7, 32, %g7
>   
>   	andcc		%g5, %g7, %g0
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index 88855e3..f0bb42d 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -143,6 +143,10 @@ static pte_t sun4v_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
>   	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4V;
>   
>   	switch (shift) {
> +	case HPAGE_16GB_SHIFT:
> +		hugepage_size = _PAGE_SZ16GB_4V;
> +		pte_val(entry) |= _PAGE_PUD_HUGE;
> +		break;
>   	case HPAGE_2GB_SHIFT:
>   		hugepage_size = _PAGE_SZ2GB_4V;
>   		pte_val(entry) |= _PAGE_PMD_HUGE;
> @@ -187,6 +191,9 @@ static unsigned int sun4v_huge_tte_to_shift(pte_t entry)
>   	unsigned int shift;
>   
>   	switch (tte_szbits) {
> +	case _PAGE_SZ16GB_4V:
> +		shift = HPAGE_16GB_SHIFT;
> +		break;
>   	case _PAGE_SZ2GB_4V:
>   		shift = HPAGE_2GB_SHIFT;
>   		break;
> @@ -263,7 +270,12 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>   
>   	pgd = pgd_offset(mm, addr);
>   	pud = pud_alloc(mm, pgd, addr);
> -	if (pud) {
> +	if (!pud)
> +		return NULL;
> +
> +	if (sz >= PUD_SIZE)
> +		pte = (pte_t *)pud;
> +	else {
>   		pmd = pmd_alloc(mm, pud, addr);
>   		if (!pmd)
>   			return NULL;
> @@ -288,12 +300,16 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>   	if (!pgd_none(*pgd)) {
>   		pud = pud_offset(pgd, addr);
>   		if (!pud_none(*pud)) {
> -			pmd = pmd_offset(pud, addr);
> -			if (!pmd_none(*pmd)) {
> -				if (is_hugetlb_pmd(*pmd))
> -					pte = (pte_t *)pmd;
> -				else
> -					pte = pte_offset_map(pmd, addr);
> +			if (is_hugetlb_pud(*pud))
> +				pte = (pte_t *)pud;
> +			else {
> +				pmd = pmd_offset(pud, addr);
> +				if (!pmd_none(*pmd)) {
> +					if (is_hugetlb_pmd(*pmd))
> +						pte = (pte_t *)pmd;
> +					else
> +						pte = pte_offset_map(pmd, addr);
> +				}
>   			}
>   		}
>   	}
> @@ -304,12 +320,20 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>   void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>   		     pte_t *ptep, pte_t entry)
>   {
> -	unsigned int i, nptes, orig_shift, shift;
> -	unsigned long size;
> +	unsigned int nptes, orig_shift, shift;
> +	unsigned long i, size;
>   	pte_t orig;
>   
>   	size = huge_tte_to_size(entry);
> -	shift = size >= HPAGE_SIZE ? PMD_SHIFT : PAGE_SHIFT;
> +
> +	shift = PAGE_SHIFT;
> +	if (size >= PUD_SIZE)
> +		shift = PUD_SHIFT;
> +	else if (size >= PMD_SIZE)
> +		shift = PMD_SHIFT;
> +	else
> +		shift = PAGE_SHIFT;
> +
>   	nptes = size >> shift;
>   
>   	if (!pte_present(*ptep) && pte_present(entry))
> @@ -332,19 +356,23 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>   pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>   			      pte_t *ptep)
>   {
> -	unsigned int i, nptes, hugepage_shift;
> +	unsigned int i, nptes, orig_shift, shift;
>   	unsigned long size;
>   	pte_t entry;
>   
>   	entry = *ptep;
>   	size = huge_tte_to_size(entry);
> -	if (size >= HPAGE_SIZE)
> -		nptes = size >> PMD_SHIFT;
> +
> +	shift = PAGE_SHIFT;
> +	if (size >= PUD_SIZE)
> +		shift = PUD_SHIFT;
> +	else if (size >= PMD_SIZE)
> +		shift = PMD_SHIFT;
>   	else
> -		nptes = size >> PAGE_SHIFT;
> +		shift = PAGE_SHIFT;
>   
> -	hugepage_shift = pte_none(entry) ? PAGE_SHIFT :
> -		huge_tte_to_shift(entry);
> +	nptes = size >> shift;
> +	orig_shift = pte_none(entry) ? PAGE_SHIFT : huge_tte_to_shift(entry);
>   
>   	if (pte_present(entry))
>   		mm->context.hugetlb_pte_count -= nptes;
> @@ -353,11 +381,11 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>   	for (i = 0; i < nptes; i++)
>   		ptep[i] = __pte(0UL);
>   
> -	maybe_tlb_batch_add(mm, addr, ptep, entry, 0, hugepage_shift);
> +	maybe_tlb_batch_add(mm, addr, ptep, entry, 0, orig_shift);
>   	/* An HPAGE_SIZE'ed page is composed of two REAL_HPAGE_SIZE'ed pages */
>   	if (size = HPAGE_SIZE)
>   		maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, entry, 0,
> -				    hugepage_shift);
> +				    orig_shift);
>   
>   	return entry;
>   }
> @@ -370,7 +398,8 @@ int pmd_huge(pmd_t pmd)
>   
>   int pud_huge(pud_t pud)
>   {
> -	return 0;
> +	return !pud_none(pud) &&
> +		(pud_val(pud) & (_PAGE_VALID|_PAGE_PUD_HUGE)) != _PAGE_VALID;
>   }
>   
>   static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> @@ -434,8 +463,11 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
>   		next = pud_addr_end(addr, end);
>   		if (pud_none_or_clear_bad(pud))
>   			continue;
> -		hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
> -				       ceiling);
> +		if (is_hugetlb_pud(*pud))
> +			pud_clear(pud);
> +		else
> +			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
> +					       ceiling);
>   	} while (pud++, addr = next, addr != end);
>   
>   	start &= PGDIR_MASK;
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 3c40ebd..cc8d0d4 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -337,6 +337,10 @@ static int __init setup_hugepagesz(char *string)
>   	hugepage_shift = ilog2(hugepage_size);
>   
>   	switch (hugepage_shift) {
> +	case HPAGE_16GB_SHIFT:
> +		hv_pgsz_mask = HV_PGSZ_MASK_16GB;
> +		hv_pgsz_idx = HV_PGSZ_IDX_16GB;
> +		break;
>   	case HPAGE_2GB_SHIFT:
>   		hv_pgsz_mask = HV_PGSZ_MASK_2GB;
>   		hv_pgsz_idx = HV_PGSZ_IDX_2GB;
> @@ -377,6 +381,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
>   {
>   	struct mm_struct *mm;
>   	unsigned long flags;
> +	bool is_huge_tsb;
>   	pte_t pte = *ptep;
>   
>   	if (tlb_type != hypervisor) {
> @@ -394,15 +399,37 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
>   
>   	spin_lock_irqsave(&mm->context.lock, flags);
>   
> +	is_huge_tsb = false;
>   #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
> -	if ((mm->context.hugetlb_pte_count || mm->context.thp_pte_count) &&
> -	    is_hugetlb_pmd(__pmd(pte_val(pte)))) {
> -		/* We are fabricating 8MB pages using 4MB real hw pages.  */
> -		pte_val(pte) |= (address & (1UL << REAL_HPAGE_SHIFT));
> -		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
> -					address, pte_val(pte));
> -	} else
> +	if (mm->context.hugetlb_pte_count || mm->context.thp_pte_count) {
> +		unsigned long hugepage_size = PAGE_SIZE;
> +
> +		if (is_vm_hugetlb_page(vma))
> +			hugepage_size = huge_page_size(hstate_vma(vma));
> +
> +		if (hugepage_size >= PUD_SIZE) {
> +			unsigned long mask = 0x1ffc00000UL;
> +
> +			/* Transfer bits [32:22] from address to resolve
> +			 * at 4M granularity.
> +			 */
> +			pte_val(pte) &= ~mask;
> +			pte_val(pte) |= (address & mask);
> +		} else if (hugepage_size >= PMD_SIZE) {
> +			/* We are fabricating 8MB pages using 4MB
> +			 * real hw pages.
> +			 */
> +			pte_val(pte) |= (address & (1UL << REAL_HPAGE_SHIFT));
> +		}
> +
> +		if (hugepage_size >= PMD_SIZE) {
> +			__update_mmu_tsb_insert(mm, MM_TSB_HUGE,
> +				REAL_HPAGE_SHIFT, address, pte_val(pte));
> +			is_huge_tsb = true;
> +		}
> +	}
>   #endif
> +	if (!is_huge_tsb)
>   		__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
>   					address, pte_val(pte));
>   

