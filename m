From: Christoph Hellwig <hch@lst.de>
Date: Thu, 04 Apr 2019 16:25:38 +0000
Subject: [PATCH] sparc64/pci_sun4v: fix ATU checks for large DMA masks
Message-Id: <20190404162538.22428-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mroos-Y27EyoLml9s@public.gmane.org

Now that we allow drivers to always need to set larger than required
DMA masks we need to be a little more careful in the sun4v PCI iommu
driver to chose when to select the ATU support - a larger DMA mask
can be set even when the platform does not support ATU, so we always
have to check if it is avaiable before using it.  Add a little helper
for that and use it in all the places where we make ATU usage decisions
based on the DMA mask.

Fixes: 24132a419c68 ("sparc64/pci_sun4v: allow large DMA masks")
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Meelis Roos <mroos@linux.ee>
---
 arch/sparc/kernel/pci_sun4v.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index a8af6023c126..14b93c5564e3 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -73,6 +73,11 @@ static inline void iommu_batch_start(struct device *dev, unsigned long prot, uns
 	p->npages	= 0;
 }
 
+static inline bool iommu_use_atu(struct iommu *iommu, u64 mask)
+{
+	return iommu->atu && mask > DMA_BIT_MASK(32);
+}
+
 /* Interrupts must be disabled.  */
 static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
 {
@@ -92,7 +97,7 @@ static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
 		prot &= (HV_PCI_MAP_ATTR_READ | HV_PCI_MAP_ATTR_WRITE);
 
 	while (npages != 0) {
-		if (mask <= DMA_BIT_MASK(32) || !pbm->iommu->atu) {
+		if (!iommu_use_atu(pbm->iommu, mask)) {
 			num = pci_sun4v_iommu_map(devhandle,
 						  HV_PCI_TSBID(0, entry),
 						  npages,
@@ -179,7 +184,6 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	unsigned long flags, order, first_page, npages, n;
 	unsigned long prot = 0;
 	struct iommu *iommu;
-	struct atu *atu;
 	struct iommu_map_table *tbl;
 	struct page *page;
 	void *ret;
@@ -205,13 +209,11 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	memset((char *)first_page, 0, PAGE_SIZE << order);
 
 	iommu = dev->archdata.iommu;
-	atu = iommu->atu;
-
 	mask = dev->coherent_dma_mask;
-	if (mask <= DMA_BIT_MASK(32) || !atu)
+	if (!iommu_use_atu(iommu, mask))
 		tbl = &iommu->tbl;
 	else
-		tbl = &atu->tbl;
+		tbl = &iommu->atu->tbl;
 
 	entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
 				      (unsigned long)(-1), 0);
@@ -333,7 +335,7 @@ static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 	atu = iommu->atu;
 	devhandle = pbm->devhandle;
 
-	if (dvma <= DMA_BIT_MASK(32)) {
+	if (!iommu_use_atu(iommu, dvma)) {
 		tbl = &iommu->tbl;
 		iotsb_num = 0; /* we don't care for legacy iommu */
 	} else {
@@ -374,7 +376,7 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	npages >>= IO_PAGE_SHIFT;
 
 	mask = *dev->dma_mask;
-	if (mask <= DMA_BIT_MASK(32))
+	if (!iommu_use_atu(iommu, mask))
 		tbl = &iommu->tbl;
 	else
 		tbl = &atu->tbl;
@@ -510,7 +512,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
 
 	mask = *dev->dma_mask;
-	if (mask <= DMA_BIT_MASK(32))
+	if (!iommu_use_atu(iommu, mask))
 		tbl = &iommu->tbl;
 	else
 		tbl = &atu->tbl;
-- 
2.20.1
