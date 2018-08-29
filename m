From: Christoph Hellwig <hch@lst.de>
Date: Wed, 29 Aug 2018 06:24:01 +0000
Subject: [PATCH 3/3] of/platform: initialise AMBA default DMA masks
Message-Id: <20180829062401.8701-4-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180829062401.8701-1-hch@lst.de>
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, Meelis Roos <mroos@linux.ee>, Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linus.walleij@linaro.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

commit a5516219b102 ("of/platform: Initialise default DMA masks") sets up
the coherent_dma_mask of platform devices created from the device tree,
but fails to do the same for AMBA (PrimeCell) devices.

This leads to a regression in kernel v4.19-rc1 triggering the
WARN_ON_ONCE(dev && !dev->coherent_dma_mask) in dma_alloc_attrs().

This regresses the PL111 DRM driver in drivers/gpu/drm/pl111 that uses
the AMBA PrimeCell to instantiate the frame buffer device, as it cannot
allocate a chunk of coherent memory anymore due to the missing mask.

Fixes: a5516219b102 ("of/platform: Initialise default DMA masks")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[hch: added a comment, and droped a conditional that can't be true]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/of/platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7ba90c290a42..6c59673933e9 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -241,6 +241,10 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	if (!dev)
 		goto err_clear_flag;
 
+	/* AMBA devices only support a single DMA mask */
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+
 	/* setup generic device info */
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.fwnode = &node->fwnode;
-- 
2.18.0
