From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:44 +0000
Subject: [PATCH 6/9] sparc/iommu: move per-page flushing into __sbus_iommu_map_page
Message-Id: <20190416182347.18441-7-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

This prepares for reusing __sbus_iommu_map_page in the map_sg path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 19d9266e4049..7e191c8ae46a 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -207,15 +207,25 @@ static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
 }
 
 static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t len)
+		unsigned long offset, size_t len, bool per_page_flush)
 {
 	void *vaddr = page_address(page) + offset;
 	unsigned long off = (unsigned long)vaddr & ~PAGE_MASK;
 	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	
+
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
+
+	if (per_page_flush) {
+		unsigned long p = (unsigned long)vaddr & PAGE_MASK;
+
+		while (p < (unsigned long)vaddr + len) {
+			flush_page_for_dma(p);
+			p += PAGE_SIZE;
+		}
+	}
+
 	return iommu_get_one(dev, virt_to_phys(vaddr), npages) + off;
 }
 
@@ -224,22 +234,14 @@ static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	flush_page_for_dma(0);
-	return __sbus_iommu_map_page(dev, page, offset, len);
+	return __sbus_iommu_map_page(dev, page, offset, len, false);
 }
 
 static dma_addr_t sbus_iommu_map_page_pflush(struct device *dev,
 		struct page *page, unsigned long offset, size_t len,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	void *vaddr = page_address(page) + offset;
-	unsigned long p = ((unsigned long)vaddr) & PAGE_MASK;
-
-	while (p < (unsigned long)vaddr + len) {
-		flush_page_for_dma(p);
-		p += PAGE_SIZE;
-	}
-
-	return __sbus_iommu_map_page(dev, page, offset, len);
+	return __sbus_iommu_map_page(dev, page, offset, len, true);
 }
 
 static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
-- 
2.20.1
