From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:16 +0000
Subject: [PATCH 11/16] m68k: convert to dma_map_ops
Message-Id: <1447093041-21832-12-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig                   |   1 +
 arch/m68k/include/asm/dma-mapping.h | 112 ++----------------------------------
 arch/m68k/kernel/dma.c              |  61 +++++++++-----------
 3 files changed, 32 insertions(+), 142 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 498b567..d5d75b3 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -23,6 +23,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select HAVE_DMA_ATTRS
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
diff --git a/arch/m68k/include/asm/dma-mapping.h b/arch/m68k/include/asm/dma-mapping.h
index 05aa535..2c082a6 100644
--- a/arch/m68k/include/asm/dma-mapping.h
+++ b/arch/m68k/include/asm/dma-mapping.h
@@ -1,123 +1,19 @@
 #ifndef _M68K_DMA_MAPPING_H
 #define _M68K_DMA_MAPPING_H
 
-#include <asm/cache.h>
+extern struct dma_map_ops m68k_dma_ops;
 
-struct scatterlist;
-
-static inline int dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
-static inline int dma_set_mask(struct device *dev, u64 mask)
+static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	return 0;
+        return &m68k_dma_ops;
 }
 
-extern void *dma_alloc_coherent(struct device *, size_t,
-				dma_addr_t *, gfp_t);
-extern void dma_free_coherent(struct device *, size_t,
-			      void *, dma_addr_t);
+#include <asm-generic/dma-mapping-common.h>
 
-static inline void *dma_alloc_attrs(struct device *dev, size_t size,
-				    dma_addr_t *dma_handle, gfp_t flag,
-				    struct dma_attrs *attrs)
-{
-	/* attrs is not supported and ignored */
-	return dma_alloc_coherent(dev, size, dma_handle, flag);
-}
-
-static inline void dma_free_attrs(struct device *dev, size_t size,
-				  void *cpu_addr, dma_addr_t dma_handle,
-				  struct dma_attrs *attrs)
-{
-	/* attrs is not supported and ignored */
-	dma_free_coherent(dev, size, cpu_addr, dma_handle);
-}
-
-static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
-					  dma_addr_t *handle, gfp_t flag)
-{
-	return dma_alloc_coherent(dev, size, handle, flag);
-}
-static inline void dma_free_noncoherent(struct device *dev, size_t size,
-					void *addr, dma_addr_t handle)
-{
-	dma_free_coherent(dev, size, addr, handle);
-}
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 				  enum dma_data_direction dir)
 {
 	/* we use coherent allocation, so not much to do here. */
 }
 
-extern dma_addr_t dma_map_single(struct device *, void *, size_t,
-				 enum dma_data_direction);
-static inline void dma_unmap_single(struct device *dev, dma_addr_t addr,
-				    size_t size, enum dma_data_direction dir)
-{
-}
-
-extern dma_addr_t dma_map_page(struct device *, struct page *,
-			       unsigned long, size_t size,
-			       enum dma_data_direction);
-static inline void dma_unmap_page(struct device *dev, dma_addr_t address,
-				  size_t size, enum dma_data_direction dir)
-{
-}
-
-extern int dma_map_sg(struct device *, struct scatterlist *, int,
-		      enum dma_data_direction);
-static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-				int nhwentries, enum dma_data_direction dir)
-{
-}
-
-extern void dma_sync_single_for_device(struct device *, dma_addr_t, size_t,
-				       enum dma_data_direction);
-extern void dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
-				   enum dma_data_direction);
-
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t dma_handle, unsigned long offset, size_t size,
-		enum dma_data_direction direction)
-{
-	/* just sync everything for now */
-	dma_sync_single_for_device(dev, dma_handle, offset + size, direction);
-}
-
-static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
-					   size_t size, enum dma_data_direction dir)
-{
-}
-
-static inline void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-				       int nents, enum dma_data_direction dir)
-{
-}
-
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, unsigned long offset, size_t size,
-		enum dma_data_direction direction)
-{
-	/* just sync everything for now */
-	dma_sync_single_for_cpu(dev, dma_handle, offset + size, direction);
-}
-
-static inline int dma_mapping_error(struct device *dev, dma_addr_t handle)
-{
-	return 0;
-}
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
 #endif  /* _M68K_DMA_MAPPING_H */
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 564665f..cbc78b4 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -18,8 +18,8 @@
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
 
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *handle, gfp_t flag)
+static void *m68k_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		gfp_t flag, struct dma_attrs *attrs)
 {
 	struct page *page, **map;
 	pgprot_t pgprot;
@@ -61,8 +61,8 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 	return addr;
 }
 
-void dma_free_coherent(struct device *dev, size_t size,
-		       void *addr, dma_addr_t handle)
+static void m68k_dma_free(struct device *dev, size_t size, void *addr,
+		dma_addr_t handle, struct dma_attrs *attrs)
 {
 	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
 	vfree(addr);
@@ -72,8 +72,8 @@ void dma_free_coherent(struct device *dev, size_t size,
 
 #include <asm/cacheflush.h>
 
-void *dma_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t gfp)
+static void *m68k_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
 	void *ret;
 	/* ignore region specifiers */
@@ -90,19 +90,16 @@ void *dma_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 }
 
-void dma_free_coherent(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle)
+static void m68k_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
 }
 
 #endif /* CONFIG_MMU && !CONFIG_COLDFIRE */
 
-EXPORT_SYMBOL(dma_alloc_coherent);
-EXPORT_SYMBOL(dma_free_coherent);
-
-void dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
-				size_t size, enum dma_data_direction dir)
+static void m68k_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
@@ -118,10 +115,9 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
 		break;
 	}
 }
-EXPORT_SYMBOL(dma_sync_single_for_device);
 
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
-			    int nents, enum dma_data_direction dir)
+static void m68k_dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sglist, int nents, enum dma_data_direction dir)
 {
 	int i;
 	struct scatterlist *sg;
@@ -131,31 +127,19 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
 					   dir);
 	}
 }
-EXPORT_SYMBOL(dma_sync_sg_for_device);
-
-dma_addr_t dma_map_single(struct device *dev, void *addr, size_t size,
-			  enum dma_data_direction dir)
-{
-	dma_addr_t handle = virt_to_bus(addr);
-
-	dma_sync_single_for_device(dev, handle, size, dir);
-	return handle;
-}
-EXPORT_SYMBOL(dma_map_single);
 
-dma_addr_t dma_map_page(struct device *dev, struct page *page,
-			unsigned long offset, size_t size,
-			enum dma_data_direction dir)
+static dma_addr_t m68k_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
 {
 	dma_addr_t handle = page_to_phys(page) + offset;
 
 	dma_sync_single_for_device(dev, handle, size, dir);
 	return handle;
 }
-EXPORT_SYMBOL(dma_map_page);
 
-int dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
-	       enum dma_data_direction dir)
+static int m68k_dma_map_sg(struct device *dev, struct scatterlist *sglist,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	int i;
 	struct scatterlist *sg;
@@ -167,4 +151,13 @@ int dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	}
 	return nents;
 }
-EXPORT_SYMBOL(dma_map_sg);
+
+struct dma_map_ops m68k_dma_ops = {
+	.alloc			= m68k_dma_alloc,
+	.free			= m68k_dma_free,
+	.map_page		= m68k_dma_map_page,
+	.map_sg			= m68k_dma_map_sg,
+	.sync_single_for_device	= m68k_dma_sync_single_for_device,
+	.sync_sg_for_device	= m68k_dma_sync_sg_for_device,
+};
+EXPORT_SYMBOL(m68k_dma_ops);
-- 
1.9.1

