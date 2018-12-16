From: Christoph Hellwig <hch@lst.de>
Date: Sun, 16 Dec 2018 09:57:54 +0000
Subject: [PATCH 1/2] sparc/io-unit: fix ->map_sg return value
Message-Id: <20181216095755.10503-2-hch@lst.de>
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
 arch/sparc/mm/io-unit.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 2088d292c6e5..91be13935d40 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -158,22 +158,22 @@ static dma_addr_t iounit_map_page(struct device *dev, struct page *page,
 	return ret;
 }
 
-static int iounit_map_sg(struct device *dev, struct scatterlist *sg, int sz,
+static int iounit_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iounit_struct *iounit = dev->archdata.iommu;
+	struct scatterlist *sg;
 	unsigned long flags;
+	int i;
 
 	/* FIXME: Cache some resolved pages - often several sg entries are to the same page */
 	spin_lock_irqsave(&iounit->lock, flags);
-	while (sz != 0) {
-		--sz;
+	for_each_sg(sgl, sg, nents, i) {
 		sg->dma_address = iounit_get_area(iounit, (unsigned long) sg_virt(sg), sg->length);
 		sg->dma_length = sg->length;
-		sg = sg_next(sg);
 	}
 	spin_unlock_irqrestore(&iounit->lock, flags);
-	return sz;
+	return nents;
 }
 
 static void iounit_unmap_page(struct device *dev, dma_addr_t vaddr, size_t len,
@@ -191,22 +191,21 @@ static void iounit_unmap_page(struct device *dev, dma_addr_t vaddr, size_t len,
 	spin_unlock_irqrestore(&iounit->lock, flags);
 }
 
-static void iounit_unmap_sg(struct device *dev, struct scatterlist *sg, int sz,
-		enum dma_data_direction dir, unsigned long attrs)
+static void iounit_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iounit_struct *iounit = dev->archdata.iommu;
-	unsigned long flags;
-	unsigned long vaddr, len;
+	unsigned long flags, vaddr, len;
+	struct scatterlist *sg;
+	int i;
 
 	spin_lock_irqsave(&iounit->lock, flags);
-	while (sz != 0) {
-		--sz;
+	for_each_sg(sgl, sg, nents, i) {
 		len = ((sg->dma_address & ~PAGE_MASK) + sg->length + (PAGE_SIZE-1)) >> PAGE_SHIFT;
 		vaddr = (sg->dma_address - IOUNIT_DMA_BASE) >> PAGE_SHIFT;
 		IOD(("iounit_release %08lx-%08lx\n", (long)vaddr, (long)len+vaddr));
 		for (len += vaddr; vaddr < len; vaddr++)
 			clear_bit(vaddr, iounit->bmap);
-		sg = sg_next(sg);
 	}
 	spin_unlock_irqrestore(&iounit->lock, flags);
 }
-- 
2.19.2
