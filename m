From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:18 +0000
Subject: [PATCH 13/25] openrisc: remove the no-op unmap_page and unmap_sg DMA operations
Message-Id: <20180522120430.28709-14-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 47601274abf7..7cadff93d179 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -171,14 +171,6 @@ or1k_map_page(struct device *dev, struct page *page,
 	return addr;
 }
 
-static void
-or1k_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	/* Nothing special to do here... */
-}
-
 static int
 or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	    int nents, enum dma_data_direction dir,
@@ -195,19 +187,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_unmap_sg(struct device *dev, struct scatterlist *sg,
-	      int nents, enum dma_data_direction dir,
-	      unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		or1k_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, 0);
-	}
-}
-
 static void
 or1k_sync_single_for_device(struct device *dev,
 			    dma_addr_t dma_handle, size_t size,
@@ -226,9 +205,7 @@ const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
 	.map_page = or1k_map_page,
-	.unmap_page = or1k_unmap_page,
 	.map_sg = or1k_map_sg,
-	.unmap_sg = or1k_unmap_sg,
 	.sync_single_for_device = or1k_sync_single_for_device,
 };
 EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.17.0

