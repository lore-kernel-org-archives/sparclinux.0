From: Will Deacon <will@kernel.org>
Date: Tue, 24 Mar 2020 10:40:04 +0000
Subject: [PATCH 3/4] sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
Message-Id: <20200324104005.11279-4-will@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200324104005.11279-1-will@kernel.org>
In-Reply-To: <20200324104005.11279-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Matt Fleming <matt@codeblueprint.co.uk>, sparclinux@vger.kernel.org

Change the 'pgtable_t' type for sparc32 so that it represents the uncached
virtual address of the PTE table, rather than the underlying 'struct page'.

This allows us to free page table allocations smaller than a page.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/include/asm/page_32.h    |  2 +-
 arch/sparc/include/asm/pgalloc_32.h |  6 +++---
 arch/sparc/include/asm/pgtable_32.h | 11 +++++++++++
 arch/sparc/mm/srmmu.c               | 29 +++++++++--------------------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index e76e6c006e10..721fa99abc73 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -106,7 +106,7 @@ typedef unsigned long iopgprot_t;
 
 #endif
 
-typedef struct page *pgtable_t;
+typedef pte_t *pgtable_t;
 
 #define TASK_UNMAPPED_BASE	0x50000000
 
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 99c032424946..b772384871e9 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -50,11 +50,11 @@ static inline void free_pmd_fast(pmd_t * pmd)
 #define pmd_free(mm, pmd)		free_pmd_fast(pmd)
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
 
-void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep);
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
+#define pmd_pgtable(pmd)		(pgtable_t)__pmd_page(pmd)
 
 void pmd_set(pmd_t *pmdp, pte_t *ptep);
-#define pmd_populate_kernel(MM, PMD, PTE) pmd_set(PMD, PTE)
+#define pmd_populate_kernel		pmd_populate
 
 pgtable_t pte_alloc_one(struct mm_struct *mm);
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 785dc9a95e70..03f4b84dc8fd 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -135,6 +135,17 @@ static inline struct page *pmd_page(pmd_t pmd)
 	return pfn_to_page((pmd_val(pmd) & SRMMU_PTD_PMASK) >> (PAGE_SHIFT-4));
 }
 
+static inline unsigned long __pmd_page(pmd_t pmd)
+{
+	unsigned long v;
+
+	if (srmmu_device_memory(pmd_val(pmd)))
+		BUG();
+
+	v = pmd_val(pmd) & SRMMU_PTD_PMASK;
+	return (unsigned long)__nocache_va(v << 4);
+}
+
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	if (srmmu_device_memory(pud_val(pud))) {
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 7fa096422bd0..dfd883b53054 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -140,12 +140,6 @@ void pmd_set(pmd_t *pmdp, pte_t *ptep)
 	set_pte((pte_t *)&pmd_val(*pmdp), __pte(SRMMU_ET_PTD | ptp));
 }
 
-void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
-{
-	unsigned long ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4); /* watch for overflow */
-	set_pte((pte_t *)&pmd_val(*pmdp), __pte(SRMMU_ET_PTD | ptp));
-}
-
 /* Find an entry in the third-level page table.. */
 pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
 {
@@ -364,31 +358,26 @@ pgd_t *get_pgd_fast(void)
  */
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	unsigned long pte;
+	pte_t *ptep;
 	struct page *page;
 
-	if ((pte = (unsigned long)pte_alloc_one_kernel(mm)) = 0)
+	if ((ptep = pte_alloc_one_kernel(mm)) = 0)
 		return NULL;
-	page = pfn_to_page(__nocache_pa(pte) >> PAGE_SHIFT);
+	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	if (!pgtable_pte_page_ctor(page)) {
 		__free_page(page);
 		return NULL;
 	}
-	return page;
+	return ptep;
 }
 
-void pte_free(struct mm_struct *mm, pgtable_t pte)
+void pte_free(struct mm_struct *mm, pgtable_t ptep)
 {
-	unsigned long p;
-
-	pgtable_pte_page_dtor(pte);
-	p = (unsigned long)page_address(pte);	/* Cached address (for test) */
-	if (p = 0)
-		BUG();
-	p = page_to_pfn(pte) << PAGE_SHIFT;	/* Physical address */
+	struct page *page;
 
-	/* free non cached virtual address*/
-	srmmu_free_nocache(__nocache_va(p), SRMMU_PTE_TABLE_SIZE);
+	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
+	pgtable_pte_page_dtor(page);
+	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
 }
 
 /* context handling - a dynamically sized pool is used */
-- 
2.20.1
