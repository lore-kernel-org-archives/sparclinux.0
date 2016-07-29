From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 29 Jul 2016 07:54:21 +0000
Subject: [PATCH v2] sparc64: Trim page tables for 8M hugepages
Message-Id: <1469778930-242969-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Julian Calaby <julian.calaby@gmail.com>, Hugh Dickins <hughd@google.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, Minchan Kim <minchan@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sudeep Holla <sudeep.holla@arm.com>, Chris Hyser <chris.hyser@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>, Toshi Kani <toshi.kani@hpe.com>, Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

For PMD aligned (8M) hugepages, we currently allocate
all four page table levels which is wasteful. We now
allocate till PMD level only which saves memory usage
from page tables.

Also, when freeing page table for 8M hugepage backed region,
make sure we don't try to access non-existent PTE level.

Orabug: 22630259

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
Changelog v2 vs v1
 - Combine fix for page table freeing with the main trimming patch (Dave)

arch/sparc/include/asm/hugetlb.h    |   12 +--
 arch/sparc/include/asm/pgtable_64.h |    7 ++-
 arch/sparc/include/asm/tsb.h        |    2 +-
 arch/sparc/mm/fault_64.c            |    4 +-
 arch/sparc/mm/hugetlbpage.c         |  166 +++++++++++++++++++++++-----------
 arch/sparc/mm/init_64.c             |    5 +-
 6 files changed, 129 insertions(+), 67 deletions(-)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 139e711..dcbf985 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -31,14 +31,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-					  unsigned long addr, unsigned long end,
-					  unsigned long floor,
-					  unsigned long ceiling)
-{
-	free_pgd_range(tlb, addr, end, floor, ceiling);
-}
-
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
 {
@@ -82,4 +74,8 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
+void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
+			    unsigned long end, unsigned long floor,
+			    unsigned long ceiling);
+
 #endif /* _ASM_SPARC64_HUGETLB_H */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index e7d8280..1fb317f 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -395,7 +395,7 @@ static inline unsigned long __pte_huge_mask(void)
 
 static inline pte_t pte_mkhuge(pte_t pte)
 {
-	return __pte(pte_val(pte) | __pte_huge_mask());
+	return __pte(pte_val(pte) | _PAGE_PMD_HUGE | __pte_huge_mask());
 }
 
 static inline bool is_hugetlb_pte(pte_t pte)
@@ -403,6 +403,11 @@ static inline bool is_hugetlb_pte(pte_t pte)
 	return !!(pte_val(pte) & __pte_huge_mask());
 }
 
+static inline bool is_hugetlb_pmd(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_PMD_HUGE);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index c6a155c..32258e0 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -203,7 +203,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 * We have to propagate the 4MB bit of the virtual address
 	 * because we are fabricating 8MB pages using 4MB hw pages.
 	 */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 #define USER_PGTABLE_CHECK_PMD_HUGE(VADDR, REG1, REG2, FAIL_LABEL, PTE_LABEL) \
 	brz,pn		REG1, FAIL_LABEL;		\
 	 sethi		%uhi(_PAGE_PMD_HUGE), REG2;	\
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 6c43b92..575ecfe 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -111,8 +111,8 @@ static unsigned int get_user_insn(unsigned long tpc)
 	if (pmd_none(*pmdp) || unlikely(pmd_bad(*pmdp)))
 		goto out_irq_enable;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_trans_huge(*pmdp)) {
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
+	if (is_hugetlb_pmd(*pmdp)) {
 		pa  = pmd_pfn(*pmdp) << PAGE_SHIFT;
 		pa += tpc & ~HPAGE_MASK;
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ba52e64..494c390 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -12,6 +12,7 @@
 
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
+#include <asm/pgtable.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -131,23 +132,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	/* We must align the address, because our caller will run
-	 * set_huge_pte_at() on whatever we return, which writes out
-	 * all of the sub-ptes for the hugepage range.  So we have
-	 * to give it the first such sub-pte.
-	 */
-	addr &= HPAGE_MASK;
-
 	pgd = pgd_offset(mm, addr);
 	pud = pud_alloc(mm, pgd, addr);
-	if (pud) {
-		pmd = pmd_alloc(mm, pud, addr);
-		if (pmd)
-			pte = pte_alloc_map(mm, pmd, addr);
-	}
+	if (pud)
+		pte = (pte_t *)pmd_alloc(mm, pud, addr);
+
 	return pte;
 }
 
@@ -155,19 +146,13 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
-	pmd_t *pmd;
 	pte_t *pte = NULL;
 
-	addr &= HPAGE_MASK;
-
 	pgd = pgd_offset(mm, addr);
 	if (!pgd_none(*pgd)) {
 		pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
-			pmd = pmd_offset(pud, addr);
-			if (!pmd_none(*pmd))
-				pte = pte_offset_map(pmd, addr);
-		}
+		if (!pud_none(*pud))
+			pte = (pte_t *)pmd_offset(pud, addr);
 	}
 	return pte;
 }
@@ -175,70 +160,143 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry)
 {
-	int i;
-	pte_t orig[2];
-	unsigned long nptes;
+	pte_t orig;
 
 	if (!pte_present(*ptep) && pte_present(entry))
 		mm->context.huge_pte_count++;
 
 	addr &= HPAGE_MASK;
-
-	nptes = 1 << HUGETLB_PAGE_ORDER;
-	orig[0] = *ptep;
-	orig[1] = *(ptep + nptes / 2);
-	for (i = 0; i < nptes; i++) {
-		*ptep = entry;
-		ptep++;
-		addr += PAGE_SIZE;
-		pte_val(entry) += PAGE_SIZE;
-	}
+	orig = *ptep;
+	*ptep = entry;
 
 	/* Issue TLB flush at REAL_HPAGE_SIZE boundaries */
-	addr -= REAL_HPAGE_SIZE;
-	ptep -= nptes / 2;
-	maybe_tlb_batch_add(mm, addr, ptep, orig[1], 0);
-	addr -= REAL_HPAGE_SIZE;
-	ptep -= nptes / 2;
-	maybe_tlb_batch_add(mm, addr, ptep, orig[0], 0);
+	maybe_tlb_batch_add(mm, addr, ptep, orig, 0);
+	maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, orig, 0);
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
 	pte_t entry;
-	int i;
-	unsigned long nptes;
 
 	entry = *ptep;
 	if (pte_present(entry))
 		mm->context.huge_pte_count--;
 
 	addr &= HPAGE_MASK;
-	nptes = 1 << HUGETLB_PAGE_ORDER;
-	for (i = 0; i < nptes; i++) {
-		*ptep = __pte(0UL);
-		addr += PAGE_SIZE;
-		ptep++;
-	}
+	*ptep = __pte(0UL);
 
 	/* Issue TLB flush at REAL_HPAGE_SIZE boundaries */
-	addr -= REAL_HPAGE_SIZE;
-	ptep -= nptes / 2;
-	maybe_tlb_batch_add(mm, addr, ptep, entry, 0);
-	addr -= REAL_HPAGE_SIZE;
-	ptep -= nptes / 2;
 	maybe_tlb_batch_add(mm, addr, ptep, entry, 0);
+	maybe_tlb_batch_add(mm, addr + REAL_HPAGE_SIZE, ptep, entry, 0);
 
 	return entry;
 }
 
 int pmd_huge(pmd_t pmd)
 {
-	return 0;
+	return !pmd_none(pmd) &&
+		(pmd_val(pmd) & (_PAGE_VALID|_PAGE_PMD_HUGE)) != _PAGE_VALID;
 }
 
 int pud_huge(pud_t pud)
 {
 	return 0;
 }
+
+static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+			   unsigned long addr)
+{
+	pgtable_t token = pmd_pgtable(*pmd);
+
+	pmd_clear(pmd);
+	pte_free_tlb(tlb, token, addr);
+	atomic_long_dec(&tlb->mm->nr_ptes);
+}
+
+static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				   unsigned long addr, unsigned long end,
+				   unsigned long floor, unsigned long ceiling)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	unsigned long start;
+
+	start = addr;
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (is_hugetlb_pmd(*pmd))
+			pmd_clear(pmd);
+		else
+			hugetlb_free_pte_range(tlb, pmd, addr);
+	} while (pmd++, addr = next, addr != end);
+
+	start &= PUD_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PUD_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pmd = pmd_offset(pud, start);
+	pud_clear(pud);
+	pmd_free_tlb(tlb, pmd, start);
+	mm_dec_nr_pmds(tlb->mm);
+}
+
+static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				   unsigned long addr, unsigned long end,
+				   unsigned long floor, unsigned long ceiling)
+{
+	pud_t *pud;
+	unsigned long next;
+	unsigned long start;
+
+	start = addr;
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
+				       ceiling);
+	} while (pud++, addr = next, addr != end);
+
+	start &= PGDIR_MASK;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= PGDIR_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		return;
+
+	pud = pud_offset(pgd, start);
+	pgd_clear(pgd);
+	pud_free_tlb(tlb, pud, start);
+}
+
+void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+			    unsigned long addr, unsigned long end,
+			    unsigned long floor, unsigned long ceiling)
+{
+	pgd_t *pgd;
+	unsigned long next;
+
+	pgd = pgd_offset(tlb->mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
+	} while (pgd++, addr = next, addr != end);
+}
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index aec508e..9510051 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -346,9 +346,12 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (mm->context.huge_pte_count && is_hugetlb_pte(pte))
+	if (mm->context.huge_pte_count && is_hugetlb_pte(pte)) {
+		/* We are fabricating 8MB pages using 4MB real hw pages.  */
+		pte_val(pte) |= (address & (1UL << REAL_HPAGE_SHIFT));
 		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
 					address, pte_val(pte));
+	}
 	else
 #endif
 		__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
-- 
1.7.1

