From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:25 +0000
Subject: [PATCH 26/49]: sparc: Convert uctrl driver to OF driver.
Message-Id: <20080827.212425.113474786.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Convert uctrl driver to OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/sbus/char/Kconfig |    2 +-
 drivers/sbus/char/uctrl.c |  216 +++++++++++++++++++++++++--------------------
 2 files changed, 121 insertions(+), 97 deletions(-)

diff --git a/drivers/sbus/char/Kconfig b/drivers/sbus/char/Kconfig
index 3fd2bc9..1d5d1b4 100644
--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -32,7 +32,7 @@ config OBP_FLASH
 
 config TADPOLE_TS102_UCTRL
 	tristate "Tadpole TS102 Microcontroller support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SPARC32
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to directly support the TS102 Microcontroller interface
 	  on the Tadpole Sparcbook 3.  This device handles power-management
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 7776375..6cff977 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -1,7 +1,7 @@
-/* $Id: uctrl.c,v 1.12 2001/10/08 22:19:51 davem Exp $
- * uctrl.c: TS102 Microcontroller interface on Tadpole Sparcbook 3
+/* uctrl.c: TS102 Microcontroller interface on Tadpole Sparcbook 3
  *
  * Copyright 1999 Derrick J Brashear (shadow@dementia.org)
+ * Copyright 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/module.h>
@@ -14,6 +14,8 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -21,7 +23,6 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
-#include <asm/sbus.h>
 
 #define UCTRL_MINOR	174
 
@@ -33,26 +34,26 @@
 #endif
 
 struct uctrl_regs {
-	volatile u32 uctrl_intr;
-	volatile u32 uctrl_data;
-	volatile u32 uctrl_stat;
-	volatile u32 uctrl_xxx[5];
+	u32 uctrl_intr;
+	u32 uctrl_data;
+	u32 uctrl_stat;
+	u32 uctrl_xxx[5];
 };
 
 struct ts102_regs {
-	volatile u32 card_a_intr;
-	volatile u32 card_a_stat;
-	volatile u32 card_a_ctrl;
-	volatile u32 card_a_xxx;
-	volatile u32 card_b_intr;
-	volatile u32 card_b_stat;
-	volatile u32 card_b_ctrl;
-	volatile u32 card_b_xxx;
-	volatile u32 uctrl_intr;
-	volatile u32 uctrl_data;
-	volatile u32 uctrl_stat;
-	volatile u32 uctrl_xxx;
-	volatile u32 ts102_xxx[4];
+	u32 card_a_intr;
+	u32 card_a_stat;
+	u32 card_a_ctrl;
+	u32 card_a_xxx;
+	u32 card_b_intr;
+	u32 card_b_stat;
+	u32 card_b_ctrl;
+	u32 card_b_xxx;
+	u32 uctrl_intr;
+	u32 uctrl_data;
+	u32 uctrl_stat;
+	u32 uctrl_xxx;
+	u32 ts102_xxx[4];
 };
 
 /* Bits for uctrl_intr register */
@@ -186,17 +187,15 @@ enum uctrl_opcode {
   POWER_RESTART=0x83,
 };
 
-struct uctrl_driver {
-	struct uctrl_regs *regs;
+static struct uctrl_driver {
+	struct uctrl_regs __iomem *regs;
 	int irq;
 	int pending;
 	struct uctrl_status status;
-};
-
-static struct uctrl_driver drv;
+} *global_driver;
 
-static void uctrl_get_event_status(void);
-static void uctrl_get_external_status(void);
+static void uctrl_get_event_status(struct uctrl_driver *);
+static void uctrl_get_external_status(struct uctrl_driver *);
 
 static int
 uctrl_ioctl(struct inode *inode, struct file *file,
@@ -213,16 +212,14 @@ static int
 uctrl_open(struct inode *inode, struct file *file)
 {
 	lock_kernel();
-	uctrl_get_event_status();
-	uctrl_get_external_status();
+	uctrl_get_event_status(global_driver);
+	uctrl_get_external_status(global_driver);
 	unlock_kernel();
 	return 0;
 }
 
 static irqreturn_t uctrl_interrupt(int irq, void *dev_id)
 {
-	struct uctrl_driver *driver = (struct uctrl_driver *)dev_id;
-	printk("in uctrl_interrupt\n");
 	return IRQ_HANDLED;
 }
 
@@ -244,11 +241,11 @@ static struct miscdevice uctrl_dev = {
 { \
   unsigned int i; \
   for (i = 0; i < 10000; i++) { \
-    if (UCTRL_STAT_TXNF_STA & driver->regs->uctrl_stat) \
+      if (UCTRL_STAT_TXNF_STA & sbus_readl(&driver->regs->uctrl_stat)) \
       break; \
   } \
   dprintk(("write data 0x%02x\n", value)); \
-  driver->regs->uctrl_data = value; \
+  sbus_writel(value, &driver->regs->uctrl_data); \
 }
 
 /* Wait for something to read, read it, then clear the bit */
@@ -257,24 +254,23 @@ static struct miscdevice uctrl_dev = {
   unsigned int i; \
   value = 0; \
   for (i = 0; i < 10000; i++) { \
-    if ((UCTRL_STAT_RXNE_STA & driver->regs->uctrl_stat) = 0) \
+      if ((UCTRL_STAT_RXNE_STA & sbus_readl(&driver->regs->uctrl_stat)) = 0) \
       break; \
     udelay(1); \
   } \
-  value = driver->regs->uctrl_data; \
+  value = sbus_readl(&driver->regs->uctrl_data); \
   dprintk(("read data 0x%02x\n", value)); \
-  driver->regs->uctrl_stat = UCTRL_STAT_RXNE_STA; \
+  sbus_writel(UCTRL_STAT_RXNE_STA, &driver->regs->uctrl_stat); \
 }
 
-static void uctrl_do_txn(struct uctrl_txn *txn)
+static void uctrl_do_txn(struct uctrl_driver *driver, struct uctrl_txn *txn)
 {
-	struct uctrl_driver *driver = &drv;
 	int stat, incnt, outcnt, bytecnt, intr;
 	u32 byte;
 
-	stat = driver->regs->uctrl_stat;
-	intr = driver->regs->uctrl_intr;
-	driver->regs->uctrl_stat = stat;
+	stat = sbus_readl(&driver->regs->uctrl_stat);
+	intr = sbus_readl(&driver->regs->uctrl_intr);
+	sbus_writel(stat, &driver->regs->uctrl_stat);
 
 	dprintk(("interrupt stat 0x%x int 0x%x\n", stat, intr));
 
@@ -305,9 +301,8 @@ static void uctrl_do_txn(struct uctrl_txn *txn)
 	}
 }
 
-static void uctrl_get_event_status(void)
+static void uctrl_get_event_status(struct uctrl_driver *driver)
 {
-	struct uctrl_driver *driver = &drv;
 	struct uctrl_txn txn;
 	u8 outbits[2];
 
@@ -317,7 +312,7 @@ static void uctrl_get_event_status(void)
 	txn.inbuf = NULL;
 	txn.outbuf = outbits;
 
-	uctrl_do_txn(&txn);
+	uctrl_do_txn(driver, &txn);
 
 	dprintk(("bytes %x %x\n", (outbits[0] & 0xff), (outbits[1] & 0xff)));
 	driver->status.event_status = 
@@ -325,9 +320,8 @@ static void uctrl_get_event_status(void)
 	dprintk(("ev is %x\n", driver->status.event_status));
 }
 
-static void uctrl_get_external_status(void)
+static void uctrl_get_external_status(struct uctrl_driver *driver)
 {
-	struct uctrl_driver *driver = &drv;
 	struct uctrl_txn txn;
 	u8 outbits[2];
 	int i, v;
@@ -338,7 +332,7 @@ static void uctrl_get_external_status(void)
 	txn.inbuf = NULL;
 	txn.outbuf = outbits;
 
-	uctrl_do_txn(&txn);
+	uctrl_do_txn(driver, &txn);
 
 	dprintk(("bytes %x %x\n", (outbits[0] & 0xff), (outbits[1] & 0xff)));
 	driver->status.external_status = 
@@ -354,71 +348,101 @@ static void uctrl_get_external_status(void)
 	
 }
 
-static int __init ts102_uctrl_init(void)
+static int __devinit uctrl_probe(struct of_device *op,
+				 const struct of_device_id *match)
 {
-	struct uctrl_driver *driver = &drv;
-	int len;
-	struct linux_prom_irqs tmp_irq[2];
-        unsigned int vaddr[2] = { 0, 0 };
-	int tmpnode, uctrlnode = prom_getchild(prom_root_node);
-	int err;
+	struct uctrl_driver *p;
+	int err = -ENOMEM;
 
-	tmpnode = prom_searchsiblings(uctrlnode, "obio");
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		printk(KERN_ERR "uctrl: Unable to allocate device struct.\n");
+		goto out;
+	}
 
-	if (tmpnode)
-	  uctrlnode = prom_getchild(tmpnode);
+	p->regs = of_ioremap(&op->resource[0], 0,
+			     resource_size(&op->resource[0]),
+			     "uctrl");
+	if (!p->regs) {
+		printk(KERN_ERR "uctrl: Unable to map registers.\n");
+		goto out_free;
+	}
 
-	uctrlnode = prom_searchsiblings(uctrlnode, "uctrl");
+	p->irq = op->irqs[0];
+	err = request_irq(p->irq, uctrl_interrupt, 0, "uctrl", p);
+	if (err) {
+		printk(KERN_ERR "uctrl: Unable to register irq.\n");
+		goto out_iounmap;
+	}
 
-	if (!uctrlnode)
-		return -ENODEV;
+	err = misc_register(&uctrl_dev);
+	if (err) {
+		printk(KERN_ERR "uctrl: Unable to register misc device.\n");
+		goto out_free_irq;
+	}
 
-	/* the prom mapped it for us */
-	len = prom_getproperty(uctrlnode, "address", (void *) vaddr,
-			       sizeof(vaddr));
-	driver->regs = (struct uctrl_regs *)vaddr[0];
+	sbus_writel(UCTRL_INTR_RXNE_REQ|UCTRL_INTR_RXNE_MSK, &p->regs->uctrl_intr);
+	printk(KERN_INFO "%s: uctrl regs[0x%p] (irq %d)\n",
+	       op->node->full_name, p->regs, p->irq);
+	uctrl_get_event_status(p);
+	uctrl_get_external_status(p);
 
-	len = prom_getproperty(uctrlnode, "intr", (char *) tmp_irq,
-			       sizeof(tmp_irq));
+	dev_set_drvdata(&op->dev, p);
+	global_driver = p;
 
-	/* Flush device */
-	READUCTLDATA(len);
+out:
+	return err;
 
-	if(!driver->irq) 
-		driver->irq = tmp_irq[0].pri;
+out_free_irq:
+	free_irq(p->irq, p);
 
-	err = request_irq(driver->irq, uctrl_interrupt, 0, "uctrl", driver);
-	if (err) {
-		printk("%s: unable to register irq %d\n",
-		       __func__, driver->irq);
-		return err;
-	}
+out_iounmap:
+	of_iounmap(&op->resource[0], p->regs, resource_size(&op->resource[0]));
 
-	if (misc_register(&uctrl_dev)) {
-		printk("%s: unable to get misc minor %d\n",
-		       __func__, uctrl_dev.minor);
-		free_irq(driver->irq, driver);
-		return -ENODEV;
-	}
+out_free:
+	kfree(p);
+	goto out;
+}
 
-	driver->regs->uctrl_intr = UCTRL_INTR_RXNE_REQ|UCTRL_INTR_RXNE_MSK;
-	printk("uctrl: 0x%p (irq %d)\n", driver->regs, driver->irq);
-	uctrl_get_event_status();
-	uctrl_get_external_status();
-        return 0;
+static int __devexit uctrl_remove(struct of_device *op)
+{
+	struct uctrl_driver *p = dev_get_drvdata(&op->dev);
+
+	if (p) {
+		misc_deregister(&uctrl_dev);
+		free_irq(p->irq, p);
+		of_iounmap(&op->resource[0], p->regs, resource_size(&op->resource[0]));
+		kfree(p);
+	}
+	return 0;
 }
 
-static void __exit ts102_uctrl_cleanup(void)
+static struct of_device_id uctrl_match[] = {
+	{
+		.name = "uctrl",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, uctrl_match);
+
+static struct of_platform_driver uctrl_driver = {
+	.name		= "uctrl",
+	.match_table	= uctrl_match,
+	.probe		= uctrl_probe,
+	.remove		= __devexit_p(uctrl_remove),
+};
+
+
+static int __init uctrl_init(void)
 {
-	struct uctrl_driver *driver = &drv;
+	return of_register_driver(&uctrl_driver, &of_bus_type);
+}
 
-	misc_deregister(&uctrl_dev);
-	if (driver->irq)
-		free_irq(driver->irq, driver);
-	if (driver->regs)
-		driver->regs = NULL;
+static void __exit uctrl_exit(void)
+{
+	of_unregister_driver(&uctrl_driver);
 }
 
-module_init(ts102_uctrl_init);
-module_exit(ts102_uctrl_cleanup);
+module_init(uctrl_init);
+module_exit(uctrl_exit);
 MODULE_LICENSE("GPL");
-- 
1.5.6.5.GIT

