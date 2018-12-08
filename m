From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:37:01 +0000
Subject: [PATCH 09/10] dma-mapping: skip declared coherent memory for DMA_ATTR_NON_CONSISTENT
Message-Id: <20181208173702.15158-10-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

Memory declared using dma_declare_coherent is ioremapped and thus not
always suitable for our tightened DMA_ATTR_NON_CONSISTENT definition.

Skip it given all the existing callers don't DMA_ATTR_NON_CONSISTENT
anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7799c2b27849..8c81fa5d1f44 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -521,7 +521,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	BUG_ON(!ops);
 	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
 
-	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT) &&
+	    dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
 	/* let the implementation decide on the zone to allocate from: */
-- 
2.19.2
