From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 Feb 2019 14:45:57 +0000
Subject: [PATCH 3/5] sparc64/iommu: allow large DMA masks
Message-Id: <20190215144559.8777-4-hch@lst.de>
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
drivers to supply a matching mask.  Change dma_4u_supported to just
check if the supplied dma mask is large enough as nothing in the
iommu.c code (or the core DMA code) actually looks at the DMA mask
later on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 0c253f1c852e..4ae7388b1bff 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -748,11 +748,9 @@ static int dma_4u_supported(struct device *dev, u64 device_mask)
 	if (ali_sound_dma_hack(dev, device_mask))
 		return 1;
 
-	if (device_mask > DMA_BIT_MASK(32))
+	if (device_mask < iommu->dma_addr_mask)
 		return 0;
-	if ((device_mask & iommu->dma_addr_mask) = iommu->dma_addr_mask)
-		return 1;
-	return 0;
+	return 1;
 }
 
 static const struct dma_map_ops sun4u_dma_ops = {
-- 
2.20.1
