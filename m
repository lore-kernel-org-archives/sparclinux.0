From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 21:03:46 +0000
Subject: [PATCH 3/4] cs4231: cleanup conditional on CONFIG_SBUS
Message-Id: <1294261427-26104-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This driver is sparc-only.
And as sparc always has SBUS enabled then there is
no point in keeping #ifdef SBUS

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 sound/sparc/cs4231.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index c276086..b72eca9 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -27,10 +27,6 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 
-#ifdef CONFIG_SBUS
-#define SBUS_SUPPORT
-#endif
-
 #if defined(CONFIG_PCI) && defined(CONFIG_SPARC64)
 #define EBUS_SUPPORT
 #include <linux/pci.h>
@@ -53,13 +49,11 @@ MODULE_DESCRIPTION("Sun CS4231");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Sun,CS4231}}");
 
-#ifdef SBUS_SUPPORT
 struct sbus_dma_info {
        spinlock_t	lock;	/* DMA access lock */
        int		dir;
        void __iomem	*regs;
 };
-#endif
 
 struct snd_cs4231;
 struct cs4231_dma_control {
@@ -72,9 +66,7 @@ struct cs4231_dma_control {
 #ifdef EBUS_SUPPORT
 	struct		ebus_dma_info	ebus_info;
 #endif
-#ifdef SBUS_SUPPORT
 	struct		sbus_dma_info	sbus_info;
-#endif
 };
 
 struct snd_cs4231 {
@@ -1620,8 +1612,6 @@ out_err:
 	return err;
 }
 
-#ifdef SBUS_SUPPORT
-
 static irqreturn_t snd_cs4231_sbus_interrupt(int irq, void *dev_id)
 {
 	unsigned long flags;
@@ -1880,7 +1870,6 @@ static int __devinit cs4231_sbus_probe(struct platform_device *op, const struct
 
 	return cs4231_attach_finish(card);
 }
-#endif
 
 #ifdef EBUS_SUPPORT
 
@@ -2078,11 +2067,9 @@ static int __devinit cs4231_probe(struct platform_device *op, const struct of_de
 	if (!strcmp(op->dev.of_node->parent->name, "ebus"))
 		return cs4231_ebus_probe(op, match);
 #endif
-#ifdef SBUS_SUPPORT
 	if (!strcmp(op->dev.of_node->parent->name, "sbus") ||
 	    !strcmp(op->dev.of_node->parent->name, "sbi"))
 		return cs4231_sbus_probe(op, match);
-#endif
 	return -ENODEV;
 }
 
-- 
1.6.0.6

