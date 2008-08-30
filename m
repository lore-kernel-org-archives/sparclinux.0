From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 05:35:58 +0000
Subject: [PATCH 1/1]: bbc_i2c: Convert to pure OF driver.
Message-Id: <20080829.223558.34767564.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


At this point the only users of the EBUS layer remaining on sparc64
are parport, floppy, and CS4231.

bbc_i2c: Convert to pure OF driver.

This thing was a mess, who wrote this junk? :)

Luckily we'll soon have nice generic I2C layer drivers for this PCF
based I2C stuff on sparc64.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/sbus/char/bbc_envctrl.c |  121 ++++++------------
 drivers/sbus/char/bbc_i2c.c     |  267 ++++++++++++++++-----------------------
 drivers/sbus/char/bbc_i2c.h     |   75 ++++++++++-
 3 files changed, 214 insertions(+), 249 deletions(-)

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index 0bde269..abe4d50 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -1,15 +1,15 @@
-/* $Id: bbc_envctrl.c,v 1.4 2001/04/06 16:48:08 davem Exp $
- * bbc_envctrl.c: UltraSPARC-III environment control driver.
+/* bbc_envctrl.c: UltraSPARC-III environment control driver.
  *
- * Copyright (C) 2001 David S. Miller (davem@redhat.com)
+ * Copyright (C) 2001, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/kmod.h>
 #include <linux/reboot.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/oplib.h>
-#include <asm/ebus.h>
 
 #include "bbc_i2c.h"
 #include "max1617.h"
@@ -75,43 +75,8 @@ static struct temp_limits amb_temp_limits[2] = {
 	{ 65, 55, 40, 5, -5, -10 },
 };
 
-enum fan_action { FAN_SLOWER, FAN_SAME, FAN_FASTER, FAN_FULLBLAST, FAN_STATE_MAX };
-
-struct bbc_cpu_temperature {
-	struct bbc_cpu_temperature	*next;
-
-	struct bbc_i2c_client		*client;
-	int				index;
-
-	/* Current readings, and history. */
-	s8				curr_cpu_temp;
-	s8				curr_amb_temp;
-	s8				prev_cpu_temp;
-	s8				prev_amb_temp;
-	s8				avg_cpu_temp;
-	s8				avg_amb_temp;
-
-	int				sample_tick;
-
-	enum fan_action			fan_todo[2];
-#define FAN_AMBIENT	0
-#define FAN_CPU		1
-};
-
-struct bbc_cpu_temperature *all_bbc_temps;
-
-struct bbc_fan_control {
-	struct bbc_fan_control 	*next;
-
-	struct bbc_i2c_client 	*client;
-	int 			index;
-
-	int			psupply_fan_on;
-	int			cpu_fan_speed;
-	int			system_fan_speed;
-};
-
-struct bbc_fan_control *all_bbc_fans;
+static LIST_HEAD(all_temps);
+static LIST_HEAD(all_fans);
 
 #define CPU_FAN_REG	0xf0
 #define SYS_FAN_REG	0xf2
@@ -330,7 +295,7 @@ static enum fan_action prioritize_fan_action(int which_fan)
 	 * recommend we do, and perform that action on all the
 	 * fans.
 	 */
-	for (tp = all_bbc_temps; tp; tp = tp->next) {
+	list_for_each_entry(tp, &all_temps, glob_list) {
 		if (tp->fan_todo[which_fan] = FAN_FULLBLAST) {
 			decision = FAN_FULLBLAST;
 			break;
@@ -439,7 +404,7 @@ static void fans_full_blast(void)
 	/* Since we will not be monitoring things anymore, put
 	 * the fans on full blast.
 	 */
-	for (fp = all_bbc_fans; fp; fp = fp->next) {
+	list_for_each_entry(fp, &all_fans, glob_list) {
 		fp->cpu_fan_speed = FAN_SPEED_MAX;
 		fp->system_fan_speed = FAN_SPEED_MAX;
 		fp->psupply_fan_on = 1;
@@ -463,11 +428,11 @@ static int kenvctrld(void *__unused)
 		if (kthread_should_stop())
 			break;
 
-		for (tp = all_bbc_temps; tp; tp = tp->next) {
+		list_for_each_entry(tp, &all_temps, glob_list) {
 			get_current_temps(tp);
 			analyze_temps(tp, &last_warning_jiffies);
 		}
-		for (fp = all_bbc_fans; fp; fp = fp->next)
+		list_for_each_entry(fp, &all_fans, glob_list)
 			maybe_new_fan_speeds(fp);
 	}
 	printk(KERN_INFO "bbc_envctrl: kenvctrld exiting...\n");
@@ -477,7 +442,8 @@ static int kenvctrld(void *__unused)
 	return 0;
 }
 
-static void attach_one_temp(struct linux_ebus_child *echild, int temp_idx)
+static void attach_one_temp(struct bbc_i2c_bus *bp, struct of_device *op,
+			    int temp_idx)
 {
 	struct bbc_cpu_temperature *tp;
 
@@ -485,20 +451,17 @@ static void attach_one_temp(struct linux_ebus_child *echild, int temp_idx)
 	if (!tp)
 		return;
 
-	tp->client = bbc_i2c_attach(echild);
+	tp->client = bbc_i2c_attach(op);
 	if (!tp->client) {
 		kfree(tp);
 		return;
 	}
 
+
 	tp->index = temp_idx;
-	{
-		struct bbc_cpu_temperature **tpp = &all_bbc_temps;
-		while (*tpp)
-			tpp = &((*tpp)->next);
-		tp->next = NULL;
-		*tpp = tp;
-	}
+
+	list_add(&tp->glob_list, &all_temps);
+	list_add(&tp->bp_list, &bp->temps);
 
 	/* Tell it to convert once every 5 seconds, clear all cfg
 	 * bits.
@@ -524,7 +487,8 @@ static void attach_one_temp(struct linux_ebus_child *echild, int temp_idx)
 	tp->fan_todo[FAN_CPU] = FAN_SAME;
 }
 
-static void attach_one_fan(struct linux_ebus_child *echild, int fan_idx)
+static void attach_one_fan(struct bbc_i2c_bus *bp, struct of_device *op,
+			   int fan_idx)
 {
 	struct bbc_fan_control *fp;
 
@@ -532,7 +496,7 @@ static void attach_one_fan(struct linux_ebus_child *echild, int fan_idx)
 	if (!fp)
 		return;
 
-	fp->client = bbc_i2c_attach(echild);
+	fp->client = bbc_i2c_attach(op);
 	if (!fp->client) {
 		kfree(fp);
 		return;
@@ -540,13 +504,8 @@ static void attach_one_fan(struct linux_ebus_child *echild, int fan_idx)
 
 	fp->index = fan_idx;
 
-	{
-		struct bbc_fan_control **fpp = &all_bbc_fans;
-		while (*fpp)
-			fpp = &((*fpp)->next);
-		fp->next = NULL;
-		*fpp = fp;
-	}
+	list_add(&fp->glob_list, &all_fans);
+	list_add(&fp->bp_list, &bp->fans);
 
 	/* The i2c device controlling the fans is write-only.
 	 * So the only way to keep track of the current power
@@ -563,18 +522,18 @@ static void attach_one_fan(struct linux_ebus_child *echild, int fan_idx)
 	set_fan_speeds(fp);
 }
 
-int bbc_envctrl_init(void)
+int bbc_envctrl_init(struct bbc_i2c_bus *bp)
 {
-	struct linux_ebus_child *echild;
+	struct of_device *op;
 	int temp_index = 0;
 	int fan_index = 0;
 	int devidx = 0;
 
-	while ((echild = bbc_i2c_getdev(devidx++)) != NULL) {
-		if (!strcmp(echild->prom_node->name, "temperature"))
-			attach_one_temp(echild, temp_index++);
-		if (!strcmp(echild->prom_node->name, "fan-control"))
-			attach_one_fan(echild, fan_index++);
+	while ((op = bbc_i2c_getdev(devidx++)) != NULL) {
+		if (!strcmp(op->node->name, "temperature"))
+			attach_one_temp(bp, op, temp_index++);
+		if (!strcmp(op->node->name, "fan-control"))
+			attach_one_fan(bp, op, fan_index++);
 	}
 	if (temp_index != 0 && fan_index != 0) {
 		kenvctrld_task = kthread_run(kenvctrld, NULL, "kenvctrld");
@@ -597,26 +556,22 @@ static void destroy_one_fan(struct bbc_fan_control *fp)
 	kfree(fp);
 }
 
-void bbc_envctrl_cleanup(void)
+void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp)
 {
-	struct bbc_cpu_temperature *tp;
-	struct bbc_fan_control *fp;
+	struct bbc_cpu_temperature *tp, *tpos;
+	struct bbc_fan_control *fp, *fpos;
 
 	kthread_stop(kenvctrld_task);
 
-	tp = all_bbc_temps;
-	while (tp != NULL) {
-		struct bbc_cpu_temperature *next = tp->next;
+	list_for_each_entry_safe(tp, tpos, &bp->temps, bp_list) {
+		list_del(&tp->bp_list);
+		list_del(&tp->glob_list);
 		destroy_one_temp(tp);
-		tp = next;
 	}
-	all_bbc_temps = NULL;
 
-	fp = all_bbc_fans;
-	while (fp != NULL) {
-		struct bbc_fan_control *next = fp->next;
+	list_for_each_entry_safe(fp, fpos, &bp->fans, bp_list) {
+		list_del(&fp->bp_list);
+		list_del(&fp->glob_list);
 		destroy_one_fan(fp);
-		fp = next;
 	}
-	all_bbc_fans = NULL;
 }
diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index ac8ef2c..af7f4af 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -1,8 +1,7 @@
-/* $Id: bbc_i2c.c,v 1.2 2001/04/02 09:59:08 davem Exp $
- * bbc_i2c.c: I2C low-level driver for BBC device on UltraSPARC-III
+/* bbc_i2c.c: I2C low-level driver for BBC device on UltraSPARC-III
  *            platforms.
  *
- * Copyright (C) 2001 David S. Miller (davem@redhat.com)
+ * Copyright (C) 2001, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/module.h>
@@ -14,9 +13,8 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <asm/oplib.h>
-#include <asm/ebus.h>
-#include <asm/spitfire.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/bbc.h>
 #include <asm/io.h>
 
@@ -53,54 +51,12 @@
  * The second controller also connects to the smartcard reader, if present.
  */
 
-#define NUM_CHILDREN	8
-struct bbc_i2c_bus {
-	struct bbc_i2c_bus		*next;
-	int				index;
-	spinlock_t			lock;
-	void				__iomem *i2c_bussel_reg;
-	void				__iomem *i2c_control_regs;
-	unsigned char			own, clock;
-
-	wait_queue_head_t		wq;
-	volatile int			waiting;
-
-	struct linux_ebus_device	*bus_edev;
-	struct {
-		struct linux_ebus_child	*device;
-		int			client_claimed;
-	} devs[NUM_CHILDREN];
-};
-
-static struct bbc_i2c_bus *all_bbc_i2c;
-
-struct bbc_i2c_client {
-	struct bbc_i2c_bus	*bp;
-	struct linux_ebus_child	*echild;
-	int			bus;
-	int			address;
-};
-
-static int find_device(struct bbc_i2c_bus *bp, struct linux_ebus_child *echild)
+static void set_device_claimage(struct bbc_i2c_bus *bp, struct of_device *op, int val)
 {
 	int i;
 
 	for (i = 0; i < NUM_CHILDREN; i++) {
-		if (bp->devs[i].device = echild) {
-			if (bp->devs[i].client_claimed)
-				return 0;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-static void set_device_claimage(struct bbc_i2c_bus *bp, struct linux_ebus_child *echild, int val)
-{
-	int i;
-
-	for (i = 0; i < NUM_CHILDREN; i++) {
-		if (bp->devs[i].device = echild) {
+		if (bp->devs[i].device = op) {
 			bp->devs[i].client_claimed = val;
 			return;
 		}
@@ -110,61 +66,47 @@ static void set_device_claimage(struct bbc_i2c_bus *bp, struct linux_ebus_child
 #define claim_device(BP,ECHILD)		set_device_claimage(BP,ECHILD,1)
 #define release_device(BP,ECHILD)	set_device_claimage(BP,ECHILD,0)
 
-static struct bbc_i2c_bus *find_bus_for_device(struct linux_ebus_child *echild)
+struct of_device *bbc_i2c_getdev(struct bbc_i2c_bus *bp, int index)
 {
-	struct bbc_i2c_bus *bp = all_bbc_i2c;
+	struct of_device *op = NULL;
+	int curidx = 0, i;
 
-	while (bp != NULL) {
-		if (find_device(bp, echild) != 0)
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		if (!(op = bp->devs[i].device))
 			break;
-		bp = bp->next;
+		if (curidx = index)
+			goto out;
+		op = NULL;
+		curidx++;
 	}
 
-	return bp;
-}
-
-struct linux_ebus_child *bbc_i2c_getdev(int index)
-{
-	struct bbc_i2c_bus *bp = all_bbc_i2c;
-	struct linux_ebus_child *echild = NULL;
-	int curidx = 0;
-
-	while (bp != NULL) {
-		struct bbc_i2c_bus *next = bp->next;
-		int i;
-
-		for (i = 0; i < NUM_CHILDREN; i++) {
-			if (!(echild = bp->devs[i].device))
-				break;
-			if (curidx = index)
-				goto out;
-			echild = NULL;
-			curidx++;
-		}
-		bp = next;
-	}
 out:
 	if (curidx = index)
-		return echild;
+		return op;
 	return NULL;
 }
 
-struct bbc_i2c_client *bbc_i2c_attach(struct linux_ebus_child *echild)
+struct bbc_i2c_client *bbc_i2c_attach(struct bbc_i2c_bus *bp, struct of_device *op)
 {
-	struct bbc_i2c_bus *bp = find_bus_for_device(echild);
 	struct bbc_i2c_client *client;
+	const u32 *reg;
 
-	if (!bp)
-		return NULL;
 	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client)
 		return NULL;
 	client->bp = bp;
-	client->echild = echild;
-	client->bus = echild->resource[0].start;
-	client->address = echild->resource[1].start;
+	client->op = op;
+
+	reg = of_get_property(op->node, "reg", NULL);
+	if (!reg) {
+		kfree(client);
+		return NULL;
+	}
 
-	claim_device(bp, echild);
+	client->bus = reg[0];
+	client->address = reg[1];
+
+	claim_device(bp, op);
 
 	return client;
 }
@@ -172,9 +114,9 @@ struct bbc_i2c_client *bbc_i2c_attach(struct linux_ebus_child *echild)
 void bbc_i2c_detach(struct bbc_i2c_client *client)
 {
 	struct bbc_i2c_bus *bp = client->bp;
-	struct linux_ebus_child *echild = client->echild;
+	struct of_device *op = client->op;
 
-	release_device(bp, echild);
+	release_device(bp, op);
 	kfree(client);
 }
 
@@ -355,44 +297,43 @@ static void __init reset_one_i2c(struct bbc_i2c_bus *bp)
 	writeb(I2C_PCF_IDLE, bp->i2c_control_regs + 0x0);
 }
 
-static int __init attach_one_i2c(struct linux_ebus_device *edev, int index)
+static struct bbc_i2c_bus * __init attach_one_i2c(struct of_device *op, int index)
 {
 	struct bbc_i2c_bus *bp;
-	struct linux_ebus_child *echild;
+	struct device_node *dp;
 	int entry;
 
 	bp = kzalloc(sizeof(*bp), GFP_KERNEL);
 	if (!bp)
-		return -ENOMEM;
+		return NULL;
 
-	bp->i2c_control_regs = ioremap(edev->resource[0].start, 0x2);
+	bp->i2c_control_regs = of_ioremap(&op->resource[0], 0, 0x2, "bbc_i2c_regs");
 	if (!bp->i2c_control_regs)
 		goto fail;
 
-	if (edev->num_addrs = 2) {
-		bp->i2c_bussel_reg = ioremap(edev->resource[1].start, 0x1);
-		if (!bp->i2c_bussel_reg)
-			goto fail;
-	}
+	bp->i2c_bussel_reg = of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bussel");
+	if (!bp->i2c_bussel_reg)
+		goto fail;
 
 	bp->waiting = 0;
 	init_waitqueue_head(&bp->wq);
-	if (request_irq(edev->irqs[0], bbc_i2c_interrupt,
+	if (request_irq(op->irqs[0], bbc_i2c_interrupt,
 			IRQF_SHARED, "bbc_i2c", bp))
 		goto fail;
 
 	bp->index = index;
-	bp->bus_edev = edev;
+	bp->op = op;
 
 	spin_lock_init(&bp->lock);
-	bp->next = all_bbc_i2c;
-	all_bbc_i2c = bp;
 
 	entry = 0;
-	for (echild = edev->children;
-	     echild && entry < 8;
-	     echild = echild->next, entry++) {
-		bp->devs[entry].device = echild;
+	for (dp = op->node->child;
+	     dp && entry < 8;
+	     dp = dp->sibling, entry++) {
+		struct of_device *child_op;
+
+		child_op = of_find_device_by_node(dp);
+		bp->devs[entry].device = child_op;
 		bp->devs[entry].client_claimed = 0;
 	}
 
@@ -406,86 +347,90 @@ static int __init attach_one_i2c(struct linux_ebus_device *edev, int index)
 
 	reset_one_i2c(bp);
 
-	return 0;
+	return bp;
 
 fail:
 	if (bp->i2c_bussel_reg)
-		iounmap(bp->i2c_bussel_reg);
+		of_iounmap(&op->resource[1], bp->i2c_bussel_reg, 1);
 	if (bp->i2c_control_regs)
-		iounmap(bp->i2c_control_regs);
+		of_iounmap(&op->resource[0], bp->i2c_control_regs, 2);
 	kfree(bp);
-	return -EINVAL;
-}
-
-static int __init bbc_present(void)
-{
-	struct linux_ebus *ebus = NULL;
-	struct linux_ebus_device *edev = NULL;
-
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->prom_node->name, "bbc"))
-				return 1;
-		}
-	}
-	return 0;
+	return NULL;
 }
 
-extern int bbc_envctrl_init(void);
-extern void bbc_envctrl_cleanup(void);
-static void bbc_i2c_cleanup(void);
+extern int bbc_envctrl_init(struct bbc_i2c_bus *bp);
+extern void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp);
 
-static int __init bbc_i2c_init(void)
+static int __devinit bbc_i2c_probe(struct of_device *op,
+				   const struct of_device_id *match)
 {
-	struct linux_ebus *ebus = NULL;
-	struct linux_ebus_device *edev = NULL;
+	struct bbc_i2c_bus *bp;
 	int err, index = 0;
 
-	if ((tlb_type != cheetah && tlb_type != cheetah_plus) ||
-	    !bbc_present())
-		return -ENODEV;
+	bp = attach_one_i2c(op, index);
+	if (!bp)
+		return -EINVAL;
 
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->prom_node->name, "i2c")) {
-				if (!attach_one_i2c(edev, index))
-					index++;
-			}
-		}
+	err = bbc_envctrl_init(bp);
+	if (err) {
+		free_irq(op->irqs[0], bp);
+		if (bp->i2c_bussel_reg)
+			of_iounmap(&op->resource[0], bp->i2c_bussel_reg, 1);
+		if (bp->i2c_control_regs)
+			of_iounmap(&op->resource[1], bp->i2c_control_regs, 2);
+		kfree(bp);
+	} else {
+		dev_set_drvdata(&op->dev, bp);
 	}
 
-	if (!index)
-		return -ENODEV;
-
-	err = bbc_envctrl_init();
-	if (err)
-		bbc_i2c_cleanup();
 	return err;
 }
 
-static void bbc_i2c_cleanup(void)
+static int __devexit bbc_i2c_remove(struct of_device *op)
 {
-	struct bbc_i2c_bus *bp = all_bbc_i2c;
+	struct bbc_i2c_bus *bp = dev_get_drvdata(&op->dev);
+
+	bbc_envctrl_cleanup(bp);
+
+	free_irq(op->irqs[0], bp);
 
-	bbc_envctrl_cleanup();
+	if (bp->i2c_bussel_reg)
+		of_iounmap(&op->resource[0], bp->i2c_bussel_reg, 1);
+	if (bp->i2c_control_regs)
+		of_iounmap(&op->resource[1], bp->i2c_control_regs, 2);
 
-	while (bp != NULL) {
-		struct bbc_i2c_bus *next = bp->next;
+	kfree(bp);
 
-		free_irq(bp->bus_edev->irqs[0], bp);
+	return 0;
+}
 
-		if (bp->i2c_bussel_reg)
-			iounmap(bp->i2c_bussel_reg);
-		if (bp->i2c_control_regs)
-			iounmap(bp->i2c_control_regs);
+static struct of_device_id bbc_i2c_match[] = {
+	{
+		.name = "i2c",
+		.compatible = "SUNW,bbc-i2c",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, bbc_i2c_match);
 
-		kfree(bp);
+static struct of_platform_driver bbc_i2c_driver = {
+	.name		= "bbc_i2c",
+	.match_table	= bbc_i2c_match,
+	.probe		= bbc_i2c_probe,
+	.remove		= __devexit_p(bbc_i2c_remove),
+};
 
-		bp = next;
-	}
-	all_bbc_i2c = NULL;
+static int __init bbc_i2c_init(void)
+{
+	return of_register_driver(&bbc_i2c_driver, &of_bus_type);
+}
+
+static void __exit bbc_i2c_exit(void)
+{
+	of_unregister_driver(&bbc_i2c_driver);
 }
 
 module_init(bbc_i2c_init);
-module_exit(bbc_i2c_cleanup);
+module_exit(bbc_i2c_exit);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/sbus/char/bbc_i2c.h b/drivers/sbus/char/bbc_i2c.h
index fb01bd1..83c4811 100644
--- a/drivers/sbus/char/bbc_i2c.h
+++ b/drivers/sbus/char/bbc_i2c.h
@@ -1,14 +1,79 @@
-/* $Id: bbc_i2c.h,v 1.2 2001/04/02 09:59:25 davem Exp $ */
 #ifndef _BBC_I2C_H
 #define _BBC_I2C_H
 
-#include <asm/ebus.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/list.h>
 
-struct bbc_i2c_client;
+struct bbc_i2c_client {
+	struct bbc_i2c_bus		*bp;
+	struct of_device		*op;
+	int				bus;
+	int				address;
+};
+
+enum fan_action { FAN_SLOWER, FAN_SAME, FAN_FASTER, FAN_FULLBLAST, FAN_STATE_MAX };
+
+struct bbc_cpu_temperature {
+	struct list_head		bp_list;
+	struct list_head		glob_list;
+
+	struct bbc_i2c_client		*client;
+	int				index;
+
+	/* Current readings, and history. */
+	s8				curr_cpu_temp;
+	s8				curr_amb_temp;
+	s8				prev_cpu_temp;
+	s8				prev_amb_temp;
+	s8				avg_cpu_temp;
+	s8				avg_amb_temp;
+
+	int				sample_tick;
+
+	enum fan_action			fan_todo[2];
+#define FAN_AMBIENT	0
+#define FAN_CPU		1
+};
+
+struct bbc_fan_control {
+	struct list_head		bp_list;
+	struct list_head		glob_list;
+
+	struct bbc_i2c_client 		*client;
+	int 				index;
+
+	int				psupply_fan_on;
+	int				cpu_fan_speed;
+	int				system_fan_speed;
+};
+
+#define NUM_CHILDREN	8
+
+struct bbc_i2c_bus {
+	struct bbc_i2c_bus		*next;
+	int				index;
+	spinlock_t			lock;
+	void				__iomem *i2c_bussel_reg;
+	void				__iomem *i2c_control_regs;
+	unsigned char			own, clock;
+
+	wait_queue_head_t		wq;
+	volatile int			waiting;
+
+	struct list_head		temps;
+	struct list_head		fans;
+
+	struct of_device		*op;
+	struct {
+		struct of_device	*device;
+		int			client_claimed;
+	} devs[NUM_CHILDREN];
+};
 
 /* Probing and attachment. */
-extern struct linux_ebus_child *bbc_i2c_getdev(int);
-extern struct bbc_i2c_client *bbc_i2c_attach(struct linux_ebus_child *);
+extern struct of_device *bbc_i2c_getdev(struct bbc_i2c_bus *, int);
+extern struct bbc_i2c_client *bbc_i2c_attach(struct bbc_i2c_bus *bp, struct of_device *);
 extern void bbc_i2c_detach(struct bbc_i2c_client *);
 
 /* Register read/write.  NOTE: Blocking! */
-- 
1.5.6.5.GIT

