From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:36:58 +0000
Subject: [PATCH 06/10] sparc64/iommu: implement DMA_ATTR_NON_CONSISTENT
Message-Id: <20181208173702.15158-7-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

Just allocate the memory and use map_page to map the memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 4bf0497e0704..4ce24c9dc691 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -699,14 +699,19 @@ static void *dma_4u_alloc(struct device *dev, size_t size,
 	first_page = (unsigned long) page_address(page);
 	memset((char *)first_page, 0, PAGE_SIZE << order);
 
+	if (attrs & DMA_ATTR_NON_CONSISTENT) {
+		*dma_addrp = dma_4u_map_page(dev, page, 0, size,
+					     DMA_BIDIRECTIONAL, 0);
+		if (*dma_addrp = DMA_MAPPING_ERROR)
+			goto out_free_page;
+		return page_address(page);
+	}
+
 	iommu = dev->archdata.iommu;
 
 	iopte = alloc_npages(dev, iommu, size >> IO_PAGE_SHIFT);
-
-	if (unlikely(iopte = NULL)) {
-		free_pages(first_page, order);
-		return NULL;
-	}
+	if (unlikely(iopte = NULL))
+		goto out_free_page;
 
 	*dma_addrp = (iommu->tbl.table_map_base +
 		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
@@ -722,18 +727,26 @@ static void *dma_4u_alloc(struct device *dev, size_t size,
 	}
 
 	return ret;
+
+out_free_page:
+	free_pages(first_page, order);
+	return NULL;
 }
 
 static void dma_4u_free(struct device *dev, size_t size, void *cpu,
 			dma_addr_t dvma, unsigned long attrs)
 {
-	struct iommu *iommu;
-	unsigned long order, npages;
+	unsigned long order;
 
-	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
-	iommu = dev->archdata.iommu;
+	if (attrs & DMA_ATTR_NON_CONSISTENT) {
+		dma_4u_unmap_page(dev, dvma, size, DMA_BIDIRECTIONAL, 0);
+	} else {
+		struct iommu *iommu = dev->archdata.iommu;
 
-	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
+		iommu_tbl_range_free(&iommu->tbl, dvma,
+				     IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT,
+				     IOMMU_ERROR_CODE);
+	}
 
 	order = get_order(size);
 	if (order < 10)
-- 
2.19.2
