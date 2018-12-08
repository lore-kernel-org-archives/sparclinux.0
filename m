From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:36:59 +0000
Subject: [PATCH 07/10] sparc64/pci_sun4v: move code around a bit
Message-Id: <20181208173702.15158-8-hch@lst.de>
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
 arch/sparc/kernel/pci_sun4v.c | 229 +++++++++++++++++-----------------
 1 file changed, 114 insertions(+), 115 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index fa0e42b4cbfb..b95c70136559 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -171,87 +171,6 @@ static inline long iommu_batch_end(u64 mask)
 	return iommu_batch_flush(p, mask);
 }
 
-static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
-				   dma_addr_t *dma_addrp, gfp_t gfp,
-				   unsigned long attrs)
-{
-	u64 mask;
-	unsigned long flags, order, first_page, npages, n;
-	unsigned long prot = 0;
-	struct iommu *iommu;
-	struct atu *atu;
-	struct iommu_map_table *tbl;
-	struct page *page;
-	void *ret;
-	long entry;
-	int nid;
-
-	size = IO_PAGE_ALIGN(size);
-	order = get_order(size);
-	if (unlikely(order >= MAX_ORDER))
-		return NULL;
-
-	npages = size >> IO_PAGE_SHIFT;
-
-	if (attrs & DMA_ATTR_WEAK_ORDERING)
-		prot = HV_PCI_MAP_ATTR_RELAXED_ORDER;
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
-	atu = iommu->atu;
-
-	mask = dev->coherent_dma_mask;
-	if (mask <= DMA_BIT_MASK(32))
-		tbl = &iommu->tbl;
-	else
-		tbl = &atu->tbl;
-
-	entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
-				      (unsigned long)(-1), 0);
-
-	if (unlikely(entry = IOMMU_ERROR_CODE))
-		goto range_alloc_fail;
-
-	*dma_addrp = (tbl->table_map_base + (entry << IO_PAGE_SHIFT));
-	ret = (void *) first_page;
-	first_page = __pa(first_page);
-
-	local_irq_save(flags);
-
-	iommu_batch_start(dev,
-			  (HV_PCI_MAP_ATTR_READ | prot |
-			   HV_PCI_MAP_ATTR_WRITE),
-			  entry);
-
-	for (n = 0; n < npages; n++) {
-		long err = iommu_batch_add(first_page + (n * PAGE_SIZE), mask);
-		if (unlikely(err < 0L))
-			goto iommu_map_fail;
-	}
-
-	if (unlikely(iommu_batch_end(mask) < 0L))
-		goto iommu_map_fail;
-
-	local_irq_restore(flags);
-
-	return ret;
-
-iommu_map_fail:
-	local_irq_restore(flags);
-	iommu_tbl_range_free(tbl, *dma_addrp, npages, IOMMU_ERROR_CODE);
-
-range_alloc_fail:
-	free_pages(first_page, order);
-	return NULL;
-}
-
 unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
 				unsigned long iotsb_num,
 				struct pci_bus *bus_dev)
@@ -316,38 +235,6 @@ static void dma_4v_iommu_demap(struct device *dev, unsigned long devhandle,
 	local_irq_restore(flags);
 }
 
-static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
-				 dma_addr_t dvma, unsigned long attrs)
-{
-	struct pci_pbm_info *pbm;
-	struct iommu *iommu;
-	struct atu *atu;
-	struct iommu_map_table *tbl;
-	unsigned long order, npages, entry;
-	unsigned long iotsb_num;
-	u32 devhandle;
-
-	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
-	iommu = dev->archdata.iommu;
-	pbm = dev->archdata.host_controller;
-	atu = iommu->atu;
-	devhandle = pbm->devhandle;
-
-	if (dvma <= DMA_BIT_MASK(32)) {
-		tbl = &iommu->tbl;
-		iotsb_num = 0; /* we don't care for legacy iommu */
-	} else {
-		tbl = &atu->tbl;
-		iotsb_num = atu->iotsb->iotsb_num;
-	}
-	entry = ((dvma - tbl->table_map_base) >> IO_PAGE_SHIFT);
-	dma_4v_iommu_demap(dev, devhandle, dvma, iotsb_num, entry, npages);
-	iommu_tbl_range_free(tbl, dvma, npages, IOMMU_ERROR_CODE);
-	order = get_order(size);
-	if (order < 10)
-		free_pages((unsigned long)cpu, order);
-}
-
 static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 				  unsigned long offset, size_t sz,
 				  enum dma_data_direction direction,
@@ -671,6 +558,118 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	local_irq_restore(flags);
 }
 
+static void *dma_4v_alloc(struct device *dev, size_t size,
+			  dma_addr_t *dma_addrp, gfp_t gfp, unsigned long attrs)
+{
+	u64 mask;
+	unsigned long flags, order, first_page, npages, n;
+	unsigned long prot = 0;
+	struct iommu *iommu;
+	struct atu *atu;
+	struct iommu_map_table *tbl;
+	struct page *page;
+	void *ret;
+	long entry;
+	int nid;
+
+	size = IO_PAGE_ALIGN(size);
+	order = get_order(size);
+	if (unlikely(order >= MAX_ORDER))
+		return NULL;
+
+	npages = size >> IO_PAGE_SHIFT;
+
+	if (attrs & DMA_ATTR_WEAK_ORDERING)
+		prot = HV_PCI_MAP_ATTR_RELAXED_ORDER;
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
+	atu = iommu->atu;
+
+	mask = dev->coherent_dma_mask;
+	if (mask <= DMA_BIT_MASK(32))
+		tbl = &iommu->tbl;
+	else
+		tbl = &atu->tbl;
+
+	entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
+				      (unsigned long)(-1), 0);
+
+	if (unlikely(entry = IOMMU_ERROR_CODE))
+		goto range_alloc_fail;
+
+	*dma_addrp = (tbl->table_map_base + (entry << IO_PAGE_SHIFT));
+	ret = (void *) first_page;
+	first_page = __pa(first_page);
+
+	local_irq_save(flags);
+
+	iommu_batch_start(dev,
+			  (HV_PCI_MAP_ATTR_READ | prot |
+			   HV_PCI_MAP_ATTR_WRITE),
+			  entry);
+
+	for (n = 0; n < npages; n++) {
+		long err = iommu_batch_add(first_page + (n * PAGE_SIZE), mask);
+		if (unlikely(err < 0L))
+			goto iommu_map_fail;
+	}
+
+	if (unlikely(iommu_batch_end(mask) < 0L))
+		goto iommu_map_fail;
+
+	local_irq_restore(flags);
+
+	return ret;
+
+iommu_map_fail:
+	local_irq_restore(flags);
+	iommu_tbl_range_free(tbl, *dma_addrp, npages, IOMMU_ERROR_CODE);
+
+range_alloc_fail:
+	free_pages(first_page, order);
+	return NULL;
+}
+
+static void dma_4v_free(struct device *dev, size_t size, void *cpu,
+			dma_addr_t dvma, unsigned long attrs)
+{
+	struct pci_pbm_info *pbm;
+	struct iommu *iommu;
+	struct atu *atu;
+	struct iommu_map_table *tbl;
+	unsigned long order, npages, entry;
+	unsigned long iotsb_num;
+	u32 devhandle;
+
+	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
+	iommu = dev->archdata.iommu;
+	pbm = dev->archdata.host_controller;
+	atu = iommu->atu;
+	devhandle = pbm->devhandle;
+
+	if (dvma <= DMA_BIT_MASK(32)) {
+		tbl = &iommu->tbl;
+		iotsb_num = 0; /* we don't care for legacy iommu */
+	} else {
+		tbl = &atu->tbl;
+		iotsb_num = atu->iotsb->iotsb_num;
+	}
+	entry = ((dvma - tbl->table_map_base) >> IO_PAGE_SHIFT);
+	dma_4v_iommu_demap(dev, devhandle, dvma, iotsb_num, entry, npages);
+	iommu_tbl_range_free(tbl, dvma, npages, IOMMU_ERROR_CODE);
+	order = get_order(size);
+	if (order < 10)
+		free_pages((unsigned long)cpu, order);
+}
+
 static int dma_4v_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
@@ -689,8 +688,8 @@ static int dma_4v_supported(struct device *dev, u64 device_mask)
 }
 
 static const struct dma_map_ops sun4v_dma_ops = {
-	.alloc				= dma_4v_alloc_coherent,
-	.free				= dma_4v_free_coherent,
+	.alloc				= dma_4v_alloc,
+	.free				= dma_4v_free,
 	.map_page			= dma_4v_map_page,
 	.unmap_page			= dma_4v_unmap_page,
 	.map_sg				= dma_4v_map_sg,
-- 
2.19.2
