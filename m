From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 20:43:35 +0000
Subject: [PATCH] sparc32: Un-btfixup set_pte, pte_present, mk_pte{_phys,_io}().
Message-Id: <20120512.164335.288317679596395929.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |   50 +++++++++++++++++++----------------
 arch/sparc/mm/srmmu.c               |   35 +++++-------------------
 2 files changed, 33 insertions(+), 52 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index ac85f9b..62e34d9 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -113,11 +113,18 @@ static inline unsigned long srmmu_swap(unsigned long *addr, unsigned long value)
 	return value;
 }
 
-static inline void srmmu_set_pte(pte_t *ptep, pte_t pteval)
+/* Certain architectures need to do special things when pte's
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+
+static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
 	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
 }
 
+#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+
 static inline int srmmu_device_memory(unsigned long x)
 {
 	return ((x & 0xF0000000) != 0);
@@ -134,18 +141,19 @@ BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page_vaddr, pgd_t)
 
 #define pgd_page_vaddr(pgd) BTFIXUP_CALL(pgd_page_vaddr)(pgd)
 
-BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
+static inline int pte_present(pte_t pte)
+{
+	return ((pte_val(pte) & SRMMU_ET_MASK) = SRMMU_ET_PTE);
+}
 
 static inline int pte_none(pte_t pte)
 {
 	return !pte_val(pte);
 }
 
-#define pte_present(pte) BTFIXUP_CALL(pte_present)(pte)
-
 static inline void __pte_clear(pte_t *ptep)
 {
-	srmmu_set_pte(ptep, __pte(0));
+	set_pte(ptep, __pte(0));
 }
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
@@ -172,7 +180,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 {
 	int i;
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++)
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(0));
+		set_pte((pte_t *)&pmdp->pmdv[i], __pte(0));
 }
 
 static inline int pgd_none(pgd_t pgd)          
@@ -192,7 +200,7 @@ static inline int pgd_present(pgd_t pgd)
 
 static inline void pgd_clear(pgd_t *pgdp)
 {
-	srmmu_set_pte((pte_t *)pgdp, __pte(0));
+	set_pte((pte_t *)pgdp, __pte(0));
 }
 
 /*
@@ -292,14 +300,20 @@ static inline unsigned long pte_pfn(pte_t pte)
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
-BTFIXUPDEF_CALL_CONST(pte_t, mk_pte, struct page *, pgprot_t)
+static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
+{
+	return __pte((page_to_pfn(page) << (PAGE_SHIFT-4)) | pgprot_val(pgprot));
+}
 
-BTFIXUPDEF_CALL_CONST(pte_t, mk_pte_phys, unsigned long, pgprot_t)
-BTFIXUPDEF_CALL_CONST(pte_t, mk_pte_io, unsigned long, pgprot_t, int)
+static inline pte_t mk_pte_phys(unsigned long page, pgprot_t pgprot)
+{
+	return __pte(((page) >> 4) | pgprot_val(pgprot));
+}
 
-#define mk_pte(page,pgprot) BTFIXUP_CALL(mk_pte)(page,pgprot)
-#define mk_pte_phys(page,pgprot) BTFIXUP_CALL(mk_pte_phys)(page,pgprot)
-#define mk_pte_io(page,pgprot,space) BTFIXUP_CALL(mk_pte_io)(page,pgprot,space)
+static inline pte_t mk_pte_io(unsigned long page, pgprot_t pgprot, int space)
+{
+	return __pte(((page) >> 4) | (space << 28) | pgprot_val(pgprot));
+}
 
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t prot)
@@ -339,16 +353,6 @@ BTFIXUPDEF_CALL(pte_t *, pte_offset_kernel, pmd_t *, unsigned long)
 #define pte_offset_map(d, a)		pte_offset_kernel(d,a)
 #define pte_unmap(pte)		do{}while(0)
 
-/* Certain architectures need to do special things when pte's
- * within a page table are directly modified.  Thus, the following
- * hook is made available.
- */
-
-BTFIXUPDEF_CALL(void, set_pte, pte_t *, pte_t)
-
-#define set_pte(ptep,pteval) BTFIXUP_CALL(set_pte)(ptep,pteval)
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
 struct seq_file;
 BTFIXUPDEF_CALL(void, mmu_info, struct seq_file *)
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 71abcc5..224db00 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -116,9 +116,6 @@ static inline unsigned long srmmu_pgd_page(pgd_t pgd)
 static inline int srmmu_pte_none(pte_t pte)
 { return !(pte_val(pte) & 0xFFFFFFF); }
 
-static inline int srmmu_pte_present(pte_t pte)
-{ return ((pte_val(pte) & SRMMU_ET_MASK) = SRMMU_ET_PTE); }
-
 static inline int srmmu_pmd_none(pmd_t pmd)
 { return !(pmd_val(pmd) & 0xFFFFFFF); }
 
@@ -140,25 +137,12 @@ static inline pte_t srmmu_pte_mkdirty(pte_t pte)
 static inline pte_t srmmu_pte_mkyoung(pte_t pte)
 { return __pte(pte_val(pte) | SRMMU_REF);}
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-static pte_t srmmu_mk_pte(struct page *page, pgprot_t pgprot)
-{ return __pte((page_to_pfn(page) << (PAGE_SHIFT-4)) | pgprot_val(pgprot)); }
-
-static pte_t srmmu_mk_pte_phys(unsigned long page, pgprot_t pgprot)
-{ return __pte(((page) >> 4) | pgprot_val(pgprot)); }
-
-static pte_t srmmu_mk_pte_io(unsigned long page, pgprot_t pgprot, int space)
-{ return __pte(((page) >> 4) | (space << 28) | pgprot_val(pgprot)); }
-
 /* XXX should we hyper_flush_whole_icache here - Anton */
 static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
-{ srmmu_set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
+{ set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
 
 static inline void srmmu_pgd_set(pgd_t * pgdp, pmd_t * pmdp)
-{ srmmu_set_pte((pte_t *)pgdp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pmdp) >> 4))); }
+{ set_pte((pte_t *)pgdp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pmdp) >> 4))); }
 
 static void srmmu_pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
@@ -167,7 +151,7 @@ static void srmmu_pmd_set(pmd_t *pmdp, pte_t *ptep)
 
 	ptp = __nocache_pa((unsigned long) ptep) >> 4;
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
+		set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
 		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
 	}
 }
@@ -179,7 +163,7 @@ static void srmmu_pmd_populate(pmd_t *pmdp, struct page *ptep)
 
 	ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4);	/* watch for overflow */
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
+		set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
 		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
 	}
 }
@@ -369,7 +353,7 @@ static void __init srmmu_nocache_init(void)
 		if (srmmu_cache_pagetables)
 			pteval |= SRMMU_CACHE;
 
-		srmmu_set_pte(__nocache_fix(pte), __pte(pteval));
+		set_pte(__nocache_fix(pte), __pte(pteval));
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;
@@ -534,7 +518,7 @@ static inline void srmmu_mapioaddr(unsigned long physaddr,
 	tmp |= (bus_type << 28);
 	tmp |= SRMMU_PRIV;
 	__flush_page_to_ram(virt_addr);
-	srmmu_set_pte(ptep, __pte(tmp));
+	set_pte(ptep, __pte(tmp));
 }
 
 static void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
@@ -2070,15 +2054,8 @@ void __init load_mmu(void)
 	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4md, BTFIXUPCALL_SWAPG1G2);
 #endif
 
-	BTFIXUPSET_CALL(set_pte, srmmu_set_pte, BTFIXUPCALL_SWAPO0O1);
-
 	BTFIXUPSET_CALL(pgd_page_vaddr, srmmu_pgd_page, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(pte_present, srmmu_pte_present, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(mk_pte, srmmu_mk_pte, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mk_pte_phys, srmmu_mk_pte_phys, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mk_pte_io, srmmu_mk_pte_io, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pgd_set, srmmu_pgd_set, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_set, srmmu_pmd_set, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_populate, srmmu_pmd_populate, BTFIXUPCALL_NORM);
-- 
1.7.10

