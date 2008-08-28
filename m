From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:39 +0000
Subject: [PATCH 31/49]: sparc32: Convert apc to OF driver.
Message-Id: <20080827.212439.263980869.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Convert apc to OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/apc.c |   72 ++++++++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index 5267d48..0a20cd8 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -12,9 +12,10 @@
 #include <linux/miscdevice.h>
 #include <linux/smp_lock.h>
 #include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/sbus.h>
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
 #include <asm/auxio.h>
@@ -29,11 +30,10 @@
 #define APC_OBPNAME	"power-management"
 #define APC_DEVNAME "apc"
 
-volatile static u8 __iomem *regs; 
-static int apc_regsize;
+static u8 __iomem *regs;
 static int apc_no_idle __initdata = 0;
 
-#define apc_readb(offs)			(sbus_readb(regs+offs))
+#define apc_readb(offs)		(sbus_readb(regs+offs))
 #define apc_writeb(val, offs) 	(sbus_writeb(val, regs+offs))
 
 /* Specify "apc=noidle" on the kernel command line to 
@@ -69,9 +69,9 @@ static void apc_swift_idle(void)
 #endif
 } 
 
-static inline void apc_free(void)
+static inline void apc_free(struct of_device *op)
 {
-	sbus_iounmap(regs, apc_regsize);
+	of_iounmap(&op->resource[0], regs, resource_size(&op->resource[0]));
 }
 
 static int apc_open(struct inode *inode, struct file *f)
@@ -153,52 +153,56 @@ static const struct file_operations apc_fops = {
 
 static struct miscdevice apc_miscdev = { APC_MINOR, APC_DEVNAME, &apc_fops };
 
-static int __init apc_probe(void)
+static int __devinit apc_probe(struct of_device *op,
+			       const struct of_device_id *match)
 {
-	struct sbus_bus *sbus = NULL;
-	struct sbus_dev *sdev = NULL;
-	int iTmp = 0;
-
-	for_each_sbus(sbus) {
-		for_each_sbusdev(sdev, sbus) {
-			if (!strcmp(sdev->prom_name, APC_OBPNAME)) {
-				goto sbus_done;
-			}
-		}
-	}
+	int err;
 
-sbus_done:
-	if (!sdev) {
-		return -ENODEV;
-	}
-
-	apc_regsize = sdev->reg_addrs[0].reg_size;
-	regs = sbus_ioremap(&sdev->resource[0], 0, 
-				   apc_regsize, APC_OBPNAME);
-	if(!regs) {
+	regs = of_ioremap(&op->resource[0], 0,
+			  resource_size(&op->resource[0]), APC_OBPNAME);
+	if (!regs) {
 		printk(KERN_ERR "%s: unable to map registers\n", APC_DEVNAME);
 		return -ENODEV;
 	}
 
-	iTmp = misc_register(&apc_miscdev);
-	if (iTmp != 0) {
+	err = misc_register(&apc_miscdev);
+	if (err) {
 		printk(KERN_ERR "%s: unable to register device\n", APC_DEVNAME);
-		apc_free();
+		apc_free(op);
 		return -ENODEV;
 	}
 
 	/* Assign power management IDLE handler */
-	if(!apc_no_idle)
+	if (!apc_no_idle)
 		pm_idle = apc_swift_idle;	
 
 	printk(KERN_INFO "%s: power management initialized%s\n", 
-		APC_DEVNAME, apc_no_idle ? " (CPU idle disabled)" : "");
+	       APC_DEVNAME, apc_no_idle ? " (CPU idle disabled)" : "");
+
 	return 0;
 }
 
+static struct of_device_id apc_match[] = {
+	{
+		.name = APC_OBPNAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, apc_match);
+
+static struct of_platform_driver apc_driver = {
+	.name		= "apc",
+	.match_table	= apc_match,
+	.probe		= apc_probe,
+};
+
+static int __init apc_init(void)
+{
+	return of_register_driver(&apc_driver, &of_bus_type);
+}
+
 /* This driver is not critical to the boot process
  * and is easiest to ioremap when SBus is already
  * initialized, so we install ourselves thusly:
  */
-__initcall(apc_probe);
-
+__initcall(apc_init);
-- 
1.5.6.5.GIT

