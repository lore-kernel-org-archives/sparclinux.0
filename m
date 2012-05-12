From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 19:37:25 +0000
Subject: [PATCH] sparc32: Un-btfixup pmd_page and pte_pfn.
Message-Id: <20120512.153725.91998100691970749.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |   31 +++++++++++++++++++++++++------
 arch/sparc/mm/srmmu.c               |   29 -----------------------------
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 144ab31..1c31ef1 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -134,12 +134,20 @@ static inline void srmmu_set_pte(pte_t *ptep, pte_t pteval)
 	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
 }
 
-/*
- */
-BTFIXUPDEF_CALL_CONST(struct page *, pmd_page, pmd_t)
+static inline int srmmu_device_memory(unsigned long x)
+{
+	return ((x & 0xF0000000) != 0);
+}
+
+static inline struct page *pmd_page(pmd_t pmd)
+{
+	if (srmmu_device_memory(pmd_val(pmd)))
+		BUG();
+	return pfn_to_page((pmd_val(pmd) & SRMMU_PTD_PMASK) >> (PAGE_SHIFT-4));
+}
+
 BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page_vaddr, pgd_t)
 
-#define pmd_page(pmd) BTFIXUP_CALL(pmd_page)(pmd)
 #define pgd_page_vaddr(pgd) BTFIXUP_CALL(pgd_page_vaddr)(pgd)
 
 BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
@@ -270,8 +278,19 @@ BTFIXUPDEF_CALL_CONST(pte_t, pte_mkyoung, pte_t)
 
 #define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
 
-BTFIXUPDEF_CALL(unsigned long,	 pte_pfn, pte_t)
-#define pte_pfn(pte) BTFIXUP_CALL(pte_pfn)(pte)
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	if (srmmu_device_memory(pte_val(pte))) {
+		/* Just return something that will cause
+		 * pfn_valid() to return false.  This makes
+		 * copy_one_pte() to just directly copy to
+		 * PTE over.
+		 */
+		return ~0UL;
+	}
+	return (pte_val(pte) & SRMMU_PTE_PMASK) >> (PAGE_SHIFT-4);
+}
+
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
 /*
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 29dfabf..d852962 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -91,12 +91,6 @@ static DEFINE_SPINLOCK(srmmu_context_spinlock);
 
 static int is_hypersparc;
 
-/* The very generic SRMMU page table operations. */
-static inline int srmmu_device_memory(unsigned long x)
-{
-	return ((x & 0xF0000000) != 0);
-}
-
 static int srmmu_cache_pagetables;
 
 /* these will be initialized in srmmu_nocache_calcsize() */
@@ -113,27 +107,6 @@ void *srmmu_nocache_pool;
 void *srmmu_nocache_bitmap;
 static struct bit_map srmmu_nocache_map;
 
-static unsigned long srmmu_pte_pfn(pte_t pte)
-{
-	if (srmmu_device_memory(pte_val(pte))) {
-		/* Just return something that will cause
-		 * pfn_valid() to return false.  This makes
-		 * copy_one_pte() to just directly copy to
-		 * PTE over.
-		 */
-		return ~0UL;
-	}
-	return (pte_val(pte) & SRMMU_PTE_PMASK) >> (PAGE_SHIFT-4);
-}
-
-static struct page *srmmu_pmd_page(pmd_t pmd)
-{
-
-	if (srmmu_device_memory(pmd_val(pmd)))
-		BUG();
-	return pfn_to_page((pmd_val(pmd) & SRMMU_PTD_PMASK) >> (PAGE_SHIFT-4));
-}
-
 static inline unsigned long srmmu_pgd_page(pgd_t pgd)
 { return srmmu_device_memory(pgd_val(pgd))?~0:(unsigned long)__nocache_va((pgd_val(pgd) & SRMMU_PTD_PMASK) << 4); }
 
@@ -2119,8 +2092,6 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(set_pte, srmmu_set_pte, BTFIXUPCALL_SWAPO0O1);
 
-	BTFIXUPSET_CALL(pte_pfn, srmmu_pte_pfn, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_page, srmmu_pmd_page, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pgd_page_vaddr, srmmu_pgd_page, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pte_present, srmmu_pte_present, BTFIXUPCALL_NORM);
-- 
1.7.10

