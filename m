From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 10:19:12 +0000
Subject: [PATCH 2/6]: sparc64: Convert SCHIZO PCI controller driver into a
Message-Id: <20080830.031912.190085069.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Convert SCHIZO PCI controller driver into a real driver.

The idea is to convert all of the PCI controller drivers into
genuine OF drivers, then we can get rid of this terrible probing
table and infrastructure in arch/sparc64/kernel/pci.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c        |   15 +----
 arch/sparc64/kernel/pci_schizo.c |  117 ++++++++++++++++++++++++++------------
 2 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 83c50a6..73f1d42 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -167,9 +167,6 @@ void pci_config_write32(u32 *addr, u32 val)
 /* Probe for all PCI controllers in the system. */
 extern void sabre_init(struct device_node *, const char *);
 extern void psycho_init(struct device_node *, const char *);
-extern void schizo_init(struct device_node *, const char *);
-extern void schizo_plus_init(struct device_node *, const char *);
-extern void tomatillo_init(struct device_node *, const char *);
 extern void sun4v_pci_init(struct device_node *, const char *);
 extern void fire_pci_init(struct device_node *, const char *);
 
@@ -182,12 +179,6 @@ static struct {
 	{ "pci108e,a001", sabre_init },
 	{ "SUNW,psycho", psycho_init },
 	{ "pci108e,8000", psycho_init },
-	{ "SUNW,schizo", schizo_init },
-	{ "pci108e,8001", schizo_init },
-	{ "SUNW,schizo+", schizo_plus_init },
-	{ "pci108e,8002", schizo_plus_init },
-	{ "SUNW,tomatillo", tomatillo_init },
-	{ "pci108e,a801", tomatillo_init },
 	{ "SUNW,sun4v-pci", sun4v_pci_init },
 	{ "pciex108e,80f0", fire_pci_init },
 };
@@ -795,8 +786,10 @@ static void __init pci_scan_each_controller_bus(void)
 {
 	struct pci_pbm_info *pbm;
 
-	for (pbm = pci_pbm_root; pbm; pbm = pbm->next)
-		pbm->scan_bus(pbm);
+	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
+		if (pbm->scan_bus)
+			pbm->scan_bus(pbm);
+	}
 }
 
 static int __init pcibios_init(void)
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index 9248c67..b95dd54 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -1,6 +1,6 @@
 /* pci_schizo.c: SCHIZO/TOMATILLO specific PCI controller support.
  *
- * Copyright (C) 2001, 2002, 2003, 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 2001, 2002, 2003, 2007, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/kernel.h>
@@ -13,14 +13,15 @@
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
-#include <asm/upa.h>
 #include <asm/pstate.h>
 #include <asm/prom.h>
-#include <asm/oplib.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
 
+#define DRIVER_NAME	"schizo"
+#define PFX		DRIVER_NAME ": "
+
 /* All SCHIZO registers are 64-bits.  The following accessor
  * routines are how they are accessed.  The REG parameter
  * is a physical address.
@@ -1084,7 +1085,7 @@ static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 	pci_config_write8(addr, 64);
 }
 
-static void __init schizo_scan_bus(struct pci_pbm_info *pbm)
+static void __devinit schizo_scan_bus(struct pci_pbm_info *pbm)
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable @@ -1187,9 +1188,9 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 			break;
 
 		default:
-			prom_printf("SCHIZO: strange virtual-dma size.\n");
-			prom_halt();
-	};
+			printk(KERN_ERR PFX "Strange virtual-dma size.\n");
+			return -EINVAL;
+	}
 
 	/* Register addresses, SCHIZO has iommu ctx flushing. */
 	iommu->iommu_control  = pbm->pbm_regs + SCHIZO_IOMMU_CONTROL;
@@ -1212,7 +1213,7 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 
 	tagbase = SCHIZO_IOMMU_TAG, database = SCHIZO_IOMMU_DATA;
 
-	for(i = 0; i < 16; i++) {
+	for (i = 0; i < 16; i++) {
 		schizo_write(pbm->pbm_regs + tagbase + (i * 8UL), 0);
 		schizo_write(pbm->pbm_regs + database + (i * 8UL), 0);
 	}
@@ -1222,8 +1223,10 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 	 */
 	err = iommu_table_init(iommu, tsbsize * 8 * 1024, vdma[0], dma_mask,
 			       pbm->numa_node);
-	if (err)
+	if (err) {
+		printk(KERN_ERR PFX "iommu_table_init() fails with %d\n", err);
 		return err;
+	}
 
 	schizo_write(iommu->iommu_tsbbase, __pa(iommu->page_table));
 
@@ -1236,7 +1239,7 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 	case 128:
 		control |= SCHIZO_IOMMU_TSBSZ_128K;
 		break;
-	};
+	}
 
 	control |= SCHIZO_IOMMU_CTRL_ENAB;
 	schizo_write(iommu->iommu_control, control);
@@ -1334,9 +1337,9 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	}
 }
 
-static int __init schizo_pbm_init(struct pci_controller_info *p,
-				  struct device_node *dp, u32 portid,
-				  int chip_type)
+static int __devinit schizo_pbm_init(struct pci_controller_info *p,
+				     struct device_node *dp, u32 portid,
+				     int chip_type)
 {
 	const struct linux_prom64_registers *regs;
 	struct pci_pbm_info *pbm;
@@ -1382,7 +1385,6 @@ static int __init schizo_pbm_init(struct pci_controller_info *p,
 
 	pbm->numa_node = -1;
 
-	pbm->scan_bus = schizo_scan_bus;
 	pbm->pci_ops = &sun4u_pci_ops;
 	pbm->config_space_reg_bits = 8;
 
@@ -1420,6 +1422,8 @@ static int __init schizo_pbm_init(struct pci_controller_info *p,
 
 	schizo_pbm_strbuf_init(pbm);
 
+	schizo_scan_bus(pbm);
+
 	return 0;
 }
 
@@ -1433,8 +1437,7 @@ static inline int portid_compare(u32 x, u32 y, int chip_type)
 	return (x = y);
 }
 
-static void __init __schizo_init(struct device_node *dp, char *model_name,
-				 int chip_type)
+static int __devinit __schizo_init(struct device_node *dp, unsigned long chip_type)
 {
 	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
@@ -1447,48 +1450,88 @@ static void __init __schizo_init(struct device_node *dp, char *model_name,
 		if (portid_compare(pbm->portid, portid, chip_type)) {
 			if (schizo_pbm_init(pbm->parent, dp,
 					    portid, chip_type))
-				goto fatal_memory_error;
-			return;
+				return -ENOMEM;
+			return 0;
 		}
 	}
 
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p)
-		goto fatal_memory_error;
+	if (!p) {
+		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
+		goto out_free;
+	}
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu)
-		goto fatal_memory_error;
+	if (!iommu) {
+		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
+		goto out_free;
+	}
 
 	p->pbm_A.iommu = iommu;
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu)
-		goto fatal_memory_error;
+	if (!iommu) {
+		printk(KERN_ERR PFX "Cannot allocate PBM B iommu.\n");
+		goto out_free;
+	}
 
 	p->pbm_B.iommu = iommu;
 
 	if (schizo_pbm_init(p, dp, portid, chip_type))
-		goto fatal_memory_error;
+		goto out_free;
 
-	return;
+	return 0;
 
-fatal_memory_error:
-	prom_printf("SCHIZO: Fatal memory allocation error.\n");
-	prom_halt();
+out_free:
+	if (p) {
+		if (p->pbm_A.iommu)
+			kfree(p->pbm_A.iommu);
+		if (p->pbm_B.iommu)
+			kfree(p->pbm_B.iommu);
+		kfree(p);
+	}
+	return -ENOMEM;
 }
 
-void __init schizo_init(struct device_node *dp, char *model_name)
+static int __devinit schizo_probe(struct of_device *op,
+				  const struct of_device_id *match)
 {
-	__schizo_init(dp, model_name, PBM_CHIP_TYPE_SCHIZO);
+	return __schizo_init(op->node, (unsigned long) match->data);
 }
 
-void __init schizo_plus_init(struct device_node *dp, char *model_name)
-{
-	__schizo_init(dp, model_name, PBM_CHIP_TYPE_SCHIZO_PLUS);
-}
+/* The ordering of this table is very important.  Some Tomatillo
+ * nodes announce that they are compatible with both pci108e,a801
+ * and pci108e,8001.  So list the chips in reverse chronological
+ * order.
+ */
+static struct of_device_id schizo_match[] = {
+	{
+		.name = "pci",
+		.compatible = "pci108e,a801",
+		.data = (void *) PBM_CHIP_TYPE_TOMATILLO,
+	},
+	{
+		.name = "pci",
+		.compatible = "pci108e,8002",
+		.data = (void *) PBM_CHIP_TYPE_SCHIZO_PLUS,
+	},
+	{
+		.name = "pci",
+		.compatible = "pci108e,8001",
+		.data = (void *) PBM_CHIP_TYPE_SCHIZO,
+	},
+	{},
+};
 
-void __init tomatillo_init(struct device_node *dp, char *model_name)
+static struct of_platform_driver schizo_driver = {
+	.name		= DRIVER_NAME,
+	.match_table	= schizo_match,
+	.probe		= schizo_probe,
+};
+
+static int __init schizo_init(void)
 {
-	__schizo_init(dp, model_name, PBM_CHIP_TYPE_TOMATILLO);
+	return of_register_driver(&schizo_driver, &of_bus_type);
 }
+
+subsys_initcall(schizo_init);
-- 
1.5.6.5.GIT

