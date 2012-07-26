From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:14 +0000
Subject: [PATCH 04/18] sparc32: use void * in nocache get/free
Message-Id: <1343336548-3879-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This allowed to us to kill a lot of casts,
with no loss of readability in any places

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgalloc_32.h |   16 ++++----
 arch/sparc/mm/srmmu.c               |   61 +++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index e5b169b..bf20809 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -18,8 +18,8 @@ extern struct pgtable_cache_struct {
 	unsigned long pgd_cache_sz;
 } pgt_quicklists;
 
-unsigned long srmmu_get_nocache(int size, int align);
-void srmmu_free_nocache(unsigned long vaddr, int size);
+void *srmmu_get_nocache(int size, int align);
+void srmmu_free_nocache(void *addr, int size);
 
 #define pgd_quicklist           (pgt_quicklists.pgd_cache)
 #define pmd_quicklist           ((unsigned long *)0)
@@ -32,7 +32,7 @@ void srmmu_free_nocache(unsigned long vaddr, int size);
 pgd_t *get_pgd_fast(void);
 static inline void free_pgd_fast(pgd_t *pgd)
 {
-	srmmu_free_nocache((unsigned long)pgd, SRMMU_PGD_TABLE_SIZE);
+	srmmu_free_nocache(pgd, SRMMU_PGD_TABLE_SIZE);
 }
 
 #define pgd_free(mm, pgd)	free_pgd_fast(pgd)
@@ -50,13 +50,13 @@ static inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm,
 				   unsigned long address)
 {
-	return (pmd_t *)srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
-					  SRMMU_PMD_TABLE_SIZE);
+	return srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
+				 SRMMU_PMD_TABLE_SIZE);
 }
 
 static inline void free_pmd_fast(pmd_t * pmd)
 {
-	srmmu_free_nocache((unsigned long)pmd, SRMMU_PMD_TABLE_SIZE);
+	srmmu_free_nocache(pmd, SRMMU_PMD_TABLE_SIZE);
 }
 
 #define pmd_free(mm, pmd)		free_pmd_fast(pmd)
@@ -73,13 +73,13 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address);
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return (pte_t *)srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
+	return srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 }
 
 
 static inline void free_pte_fast(pte_t *pte)
 {
-	srmmu_free_nocache((unsigned long)pte, PTE_SIZE);
+	srmmu_free_nocache(pte, PTE_SIZE);
 }
 
 #define pte_free_kernel(mm, pte)	free_pte_fast(pte)
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 4b00f69..146742b 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -151,49 +151,55 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
  * align: bytes, number to align at.
  * Returns the virtual address of the allocated area.
  */
-static unsigned long __srmmu_get_nocache(int size, int align)
+static void *__srmmu_get_nocache(int size, int align)
 {
 	int offset;
+	unsigned long addr;
 
 	if (size < SRMMU_NOCACHE_BITMAP_SHIFT) {
-		printk("Size 0x%x too small for nocache request\n", size);
+		printk(KERN_ERR "Size 0x%x too small for nocache request\n",
+		       size);
 		size = SRMMU_NOCACHE_BITMAP_SHIFT;
 	}
-	if (size & (SRMMU_NOCACHE_BITMAP_SHIFT-1)) {
-		printk("Size 0x%x unaligned int nocache request\n", size);
-		size += SRMMU_NOCACHE_BITMAP_SHIFT-1;
+	if (size & (SRMMU_NOCACHE_BITMAP_SHIFT - 1)) {
+		printk(KERN_ERR "Size 0x%x unaligned int nocache request\n",
+		       size);
+		size += SRMMU_NOCACHE_BITMAP_SHIFT - 1;
 	}
 	BUG_ON(align > SRMMU_NOCACHE_ALIGN_MAX);
 
 	offset = bit_map_string_get(&srmmu_nocache_map,
-					size >> SRMMU_NOCACHE_BITMAP_SHIFT,
-					align >> SRMMU_NOCACHE_BITMAP_SHIFT);
+				    size >> SRMMU_NOCACHE_BITMAP_SHIFT,
+				    align >> SRMMU_NOCACHE_BITMAP_SHIFT);
 	if (offset = -1) {
-		printk("srmmu: out of nocache %d: %d/%d\n",
-		    size, (int) srmmu_nocache_size,
-		    srmmu_nocache_map.used << SRMMU_NOCACHE_BITMAP_SHIFT);
+		printk(KERN_ERR "srmmu: out of nocache %d: %d/%d\n",
+		       size, (int) srmmu_nocache_size,
+		       srmmu_nocache_map.used << SRMMU_NOCACHE_BITMAP_SHIFT);
 		return 0;
 	}
 
-	return (SRMMU_NOCACHE_VADDR + (offset << SRMMU_NOCACHE_BITMAP_SHIFT));
+	addr = SRMMU_NOCACHE_VADDR + (offset << SRMMU_NOCACHE_BITMAP_SHIFT);
+	return (void *)addr;
 }
 
-unsigned long srmmu_get_nocache(int size, int align)
+void *srmmu_get_nocache(int size, int align)
 {
-	unsigned long tmp;
+	void *tmp;
 
 	tmp = __srmmu_get_nocache(size, align);
 
 	if (tmp)
-		memset((void *)tmp, 0, size);
+		memset(tmp, 0, size);
 
 	return tmp;
 }
 
-void srmmu_free_nocache(unsigned long vaddr, int size)
+void srmmu_free_nocache(void *addr, int size)
 {
+	unsigned long vaddr;
 	int offset;
 
+	vaddr = (unsigned long)addr;
 	if (vaddr < SRMMU_NOCACHE_VADDR) {
 		printk("Vaddr %lx is smaller than nocache base 0x%lx\n",
 		    vaddr, (unsigned long)SRMMU_NOCACHE_VADDR);
@@ -271,7 +277,7 @@ static void __init srmmu_nocache_init(void)
 	srmmu_nocache_bitmap = __alloc_bootmem(bitmap_bits >> 3, SMP_CACHE_BYTES, 0UL);
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
-	srmmu_swapper_pg_dir = (pgd_t *)__srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
+	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
 	memset(__nocache_fix(srmmu_swapper_pg_dir), 0, SRMMU_PGD_TABLE_SIZE);
 	init_mm.pgd = srmmu_swapper_pg_dir;
 
@@ -304,7 +310,7 @@ pgd_t *get_pgd_fast(void)
 {
 	pgd_t *pgd = NULL;
 
-	pgd = (pgd_t *)__srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
+	pgd = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
 	if (pgd) {
 		pgd_t *init = pgd_offset_k(0);
 		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
@@ -344,8 +350,9 @@ void pte_free(struct mm_struct *mm, pgtable_t pte)
 	if (p = 0)
 		BUG();
 	p = page_to_pfn(pte) << PAGE_SHIFT;	/* Physical address */
-	p = (unsigned long) __nocache_va(p);	/* Nocached virtual */
-	srmmu_free_nocache(p, PTE_SIZE);
+
+	/* free non cached virtual address*/
+	srmmu_free_nocache(__nocache_va(p), PTE_SIZE);
 }
 
 /*
@@ -593,7 +600,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 	while (start < end) {
 		pgdp = pgd_offset_k(start);
 		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
-			pmdp = (pmd_t *) __srmmu_get_nocache(
+			pmdp = __srmmu_get_nocache(
 			    SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
@@ -602,7 +609,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 		}
 		pmdp = pmd_offset(__nocache_fix(pgdp), start);
 		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
-			ptep = (pte_t *)__srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
+			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
 			memset(__nocache_fix(ptep), 0, PTE_SIZE);
@@ -624,7 +631,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 	while (start < end) {
 		pgdp = pgd_offset_k(start);
 		if (pgd_none(*pgdp)) {
-			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
+			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
 			memset(pmdp, 0, SRMMU_PMD_TABLE_SIZE);
@@ -632,7 +639,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 		}
 		pmdp = pmd_offset(pgdp, start);
 		if (srmmu_pmd_none(*pmdp)) {
-			ptep = (pte_t *) __srmmu_get_nocache(PTE_SIZE,
+			ptep = __srmmu_get_nocache(PTE_SIZE,
 							     PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
@@ -707,7 +714,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			continue;
 		}
 		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
-			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
+			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
@@ -715,7 +722,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		}
 		pmdp = pmd_offset(__nocache_fix(pgdp), start);
 		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
-			ptep = (pte_t *)__srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
+			ptep = __srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
 			memset(__nocache_fix(ptep), 0, PTE_SIZE);
@@ -831,11 +838,11 @@ void __init srmmu_paging_init(void)
 
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
-	srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM - PAGE_SIZE));
 	map_kernel();
 
 	/* ctx table has to be physically aligned to its size */
-	srmmu_context_table = (ctxd_t *)__srmmu_get_nocache(num_contexts*sizeof(ctxd_t), num_contexts*sizeof(ctxd_t));
+	srmmu_context_table = __srmmu_get_nocache(num_contexts * sizeof(ctxd_t), num_contexts * sizeof(ctxd_t));
 	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa((unsigned long)srmmu_context_table);
 
 	for (i = 0; i < num_contexts; i++)
-- 
1.6.0.6

