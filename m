From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:19 +0000
Subject: [PATCH 23/49]: cs4231: Convert SBUS side to OF driver.
Message-Id: <20080827.212419.40806753.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


cs4231: Convert SBUS side to OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 sound/sparc/cs4231.c |   78 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index e2be131..271b042 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1,6 +1,6 @@
 /*
  * Driver for CS4231 sound chips found on Sparcs.
- * Copyright (C) 2002 David S. Miller <davem@redhat.com>
+ * Copyright (C) 2002, 2008 David S. Miller <davem@davemloft.net>
  *
  * Based entirely upon drivers/sbus/audio/cs4231.c which is:
  * Copyright (C) 1996, 1997, 1998 Derrick J Brashear (shadow@andrew.cmu.edu)
@@ -17,7 +17,8 @@
 #include <linux/moduleparam.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -29,7 +30,6 @@
 
 #ifdef CONFIG_SBUS
 #define SBUS_SUPPORT
-#include <asm/sbus.h>
 #endif
 
 #if defined(CONFIG_PCI) && defined(CONFIG_SPARC64)
@@ -116,7 +116,7 @@ struct snd_cs4231 {
 
 	union {
 #ifdef SBUS_SUPPORT
-		struct sbus_dev		*sdev;
+		struct of_device	*op;
 #endif
 #ifdef EBUS_SUPPORT
 		struct pci_dev		*pdev;
@@ -1785,7 +1785,7 @@ static unsigned int sbus_dma_addr(struct cs4231_dma_control *dma_cont)
 static void sbus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &chip->dev_u.sdev->ofdev.dev,
+					      &chip->dev_u.op->dev,
 					      64 * 1024, 128 * 1024);
 }
 
@@ -1795,11 +1795,13 @@ static void sbus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
 
 static int snd_cs4231_sbus_free(struct snd_cs4231 *chip)
 {
+	struct of_device *op = chip->dev_u.op;
+
 	if (chip->irq[0])
 		free_irq(chip->irq[0], chip);
 
 	if (chip->port)
-		sbus_iounmap(chip->port, chip->regs_size);
+		of_iounmap(&op->resource[0], chip->port, chip->regs_size);
 
 	return 0;
 }
@@ -1816,7 +1818,7 @@ static struct snd_device_ops snd_cs4231_sbus_dev_ops = {
 };
 
 static int __init snd_cs4231_sbus_create(struct snd_card *card,
-					 struct sbus_dev *sdev,
+					 struct of_device *op,
 					 int dev)
 {
 	struct snd_cs4231 *chip = card->private_data;
@@ -1827,13 +1829,13 @@ static int __init snd_cs4231_sbus_create(struct snd_card *card,
 	spin_lock_init(&chip->p_dma.sbus_info.lock);
 	mutex_init(&chip->mce_mutex);
 	mutex_init(&chip->open_mutex);
-	chip->dev_u.sdev = sdev;
-	chip->regs_size = sdev->reg_addrs[0].reg_size;
+	chip->dev_u.op = op;
+	chip->regs_size = resource_size(&op->resource[0]);
 	memcpy(&chip->image, &snd_cs4231_original_image,
 	       sizeof(snd_cs4231_original_image));
 
-	chip->port = sbus_ioremap(&sdev->resource[0], 0,
-				  chip->regs_size, "cs4231");
+	chip->port = of_ioremap(&op->resource[0], 0,
+				chip->regs_size, "cs4231");
 	if (!chip->port) {
 		snd_printdd("cs4231-%d: Unable to map chip registers.\n", dev);
 		return -EIO;
@@ -1856,14 +1858,14 @@ static int __init snd_cs4231_sbus_create(struct snd_card *card,
 	chip->c_dma.address = sbus_dma_addr;
 	chip->c_dma.preallocate = sbus_dma_preallocate;
 
-	if (request_irq(sdev->irqs[0], snd_cs4231_sbus_interrupt,
+	if (request_irq(op->irqs[0], snd_cs4231_sbus_interrupt,
 			IRQF_SHARED, "cs4231", chip)) {
 		snd_printdd("cs4231-%d: Unable to grab SBUS IRQ %d\n",
-			    dev, sdev->irqs[0]);
+			    dev, op->irqs[0]);
 		snd_cs4231_sbus_free(chip);
 		return -EBUSY;
 	}
-	chip->irq[0] = sdev->irqs[0];
+	chip->irq[0] = op->irqs[0];
 
 	if (snd_cs4231_probe(chip) < 0) {
 		snd_cs4231_sbus_free(chip);
@@ -1880,12 +1882,16 @@ static int __init snd_cs4231_sbus_create(struct snd_card *card,
 	return 0;
 }
 
-static int __init cs4231_sbus_attach(struct sbus_dev *sdev)
+static int __devinit cs4231_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct resource *rp = &sdev->resource[0];
+	struct resource *rp = &op->resource[0];
 	struct snd_card *card;
 	int err;
 
+	if (strcmp(op->node->parent->name, "sbus") &&
+	    strcmp(op->node->parent->name, "sbi"))
+		return -ENODEV;
+
 	err = cs4231_attach_begin(&card);
 	if (err)
 		return err;
@@ -1894,9 +1900,9 @@ static int __init cs4231_sbus_attach(struct sbus_dev *sdev)
 		card->shortname,
 		rp->flags & 0xffL,
 		(unsigned long long)rp->start,
-		sdev->irqs[0]);
+		op->irqs[0]);
 
-	err = snd_cs4231_sbus_create(card, sdev, dev);
+	err = snd_cs4231_sbus_create(card, op, dev);
 	if (err < 0) {
 		snd_card_free(card);
 		return err;
@@ -2101,12 +2107,25 @@ static int __init cs4231_ebus_attach(struct linux_ebus_device *edev)
 }
 #endif
 
-static int __init cs4231_init(void)
-{
 #ifdef SBUS_SUPPORT
-	struct sbus_bus *sbus;
-	struct sbus_dev *sdev;
+static struct of_device_id cs4231_match[] = {
+	{
+		.name = "SUNW,CS4231",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, cs4231_match);
+
+static struct of_platform_driver cs4231_driver = {
+	.name		= "audio",
+	.match_table	= cs4231_match,
+	.probe		= cs4231_probe,
+};
 #endif
+
+static int __init cs4231_init(void)
+{
 #ifdef EBUS_SUPPORT
 	struct linux_ebus *ebus;
 	struct linux_ebus_device *edev;
@@ -2116,11 +2135,10 @@ static int __init cs4231_init(void)
 	found = 0;
 
 #ifdef SBUS_SUPPORT
-	for_all_sbusdev(sdev, sbus) {
-		if (!strcmp(sdev->prom_name, "SUNW,CS4231")) {
-			if (cs4231_sbus_attach(sdev) = 0)
-				found++;
-		}
+	{
+		int err = of_register_driver(&cs4231_driver, &of_bus_type);
+		if (err)
+			return err;
 	}
 #endif
 #ifdef EBUS_SUPPORT
@@ -2147,13 +2165,17 @@ static int __init cs4231_init(void)
 #endif
 
 
-	return (found > 0) ? 0 : -EIO;
+	return 0;
 }
 
 static void __exit cs4231_exit(void)
 {
 	struct snd_cs4231 *p = cs4231_list;
 
+#ifdef SBUS_SUPPORT
+	of_unregister_driver(&cs4231_driver);
+#endif
+
 	while (p != NULL) {
 		struct snd_cs4231 *next = p->next;
 
-- 
1.5.6.5.GIT

