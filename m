From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:07 +0000
Subject: [PATCH 02/16] arc: convert to dma_map_ops
Message-Id: <1447093041-21832-3-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Koichi Yasutake <yasutake.koichi-NAum8xwdG0+S7A1Ibl2khg@public.gmane.org>, Chris Metcalf <cmetcalf-d5a29ZRxExrQT0dZR+AlfA@public.gmane.org>, linux-snps-arc-IAPFreCvJWPLiZjB17Co1B2eb7JE58TQ@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-cris-kernel-VrBV9hrLPhE@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig                   |   1 +
 arch/arc/include/asm/dma-mapping.h | 187 +------------------------------------
 arch/arc/mm/dma.c                  | 151 ++++++++++++++++++++----------
 3 files changed, 109 insertions(+), 230 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2c2ac3f..fdf217c 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -38,6 +38,7 @@ config ARC
 	select OF_EARLY_FLATTREE
 	select PERF_USE_VMALLOC
 	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DMA_ATTRS
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
index 2d28ba9..2a617f9 100644
--- a/arch/arc/include/asm/dma-mapping.h
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -11,192 +11,13 @@
 #ifndef ASM_ARC_DMA_MAPPING_H
 #define ASM_ARC_DMA_MAPPING_H
 
-#include <asm-generic/dma-coherent.h>
-#include <asm/cacheflush.h>
+extern struct dma_map_ops arc_dma_ops;
 
-void *dma_alloc_noncoherent(struct device *dev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t gfp);
-
-void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
-			  dma_addr_t dma_handle);
-
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *dma_handle, gfp_t gfp);
-
-void dma_free_coherent(struct device *dev, size_t size, void *kvaddr,
-		       dma_addr_t dma_handle);
-
-/* drivers/base/dma-mapping.c */
-extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
-			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
-extern int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
-				  void *cpu_addr, dma_addr_t dma_addr,
-				  size_t size);
-
-#define dma_mmap_coherent(d, v, c, h, s) dma_common_mmap(d, v, c, h, s)
-#define dma_get_sgtable(d, t, v, h, s) dma_common_get_sgtable(d, t, v, h, s)
-
-/*
- * streaming DMA Mapping API...
- * CPU accesses page via normal paddr, thus needs to explicitly made
- * consistent before each use
- */
-
-static inline void __inline_dma_cache_sync(unsigned long paddr, size_t size,
-					   enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_FROM_DEVICE:
-		dma_cache_inv(paddr, size);
-		break;
-	case DMA_TO_DEVICE:
-		dma_cache_wback(paddr, size);
-		break;
-	case DMA_BIDIRECTIONAL:
-		dma_cache_wback_inv(paddr, size);
-		break;
-	default:
-		pr_err("Invalid DMA dir [%d] for OP @ %lx\n", dir, paddr);
-	}
-}
-
-void __arc_dma_cache_sync(unsigned long paddr, size_t size,
-			  enum dma_data_direction dir);
-
-#define _dma_cache_sync(addr, sz, dir)			\
-do {							\
-	if (__builtin_constant_p(dir))			\
-		__inline_dma_cache_sync(addr, sz, dir);	\
-	else						\
-		__arc_dma_cache_sync(addr, sz, dir);	\
-}							\
-while (0);
-
-static inline dma_addr_t
-dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-	       enum dma_data_direction dir)
-{
-	_dma_cache_sync((unsigned long)cpu_addr, size, dir);
-	return (dma_addr_t)cpu_addr;
-}
-
-static inline void
-dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
-		 size_t size, enum dma_data_direction dir)
-{
-}
-
-static inline dma_addr_t
-dma_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size,
-	     enum dma_data_direction dir)
-{
-	unsigned long paddr = page_to_phys(page) + offset;
-	return dma_map_single(dev, (void *)paddr, size, dir);
-}
-
-static inline void
-dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
-	       size_t size, enum dma_data_direction dir)
-{
-}
-
-static inline int
-dma_map_sg(struct device *dev, struct scatterlist *sg,
-	   int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir);
-
-	return nents;
-}
-
-static inline void
-dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-	     int nents, enum dma_data_direction dir)
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
-}
-
-static inline void
-dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-			size_t size, enum dma_data_direction dir)
-{
-	_dma_cache_sync(dma_handle, size, DMA_FROM_DEVICE);
-}
-
-static inline void
-dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-			   size_t size, enum dma_data_direction dir)
-{
-	_dma_cache_sync(dma_handle, size, DMA_TO_DEVICE);
-}
-
-static inline void
-dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-			      unsigned long offset, size_t size,
-			      enum dma_data_direction direction)
-{
-	_dma_cache_sync(dma_handle + offset, size, DMA_FROM_DEVICE);
-}
-
-static inline void
-dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction direction)
-{
-	_dma_cache_sync(dma_handle + offset, size, DMA_TO_DEVICE);
+	return &arc_dma_ops;
 }
 
-static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
-		    enum dma_data_direction dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
-}
-
-static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
-		       int nelems, enum dma_data_direction dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
-}
-
-static inline int dma_supported(struct device *dev, u64 dma_mask)
-{
-	/* Support 32 bit DMA mask exclusively */
-	return dma_mask = DMA_BIT_MASK(32);
-}
-
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
-	*dev->dma_mask = dma_mask;
-
-	return 0;
-}
+#include <asm-generic/dma-mapping-common.h>
 
 #endif
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 29a46bb..da289cb 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -17,18 +17,14 @@
  */
 
 #include <linux/dma-mapping.h>
-#include <linux/dma-debug.h>
-#include <linux/export.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 
-/*
- * Helpers for Coherent DMA API.
- */
-void *dma_alloc_noncoherent(struct device *dev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t gfp)
+
+static void *arc_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	void *paddr;
+	void *paddr, *kvaddr;
 
 	/* This is linear addr (0x8000_0000 based) */
 	paddr = alloc_pages_exact(size, gfp);
@@ -38,22 +34,6 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
 	/* This is bus address, platform dependent */
 	*dma_handle = (dma_addr_t)paddr;
 
-	return paddr;
-}
-EXPORT_SYMBOL(dma_alloc_noncoherent);
-
-void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
-			  dma_addr_t dma_handle)
-{
-	free_pages_exact((void *)dma_handle, size);
-}
-EXPORT_SYMBOL(dma_free_noncoherent);
-
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *dma_handle, gfp_t gfp)
-{
-	void *paddr, *kvaddr;
-
 	/*
 	 * IOC relies on all data (even coherent DMA data) being in cache
 	 * Thus allocate normal cached memory
@@ -65,22 +45,15 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 	 *   -For coherent data, Read/Write to buffers terminate early in cache
 	 *   (vs. always going to memory - thus are faster)
 	 */
-	if (is_isa_arcv2() && ioc_exists)
-		return dma_alloc_noncoherent(dev, size, dma_handle, gfp);
-
-	/* This is linear addr (0x8000_0000 based) */
-	paddr = alloc_pages_exact(size, gfp);
-	if (!paddr)
-		return NULL;
+	if ((is_isa_arcv2() && ioc_exists) ||
+	    dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs)
+		return paddr;
 
 	/* This is kernel Virtual address (0x7000_0000 based) */
 	kvaddr = ioremap_nocache((unsigned long)paddr, size);
 	if (kvaddr = NULL)
 		return NULL;
 
-	/* This is bus address, platform dependent */
-	*dma_handle = (dma_addr_t)paddr;
-
 	/*
 	 * Evict any existing L1 and/or L2 lines for the backing page
 	 * in case it was used earlier as a normal "cached" page.
@@ -95,26 +68,110 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 
 	return kvaddr;
 }
-EXPORT_SYMBOL(dma_alloc_coherent);
 
-void dma_free_coherent(struct device *dev, size_t size, void *kvaddr,
-		       dma_addr_t dma_handle)
+static void arc_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
-	if (is_isa_arcv2() && ioc_exists)
-		return dma_free_noncoherent(dev, size, kvaddr, dma_handle);
-
-	iounmap((void __force __iomem *)kvaddr);
+	if (!(is_isa_arcv2() && ioc_exists) ||
+	    dma_get_attr(DMA_ATTR_NON_CONSISTENT, attrs))
+		iounmap((void __force __iomem *)kvaddr);
 
 	free_pages_exact((void *)dma_handle, size);
 }
-EXPORT_SYMBOL(dma_free_coherent);
 
 /*
- * Helper for streaming DMA...
+ * streaming DMA Mapping API...
+ * CPU accesses page via normal paddr, thus needs to explicitly made
+ * consistent before each use
  */
-void __arc_dma_cache_sync(unsigned long paddr, size_t size,
-			  enum dma_data_direction dir)
+static void _dma_cache_sync(unsigned long paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		dma_cache_inv(paddr, size);
+		break;
+	case DMA_TO_DEVICE:
+		dma_cache_wback(paddr, size);
+		break;
+	case DMA_BIDIRECTIONAL:
+		dma_cache_wback_inv(paddr, size);
+		break;
+	default:
+		pr_err("Invalid DMA dir [%d] for OP @ %lx\n", dir, paddr);
+	}
+}
+
+static dma_addr_t arc_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	unsigned long paddr = page_to_phys(page) + offset;
+	return dma_map_single(dev, (void *)paddr, size, dir);
+}
+
+static int arc_dma_map_sg(struct device *dev, struct scatterlist *sg,
+	   int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
+					       s->length, dir);
+
+	return nents;
+}
+
+static void arc_dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+{
+	_dma_cache_sync(dma_handle, size, DMA_FROM_DEVICE);
+}
+
+static void arc_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
-	__inline_dma_cache_sync(paddr, size, dir);
+	_dma_cache_sync(dma_handle, size, DMA_TO_DEVICE);
 }
-EXPORT_SYMBOL(__arc_dma_cache_sync);
+
+static void arm_dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sglist, int nelems,
+		enum dma_data_direction dir)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
+		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
+}
+
+static void arc_dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sglist, int nelems,
+		enum dma_data_direction dir)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i)
+		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
+}
+
+static int arc_dma_supported(struct device *dev, u64 dma_mask)
+{
+	/* Support 32 bit DMA mask exclusively */
+	return dma_mask = DMA_BIT_MASK(32);
+}
+
+struct dma_map_ops arc_dma_ops = {
+	.alloc			= arc_dma_alloc,
+	.free			= arc_dma_free,
+	.map_page		= arc_dma_map_page,
+	.map_sg			= arc_dma_map_sg,
+	.sync_single_for_device	= arc_dma_sync_single_for_device,
+	.sync_single_for_cpu	= arc_dma_sync_single_for_cpu,
+	.sync_sg_for_cpu	= arc_dma_sync_sg_for_cpu,
+	.sync_sg_for_dev	= arc_dma_sync_sg_for_device,
+	.dma_supported		= arc_dma_supported,
+};
+EXPORT_SYMBOL(arc_dma_ops);
-- 
1.9.1

