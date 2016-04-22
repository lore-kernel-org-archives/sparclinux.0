From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 17:41:06 +0000
Subject: [PATCH 4/5] sparc32: fix build with STRICT_MM_TYPECHECKS
Message-Id: <1461346867-9736-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Based on recent thread on linux-arch (some weeks ago) I
decided to check how much work was required to build sparc32
with STRICT_MM_TYPECHECKS enabled.

The resulting binary (checked srmmu.o) was to my suprise smaller with
STRICT_MM_TYPECHECKS defined, than without.

As I have no working gear to test sparc32 bits at for the moment,
I did not enable STRICT_MM_TYPECHECKS - but was tempeted to do so.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/page_32.h    |  2 --
 arch/sparc/include/asm/pgalloc_32.h |  2 +-
 arch/sparc/include/asm/pgtable_32.h |  2 +-
 arch/sparc/mm/io-unit.c             |  4 ++--
 arch/sparc/mm/srmmu.c               | 15 ++++++++++-----
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index f82a1f3..0efd058 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -69,7 +69,6 @@ typedef struct { unsigned long iopgprot; } iopgprot_t;
 
 #define __pte(x)	((pte_t) { (x) } )
 #define __iopte(x)	((iopte_t) { (x) } )
-/* #define __pmd(x)        ((pmd_t) { (x) } ) */ /* XXX procedure with loop */
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __ctxd(x)	((ctxd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
@@ -97,7 +96,6 @@ typedef unsigned long iopgprot_t;
 
 #define __pte(x)	(x)
 #define __iopte(x)	(x)
-/* #define __pmd(x)        (x) */ /* XXX later */
 #define __pgd(x)	(x)
 #define __ctxd(x)	(x)
 #define __pgprot(x)	(x)
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index a3890da..21f6482 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -31,7 +31,7 @@ static inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
 {
 	unsigned long pa = __nocache_pa((unsigned long)pmdp);
 
-	set_pte((pte_t *)pgdp, (SRMMU_ET_PTD | (pa >> 4)));
+	set_pte((pte_t *)pgdp, __pte((SRMMU_ET_PTD | (pa >> 4))));
 }
 
 #define pgd_populate(MM, PGD, PMD)      pgd_set(PGD, PMD)
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 91b963a..ce6f569 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -298,7 +298,7 @@ static inline pte_t mk_pte_io(unsigned long page, pgprot_t pgprot, int space)
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t prot)
 {
-	prot &= ~__pgprot(SRMMU_CACHE);
+	pgprot_val(prot) &= ~pgprot_val(__pgprot(SRMMU_CACHE));
 	return prot;
 }
 
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index f311bf2..338fb71 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -133,7 +133,7 @@ nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
 	vaddr = IOUNIT_DMA_BASE + (scan << PAGE_SHIFT) + (vaddr & ~PAGE_MASK);
 	for (k = 0; k < npages; k++, iopte = __iopte(iopte_val(iopte) + 0x100), scan++) {
 		set_bit(scan, iounit->bmap);
-		sbus_writel(iopte, &iounit->page_table[scan]);
+		sbus_writel(iopte_val(iopte), &iounit->page_table[scan]);
 	}
 	IOD(("%08lx\n", vaddr));
 	return vaddr;
@@ -228,7 +228,7 @@ static int iounit_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned lon
 			i = ((addr - IOUNIT_DMA_BASE) >> PAGE_SHIFT);
 
 			iopte = iounit->page_table + i;
-			sbus_writel(MKIOPTE(__pa(page)), iopte);
+			sbus_writel(iopte_val(MKIOPTE(__pa(page))), iopte);
 		}
 		addr += PAGE_SIZE;
 		va += PAGE_SIZE;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 5cbc96d..3b1c047 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -107,7 +107,12 @@ static inline int srmmu_pmd_none(pmd_t pmd)
 
 /* XXX should we hyper_flush_whole_icache here - Anton */
 static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
-{ set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
+{
+	pte_t pte;
+
+	pte = __pte((SRMMU_ET_PTD | (__nocache_pa(pgdp) >> 4)));
+	set_pte((pte_t *)ctxp, pte);
+}
 
 void pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
@@ -116,8 +121,8 @@ void pmd_set(pmd_t *pmdp, pte_t *ptep)
 
 	ptp = __nocache_pa((unsigned long) ptep) >> 4;
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
-		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
+		set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
+		ptp += (SRMMU_REAL_PTRS_PER_PTE * sizeof(pte_t) >> 4);
 	}
 }
 
@@ -128,8 +133,8 @@ void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
 
 	ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4);	/* watch for overflow */
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
-		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
+		set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
+		ptp += (SRMMU_REAL_PTRS_PER_PTE * sizeof(pte_t) >> 4);
 	}
 }
 
-- 
2.5.0

