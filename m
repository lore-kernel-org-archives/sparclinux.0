From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:00 +0000
Subject: [PATCH 16/49]: parport_sunbpp: Convert to pure OF driver.
Message-Id: <20080827.212400.235227151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


parport_sunbpp: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/parport/parport_sunbpp.c |   47 ++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 9d595aa..e4f00c6 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -26,6 +26,8 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/parport.h>
 
@@ -34,7 +36,6 @@
 
 #include <asm/io.h>
 #include <asm/oplib.h>           /* OpenProm Library */
-#include <asm/sbus.h>
 #include <asm/dma.h>             /* BPP uses LSI 64854 for DMA */
 #include <asm/irq.h>
 #include <asm/sunbpp.h>
@@ -285,38 +286,37 @@ static struct parport_operations parport_sunbpp_ops  	.owner		= THIS_MODULE,
 };
 
-static int __devinit init_one_port(struct sbus_dev *sdev)
+static int __devinit bpp_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct parport *p;
-	/* at least in theory there may be a "we don't dma" case */
 	struct parport_operations *ops;
-	void __iomem *base;
-	int irq, dma, err = 0, size;
 	struct bpp_regs __iomem *regs;
+	int irq, dma, err = 0, size;
 	unsigned char value_tcr;
+	void __iomem *base;
+	struct parport *p;
 
-	irq = sdev->irqs[0];
-	base = sbus_ioremap(&sdev->resource[0], 0,
-			    sdev->reg_addrs[0].reg_size, 
-			    "sunbpp");
+	irq = op->irqs[0];
+	base = of_ioremap(&op->resource[0], 0,
+			  resource_size(&op->resource[0]),
+			  "sunbpp");
 	if (!base)
 		return -ENODEV;
 
-	size = sdev->reg_addrs[0].reg_size;
+	size = resource_size(&op->resource[0]);
 	dma = PARPORT_DMA_NONE;
 
 	ops = kmalloc(sizeof(struct parport_operations), GFP_KERNEL);
         if (!ops)
 		goto out_unmap;
 
-        memcpy (ops, &parport_sunbpp_ops, sizeof (struct parport_operations));
+        memcpy (ops, &parport_sunbpp_ops, sizeof(struct parport_operations));
 
 	dprintk(("register_port\n"));
 	if (!(p = parport_register_port((unsigned long)base, irq, dma, ops)))
 		goto out_free_ops;
 
 	p->size = size;
-	p->dev = &sdev->ofdev.dev;
+	p->dev = &op->dev;
 
 	if ((err = request_irq(p->irq, parport_irq_handler,
 			       IRQF_SHARED, p->name, p)) != 0) {
@@ -333,7 +333,7 @@ static int __devinit init_one_port(struct sbus_dev *sdev)
 
 	printk(KERN_INFO "%s: sunbpp at 0x%lx\n", p->name, p->base);
 
-	dev_set_drvdata(&sdev->ofdev.dev, p);
+	dev_set_drvdata(&op->dev, p);
 
 	parport_announce_port(p);
 
@@ -346,21 +346,14 @@ out_free_ops:
 	kfree(ops);
 
 out_unmap:
-	sbus_iounmap(base, size);
+	of_iounmap(&op->resource[0], base, size);
 
 	return err;
 }
 
-static int __devinit bpp_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
-
-	return init_one_port(sdev);
-}
-
-static int __devexit bpp_remove(struct of_device *dev)
+static int __devexit bpp_remove(struct of_device *op)
 {
-	struct parport *p = dev_get_drvdata(&dev->dev);
+	struct parport *p = dev_get_drvdata(&op->dev);
 	struct parport_operations *ops = p->ops;
 
 	parport_remove_port(p);
@@ -370,11 +363,11 @@ static int __devexit bpp_remove(struct of_device *dev)
 		free_irq(p->irq, p);
 	}
 
-	sbus_iounmap((void __iomem *) p->base, p->size);
+	of_iounmap(&op->resource[0], (void __iomem *) p->base, p->size);
 	parport_put_port(p);
 	kfree(ops);
 
-	dev_set_drvdata(&dev->dev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	return 0;
 }
@@ -397,7 +390,7 @@ static struct of_platform_driver bpp_sbus_driver = {
 
 static int __init parport_sunbpp_init(void)
 {
-	return of_register_driver(&bpp_sbus_driver, &sbus_bus_type);
+	return of_register_driver(&bpp_sbus_driver, &of_bus_type);
 }
 
 static void __exit parport_sunbpp_exit(void)
-- 
1.5.6.5.GIT

