From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:06 +0000
Subject: [PATCH 19/49]: amd7930: Convert to pure OF driver.
Message-Id: <20080827.212406.44135609.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


amd7930: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 sound/sparc/amd7930.c |   83 ++++++++++++-------------------------------------
 1 files changed, 20 insertions(+), 63 deletions(-)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 0c63e05..0f82c3f 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -1,6 +1,6 @@
 /*
  * Driver for AMD7930 sound chips found on Sparcs.
- * Copyright (C) 2002 David S. Miller <davem@redhat.com>
+ * Copyright (C) 2002, 2008 David S. Miller <davem@davemloft.net>
  *
  * Based entirely upon drivers/sbus/audio/amd7930.c which is:
  * Copyright (C) 1996,1997 Thomas K. Dyas (tdyas@eden.rutgers.edu)
@@ -35,6 +35,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -44,7 +46,6 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/sbus.h>
 #include <asm/prom.h>
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
@@ -335,8 +336,8 @@ struct snd_amd7930 {
 	int			pgain;
 	int			mgain;
 
+	struct of_device	*op;
 	unsigned int		irq;
-	unsigned int		regs_size;
 	struct snd_amd7930	*next;
 };
 
@@ -920,13 +921,16 @@ static int __devinit snd_amd7930_mixer(struct snd_amd7930 *amd)
 
 static int snd_amd7930_free(struct snd_amd7930 *amd)
 {
+	struct of_device *op = amd->op;
+
 	amd7930_idle(amd);
 
 	if (amd->irq)
 		free_irq(amd->irq, amd);
 
 	if (amd->regs)
-		sbus_iounmap(amd->regs, amd->regs_size);
+		of_iounmap(&op->resource[0], amd->regs,
+			   resource_size(&op->resource[0]));
 
 	kfree(amd);
 
@@ -945,13 +949,12 @@ static struct snd_device_ops snd_amd7930_dev_ops = {
 };
 
 static int __devinit snd_amd7930_create(struct snd_card *card,
-					struct resource *rp,
-					unsigned int reg_size,
+					struct of_device *op,
 					int irq, int dev,
 					struct snd_amd7930 **ramd)
 {
-	unsigned long flags;
 	struct snd_amd7930 *amd;
+	unsigned long flags;
 	int err;
 
 	*ramd = NULL;
@@ -961,9 +964,10 @@ static int __devinit snd_amd7930_create(struct snd_card *card,
 
 	spin_lock_init(&amd->lock);
 	amd->card = card;
-	amd->regs_size = reg_size;
+	amd->op = op;
 
-	amd->regs = sbus_ioremap(rp, 0, amd->regs_size, "amd7930");
+	amd->regs = of_ioremap(&op->resource[0], 0,
+			       resource_size(&op->resource[0]), "amd7930");
 	if (!amd->regs) {
 		snd_printk("amd7930-%d: Unable to map chip registers.\n", dev);
 		return -EIO;
@@ -1012,12 +1016,15 @@ static int __devinit snd_amd7930_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit amd7930_attach_common(struct resource *rp, int irq)
+static int __devinit amd7930_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
+	struct resource *rp = &op->resource[0];
 	static int dev_num;
 	struct snd_card *card;
 	struct snd_amd7930 *amd;
-	int err;
+	int err, irq;
+
+	irq = op->irqs[0];
 
 	if (dev_num >= SNDRV_CARDS)
 		return -ENODEV;
@@ -1038,8 +1045,7 @@ static int __devinit amd7930_attach_common(struct resource *rp, int irq)
 		(unsigned long long)rp->start,
 		irq);
 
-	if ((err = snd_amd7930_create(card, rp,
-				      (rp->end - rp->start) + 1,
+	if ((err = snd_amd7930_create(card, op,
 				      irq, dev_num, &amd)) < 0)
 		goto out_err;
 
@@ -1064,42 +1070,6 @@ out_err:
 	return err;
 }
 
-static int __devinit amd7930_obio_attach(struct device_node *dp)
-{
-	const struct linux_prom_registers *regs;
-	const struct linux_prom_irqs *irqp;
-	struct resource res, *rp;
-	int len;
-
-	irqp = of_get_property(dp, "intr", &len);
-	if (!irqp) {
-		snd_printk("%s: Firmware node lacks IRQ property.\n",
-			   dp->full_name);
-		return -ENODEV;
-	}
-
-	regs = of_get_property(dp, "reg", &len);
-	if (!regs) {
-		snd_printk("%s: Firmware node lacks register property.\n",
-			   dp->full_name);
-		return -ENODEV;
-	}
-
-	rp = &res;
-	rp->start = regs->phys_addr;
-	rp->end = rp->start + regs->reg_size - 1;
-	rp->flags = IORESOURCE_IO | (regs->which_io & 0xff);
-
-	return amd7930_attach_common(rp, irqp->pri);
-}
-
-static int __devinit amd7930_sbus_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
-
-	return amd7930_attach_common(&sdev->resource[0], sdev->irqs[0]);
-}
-
 static struct of_device_id amd7930_match[] = {
 	{
 		.name = "audio",
@@ -1115,20 +1085,7 @@ static struct of_platform_driver amd7930_sbus_driver = {
 
 static int __init amd7930_init(void)
 {
-	struct device_node *dp;
-
-	/* Try to find the sun4c "audio" node first. */
-	dp = of_find_node_by_path("/");
-	dp = dp->child;
-	while (dp) {
-		if (!strcmp(dp->name, "audio"))
-			amd7930_obio_attach(dp);
-
-		dp = dp->sibling;
-	}
-
-	/* Probe each SBUS for amd7930 chips. */
-	return of_register_driver(&amd7930_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&amd7930_sbus_driver, &of_bus_type);
 }
 
 static void __exit amd7930_exit(void)
-- 
1.5.6.5.GIT

