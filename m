From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 11 Jan 2011 10:49:06 +0000
Subject: [PATCH 4/4] sparc/leon: Add LEON dma_ops.
Message-Id: <1294742946-1040-5-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch introduces a dma_ops structure for LEON. It reuses parts of the SBUS and PCI API to avoid code duplication.

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |   71 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index ba5cf62..444ffa7 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -292,16 +292,22 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 	/*
 	 * XXX That's where sdev would be used. Currently we load
 	 * all iommu tables with the same translations.
+	 *
+	 * For LEON we only set up the SRMMU, no IOMMU. 
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
 	res->name = op->dev.of_node->name;
 
 	return (void *)(unsigned long)res->start;
 
-err_noiommu:
-	release_resource(res);
 err_nova:
 	free_pages(va, order);
 err_nomem:
@@ -337,9 +343,15 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 	release_resource(res);
 	kfree(res);
 
-	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
 	pgv = virt_to_page(p);
+
+        /* No IOMMU support for LEON */
+#ifdef CONFIG_SPARC_LEON
+	mmu_inval_dma_area((unsigned long)p, n);
+	sparc_unmapiorange((unsigned long)p, n);
+#else
 	mmu_unmap_dma_area(dev, ba, n);
+#endif
 
 	__free_pages(pgv, get_order(n));
 }
@@ -414,9 +426,6 @@ struct dma_map_ops sbus_dma_ops = {
 	.sync_sg_for_device	= sbus_sync_sg_for_device,
 };
 
-struct dma_map_ops *dma_ops = &sbus_dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 static int __init sparc_register_ioport(void)
 {
 	register_proc_sparc_ioport();
@@ -428,7 +437,9 @@ arch_initcall(sparc_register_ioport);
 
 #endif /* CONFIG_SBUS */
 
-#ifdef CONFIG_PCI
+
+/* LEON reuses PCI DMA ops */
+#if defined(CONFIG_PCI) || defined(CONFIG_SPARC_LEON)
 
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
@@ -669,7 +680,45 @@ struct dma_map_ops pci32_dma_ops = {
 };
 EXPORT_SYMBOL(pci32_dma_ops);
 
-#endif /* CONFIG_PCI */
+/* 
+ * We can only invalidate the whole cache 
+ */
+static void leon_unmap_sg(struct device *dev, struct scatterlist *sgl,
+			   int nents, enum dma_data_direction dir,
+			   struct dma_attrs *attrs)
+{
+
+	if (dir != PCI_DMA_TODEVICE) {
+		mmu_inval_dma_area(0, 0);
+	}
+}
+
+struct dma_map_ops leon_dma_ops = {
+	.alloc_coherent		= sbus_alloc_coherent,
+	.free_coherent		= sbus_free_coherent,
+	.map_page		= pci32_map_page,
+	.unmap_page		= pci32_unmap_page,
+	.map_sg			= pci32_map_sg,
+	.unmap_sg		= leon_unmap_sg,
+	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
+	.sync_single_for_device	= pci32_sync_single_for_device,
+	.sync_sg_for_cpu	= pci32_sync_sg_for_cpu,
+	.sync_sg_for_device	= pci32_sync_sg_for_device,
+};
+
+#endif /* CONFIG_PCI || CONFIG_SPARC_LEON */
+
+#ifdef CONFIG_SBUS
+
+#ifdef CONFIG_SPARC_LEON
+struct dma_map_ops *dma_ops = &leon_dma_ops;
+#else
+struct dma_map_ops *dma_ops = &sbus_dma_ops;
+#endif
+
+EXPORT_SYMBOL(dma_ops);
+
+#endif
 
 /*
  * Return whether the given PCI device DMA address mask can be
-- 
1.6.4.1

