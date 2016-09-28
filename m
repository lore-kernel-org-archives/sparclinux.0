From: chris hyser <chris.hyser@oracle.com>
Date: Wed, 28 Sep 2016 17:03:14 +0000
Subject: [PATCH 2/2] sparc64: Enable setting "relaxed ordering" in IOMMU mappings
Message-Id: <201609281703.u8SH3F40005804@userv0121.oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enable relaxed ordering for memory writes in IOMMU TSB entry from
dma_4v_alloc_coherent(), dma_4v_map_page() and dma_4v_map_sg() when
dma_attrs DMA_ATTR_WEAK_ORDERING is set. This requires PCI IOMMU I/O
Translation Services version 2.0 API.

Many PCIe devices allow enabling relaxed-ordering (memory writes bypassing
other memory writes) for various DMA buffers. A notable exception is the
Mellanox mlx4 IB adapter. Due to the nature of x86 HW this appears to have
little performance impact there. On SPARC HW however, this results in major
performance degradation getting only about 3Gbps. Enabling RO in the IOMMU
entries corresponding to mlx4 data buffers increases the throughput to
about 13 Gbps.

Orabug: 19245907

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index f5b6537..666d5ba 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -1744,6 +1744,7 @@ unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
 
 #define HV_PCI_MAP_ATTR_READ		0x01
 #define HV_PCI_MAP_ATTR_WRITE		0x02
+#define HV_PCI_MAP_ATTR_RELAXED_ORDER	0x04
 
 #define HV_PCI_DEVICE_BUILD(b,d,f)	\
 	((((b) & 0xff) << 16) | \
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 590e6d3..9d8957a 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -78,6 +78,10 @@ static long iommu_batch_flush(struct iommu_batch *p)
 	u64 *pglist = p->pglist;
 	unsigned long npages = p->npages;
 
+	/* VPCI maj=1, min=[0,1] only supports read and write */
+	if (vpci_major < 2)
+		prot &= (HV_PCI_MAP_ATTR_READ | HV_PCI_MAP_ATTR_WRITE);
+
 	while (npages != 0) {
 		long num;
 
@@ -144,6 +148,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 				   struct dma_attrs *attrs)
 {
 	unsigned long flags, order, first_page, npages, n;
+	unsigned long prot = 0;
 	struct iommu *iommu;
 	struct page *page;
 	void *ret;
@@ -157,6 +162,9 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 
 	npages = size >> IO_PAGE_SHIFT;
 
+	if (dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+		prot = HV_PCI_MAP_ATTR_RELAXED_ORDER;
+
 	nid = dev->archdata.numa_node;
 	page = alloc_pages_node(nid, gfp, order);
 	if (unlikely(!page))
@@ -180,7 +188,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	local_irq_save(flags);
 
 	iommu_batch_start(dev,
-			  (HV_PCI_MAP_ATTR_READ |
+			  (HV_PCI_MAP_ATTR_READ | prot |
 			   HV_PCI_MAP_ATTR_WRITE),
 			  entry);
 
@@ -277,6 +285,9 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	if (direction != DMA_TO_DEVICE)
 		prot |= HV_PCI_MAP_ATTR_WRITE;
 
+	if (dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
+
 	local_irq_save(flags);
 
 	iommu_batch_start(dev, prot, entry);
@@ -350,11 +361,14 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	iommu = dev->archdata.iommu;
 	if (nelems = 0 || !iommu)
 		return 0;
-	
+
 	prot = HV_PCI_MAP_ATTR_READ;
 	if (direction != DMA_TO_DEVICE)
 		prot |= HV_PCI_MAP_ATTR_WRITE;
 
+	if (dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+		prot |= HV_PCI_MAP_ATTR_RELAXED_ORDER;
+
 	outs = s = segstart = &sglist[0];
 	outcount = 1;
 	incount = nelems;
