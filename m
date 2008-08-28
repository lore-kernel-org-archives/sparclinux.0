From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:41 +0000
Subject: [PATCH 32/49]: sparc32: Convert pmc to OF driver.
Message-Id: <20080827.212441.81861826.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Convert pmc to OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pmc.c |   57 +++++++++++++++++++++++------------------------
 1 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index 7eca887..9976e82 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -10,9 +10,10 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/sbus.h>
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
 #include <asm/auxio.h>
@@ -30,10 +31,9 @@
 #define PMC_IDLE_REG	0x00
 #define PMC_IDLE_ON		0x01
 
-volatile static u8 __iomem *regs; 
-static int pmc_regsize;
+static u8 __iomem *regs;
 
-#define pmc_readb(offs)			(sbus_readb(regs+offs))
+#define pmc_readb(offs)		(sbus_readb(regs+offs))
 #define pmc_writeb(val, offs) 	(sbus_writeb(val, regs+offs))
 
 /* 
@@ -53,31 +53,11 @@ void pmc_swift_idle(void)
 #endif
 } 
 
-static inline void pmc_free(void)
+static int __devinit pmc_probe(struct of_device *op,
+			       const struct of_device_id *match)
 {
-	sbus_iounmap(regs, pmc_regsize);
-}
-
-static int __init pmc_probe(void)
-{
-	struct sbus_bus *sbus = NULL;
-	struct sbus_dev *sdev = NULL;
-	for_each_sbus(sbus) {
-		for_each_sbusdev(sdev, sbus) {
-			if (!strcmp(sdev->prom_name, PMC_OBPNAME)) {
-				goto sbus_done;
-			}
-		}
-	}
-
-sbus_done:
-	if (!sdev) {
-		return -ENODEV;
-	}
-
-	pmc_regsize = sdev->reg_addrs[0].reg_size;
-	regs = sbus_ioremap(&sdev->resource[0], 0, 
-				   pmc_regsize, PMC_OBPNAME);
+	regs = of_ioremap(&op->resource[0], 0,
+			  resource_size(&op->resource[0]), PMC_OBPNAME);
 	if (!regs) {
 		printk(KERN_ERR "%s: unable to map registers\n", PMC_DEVNAME);
 		return -ENODEV;
@@ -92,8 +72,27 @@ sbus_done:
 	return 0;
 }
 
+static struct of_device_id pmc_match[] = {
+	{
+		.name = PMC_OBPNAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, pmc_match);
+
+static struct of_platform_driver pmc_driver = {
+	.name		= "pmc",
+	.match_table	= pmc_match,
+	.probe		= pmc_probe,
+};
+
+static int __init pmc_init(void)
+{
+	return of_register_driver(&pmc_driver, &of_bus_type);
+}
+
 /* This driver is not critical to the boot process
  * and is easiest to ioremap when SBus is already
  * initialized, so we install ourselves thusly:
  */
-__initcall(pmc_probe);
+__initcall(pmc_init);
-- 
1.5.6.5.GIT

