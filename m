From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:40 +0000
Subject: [PATCH 2/9] sparc/iommu: use sbus_iommu_unmap_page in sbus_iommu_unmap_sg
Message-Id: <20190416182347.18441-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Use the page-level helper instead of duplicating the logic, while also
fixing the incorrect handling of larger than page sized offsets in
the sg variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index dcdadac03fdf..f47a6ce0acaa 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -321,11 +321,11 @@ static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
-	int i, n;
+	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		iommu_release_one(dev, sg->dma_address & PAGE_MASK, n);
+		sbus_iommu_unmap_page(dev, sg->dma_address, sg->length, dir,
+				attrs);
 		sg->dma_address = 0x21212121;
 	}
 }
-- 
2.20.1
