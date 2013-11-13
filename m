From: David Miller <davem@davemloft.net>
Date: Wed, 13 Nov 2013 07:18:41 +0000
Subject: [PATCH v3 7/9] sparc64: Move from 4MB to 8MB huge pages.
Message-Id: <20131113.021841.1188265874488788628.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The impetus for this is that we would like to move to 64-bit PMDs and
PGDs, but that would result in only supporting a 42-bit address space
with the current page table layout.  It'd be nice to support at least
43-bits.

The reason we'd end up with only 42-bits after making PMDs and PGDs
64-bit is that we only use half-page sized PTE tables in order to make
PMDs line up to 4MB, the hardware huge page size we use.

So what we do here is we make huge pages 8MB, and fabricate them using
4MB hw TLB entries.

Facilitate this by providing a "REAL_HPAGE_SHIFT" which is used in
places that really need to operate on hardware 4MB pages.

Use full pages (512 entries) for PTE tables, and adjust PMD_SHIFT,
PGD_SHIFT, and the build time CPP test as needed.  Use a CPP test to
make sure REAL_HPAGE_SHIFT and the _PAGE_SZHUGE_* we use match up.

This makes the pgtable cache completely unused, so remove the code
managing it and the state used in mm_context_t.  Now we have less
spinlocks taken in the page table allocation path.

The technique we use to fabricate the 8MB pages is to transfer bit 22
from the missing virtual address into the PTEs physical address field.
That takes care of the transparent huge pages case.

For hugetlb, we fill things in at the PTE level and that code already
puts the sub huge page physical bits into the PTEs, based upon the
offset, so there is nothing special we need to do.  It all just works
out.

So, a small amount of complexity in the THP case, but this code is
about to get much simpler when we move the 64-bit PMDs as we can move
away from the fancy 32-bit huge PMD encoding and just put a real PTE
value in there.

With bug fixes and help from Bob Picco.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/mmu_64.h     |  1 -
 arch/sparc/include/asm/page_64.h    |  5 ++-
 arch/sparc/include/asm/pgtable_64.h | 12 ++++--
 arch/sparc/include/asm/tsb.h        | 17 ++++++---
 arch/sparc/kernel/sun4v_tlb_miss.S  |  2 +-
 arch/sparc/kernel/tsb.S             |  2 +-
 arch/sparc/mm/init_64.c             | 74 ++++++++-----------------------------
 arch/sparc/mm/tlb.c                 |  6 ++-
 arch/sparc/mm/tsb.c                 | 13 +------
 9 files changed, 47 insertions(+), 85 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 76092c4..f668797 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -93,7 +93,6 @@ typedef struct {
 	spinlock_t		lock;
 	unsigned long		sparc64_ctx_val;
 	unsigned long		huge_pte_count;
-	struct page		*pgtable_page;
 	struct tsb_config	tsb_block[MM_NUM_TSBS];
 	struct hv_tsb_descr	tsb_descr[MM_NUM_TSBS];
 } mm_context_t;
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 89e07fd..1958bfbe 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -15,7 +15,10 @@
 #define DCACHE_ALIASING_POSSIBLE
 #endif
 
-#define HPAGE_SHIFT		22
+#define HPAGE_SHIFT		23
+#define REAL_HPAGE_SHIFT	22
+
+#define REAL_HPAGE_SIZE		(_AC(1,UL) << REAL_HPAGE_SHIFT)
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3676031..012b6ee 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -48,18 +48,18 @@
 /* PMD_SHIFT determines the size of the area a second-level page
  * table can map
  */
-#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-4))
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3))
 #define PMD_SIZE	(_AC(1,UL) << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 #define PMD_BITS	(PAGE_SHIFT - 2)
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-4) + PMD_BITS)
+#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3) + PMD_BITS)
 #define PGDIR_SIZE	(_AC(1,UL) << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PGDIR_BITS	(PAGE_SHIFT - 2)
 
-#if (PGDIR_SHIFT + PGDIR_BITS) != 44
+#if (PGDIR_SHIFT + PGDIR_BITS) != 45
 #error Page table parameters do not cover virtual address space properly.
 #endif
 
@@ -95,7 +95,7 @@
 #include <linux/sched.h>
 
 /* Entries per page directory level. */
-#define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-4))
+#define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PMD	(1UL << PMD_BITS)
 #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
 
@@ -180,6 +180,10 @@
 #define _PAGE_SZBITS_4U	_PAGE_SZ8K_4U
 #define _PAGE_SZBITS_4V	_PAGE_SZ8K_4V
 
+#if REAL_HPAGE_SHIFT != 22
+#error REAL_HPAGE_SHIFT and _PAGE_SZHUGE_foo must match up
+#endif
+
 #define _PAGE_SZHUGE_4U	_PAGE_SZ4MB_4U
 #define _PAGE_SZHUGE_4V	_PAGE_SZ4MB_4V
 
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index e696432..16e5777 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -152,7 +152,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	lduwa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
 	brz,pn		REG1, FAIL_LABEL; \
 	 sllx		VADDR, 64 - PMD_SHIFT, REG2; \
-	srlx		REG2, 64 - (PAGE_SHIFT - 1), REG2; \
+	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	sllx		REG1, PMD_PADDR_SHIFT, REG1; \
 	andn		REG2, 0x7, REG2; \
 	add		REG1, REG2, REG1;
@@ -177,8 +177,15 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	or		REG, _PAGE_##NAME##_4V, REG;	\
 	.previous;
 
-	/* Load into REG the PTE value for VALID, CACHE, and SZHUGE.  */
-#define BUILD_PTE_VALID_SZHUGE_CACHE(REG)				   \
+	/* Load into REG the PTE value for VALID, CACHE, and SZHUGE.
+	 *
+	 * We are fabricating an 8MB page using 2 4MB HW pages here.
+	 */
+#define BUILD_PTE_VALID_SZHUGE_CACHE(VADDR, PADDR_BITS, REG)		   \
+	sethi		%hi(4 * 1024 * 1024), REG;			   \
+	andn		PADDR_BITS, REG, PADDR_BITS;			   \
+	and		VADDR, REG, REG;				   \
+	or		PADDR_BITS, REG, PADDR_BITS;			   \
 661:	sethi		%uhi(_PAGE_VALID|_PAGE_SZHUGE_4U), REG;		   \
 	.section	.sun4v_1insn_patch, "ax";			   \
 	.word		661b;						   \
@@ -231,7 +238,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 nop;								      \
 	OR_PTE_BIT_2INSN(REG2, REG1, EXEC);				      \
 	/* REG1 can now be clobbered, build final PTE */		      \
-1:	BUILD_PTE_VALID_SZHUGE_CACHE(REG1);				      \
+1:	BUILD_PTE_VALID_SZHUGE_CACHE(VADDR, REG2, REG1);		      \
 	ba,pt		%xcc, PTE_LABEL;				      \
 	 or		REG1, REG2, REG1;				      \
 700:
@@ -263,7 +270,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	lduwa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
 	USER_PGTABLE_CHECK_PMD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, 800f) \
 	sllx		VADDR, 64 - PMD_SHIFT, REG2; \
-	srlx		REG2, 64 - (PAGE_SHIFT - 1), REG2; \
+	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
 	sllx		REG1, PMD_PADDR_SHIFT, REG1; \
 	andn		REG2, 0x7, REG2; \
 	add		REG1, REG2, REG1; \
diff --git a/arch/sparc/kernel/sun4v_tlb_miss.S b/arch/sparc/kernel/sun4v_tlb_miss.S
index bde867f..e0c09bf8 100644
--- a/arch/sparc/kernel/sun4v_tlb_miss.S
+++ b/arch/sparc/kernel/sun4v_tlb_miss.S
@@ -182,7 +182,7 @@ sun4v_tsb_miss_common:
 	cmp	%g5, -1
 	be,pt	%xcc, 80f
 	 nop
-	COMPUTE_TSB_PTR(%g5, %g4, HPAGE_SHIFT, %g2, %g7)
+	COMPUTE_TSB_PTR(%g5, %g4, REAL_HPAGE_SHIFT, %g2, %g7)
 
 	/* That clobbered %g2, reload it.  */
 	ldxa	[%g0] ASI_SCRATCHPAD, %g2
diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index a313e4a..14158d4 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -75,7 +75,7 @@ tsb_miss_page_table_walk:
 	mov		512, %g7
 	andn		%g5, 0x7, %g5
 	sllx		%g7, %g6, %g7
-	srlx		%g4, HPAGE_SHIFT, %g6
+	srlx		%g4, REAL_HPAGE_SHIFT, %g6
 	sub		%g7, 1, %g7
 	and		%g6, %g7, %g6
 	sllx		%g6, 4, %g6
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 7a97b5a..807e108 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -354,7 +354,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	if (mm->context.huge_pte_count && is_hugetlb_pte(pte))
-		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, HPAGE_SHIFT,
+		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
 					address, pte_val(pte));
 	else
 #endif
@@ -2547,53 +2547,13 @@ void __flush_tlb_all(void)
 			     : : "r" (pstate));
 }
 
-static pte_t *get_from_cache(struct mm_struct *mm)
-{
-	struct page *page;
-	pte_t *ret;
-
-	spin_lock(&mm->page_table_lock);
-	page = mm->context.pgtable_page;
-	ret = NULL;
-	if (page) {
-		void *p = page_address(page);
-
-		mm->context.pgtable_page = NULL;
-
-		ret = (pte_t *) (p + (PAGE_SIZE / 2));
-	}
-	spin_unlock(&mm->page_table_lock);
-
-	return ret;
-}
-
-static struct page *__alloc_for_cache(struct mm_struct *mm)
-{
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK |
-				       __GFP_REPEAT | __GFP_ZERO);
-
-	if (page) {
-		spin_lock(&mm->page_table_lock);
-		if (!mm->context.pgtable_page) {
-			atomic_set(&page->_count, 2);
-			mm->context.pgtable_page = page;
-		}
-		spin_unlock(&mm->page_table_lock);
-	}
-	return page;
-}
-
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 			    unsigned long address)
 {
-	struct page *page;
-	pte_t *pte;
-
-	pte = get_from_cache(mm);
-	if (pte)
-		return pte;
+	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK |
+				       __GFP_REPEAT | __GFP_ZERO);
+	pte_t *pte = NULL;
 
-	page = __alloc_for_cache(mm);
 	if (page)
 		pte = (pte_t *) page_address(page);
 
@@ -2603,14 +2563,10 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 pgtable_t pte_alloc_one(struct mm_struct *mm,
 			unsigned long address)
 {
-	struct page *page;
-	pte_t *pte;
-
-	pte = get_from_cache(mm);
-	if (pte)
-		return pte;
+	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK |
+				       __GFP_REPEAT | __GFP_ZERO);
+	pte_t *pte = NULL;
 
-	page = __alloc_for_cache(mm);
 	if (page) {
 		pgtable_page_ctor(page);
 		pte = (pte_t *) page_address(page);
@@ -2621,18 +2577,15 @@ pgtable_t pte_alloc_one(struct mm_struct *mm,
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	struct page *page = virt_to_page(pte);
-	if (put_page_testzero(page))
-		free_hot_cold_page(page, 0);
+	free_page((unsigned long)pte);
 }
 
 static void __pte_free(pgtable_t pte)
 {
 	struct page *page = virt_to_page(pte);
-	if (put_page_testzero(page)) {
-		pgtable_page_dtor(page);
-		free_hot_cold_page(page, 0);
-	}
+
+	pgtable_page_dtor(page);
+	__free_page(page);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
@@ -2752,6 +2705,9 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 	pte <<= PMD_PADDR_SHIFT;
 	pte |= _PAGE_VALID;
 
+	/* We are fabricating 8MB pages using 4MB real hw pages.  */
+	pte |= (addr & (1UL << REAL_HPAGE_SHIFT));
+
 	prot = pmd_pgprot(entry);
 
 	if (tlb_type = hypervisor)
@@ -2766,7 +2722,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 	if (mm->context.tsb_block[MM_TSB_HUGE].tsb != NULL)
-		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, HPAGE_SHIFT,
+		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
 					addr, pte);
 
 	spin_unlock_irqrestore(&mm->context.lock, flags);
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 7a91f28..97d1e56 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -181,10 +181,12 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		bool exec = ((pmd_val(orig) & PMD_HUGE_EXEC) != 0);
 
 		addr &= HPAGE_MASK;
-		if (pmd_val(orig) & PMD_ISHUGE)
+		if (pmd_val(orig) & PMD_ISHUGE) {
 			tlb_batch_add_one(mm, addr, exec);
-		else
+			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec);
+		} else {
 			tlb_batch_pmd_scan(mm, addr, orig, exec);
+		}
 	}
 }
 
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 2cc3bce..3b3a360 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -87,7 +87,7 @@ void flush_tsb_user(struct tlb_batch *tb)
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
 			base = __pa(base);
-		__flush_tsb_one(tb, HPAGE_SHIFT, base, nentries);
+		__flush_tsb_one(tb, REAL_HPAGE_SHIFT, base, nentries);
 	}
 #endif
 	spin_unlock_irqrestore(&mm->context.lock, flags);
@@ -111,7 +111,7 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr)
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
 		if (tlb_type = cheetah_plus || tlb_type = hypervisor)
 			base = __pa(base);
-		__flush_tsb_one_entry(base, vaddr, HPAGE_SHIFT, nentries);
+		__flush_tsb_one_entry(base, vaddr, REAL_HPAGE_SHIFT, nentries);
 	}
 #endif
 	spin_unlock_irqrestore(&mm->context.lock, flags);
@@ -472,8 +472,6 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	mm->context.huge_pte_count = 0;
 #endif
 
-	mm->context.pgtable_page = NULL;
-
 	/* copy_mm() copies over the parent's mm_struct before calling
 	 * us, so we need to zero out the TSB pointer or else tsb_grow()
 	 * will be confused and think there is an older TSB to free up.
@@ -512,17 +510,10 @@ static void tsb_destroy_one(struct tsb_config *tp)
 void destroy_context(struct mm_struct *mm)
 {
 	unsigned long flags, i;
-	struct page *page;
 
 	for (i = 0; i < MM_NUM_TSBS; i++)
 		tsb_destroy_one(&mm->context.tsb_block[i]);
 
-	page = mm->context.pgtable_page;
-	if (page && put_page_testzero(page)) {
-		pgtable_page_dtor(page);
-		free_hot_cold_page(page, 0);
-	}
-
 	spin_lock_irqsave(&ctx_alloc_lock, flags);
 
 	if (CTX_VALID(mm->context)) {
-- 
1.8.1.2

