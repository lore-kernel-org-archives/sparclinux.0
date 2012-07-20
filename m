From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2012 07:55:40 +0000
Subject: [PATCH 5/9] sparc32: beautify srmmu_inherit_prom_mappings()
Message-Id: <1342770944-17476-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/srmmu.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 146742b..ab62595 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -677,44 +677,48 @@ static inline unsigned long srmmu_probe(unsigned long vaddr)
 static void __init srmmu_inherit_prom_mappings(unsigned long start,
 					       unsigned long end)
 {
+	unsigned long probed;
+	unsigned long addr;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	int what = 0; /* 0 = normal-pte, 1 = pmd-level pte, 2 = pgd-level pte */
-	unsigned long prompte;
+	int what; /* 0 = normal-pte, 1 = pmd-level pte, 2 = pgd-level pte */
 
 	while (start <= end) {
 		if (start = 0)
 			break; /* probably wrap around */
 		if (start = 0xfef00000)
 			start = KADB_DEBUGGER_BEGVM;
-		if (!(prompte = srmmu_probe(start))) {
+		probed = srmmu_probe(start);
+		if (!probed) {
+			/* continue probing until we find an entry */
 			start += PAGE_SIZE;
 			continue;
 		}
 
 		/* A red snapper, see what it really is. */
 		what = 0;
+		addr = start - PAGE_SIZE;
 
 		if (!(start & ~(SRMMU_REAL_PMD_MASK))) {
-			if (srmmu_probe((start - PAGE_SIZE) + SRMMU_REAL_PMD_SIZE) = prompte)
+			if (srmmu_probe(addr + SRMMU_REAL_PMD_SIZE) = probed)
 				what = 1;
 		}
 
 		if (!(start & ~(SRMMU_PGDIR_MASK))) {
-			if (srmmu_probe((start-PAGE_SIZE) + SRMMU_PGDIR_SIZE) =
-			   prompte)
+			if (srmmu_probe(addr + SRMMU_PGDIR_SIZE) = probed)
 				what = 2;
 		}
 
 		pgdp = pgd_offset_k(start);
 		if (what = 2) {
-			*(pgd_t *)__nocache_fix(pgdp) = __pgd(prompte);
+			*(pgd_t *)__nocache_fix(pgdp) = __pgd(probed);
 			start += SRMMU_PGDIR_SIZE;
 			continue;
 		}
 		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
-			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
+			pmdp = __srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE,
+						   SRMMU_PMD_TABLE_SIZE);
 			if (pmdp = NULL)
 				early_pgtable_allocfail("pmd");
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
@@ -734,13 +738,15 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			 * good hardware PTE piece. Alternatives seem worse.
 			 */
 			unsigned int x;	/* Index of HW PMD in soft cluster */
+			unsigned long *val;
 			x = (start >> PMD_SHIFT) & 15;
-			*(unsigned long *)__nocache_fix(&pmdp->pmdv[x]) = prompte;
+			val = &pmdp->pmdv[x];
+			*(unsigned long *)__nocache_fix(val) = probed;
 			start += SRMMU_REAL_PMD_SIZE;
 			continue;
 		}
 		ptep = pte_offset_kernel(__nocache_fix(pmdp), start);
-		*(pte_t *)__nocache_fix(ptep) = __pte(prompte);
+		*(pte_t *)__nocache_fix(ptep) = __pte(probed);
 		start += PAGE_SIZE;
 	}
 }
-- 
1.6.0.6

