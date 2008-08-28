From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:27 +0000
Subject: [PATCH 27/49]: sparc64: Convert SBUS floppy probing to use OF
Message-Id: <20080827.212427.110252134.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Convert SBUS floppy probing to use OF device objects.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/floppy_64.h |   45 +++++++++++++++++++++--------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index c39db10..d8fb060 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -1,6 +1,6 @@
 /* floppy.h: Sparc specific parts of the Floppy driver.
  *
- * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1996, 2007, 2008 David S. Miller (davem@davemloft.net)
  * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  *
  * Ultra/PCI support added: Sep 1997  Eddie C. Dost  (ecd@skynet.be)
@@ -11,6 +11,8 @@
 
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -18,7 +20,6 @@
 #include <asm/idprom.h>
 #include <asm/oplib.h>
 #include <asm/auxio.h>
-#include <asm/sbus.h>
 #include <asm/irq.h>
 
 
@@ -50,7 +51,7 @@ struct sun_flpy_controller {
 /* You'll only ever find one controller on an Ultra anyways. */
 static struct sun_flpy_controller *sun_fdc = (struct sun_flpy_controller *)-1;
 unsigned long fdc_status;
-static struct sbus_dev *floppy_sdev = NULL;
+static struct of_device *floppy_op = NULL;
 
 struct sun_floppy_ops {
 	unsigned char	(*fd_inb) (unsigned long port);
@@ -559,22 +560,28 @@ static int __init ebus_fdthree_p(struct linux_ebus_device *edev)
 
 static unsigned long __init sun_floppy_init(void)
 {
-	char state[128];
-	struct sbus_bus *bus;
-	struct sbus_dev *sdev = NULL;
 	static int initialized = 0;
+	struct device_node *dp;
+	struct of_device *op;
+	const char *prop;
+	char state[128];
 
 	if (initialized)
 		return sun_floppy_types[0];
 	initialized = 1;
 
-	for_all_sbusdev (sdev, bus) {
-		if (!strcmp(sdev->prom_name, "SUNW,fdtwo"))
+	op = NULL;
+
+	for_each_node_by_name(dp, "SUNW,fdtwo") {
+		if (strcmp(dp->parent->name, "sbus"))
+			continue;
+		op = of_find_device_by_node(dp);
+		if (op)
 			break;
 	}
-	if(sdev) {
-		floppy_sdev = sdev;
-		FLOPPY_IRQ = sdev->irqs[0];
+	if (op) {
+		floppy_op = op;
+		FLOPPY_IRQ = op->irqs[0];
 	} else {
 #ifdef CONFIG_PCI
 		struct linux_ebus *ebus;
@@ -593,7 +600,9 @@ static unsigned long __init sun_floppy_init(void)
 		if (!edev)
 			return 0;
 
-		state_prop = of_get_property(edev->prom_node, "status", NULL);
+		op = &edev->ofdev;
+
+		state_prop = of_get_property(op->node, "status", NULL);
 		if (state_prop && !strncmp(state_prop, "disabled", 8))
 			return 0;
 
@@ -720,22 +729,22 @@ static unsigned long __init sun_floppy_init(void)
 		return 0;
 #endif
 	}
-	prom_getproperty(sdev->prom_node, "status", state, sizeof(state));
-	if(!strncmp(state, "disabled", 8))
+	prop = of_get_property(op->node, "status", NULL);
+	if (prop && !strncmp(state, "disabled", 8))
 		return 0;
 
 	/*
-	 * We cannot do sbus_ioremap here: it does request_region,
+	 * We cannot do of_ioremap here: it does request_region,
 	 * which the generic floppy driver tries to do once again.
 	 * But we must use the sdev resource values as they have
 	 * had parent ranges applied.
 	 */
 	sun_fdc = (struct sun_flpy_controller *)
-		(sdev->resource[0].start +
-		 ((sdev->resource[0].flags & 0x1ffUL) << 32UL));
+		(op->resource[0].start +
+		 ((op->resource[0].flags & 0x1ffUL) << 32UL));
 
 	/* Last minute sanity check... */
-	if(sbus_readb(&sun_fdc->status1_82077) = 0xff) {
+	if (sbus_readb(&sun_fdc->status1_82077) = 0xff) {
 		sun_fdc = (struct sun_flpy_controller *)-1;
 		return 0;
 	}
-- 
1.5.6.5.GIT

