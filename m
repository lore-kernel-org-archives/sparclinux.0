From: Christoph Hellwig <hch@lst.de>
Date: Wed, 29 Aug 2018 06:23:59 +0000
Subject: [PATCH 1/3] driver core: initialize a default DMA mask for platform device
Message-Id: <20180829062401.8701-2-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180829062401.8701-1-hch@lst.de>
In-Reply-To: <20180829062401.8701-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

We still treat devices without a DMA mask as defaulting to 32-bits for
both mask, but a few releases ago we've started warning about such
cases, as they require special cases to work around this sloppyness.
Add a dma_mask field to struct platform_object so that we can initialize
the dma_mask pointer in struct device and initialize both masks to
32-bits by default.  Architectures can still override this in
arch_setup_pdev_archdata if needed.

Note that the code looks a little odd with the various conditionals
because we have to support platform_device structures that are
statically allocated.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c         | 15 +++++++++++++--
 include/linux/platform_device.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..baf4b06cf2d9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -225,6 +225,17 @@ struct platform_object {
 	char name[];
 };
 
+static void setup_pdev_archdata(struct platform_device *pdev)
+{
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dma_mask)
+		pdev->dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &pdev->dma_mask;
+	arch_setup_pdev_archdata(pdev);
+};
+
 /**
  * platform_device_put - destroy a platform device
  * @pdev: platform device to free
@@ -271,7 +282,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
 		pa->pdev.dev.release = platform_device_release;
-		arch_setup_pdev_archdata(&pa->pdev);
+		setup_pdev_archdata(&pa->pdev);
 	}
 
 	return pa ? &pa->pdev : NULL;
@@ -472,7 +483,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
 int platform_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
-	arch_setup_pdev_archdata(pdev);
+	setup_pdev_archdata(pdev);
 	return platform_device_add(pdev);
 }
 EXPORT_SYMBOL_GPL(platform_device_register);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1a9f38f27f65..d9dc4883d5fb 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	int		id;
 	bool		id_auto;
 	struct device	dev;
+	u64		dma_mask;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.18.0
