From: Christoph Hellwig <hch@lst.de>
Date: Tue, 19 Jun 2018 07:00:46 +0000
Subject: [PATCH] sparc: use generic dma_noncoherent_ops
Message-Id: <20180619070046.25759-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

This removes the previous sync_single_for_device implementation, which
looks bogus given that no syncing is happening in the similar but more
important map_single case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/Kconfig                   |   2 +
 arch/sparc/include/asm/dma-mapping.h |   5 +-
 arch/sparc/kernel/ioport.c           | 151 ++-------------------------
 3 files changed, 14 insertions(+), 144 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0f535debf802..79f29c67291a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -48,6 +48,8 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select DMA_NONCOHERENT_OPS
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 12ae33daf52f..e17566376934 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -7,7 +7,6 @@
 #include <linux/dma-debug.h>
 
 extern const struct dma_map_ops *dma_ops;
-extern const struct dma_map_ops pci32_dma_ops;
 
 extern struct bus_type pci_bus_type;
 
@@ -15,11 +14,11 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_SPARC_LEON
 	if (sparc_cpu_model = sparc_leon)
-		return &pci32_dma_ops;
+		return &dma_noncoherent_ops;
 #endif
 #if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
 	if (bus = &pci_bus_type)
-		return &pci32_dma_ops;
+		return &dma_noncoherent_ops;
 #endif
 	return dma_ops;
 }
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index cca9134cfa7d..960c1bc22c2e 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -38,6 +38,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/of_device.h>
 
 #include <asm/io.h>
@@ -434,9 +435,8 @@ arch_initcall(sparc_register_ioport);
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
  */
-static void *pci32_alloc_coherent(struct device *dev, size_t len,
-				  dma_addr_t *pba, gfp_t gfp,
-				  unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t len, dma_addr_t *pba, gfp_t gfp,
+		unsigned long attrs)
 {
 	unsigned long len_total = PAGE_ALIGN(len);
 	void *va;
@@ -488,8 +488,8 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
  * References to the memory and mappings associated with cpu_addr/dma_addr
  * past this call are illegal.
  */
-static void pci32_free_coherent(struct device *dev, size_t n, void *p,
-				dma_addr_t ba, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t n, void *p, dma_addr_t ba,
+		unsigned long attrs)
 {
 	struct resource *res;
 
@@ -519,146 +519,15 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 	free_pages((unsigned long)phys_to_virt(ba), get_order(n));
 }
 
-/*
- * Same as pci_map_single, but with pages.
- */
-static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	/* IIep is write-through, not flushing. */
-	return page_to_phys(page) + offset;
-}
-
-static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
-			     enum dma_data_direction dir, unsigned long attrs)
-{
-	if (dir != PCI_DMA_TODEVICE && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_make_coherent(ba, PAGE_ALIGN(size));
-}
-
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scatter-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
-			int nents, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int n;
-
-	/* IIep is write-through, not flushing. */
-	for_each_sg(sgl, sg, nents, n) {
-		sg->dma_address = sg_phys(sg);
-		sg->dma_length = sg->length;
-	}
-	return nents;
-}
-
-/* Unmap a set of streaming mode DMA translations.
- * Again, cpu read rules concerning calls here are the same as for
- * pci_unmap_single() above.
- */
-static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
-			   int nents, enum dma_data_direction dir,
-			   unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int n;
-
-	if (dir != PCI_DMA_TODEVICE && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		for_each_sg(sgl, sg, nents, n) {
-			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
-		}
-	}
-}
+/* IIep is write-through, not flushing on cpu to device transfer. */
 
-/* Make physical memory consistent for a single
- * streaming mode DMA translation before or after a transfer.
- *
- * If you perform a pci_map_single() but wish to interrogate the
- * buffer using the cpu, yet do not wish to teardown the PCI dma
- * mapping, you must call this function before doing so.  At the
- * next point you give the PCI dma address back to the card, you
- * must first perform a pci_dma_sync_for_device, and then the
- * device again owns the buffer.
- */
-static void pci32_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
-				      size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	if (dir != PCI_DMA_TODEVICE) {
-		dma_make_coherent(ba, PAGE_ALIGN(size));
-	}
-}
-
-static void pci32_sync_single_for_device(struct device *dev, dma_addr_t ba,
-					 size_t size, enum dma_data_direction dir)
-{
-	if (dir != PCI_DMA_TODEVICE) {
-		dma_make_coherent(ba, PAGE_ALIGN(size));
-	}
+	if (dir != PCI_DMA_TODEVICE)
+		dma_make_coherent(paddr, PAGE_ALIGN(size));
 }
 
-/* Make physical memory consistent for a set of streaming
- * mode DMA translations after a transfer.
- *
- * The same as pci_dma_sync_single_* but for a scatter-gather list,
- * same rules and usage.
- */
-static void pci32_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
-				  int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int n;
-
-	if (dir != PCI_DMA_TODEVICE) {
-		for_each_sg(sgl, sg, nents, n) {
-			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
-		}
-	}
-}
-
-static void pci32_sync_sg_for_device(struct device *device, struct scatterlist *sgl,
-				     int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int n;
-
-	if (dir != PCI_DMA_TODEVICE) {
-		for_each_sg(sgl, sg, nents, n) {
-			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
-		}
-	}
-}
-
-/* note: leon re-uses pci32_dma_ops */
-const struct dma_map_ops pci32_dma_ops = {
-	.alloc			= pci32_alloc_coherent,
-	.free			= pci32_free_coherent,
-	.map_page		= pci32_map_page,
-	.unmap_page		= pci32_unmap_page,
-	.map_sg			= pci32_map_sg,
-	.unmap_sg		= pci32_unmap_sg,
-	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
-	.sync_single_for_device	= pci32_sync_single_for_device,
-	.sync_sg_for_cpu	= pci32_sync_sg_for_cpu,
-	.sync_sg_for_device	= pci32_sync_sg_for_device,
-};
-EXPORT_SYMBOL(pci32_dma_ops);
-
 const struct dma_map_ops *dma_ops = &sbus_dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-- 
2.17.1

