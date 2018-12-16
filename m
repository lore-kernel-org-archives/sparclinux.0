From: Christoph Hellwig <hch@lst.de>
Date: Sun, 16 Dec 2018 09:57:55 +0000
Subject: [PATCH 2/2] sparc/iommu: fix ->map_sg return value
Message-Id: <20181216095755.10503-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just decrementing the sz value will lead to an incorrect return value.
Instead of just introducing a local variable switch to the standard
for_each_sg helper and standard naming of the arguments.

Fixes: ce65d36f3e ("sparc: remove the sparc32_dma_ops indirection")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/mm/iommu.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 3599485717e7..25ab0fa042ef 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -241,32 +241,31 @@ static dma_addr_t sbus_iommu_map_page_pflush(struct device *dev,
 	return __sbus_iommu_map_page(dev, page, offset, len);
 }
 
-static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sg,
-		int sz, enum dma_data_direction dir, unsigned long attrs)
+static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	int n;
+	struct scatterlist *sg;
+	int j, n;
 
 	flush_page_for_dma(0);
-	while (sz != 0) {
-		--sz;
+
+	for_each_sg(sgl, sg, nents, j) {
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
 		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
 		sg->dma_length = sg->length;
-		sg = sg_next(sg);
 	}
 
-	return sz;
+	return nents;
 }
 
-static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sg,
-		int sz, enum dma_data_direction dir, unsigned long attrs)
+static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long page, oldpage = 0;
-	int n, i;
-
-	while(sz != 0) {
-		--sz;
+	struct scatterlist *sg;
+	int i, j, n;
 
+	for_each_sg(sgl, sg, nents, j) {
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
 
 		/*
@@ -286,10 +285,9 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sg,
 
 		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
 		sg->dma_length = sg->length;
-		sg = sg_next(sg);
 	}
 
-	return sz;
+	return nents;
 }
 
 static void iommu_release_one(struct device *dev, u32 busa, int npages)
@@ -318,17 +316,16 @@ static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	iommu_release_one(dev, dma_addr & PAGE_MASK, npages);
 }
 
-static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int sz, enum dma_data_direction dir, unsigned long attrs)
+static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	int n;
+	struct scatterlist *sg;
+	int j, n;
 
-	while(sz != 0) {
-		--sz;
+	for_each_sg(sgl, sg, nents, j) {
 		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
 		iommu_release_one(dev, sg->dma_address & PAGE_MASK, n);
 		sg->dma_address = 0x21212121;
-		sg = sg_next(sg);
 	}
 }
 
-- 
2.19.2
