From: Christoph Hellwig <hch@lst.de>
Date: Tue, 28 Aug 2018 11:43:58 +0000
Subject: Re: new SBus related DMA warnings in 4.18+git
Message-Id: <20180828114358.GA14519@lst.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
	<alpine.LRH.2.21.1808272203270.28446@math.ut.ee>
	<20180828092915.GC12488@lst.de>
	<alpine.LRH.2.21.1808281330270.13945@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1808281330270.13945-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Updated version including that has survived contact with a sparc cross
compiler below.  Note that this is on top of the previous patch adding
a dma_mask to struct platform_device, which I've included as well.

--Kj7319i9nmIyA2yE
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-driver-core-initialize-a-default-DMA-mask-for-platfo.patch"

From e22d27b9bf48c0e3d6eb106f596972c9357ed24d Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 27 Aug 2018 17:23:24 +0200
Subject: driver core: initialize a default DMA mask for platform device

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


--Kj7319i9nmIyA2yE
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-sparc-set-a-default-32-bit-dma-mask-for-OF-devices.patch"

From b4c6e6779559a1bcda41fad0f2e8b713fcf96446 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 28 Aug 2018 11:25:51 +0200
Subject: sparc: set a default 32-bit dma mask for OF devices

This keeps the historic default behavior for devices without a DMA mask,
but removes the warning about a lacking DMA mask for doing DMA without
a mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/of_device_32.c | 5 +++++
 arch/sparc/kernel/of_device_64.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 3641a294ed54..7f3dec7e1e78 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
 
@@ -381,6 +382,10 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
 
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
+
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
 		       dp->full_name);
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 44e4d4435bed..d94c31822da1 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/mod_devicetable.h>
@@ -675,6 +676,9 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		dev_set_name(&op->dev, "root");
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
-- 
2.18.0


--Kj7319i9nmIyA2yE--
