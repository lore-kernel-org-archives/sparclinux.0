From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 07:58:26 +0000
Subject: [PATCH 2/6]: sparc64: Convert EBUS floppy support to pure OF
Message-Id: <20080830.005826.120549072.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Convert EBUS floppy support to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/floppy_64.h |   86 +++++++++++++++---------------------
 1 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 8c7a06e..36439d6 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -9,19 +9,11 @@
 #ifndef __ASM_SPARC64_FLOPPY_H
 #define __ASM_SPARC64_FLOPPY_H
 
-#include <linux/init.h>
-#include <linux/pci.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/dma-mapping.h>
 
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/system.h>
-#include <asm/idprom.h>
-#include <asm/oplib.h>
 #include <asm/auxio.h>
-#include <asm/irq.h>
-
 
 /*
  * Define this to enable exchanging drive 0 and 1 if only drive 1 is
@@ -292,13 +284,11 @@ static int sun_fd_eject(int drive)
 	return 0;
 }
 
-#ifdef CONFIG_PCI
-#include <asm/ebus.h>
 #include <asm/ebus_dma.h>
 #include <asm/ns87303.h>
 
 static struct ebus_dma_info sun_pci_fd_ebus_dma;
-static struct pci_dev *sun_pci_ebus_dev;
+static struct device *sun_floppy_dev;
 static int sun_pci_broken_drive = -1;
 
 struct sun_pci_dma_op {
@@ -379,7 +369,7 @@ static void sun_pci_fd_enable_dma(void)
 	sun_pci_dma_pending.addr = -1U;
 
 	sun_pci_dma_current.addr -		pci_map_single(sun_pci_ebus_dev,
+		dma_map_single(sun_floppy_dev,
 			       sun_pci_dma_current.buf,
 			       sun_pci_dma_current.len,
 			       sun_pci_dma_current.direction);
@@ -396,7 +386,7 @@ static void sun_pci_fd_disable_dma(void)
 {
 	ebus_dma_enable(&sun_pci_fd_ebus_dma, 0);
 	if (sun_pci_dma_current.addr != -1U)
-		pci_unmap_single(sun_pci_ebus_dev,
+		dma_unmap_single(sun_floppy_dev,
 				 sun_pci_dma_current.addr,
 				 sun_pci_dma_current.len,
 				 sun_pci_dma_current.direction);
@@ -406,9 +396,9 @@ static void sun_pci_fd_disable_dma(void)
 static void sun_pci_fd_set_dma_mode(int mode)
 {
 	if (mode = DMA_MODE_WRITE)
-		sun_pci_dma_pending.direction = PCI_DMA_TODEVICE;
+		sun_pci_dma_pending.direction = DMA_TO_DEVICE;
 	else
-		sun_pci_dma_pending.direction = PCI_DMA_FROMDEVICE;
+		sun_pci_dma_pending.direction = DMA_FROM_DEVICE;
 
 	ebus_dma_prepare(&sun_pci_fd_ebus_dma, mode != DMA_MODE_WRITE);
 }
@@ -540,24 +530,19 @@ static int sun_pci_fd_test_drive(unsigned long port, int drive)
 #undef MSR
 #undef DOR
 
-#endif /* CONFIG_PCI */
-
-#ifdef CONFIG_PCI
-static int __init ebus_fdthree_p(struct linux_ebus_device *edev)
+static int __init ebus_fdthree_p(struct device_node *dp)
 {
-	if (!strcmp(edev->prom_node->name, "fdthree"))
+	if (!strcmp(dp->name, "fdthree"))
 		return 1;
-	if (!strcmp(edev->prom_node->name, "floppy")) {
+	if (!strcmp(dp->name, "floppy")) {
 		const char *compat;
 
-		compat = of_get_property(edev->prom_node,
-					 "compatible", NULL);
+		compat = of_get_property(dp, "compatible", NULL);
 		if (compat && !strcmp(compat, "fdthree"))
 			return 1;
 	}
 	return 0;
 }
-#endif
 
 static unsigned long __init sun_floppy_init(void)
 {
@@ -584,44 +569,45 @@ static unsigned long __init sun_floppy_init(void)
 		floppy_op = op;
 		FLOPPY_IRQ = op->irqs[0];
 	} else {
-#ifdef CONFIG_PCI
-		struct linux_ebus *ebus;
-		struct linux_ebus_device *edev = NULL;
-		unsigned long config = 0;
+		struct device_node *ebus_dp;
 		void __iomem *auxio_reg;
 		const char *state_prop;
+		unsigned long config;
 
-		for_each_ebus(ebus) {
-			for_each_ebusdev(edev, ebus) {
-				if (ebus_fdthree_p(edev))
-					goto ebus_done;
+		dp = NULL;
+		for_each_node_by_name(ebus_dp, "ebus") {
+			for (dp = ebus_dp->child; dp; dp = dp->sibling) {
+				if (ebus_fdthree_p(dp))
+					goto found_fdthree;
 			}
 		}
-	ebus_done:
-		if (!edev)
+	found_fdthree:
+		if (!dp)
 			return 0;
 
-		op = &edev->ofdev;
+		op = of_find_device_by_node(dp);
+		if (!op)
+			return 0;
 
 		state_prop = of_get_property(op->node, "status", NULL);
 		if (state_prop && !strncmp(state_prop, "disabled", 8))
 			return 0;
 
-		FLOPPY_IRQ = edev->irqs[0];
+		FLOPPY_IRQ = op->irqs[0];
 
 		/* Make sure the high density bit is set, some systems
 		 * (most notably Ultra5/Ultra10) come up with it clear.
 		 */
-		auxio_reg = (void __iomem *) edev->resource[2].start;
+		auxio_reg = (void __iomem *) op->resource[2].start;
 		writel(readl(auxio_reg)|0x2, auxio_reg);
 
-		sun_pci_ebus_dev = ebus->self;
+		sun_floppy_dev = &op->dev;
 
 		spin_lock_init(&sun_pci_fd_ebus_dma.lock);
 
 		/* XXX ioremap */
 		sun_pci_fd_ebus_dma.regs = (void __iomem *)
-			edev->resource[1].start;
+			op->resource[1].start;
 		if (!sun_pci_fd_ebus_dma.regs)
 			return 0;
 
@@ -635,7 +621,7 @@ static unsigned long __init sun_floppy_init(void)
 			return 0;
 
 		/* XXX ioremap */
-		sun_fdc = (struct sun_flpy_controller *)edev->resource[0].start;
+		sun_fdc = (struct sun_flpy_controller *) op->resource[0].start;
 
 		sun_fdops.fd_inb = sun_pci_fd_inb;
 		sun_fdops.fd_outb = sun_pci_fd_outb;
@@ -672,12 +658,15 @@ static unsigned long __init sun_floppy_init(void)
 		/*
 		 * Find NS87303 SuperIO config registers (through ecpp).
 		 */
-		for_each_ebus(ebus) {
-			for_each_ebusdev(edev, ebus) {
-				if (!strcmp(edev->prom_node->name, "ecpp")) {
-					config = edev->resource[1].start;
-					goto config_done;
-				}
+		config = 0;
+		for (dp = ebus_dp->child; dp; dp = dp->sibling) {
+			if (!strcmp(dp->name, "ecpp")) {
+				struct of_device *ecpp_op;
+
+				ecpp_op = of_find_device_by_node(dp);
+				if (ecpp_op)
+					config = ecpp_op->resource[1].start;
+				goto config_done;
 			}
 		}
 	config_done:
@@ -726,9 +715,6 @@ static unsigned long __init sun_floppy_init(void)
 #endif /* PCI_FDC_SWAP_DRIVES */
 
 		return sun_floppy_types[0];
-#else
-		return 0;
-#endif
 	}
 	prop = of_get_property(op->node, "status", NULL);
 	if (prop && !strncmp(state, "disabled", 8))
-- 
1.5.6.5.GIT

