From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:41 +0000
Subject: [PATCH 3/9] sparc/iommu: merge iommu_release_one and sbus_iommu_unmap_page
Message-Id: <20190416182347.18441-4-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

There is only one caller of iommu_release_one left, so merge it into
that one to clean things up a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index f47a6ce0acaa..7cb9ddda7531 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -291,14 +291,17 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static void iommu_release_one(struct device *dev, u32 busa, int npages)
+static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
+		size_t len, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iommu_struct *iommu = dev->archdata.iommu;
-	int ioptex;
-	int i;
+	unsigned int busa = dma_addr & PAGE_MASK;
+	unsigned long off = dma_addr & ~PAGE_MASK;
+	unsigned int npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
+	unsigned int ioptex = (busa - iommu->start) >> PAGE_SHIFT;
+	unsigned int i;
 
 	BUG_ON(busa < iommu->start);
-	ioptex = (busa - iommu->start) >> PAGE_SHIFT;
 	for (i = 0; i < npages; i++) {
 		iopte_val(iommu->page_table[ioptex + i]) = 0;
 		iommu_invalidate_page(iommu->regs, busa);
@@ -307,16 +310,6 @@ static void iommu_release_one(struct device *dev, u32 busa, int npages)
 	bit_map_clear(&iommu->usemap, ioptex, npages);
 }
 
-static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
-		size_t len, enum dma_data_direction dir, unsigned long attrs)
-{
-	unsigned long off = dma_addr & ~PAGE_MASK;
-	int npages;
-
-	npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
-	iommu_release_one(dev, dma_addr & PAGE_MASK, npages);
-}
-
 static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.20.1
