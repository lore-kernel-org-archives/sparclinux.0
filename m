From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:10 +0000
Subject: [PATCH 05/16] c6x: convert to dma_map_ops
Message-Id: <1447093041-21832-6-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/c6x/Kconfig                   |  2 +
 arch/c6x/include/asm/dma-mapping.h | 96 ++------------------------------------
 arch/c6x/kernel/dma.c              | 91 ++++++++++++++++--------------------
 3 files changed, 47 insertions(+), 142 deletions(-)

diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 77ea09b..8602f72 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -17,6 +17,8 @@ config C6X
 	select OF_EARLY_FLATTREE
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
+	select ARCH_NO_COHERENT_DMA_MMAP
+	select HAVE_DMA_ATTRS
 
 config MMU
 	def_bool n
diff --git a/arch/c6x/include/asm/dma-mapping.h b/arch/c6x/include/asm/dma-mapping.h
index bbd7774..6aa20fd 100644
--- a/arch/c6x/include/asm/dma-mapping.h
+++ b/arch/c6x/include/asm/dma-mapping.h
@@ -12,104 +12,18 @@
 #ifndef _ASM_C6X_DMA_MAPPING_H
 #define _ASM_C6X_DMA_MAPPING_H
 
-#include <linux/dma-debug.h>
-#include <asm-generic/dma-coherent.h>
-
-#define dma_supported(d, m)	1
-
-static inline void dma_sync_single_range_for_device(struct device *dev,
-						    dma_addr_t addr,
-						    unsigned long offset,
-						    size_t size,
-						    enum dma_data_direction dir)
-{
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
-
 /*
  * DMA errors are defined by all-bits-set in the DMA address.
  */
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	debug_dma_mapping_error(dev, dma_addr);
-	return dma_addr = ~0;
-}
-
-extern dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
-				 size_t size, enum dma_data_direction dir);
+#define DMA_ERROR_CODE ~0
 
-extern void dma_unmap_single(struct device *dev, dma_addr_t handle,
-			     size_t size, enum dma_data_direction dir);
+extern struct dma_map_ops c6x_dma_ops;
 
-extern int dma_map_sg(struct device *dev, struct scatterlist *sglist,
-		      int nents, enum dma_data_direction direction);
-
-extern void dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-			 int nents, enum dma_data_direction direction);
-
-static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
-				      unsigned long offset, size_t size,
-				      enum dma_data_direction dir)
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	dma_addr_t handle;
-
-	handle = dma_map_single(dev, page_address(page) + offset, size, dir);
-
-	debug_dma_map_page(dev, page, offset, size, dir, handle, false);
-
-	return handle;
-}
-
-static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir)
-{
-	dma_unmap_single(dev, handle, size, dir);
-
-	debug_dma_unmap_page(dev, handle, size, dir, false);
-}
-
-extern void dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
-				    size_t size, enum dma_data_direction dir);
-
-extern void dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				       size_t size,
-				       enum dma_data_direction dir);
-
-extern void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction dir);
-
-extern void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-				   int nents, enum dma_data_direction dir);
-
-extern void coherent_mem_init(u32 start, u32 size);
-extern void *dma_alloc_coherent(struct device *, size_t, dma_addr_t *, gfp_t);
-extern void dma_free_coherent(struct device *, size_t, void *, dma_addr_t);
-
-#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent((d), (s), (h), (f))
-#define dma_free_noncoherent(d, s, v, h)  dma_free_coherent((d), (s), (v), (h))
-
-/* Not supported for now */
-static inline int dma_mmap_coherent(struct device *dev,
-				    struct vm_area_struct *vma, void *cpu_addr,
-				    dma_addr_t dma_addr, size_t size)
-{
-	return -EINVAL;
+	return &c6x_dma_ops;
 }
 
-static inline int dma_get_sgtable(struct device *dev, struct sg_table *sgt,
-				  void *cpu_addr, dma_addr_t dma_addr,
-				  size_t size)
-{
-	return -EINVAL;
-}
+#include <asm-generic/dma-mapping-common.h>
 
 #endif	/* _ASM_C6X_DMA_MAPPING_H */
diff --git a/arch/c6x/kernel/dma.c b/arch/c6x/kernel/dma.c
index ab7b12d..fd1d5c0 100644
--- a/arch/c6x/kernel/dma.c
+++ b/arch/c6x/kernel/dma.c
@@ -36,110 +36,99 @@ static void c6x_dma_sync(dma_addr_t handle, size_t size,
 	}
 }
 
-dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
-			  enum dma_data_direction dir)
+static dma_addr_t c6x_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
 {
-	dma_addr_t addr = virt_to_phys(ptr);
+	dma_addr_t handle = virt_to_phys(page_address(page) + offset);
 
-	c6x_dma_sync(addr, size, dir);
-
-	debug_dma_map_page(dev, virt_to_page(ptr),
-			   (unsigned long)ptr & ~PAGE_MASK, size,
-			   dir, addr, true);
-	return addr;
+	c6x_dma_sync(handle, size, dir);
+	return handle;
 }
-EXPORT_SYMBOL(dma_map_single);
-
 
-void dma_unmap_single(struct device *dev, dma_addr_t handle,
-		      size_t size, enum dma_data_direction dir)
+static void c6x_dma_unmap_page(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	c6x_dma_sync(handle, size, dir);
-
-	debug_dma_unmap_page(dev, handle, size, dir, true);
 }
-EXPORT_SYMBOL(dma_unmap_single);
-
 
-int dma_map_sg(struct device *dev, struct scatterlist *sglist,
-	       int nents, enum dma_data_direction dir)
+static int c6x_dma_map_sg(struct device *dev, struct scatterlist *sglist,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i;
 
 	for_each_sg(sglist, sg, nents, i)
-		sg->dma_address = dma_map_single(dev, sg_virt(sg), sg->length,
-						 dir);
-
-	debug_dma_map_sg(dev, sglist, nents, nents, dir);
+		sg->dma_address = sg_phys(sg);
+		c6x_dma_sync(sg->dma_address, sg->length, dir);
+	}
 
 	return nents;
 }
-EXPORT_SYMBOL(dma_map_sg);
-
 
-void dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		  int nents, enum dma_data_direction dir)
+static void c6x_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
+		  int nents, enum dma_data_direction dir,
+		  struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i;
 
 	for_each_sg(sglist, sg, nents, i)
-		dma_unmap_single(dev, sg_dma_address(sg), sg->length, dir);
+		c6x_dma_sync(sg_dma_address(sg), sg->length, dir);
 
-	debug_dma_unmap_sg(dev, sglist,	nents, dir);
 }
-EXPORT_SYMBOL(dma_unmap_sg);
 
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
-			     size_t size, enum dma_data_direction dir)
+static void c6x_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir)
 {
 	c6x_dma_sync(handle, size, dir);
 
-	debug_dma_sync_single_for_cpu(dev, handle, size, dir);
 }
-EXPORT_SYMBOL(dma_sync_single_for_cpu);
-
 
-void dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				size_t size, enum dma_data_direction dir)
+static void c6x_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	c6x_dma_sync(handle, size, dir);
 
-	debug_dma_sync_single_for_device(dev, handle, size, dir);
 }
-EXPORT_SYMBOL(dma_sync_single_for_device);
 
-
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist,
-			 int nents, enum dma_data_direction dir)
+static void c6x_dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sglist, int nents,
+		enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
 	int i;
 
 	for_each_sg(sglist, sg, nents, i)
-		dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+		c6x_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 					sg->length, dir);
 
-	debug_dma_sync_sg_for_cpu(dev, sglist, nents, dir);
 }
-EXPORT_SYMBOL(dma_sync_sg_for_cpu);
-
 
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
-			    int nents, enum dma_data_direction dir)
+static void c6x_dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sglist, int nents,
+		enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
 	int i;
 
 	for_each_sg(sglist, sg, nents, i)
-		dma_sync_single_for_device(dev, sg_dma_address(sg),
+		c6x_dma_sync_single_for_device(dev, sg_dma_address(sg),
 					   sg->length, dir);
 
-	debug_dma_sync_sg_for_device(dev, sglist, nents, dir);
 }
-EXPORT_SYMBOL(dma_sync_sg_for_device);
 
+struct dma_map_ops c6x_dma_ops = {
+	.alloc			= c6x_dma_alloc,
+	.free			= c6x_dma_free,
+	.map_page		= c6x_dma_map_page,
+	.map_sg			= c6x_dma_map_sg,
+	.sync_single_for_device	= c6x_dma_sync_single_for_device,
+	.sync_single_for_cpu	= c6x_dma_sync_single_for_cpu,
+	.sync_sg_for_device	= c6x_dma_sync_sg_for_device,
+	.sync_sg_for_cpu	= c6x_dma_sync_sg_for_cpu,
+};
+EXPORT_SYMBOL(c6x_dma_ops);
 
 /* Number of entries preallocated for DMA-API debugging */
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-- 
1.9.1

