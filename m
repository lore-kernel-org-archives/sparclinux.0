From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 02 Nov 2009 14:28:12 +0000
Subject: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area.
Message-Id: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Added mmu_inval_dma_area for LEON which flushes dcache if snooping is not enabled
and created LEON specific dma_ops.

Best regards,
Kristoffer Glembo

---
 arch/sparc/kernel/ioport.c |  222 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 218 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 9f61fd8..63aab03 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -48,8 +48,18 @@
 #include <asm/dma.h>
 #include <asm/iommu.h>
 #include <asm/io-unit.h>
+#include <asm/leon.h>
 
+#ifndef CONFIG_SPARC_LEON
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
+#else
+static inline void mmu_inval_dma_area(unsigned long va, unsigned long len)
+{
+	if (!sparc_leon3_snooping_enabled()) {
+                leon_flush_dcache_all();
+        }
+}
+#endif
 
 static struct resource *_sparc_find_resource(struct resource *r,
 					     unsigned long);
@@ -70,6 +80,9 @@ static struct resource _sparc_dvma = {
 	.name = "sparc_iomap", .start = IOBASE_VADDR, .end = IOBASE_END - 1
 };
 
+struct dma_map_ops *dma_ops;
+EXPORT_SYMBOL(dma_ops);
+
 /*
  * Our mini-allocator...
  * Boy this is gross! We need it because we must map I/O for
@@ -403,11 +416,214 @@ struct dma_map_ops sbus_dma_ops = {
 	.sync_sg_for_device	= sbus_sync_sg_for_device,
 };
 
-struct dma_map_ops *dma_ops = &sbus_dma_ops;
-EXPORT_SYMBOL(dma_ops);
+#endif /* CONFIG_SBUS */
+
+#ifdef CONFIG_SPARC_LEON
+
+static void *leon3_alloc_coherent(struct device *dev, size_t len,
+				  dma_addr_t *pba, gfp_t gfp)
+{
+	unsigned long len_total = (len + PAGE_SIZE-1) & PAGE_MASK;
+	unsigned long va;
+ 	struct resource *res;
+	int order;
+
+	if (len = 0) {
+		return NULL;
+	}
+	if (len > 256*1024) {			/* __get_free_pages() limit */
+		return NULL;
+	}
+
+	order = get_order(len_total);
+	va = __get_free_pages(GFP_KERNEL, order);
+	if (va = 0) {
+		printk("leon3_alloc_consistent: no %ld pages\n", len_total>>PAGE_SHIFT);
+		return NULL;
+	}
+
+	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) = NULL) {
+		free_pages(va, order);
+		printk("leon3_alloc_consistent: no core\n");
+		return NULL;
+	}
+
+	if (allocate_resource(&_sparc_dvma, res, len_total,
+	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
+		printk("leon3_alloc_consistent: cannot occupy 0x%lx", len_total);
+		free_pages(va, order);
+		kfree(res);
+		return NULL;
+	}
+	mmu_inval_dma_area(va, len_total);
+
+	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
+
+	*pba = virt_to_phys(va);
+	return (void *) res->start;
+}
+
+
+static void leon3_free_coherent(struct device *dev, size_t n, void *p,
+				dma_addr_t ba)
+{
+	struct resource *res;
+	unsigned long pgp;
+
+	if ((res = _sparc_find_resource(&_sparc_dvma,
+	    (unsigned long)p)) = NULL) {
+		printk("leon3_free_consistent: cannot free %p\n", p);
+		return;
+	}
+
+	if (((unsigned long)p & (PAGE_SIZE-1)) != 0) {
+		printk("leon3_free_consistent: unaligned va %p\n", p);
+		return;
+	}
+
+	n = (n + PAGE_SIZE-1) & PAGE_MASK;
+	if ((res->end-res->start)+1 != n) {
+		printk("leon3_free_consistent: region 0x%lx asked 0x%lx\n",
+		    (long)((res->end-res->start)+1), (long)n);
+		return;
+	}
+
+	pgp = (unsigned long) phys_to_virt(ba);	/* bus_to_virt actually */
+	mmu_inval_dma_area(pgp, n);
+	sparc_unmapiorange((unsigned long)p, n);
+
+	release_resource(res);
+	kfree(res);
+
+	free_pages(pgp, get_order(n));
+}
+
+static dma_addr_t leon3_map_page(struct device *dev, struct page *page,
+				 unsigned long offset, size_t size,
+				 enum dma_data_direction dir,
+				 struct dma_attrs *attrs)
+{
+	/* LEON3 is write-through, not flushing. */
+	return page_to_phys(page) + offset;
+}
+
+static void leon3_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
+                             enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+        if (dir != DMA_TO_DEVICE) {
+		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
+		    (size + PAGE_SIZE-1) & PAGE_MASK);
+	}
+}
+
+static int leon3_map_sg(struct device *device, struct scatterlist *sgl,
+			int nents, enum dma_data_direction dir,
+			struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int n;
+
+	/* LEON3 is write-through, not flushing. */
+	for_each_sg(sgl, sg, nents, n) {
+		BUG_ON(page_address(sg_page(sg)) = NULL);
+		sg->dma_address = virt_to_phys(sg_virt(sg));
+		sg->dma_length = sg->length;
+	}
+	return nents;
+}
+
+static void leon3_unmap_sg(struct device *dev, struct scatterlist *sgl,
+			   int nents, enum dma_data_direction dir,
+			   struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int n;
+
+	if (dir != DMA_TO_DEVICE) {
+		for_each_sg(sgl, sg, nents, n) {
+			BUG_ON(page_address(sg_page(sg)) = NULL);
+			mmu_inval_dma_area(
+			    (unsigned long) page_address(sg_page(sg)),
+			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
+		}
+	}
+}
+
+static void leon3_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
+				      size_t size, enum dma_data_direction dir)
+{
+	if (dir != DMA_TO_DEVICE) {
+		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
+		    (size + PAGE_SIZE-1) & PAGE_MASK);
+	}
+}
+
+static void leon3_sync_single_for_device(struct device *dev, dma_addr_t ba,
+					 size_t size, enum dma_data_direction dir)
+{
+	if (dir != DMA_TO_DEVICE) {
+		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
+		    (size + PAGE_SIZE-1) & PAGE_MASK);
+	}
+}
+
+static void leon3_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
+				  int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int n;
+
+	if (dir != DMA_TO_DEVICE) {
+		for_each_sg(sgl, sg, nents, n) {
+			BUG_ON(page_address(sg_page(sg)) = NULL);
+			mmu_inval_dma_area(
+			    (unsigned long) page_address(sg_page(sg)),
+			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
+		}
+	}
+}
+
+static void leon3_sync_sg_for_device(struct device *device, struct scatterlist *sgl,
+				     int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int n;
+
+	if (dir != DMA_TO_DEVICE) {
+		for_each_sg(sgl, sg, nents, n) {
+			BUG_ON(page_address(sg_page(sg)) = NULL);
+			mmu_inval_dma_area(
+			    (unsigned long) page_address(sg_page(sg)),
+			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
+		}
+	}
+}
+
+struct dma_map_ops leon3_dma_ops = {
+	.alloc_coherent		= leon3_alloc_coherent,
+	.free_coherent		= leon3_free_coherent,
+	.map_page		= leon3_map_page,
+	.unmap_page		= leon3_unmap_page,
+	.map_sg			= leon3_map_sg,
+	.unmap_sg		= leon3_unmap_sg,
+        .sync_single_for_cpu    = leon3_sync_single_for_cpu,
+        .sync_single_for_device = leon3_sync_single_for_device,
+	.sync_sg_for_cpu	= leon3_sync_sg_for_cpu,
+	.sync_sg_for_device	= leon3_sync_sg_for_device,
+};
+
+
+
+#endif /* CONFIG_SPARC_LEON */
 
 static int __init sparc_register_ioport(void)
 {
+#ifdef CONFIG_SPARC_LEON
+        dma_ops = &leon3_dma_ops;
+#else
+        dma_ops = &sbus_dma_ops;
+#endif
+
 	register_proc_sparc_ioport();
 
 	return 0;
@@ -415,8 +631,6 @@ static int __init sparc_register_ioport(void)
 
 arch_initcall(sparc_register_ioport);
 
-#endif /* CONFIG_SBUS */
-
 #ifdef CONFIG_PCI
 
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
-- 
1.5.2.2

