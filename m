From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:02:51 +0000
Subject: [PATCH 8/8] sparc32: drop unused inline functions in srmmu.c
Message-Id: <1337493771-18535-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When decelared inline the compiler does not warn
about unused functions.
But they are not used so drop them.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/srmmu.c |   26 --------------------------
 1 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a02c56a..8e97e03 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -105,21 +105,9 @@ void *srmmu_nocache_pool;
 void *srmmu_nocache_bitmap;
 static struct bit_map srmmu_nocache_map;
 
-static inline int srmmu_pte_none(pte_t pte)
-{ return !(pte_val(pte) & 0xFFFFFFF); }
-
 static inline int srmmu_pmd_none(pmd_t pmd)
 { return !(pmd_val(pmd) & 0xFFFFFFF); }
 
-static inline pte_t srmmu_pte_wrprotect(pte_t pte)
-{ return __pte(pte_val(pte) & ~SRMMU_WRITE);}
-
-static inline pte_t srmmu_pte_mkclean(pte_t pte)
-{ return __pte(pte_val(pte) & ~SRMMU_DIRTY);}
-
-static inline pte_t srmmu_pte_mkold(pte_t pte)
-{ return __pte(pte_val(pte) & ~SRMMU_REF);}
-
 /* XXX should we hyper_flush_whole_icache here - Anton */
 static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
 { set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
@@ -148,13 +136,6 @@ void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
 	}
 }
 
-static inline pte_t srmmu_pte_modify(pte_t pte, pgprot_t newprot)
-{ return __pte((pte_val(pte) & SRMMU_CHG_MASK) | pgprot_val(newprot)); }
-
-/* to find an entry in a top-level page table... */
-static inline pgd_t *srmmu_pgd_offset(struct mm_struct * mm, unsigned long address)
-{ return mm->pgd + (address >> SRMMU_PGDIR_SHIFT); }
-
 /* Find an entry in the third-level page table.. */ 
 pte_t *pte_offset_kernel(pmd_t * dir, unsigned long address)
 {
@@ -805,13 +786,6 @@ static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
 	return vstart;
 }
 
-static inline void memprobe_error(char *msg)
-{
-	prom_printf(msg);
-	prom_printf("Halting now...\n");
-	prom_halt();
-}
-
 static inline void map_kernel(void)
 {
 	int i;
-- 
1.6.0.6

