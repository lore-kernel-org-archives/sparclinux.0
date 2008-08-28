From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:31 +0000
Subject: [PATCH 29/49]: sparc32: Kill mmu_translate_dvma and
Message-Id: <20080827.212431.203633347.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Kill mmu_translate_dvma and implementations.

No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h |    2 --
 arch/sparc/mm/io-unit.c      |   14 --------------
 arch/sparc/mm/iommu.c        |   10 ----------
 arch/sparc/mm/sun4c.c        |    8 --------
 4 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index 5955177..ee4ac18 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -132,12 +132,10 @@ BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct device *, struct scatterlist
  * to a separate mapping function for CPU visible mappings.
  */
 BTFIXUPDEF_CALL(int,  mmu_map_dma_area, dma_addr_t *, unsigned long, unsigned long, int len)
-BTFIXUPDEF_CALL(struct page *, mmu_translate_dvma, unsigned long busa)
 BTFIXUPDEF_CALL(void,  mmu_unmap_dma_area, unsigned long busa, int len)
 
 #define mmu_map_dma_area(pba,va,a,len) BTFIXUP_CALL(mmu_map_dma_area)(pba,va,a,len)
 #define mmu_unmap_dma_area(ba,len) BTFIXUP_CALL(mmu_unmap_dma_area)(ba,len)
-#define mmu_translate_dvma(ba)     BTFIXUP_CALL(mmu_translate_dvma)(ba)
 #endif
 
 #endif /* !(_ASM_SPARC_DMA_H) */
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 4239655..6b46982 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -233,19 +233,6 @@ static void iounit_unmap_dma_area(unsigned long addr, int len)
 {
 	/* XXX Somebody please fill this in */
 }
-
-/* XXX We do not pass sbus device here, bad. */
-static struct page *iounit_translate_dvma(unsigned long addr)
-{
-	struct sbus_bus *sbus = sbus_root;	/* They are all the same */
-	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
-	int i;
-	iopte_t *iopte;
-
-	i = ((addr - IOUNIT_DMA_BASE) >> PAGE_SHIFT);
-	iopte = (iopte_t *)(iounit->page_table + i);
-	return pfn_to_page(iopte_val(*iopte) >> (PAGE_SHIFT-4)); /* XXX sun4d guru, help */
-}
 #endif
 
 static char *iounit_lockarea(char *vaddr, unsigned long len)
@@ -272,7 +259,6 @@ void __init ld_mmu_iounit(void)
 #ifdef CONFIG_SBUS
 	BTFIXUPSET_CALL(mmu_map_dma_area, iounit_map_dma_area, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_unmap_dma_area, iounit_unmap_dma_area, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_translate_dvma, iounit_translate_dvma, BTFIXUPCALL_NORM);
 #endif
 }
 
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 8e9ab93..832d99f 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -421,15 +421,6 @@ static void iommu_unmap_dma_area(unsigned long busa, int len)
 	iommu_invalidate(iommu->regs);
 	bit_map_clear(&iommu->usemap, ioptex, len >> PAGE_SHIFT);
 }
-
-static struct page *iommu_translate_dvma(unsigned long busa)
-{
-	struct iommu_struct *iommu = sbus_root->ofdev.dev.archdata.iommu;
-	iopte_t *iopte = iommu->page_table;
-
-	iopte += ((busa - iommu->start) >> PAGE_SHIFT);
-	return pfn_to_page((iopte_val(*iopte) & IOPTE_PAGE) >> (PAGE_SHIFT-4));
-}
 #endif
 
 static char *iommu_lockarea(char *vaddr, unsigned long len)
@@ -465,7 +456,6 @@ void __init ld_mmu_iommu(void)
 #ifdef CONFIG_SBUS
 	BTFIXUPSET_CALL(mmu_map_dma_area, iommu_map_dma_area, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_unmap_dma_area, iommu_unmap_dma_area, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_translate_dvma, iommu_translate_dvma, BTFIXUPCALL_NORM);
 #endif
 
 	if (viking_mxcc_present || srmmu_modtype = HyperSparc) {
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index d1782f6..65af311 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -555,13 +555,6 @@ static int sun4c_map_dma_area(dma_addr_t *pba, unsigned long va,
 	return 0;
 }
 
-static struct page *sun4c_translate_dvma(unsigned long busa)
-{
-	/* Fortunately for us, bus_addr = uncached_virt in sun4c. */
-	unsigned long pte = sun4c_get_pte(busa);
-	return pfn_to_page(pte & SUN4C_PFN_MASK);
-}
-
 static void sun4c_unmap_dma_area(unsigned long busa, int len)
 {
 	/* Fortunately for us, bus_addr = uncached_virt in sun4c. */
@@ -2263,7 +2256,6 @@ void __init ld_mmu_sun4c(void)
 
 	BTFIXUPSET_CALL(mmu_map_dma_area, sun4c_map_dma_area, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_unmap_dma_area, sun4c_unmap_dma_area, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_translate_dvma, sun4c_translate_dvma, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(sparc_mapiorange, sun4c_mapiorange, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(sparc_unmapiorange, sun4c_unmapiorange, BTFIXUPCALL_NORM);
-- 
1.5.6.5.GIT

