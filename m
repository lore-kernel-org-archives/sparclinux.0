From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 22:45:11 +0000
Subject: [PATCH 1/3]: riowatchdog: Convert to pure OF driver.
Message-Id: <20080829.154511.26841138.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


riowatchdog: Convert to pure OF driver.

This also cleans up a lot of crud in this driver:

1) Don't touch the BBC regs, just leave the watchdog trigger
   behavior whatever the firmware programmed it to.

2) Use WATCHDOG_MINOR instead of hardcoded and not properly
   allocated RIOWD_MINOR.

Hey, I haven't touched it since I wrote it years ago :-)

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/sbus/char/riowatchdog.c |  234 ++++++++++++++++----------------------
 1 files changed, 99 insertions(+), 135 deletions(-)

diff --git a/drivers/sbus/char/riowatchdog.c b/drivers/sbus/char/riowatchdog.c
index 88c0fc6..b53af83 100644
--- a/drivers/sbus/char/riowatchdog.c
+++ b/drivers/sbus/char/riowatchdog.c
@@ -1,7 +1,6 @@
-/* $Id: riowatchdog.c,v 1.3.2.2 2002/01/23 18:48:02 davem Exp $
- * riowatchdog.c - driver for hw watchdog inside Super I/O of RIO
+/* riowatchdog.c - driver for hw watchdog inside Super I/O of RIO
  *
- * Copyright (C) 2001 David S. Miller (davem@redhat.com)
+ * Copyright (C) 2001, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/kernel.h>
@@ -12,14 +11,13 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/smp_lock.h>
+#include <linux/watchdog.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/ebus.h>
-#include <asm/bbc.h>
-#include <asm/oplib.h>
 #include <asm/uaccess.h>
 
-#include <asm/watchdog.h>
 
 /* RIO uses the NatSemi Super I/O power management logical device
  * as its' watchdog.
@@ -45,74 +43,35 @@
  * The watchdog device generates no interrupts.
  */
 
-MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Hardware watchdog driver for Sun RIO");
 MODULE_SUPPORTED_DEVICE("watchdog");
 MODULE_LICENSE("GPL");
 
 #define RIOWD_NAME	"pmc"
-#define RIOWD_MINOR	215
+#define PFX		RIOWD_NAME ": "
 
-static DEFINE_SPINLOCK(riowd_lock);
+struct riowd {
+	void __iomem		*regs;
+	spinlock_t		lock;
+};
+
+static struct riowd *riowd_device;
 
-static void __iomem *bbc_regs;
-static void __iomem *riowd_regs;
 #define WDTO_INDEX	0x05
 
 static int riowd_timeout = 1;		/* in minutes */
 module_param(riowd_timeout, int, 0);
 MODULE_PARM_DESC(riowd_timeout, "Watchdog timeout in minutes");
 
-#if 0 /* Currently unused. */
-static u8 riowd_readreg(int index)
+static void riowd_writereg(struct riowd *p, u8 val, int index)
 {
 	unsigned long flags;
-	u8 ret;
 
-	spin_lock_irqsave(&riowd_lock, flags);
-	writeb(index, riowd_regs + 0);
-	ret = readb(riowd_regs + 1);
-	spin_unlock_irqrestore(&riowd_lock, flags);
-
-	return ret;
-}
-#endif
-
-static void riowd_writereg(u8 val, int index)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&riowd_lock, flags);
-	writeb(index, riowd_regs + 0);
-	writeb(val, riowd_regs + 1);
-	spin_unlock_irqrestore(&riowd_lock, flags);
-}
-
-static void riowd_pingtimer(void)
-{
-	riowd_writereg(riowd_timeout, WDTO_INDEX);
-}
-
-static void riowd_stoptimer(void)
-{
-	u8 val;
-
-	riowd_writereg(0, WDTO_INDEX);
-
-	val = readb(bbc_regs + BBC_WDACTION);
-	val &= ~BBC_WDACTION_RST;
-	writeb(val, bbc_regs + BBC_WDACTION);
-}
-
-static void riowd_starttimer(void)
-{
-	u8 val;
-
-	riowd_writereg(riowd_timeout, WDTO_INDEX);
-
-	val = readb(bbc_regs + BBC_WDACTION);
-	val |= BBC_WDACTION_RST;
-	writeb(val, bbc_regs + BBC_WDACTION);
+	spin_lock_irqsave(&p->lock, flags);
+	writeb(index, p->regs + 0);
+	writeb(val, p->regs + 1);
+	spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int riowd_open(struct inode *inode, struct file *filp)
@@ -131,9 +90,12 @@ static int riowd_ioctl(struct inode *inode, struct file *filp,
 		       unsigned int cmd, unsigned long arg)
 {
 	static struct watchdog_info info = {
-	       	WDIOF_SETTIMEOUT, 0, "Natl. Semiconductor PC97317"
+		.options		= WDIOF_SETTIMEOUT,
+		.firmware_version	= 1,
+		.identity		= "riowd",
 	};
 	void __user *argp = (void __user *)arg;
+	struct riowd *p = riowd_device;
 	unsigned int options;
 	int new_margin;
 
@@ -150,7 +112,7 @@ static int riowd_ioctl(struct inode *inode, struct file *filp,
 		break;
 
 	case WDIOC_KEEPALIVE:
-		riowd_pingtimer();
+		riowd_writereg(p, riowd_timeout, WDTO_INDEX);
 		break;
 
 	case WDIOC_SETOPTIONS:
@@ -158,9 +120,9 @@ static int riowd_ioctl(struct inode *inode, struct file *filp,
 			return -EFAULT;
 
 		if (options & WDIOS_DISABLECARD)
-			riowd_stoptimer();
+			riowd_writereg(p, 0, WDTO_INDEX);
 		else if (options & WDIOS_ENABLECARD)
-			riowd_starttimer();
+			riowd_writereg(p, riowd_timeout, WDTO_INDEX);
 		else
 			return -EINVAL;
 
@@ -170,9 +132,9 @@ static int riowd_ioctl(struct inode *inode, struct file *filp,
 		if (get_user(new_margin, (int __user *)argp))
 			return -EFAULT;
 		if ((new_margin < 60) || (new_margin > (255 * 60)))
-		    return -EINVAL;
+			return -EINVAL;
 		riowd_timeout = (new_margin + 59) / 60;
-		riowd_pingtimer();
+		riowd_writereg(p, riowd_timeout, WDTO_INDEX);
 		/* Fall */
 
 	case WDIOC_GETTIMEOUT:
@@ -187,8 +149,10 @@ static int riowd_ioctl(struct inode *inode, struct file *filp,
 
 static ssize_t riowd_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
+	struct riowd *p = riowd_device;
+
 	if (count) {
-		riowd_pingtimer();
+		riowd_writereg(p, riowd_timeout, WDTO_INDEX);
 		return 1;
 	}
 
@@ -197,99 +161,99 @@ static ssize_t riowd_write(struct file *file, const char __user *buf, size_t cou
 
 static const struct file_operations riowd_fops = {
 	.owner =	THIS_MODULE,
+	.llseek =	no_llseek,
 	.ioctl =	riowd_ioctl,
 	.open =		riowd_open,
 	.write =	riowd_write,
 	.release =	riowd_release,
 };
 
-static struct miscdevice riowd_miscdev = { RIOWD_MINOR, RIOWD_NAME, &riowd_fops };
+static struct miscdevice riowd_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &riowd_fops
+};
 
-static int __init riowd_bbc_init(void)
+static int __devinit riowd_probe(struct of_device *op,
+				 const struct of_device_id *match)
 {
-	struct 	linux_ebus *ebus = NULL;
-	struct 	linux_ebus_device *edev = NULL;
-	u8 val;
-
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->ofdev.node->name, "bbc"))
-				goto found_bbc;
-		}
-	}
+	struct riowd *p;
+	int err = -EINVAL;
 
-found_bbc:
-	if (!edev)
-		return -ENODEV;
-	bbc_regs = ioremap(edev->resource[0].start, BBC_REGS_SIZE);
-	if (!bbc_regs)
-		return -ENODEV;
+	if (riowd_device)
+		goto out;
 
-	/* Turn it off. */
-	val = readb(bbc_regs + BBC_WDACTION);
-	val &= ~BBC_WDACTION_RST;
-	writeb(val, bbc_regs + BBC_WDACTION);
+	err = -ENOMEM;
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		goto out;
 
-	return 0;
-}
+	spin_lock_init(&p->lock);
 
-static int __init riowd_init(void)
-{
-	struct 	linux_ebus *ebus = NULL;
-	struct 	linux_ebus_device *edev = NULL;
-
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (!strcmp(edev->ofdev.node->name, RIOWD_NAME))
-				goto ebus_done;
-		}
+	p->regs = of_ioremap(&op->resource[0], 0, 2, "riowd");
+	if (!p->regs) {
+		printk(KERN_ERR PFX "Cannot map registers.\n");
+		goto out_free;
 	}
 
-ebus_done:
-	if (!edev)
-		goto fail;
-
-	riowd_regs = ioremap(edev->resource[0].start, 2);
-	if (riowd_regs = NULL) {
-		printk(KERN_ERR "pmc: Cannot map registers.\n");
-		return -ENODEV;
+	err = misc_register(&riowd_miscdev);
+	if (err) {
+		printk(KERN_ERR PFX "Cannot register watchdog misc device.\n");
+		goto out_iounmap;
 	}
 
-	if (riowd_bbc_init()) {
-		printk(KERN_ERR "pmc: Failure initializing BBC config.\n");
-		goto fail;
-	}
+	printk(KERN_INFO PFX "Hardware watchdog [%i minutes], "
+	       "regs at %p\n", riowd_timeout, p->regs);
 
-	if (misc_register(&riowd_miscdev)) {
-		printk(KERN_ERR "pmc: Cannot register watchdog misc device.\n");
-		goto fail;
-	}
+	dev_set_drvdata(&op->dev, p);
+	riowd_device = p;
+	err = 0;
 
-	printk(KERN_INFO "pmc: Hardware watchdog [%i minutes], "
-	       "regs at %p\n", riowd_timeout, riowd_regs);
+out_iounmap:
+	of_iounmap(&op->resource[0], p->regs, 2);
 
-	return 0;
+out_free:
+	kfree(p);
 
-fail:
-	if (riowd_regs) {
-		iounmap(riowd_regs);
-		riowd_regs = NULL;
-	}
-	if (bbc_regs) {
-		iounmap(bbc_regs);
-		bbc_regs = NULL;
-	}
-	return -ENODEV;
+out:
+	return err;
 }
 
-static void __exit riowd_cleanup(void)
+static int __devexit riowd_remove(struct of_device *op)
 {
+	struct riowd *p = dev_get_drvdata(&op->dev);
+
 	misc_deregister(&riowd_miscdev);
-	iounmap(riowd_regs);
-	riowd_regs = NULL;
-	iounmap(bbc_regs);
-	bbc_regs = NULL;
+	of_iounmap(&op->resource[0], p->regs, 2);
+	kfree(p);
+
+	return 0;
+}
+
+static struct of_device_id riowd_match[] = {
+	{
+		.name = "pmc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, riowd_match);
+
+static struct of_platform_driver riowd_driver = {
+	.name		= "riowd",
+	.match_table	= riowd_match,
+	.probe		= riowd_probe,
+	.remove		= __devexit_p(riowd_remove),
+};
+
+static int __init riowd_init(void)
+{
+	return of_register_driver(&riowd_driver, &of_bus_type);
+}
+
+static void __exit riowd_exit(void)
+{
+	of_unregister_driver(&riowd_driver);
 }
 
 module_init(riowd_init);
-module_exit(riowd_cleanup);
+module_exit(riowd_exit);
-- 
1.5.6.5.GIT

