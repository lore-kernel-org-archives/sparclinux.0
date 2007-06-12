From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 12 Jun 2007 23:16:00 +0000
Subject: [PATCH] Fix build errors with strict MM checking
Message-Id: <20070612231600.GA8953@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Turning on STRICT_MM_TYPECHECKS in include/asm/page.h causes some
build errors for sparc32. This patch against 2.6.21 fixes these.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
--- linux/arch/sparc/mm/srmmu.c.orig	2007-06-06 23:26:13.000000000 +0100
+++ linux/arch/sparc/mm/srmmu.c	2007-06-12 23:56:43.000000000 +0100
@@ -226,10 +226,10 @@ static pte_t srmmu_mk_pte_io(unsigned lo
 
 /* XXX should we hyper_flush_whole_icache here - Anton */
 static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
-{ srmmu_set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
+{ srmmu_set_pte((pte_t *)ctxp, __pte(SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
 
 static inline void srmmu_pgd_set(pgd_t * pgdp, pmd_t * pmdp)
-{ srmmu_set_pte((pte_t *)pgdp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pmdp) >> 4))); }
+{ srmmu_set_pte((pte_t *)pgdp, __pte(SRMMU_ET_PTD | (__nocache_pa((unsigned long) pmdp) >> 4))); }
 
 static void srmmu_pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
@@ -238,7 +238,7 @@ static void srmmu_pmd_set(pmd_t *pmdp, p
 
 	ptp = __nocache_pa((unsigned long) ptep) >> 4;
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
+		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
 		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
 	}
 }
@@ -250,7 +250,7 @@ static void srmmu_pmd_populate(pmd_t *pm
 
 	ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4);	/* watch for overflow */
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
+		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
 		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
 	}
 }
@@ -2137,11 +2137,11 @@ static unsigned long srmmu_pte_to_pgoff(
 
 static pgprot_t srmmu_pgprot_noncached(pgprot_t prot)
 {
-	prot &= ~__pgprot(SRMMU_CACHE);
+	pgprot_val(prot) &= ~SRMMU_CACHE;
 
 	return prot;
 }
