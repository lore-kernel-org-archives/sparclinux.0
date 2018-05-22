From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:07 +0000
Subject: [PATCH 02/25] hexagon: implement the sync_sg_for_device DMA operation
Message-Id: <20180522120430.28709-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

This methods needs to provide the equivalent of sync_single_for_device
for each S/G list element, but was missing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index d2b717f352f4..9e46556a227d 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -188,6 +188,18 @@ static void hexagon_sync_single_for_device(struct device *dev,
 	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
 }
 
+static void hexagon_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		hexagon_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
+}
+
+
 static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr = HEXAGON_MAPPING_ERROR;
@@ -199,6 +211,7 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
 	.sync_single_for_device = hexagon_sync_single_for_device,
+	.sync_sg_for_device = hexagon_sync_sg_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
 
-- 
2.17.0

