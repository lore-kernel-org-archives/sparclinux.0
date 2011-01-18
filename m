From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 18 Jan 2011 14:10:28 +0000
Subject: [PATCH 5/6 V3] sparc: Make mmu_inval_dma_area take void * instead of unsigned long to minimize casts
Message-Id: <1295359829-27308-6-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |   53 ++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 815003b..bd4fb10 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -53,7 +53,7 @@
 #ifndef CONFIG_SPARC_LEON
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
 #else
-static inline void mmu_inval_dma_area(unsigned long va, unsigned long len)
+static inline void mmu_inval_dma_area(void *va, unsigned long len)
 {
 	if (!sparc_leon3_snooping_enabled())
 		leon_flush_dcache_all();
@@ -284,7 +284,7 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 		printk("sbus_alloc_consistent: cannot occupy 0x%lx", len_total);
 		goto err_nova;
 	}
-	mmu_inval_dma_area(va, len_total);
+	mmu_inval_dma_area((void *)va, len_total);
 
 	// XXX The mmu_map_dma_area does this for us below, see comments.
 	// sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
@@ -435,7 +435,7 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
 				  dma_addr_t *pba, gfp_t gfp)
 {
 	unsigned long len_total = PAGE_ALIGN(len);
-	unsigned long va;
+	void *va;
 	struct resource *res;
 	int order;
 
@@ -447,30 +447,34 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
 	}
 
 	order = get_order(len_total);
-	va = __get_free_pages(GFP_KERNEL, order);
-	if (va = 0) {
+	va = (void *) __get_free_pages(GFP_KERNEL, order);
+	if (va = NULL) {
 		printk("pci_alloc_consistent: no %ld pages\n", len_total>>PAGE_SHIFT);
-		return NULL;
+		goto err_nopages;
 	}
 
 	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) = NULL) {
-		free_pages(va, order);
 		printk("pci_alloc_consistent: no core\n");
-		return NULL;
+		goto err_nomem;
 	}
 
 	if (allocate_resource(&_sparc_dvma, res, len_total,
 	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
 		printk("pci_alloc_consistent: cannot occupy 0x%lx", len_total);
-		free_pages(va, order);
-		kfree(res);
-		return NULL;
+		goto err_nova;
 	}
 	mmu_inval_dma_area(va, len_total);
 	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
 
 	*pba = virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
 	return (void *) res->start;
+
+err_nova:
+	kfree(res);
+err_nomem:
+	free_pages((unsigned long)va, order);
+err_nopages:
+	return NULL;
 }
 
 /* Free and unmap a consistent DMA buffer.
@@ -485,7 +489,7 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 				dma_addr_t ba)
 {
 	struct resource *res;
-	unsigned long pgp;
+	void *pgp;
 
 	if ((res = _sparc_find_resource(&_sparc_dvma,
 	    (unsigned long)p)) = NULL) {
@@ -505,14 +509,14 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 		return;
 	}
 
-	pgp = (unsigned long) phys_to_virt(ba);	/* bus_to_virt actually */
+	pgp = phys_to_virt(ba);	/* bus_to_virt actually */
 	mmu_inval_dma_area(pgp, n);
 	sparc_unmapiorange((unsigned long)p, n);
 
 	release_resource(res);
 	kfree(res);
 
-	free_pages(pgp, get_order(n));
+	free_pages((unsigned long)pgp, get_order(n));
 }
 
 /*
@@ -531,7 +535,7 @@ static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
 			     enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	if (dir != PCI_DMA_TODEVICE)
-		mmu_inval_dma_area((unsigned long)phys_to_virt(ba), PAGE_ALIGN(size));
+		mmu_inval_dma_area(phys_to_virt(ba), PAGE_ALIGN(size));
 }
 
 /* Map a set of buffers described by scatterlist in streaming
@@ -579,9 +583,8 @@ static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	if (dir != PCI_DMA_TODEVICE) {
 		for_each_sg(sgl, sg, nents, n) {
 			BUG_ON(page_address(sg_page(sg)) = NULL);
-			mmu_inval_dma_area(
-			    (unsigned long) page_address(sg_page(sg)),
-			    PAGE_ALIGN(sg->length));
+			mmu_inval_dma_area(page_address(sg_page(sg)),
+					   PAGE_ALIGN(sg->length));
 		}
 	}
 }
@@ -600,7 +603,7 @@ static void pci32_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
 				      size_t size, enum dma_data_direction dir)
 {
 	if (dir != PCI_DMA_TODEVICE) {
-		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
+		mmu_inval_dma_area(phys_to_virt(ba),
 				   PAGE_ALIGN(size));
 	}
 }
@@ -609,7 +612,7 @@ static void pci32_sync_single_for_device(struct device *dev, dma_addr_t ba,
 					 size_t size, enum dma_data_direction dir)
 {
 	if (dir != PCI_DMA_TODEVICE) {
-		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
+		mmu_inval_dma_area(phys_to_virt(ba),
 				   PAGE_ALIGN(size));
 	}
 }
@@ -629,9 +632,8 @@ static void pci32_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
 	if (dir != PCI_DMA_TODEVICE) {
 		for_each_sg(sgl, sg, nents, n) {
 			BUG_ON(page_address(sg_page(sg)) = NULL);
-			mmu_inval_dma_area(
-			    (unsigned long) page_address(sg_page(sg)),
-			    PAGE_ALIGN(sg->length));
+			mmu_inval_dma_area(page_address(sg_page(sg)),
+					   PAGE_ALIGN(sg->length));
 		}
 	}
 }
@@ -645,9 +647,8 @@ static void pci32_sync_sg_for_device(struct device *device, struct scatterlist *
 	if (dir != PCI_DMA_TODEVICE) {
 		for_each_sg(sgl, sg, nents, n) {
 			BUG_ON(page_address(sg_page(sg)) = NULL);
-			mmu_inval_dma_area(
-			    (unsigned long) page_address(sg_page(sg)),
-			    PAGE_ALIGN(sg->length));
+			mmu_inval_dma_area(page_address(sg_page(sg)),
+					   PAGE_ALIGN(sg->length));
 		}
 	}
 }
-- 
1.6.4.1

