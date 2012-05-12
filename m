From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 20:17:36 +0000
Subject: [PATCH] sparc32: Un-btfixup pgd_{none,bad,present}.
Message-Id: <20120512.161736.1387517512046483217.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |   19 +++++++++++++------
 arch/sparc/mm/srmmu.c               |   19 +++----------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index c0e4d73..9b4ff5a 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -171,13 +171,20 @@ static inline void pmd_clear(pmd_t *pmdp)
 		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(0));
 }
 
-BTFIXUPDEF_CALL_CONST(int, pgd_none, pgd_t)
-BTFIXUPDEF_CALL_CONST(int, pgd_bad, pgd_t)
-BTFIXUPDEF_CALL_CONST(int, pgd_present, pgd_t)
+static inline int pgd_none(pgd_t pgd)          
+{
+	return !(pgd_val(pgd) & 0xFFFFFFF);
+}
 
-#define pgd_none(pgd) BTFIXUP_CALL(pgd_none)(pgd)
-#define pgd_bad(pgd) BTFIXUP_CALL(pgd_bad)(pgd)
-#define pgd_present(pgd) BTFIXUP_CALL(pgd_present)(pgd)
+static inline int pgd_bad(pgd_t pgd)
+{
+	return (pgd_val(pgd) & SRMMU_ET_MASK) != SRMMU_ET_PTD;
+}
+
+static inline int pgd_present(pgd_t pgd)
+{
+	return ((pgd_val(pgd) & SRMMU_ET_MASK) = SRMMU_ET_PTD);
+}
 
 static inline void pgd_clear(pgd_t *pgdp)
 {
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index c696271..94dcd06 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -124,15 +124,6 @@ static inline int srmmu_pmd_bad(pmd_t pmd)
 static inline int srmmu_pmd_present(pmd_t pmd)
 { return ((pmd_val(pmd) & SRMMU_ET_MASK) = SRMMU_ET_PTD); }
 
-static inline int srmmu_pgd_none(pgd_t pgd)          
-{ return !(pgd_val(pgd) & 0xFFFFFFF); }
-
-static inline int srmmu_pgd_bad(pgd_t pgd)
-{ return (pgd_val(pgd) & SRMMU_ET_MASK) != SRMMU_ET_PTD; }
-
-static inline int srmmu_pgd_present(pgd_t pgd)
-{ return ((pgd_val(pgd) & SRMMU_ET_MASK) = SRMMU_ET_PTD); }
-
 static inline pte_t srmmu_pte_wrprotect(pte_t pte)
 { return __pte(pte_val(pte) & ~SRMMU_WRITE);}
 
@@ -1007,7 +998,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 
 	while(start < end) {
 		pgdp = pgd_offset_k(start);
-		if(srmmu_pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
+		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
 			pmdp = (pmd_t *) __srmmu_get_nocache(
 			    SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
@@ -1038,7 +1029,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 
 	while(start < end) {
 		pgdp = pgd_offset_k(start);
-		if(srmmu_pgd_none(*pgdp)) {
+		if (pgd_none(*pgdp)) {
 			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
@@ -1104,7 +1095,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			start += SRMMU_PGDIR_SIZE;
 			continue;
 		}
-		if(srmmu_pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
+		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
 			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
@@ -2090,10 +2081,6 @@ void __init ld_mmu_srmmu(void)
 	BTFIXUPSET_CALL(pmd_bad, srmmu_pmd_bad, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_present, srmmu_pmd_present, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(pgd_none, srmmu_pgd_none, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_bad, srmmu_pgd_bad, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pgd_present, srmmu_pgd_present, BTFIXUPCALL_NORM);
-
 	BTFIXUPSET_CALL(mk_pte, srmmu_mk_pte, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mk_pte_phys, srmmu_mk_pte_phys, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mk_pte_io, srmmu_mk_pte_io, BTFIXUPCALL_NORM);
-- 
1.7.10

