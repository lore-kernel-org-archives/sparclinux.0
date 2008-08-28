From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:29 +0000
Subject: [PATCH 28/49]: sparc32: Kill mmu_translate_dvma() usage.
Message-Id: <20080827.212429.117586418.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Kill mmu_translate_dvma() usage.

Just simply use virt_to_page() on the provided virtual address pointer.

Kill #if 0'd code.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ioport.c |   36 +-----------------------------------
 1 files changed, 1 insertions(+), 35 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index e87ed51..82ef201 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -383,7 +383,7 @@ void sbus_free_consistent(struct device *dev, long n, void *p, u32 ba)
 	kfree(res);
 
 	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
-	pgv = mmu_translate_dvma(ba);
+	pgv = virt_to_page(p);
 	mmu_unmap_dma_area(ba, n);
 
 	__free_pages(pgv, get_order(n));
@@ -428,46 +428,12 @@ void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n, int direct
 	mmu_release_scsi_sgl(dev, sg, n);
 }
 
-/*
- */
 void sbus_dma_sync_single_for_cpu(struct device *dev, dma_addr_t ba, size_t size, int direction)
 {
-#if 0
-	unsigned long va;
-	struct resource *res;
-
-	/* We do not need the resource, just print a message if invalid. */
-	res = _sparc_find_resource(&_sparc_dvma, ba);
-	if (res = NULL)
-		panic("sbus_dma_sync_single: 0x%x\n", ba);
-
-	va = page_address(mmu_translate_dvma(ba)); /* XXX higmem */
-	/*
-	 * XXX This bogosity will be fixed with the iommu rewrite coming soon
-	 * to a kernel near you. - Anton
-	 */
-	/* mmu_inval_dma_area(va, (size + PAGE_SIZE-1) & PAGE_MASK); */
-#endif
 }
 
 void sbus_dma_sync_single_for_device(struct device *dev, dma_addr_t ba, size_t size, int direction)
 {
-#if 0
-	unsigned long va;
-	struct resource *res;
-
-	/* We do not need the resource, just print a message if invalid. */
-	res = _sparc_find_resource(&_sparc_dvma, ba);
-	if (res = NULL)
-		panic("sbus_dma_sync_single: 0x%x\n", ba);
-
-	va = page_address(mmu_translate_dvma(ba)); /* XXX higmem */
-	/*
-	 * XXX This bogosity will be fixed with the iommu rewrite coming soon
-	 * to a kernel near you. - Anton
-	 */
-	/* mmu_inval_dma_area(va, (size + PAGE_SIZE-1) & PAGE_MASK); */
-#endif
 }
 
 /* Support code for sbus_init().  */
-- 
1.5.6.5.GIT

