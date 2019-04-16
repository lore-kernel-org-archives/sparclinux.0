From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:42 +0000
Subject: [PATCH 4/9] sparc/iommu: create a common helper for map_sg
Message-Id: <20190416182347.18441-5-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Share the code for the global and per-page flush map_sg loops using a
simple bool parameter to disable the per-page flush for the former
variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 7cb9ddda7531..f90d943a3a27 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -241,25 +241,9 @@ static dma_addr_t sbus_iommu_map_page_pflush(struct device *dev,
 	return __sbus_iommu_map_page(dev, page, offset, len);
 }
 
-static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i, n;
-
-	flush_page_for_dma(0);
-
-	for_each_sg(sgl, sg, nents, i) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
-		sg->dma_length = sg->length;
-	}
-
-	return nents;
-}
-
-static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs,
+		bool per_page_flush)
 {
 	unsigned long page, oldpage = 0;
 	struct scatterlist *sg;
@@ -273,7 +257,7 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 		 * XXX Is this a good assumption?
 		 * XXX What if someone else unmaps it here and races us?
 		 */
-		if (!PageHighMem(sg_page(sg))) {
+		if (per_page_flush && !PageHighMem(sg_page(sg))) {
 			page = (unsigned long)page_address(sg_page(sg));
 			for (i = 0; i < n; i++) {
 				if (page != oldpage) {	/* Already flushed? */
@@ -291,6 +275,19 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
+static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	flush_page_for_dma(0);
+	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, false);
+}
+
+static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, true);
+}
+
 static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		size_t len, enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.20.1
