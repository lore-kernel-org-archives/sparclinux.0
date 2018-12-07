From: Christoph Hellwig <hch@lst.de>
Date: Fri, 07 Dec 2018 14:14:04 +0000
Subject: [PATCH 1/4] sparc: remove no needed sbus_dma_ops methods
Message-Id: <20181207141407.3154-2-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

No need to BUG_ON() on the cache maintainance ops - they are no-ops
by default, and there is nothing in the DMA API contract that prohibits
calling them on sbus devices (even if such drivers are unlikely to
ever appear).

Similarly a dma_supported method that always returns 0 is rather
pointless.  The only thing that indicates is that no one ever calls
the method on sbus devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/ioport.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 6799c93c9f27..4b2167a0ec0b 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -391,23 +391,6 @@ static void sbus_unmap_sg(struct device *dev, struct scatterlist *sg, int n,
 	mmu_release_scsi_sgl(dev, sg, n);
 }
 
-static void sbus_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-				 int n,	enum dma_data_direction dir)
-{
-	BUG();
-}
-
-static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-				    int n, enum dma_data_direction dir)
-{
-	BUG();
-}
-
-static int sbus_dma_supported(struct device *dev, u64 mask)
-{
-	return 0;
-}
-
 static const struct dma_map_ops sbus_dma_ops = {
 	.alloc			= sbus_alloc_coherent,
 	.free			= sbus_free_coherent,
@@ -415,9 +398,6 @@ static const struct dma_map_ops sbus_dma_ops = {
 	.unmap_page		= sbus_unmap_page,
 	.map_sg			= sbus_map_sg,
 	.unmap_sg		= sbus_unmap_sg,
-	.sync_sg_for_cpu	= sbus_sync_sg_for_cpu,
-	.sync_sg_for_device	= sbus_sync_sg_for_device,
-	.dma_supported		= sbus_dma_supported,
 };
 
 static int __init sparc_register_ioport(void)
-- 
2.19.1
