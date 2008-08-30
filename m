From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 00:42:22 +0000
Subject: [PATCH 1/1]: sun_uflash: Convert to pure OF driver.
Message-Id: <20080829.174222.157622565.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This one was pretty trivial.  One more EBUS driver down,
several more to go :)

sun_uflash: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/mtd/maps/sun_uflash.c |   73 +++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 0d7c883..e931f1d 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -1,13 +1,10 @@
-/*
- *
- * sun_uflash - Driver implementation for user-programmable flash
- * present on many Sun Microsystems SME boardsets.
+/* sun_uflash.c - Driver for user-programmable flash on
+ *                Sun Microsystems SME boardsets.
  *
  * This driver does NOT provide access to the OBP-flash for
  * safety reasons-- use <linux>/drivers/sbus/char/flash.c instead.
  *
  * Copyright (c) 2001 Eric Brower (ebrower@usa.net)
- *
  */
 
 #include <linux/kernel.h>
@@ -16,8 +13,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <asm/ebus.h>
-#include <asm/oplib.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/prom.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -26,67 +23,65 @@
 #include <linux/mtd/map.h>
 
 #define UFLASH_OBPNAME	"flashprom"
-#define UFLASH_DEVNAME 	"userflash"
+#define DRIVER_NAME	"sun_uflash"
+#define PFX		DRIVER_NAME ": "
 
 #define UFLASH_WINDOW_SIZE	0x200000
 #define UFLASH_BUSWIDTH		1			/* EBus is 8-bit */
 
 MODULE_AUTHOR("Eric Brower <ebrower@usa.net>");
 MODULE_DESCRIPTION("User-programmable flash device on Sun Microsystems boardsets");
-MODULE_SUPPORTED_DEVICE("userflash");
+MODULE_SUPPORTED_DEVICE(DRIVER_NAME);
 MODULE_LICENSE("GPL");
-MODULE_VERSION("2.0");
+MODULE_VERSION("2.1");
 
-static LIST_HEAD(device_list);
 struct uflash_dev {
 	const char		*name;	/* device name */
 	struct map_info 	map;	/* mtd map info */
 	struct mtd_info		*mtd;	/* mtd info */
 };
 
-
 struct map_info uflash_map_templ = {
 	.name =		"SUNW,???-????",
 	.size =		UFLASH_WINDOW_SIZE,
 	.bankwidth =	UFLASH_BUSWIDTH,
 };
 
-int uflash_devinit(struct linux_ebus_device *edev, struct device_node *dp)
+int uflash_devinit(struct of_device *op, struct device_node *dp)
 {
 	struct uflash_dev *up;
-	struct resource *res;
 
-	res = &edev->resource[0];
-
-	if (edev->num_addrs != 1) {
+	if (op->resource[1].flags) {
 		/* Non-CFI userflash device-- once I find one we
 		 * can work on supporting it.
 		 */
-		printk("%s: unsupported device at 0x%llx (%d regs): " \
-			"email ebrower@usa.net\n",
-		       dp->full_name, (unsigned long long)res->start,
-		       edev->num_addrs);
+		printk(KERN_ERR PFX "Unsupported device at %s, 0x%llx\n",
+		       dp->full_name, (unsigned long long)op->resource[0].start);
 
 		return -ENODEV;
 	}
 
 	up = kzalloc(sizeof(struct uflash_dev), GFP_KERNEL);
-	if (!up)
+	if (!up) {
+		printk(KERN_ERR PFX "Cannot allocate struct uflash_dev\n");
 		return -ENOMEM;
+	}
 
 	/* copy defaults and tweak parameters */
 	memcpy(&up->map, &uflash_map_templ, sizeof(uflash_map_templ));
-	up->map.size = (res->end - res->start) + 1UL;
+
+	up->map.size = resource_size(&op->resource[0]);
 
 	up->name = of_get_property(dp, "model", NULL);
 	if (up->name && 0 < strlen(up->name))
 		up->map.name = (char *)up->name;
 
-	up->map.phys = res->start;
+	up->map.phys = op->resource[0].start;
 
-	up->map.virt = ioremap_nocache(res->start, up->map.size);
+	up->map.virt = of_ioremap(&op->resource[0], 0, up->map.size,
+				  DRIVER_NAME);
 	if (!up->map.virt) {
-		printk("%s: Failed to map device.\n", dp->full_name);
+		printk(KERN_ERR PFX "Failed to map device.\n");
 		kfree(up);
 
 		return -EINVAL;
@@ -97,7 +92,7 @@ int uflash_devinit(struct linux_ebus_device *edev, struct device_node *dp)
 	/* MTD registration */
 	up->mtd = do_map_probe("cfi_probe", &up->map);
 	if (!up->mtd) {
-		iounmap(up->map.virt);
+		of_iounmap(&op->resource[0], up->map.virt, up->map.size);
 		kfree(up);
 
 		return -ENXIO;
@@ -107,32 +102,34 @@ int uflash_devinit(struct linux_ebus_device *edev, struct device_node *dp)
 
 	add_mtd_device(up->mtd);
 
-	dev_set_drvdata(&edev->ofdev.dev, up);
+	dev_set_drvdata(&op->dev, up);
 
 	return 0;
 }
 
-static int __devinit uflash_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit uflash_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct linux_ebus_device *edev = to_ebus_device(&dev->dev);
-	struct device_node *dp = dev->node;
+	struct device_node *dp = op->node;
 
-	if (of_find_property(dp, "user", NULL))
+	/* Flashprom must have the "user" property in order to
+	 * be used by this driver.
+	 */
+	if (!of_find_property(dp, "user", NULL))
 		return -ENODEV;
 
-	return uflash_devinit(edev, dp);
+	return uflash_devinit(op, dp);
 }
 
-static int __devexit uflash_remove(struct of_device *dev)
+static int __devexit uflash_remove(struct of_device *op)
 {
-	struct uflash_dev *up = dev_get_drvdata(&dev->dev);
+	struct uflash_dev *up = dev_get_drvdata(&op->dev);
 
 	if (up->mtd) {
 		del_mtd_device(up->mtd);
 		map_destroy(up->mtd);
 	}
 	if (up->map.virt) {
-		iounmap(up->map.virt);
+		of_iounmap(&op->resource[0], up->map.virt, up->map.size);
 		up->map.virt = NULL;
 	}
 
@@ -151,7 +148,7 @@ static struct of_device_id uflash_match[] = {
 MODULE_DEVICE_TABLE(of, uflash_match);
 
 static struct of_platform_driver uflash_driver = {
-	.name		= UFLASH_DEVNAME,
+	.name		= DRIVER_NAME,
 	.match_table	= uflash_match,
 	.probe		= uflash_probe,
 	.remove		= __devexit_p(uflash_remove),
@@ -159,7 +156,7 @@ static struct of_platform_driver uflash_driver = {
 
 static int __init uflash_init(void)
 {
-	return of_register_driver(&uflash_driver, &ebus_bus_type);
+	return of_register_driver(&uflash_driver, &of_bus_type);
 }
 
 static void __exit uflash_exit(void)
-- 
1.5.6.5.GIT

