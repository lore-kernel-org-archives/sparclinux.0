From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:46 +0000
Subject: [PATCH 8/9] sparc/iommu: use __sbus_iommu_map_page to implement the map_sg path
Message-Id: <20190416182347.18441-9-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

This means we handle > PAGE_SIZE offsets fine, and grow the size check
so far only performed in the map_page path.  We lose the optimization
to not double flush a page if it apears in multiple consecutive SG list
entries.  But at least for block I/O those don't happen anymore since
we properly merge in higher layers anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 37b5ce7657f6..8fbc08d14836 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -217,6 +217,11 @@ static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
 
+	/*
+	 * We expect unmapped highmem pages to be not in the cache.
+	 * XXX Is this a good assumption?
+	 * XXX What if someone else unmaps it here and races us?
+	 */
 	if (per_page_flush && !PageHighMem(page)) {
 		unsigned long vaddr, p;
 
@@ -247,30 +252,14 @@ static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs,
 		bool per_page_flush)
 {
-	unsigned long page, oldpage = 0;
 	struct scatterlist *sg;
-	int i, j, n;
+	int j;
 
 	for_each_sg(sgl, sg, nents, j) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-
-		/*
-		 * We expect unmapped highmem pages to be not in the cache.
-		 * XXX Is this a good assumption?
-		 * XXX What if someone else unmaps it here and races us?
-		 */
-		if (per_page_flush && !PageHighMem(sg_page(sg))) {
-			page = (unsigned long)page_address(sg_page(sg));
-			for (i = 0; i < n; i++) {
-				if (page != oldpage) {	/* Already flushed? */
-					flush_page_for_dma(page);
-					oldpage = page;
-				}
-				page += PAGE_SIZE;
-			}
-		}
-
-		sg->dma_address = iommu_get_one(dev, sg_phys(sg), n) + sg->offset;
+		sg->dma_address =__sbus_iommu_map_page(dev, sg_page(sg),
+				sg->offset, sg->length, per_page_flush);
+		if (sg->dma_address = DMA_MAPPING_ERROR)
+			return 0;
 		sg->dma_length = sg->length;
 	}
 
-- 
2.20.1
