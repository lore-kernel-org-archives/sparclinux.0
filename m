From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 11:01:32 +0000
Subject: [patch] sparc64: move dereference after check for NULL
Message-Id: <20161125105853.GB5938@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

We shouldn't dereference "iommu" until after we have checked that it is
non-NULL.

Fixes: f08978b0fdbf ("sparc64: Enable sun4v dma ops to use IOMMU v2 APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Applies to sparc.git

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 06981cc7..cabb609 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -478,11 +478,10 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	BUG_ON(direction = DMA_NONE);
 
 	iommu = dev->archdata.iommu;
-	atu = iommu->atu;
-
 	if (nelems = 0 || !iommu)
 		return 0;
-	
+	atu = iommu->atu;
+
 	prot = HV_PCI_MAP_ATTR_READ;
 	if (direction != DMA_TO_DEVICE)
 		prot |= HV_PCI_MAP_ATTR_WRITE;
