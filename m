From: Andreas Larsson <andreas@gaisler.com>
Date: Thu, 18 Oct 2012 07:39:56 +0000
Subject: [PATCH] sparc: Add sparc support for platform_get_resource()
Message-Id: <1350545996-7823-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This adds sparc support for platform_get_irq that in the normal case use
platform_get_resource() to get an irq. This standard approach fails for sparc as
there are no resources of type IORESOURCE_IRQ for irqs for sparc.

Cross platform drivers can then use this standard platform function and work on
sparc instead of having to have a special case for sparc.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/base/platform.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ddeca14..a17199a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -82,9 +82,15 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  */
 int platform_get_irq(struct platform_device *dev, unsigned int num)
 {
+#ifdef CONFIG_SPARC
+	if (!dev || num >= dev->archdata.num_irqs)
+		return -ENXIO;
+	return dev->archdata.irqs[num];
+#else
 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 
 	return r ? r->start : -ENXIO;
+#endif
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
-- 
1.7.0.4

