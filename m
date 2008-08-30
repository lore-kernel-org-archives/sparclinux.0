From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 07:58:29 +0000
Subject: [PATCH 3/6]: cs4231: Convert to EBUS side to pure OF driver.
Message-Id: <20080830.005829.198293204.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


cs4231: Convert to EBUS side to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 sound/sparc/cs4231.c |  172 ++++++++++++++++----------------------------------
 1 files changed, 54 insertions(+), 118 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index e6dba4f..cdbfae9 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -35,7 +35,6 @@
 #if defined(CONFIG_PCI) && defined(CONFIG_SPARC64)
 #define EBUS_SUPPORT
 #include <linux/pci.h>
-#include <asm/ebus.h>
 #include <asm/ebus_dma.h>
 #endif
 
@@ -71,8 +70,6 @@ struct cs4231_dma_control {
 	int		(*request)(struct cs4231_dma_control *dma_cont,
 				   dma_addr_t bus_addr, size_t len);
 	unsigned int	(*address)(struct cs4231_dma_control *dma_cont);
-	void		(*preallocate)(struct snd_cs4231 *chip,
-				       struct snd_pcm *pcm);
 #ifdef EBUS_SUPPORT
 	struct		ebus_dma_info	ebus_info;
 #endif
@@ -115,21 +112,12 @@ struct snd_cs4231 {
 	struct mutex		mce_mutex;	/* mutex for mce register */
 	struct mutex		open_mutex;	/* mutex for ALSA open/close */
 
-	union {
-#ifdef SBUS_SUPPORT
-		struct of_device	*op;
-#endif
-#ifdef EBUS_SUPPORT
-		struct pci_dev		*pdev;
-#endif
-	} dev_u;
+	struct of_device	*op;
 	unsigned int		irq[2];
 	unsigned int		regs_size;
 	struct snd_cs4231	*next;
 };
 
-static struct snd_cs4231 *cs4231_list;
-
 /* Eventually we can use sound/isa/cs423x/cs4231_lib.c directly, but for
  * now....  -DaveM
  */
@@ -268,27 +256,19 @@ static unsigned char snd_cs4231_original_image[32]  
 static u8 __cs4231_readb(struct snd_cs4231 *cp, void __iomem *reg_addr)
 {
-#ifdef EBUS_SUPPORT
 	if (cp->flags & CS4231_FLAG_EBUS)
 		return readb(reg_addr);
 	else
-#endif
-#ifdef SBUS_SUPPORT
 		return sbus_readb(reg_addr);
-#endif
 }
 
 static void __cs4231_writeb(struct snd_cs4231 *cp, u8 val,
 			    void __iomem *reg_addr)
 {
-#ifdef EBUS_SUPPORT
 	if (cp->flags & CS4231_FLAG_EBUS)
 		return writeb(val, reg_addr);
 	else
-#endif
-#ifdef SBUS_SUPPORT
 		return sbus_writeb(val, reg_addr);
-#endif
 }
 
 /*
@@ -1259,7 +1239,9 @@ static int __init snd_cs4231_pcm(struct snd_card *card)
 	pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
 	strcpy(pcm->name, "CS4231");
 
-	chip->p_dma.preallocate(chip, pcm);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      &chip->op->dev,
+					      64 * 1024, 128 * 1024);
 
 	chip->pcm = pcm;
 
@@ -1627,8 +1609,7 @@ static int __init cs4231_attach_finish(struct snd_card *card)
 	if (err < 0)
 		goto out_err;
 
-	chip->next = cs4231_list;
-	cs4231_list = chip;
+	dev_set_drvdata(&chip->op->dev, chip);
 
 	dev++;
 	return 0;
@@ -1783,20 +1764,13 @@ static unsigned int sbus_dma_addr(struct cs4231_dma_control *dma_cont)
 	return sbus_readl(base->regs + base->dir + APCVA);
 }
 
-static void sbus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &chip->dev_u.op->dev,
-					      64 * 1024, 128 * 1024);
-}
-
 /*
  * Init and exit routines
  */
 
 static int snd_cs4231_sbus_free(struct snd_cs4231 *chip)
 {
-	struct of_device *op = chip->dev_u.op;
+	struct of_device *op = chip->op;
 
 	if (chip->irq[0])
 		free_irq(chip->irq[0], chip);
@@ -1830,7 +1804,7 @@ static int __init snd_cs4231_sbus_create(struct snd_card *card,
 	spin_lock_init(&chip->p_dma.sbus_info.lock);
 	mutex_init(&chip->mce_mutex);
 	mutex_init(&chip->open_mutex);
-	chip->dev_u.op = op;
+	chip->op = op;
 	chip->regs_size = resource_size(&op->resource[0]);
 	memcpy(&chip->image, &snd_cs4231_original_image,
 	       sizeof(snd_cs4231_original_image));
@@ -1851,13 +1825,11 @@ static int __init snd_cs4231_sbus_create(struct snd_card *card,
 	chip->p_dma.enable = sbus_dma_enable;
 	chip->p_dma.request = sbus_dma_request;
 	chip->p_dma.address = sbus_dma_addr;
-	chip->p_dma.preallocate = sbus_dma_preallocate;
 
 	chip->c_dma.prepare = sbus_dma_prepare;
 	chip->c_dma.enable = sbus_dma_enable;
 	chip->c_dma.request = sbus_dma_request;
 	chip->c_dma.address = sbus_dma_addr;
-	chip->c_dma.preallocate = sbus_dma_preallocate;
 
 	if (request_irq(op->irqs[0], snd_cs4231_sbus_interrupt,
 			IRQF_SHARED, "cs4231", chip)) {
@@ -1883,16 +1855,12 @@ static int __init snd_cs4231_sbus_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit cs4231_probe(struct of_device *op, const struct of_device_id *match)
+static int __devinit cs4231_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct resource *rp = &op->resource[0];
 	struct snd_card *card;
 	int err;
 
-	if (strcmp(op->node->parent->name, "sbus") &&
-	    strcmp(op->node->parent->name, "sbi"))
-		return -ENODEV;
-
 	err = cs4231_attach_begin(&card);
 	if (err)
 		return err;
@@ -1956,30 +1924,25 @@ static unsigned int _ebus_dma_addr(struct cs4231_dma_control *dma_cont)
 	return ebus_dma_addr(&dma_cont->ebus_info);
 }
 
-static void _ebus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-				      snd_dma_pci_data(chip->dev_u.pdev),
-				      64*1024, 128*1024);
-}
-
 /*
  * Init and exit routines
  */
 
 static int snd_cs4231_ebus_free(struct snd_cs4231 *chip)
 {
+	struct of_device *op = chip->op;
+
 	if (chip->c_dma.ebus_info.regs) {
 		ebus_dma_unregister(&chip->c_dma.ebus_info);
-		iounmap(chip->c_dma.ebus_info.regs);
+		of_iounmap(&op->resource[2], chip->c_dma.ebus_info.regs, 0x10);
 	}
 	if (chip->p_dma.ebus_info.regs) {
 		ebus_dma_unregister(&chip->p_dma.ebus_info);
-		iounmap(chip->p_dma.ebus_info.regs);
+		of_iounmap(&op->resource[1], chip->p_dma.ebus_info.regs, 0x10);
 	}
 
 	if (chip->port)
-		iounmap(chip->port);
+		of_iounmap(&op->resource[0], chip->port, 0x10);
 
 	return 0;
 }
@@ -1996,7 +1959,7 @@ static struct snd_device_ops snd_cs4231_ebus_dev_ops = {
 };
 
 static int __init snd_cs4231_ebus_create(struct snd_card *card,
-					 struct linux_ebus_device *edev,
+					 struct of_device *op,
 					 int dev)
 {
 	struct snd_cs4231 *chip = card->private_data;
@@ -2008,35 +1971,35 @@ static int __init snd_cs4231_ebus_create(struct snd_card *card,
 	mutex_init(&chip->mce_mutex);
 	mutex_init(&chip->open_mutex);
 	chip->flags |= CS4231_FLAG_EBUS;
-	chip->dev_u.pdev = edev->bus->self;
+	chip->op = op;
 	memcpy(&chip->image, &snd_cs4231_original_image,
 	       sizeof(snd_cs4231_original_image));
 	strcpy(chip->c_dma.ebus_info.name, "cs4231(capture)");
 	chip->c_dma.ebus_info.flags = EBUS_DMA_FLAG_USE_EBDMA_HANDLER;
 	chip->c_dma.ebus_info.callback = snd_cs4231_ebus_capture_callback;
 	chip->c_dma.ebus_info.client_cookie = chip;
-	chip->c_dma.ebus_info.irq = edev->irqs[0];
+	chip->c_dma.ebus_info.irq = op->irqs[0];
 	strcpy(chip->p_dma.ebus_info.name, "cs4231(play)");
 	chip->p_dma.ebus_info.flags = EBUS_DMA_FLAG_USE_EBDMA_HANDLER;
 	chip->p_dma.ebus_info.callback = snd_cs4231_ebus_play_callback;
 	chip->p_dma.ebus_info.client_cookie = chip;
-	chip->p_dma.ebus_info.irq = edev->irqs[1];
+	chip->p_dma.ebus_info.irq = op->irqs[1];
 
 	chip->p_dma.prepare = _ebus_dma_prepare;
 	chip->p_dma.enable = _ebus_dma_enable;
 	chip->p_dma.request = _ebus_dma_request;
 	chip->p_dma.address = _ebus_dma_addr;
-	chip->p_dma.preallocate = _ebus_dma_preallocate;
 
 	chip->c_dma.prepare = _ebus_dma_prepare;
 	chip->c_dma.enable = _ebus_dma_enable;
 	chip->c_dma.request = _ebus_dma_request;
 	chip->c_dma.address = _ebus_dma_addr;
-	chip->c_dma.preallocate = _ebus_dma_preallocate;
 
-	chip->port = ioremap(edev->resource[0].start, 0x10);
-	chip->p_dma.ebus_info.regs = ioremap(edev->resource[1].start, 0x10);
-	chip->c_dma.ebus_info.regs = ioremap(edev->resource[2].start, 0x10);
+	chip->port = of_ioremap(&op->resource[0], 0, 0x10, "cs4231");
+	chip->p_dma.ebus_info.regs +		of_ioremap(&op->resource[1], 0, 0x10, "cs4231_pdma");
+	chip->c_dma.ebus_info.regs +		of_ioremap(&op->resource[2], 0, 0x10, "cs4231_cdma");
 	if (!chip->port || !chip->p_dma.ebus_info.regs ||
 	    !chip->c_dma.ebus_info.regs) {
 		snd_cs4231_ebus_free(chip);
@@ -2084,7 +2047,7 @@ static int __init snd_cs4231_ebus_create(struct snd_card *card,
 	return 0;
 }
 
-static int __init cs4231_ebus_attach(struct linux_ebus_device *edev)
+static int __devinit cs4231_ebus_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct snd_card *card;
 	int err;
@@ -2095,10 +2058,10 @@ static int __init cs4231_ebus_attach(struct linux_ebus_device *edev)
 
 	sprintf(card->longname, "%s at 0x%lx, irq %d",
 		card->shortname,
-		edev->resource[0].start,
-		edev->irqs[0]);
+		op->resource[0].start,
+		op->irqs[0]);
 
-	err = snd_cs4231_ebus_create(card, edev, dev);
+	err = snd_cs4231_ebus_create(card, op, dev);
 	if (err < 0) {
 		snd_card_free(card);
 		return err;
@@ -2108,11 +2071,37 @@ static int __init cs4231_ebus_attach(struct linux_ebus_device *edev)
 }
 #endif
 
+static int __devinit cs4231_probe(struct of_device *op, const struct of_device_id *match)
+{
+#ifdef EBUS_SUPPORT
+	if (!strcmp(op->node->parent->name, "ebus"))
+		return cs4231_ebus_probe(op, match);
+#endif
 #ifdef SBUS_SUPPORT
+	if (!strcmp(op->node->parent->name, "sbus") ||
+	    !strcmp(op->node->parent->name, "sbi"))
+		return cs4231_sbus_probe(op, match);
+#endif
+	return -ENODEV;
+}
+
+static int __devexit cs4231_remove(struct of_device *op)
+{
+	struct snd_cs4231 *chip = dev_get_drvdata(&op->dev);
+
+	snd_card_free(chip->card);
+
+	return 0;
+}
+
 static struct of_device_id cs4231_match[] = {
 	{
 		.name = "SUNW,CS4231",
 	},
+	{
+		.name = "audio",
+		.compatible = "SUNW,CS4231",
+	},
 	{},
 };
 
@@ -2122,70 +2111,17 @@ static struct of_platform_driver cs4231_driver = {
 	.name		= "audio",
 	.match_table	= cs4231_match,
 	.probe		= cs4231_probe,
+	.remove		= __devexit_p(cs4231_remove),
 };
-#endif
 
 static int __init cs4231_init(void)
 {
-#ifdef EBUS_SUPPORT
-	struct linux_ebus *ebus;
-	struct linux_ebus_device *edev;
-#endif
-	int found;
-
-	found = 0;
-
-#ifdef SBUS_SUPPORT
-	{
-		int err = of_register_driver(&cs4231_driver, &of_bus_type);
-		if (err)
-			return err;
-	}
-#endif
-#ifdef EBUS_SUPPORT
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			int match = 0;
-
-			if (!strcmp(edev->prom_node->name, "SUNW,CS4231")) {
-				match = 1;
-			} else if (!strcmp(edev->prom_node->name, "audio")) {
-				const char *compat;
-
-				compat = of_get_property(edev->prom_node,
-							 "compatible", NULL);
-				if (compat && !strcmp(compat, "SUNW,CS4231"))
-					match = 1;
-			}
-
-			if (match &&
-			    cs4231_ebus_attach(edev) = 0)
-				found++;
-		}
-	}
-#endif
-
-
-	return 0;
+	return of_register_driver(&cs4231_driver, &of_bus_type);
 }
 
 static void __exit cs4231_exit(void)
 {
-	struct snd_cs4231 *p = cs4231_list;
-
-#ifdef SBUS_SUPPORT
 	of_unregister_driver(&cs4231_driver);
-#endif
-
-	while (p != NULL) {
-		struct snd_cs4231 *next = p->next;
-
-		snd_card_free(p->card);
-
-		p = next;
-	}
-
-	cs4231_list = NULL;
 }
 
 module_init(cs4231_init);
-- 
1.5.6.5.GIT

