From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:36 +0000
Subject: [PATCH 30/49]: sparc32: Make mmu_map_dma_area and
Message-Id: <20080827.212436.223634812.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Make mmu_map_dma_area and mmu_unmap_dma_area take a device pointer.

This lets us kill this "map it in every IOMMU" crazy code, and also
some of the final references to sbus_root.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h |    8 ++++----
 arch/sparc/kernel/ioport.c   |    4 ++--
 arch/sparc/mm/io-unit.c      |   14 +++++---------
 arch/sparc/mm/iommu.c        |   10 +++++-----
 arch/sparc/mm/sun4c.c        |    6 +++---
 5 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index ee4ac18..d1ae56b 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -131,11 +131,11 @@ BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct device *, struct scatterlist
  * know if we are mapping RAM or I/O, so it has to be an additional argument
  * to a separate mapping function for CPU visible mappings.
  */
-BTFIXUPDEF_CALL(int,  mmu_map_dma_area, dma_addr_t *, unsigned long, unsigned long, int len)
-BTFIXUPDEF_CALL(void,  mmu_unmap_dma_area, unsigned long busa, int len)
+BTFIXUPDEF_CALL(int, mmu_map_dma_area, struct device *, dma_addr_t *, unsigned long, unsigned long, int len)
+BTFIXUPDEF_CALL(void, mmu_unmap_dma_area, struct device *, unsigned long busa, int len)
 
-#define mmu_map_dma_area(pba,va,a,len) BTFIXUP_CALL(mmu_map_dma_area)(pba,va,a,len)
-#define mmu_unmap_dma_area(ba,len) BTFIXUP_CALL(mmu_unmap_dma_area)(ba,len)
+#define mmu_map_dma_area(dev,pba,va,a,len) BTFIXUP_CALL(mmu_map_dma_area)(dev,pba,va,a,len)
+#define mmu_unmap_dma_area(dev,ba,len) BTFIXUP_CALL(mmu_unmap_dma_area)(dev,ba,len)
 #endif
 
 #endif /* !(_ASM_SPARC_DMA_H) */
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 82ef201..d65fb9b 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -339,7 +339,7 @@ void *sbus_alloc_consistent(struct device *dev, long len, u32 *dma_addrp)
 	 * XXX That's where sdev would be used. Currently we load
 	 * all iommu tables with the same translations.
 	 */
-	if (mmu_map_dma_area(dma_addrp, va, res->start, len_total) != 0)
+	if (mmu_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0)
 		goto err_noiommu;
 
 	res->name = op->node->name;
@@ -384,7 +384,7 @@ void sbus_free_consistent(struct device *dev, long n, void *p, u32 ba)
 
 	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
 	pgv = virt_to_page(p);
-	mmu_unmap_dma_area(ba, n);
+	mmu_unmap_dma_area(dev, ba, n);
 
 	__free_pages(pgv, get_order(n));
 }
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 6b46982..0f97ab3 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -186,12 +186,12 @@ static void iounit_release_scsi_sgl(struct device *dev, struct scatterlist *sg,
 }
 
 #ifdef CONFIG_SBUS
-static int iounit_map_dma_area(dma_addr_t *pba, unsigned long va, __u32 addr, int len)
+static int iounit_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned long va, __u32 addr, int len)
 {
+	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long page, end;
 	pgprot_t dvma_prot;
 	iopte_t *iopte;
-	struct sbus_bus *sbus;
 
 	*pba = addr;
 
@@ -213,12 +213,8 @@ static int iounit_map_dma_area(dma_addr_t *pba, unsigned long va, __u32 addr, in
 			
 			i = ((addr - IOUNIT_DMA_BASE) >> PAGE_SHIFT);
 
-			for_each_sbus(sbus) {
-				struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
-
-				iopte = (iopte_t *)(iounit->page_table + i);
-				*iopte = MKIOPTE(__pa(page));
-			}
+			iopte = (iopte_t *)(iounit->page_table + i);
+			*iopte = MKIOPTE(__pa(page));
 		}
 		addr += PAGE_SIZE;
 		va += PAGE_SIZE;
@@ -229,7 +225,7 @@ static int iounit_map_dma_area(dma_addr_t *pba, unsigned long va, __u32 addr, in
 	return 0;
 }
 
-static void iounit_unmap_dma_area(unsigned long addr, int len)
+static void iounit_unmap_dma_area(struct device *dev, unsigned long addr, int len)
 {
 	/* XXX Somebody please fill this in */
 }
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 832d99f..2970cea 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -334,11 +334,11 @@ static void iommu_release_scsi_sgl(struct device *dev, struct scatterlist *sg, i
 }
 
 #ifdef CONFIG_SBUS
-static int iommu_map_dma_area(dma_addr_t *pba, unsigned long va,
-    unsigned long addr, int len)
+static int iommu_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned long va,
+			      unsigned long addr, int len)
 {
+	struct iommu_struct *iommu = dev->archdata.iommu;
 	unsigned long page, end;
-	struct iommu_struct *iommu = sbus_root->ofdev.dev.archdata.iommu;
 	iopte_t *iopte = iommu->page_table;
 	iopte_t *first;
 	int ioptex;
@@ -401,9 +401,9 @@ static int iommu_map_dma_area(dma_addr_t *pba, unsigned long va,
 	return 0;
 }
 
-static void iommu_unmap_dma_area(unsigned long busa, int len)
+static void iommu_unmap_dma_area(struct device *dev, unsigned long busa, int len)
 {
-	struct iommu_struct *iommu = sbus_root->ofdev.dev.archdata.iommu;
+	struct iommu_struct *iommu = dev->archdata.iommu;
 	iopte_t *iopte = iommu->page_table;
 	unsigned long end;
 	int ioptex = (busa - iommu->start) >> PAGE_SHIFT;
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 65af311..f289e7c 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -532,8 +532,8 @@ static inline void sun4c_init_ss2_cache_bug(void)
 }
 
 /* Addr is always aligned on a page boundary for us already. */
-static int sun4c_map_dma_area(dma_addr_t *pba, unsigned long va,
-    unsigned long addr, int len)
+static int sun4c_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned long va,
+			      unsigned long addr, int len)
 {
 	unsigned long page, end;
 
@@ -555,7 +555,7 @@ static int sun4c_map_dma_area(dma_addr_t *pba, unsigned long va,
 	return 0;
 }
 
-static void sun4c_unmap_dma_area(unsigned long busa, int len)
+static void sun4c_unmap_dma_area(struct device *dev, unsigned long busa, int len)
 {
 	/* Fortunately for us, bus_addr = uncached_virt in sun4c. */
 	/* XXX Implement this */
-- 
1.5.6.5.GIT

