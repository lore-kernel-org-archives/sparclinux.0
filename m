From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:30 +0000
Subject: [PATCH 25/25] parisc: use generic dma_noncoherent_ops
Message-Id: <20180522120430.28709-26-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

Fix sync_single_for_cpu to do skip the cache flush unless the transfer
is to the device to match the more tested unmap_single path which should
have the same cache coherency implications.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/Kconfig                   |   4 +
 arch/parisc/include/asm/dma-mapping.h |   4 -
 arch/parisc/kernel/pci-dma.c          | 145 ++------------------------
 arch/parisc/kernel/setup.c            |   2 +-
 4 files changed, 16 insertions(+), 139 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 4d8f64d48597..4993c6dc8358 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -188,6 +188,10 @@ config PA20
 config PA11
 	def_bool y
 	depends on PA7000 || PA7100LC || PA7200 || PA7300LC
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_NONCOHERENT_OPS
+	select DMA_NONCOHERENT_CACHE_SYNC
 
 config PREFETCH
 	def_bool y
diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index eeec8dd18e74..44a9f97194aa 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -21,10 +21,6 @@
 ** flush/purge and allocate "regular" cacheable pages for everything.
 */
 
-#ifdef CONFIG_PA11
-extern const struct dma_map_ops pa11_dma_ops;
-#endif
-
 extern const struct dma_map_ops *hppa_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 4d7506336918..87a7926cda6f 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -21,13 +21,12 @@
 #include <linux/init.h>
 #include <linux/gfp.h>
 #include <linux/mm.h>
-#include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/scatterlist.h>
-#include <linux/export.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 
 #include <asm/cacheflush.h>
 #include <asm/dma.h>    /* for DMA_CHUNK_SIZE */
@@ -450,7 +449,7 @@ static void *pcx_dma_alloc(struct device *dev, size_t size,
 	return addr;
 }
 
-static void *pa11_dma_alloc(struct device *dev, size_t size,
+void *arch_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 
@@ -460,7 +459,7 @@ static void *pa11_dma_alloc(struct device *dev, size_t size,
 		return pcx_dma_alloc(dev, size, dma_handle, gfp, attrs);
 }
 
-static void pa11_dma_free(struct device *dev, size_t size, void *vaddr,
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order = get_order(size);
@@ -475,142 +474,20 @@ static void pa11_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages((unsigned long)vaddr, get_order(size));
 }
 
-static dma_addr_t pa11_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size,
-		enum dma_data_direction direction, unsigned long attrs)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	void *addr = page_address(page) + offset;
-	BUG_ON(direction = DMA_NONE);
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		flush_kernel_dcache_range((unsigned long) addr, size);
-
-	return virt_to_phys(addr);
-}
-
-static void pa11_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	BUG_ON(direction = DMA_NONE);
-
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return;
-
-	if (direction = DMA_TO_DEVICE)
-		return;
-
-	/*
-	 * For PCI_DMA_FROMDEVICE this flush is not necessary for the
-	 * simple map/unmap case. However, it IS necessary if if
-	 * pci_dma_sync_single_* has been called and the buffer reused.
-	 */
-
-	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle), size);
-}
-
-static int pa11_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	BUG_ON(direction = DMA_NONE);
-
-	for_each_sg(sglist, sg, nents, i) {
-		unsigned long vaddr = (unsigned long)sg_virt(sg);
-
-		sg_dma_address(sg) = (dma_addr_t) virt_to_phys(vaddr);
-		sg_dma_len(sg) = sg->length;
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		flush_kernel_dcache_range(vaddr, sg->length);
-	}
-	return nents;
-}
-
-static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	BUG_ON(direction = DMA_NONE);
-
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return;
-
-	if (direction = DMA_TO_DEVICE)
-		return;
-
-	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
-
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_dcache_range(sg_virt(sg), sg->length);
-}
-
-static void pa11_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-
-	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle),
-			size);
-}
-
-static void pa11_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-
-	flush_kernel_dcache_range((unsigned long) phys_to_virt(dma_handle),
-			size);
-}
-
-static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
-{
-	int i;
-	struct scatterlist *sg;
-
-	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
-
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_dcache_range(sg_virt(sg), sg->length);
+	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
-static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	int i;
-	struct scatterlist *sg;
-
-	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
-
-	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_dcache_range(sg_virt(sg), sg->length);
+	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
-static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	flush_kernel_dcache_range((unsigned long)vaddr, size);
 }
-
-const struct dma_map_ops pa11_dma_ops = {
-	.alloc =		pa11_dma_alloc,
-	.free =			pa11_dma_free,
-	.map_page =		pa11_dma_map_page,
-	.unmap_page =		pa11_dma_unmap_page,
-	.map_sg =		pa11_dma_map_sg,
-	.unmap_sg =		pa11_dma_unmap_sg,
-	.sync_single_for_cpu =	pa11_dma_sync_single_for_cpu,
-	.sync_single_for_device = pa11_dma_sync_single_for_device,
-	.sync_sg_for_cpu =	pa11_dma_sync_sg_for_cpu,
-	.sync_sg_for_device =	pa11_dma_sync_sg_for_device,
-	.cache_sync =		pa11_dma_cache_sync,
-};
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 5c8450a22255..4e87c35c22b7 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -102,7 +102,7 @@ void __init dma_ops_init(void)
 	case pcxl: /* falls through */
 	case pcxs:
 	case pcxt:
-		hppa_dma_ops = &pa11_dma_ops;
+		hppa_dma_ops = &dma_noncoherent_ops;
 		break;
 	default:
 		break;
-- 
2.17.0

