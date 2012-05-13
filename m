From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 08:24:27 +0000
Subject: [PATCH 1/2] sparc32: drop btfixup in pgalloc_32.h
Message-Id: <20120513082427.GA16943@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From c831af7a9f45757cc7b11fd41af8afb86e237de6 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 08:40:27 +0200
Subject: [PATCH 1/2] sparc32: drop btfixup in pgalloc_32.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgalloc_32.h |   73 +++++++++++++++++++++++-----------
 arch/sparc/mm/srmmu.c               |   71 +++++++---------------------------
 2 files changed, 63 insertions(+), 81 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index d7ec897..47bf660 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -4,8 +4,11 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 
-#include <asm/page.h>
+#include <asm/pgtsrmmu.h>
 #include <asm/btfixup.h>
+#include <asm/pgtable.h>
+#include <asm/vaddrs.h>
+#include <asm/page.h>
 
 struct page;
 
@@ -15,6 +18,10 @@ extern struct pgtable_cache_struct {
 	unsigned long pgtable_cache_sz;
 	unsigned long pgd_cache_sz;
 } pgt_quicklists;
+
+unsigned long srmmu_get_nocache(int size, int align);
+void srmmu_free_nocache(unsigned long vaddr, int size);
+
 #define pgd_quicklist           (pgt_quicklists.pgd_cache)
 #define pmd_quicklist           ((unsigned long *)0)
 #define pte_quicklist           (pgt_quicklists.pte_cache)
@@ -23,44 +30,62 @@ extern struct pgtable_cache_struct {
 
 #define check_pgt_cache()	do { } while (0)
 
-BTFIXUPDEF_CALL(pgd_t *, get_pgd_fast, void)
-#define get_pgd_fast()		BTFIXUP_CALL(get_pgd_fast)()
-
-BTFIXUPDEF_CALL(void, free_pgd_fast, pgd_t *)
-#define free_pgd_fast(pgd)	BTFIXUP_CALL(free_pgd_fast)(pgd)
+pgd_t *get_pgd_fast(void);
+static inline void free_pgd_fast(pgd_t *pgd)
+{
+	srmmu_free_nocache((unsigned long)pgd, SRMMU_PGD_TABLE_SIZE);
+}
 
 #define pgd_free(mm, pgd)	free_pgd_fast(pgd)
 #define pgd_alloc(mm)	get_pgd_fast()
 
-BTFIXUPDEF_CALL(void, pgd_set, pgd_t *, pmd_t *)
-#define pgd_set(pgdp,pmdp) BTFIXUP_CALL(pgd_set)(pgdp,pmdp)
+static inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
+{
+	unsigned long pa = __nocache_pa((unsigned long)pmdp);
+
+	set_pte((pte_t *)pgdp, (SRMMU_ET_PTD | (pa >> 4)));
+}
+
 #define pgd_populate(MM, PGD, PMD)      pgd_set(PGD, PMD)
 
-BTFIXUPDEF_CALL(pmd_t *, pmd_alloc_one, struct mm_struct *, unsigned long)
-#define pmd_alloc_one(mm, address)	BTFIXUP_CALL(pmd_alloc_one)(mm, address)
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm,
+				   unsigned long address)
+{
+	return (pmd_t *)srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
+					  SRMMU_PMD_TABLE_SIZE);
+}
 
-BTFIXUPDEF_CALL(void, free_pmd_fast, pmd_t *)
-#define free_pmd_fast(pmd)	BTFIXUP_CALL(free_pmd_fast)(pmd)
+static inline void free_pmd_fast(pmd_t * pmd)
+{
+	srmmu_free_nocache((unsigned long)pmd, SRMMU_PMD_TABLE_SIZE);
+}
 
 #define pmd_free(mm, pmd)		free_pmd_fast(pmd)
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
 
-BTFIXUPDEF_CALL(void, pmd_populate, pmd_t *, struct page *)
-#define pmd_populate(MM, PMD, PTE)        BTFIXUP_CALL(pmd_populate)(PMD, PTE)
+void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep);
 #define pmd_pgtable(pmd) pmd_page(pmd)
-BTFIXUPDEF_CALL(void, pmd_set, pmd_t *, pte_t *)
-#define pmd_populate_kernel(MM, PMD, PTE) BTFIXUP_CALL(pmd_set)(PMD, PTE)
 
-BTFIXUPDEF_CALL(pgtable_t , pte_alloc_one, struct mm_struct *, unsigned long)
-#define pte_alloc_one(mm, address)	BTFIXUP_CALL(pte_alloc_one)(mm, address)
-BTFIXUPDEF_CALL(pte_t *, pte_alloc_one_kernel, struct mm_struct *, unsigned long)
-#define pte_alloc_one_kernel(mm, addr)	BTFIXUP_CALL(pte_alloc_one_kernel)(mm, addr)
+void pmd_set(pmd_t *pmdp, pte_t *ptep);
+#define pmd_populate_kernel(MM, PMD, PTE) pmd_set(PMD, PTE)
+
+pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+					  unsigned long address)
+{
+	return (pte_t *)srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
+}
+
+
+static inline void free_pte_fast(pte_t *pte)
+{
+	srmmu_free_nocache((unsigned long)pte, PTE_SIZE);
+}
 
-BTFIXUPDEF_CALL(void, free_pte_fast, pte_t *)
-#define pte_free_kernel(mm, pte)	BTFIXUP_CALL(free_pte_fast)(pte)
+#define pte_free_kernel(mm, pte)	free_pte_fast(pte)
 
-BTFIXUPDEF_CALL(void, pte_free, pgtable_t )
-#define pte_free(mm, pte)		BTFIXUP_CALL(pte_free)(pte)
+void pte_free(struct mm_struct * mm, pgtable_t pte);
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
 
 #endif /* _SPARC_PGALLOC_H */
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 54efa92..d9487d8 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -132,10 +132,7 @@ static inline pte_t srmmu_pte_mkold(pte_t pte)
 static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
 { set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
 
-static inline void srmmu_pgd_set(pgd_t * pgdp, pmd_t * pmdp)
-{ set_pte((pte_t *)pgdp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pmdp) >> 4))); }
-
-static void srmmu_pmd_set(pmd_t *pmdp, pte_t *ptep)
+void pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
 	unsigned long ptp;	/* Physical address, shifted right by 4 */
 	int i;
@@ -147,7 +144,7 @@ static void srmmu_pmd_set(pmd_t *pmdp, pte_t *ptep)
 	}
 }
 
-static void srmmu_pmd_populate(pmd_t *pmdp, struct page *ptep)
+void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
 {
 	unsigned long ptp;	/* Physical address, shifted right by 4 */
 	int i;
@@ -232,7 +229,7 @@ static unsigned long __srmmu_get_nocache(int size, int align)
 	return (SRMMU_NOCACHE_VADDR + (offset << SRMMU_NOCACHE_BITMAP_SHIFT));
 }
 
-static unsigned long srmmu_get_nocache(int size, int align)
+unsigned long srmmu_get_nocache(int size, int align)
 {
 	unsigned long tmp;
 
@@ -244,7 +241,7 @@ static unsigned long srmmu_get_nocache(int size, int align)
 	return tmp;
 }
 
-static void srmmu_free_nocache(unsigned long vaddr, int size)
+void srmmu_free_nocache(unsigned long vaddr, int size)
 {
 	int offset;
 
@@ -354,7 +351,7 @@ static void __init srmmu_nocache_init(void)
 	flush_tlb_all();
 }
 
-static inline pgd_t *srmmu_get_pgd_fast(void)
+pgd_t *get_pgd_fast(void)
 {
 	pgd_t *pgd = NULL;
 
@@ -369,21 +366,6 @@ static inline pgd_t *srmmu_get_pgd_fast(void)
 	return pgd;
 }
 
-static void srmmu_free_pgd_fast(pgd_t *pgd)
-{
-	srmmu_free_nocache((unsigned long)pgd, SRMMU_PGD_TABLE_SIZE);
-}
-
-static pmd_t *srmmu_pmd_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	return (pmd_t *)srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
-}
-
-static void srmmu_pmd_free(pmd_t * pmd)
-{
-	srmmu_free_nocache((unsigned long)pmd, SRMMU_PMD_TABLE_SIZE);
-}
-
 /*
  * Hardware needs alignment to 256 only, but we align to whole page size
  * to reduce fragmentation problems due to the buddy principle.
@@ -392,31 +374,19 @@ static void srmmu_pmd_free(pmd_t * pmd)
  * Alignments up to the page size are the same for physical and virtual
  * addresses of the nocache area.
  */
-static pte_t *
-srmmu_pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
-{
-	return (pte_t *)srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
-}
-
-static pgtable_t
-srmmu_pte_alloc_one(struct mm_struct *mm, unsigned long address)
+pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long pte;
 	struct page *page;
 
-	if ((pte = (unsigned long)srmmu_pte_alloc_one_kernel(mm, address)) = 0)
+	if ((pte = (unsigned long)pte_alloc_one_kernel(mm, address)) = 0)
 		return NULL;
 	page = pfn_to_page( __nocache_pa(pte) >> PAGE_SHIFT );
 	pgtable_page_ctor(page);
 	return page;
 }
 
-static void srmmu_free_pte_fast(pte_t *pte)
-{
-	srmmu_free_nocache((unsigned long)pte, PTE_SIZE);
-}
-
-static void srmmu_pte_free(pgtable_t pte)
+void pte_free(struct mm_struct *mm, pgtable_t pte)
 {
 	unsigned long p;
 
@@ -977,7 +947,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
-			srmmu_pgd_set(__nocache_fix(pgdp), pmdp);
+			pgd_set(__nocache_fix(pgdp), pmdp);
 		}
 		pmdp = srmmu_pmd_offset(__nocache_fix(pgdp), start);
 		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
@@ -985,7 +955,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
 			memset(__nocache_fix(ptep), 0, PTE_SIZE);
-			srmmu_pmd_set(__nocache_fix(pmdp), ptep);
+			pmd_set(__nocache_fix(pmdp), ptep);
 		}
 		if (start > (0xffffffffUL - PMD_SIZE))
 			break;
@@ -1007,7 +977,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
 			memset(pmdp, 0, SRMMU_PMD_TABLE_SIZE);
-			srmmu_pgd_set(pgdp, pmdp);
+			pgd_set(pgdp, pmdp);
 		}
 		pmdp = srmmu_pmd_offset(pgdp, start);
 		if(srmmu_pmd_none(*pmdp)) {
@@ -1016,7 +986,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
 			memset(ptep, 0, PTE_SIZE);
-			srmmu_pmd_set(pmdp, ptep);
+			pmd_set(pmdp, ptep);
 		}
 		if (start > (0xffffffffUL - PMD_SIZE))
 			break;
@@ -1073,7 +1043,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
-			srmmu_pgd_set(__nocache_fix(pgdp), pmdp);
+			pgd_set(__nocache_fix(pgdp), pmdp);
 		}
 		pmdp = srmmu_pmd_offset(__nocache_fix(pgdp), start);
 		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
@@ -1082,7 +1052,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
 			memset(__nocache_fix(ptep), 0, PTE_SIZE);
-			srmmu_pmd_set(__nocache_fix(pmdp), ptep);
+			pmd_set(__nocache_fix(pmdp), ptep);
 		}
 		if(what = 1) {
 			/*
@@ -2047,23 +2017,10 @@ void __init load_mmu(void)
 
 	BTFIXUPSET_CALL(pgd_page_vaddr, srmmu_pgd_page, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(pgd_set, srmmu_pgd_set, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_set, srmmu_pmd_set, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_populate, srmmu_pmd_populate, BTFIXUPCALL_NORM);
-	
 	BTFIXUPSET_INT(pte_modify_mask, SRMMU_CHG_MASK);
 	BTFIXUPSET_CALL(pmd_offset, srmmu_pmd_offset, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pte_offset_kernel, srmmu_pte_offset, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(free_pte_fast, srmmu_free_pte_fast, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pte_free, srmmu_pte_free, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pte_alloc_one_kernel, srmmu_pte_alloc_one_kernel, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pte_alloc_one, srmmu_pte_alloc_one, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(free_pmd_fast, srmmu_pmd_free, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_alloc_one, srmmu_pmd_alloc_one, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(free_pgd_fast, srmmu_free_pgd_fast, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(get_pgd_fast, srmmu_get_pgd_fast, BTFIXUPCALL_NORM);
-
 	BTFIXUPSET_CALL(update_mmu_cache, srmmu_update_mmu_cache, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(destroy_context, srmmu_destroy_context, BTFIXUPCALL_NORM);
 
-- 
1.6.0.6

