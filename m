From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:11 +0000
Subject: [PATCH 06/16] cris: convert to dma_map_ops
Message-Id: <1447093041-21832-7-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/cris/Kconfig                    |   1 +
 arch/cris/arch-v32/drivers/pci/dma.c |  54 +++++++++---
 arch/cris/include/asm/dma-mapping.h  | 161 ++---------------------------------
 3 files changed, 51 insertions(+), 165 deletions(-)

diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index e086f9e..f5dd700 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -69,6 +69,7 @@ config CRIS
 	select GENERIC_CLOCKEVENTS if ETRAX_ARCH_V32
 	select GENERIC_SCHED_CLOCK if ETRAX_ARCH_V32
 	select HAVE_DEBUG_BUGVERBOSE if ETRAX_ARCH_V32
+	select HAVE_DMA_ATTRS
 
 config HZ
 	int
diff --git a/arch/cris/arch-v32/drivers/pci/dma.c b/arch/cris/arch-v32/drivers/pci/dma.c
index ee55578..8d5efa5 100644
--- a/arch/cris/arch-v32/drivers/pci/dma.c
+++ b/arch/cris/arch-v32/drivers/pci/dma.c
@@ -16,21 +16,18 @@
 #include <linux/gfp.h>
 #include <asm/io.h>
 
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t gfp)
+static void *v32_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp,  struct dma_attrs *attrs)
 {
 	void *ret;
-	int order = get_order(size);
+
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
-	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
-		return ret;
-
 	if (dev = NULL || (dev->coherent_dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 
-	ret = (void *)__get_free_pages(gfp, order);
+	ret = (void *)__get_free_pages(gfp,  get_order(size));
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
@@ -39,12 +36,45 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-void dma_free_coherent(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle)
+static void v32_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, struct dma_attrs *attrs)
+{
+	free_pages((unsigned long)vaddr, get_order(size));
+}
+
+static inline dma_addr_t v32_dma_map_page(struct device *dev,
+		struct page *page, unsigned long offset, size_t size,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
-	int order = get_order(size);
+	return page_to_phys(page) + offset;
+}
 
-	if (!dma_release_from_coherent(dev, order, vaddr))
-		free_pages((unsigned long)vaddr, order);
+static inline int v32_dma_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
+{
+	printk("Map sg\n");
+	return nents;
+}
+
+static inline int v32_dma_supported(struct device *dev, u64 mask)
+{
+        /*
+         * we fall back to GFP_DMA when the mask isn't all 1s,
+         * so we can't guarantee allocations that must be
+         * within a tighter range than GFP_DMA..
+         */
+        if (mask < 0x00ffffff)
+                return 0;
+	return 1;
 }
 
+struct dma_map_ops v32_dma_ops = {
+	.alloc			= v32_dma_alloc,
+	.free			= v32_dma_free,
+	.map_page		= v32_dma_map_page,
+	.map_sg                 = v32_dma_map_sg,
+	.dma_supported		= v32_dma_supported,
+};
+EXPORT_SYMBOL(v32_dma_ops);
diff --git a/arch/cris/include/asm/dma-mapping.h b/arch/cris/include/asm/dma-mapping.h
index 57f794e..34e7c7c 100644
--- a/arch/cris/include/asm/dma-mapping.h
+++ b/arch/cris/include/asm/dma-mapping.h
@@ -1,156 +1,22 @@
-/* DMA mapping. Nothing tricky here, just virt_to_phys */
-
 #ifndef _ASM_CRIS_DMA_MAPPING_H
 #define _ASM_CRIS_DMA_MAPPING_H
 
-#include <linux/mm.h>
-#include <linux/kernel.h>
-#include <linux/scatterlist.h>
-
-#include <asm/cache.h>
-#include <asm/io.h>
-
-#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
-#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-
 #ifdef CONFIG_PCI
-#include <asm-generic/dma-coherent.h>
-
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flag);
+extern struct dma_map_ops v32_dma_ops;
 
-void dma_free_coherent(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle);
-#else
-static inline void *
-dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-                   gfp_t flag)
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-        BUG();
-        return NULL;
+	return &v32_dma_ops;
 }
-
-static inline void
-dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
-                    dma_addr_t dma_handle)
+#else
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-        BUG();
+	BUG();
+	return NULL;
 }
 #endif
-static inline dma_addr_t
-dma_map_single(struct device *dev, void *ptr, size_t size,
-	       enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-	return virt_to_phys(ptr);
-}
-
-static inline void
-dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-}
-
-static inline int
-dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
-{
-	printk("Map sg\n");
-	return nents;
-}
-
-static inline dma_addr_t
-dma_map_page(struct device *dev, struct page *page, unsigned long offset,
-	     size_t size, enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-	return page_to_phys(page) + offset;
-}
-
-static inline void
-dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-}
-
-
-static inline void
-dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-}
-
-static inline void
-dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
-{
-}
-
-static inline void
-dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
-{
-}
-
-static inline void
-dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-			      unsigned long offset, size_t size,
-			      enum dma_data_direction direction)
-{
-}
 
-static inline void
-dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction direction)
-{
-}
-
-static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
-{
-}
-
-static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
-{
-}
-
-static inline int
-dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int
-dma_supported(struct device *dev, u64 mask)
-{
-        /*
-         * we fall back to GFP_DMA when the mask isn't all 1s,
-         * so we can't guarantee allocations that must be
-         * within a tighter range than GFP_DMA..
-         */
-        if(mask < 0x00ffffff)
-                return 0;
-
-	return 1;
-}
-
-static inline int
-dma_set_mask(struct device *dev, u64 mask)
-{
-	if(!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	*dev->dma_mask = mask;
-
-	return 0;
-}
+#include <asm-generic/dma-mapping-common.h>
 
 static inline void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
@@ -158,15 +24,4 @@ dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 {
 }
 
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
-
 #endif
-- 
1.9.1

