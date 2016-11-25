From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 21:15:37 +0000
Subject: [patch] sparc64: restore irq in error paths in iommu
Message-Id: <20161125211537.GA4131@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

There are some error paths where we should restore IRQs but we don't.

Fixes: bb620c3d3925 ("sparc: Make sparc64 use scalable lib/iommu-common.c functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 06981cc7..7d23cad 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -242,6 +242,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 
 iommu_map_fail:
+	local_irq_restore(flags);
 	iommu_tbl_range_free(tbl, *dma_addrp, npages, IOMMU_ERROR_CODE);
 
 range_alloc_fail:
@@ -414,6 +415,7 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	return DMA_ERROR_CODE;
 
 iommu_map_fail:
+	local_irq_restore(flags);
 	iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
 	return DMA_ERROR_CODE;
 }
