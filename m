From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 Feb 2019 14:45:58 +0000
Subject: [PATCH 4/5] sparc64/pci_sun4v: allow large DMA masks
Message-Id: <20190215144559.8777-5-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190215144559.8777-1-hch@lst.de>
In-Reply-To: <20190215144559.8777-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

We've been moving to a model where the device just sets the DMA mask
supported by it, instead of having to fallback to something it thinks
the platform might support.  Sparc64 is the remaining holdout forcing
drivers to supply a matching mask.  Change dma_4v_supported to just
check if the supplied dma mask is large enough. and adjust the mapping
code to check ATU presence in addition to the DMA mask to decice on
the mapping method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/pci_sun4v.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index d30eb22b6e11..a8af6023c126 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -92,7 +92,7 @@ static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
 		prot &= (HV_PCI_MAP_ATTR_READ | HV_PCI_MAP_ATTR_WRITE);
 
 	while (npages != 0) {
-		if (mask <= DMA_BIT_MASK(32)) {
+		if (mask <= DMA_BIT_MASK(32) || !pbm->iommu->atu) {
 			num = pci_sun4v_iommu_map(devhandle,
 						  HV_PCI_TSBID(0, entry),
 						  npages,
@@ -208,7 +208,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	atu = iommu->atu;
 
 	mask = dev->coherent_dma_mask;
-	if (mask <= DMA_BIT_MASK(32))
+	if (mask <= DMA_BIT_MASK(32) || !atu)
 		tbl = &iommu->tbl;
 	else
 		tbl = &atu->tbl;
@@ -674,21 +674,12 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 static int dma_4v_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
-	u64 dma_addr_mask = iommu->dma_addr_mask;
 
 	if (ali_sound_dma_hack(dev, device_mask))
 		return 1;
-
-	if (device_mask > DMA_BIT_MASK(32)) {
-		if (iommu->atu)
-			dma_addr_mask = iommu->atu->dma_addr_mask;
-		else
-			return 0;
-	}
-
-	if ((device_mask & dma_addr_mask) = dma_addr_mask)
-		return 1;
-	return 0;
+	if (device_mask < iommu->dma_addr_mask)
+		return 0;
+	return 1;
 }
 
 static const struct dma_map_ops sun4v_dma_ops = {
-- 
2.20.1
