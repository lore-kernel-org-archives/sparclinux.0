From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 23 Jun 2016 01:11:41 +0000
Subject: [PATCH 1/2] sparc64: Trim page tables for 8M hugepages
Message-Id: <1466644374-58354-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Julian Calaby <julian.calaby@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Hugh Dickins <hughd@google.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, Minchan Kim <minchan@kernel.org>, David Ahern <david.ahern@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sudeep Holla <sudeep.holla@arm.com>, Zhang Zhen <zhenzhang.zhang@huawei.com>, Chris Hyser <chris.hyser@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>, Toshi Kani <toshi.kani@hpe.com>, Tony Luck <tony.luck@intel.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

For PMD aligned (8M) hugepages, we currently allocate
all four page table levels which is wasteful. We now
allocate till PMD level only which saves memory usage
from page tables.

Orabug: 22630259

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/pgtable_64.h |  7 +++-
 arch/sparc/include/asm/tsb.h        |  2 +-
 arch/sparc/mm/fault_64.c            |  4 +--
 arch/sparc/mm/hugetlbpage.c         | 68 ++++++++-----------------------------
 arch/sparc/mm/init_64.c             |  5 ++-
 5 files changed, 27 insertions(+), 59 deletions(-)

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
index cb841a3..ff3f9f9 100644
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
index ba52e64..cafb5ca 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -131,23 +131,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
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
 
@@ -155,19 +145,13 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
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
@@ -175,67 +159,43 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
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
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 14bb0d5..2d94fed 100644
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
2.6.4

