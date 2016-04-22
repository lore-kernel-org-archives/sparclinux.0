From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 17:41:07 +0000
Subject: [PATCH 5/5] sparc32: drop superfluous cast in calls to __nocache_pa()
Message-Id: <1461346867-9736-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgalloc_32.h | 2 +-
 arch/sparc/mm/srmmu.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 21f6482..0346c7e 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -29,7 +29,7 @@ static inline void free_pgd_fast(pgd_t *pgd)
 
 static inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
 {
-	unsigned long pa = __nocache_pa((unsigned long)pmdp);
+	unsigned long pa = __nocache_pa(pmdp);
 
 	set_pte((pte_t *)pgdp, __pte((SRMMU_ET_PTD | (pa >> 4))));
 }
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 3b1c047..c7f2a52 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -119,7 +119,7 @@ void pmd_set(pmd_t *pmdp, pte_t *ptep)
 	unsigned long ptp;	/* Physical address, shifted right by 4 */
 	int i;
 
-	ptp = __nocache_pa((unsigned long) ptep) >> 4;
+	ptp = __nocache_pa(ptep) >> 4;
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
 		set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
 		ptp += (SRMMU_REAL_PTRS_PER_PTE * sizeof(pte_t) >> 4);
@@ -916,7 +916,7 @@ void __init srmmu_paging_init(void)
 
 	/* ctx table has to be physically aligned to its size */
 	srmmu_context_table = __srmmu_get_nocache(num_contexts * sizeof(ctxd_t), num_contexts * sizeof(ctxd_t));
-	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa((unsigned long)srmmu_context_table);
+	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa(srmmu_context_table);
 
 	for (i = 0; i < num_contexts; i++)
 		srmmu_ctxd_set((ctxd_t *)__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
-- 
2.5.0

