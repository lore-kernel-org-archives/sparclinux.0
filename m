From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 30 Oct 2012 09:26:56 +0000
Subject: [PATCH v3] sparc: Add sparc support for platform_get_irq()
Message-Id: <1351589216-15076-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <0b77f2a2dd52bc39c770491689efc752@gaisler.com>
In-Reply-To: <0b77f2a2dd52bc39c770491689efc752@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: software@gaisler.com, sam@ravnborg.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

This adds sparc support for platform_get_irq that in the normal case use
platform_get_resource() to get an irq. This standard approach fails for sparc as
there are no resources of type IORESOURCE_IRQ for irqs for sparc.

Cross platform drivers can then use this standard platform function and work on
sparc instead of having to have a special case for sparc.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/base/platform.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ddeca14..9c2f828 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -82,9 +82,16 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  */
 int platform_get_irq(struct platform_device *dev, unsigned int num)
 {
+#ifdef CONFIG_SPARC
+	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
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

