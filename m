From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:36:57 +0000
Subject: [PATCH 05/10] sparc64/iommu: move code around a bit
Message-Id: <20181208173702.15158-6-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

Move the alloc / free routines down the file so that we can easily use
the map / unmap helpers to implement non-consistent allocations.

Also drop the _coherent postfix to match the method name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c | 135 +++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 68 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 0626bae5e3da..4bf0497e0704 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -195,72 +195,6 @@ static inline void iommu_free_ctx(struct iommu *iommu, int ctx)
 	}
 }
 
-static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
-				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   unsigned long attrs)
-{
-	unsigned long order, first_page;
-	struct iommu *iommu;
-	struct page *page;
-	int npages, nid;
-	iopte_t *iopte;
-	void *ret;
-
-	size = IO_PAGE_ALIGN(size);
-	order = get_order(size);
-	if (order >= 10)
-		return NULL;
-
-	nid = dev->archdata.numa_node;
-	page = alloc_pages_node(nid, gfp, order);
-	if (unlikely(!page))
-		return NULL;
-
-	first_page = (unsigned long) page_address(page);
-	memset((char *)first_page, 0, PAGE_SIZE << order);
-
-	iommu = dev->archdata.iommu;
-
-	iopte = alloc_npages(dev, iommu, size >> IO_PAGE_SHIFT);
-
-	if (unlikely(iopte = NULL)) {
-		free_pages(first_page, order);
-		return NULL;
-	}
-
-	*dma_addrp = (iommu->tbl.table_map_base +
-		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
-	ret = (void *) first_page;
-	npages = size >> IO_PAGE_SHIFT;
-	first_page = __pa(first_page);
-	while (npages--) {
-		iopte_val(*iopte) = (IOPTE_CONSISTENT(0UL) |
-				     IOPTE_WRITE |
-				     (first_page & IOPTE_PAGE));
-		iopte++;
-		first_page += IO_PAGE_SIZE;
-	}
-
-	return ret;
-}
-
-static void dma_4u_free_coherent(struct device *dev, size_t size,
-				 void *cpu, dma_addr_t dvma,
-				 unsigned long attrs)
-{
-	struct iommu *iommu;
-	unsigned long order, npages;
-
-	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
-	iommu = dev->archdata.iommu;
-
-	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
-
-	order = get_order(size);
-	if (order < 10)
-		free_pages((unsigned long)cpu, order);
-}
-
 static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
@@ -742,6 +676,71 @@ static void dma_4u_sync_sg_for_cpu(struct device *dev,
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+static void *dma_4u_alloc(struct device *dev, size_t size,
+			  dma_addr_t *dma_addrp, gfp_t gfp, unsigned long attrs)
+{
+	unsigned long order, first_page;
+	struct iommu *iommu;
+	struct page *page;
+	int npages, nid;
+	iopte_t *iopte;
+	void *ret;
+
+	size = IO_PAGE_ALIGN(size);
+	order = get_order(size);
+	if (order >= 10)
+		return NULL;
+
+	nid = dev->archdata.numa_node;
+	page = alloc_pages_node(nid, gfp, order);
+	if (unlikely(!page))
+		return NULL;
+
+	first_page = (unsigned long) page_address(page);
+	memset((char *)first_page, 0, PAGE_SIZE << order);
+
+	iommu = dev->archdata.iommu;
+
+	iopte = alloc_npages(dev, iommu, size >> IO_PAGE_SHIFT);
+
+	if (unlikely(iopte = NULL)) {
+		free_pages(first_page, order);
+		return NULL;
+	}
+
+	*dma_addrp = (iommu->tbl.table_map_base +
+		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
+	ret = (void *) first_page;
+	npages = size >> IO_PAGE_SHIFT;
+	first_page = __pa(first_page);
+	while (npages--) {
+		iopte_val(*iopte) = (IOPTE_CONSISTENT(0UL) |
+				     IOPTE_WRITE |
+				     (first_page & IOPTE_PAGE));
+		iopte++;
+		first_page += IO_PAGE_SIZE;
+	}
+
+	return ret;
+}
+
+static void dma_4u_free(struct device *dev, size_t size, void *cpu,
+			dma_addr_t dvma, unsigned long attrs)
+{
+	struct iommu *iommu;
+	unsigned long order, npages;
+
+	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
+	iommu = dev->archdata.iommu;
+
+	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
+
+	order = get_order(size);
+	if (order < 10)
+		free_pages((unsigned long)cpu, order);
+}
+
+
 static int dma_4u_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
@@ -758,8 +757,8 @@ static int dma_4u_supported(struct device *dev, u64 device_mask)
 }
 
 static const struct dma_map_ops sun4u_dma_ops = {
-	.alloc			= dma_4u_alloc_coherent,
-	.free			= dma_4u_free_coherent,
+	.alloc			= dma_4u_alloc,
+	.free			= dma_4u_free,
 	.map_page		= dma_4u_map_page,
 	.unmap_page		= dma_4u_unmap_page,
 	.map_sg			= dma_4u_map_sg,
-- 
2.19.2
