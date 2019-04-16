From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:43 +0000
Subject: [PATCH 5/9] sparc/iommu: pass a physical address to iommu_get_one
Message-Id: <20190416182347.18441-6-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

No need for the page structure, just the paddr / pfn.  This is
going to simplify fixes to the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index f90d943a3a27..19d9266e4049 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -175,16 +175,17 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 	}
 }
 
-static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
+static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
 {
 	struct iommu_struct *iommu = dev->archdata.iommu;
 	int ioptex;
 	iopte_t *iopte, *iopte0;
 	unsigned int busa, busa0;
+	unsigned long pfn = __phys_to_pfn(paddr);
 	int i;
 
 	/* page color = pfn of page */
-	ioptex = bit_map_string_get(&iommu->usemap, npages, page_to_pfn(page));
+	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
 	if (ioptex < 0)
 		panic("iommu out");
 	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
@@ -193,11 +194,11 @@ static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
 	busa = busa0;
 	iopte = iopte0;
 	for (i = 0; i < npages; i++) {
-		iopte_val(*iopte) = MKIOPTE(page_to_pfn(page), IOPERM);
+		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
 		iommu_invalidate_page(iommu->regs, busa);
 		busa += PAGE_SIZE;
 		iopte++;
-		page++;
+		pfn++;
 	}
 
 	iommu_flush_iotlb(iopte0, npages);
@@ -215,7 +216,7 @@ static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
-	return iommu_get_one(dev, virt_to_page(vaddr), npages) + off;
+	return iommu_get_one(dev, virt_to_phys(vaddr), npages) + off;
 }
 
 static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
@@ -268,7 +269,7 @@ static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
 			}
 		}
 
-		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
+		sg->dma_address = iommu_get_one(dev, sg_phys(sg), n) + sg->offset;
 		sg->dma_length = sg->length;
 	}
 
-- 
2.20.1
