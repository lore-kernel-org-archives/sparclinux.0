From: Christoph Hellwig <hch@lst.de>
Date: Sun, 15 Apr 2018 14:59:47 +0000
Subject: [PATCH 12/12] swiotlb: remove the CONFIG_DMA_DIRECT_OPS ifdefs
Message-Id: <20180415145947.1248-13-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180415145947.1248-1-hch@lst.de>
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

swiotlb now selects the DMA_DIRECT_OPS config symbol, so this will
always be true.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 47aeb04c1997..07f260319b82 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -692,7 +692,6 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 	}
 }
 
-#ifdef CONFIG_DMA_DIRECT_OPS
 static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
 		size_t size)
 {
@@ -764,7 +763,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
 				 DMA_ATTR_SKIP_CPU_SYNC);
 	return true;
 }
-#endif
 
 static void
 swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
@@ -1045,7 +1043,6 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 
-#ifdef CONFIG_DMA_DIRECT_OPS
 void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
@@ -1089,4 +1086,3 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_page		= swiotlb_unmap_page,
 	.dma_supported		= swiotlb_dma_supported,
 };
-#endif /* CONFIG_DMA_DIRECT_OPS */
-- 
2.17.0

