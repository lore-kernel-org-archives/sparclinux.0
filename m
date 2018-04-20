From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 08:03:11 +0000
Subject: [PATCH 20/22] xtensa: use generic dma_noncoherent_ops
Message-Id: <20180420080313.18796-21-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
In-Reply-To: <20180420080313.18796-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/Kconfig                   |   3 +
 arch/xtensa/include/asm/Kbuild        |   1 +
 arch/xtensa/include/asm/dma-mapping.h |  26 ------
 arch/xtensa/kernel/pci-dma.c          | 130 +++-----------------------
 4 files changed, 19 insertions(+), 141 deletions(-)
 delete mode 100644 arch/xtensa/include/asm/dma-mapping.h

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c921e8bccdc8..6035845f30a7 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -5,11 +5,14 @@ config ZONE_DMA
 config XTENSA
 	def_bool y
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DMA_NONCOHERENT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_SHOW
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 436b20337168..a8d6cd3bee4b 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += bug.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma-contiguous.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
deleted file mode 100644
index 44098800dad7..000000000000
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 - 2005 Tensilica Inc.
- * Copyright (C) 2015 Cadence Design Systems Inc.
- */
-
-#ifndef _XTENSA_DMA_MAPPING_H
-#define _XTENSA_DMA_MAPPING_H
-
-#include <asm/cache.h>
-#include <asm/io.h>
-
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-
-extern const struct dma_map_ops xtensa_dma_map_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	return &xtensa_dma_map_ops;
-}
-
-#endif	/* _XTENSA_DMA_MAPPING_H */
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 392b4a80ebc2..a83d60e92908 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -16,26 +16,24 @@
  */
 
 #include <linux/dma-contiguous.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/dma-direct.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
-static void do_cache_op(dma_addr_t dma_handle, size_t size,
+static void do_cache_op(phys_addr_t paddr, size_t size,
 			void (*fn)(unsigned long, unsigned long))
 {
-	unsigned long off = dma_handle & (PAGE_SIZE - 1);
-	unsigned long pfn = PFN_DOWN(dma_handle);
+	unsigned long off = paddr & (PAGE_SIZE - 1);
+	unsigned long pfn = PFN_DOWN(paddr);
 	struct page *page = pfn_to_page(pfn);
 
 	if (!PageHighMem(page))
-		fn((unsigned long)bus_to_virt(dma_handle), size);
+		fn((unsigned long)phys_to_virt(paddr), size);
 	else
 		while (size > 0) {
 			size_t sz = min_t(size_t, size, PAGE_SIZE - off);
@@ -49,14 +47,13 @@ static void do_cache_op(dma_addr_t dma_handle, size_t size,
 		}
 }
 
-static void xtensa_sync_single_for_cpu(struct device *dev,
-				       dma_addr_t dma_handle, size_t size,
-				       enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
 	case DMA_FROM_DEVICE:
-		do_cache_op(dma_handle, size, __invalidate_dcache_range);
+		do_cache_op(paddr, size, __invalidate_dcache_range);
 		break;
 
 	case DMA_NONE:
@@ -68,15 +65,14 @@ static void xtensa_sync_single_for_cpu(struct device *dev,
 	}
 }
 
-static void xtensa_sync_single_for_device(struct device *dev,
-					  dma_addr_t dma_handle, size_t size,
-					  enum dma_data_direction dir)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
 	case DMA_TO_DEVICE:
 		if (XCHAL_DCACHE_IS_WRITEBACK)
-			do_cache_op(dma_handle, size, __flush_dcache_range);
+			do_cache_op(paddr, size, __flush_dcache_range);
 		break;
 
 	case DMA_NONE:
@@ -88,40 +84,13 @@ static void xtensa_sync_single_for_device(struct device *dev,
 	}
 }
 
-static void xtensa_sync_sg_for_cpu(struct device *dev,
-				   struct scatterlist *sg, int nents,
-				   enum dma_data_direction dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		xtensa_sync_single_for_cpu(dev, sg_dma_address(s),
-					   sg_dma_len(s), dir);
-	}
-}
-
-static void xtensa_sync_sg_for_device(struct device *dev,
-				      struct scatterlist *sg, int nents,
-				      enum dma_data_direction dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		xtensa_sync_single_for_device(dev, sg_dma_address(s),
-					      sg_dma_len(s), dir);
-	}
-}
-
 /*
  * Note: We assume that the full memory space is always mapped to 'kseg'
  *	 Otherwise we have to use page attributes (not implemented).
  */
 
-static void *xtensa_dma_alloc(struct device *dev, size_t size,
-			      dma_addr_t *handle, gfp_t flag,
-			      unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		gfp_t flag, unsigned long attrs)
 {
 	unsigned long ret;
 	unsigned long uncached;
@@ -171,8 +140,8 @@ static void *xtensa_dma_alloc(struct device *dev, size_t size,
 	return (void *)uncached;
 }
 
-static void xtensa_dma_free(struct device *dev, size_t size, void *vaddr,
-			    dma_addr_t dma_handle, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
 {
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long addr = (unsigned long)vaddr;
@@ -192,72 +161,3 @@ static void xtensa_dma_free(struct device *dev, size_t size, void *vaddr,
 	if (!dma_release_from_contiguous(dev, page, count))
 		__free_pages(page, get_order(size));
 }
-
-static dma_addr_t xtensa_map_page(struct device *dev, struct page *page,
-				  unsigned long offset, size_t size,
-				  enum dma_data_direction dir,
-				  unsigned long attrs)
-{
-	dma_addr_t dma_handle = page_to_phys(page) + offset;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		xtensa_sync_single_for_device(dev, dma_handle, size, dir);
-
-	return dma_handle;
-}
-
-static void xtensa_unmap_page(struct device *dev, dma_addr_t dma_handle,
-			      size_t size, enum dma_data_direction dir,
-			      unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		xtensa_sync_single_for_cpu(dev, dma_handle, size, dir);
-}
-
-static int xtensa_map_sg(struct device *dev, struct scatterlist *sg,
-			 int nents, enum dma_data_direction dir,
-			 unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = xtensa_map_page(dev, sg_page(s), s->offset,
-						 s->length, dir, attrs);
-	}
-	return nents;
-}
-
-static void xtensa_unmap_sg(struct device *dev,
-			    struct scatterlist *sg, int nents,
-			    enum dma_data_direction dir,
-			    unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		xtensa_unmap_page(dev, sg_dma_address(s),
-				  sg_dma_len(s), dir, attrs);
-	}
-}
-
-int xtensa_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-const struct dma_map_ops xtensa_dma_map_ops = {
-	.alloc = xtensa_dma_alloc,
-	.free = xtensa_dma_free,
-	.map_page = xtensa_map_page,
-	.unmap_page = xtensa_unmap_page,
-	.map_sg = xtensa_map_sg,
-	.unmap_sg = xtensa_unmap_sg,
-	.sync_single_for_cpu = xtensa_sync_single_for_cpu,
-	.sync_single_for_device = xtensa_sync_single_for_device,
-	.sync_sg_for_cpu = xtensa_sync_sg_for_cpu,
-	.sync_sg_for_device = xtensa_sync_sg_for_device,
-	.mapping_error = xtensa_dma_mapping_error,
-};
-EXPORT_SYMBOL(xtensa_dma_map_ops);
-- 
2.17.0

