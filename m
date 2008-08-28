From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:10 +0000
Subject: [PATCH 20/49]: dbri: Convert to pure OF driver.
Message-Id: <20080827.212410.47041183.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


dbri: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 sound/sparc/dbri.c |   59 +++++++++++++++++++++++----------------------------
 1 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 5242ecb..446f985 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -67,7 +67,7 @@
 #include <sound/initval.h>
 
 #include <linux/of.h>
-#include <asm/sbus.h>
+#include <linux/of_device.h>
 #include <asm/atomic.h>
 
 MODULE_AUTHOR("Rudolf Koenig, Brent Baccala and Martin Habets");
@@ -298,7 +298,7 @@ struct dbri_streaminfo {
 /* This structure holds the information for both chips (DBRI & CS4215) */
 struct snd_dbri {
 	int regs_size, irq;	/* Needed for unload */
-	struct sbus_dev *sdev;	/* SBUS device info */
+	struct of_device *op;	/* OF device info */
 	spinlock_t lock;
 
 	struct dbri_dma *dma;	/* Pointer to our DMA block */
@@ -2099,7 +2099,7 @@ static int snd_dbri_hw_params(struct snd_pcm_substream *substream,
 			direction = DMA_FROM_DEVICE;
 
 		info->dvma_buffer -			dma_map_single(&dbri->sdev->ofdev.dev,
+			dma_map_single(&dbri->op->dev,
 				       runtime->dma_area,
 				       params_buffer_bytes(hw_params),
 				       direction);
@@ -2127,7 +2127,7 @@ static int snd_dbri_hw_free(struct snd_pcm_substream *substream)
 		else
 			direction = DMA_FROM_DEVICE;
 
-		dma_unmap_single(&dbri->sdev->ofdev.dev, info->dvma_buffer,
+		dma_unmap_single(&dbri->op->dev, info->dvma_buffer,
 				 substream->runtime->buffer_size, direction);
 		info->dvma_buffer = 0;
 	}
@@ -2516,17 +2516,17 @@ static void __devinit snd_dbri_proc(struct snd_card *card)
 static void snd_dbri_free(struct snd_dbri *dbri);
 
 static int __devinit snd_dbri_create(struct snd_card *card,
-				  struct sbus_dev *sdev,
-				  int irq, int dev)
+				     struct of_device *op,
+				     int irq, int dev)
 {
 	struct snd_dbri *dbri = card->private_data;
 	int err;
 
 	spin_lock_init(&dbri->lock);
-	dbri->sdev = sdev;
+	dbri->op = op;
 	dbri->irq = irq;
 
-	dbri->dma = dma_alloc_coherent(&sdev->ofdev.dev,
+	dbri->dma = dma_alloc_coherent(&op->dev,
 				       sizeof(struct dbri_dma),
 				       &dbri->dma_dvma, GFP_ATOMIC);
 	memset((void *)dbri->dma, 0, sizeof(struct dbri_dma));
@@ -2535,12 +2535,12 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 		dbri->dma, dbri->dma_dvma);
 
 	/* Map the registers into memory. */
-	dbri->regs_size = sdev->reg_addrs[0].reg_size;
-	dbri->regs = sbus_ioremap(&sdev->resource[0], 0,
-				  dbri->regs_size, "DBRI Registers");
+	dbri->regs_size = resource_size(&op->resource[0]);
+	dbri->regs = of_ioremap(&op->resource[0], 0,
+				dbri->regs_size, "DBRI Registers");
 	if (!dbri->regs) {
 		printk(KERN_ERR "DBRI: could not allocate registers\n");
-		dma_free_coherent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
+		dma_free_coherent(&op->dev, sizeof(struct dbri_dma),
 				  (void *)dbri->dma, dbri->dma_dvma);
 		return -EIO;
 	}
@@ -2549,8 +2549,8 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 			  "DBRI audio", dbri);
 	if (err) {
 		printk(KERN_ERR "DBRI: Can't get irq %d\n", dbri->irq);
-		sbus_iounmap(dbri->regs, dbri->regs_size);
-		dma_free_coherent(&sdev->ofdev.dev, sizeof(struct dbri_dma),
+		of_iounmap(&op->resource[0], dbri->regs, dbri->regs_size);
+		dma_free_coherent(&op->dev, sizeof(struct dbri_dma),
 				  (void *)dbri->dma, dbri->dma_dvma);
 		return err;
 	}
@@ -2575,28 +2575,23 @@ static void snd_dbri_free(struct snd_dbri *dbri)
 		free_irq(dbri->irq, dbri);
 
 	if (dbri->regs)
-		sbus_iounmap(dbri->regs, dbri->regs_size);
+		of_iounmap(&dbri->op->resource[0], dbri->regs, dbri->regs_size);
 
 	if (dbri->dma)
-		dma_free_coherent(&dbri->sdev->ofdev.dev,
+		dma_free_coherent(&dbri->op->dev,
 				  sizeof(struct dbri_dma),
 				  (void *)dbri->dma, dbri->dma_dvma);
 }
 
-static int __devinit dbri_probe(struct of_device *of_dev,
-				const struct of_device_id *match)
+static int __devinit dbri_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct sbus_dev *sdev = to_sbus_device(&of_dev->dev);
 	struct snd_dbri *dbri;
-	int irq;
 	struct resource *rp;
 	struct snd_card *card;
 	static int dev = 0;
+	int irq;
 	int err;
 
-	dprintk(D_GEN, "DBRI: Found %s in SBUS slot %d\n",
-		sdev->prom_name, sdev->slot);
-
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
@@ -2604,7 +2599,7 @@ static int __devinit dbri_probe(struct of_device *of_dev,
 		return -ENOENT;
 	}
 
-	irq = sdev->irqs[0];
+	irq = op->irqs[0];
 	if (irq <= 0) {
 		printk(KERN_ERR "DBRI-%d: No IRQ.\n", dev);
 		return -ENODEV;
@@ -2617,12 +2612,12 @@ static int __devinit dbri_probe(struct of_device *of_dev,
 
 	strcpy(card->driver, "DBRI");
 	strcpy(card->shortname, "Sun DBRI");
-	rp = &sdev->resource[0];
+	rp = &op->resource[0];
 	sprintf(card->longname, "%s at 0x%02lx:0x%016Lx, irq %d",
 		card->shortname,
 		rp->flags & 0xffL, (unsigned long long)rp->start, irq);
 
-	err = snd_dbri_create(card, sdev, irq, dev);
+	err = snd_dbri_create(card, op, irq, dev);
 	if (err < 0) {
 		snd_card_free(card);
 		return err;
@@ -2639,7 +2634,7 @@ static int __devinit dbri_probe(struct of_device *of_dev,
 
 	/* /proc file handling */
 	snd_dbri_proc(card);
-	dev_set_drvdata(&of_dev->dev, card);
+	dev_set_drvdata(&op->dev, card);
 
 	err = snd_card_register(card);
 	if (err < 0)
@@ -2647,7 +2642,7 @@ static int __devinit dbri_probe(struct of_device *of_dev,
 
 	printk(KERN_INFO "audio%d at %p (irq %d) is DBRI(%c)+CS4215(%d)\n",
 	       dev, dbri->regs,
-	       dbri->irq, sdev->prom_name[9], dbri->mm.version);
+	       dbri->irq, op->node->name[9], dbri->mm.version);
 	dev++;
 
 	return 0;
@@ -2658,14 +2653,14 @@ _err:
 	return err;
 }
 
-static int __devexit dbri_remove(struct of_device *dev)
+static int __devexit dbri_remove(struct of_device *op)
 {
-	struct snd_card *card = dev_get_drvdata(&dev->dev);
+	struct snd_card *card = dev_get_drvdata(&op->dev);
 
 	snd_dbri_free(card->private_data);
 	snd_card_free(card);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
 }
@@ -2692,7 +2687,7 @@ static struct of_platform_driver dbri_sbus_driver = {
 /* Probe for the dbri chip and then attach the driver. */
 static int __init dbri_init(void)
 {
-	return of_register_driver(&dbri_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&dbri_sbus_driver, &of_bus_type);
 }
 
 static void __exit dbri_exit(void)
-- 
1.5.6.5.GIT

