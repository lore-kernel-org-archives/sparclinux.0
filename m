From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:19 +0000
Subject: [PATCH 14/25] openrisc: fix cache maintainance the the sync_single_for_device DMA operation
Message-Id: <20180522120430.28709-15-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

The cache maintaince in the sync_single_for_device operation should be
equivalent to the map_page operation to facilitate reusing buffers.  Fix the
openrisc implementation by moving the cache maintaince performed in map_page
into the sync_single method, and calling that from map_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 42 +++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 7cadff93d179..d6a0bf1fa713 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -133,19 +133,15 @@ or1k_dma_free(struct device *dev, size_t size, void *vaddr,
 	free_pages_exact(vaddr, size);
 }
 
-static dma_addr_t
-or1k_map_page(struct device *dev, struct page *page,
-	      unsigned long offset, size_t size,
-	      enum dma_data_direction dir,
-	      unsigned long attrs)
+static void
+or1k_sync_single_for_device(struct device *dev,
+			    dma_addr_t dma_handle, size_t size,
+			    enum dma_data_direction dir)
 {
 	unsigned long cl;
-	dma_addr_t addr = page_to_phys(page) + offset;
+	dma_addr_t addr = dma_handle;
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
 
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return addr;
-
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
@@ -168,6 +164,20 @@ or1k_map_page(struct device *dev, struct page *page,
 		break;
 	}
 
+}
+
+static dma_addr_t
+or1k_map_page(struct device *dev, struct page *page,
+	      unsigned long offset, size_t size,
+	      enum dma_data_direction dir,
+	      unsigned long attrs)
+{
+	unsigned long cl;
+	dma_addr_t addr = page_to_phys(page) + offset;
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		or1k_sync_single_for_device(dev, addr, size, dir);
 	return addr;
 }
 
@@ -187,20 +197,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_sync_single_for_device(struct device *dev,
-			    dma_addr_t dma_handle, size_t size,
-			    enum dma_data_direction dir)
-{
-	unsigned long cl;
-	dma_addr_t addr = dma_handle;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
-	/* Flush the dcache for the requested range */
-	for (cl = addr; cl < addr + size; cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBFR, cl);
-}
-
 const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
-- 
2.17.0

