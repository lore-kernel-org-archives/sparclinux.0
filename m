From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 11 Jan 2011 10:49:05 +0000
Subject: [PATCH 3/4] sparc: Add pci32_unmap_page.
Message-Id: <1294742946-1040-4-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index bfcbd1e..ba5cf62 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -529,6 +529,14 @@ static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
 	return page_to_phys(page) + offset;
 }
 
+static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
+			     enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	if (dir != PCI_DMA_TODEVICE) {
+		mmu_inval_dma_area((unsigned long)phys_to_virt(ba), PAGE_ALIGN(size));
+	}
+}
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -651,6 +659,7 @@ struct dma_map_ops pci32_dma_ops = {
 	.alloc_coherent		= pci32_alloc_coherent,
 	.free_coherent		= pci32_free_coherent,
 	.map_page		= pci32_map_page,
+	.unmap_page		= pci32_unmap_page,
 	.map_sg			= pci32_map_sg,
 	.unmap_sg		= pci32_unmap_sg,
 	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
-- 
1.6.4.1

