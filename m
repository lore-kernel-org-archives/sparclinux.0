From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:15 +0000
Subject: [PATCH 10/16] mn10300: convert to dma_map_ops
Message-Id: <1447093041-21832-11-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mn10300/Kconfig                   |   2 +
 arch/mn10300/include/asm/dma-mapping.h | 161 +--------------------------------
 arch/mn10300/mm/dma-alloc.c            |  67 ++++++++++++--
 3 files changed, 67 insertions(+), 163 deletions(-)

diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 4434b54..1bf3af2 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -13,6 +13,8 @@ config MN10300
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select HAVE_DEBUG_STACKOVERFLOW
+	select ARCH_NO_COHERENT_DMA_MMAP
+	select HAVE_DMA_ATTRS
 
 config AM33_2
 	def_bool n
diff --git a/arch/mn10300/include/asm/dma-mapping.h b/arch/mn10300/include/asm/dma-mapping.h
index a18abfc..e69b013 100644
--- a/arch/mn10300/include/asm/dma-mapping.h
+++ b/arch/mn10300/include/asm/dma-mapping.h
@@ -11,154 +11,14 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-
 #include <asm/cache.h>
 #include <asm/io.h>
 
-/*
- * See Documentation/DMA-API.txt for the description of how the
- * following DMA API should work.
- */
-
-extern void *dma_alloc_coherent(struct device *dev, size_t size,
-				dma_addr_t *dma_handle, int flag);
-
-extern void dma_free_coherent(struct device *dev, size_t size,
-			      void *vaddr, dma_addr_t dma_handle);
-
-#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent((d), (s), (h), (f))
-#define dma_free_noncoherent(d, s, v, h)  dma_free_coherent((d), (s), (v), (h))
-
-static inline
-dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-			  enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-	mn10300_dcache_flush_inv();
-	return virt_to_bus(ptr);
-}
-
-static inline
-void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		      enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-}
-
-static inline
-int dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
-	       enum dma_data_direction direction)
-{
-	struct scatterlist *sg;
-	int i;
-
-	BUG_ON(!valid_dma_direction(direction));
-	WARN_ON(nents = 0 || sglist[0].length = 0);
-
-	for_each_sg(sglist, sg, nents, i) {
-		BUG_ON(!sg_page(sg));
-
-		sg->dma_address = sg_phys(sg);
-	}
-
-	mn10300_dcache_flush_inv();
-	return nents;
-}
-
-static inline
-void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-		  enum dma_data_direction direction)
-{
-	BUG_ON(!valid_dma_direction(direction));
-}
-
-static inline
-dma_addr_t dma_map_page(struct device *dev, struct page *page,
-			unsigned long offset, size_t size,
-			enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-	return page_to_bus(page) + offset;
-}
-
-static inline
-void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-		    enum dma_data_direction direction)
-{
-	BUG_ON(direction = DMA_NONE);
-}
-
-static inline
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-			     size_t size, enum dma_data_direction direction)
-{
-}
-
-static inline
-void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-				size_t size, enum dma_data_direction direction)
-{
-	mn10300_dcache_flush_inv();
-}
-
-static inline
-void dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction direction)
-{
-}
-
-static inline void
-dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction direction)
-{
-	mn10300_dcache_flush_inv();
-}
-
+extern struct dma_map_ops mn10300_dma_ops;
 
-static inline
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-			 int nelems, enum dma_data_direction direction)
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-}
-
-static inline
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			    int nelems, enum dma_data_direction direction)
-{
-	mn10300_dcache_flush_inv();
-}
-
-static inline
-int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline
-int dma_supported(struct device *dev, u64 mask)
-{
-	/*
-	 * we fall back to GFP_DMA when the mask isn't all 1s, so we can't
-	 * guarantee allocations that must be within a tighter range than
-	 * GFP_DMA
-	 */
-	if (mask < 0x00ffffff)
-		return 0;
-	return 1;
-}
-
-static inline
-int dma_set_mask(struct device *dev, u64 mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, mask))
-		return -EIO;
-
-	*dev->dma_mask = mask;
-	return 0;
+	return &mn10300_dma_ops;
 }
 
 static inline
@@ -168,19 +28,6 @@ void dma_cache_sync(void *vaddr, size_t size,
 	mn10300_dcache_flush_inv();
 }
 
-/* Not supported for now */
-static inline int dma_mmap_coherent(struct device *dev,
-				    struct vm_area_struct *vma, void *cpu_addr,
-				    dma_addr_t dma_addr, size_t size)
-{
-	return -EINVAL;
-}
-
-static inline int dma_get_sgtable(struct device *dev, struct sg_table *sgt,
-				  void *cpu_addr, dma_addr_t dma_addr,
-				  size_t size)
-{
-	return -EINVAL;
-}
+#include <asm-generic/dma-mapping-common.h>
 
 #endif
diff --git a/arch/mn10300/mm/dma-alloc.c b/arch/mn10300/mm/dma-alloc.c
index e244ebe..8842394 100644
--- a/arch/mn10300/mm/dma-alloc.c
+++ b/arch/mn10300/mm/dma-alloc.c
@@ -20,8 +20,8 @@
 
 static unsigned long pci_sram_allocated = 0xbc000000;
 
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *dma_handle, int gfp)
+static void *mn10300_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
 	unsigned long addr;
 	void *ret;
@@ -61,10 +61,9 @@ done:
 	printk("dma_alloc_coherent() = %p [%x]\n", ret, *dma_handle);
 	return ret;
 }
-EXPORT_SYMBOL(dma_alloc_coherent);
 
-void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-		       dma_addr_t dma_handle)
+static void mn10300_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	unsigned long addr = (unsigned long) vaddr & ~0x20000000;
 
@@ -73,4 +72,60 @@ void dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 	free_pages(addr, get_order(size));
 }
-EXPORT_SYMBOL(dma_free_coherent);
+
+static int mn10300_dma_map_sg(struct device *dev, struct scatterlist *sglist,
+		int nents, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sglist, sg, nents, i) {
+		BUG_ON(!sg_page(sg));
+
+		sg->dma_address = sg_phys(sg);
+	}
+
+	mn10300_dcache_flush_inv();
+	return nents;
+}
+
+static dma_addr_t mn10300_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction direction, struct dma_attrs *attrs)
+{
+	return page_to_bus(page) + offset;
+}
+
+static void mn10300_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
+				size_t size, enum dma_data_direction direction)
+{
+	mn10300_dcache_flush_inv();
+}
+
+static void mn10300_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+			    int nelems, enum dma_data_direction direction)
+{
+	mn10300_dcache_flush_inv();
+}
+
+static int mn10300_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s, so we can't
+	 * guarantee allocations that must be within a tighter range than
+	 * GFP_DMA
+	 */
+	if (mask < 0x00ffffff)
+		return 0;
+	return 1;
+}
+
+struct dma_map_ops mn10300_dma_ops = {
+	.alloc			= mn10300_dma_alloc,
+	.free			= mn10300_dma_free,
+	.map_page		= mn10300_dma_map_page,
+	.map_sg			= mn10300_dma_map_sg,
+	.sync_single_for_device	= mn10300_dma_sync_single_for_device,
+	.sync_sg_for_device	= mn10300_dma_sync_sg_for_device,
+};
-- 
1.9.1

