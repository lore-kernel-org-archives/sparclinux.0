From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 16 Nov 2009 09:51:07 +0000
Subject: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area
Message-Id: <1258365067-8983-2-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

---
 arch/sparc/kernel/ioport.c |   75 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 3c8c44f..312b7b4 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -50,10 +50,15 @@
 #include <asm/io-unit.h>
 #include <asm/leon.h>
 
-#ifdef CONFIG_SPARC_LEON
-#define mmu_inval_dma_area(p, l) leon_flush_dcache_all()
-#else
+#ifndef CONFIG_SPARC_LEON
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
+#else
+static inline void mmu_inval_dma_area(unsigned long va, unsigned long len)
+{
+	if (!sparc_leon3_snooping_enabled()) {
+		leon_flush_dcache_all();
+	}
+}
 #endif
 
 static struct resource *_sparc_find_resource(struct resource *r,
@@ -281,21 +286,26 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 		goto err_nova;
 	}
 	mmu_inval_dma_area(va, len_total);
+
 	// XXX The mmu_map_dma_area does this for us below, see comments.
 	// sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
 	/*
 	 * XXX That's where sdev would be used. Currently we load
 	 * all iommu tables with the same translations.
 	 */
-	if (mmu_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0)
-		goto err_noiommu;
-
+#ifdef CONFIG_SPARC_LEON
+	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);	
+	*dma_addrp = virt_to_phys(va);
+#else
+	if (mmu_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0) {
+		release_resource(res);
+		goto err_nova;
+	}
+#endif
 	res->name = op->node->name;
 
 	return (void *)(unsigned long)res->start;
 
-err_noiommu:
-	release_resource(res);
 err_nova:
 	free_pages(va, order);
 err_nomem:
@@ -333,7 +343,12 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 
 	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
 	pgv = virt_to_page(p);
+
+#ifdef CONFIG_SPARC_LEON
+	sparc_unmapiorange((unsigned long)p, n);
+#else
 	mmu_unmap_dma_area(dev, ba, n);
+#endif
 
 	__free_pages(pgv, get_order(n));
 }
@@ -408,9 +423,6 @@ struct dma_map_ops sbus_dma_ops = {
 	.sync_sg_for_device	= sbus_sync_sg_for_device,
 };
 
-struct dma_map_ops *dma_ops = &sbus_dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 static int __init sparc_register_ioport(void)
 {
 	register_proc_sparc_ioport();
@@ -422,7 +434,7 @@ arch_initcall(sparc_register_ioport);
 
 #endif /* CONFIG_SBUS */
 
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) || defined(CONFIG_SPARC_LEON)
 
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
@@ -524,7 +536,16 @@ static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
 				 struct dma_attrs *attrs)
 {
 	/* IIep is write-through, not flushing. */
-	return page_to_phys(page) + offset;
+	return virt_to_phys(page_address(page)) + offset;
+}
+
+static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
+			     enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	if (dir != PCI_DMA_TODEVICE) {
+		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
+		    (size + PAGE_SIZE-1) & PAGE_MASK);
+	}
 }
 
 /* Map a set of buffers described by scatterlist in streaming
@@ -649,6 +670,7 @@ struct dma_map_ops pci32_dma_ops = {
 	.alloc_coherent		= pci32_alloc_coherent,
 	.free_coherent		= pci32_free_coherent,
 	.map_page		= pci32_map_page,
+	.unmap_page		= pci32_unmap_page,
 	.map_sg			= pci32_map_sg,
 	.unmap_sg		= pci32_unmap_sg,
 	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
@@ -658,7 +680,30 @@ struct dma_map_ops pci32_dma_ops = {
 };
 EXPORT_SYMBOL(pci32_dma_ops);
 
-#endif /* CONFIG_PCI */
+struct dma_map_ops leon3_dma_ops = {
+	.alloc_coherent		= sbus_alloc_coherent,
+	.free_coherent		= sbus_free_coherent,
+	.map_page		= pci32_map_page,
+	.unmap_page		= pci32_unmap_page,
+	.map_sg			= pci32_map_sg,
+	.unmap_sg		= pci32_unmap_sg,
+	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
+	.sync_single_for_device	= pci32_sync_single_for_device,
+	.sync_sg_for_cpu	= pci32_sync_sg_for_cpu,
+	.sync_sg_for_device	= pci32_sync_sg_for_device,
+};
+
+#endif /* CONFIG_PCI || CONFIG_SPARC_LEON */
+
+#ifdef CONFIG_SPARC_LEON
+struct dma_map_ops *dma_ops = &leon3_dma_ops;
+#else
+struct dma_map_ops *dma_ops = &sbus_dma_ops;
+#endif
+
+#ifdef CONFIG_SBUS
+EXPORT_SYMBOL(dma_ops);
+#endif
 
 /*
  * Return whether the given PCI device DMA address mask can be
@@ -728,7 +773,7 @@ static const struct file_operations sparc_io_proc_fops = {
 static struct resource *_sparc_find_resource(struct resource *root,
 					     unsigned long hit)
 {
-        struct resource *tmp;
+	struct resource *tmp;
 
 	for (tmp = root->child; tmp != 0; tmp = tmp->sibling) {
 		if (tmp->start <= hit && tmp->end >= hit)
-- 
1.5.2.2

