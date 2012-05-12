From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 19:31:06 +0000
Subject: [PATCH] sparc32: Un-btfixup {pte,pmd,pgd}_clear().
Message-Id: <20120512.153106.256761696135937288.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Also we can remove BTFIXUPCALL_SWAPO0G0 as that is no longer
used.

This was rather amusing, we were setting the btfixup vectors
based upon cpu type but all to the same exact generic srmmu
routines.

Furthermore, we were inconsistently marking the fixup as
either BTFIXUPCALL_SWAPO0G0 or BTFIXUPCALL_NORM.

What a mess, glad we could untangle this stuff.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/btfixup.h    |    1 -
 arch/sparc/include/asm/pgtable_32.h |   44 ++++++++++++++++++++++++++++++-----
 arch/sparc/mm/srmmu.c               |   43 +---------------------------------
 3 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/arch/sparc/include/asm/btfixup.h b/arch/sparc/include/asm/btfixup.h
index 797722c..48b0141 100644
--- a/arch/sparc/include/asm/btfixup.h
+++ b/arch/sparc/include/asm/btfixup.h
@@ -120,7 +120,6 @@ extern unsigned int ___illegal_use_of_BTFIXUP_INT_in_module(void);
 #define BTFIXUPCALL_RETO0	0x01000000			/* Return first parameter, actually a nop */
 #define BTFIXUPCALL_ANDNINT(i)	(0x902a2000|((i) & 0x1fff))	/* Possibly optimize to andn %o0, i, %o0 */
 #define BTFIXUPCALL_SWAPO0O1	0xd27a0000			/* Possibly optimize to swap [%o0],%o1 */
-#define BTFIXUPCALL_SWAPO0G0	0xc07a0000			/* Possibly optimize to swap [%o0],%g0 */
 #define BTFIXUPCALL_SWAPG1G2	0xc4784000			/* Possibly optimize to swap [%g1],%g2 */
 #define BTFIXUPCALL_STG0O0	0xc0220000			/* Possibly optimize to st %g0,[%o0] */
 #define BTFIXUPCALL_STO1O0	0xd2220000			/* Possibly optimize to st %o1,[%o0] */
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 2271185..144ab31 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -119,6 +119,22 @@ extern unsigned long empty_zero_page;
 #define ZERO_PAGE(vaddr) (virt_to_page(&empty_zero_page))
 
 /*
+ * In general all page table modifications should use the V8 atomic
+ * swap instruction.  This insures the mmu and the cpu are in sync
+ * with respect to ref/mod bits in the page tables.
+ */
+static inline unsigned long srmmu_swap(unsigned long *addr, unsigned long value)
+{
+	__asm__ __volatile__("swap [%2], %0" : "=&r" (value) : "0" (value), "r" (addr));
+	return value;
+}
+
+static inline void srmmu_set_pte(pte_t *ptep, pte_t pteval)
+{
+	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
+}
+
+/*
  */
 BTFIXUPDEF_CALL_CONST(struct page *, pmd_page, pmd_t)
 BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page_vaddr, pgd_t)
@@ -127,7 +143,6 @@ BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page_vaddr, pgd_t)
 #define pgd_page_vaddr(pgd) BTFIXUP_CALL(pgd_page_vaddr)(pgd)
 
 BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
-BTFIXUPDEF_CALL(void, pte_clear, pte_t *)
 
 static inline int pte_none(pte_t pte)
 {
@@ -135,11 +150,19 @@ static inline int pte_none(pte_t pte)
 }
 
 #define pte_present(pte) BTFIXUP_CALL(pte_present)(pte)
-#define pte_clear(mm,addr,pte) BTFIXUP_CALL(pte_clear)(pte)
+
+static inline void __pte_clear(pte_t *ptep)
+{
+	srmmu_set_pte(ptep, __pte(0));
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	__pte_clear(ptep);
+}
 
 BTFIXUPDEF_CALL_CONST(int, pmd_bad, pmd_t)
 BTFIXUPDEF_CALL_CONST(int, pmd_present, pmd_t)
-BTFIXUPDEF_CALL(void, pmd_clear, pmd_t *)
 
 static inline int pmd_none(pmd_t pmd)
 {
@@ -148,17 +171,26 @@ static inline int pmd_none(pmd_t pmd)
 
 #define pmd_bad(pmd) BTFIXUP_CALL(pmd_bad)(pmd)
 #define pmd_present(pmd) BTFIXUP_CALL(pmd_present)(pmd)
-#define pmd_clear(pmd) BTFIXUP_CALL(pmd_clear)(pmd)
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	int i;
+	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++)
+		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(0));
+}
 
 BTFIXUPDEF_CALL_CONST(int, pgd_none, pgd_t)
 BTFIXUPDEF_CALL_CONST(int, pgd_bad, pgd_t)
 BTFIXUPDEF_CALL_CONST(int, pgd_present, pgd_t)
-BTFIXUPDEF_CALL(void, pgd_clear, pgd_t *)
 
 #define pgd_none(pgd) BTFIXUP_CALL(pgd_none)(pgd)
 #define pgd_bad(pgd) BTFIXUP_CALL(pgd_bad)(pgd)
 #define pgd_present(pgd) BTFIXUP_CALL(pgd_present)(pgd)
-#define pgd_clear(pgd) BTFIXUP_CALL(pgd_clear)(pgd)
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	srmmu_set_pte((pte_t *)pgdp, __pte(0));
+}
 
 /*
  * The following only work if pte_present() is true.
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 38fcb83a..29dfabf 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -91,22 +91,6 @@ static DEFINE_SPINLOCK(srmmu_context_spinlock);
 
 static int is_hypersparc;
 
-/*
- * In general all page table modifications should use the V8 atomic
- * swap instruction.  This insures the mmu and the cpu are in sync
- * with respect to ref/mod bits in the page tables.
- */
-static inline unsigned long srmmu_swap(unsigned long *addr, unsigned long value)
-{
-	__asm__ __volatile__("swap [%2], %0" : "=&r" (value) : "0" (value), "r" (addr));
-	return value;
-}
-
-static inline void srmmu_set_pte(pte_t *ptep, pte_t pteval)
-{
-	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
-}
-
 /* The very generic SRMMU page table operations. */
 static inline int srmmu_device_memory(unsigned long x)
 {
@@ -160,9 +144,6 @@ static inline int srmmu_pte_none(pte_t pte)
 static inline int srmmu_pte_present(pte_t pte)
 { return ((pte_val(pte) & SRMMU_ET_MASK) = SRMMU_ET_PTE); }
 
-static inline void srmmu_pte_clear(pte_t *ptep)
-{ srmmu_set_pte(ptep, __pte(0)); }
-
 static inline int srmmu_pmd_none(pmd_t pmd)
 { return !(pmd_val(pmd) & 0xFFFFFFF); }
 
@@ -172,12 +153,6 @@ static inline int srmmu_pmd_bad(pmd_t pmd)
 static inline int srmmu_pmd_present(pmd_t pmd)
 { return ((pmd_val(pmd) & SRMMU_ET_MASK) = SRMMU_ET_PTD); }
 
-static inline void srmmu_pmd_clear(pmd_t *pmdp) {
-	int i;
-	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++)
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(0));
-}
-
 static inline int srmmu_pgd_none(pgd_t pgd)          
 { return !(pgd_val(pgd) & 0xFFFFFFF); }
 
@@ -187,9 +162,6 @@ static inline int srmmu_pgd_bad(pgd_t pgd)
 static inline int srmmu_pgd_present(pgd_t pgd)
 { return ((pgd_val(pgd) & SRMMU_ET_MASK) = SRMMU_ET_PTD); }
 
-static inline void srmmu_pgd_clear(pgd_t * pgdp)
-{ srmmu_set_pte((pte_t *)pgdp, __pte(0)); }
-
 static inline pte_t srmmu_pte_wrprotect(pte_t pte)
 { return __pte(pte_val(pte) & ~SRMMU_WRITE);}
 
@@ -628,7 +600,7 @@ static inline void srmmu_unmapioaddr(unsigned long virt_addr)
 	ptep = srmmu_pte_offset(pmdp, virt_addr);
 
 	/* No need to flush uncacheable page. */
-	srmmu_pte_clear(ptep);
+	__pte_clear(ptep);
 }
 
 static void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len)
@@ -1480,9 +1452,6 @@ static void __init init_hypersparc(void)
 
 	is_hypersparc = 1;
 
-	BTFIXUPSET_CALL(pte_clear, srmmu_pte_clear, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_clear, srmmu_pgd_clear, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_all, hypersparc_flush_cache_all, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_mm, hypersparc_flush_cache_mm, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_range, hypersparc_flush_cache_range, BTFIXUPCALL_NORM);
@@ -1546,9 +1515,6 @@ static void __init init_cypress_common(void)
 {
 	init_vac_layout();
 
-	BTFIXUPSET_CALL(pte_clear, srmmu_pte_clear, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_clear, srmmu_pgd_clear, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_all, cypress_flush_cache_all, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_mm, cypress_flush_cache_mm, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_range, cypress_flush_cache_range, BTFIXUPCALL_NORM);
@@ -1930,10 +1896,6 @@ static void __init init_viking(void)
 		viking_mxcc_present = 0;
 		msi_set_sync();
 
-		BTFIXUPSET_CALL(pte_clear, srmmu_pte_clear, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(pgd_clear, srmmu_pgd_clear, BTFIXUPCALL_NORM);
-
 		/*
 		 * We need this to make sure old viking takes no hits
 		 * on it's cache for dma snoops to workaround the
@@ -2162,16 +2124,13 @@ void __init ld_mmu_srmmu(void)
 	BTFIXUPSET_CALL(pgd_page_vaddr, srmmu_pgd_page, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pte_present, srmmu_pte_present, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pte_clear, srmmu_pte_clear, BTFIXUPCALL_SWAPO0G0);
 
 	BTFIXUPSET_CALL(pmd_bad, srmmu_pmd_bad, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_present, srmmu_pmd_present, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_SWAPO0G0);
 
 	BTFIXUPSET_CALL(pgd_none, srmmu_pgd_none, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pgd_bad, srmmu_pgd_bad, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pgd_present, srmmu_pgd_present, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_clear, srmmu_pgd_clear, BTFIXUPCALL_SWAPO0G0);
 
 	BTFIXUPSET_CALL(mk_pte, srmmu_mk_pte, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mk_pte_phys, srmmu_mk_pte_phys, BTFIXUPCALL_NORM);
-- 
1.7.10

