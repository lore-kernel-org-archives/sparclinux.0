From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:47 +0000
Subject: [PATCH 9/9] sparc/iommu: merge iommu_get_one and __sbus_iommu_map_page
Message-Id: <20190416182347.18441-10-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

There is only one caller of iommu_get_one left, so merge it into
that one to clean things up a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/mm/iommu.c | 56 +++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 8fbc08d14836..71ac353032b6 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -175,43 +175,17 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 	}
 }
 
-static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
-{
-	struct iommu_struct *iommu = dev->archdata.iommu;
-	int ioptex;
-	iopte_t *iopte, *iopte0;
-	unsigned int busa, busa0;
-	unsigned long pfn = __phys_to_pfn(paddr);
-	int i;
-
-	/* page color = pfn of page */
-	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
-	if (ioptex < 0)
-		panic("iommu out");
-	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
-	iopte0 = &iommu->page_table[ioptex];
-
-	busa = busa0;
-	iopte = iopte0;
-	for (i = 0; i < npages; i++) {
-		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
-		iommu_invalidate_page(iommu->regs, busa);
-		busa += PAGE_SIZE;
-		iopte++;
-		pfn++;
-	}
-
-	iommu_flush_iotlb(iopte0, npages);
-
-	return busa0;
-}
-
 static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t len, bool per_page_flush)
 {
+	struct iommu_struct *iommu = dev->archdata.iommu;
 	phys_addr_t paddr = page_to_phys(page) + offset;
 	unsigned long off = paddr & ~PAGE_MASK;
 	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long pfn = __phys_to_pfn(paddr);
+	unsigned int busa, busa0;
+	iopte_t *iopte, *iopte0;
+	int ioptex, i;
 
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
@@ -230,7 +204,25 @@ static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 			flush_page_for_dma(p);
 	}
 
-	return iommu_get_one(dev, paddr, npages) + off;
+	/* page color = pfn of page */
+	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
+	if (ioptex < 0)
+		panic("iommu out");
+	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
+	iopte0 = &iommu->page_table[ioptex];
+
+	busa = busa0;
+	iopte = iopte0;
+	for (i = 0; i < npages; i++) {
+		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
+		iommu_invalidate_page(iommu->regs, busa);
+		busa += PAGE_SIZE;
+		iopte++;
+		pfn++;
+	}
+
+	iommu_flush_iotlb(iopte0, npages);
+	return busa0 + off;
 }
 
 static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
-- 
2.20.1
