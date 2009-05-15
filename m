From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Fri, 15 May 2009 02:23:08 +0000
Subject: [PATCH 1/4] sparc: move the duplication in dma-mapping_{32|64}.h to dma-mapping.h
Message-Id: <1242354191-6232-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/sparc/include/asm/dma-mapping.h    |   42 +++++++++++++++++++++++++++++++
 arch/sparc/include/asm/dma-mapping_32.h |   18 -------------
 arch/sparc/include/asm/dma-mapping_64.h |   40 -----------------------------
 arch/sparc/kernel/dma.c                 |   30 ----------------------
 4 files changed, 42 insertions(+), 88 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 0f4150e..8c911ea 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -5,4 +5,46 @@
 #else
 #include <asm/dma-mapping_32.h>
 #endif
+
+#define DMA_ERROR_CODE	(~(dma_addr_t)0x0)
+
+extern int dma_supported(struct device *dev, u64 mask);
+extern int dma_set_mask(struct device *dev, u64 dma_mask);
+
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return (dma_addr = DMA_ERROR_CODE);
+}
+
+static inline int dma_get_cache_alignment(void)
+{
+	/*
+	 * no easy way to get cache size on all processors, so return
+	 * the maximum possible, to be safe
+	 */
+	return (1 << INTERNODE_CACHE_SHIFT);
+}
+
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
+#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
+#define dma_is_consistent(d, h)	(1)
+
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+						 dma_addr_t dma_handle,
+						 unsigned long offset,
+						 size_t size,
+						 enum dma_data_direction dir)
+{
+	dma_sync_single_for_cpu(dev, dma_handle+offset, size, dir);
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+						    dma_addr_t dma_handle,
+						    unsigned long offset,
+						    size_t size,
+						    enum dma_data_direction dir)
+{
+	dma_sync_single_for_device(dev, dma_handle+offset, size, dir);
+}
+
 #endif
diff --git a/arch/sparc/include/asm/dma-mapping_32.h b/arch/sparc/include/asm/dma-mapping_32.h
index 8a57ea0..7f09c85 100644
--- a/arch/sparc/include/asm/dma-mapping_32.h
+++ b/arch/sparc/include/asm/dma-mapping_32.h
@@ -7,10 +7,6 @@ struct device;
 struct scatterlist;
 struct page;
 
-#define DMA_ERROR_CODE	(~(dma_addr_t)0x0)
-
-extern int dma_supported(struct device *dev, u64 mask);
-extern int dma_set_mask(struct device *dev, u64 dma_mask);
 extern void *dma_alloc_coherent(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t flag);
 extern void dma_free_coherent(struct device *dev, size_t size,
@@ -37,24 +33,10 @@ extern void dma_sync_single_for_device(struct device *dev,
 				       dma_addr_t dma_handle,
 				       size_t size,
 				       enum dma_data_direction direction);
-extern void dma_sync_single_range_for_cpu(struct device *dev,
-					  dma_addr_t dma_handle,
-					  unsigned long offset,
-					  size_t size,
-					  enum dma_data_direction direction);
-extern void dma_sync_single_range_for_device(struct device *dev,
-					     dma_addr_t dma_handle,
-					     unsigned long offset, size_t size,
-					     enum dma_data_direction direction);
 extern void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 				int nelems, enum dma_data_direction direction);
 extern void dma_sync_sg_for_device(struct device *dev,
 				   struct scatterlist *sg, int nelems,
 				   enum dma_data_direction direction);
-extern int dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
-extern int dma_get_cache_alignment(void);
-
-#define dma_alloc_noncoherent	dma_alloc_coherent
-#define dma_free_noncoherent	dma_free_coherent
 
 #endif /* _ASM_SPARC_DMA_MAPPING_H */
diff --git a/arch/sparc/include/asm/dma-mapping_64.h b/arch/sparc/include/asm/dma-mapping_64.h
index bfa64f9..017ae70 100644
--- a/arch/sparc/include/asm/dma-mapping_64.h
+++ b/arch/sparc/include/asm/dma-mapping_64.h
@@ -4,8 +4,6 @@
 #include <linux/scatterlist.h>
 #include <linux/mm.h>
 
-#define DMA_ERROR_CODE	(~(dma_addr_t)0x0)
-
 struct dma_ops {
 	void *(*alloc_coherent)(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t flag);
@@ -31,9 +29,6 @@ struct dma_ops {
 };
 extern const struct dma_ops *dma_ops;
 
-extern int dma_supported(struct device *dev, u64 mask);
-extern int dma_set_mask(struct device *dev, u64 dma_mask);
-
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
 {
@@ -102,25 +97,6 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	/* No flushing needed to sync cpu writes to the device.  */
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-						 dma_addr_t dma_handle,
-						 unsigned long offset,
-						 size_t size,
-						 enum dma_data_direction direction)
-{
-	dma_sync_single_for_cpu(dev, dma_handle+offset, size, direction);
-}
-
-static inline void dma_sync_single_range_for_device(struct device *dev,
-						    dma_addr_t dma_handle,
-						    unsigned long offset,
-						    size_t size,
-						    enum dma_data_direction direction)
-{
-	/* No flushing needed to sync cpu writes to the device.  */
-}
-
-
 static inline void dma_sync_sg_for_cpu(struct device *dev,
 				       struct scatterlist *sg, int nelems,
 				       enum dma_data_direction direction)
@@ -135,20 +111,4 @@ static inline void dma_sync_sg_for_device(struct device *dev,
 	/* No flushing needed to sync cpu writes to the device.  */
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return (dma_addr = DMA_ERROR_CODE);
-}
-
-static inline int dma_get_cache_alignment(void)
-{
-	/* no easy way to get cache size on all processors, so return
-	 * the maximum possible, to be safe */
-	return (1 << INTERNODE_CACHE_SHIFT);
-}
-
-#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
-#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
-#define dma_is_consistent(d, h)	(1)
-
 #endif /* _ASM_SPARC64_DMA_MAPPING_H */
diff --git a/arch/sparc/kernel/dma.c b/arch/sparc/kernel/dma.c
index ebc8403..3c9ff4f 100644
--- a/arch/sparc/kernel/dma.c
+++ b/arch/sparc/kernel/dma.c
@@ -167,24 +167,6 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 }
 EXPORT_SYMBOL(dma_sync_single_for_device);
 
-void dma_sync_single_range_for_cpu(struct device *dev,
-				   dma_addr_t dma_handle,
-				   unsigned long offset,
-				   size_t size,
-				   enum dma_data_direction direction)
-{
-	dma_sync_single_for_cpu(dev, dma_handle+offset, size, direction);
-}
-EXPORT_SYMBOL(dma_sync_single_range_for_cpu);
-
-void dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-				      unsigned long offset, size_t size,
-				      enum dma_data_direction direction)
-{
-	dma_sync_single_for_device(dev, dma_handle+offset, size, direction);
-}
-EXPORT_SYMBOL(dma_sync_single_range_for_device);
-
 void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 			 int nelems, enum dma_data_direction direction)
 {
@@ -213,15 +195,3 @@ void dma_sync_sg_for_device(struct device *dev,
 	BUG();
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
-
-int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return (dma_addr = DMA_ERROR_CODE);
-}
-EXPORT_SYMBOL(dma_mapping_error);
-
-int dma_get_cache_alignment(void)
-{
-	return 32;
-}
-EXPORT_SYMBOL(dma_get_cache_alignment);
-- 
1.6.0.6

