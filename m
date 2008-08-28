From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:23 +0000
Subject: [PATCH 25/49]: sparc: Convert flash driver to OF device probing.
Message-Id: <20080827.212423.256572211.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Convert flash driver to OF device probing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/sbus/char/flash.c |  130 +++++++++++++++++---------------------------
 1 files changed, 50 insertions(+), 80 deletions(-)

diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 7d95e15..715996f 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -1,5 +1,4 @@
-/* $Id: flash.c,v 1.25 2001/12/21 04:56:16 davem Exp $
- * flash.c: Allow mmap access to the OBP Flash, for OBP updates.
+/* flash.c: Allow mmap access to the OBP Flash, for OBP updates.
  *
  * Copyright (C) 1997  Eddie C. Dost  (ecd@skynet.be)
  */
@@ -15,13 +14,13 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <asm/sbus.h>
-#include <asm/ebus.h>
 #include <asm/upa.h>
 
 static DEFINE_SPINLOCK(flash_lock);
@@ -161,97 +160,68 @@ static const struct file_operations flash_fops = {
 
 static struct miscdevice flash_dev = { FLASH_MINOR, "flash", &flash_fops };
 
-static int __init flash_init(void)
+static int __devinit flash_probe(struct of_device *op,
+				 const struct of_device_id *match)
 {
-	struct sbus_bus *sbus;
-	struct sbus_dev *sdev = NULL;
-#ifdef CONFIG_PCI
-	struct linux_ebus *ebus;
-	struct linux_ebus_device *edev = NULL;
-	struct linux_prom_registers regs[2];
-	int len, nregs;
-#endif
-	int err;
-
-	for_all_sbusdev(sdev, sbus) {
-		if (!strcmp(sdev->prom_name, "flashprom")) {
-			if (sdev->reg_addrs[0].phys_addr = sdev->reg_addrs[1].phys_addr) {
-				flash.read_base = ((unsigned long)sdev->reg_addrs[0].phys_addr) |
-					(((unsigned long)sdev->reg_addrs[0].which_io)<<32UL);
-				flash.read_size = sdev->reg_addrs[0].reg_size;
-				flash.write_base = flash.read_base;
-				flash.write_size = flash.read_size;
-			} else {
-				flash.read_base = ((unsigned long)sdev->reg_addrs[0].phys_addr) |
-					(((unsigned long)sdev->reg_addrs[0].which_io)<<32UL);
-				flash.read_size = sdev->reg_addrs[0].reg_size;
-				flash.write_base = ((unsigned long)sdev->reg_addrs[1].phys_addr) |
-					(((unsigned long)sdev->reg_addrs[1].which_io)<<32UL);
-				flash.write_size = sdev->reg_addrs[1].reg_size;
-			}
-			flash.busy = 0;
-			break;
-		}
-	}
-	if (!sdev) {
-#ifdef CONFIG_PCI
-		const struct linux_prom_registers *ebus_regs;
-
-		for_each_ebus(ebus) {
-			for_each_ebusdev(edev, ebus) {
-				if (!strcmp(edev->prom_node->name, "flashprom"))
-					goto ebus_done;
-			}
-		}
-	ebus_done:
-		if (!edev)
-			return -ENODEV;
-
-		ebus_regs = of_get_property(edev->prom_node, "reg", &len);
-		if (!ebus_regs || (len % sizeof(regs[0])) != 0) {
-			printk("flash: Strange reg property size %d\n", len);
-			return -ENODEV;
-		}
-
-		nregs = len / sizeof(ebus_regs[0]);
+	struct device_node *dp = op->node;
+	struct device_node *parent;
 
-		flash.read_base = edev->resource[0].start;
-		flash.read_size = ebus_regs[0].reg_size;
+	parent = dp->parent;
 
-		if (nregs = 1) {
-			flash.write_base = edev->resource[0].start;
-			flash.write_size = ebus_regs[0].reg_size;
-		} else if (nregs = 2) {
-			flash.write_base = edev->resource[1].start;
-			flash.write_size = ebus_regs[1].reg_size;
-		} else {
-			printk("flash: Strange number of regs %d\n", nregs);
-			return -ENODEV;
-		}
-
-		flash.busy = 0;
-
-#else
+	if (strcmp(parent->name, "sbus") &&
+	    strcmp(parent->name, "sbi") &&
+	    strcmp(parent->name, "ebus"))
 		return -ENODEV;
-#endif
+
+	flash.read_base = op->resource[0].start;
+	flash.read_size = resource_size(&op->resource[0]);
+	if (op->resource[1].flags) {
+		flash.write_base = op->resource[1].start;
+		flash.write_size = resource_size(&op->resource[1]);
+	} else {
+		flash.write_base = op->resource[0].start;
+		flash.write_size = resource_size(&op->resource[0]);
 	}
+	flash.busy = 0;
 
-	printk("OBP Flash: RD %lx[%lx] WR %lx[%lx]\n",
+	printk(KERN_INFO "%s: OBP Flash, RD %lx[%lx] WR %lx[%lx]\n",
+	       op->node->full_name,
 	       flash.read_base, flash.read_size,
 	       flash.write_base, flash.write_size);
 
-	err = misc_register(&flash_dev);
-	if (err) {
-		printk(KERN_ERR "flash: unable to get misc minor\n");
-		return err;
-	}
+	return misc_register(&flash_dev);
+}
+
+static int __devexit flash_remove(struct of_device *op)
+{
+	misc_deregister(&flash_dev);
 
 	return 0;
 }
 
+static struct of_device_id flash_match[] = {
+	{
+		.name = "flashprom",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, flash_match);
+
+static struct of_platform_driver flash_driver = {
+	.name		= "flash",
+	.match_table	= flash_match,
+	.probe		= flash_probe,
+	.remove		= __devexit_p(flash_remove),
+};
+
+static int __init flash_init(void)
+{
+	return of_register_driver(&flash_driver, &of_bus_type);
+}
+
 static void __exit flash_cleanup(void)
 {
-	misc_deregister(&flash_dev);
+	of_unregister_driver(&flash_driver);
 }
 
 module_init(flash_init);
-- 
1.5.6.5.GIT

