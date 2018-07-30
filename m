From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Jul 2018 16:17:23 +0000
Subject: [PATCH] sparc: use generic dma_noncoherent_ops
Message-Id: <20180730161723.9445-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180619070046.25759-1-hch@lst.de>
In-Reply-To: <20180619070046.25759-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>

Switch to the generic noncoherent direct mapping implementation.

This removes the previous sync_single_for_device implementation, which
looks bogus given that no syncing is happening in the similar but more
important map_single case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile                             |   2 +-
 arch/sparc/Kconfig                   |   2 +
 arch/sparc/include/asm/dma-mapping.h |   5 +-
 arch/sparc/kernel/ioport.c           | 193 +++++----------------------
 4 files changed, 36 insertions(+), 166 deletions(-)

diff --git a/Makefile b/Makefile
index 85f3481a56d6..8a3fd0c4a76e 100644
--- a/Makefile
+++ b/Makefile
@@ -368,7 +368,7 @@ HOST_LOADLIBES := $(HOST_LFS_LIBS)
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
-CC		= $(CROSS_COMPILE)gcc
+CC		= sparc64-linux-gnu-gcc-8
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
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
index cca9134cfa7d..6799c93c9f27 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -38,6 +38,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/of_device.h>
 
 #include <asm/io.h>
@@ -434,42 +435,41 @@ arch_initcall(sparc_register_ioport);
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
  */
-static void *pci32_alloc_coherent(struct device *dev, size_t len,
-				  dma_addr_t *pba, gfp_t gfp,
-				  unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
-	unsigned long len_total = PAGE_ALIGN(len);
+	unsigned long len_total = PAGE_ALIGN(size);
 	void *va;
 	struct resource *res;
 	int order;
 
-	if (len = 0) {
+	if (size = 0) {
 		return NULL;
 	}
-	if (len > 256*1024) {			/* __get_free_pages() limit */
+	if (size > 256*1024) {			/* __get_free_pages() limit */
 		return NULL;
 	}
 
 	order = get_order(len_total);
 	va = (void *) __get_free_pages(gfp, order);
 	if (va = NULL) {
-		printk("pci_alloc_consistent: no %ld pages\n", len_total>>PAGE_SHIFT);
+		printk("%s: no %ld pages\n", __func__, len_total>>PAGE_SHIFT);
 		goto err_nopages;
 	}
 
 	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) = NULL) {
-		printk("pci_alloc_consistent: no core\n");
+		printk("%s: no core\n", __func__);
 		goto err_nomem;
 	}
 
 	if (allocate_resource(&_sparc_dvma, res, len_total,
 	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
-		printk("pci_alloc_consistent: cannot occupy 0x%lx", len_total);
+		printk("%s: cannot occupy 0x%lx", __func__, len_total);
 		goto err_nova;
 	}
 	srmmu_mapiorange(0, virt_to_phys(va), res->start, len_total);
 
-	*pba = virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
+	*dma_handle = virt_to_phys(va);
 	return (void *) res->start;
 
 err_nova:
@@ -481,184 +481,53 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
 }
 
 /* Free and unmap a consistent DMA buffer.
- * cpu_addr is what was returned from pci_alloc_consistent,
- * size must be the same as what as passed into pci_alloc_consistent,
- * and likewise dma_addr must be the same as what *dma_addrp was set to.
+ * cpu_addr is what was returned arch_dma_alloc, size must be the same as what
+ * was passed into arch_dma_alloc, and likewise dma_addr must be the same as
+ * what *dma_ndler was set to.
  *
  * References to the memory and mappings associated with cpu_addr/dma_addr
  * past this call are illegal.
  */
-static void pci32_free_coherent(struct device *dev, size_t n, void *p,
-				dma_addr_t ba, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct resource *res;
 
 	if ((res = lookup_resource(&_sparc_dvma,
-	    (unsigned long)p)) = NULL) {
-		printk("pci_free_consistent: cannot free %p\n", p);
+	    (unsigned long)cpu_addr)) = NULL) {
+		printk("%s: cannot free %p\n", __func__, cpu_addr);
 		return;
 	}
 
-	if (((unsigned long)p & (PAGE_SIZE-1)) != 0) {
-		printk("pci_free_consistent: unaligned va %p\n", p);
+	if (((unsigned long)cpu_addr & (PAGE_SIZE-1)) != 0) {
+		printk("%s: unaligned va %p\n", __func__, cpu_addr);
 		return;
 	}
 
-	n = PAGE_ALIGN(n);
-	if (resource_size(res) != n) {
-		printk("pci_free_consistent: region 0x%lx asked 0x%lx\n",
-		    (long)resource_size(res), (long)n);
+	size = PAGE_ALIGN(size);
+	if (resource_size(res) != size) {
+		printk("%s: region 0x%lx asked 0x%zx\n", __func__,
+		    (long)resource_size(res), size);
 		return;
 	}
 
-	dma_make_coherent(ba, n);
-	srmmu_unmapiorange((unsigned long)p, n);
+	dma_make_coherent(dma_addr, size);
+	srmmu_unmapiorange((unsigned long)cpu_addr, size);
 
 	release_resource(res);
 	kfree(res);
-	free_pages((unsigned long)phys_to_virt(ba), get_order(n));
-}
-
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
-
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
-{
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
+	free_pages((unsigned long)phys_to_virt(dma_addr), get_order(size));
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
+/* IIep is write-through, not flushing on cpu to device transfer. */
 
-static void pci32_sync_sg_for_device(struct device *device, struct scatterlist *sgl,
-				     int nents, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	struct scatterlist *sg;
-	int n;
-
-	if (dir != PCI_DMA_TODEVICE) {
-		for_each_sg(sgl, sg, nents, n) {
-			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
-		}
-	}
+	if (dir != PCI_DMA_TODEVICE)
+		dma_make_coherent(paddr, PAGE_ALIGN(size));
 }
 
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
2.18.0

