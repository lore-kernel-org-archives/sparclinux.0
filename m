From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 04:06:17 +0000
Subject: [PATCH 1/1]: envctrl: Convert to pure OF driver.
Message-Id: <20080829.210617.184410113.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Only a few more left :)

envctrl: Convert to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/sbus/char/envctrl.c |  147 +++++++++++++++++++++++--------------------
 1 files changed, 79 insertions(+), 68 deletions(-)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index a408402..ea8c35c 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1,5 +1,4 @@
-/* $Id: envctrl.c,v 1.25 2002/01/15 09:01:26 davem Exp $
- * envctrl.c: Temperature and Fan monitoring on Machines providing it.
+/* envctrl.c: Temperature and Fan monitoring on Machines providing it.
  *
  * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
  * Copyright (C) 2000  Vinh Truong    (vinh.truong@eng.sun.com)
@@ -28,12 +27,16 @@
 #include <linux/kmod.h>
 #include <linux/reboot.h>
 #include <linux/smp_lock.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
-#include <asm/ebus.h>
 #include <asm/uaccess.h>
 #include <asm/envctrl.h>
 #include <asm/io.h>
 
+#define DRIVER_NAME	"envctrl"
+#define PFX		DRIVER_NAME ": "
+
 #define ENVCTRL_MINOR	162
 
 #define PCF8584_ADDRESS	0x55
@@ -193,7 +196,7 @@ static void envtrl_i2c_test_pin(void)
 	} 
 
 	if (limit <= 0)
-		printk(KERN_INFO "envctrl: Pin status will not clear.\n");
+		printk(KERN_INFO PFX "Pin status will not clear.\n");
 }
 
 /* Function Description: Test busy bit.
@@ -211,7 +214,7 @@ static void envctrl_i2c_test_bb(void)
 	} 
 
 	if (limit <= 0)
-		printk(KERN_INFO "envctrl: Busy bit will not clear.\n");
+		printk(KERN_INFO PFX "Busy bit will not clear.\n");
 }
 
 /* Function Description: Send the address for a read access.
@@ -858,11 +861,10 @@ static void envctrl_init_voltage_status(struct i2c_child_t *pchild)
 /* Function Description: Initialize i2c child device.
  * Return: None.
  */
-static void envctrl_init_i2c_child(struct linux_ebus_child *edev_child,
+static void envctrl_init_i2c_child(struct device_node *dp,
 				   struct i2c_child_t *pchild)
 {
 	int len, i, tbls_size = 0;
-	struct device_node *dp = edev_child->prom_node;
 	const void *pval;
 
 	/* Get device address. */
@@ -882,12 +884,12 @@ static void envctrl_init_i2c_child(struct linux_ebus_child *edev_child,
 
                 pchild->tables = kmalloc(tbls_size, GFP_KERNEL);
 		if (pchild->tables = NULL){
-			printk("envctrl: Failed to allocate table.\n");
+			printk(KERN_ERR PFX "Failed to allocate table.\n");
 			return;
 		}
 		pval = of_get_property(dp, "tables", &len);
                 if (!pval || len <= 0) {
-			printk("envctrl: Failed to get table.\n");
+			printk(KERN_ERR PFX "Failed to get table.\n");
 			return;
 		}
 		memcpy(pchild->tables, pval, len);
@@ -993,14 +995,14 @@ static int kenvctrld(void *__unused)
 	struct i2c_child_t *cputemp;
 
 	if (NULL = (cputemp = envctrl_get_i2c_child(ENVCTRL_CPUTEMP_MON))) {
-		printk(KERN_ERR 
-		       "envctrl: kenvctrld unable to monitor CPU temp-- exiting\n");
+		printk(KERN_ERR  PFX
+		       "kenvctrld unable to monitor CPU temp-- exiting\n");
 		return -ENODEV;
 	}
 
 	poll_interval = 5000; /* TODO env_mon_interval */
 
-	printk(KERN_INFO "envctrl: %s starting...\n", current->comm);
+	printk(KERN_INFO PFX "%s starting...\n", current->comm);
 	for (;;) {
 		msleep_interruptible(poll_interval);
 
@@ -1022,54 +1024,35 @@ static int kenvctrld(void *__unused)
 			}
 		}
 	}
-	printk(KERN_INFO "envctrl: %s exiting...\n", current->comm);
+	printk(KERN_INFO PFX "%s exiting...\n", current->comm);
 	return 0;
 }
 
-static int __init envctrl_init(void)
+static int __devinit envctrl_probe(struct of_device *op,
+				   const struct of_device_id *match)
 {
-	struct linux_ebus *ebus = NULL;
-	struct linux_ebus_device *edev = NULL;
-	struct linux_ebus_child *edev_child = NULL;
-	int err, i = 0;
-
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->prom_node->name, "bbc")) {
-				/* If we find a boot-bus controller node,
-				 * then this envctrl driver is not for us.
-				 */
-				return -ENODEV;
-			}
-		}
-	}
+	struct device_node *dp;
+	int index, err;
 
-	/* Traverse through ebus and ebus device list for i2c device and
-	 * adc and gpio nodes.
-	 */
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->prom_node->name, "i2c")) {
-				i2c = ioremap(edev->resource[0].start, 0x2);
-				for_each_edevchild(edev, edev_child) {
-					if (!strcmp("gpio", edev_child->prom_node->name)) {
-						i2c_childlist[i].i2ctype = I2C_GPIO;
-						envctrl_init_i2c_child(edev_child, &(i2c_childlist[i++]));
-					}
-					if (!strcmp("adc", edev_child->prom_node->name)) {
-						i2c_childlist[i].i2ctype = I2C_ADC;
-						envctrl_init_i2c_child(edev_child, &(i2c_childlist[i++]));
-					}
-				}
-				goto done;
-			}
+	if (i2c)
+		return -EINVAL;
+
+	i2c = of_ioremap(&op->resource[0], 0, 0x2, DRIVER_NAME);
+	if (!i2c)
+		return -ENOMEM;
+
+	index = 0;
+	dp = op->node->child;
+	while (dp) {
+		if (!strcmp(dp->name, "gpio")) {
+			i2c_childlist[index].i2ctype = I2C_GPIO;
+			envctrl_init_i2c_child(dp, &(i2c_childlist[index++]));
+		} else if (!strcmp(dp->name, "adc")) {
+			i2c_childlist[index].i2ctype = I2C_ADC;
+			envctrl_init_i2c_child(dp, &(i2c_childlist[index++]));
 		}
-	}
 
-done:
-	if (!edev) {
-		printk("envctrl: I2C device not found.\n");
-		return -ENODEV;
+		dp = dp->sibling;
 	}
 
 	/* Set device address. */
@@ -1087,7 +1070,7 @@ done:
 	/* Register the device as a minor miscellaneous device. */
 	err = misc_register(&envctrl_dev);
 	if (err) {
-		printk("envctrl: Unable to get misc minor %d\n",
+		printk(KERN_ERR PFX "Unable to get misc minor %d\n",
 		       envctrl_dev.minor);
 		goto out_iounmap;
 	}
@@ -1096,12 +1079,12 @@ done:
 	 * a next child device, so we decrement before reverse-traversal of
 	 * child devices.
 	 */
-	printk("envctrl: initialized ");
-	for (--i; i >= 0; --i) {
+	printk(KERN_INFO PFX "Initialized ");
+	for (--index; index >= 0; --index) {
 		printk("[%s 0x%lx]%s", 
-			(I2C_ADC = i2c_childlist[i].i2ctype) ? ("adc") : 
-			((I2C_GPIO = i2c_childlist[i].i2ctype) ? ("gpio") : ("unknown")), 
-			i2c_childlist[i].addr, (0 = i) ? ("\n") : (" "));
+			(I2C_ADC = i2c_childlist[index].i2ctype) ? "adc" : 
+			((I2C_GPIO = i2c_childlist[index].i2ctype) ? "gpio" : "unknown"), 
+			i2c_childlist[index].addr, (0 = index) ? "\n" : " ");
 	}
 
 	kenvctrld_task = kthread_run(kenvctrld, NULL, "kenvctrld");
@@ -1115,26 +1098,54 @@ done:
 out_deregister:
 	misc_deregister(&envctrl_dev);
 out_iounmap:
-	iounmap(i2c);
-	for (i = 0; i < ENVCTRL_MAX_CPU * 2; i++)
-		kfree(i2c_childlist[i].tables);
+	of_iounmap(&op->resource[0], i2c, 0x2);
+	for (index = 0; index < ENVCTRL_MAX_CPU * 2; index++)
+		kfree(i2c_childlist[index].tables);
 
 	return err;
 }
 
-static void __exit envctrl_cleanup(void)
+static int __devexit envctrl_remove(struct of_device *op)
 {
-	int i;
+	int index;
 
 	kthread_stop(kenvctrld_task);
 
-	iounmap(i2c);
+	of_iounmap(&op->resource[0], i2c, 0x2);
 	misc_deregister(&envctrl_dev);
 
-	for (i = 0; i < ENVCTRL_MAX_CPU * 2; i++)
-		kfree(i2c_childlist[i].tables);
+	for (index = 0; index < ENVCTRL_MAX_CPU * 2; index++)
+		kfree(i2c_childlist[index].tables);
+
+	return 0;
+}
+
+static struct of_device_id envctrl_match[] = {
+	{
+		.name = "i2c",
+		.compatible = "i2cpcf,8584",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, envctrl_match);
+
+static struct of_platform_driver envctrl_driver = {
+	.name		= DRIVER_NAME,
+	.match_table	= envctrl_match,
+	.probe		= envctrl_probe,
+	.remove		= __devexit_p(envctrl_remove),
+};
+
+static int __init envctrl_init(void)
+{
+	return of_register_driver(&envctrl_driver, &of_bus_type);
+}
+
+static void __exit envctrl_exit(void)
+{
+	of_unregister_driver(&envctrl_driver);
 }
 
 module_init(envctrl_init);
-module_exit(envctrl_cleanup);
+module_exit(envctrl_exit);
 MODULE_LICENSE("GPL");
-- 
1.5.6.5.GIT

