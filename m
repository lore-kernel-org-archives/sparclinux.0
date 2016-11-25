From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 11:12:51 +0000
Subject: [patch] sparc64: enable IRQs on error paths
Message-Id: <20161125111054.GE5938@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

There are several error paths where we should enable IRQs but we don't.

Fixes: bb620c3d3925 ("sparc: Make sparc64 use scalable lib/iommu-common.c functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 06981cc7..274df7a 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -230,12 +230,16 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 
 	for (n = 0; n < npages; n++) {
 		long err = iommu_batch_add(first_page + (n * PAGE_SIZE), mask);
-		if (unlikely(err < 0L))
+		if (unlikely(err < 0L)) {
+			local_irq_restore(flags);
 			goto iommu_map_fail;
+		}
 	}
 
-	if (unlikely(iommu_batch_end(mask) < 0L))
+	if (unlikely(iommu_batch_end(mask) < 0L)) {
+		local_irq_restore(flags);
 		goto iommu_map_fail;
+	}
 
 	local_irq_restore(flags);
 
@@ -398,11 +402,15 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 
 	for (i = 0; i < npages; i++, base_paddr += IO_PAGE_SIZE) {
 		long err = iommu_batch_add(base_paddr, mask);
-		if (unlikely(err < 0L))
+		if (unlikely(err < 0L)) {
+			local_irq_restore(flags);
 			goto iommu_map_fail;
+		}
 	}
-	if (unlikely(iommu_batch_end(mask) < 0L))
+	if (unlikely(iommu_batch_end(mask) < 0L)) {
+		local_irq_restore(flags);
 		goto iommu_map_fail;
+	}
 
 	local_irq_restore(flags);
 
