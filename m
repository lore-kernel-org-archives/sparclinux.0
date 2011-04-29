From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 29 Apr 2011 08:17:00 +0000
Subject: [PATCH] sparc32,leon: Remove unnecessary page_address calls in LEON DMA API.
Message-Id: <1304065020-28326-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function mmu_inval_dma_area takes a virtual address as a parameter
which is problematic in case the buffer is located in highmem and the
mapping currently is unavailable.

Since the function was only implemented for LEON this patch removes
calls to it in non LEON code paths and renames it to dma_make_coherent
which instead takes a physical address (which for now is unused since we
flush the whole cache). This way it is possible to remove several unnecessary
calls to page_address which will fail if the virtual mapping is unavailable.

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |   42 ++++++++++++++++--------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index c6ce9a6..1c9c80a 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -50,10 +50,15 @@
 #include <asm/io-unit.h>
 #include <asm/leon.h>
 
+/* This function must make sure that caches and memory are coherent after DMA
+ * On LEON systems without cache snooping it flushes the entire D-CACHE.
+ */
 #ifndef CONFIG_SPARC_LEON
-#define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
+static inline void dma_make_coherent(unsigned long pa, unsigned long len)
+{
+}
 #else
-static inline void mmu_inval_dma_area(void *va, unsigned long len)
+static inline void dma_make_coherent(unsigned long pa, unsigned long len)
 {
 	if (!sparc_leon3_snooping_enabled())
 		leon_flush_dcache_all();
@@ -284,7 +289,6 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 		printk("sbus_alloc_consistent: cannot occupy 0x%lx", len_total);
 		goto err_nova;
 	}
-	mmu_inval_dma_area((void *)va, len_total);
 
 	// XXX The mmu_map_dma_area does this for us below, see comments.
 	// sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
@@ -336,7 +340,6 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 	release_resource(res);
 	kfree(res);
 
-	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
 	pgv = virt_to_page(p);
 	mmu_unmap_dma_area(dev, ba, n);
 
@@ -463,7 +466,6 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
 		printk("pci_alloc_consistent: cannot occupy 0x%lx", len_total);
 		goto err_nova;
 	}
-	mmu_inval_dma_area(va, len_total);
 	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
 
 	*pba = virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
@@ -489,7 +491,6 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 				dma_addr_t ba)
 {
 	struct resource *res;
-	void *pgp;
 
 	if ((res = _sparc_find_resource(&_sparc_dvma,
 	    (unsigned long)p)) = NULL) {
@@ -509,14 +510,12 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 		return;
 	}
 
-	pgp = phys_to_virt(ba);	/* bus_to_virt actually */
-	mmu_inval_dma_area(pgp, n);
+	dma_make_coherent(ba, n);
 	sparc_unmapiorange((unsigned long)p, n);
 
 	release_resource(res);
 	kfree(res);
-
-	free_pages((unsigned long)pgp, get_order(n));
+	free_pages((unsigned long)phys_to_virt(ba), get_order(n));
 }
 
 /*
@@ -535,7 +534,7 @@ static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
 			     enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	if (dir != PCI_DMA_TODEVICE)
-		mmu_inval_dma_area(phys_to_virt(ba), PAGE_ALIGN(size));
+		dma_make_coherent(ba, PAGE_ALIGN(size));
 }
 
 /* Map a set of buffers described by scatterlist in streaming
@@ -562,8 +561,7 @@ static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
 
 	/* IIep is write-through, not flushing. */
 	for_each_sg(sgl, sg, nents, n) {
-		BUG_ON(page_address(sg_page(sg)) = NULL);
-		sg->dma_address = virt_to_phys(sg_virt(sg));
+		sg->dma_address = sg_phys(sg);
 		sg->dma_length = sg->length;
 	}
 	return nents;
@@ -582,9 +580,7 @@ static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
 
 	if (dir != PCI_DMA_TODEVICE) {
 		for_each_sg(sgl, sg, nents, n) {
-			BUG_ON(page_address(sg_page(sg)) = NULL);
-			mmu_inval_dma_area(page_address(sg_page(sg)),
-					   PAGE_ALIGN(sg->length));
+			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
 		}
 	}
 }
@@ -603,8 +599,7 @@ static void pci32_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
 				      size_t size, enum dma_data_direction dir)
 {
 	if (dir != PCI_DMA_TODEVICE) {
-		mmu_inval_dma_area(phys_to_virt(ba),
-				   PAGE_ALIGN(size));
+		dma_make_coherent(ba, PAGE_ALIGN(size));
 	}
 }
 
@@ -612,8 +607,7 @@ static void pci32_sync_single_for_device(struct device *dev, dma_addr_t ba,
 					 size_t size, enum dma_data_direction dir)
 {
 	if (dir != PCI_DMA_TODEVICE) {
-		mmu_inval_dma_area(phys_to_virt(ba),
-				   PAGE_ALIGN(size));
+		dma_make_coherent(ba, PAGE_ALIGN(size));
 	}
 }
 
@@ -631,9 +625,7 @@ static void pci32_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
 
 	if (dir != PCI_DMA_TODEVICE) {
 		for_each_sg(sgl, sg, nents, n) {
-			BUG_ON(page_address(sg_page(sg)) = NULL);
-			mmu_inval_dma_area(page_address(sg_page(sg)),
-					   PAGE_ALIGN(sg->length));
+			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
 		}
 	}
 }
@@ -646,9 +638,7 @@ static void pci32_sync_sg_for_device(struct device *device, struct scatterlist *
 
 	if (dir != PCI_DMA_TODEVICE) {
 		for_each_sg(sgl, sg, nents, n) {
-			BUG_ON(page_address(sg_page(sg)) = NULL);
-			mmu_inval_dma_area(page_address(sg_page(sg)),
-					   PAGE_ALIGN(sg->length));
+			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
 		}
 	}
 }
-- 
1.6.4.1

