From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 10:19:20 +0000
Subject: [PATCH 5/6]: sparc64: Convert SABRE PCI controller driver into a
Message-Id: <20080830.031920.139321122.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Convert SABRE PCI controller driver into a real driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c       |    4 -
 arch/sparc64/kernel/pci_sabre.c |  126 ++++++++++++++++++++++++++-------------
 2 files changed, 85 insertions(+), 45 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index c66c9bb..c2ff2de 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -165,16 +165,12 @@ void pci_config_write32(u32 *addr, u32 val)
 }
 
 /* Probe for all PCI controllers in the system. */
-extern void sabre_init(struct device_node *, const char *);
 extern void fire_pci_init(struct device_node *, const char *);
 
 static struct {
 	char *model_name;
 	void (*init)(struct device_node *, const char *);
 } pci_controller_table[] __initdata = {
-	{ "SUNW,sabre", sabre_init },
-	{ "pci108e,a000", sabre_init },
-	{ "pci108e,a001", sabre_init },
 	{ "pciex108e,80f0", fire_pci_init },
 };
 #define PCI_NUM_CONTROLLER_TYPES	ARRAY_SIZE(pci_controller_table)
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index ade5184..7cce4d8 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -16,13 +16,14 @@
 #include <asm/apb.h>
 #include <asm/iommu.h>
 #include <asm/irq.h>
-#include <asm/smp.h>
-#include <asm/oplib.h>
 #include <asm/prom.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
 
+#define DRIVER_NAME	"sabre"
+#define PFX		DRIVER_NAME ": "
+
 /* All SABRE registers are 64-bits.  The following accessor
  * routines are how they are accessed.  The REG parameter
  * is a physical address.
@@ -656,8 +657,8 @@ static void __init sabre_scan_bus(struct pci_pbm_info *pbm)
 	 * to live at bus 0.
 	 */
 	if (once != 0) {
-		prom_printf("SABRE: Multiple controllers unsupported.\n");
-		prom_halt();
+		printk(KERN_ERR PFX "Multiple controllers unsupported.\n");
+		return;
 	}
 	once++;
 
@@ -705,8 +706,10 @@ static int sabre_iommu_init(struct pci_pbm_info *pbm,
 	 */
 	err = iommu_table_init(iommu, tsbsize * 1024 * 8,
 			       dvma_offset, dma_mask, pbm->numa_node);
-	if (err)
+	if (err) {
+		printk(KERN_ERR PFX "iommu_table_init() failed\n");
 		return err;
+	}
 
 	sabre_write(pbm->controller_regs + SABRE_IOMMU_TSBBASE,
 		    __pa(iommu->page_table));
@@ -722,9 +725,8 @@ static int sabre_iommu_init(struct pci_pbm_info *pbm,
 		control |= SABRE_IOMMU_TSBSZ_128K;
 		break;
 	default:
-		prom_printf("iommu_init: Illegal TSB size %d\n", tsbsize);
-		prom_halt();
-		break;
+		printk(KERN_ERR PFX "Illegal TSB size %d\n", tsbsize);
+		return -EINVAL;
 	}
 	sabre_write(pbm->controller_regs + SABRE_IOMMU_CONTROL, control);
 
@@ -739,7 +741,6 @@ static void __init sabre_pbm_init(struct pci_controller_info *p,
 
 	pbm->numa_node = -1;
 
-	pbm->scan_bus = sabre_scan_bus;
 	pbm->pci_ops = &sun4u_pci_ops;
 	pbm->config_space_reg_bits = 8;
 
@@ -751,46 +752,49 @@ static void __init sabre_pbm_init(struct pci_controller_info *p,
 	pci_get_pbm_props(pbm);
 
 	pci_determine_mem_io_space(pbm);
+
+	sabre_scan_bus(pbm);
 }
 
-void __init sabre_init(struct device_node *dp, char *model_name)
+static int __devinit sabre_probe(struct of_device *op,
+				 const struct of_device_id *match)
 {
 	const struct linux_prom64_registers *pr_regs;
+	struct device_node *dp = op->node;
 	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
+	u32 upa_portid, dma_mask;
 	struct iommu *iommu;
-	int tsbsize;
+	int tsbsize, err;
 	const u32 *vdma;
-	u32 upa_portid, dma_mask;
 	u64 clear_irq;
 
-	hummingbird_p = 0;
-	if (!strcmp(model_name, "pci108e,a001"))
-		hummingbird_p = 1;
-	else if (!strcmp(model_name, "SUNW,sabre")) {
-		const char *compat = of_get_property(dp, "compatible", NULL);
-		if (compat && !strcmp(compat, "pci108e,a001"))
-			hummingbird_p = 1;
-		if (!hummingbird_p) {
-			struct device_node *dp;
-
-			/* Of course, Sun has to encode things a thousand
-			 * different ways, inconsistently.
-			 */
-			for_each_node_by_type(dp, "cpu") {
-				if (!strcmp(dp->name, "SUNW,UltraSPARC-IIe"))
-					hummingbird_p = 1;
-			}
+	hummingbird_p = (match->data != NULL);
+	if (!hummingbird_p) {
+		struct device_node *cpu_dp;
+
+		/* Of course, Sun has to encode things a thousand
+		 * different ways, inconsistently.
+		 */
+		for_each_node_by_type(cpu_dp, "cpu") {
+			if (!strcmp(cpu_dp->name, "SUNW,UltraSPARC-IIe"))
+				hummingbird_p = 1;
 		}
 	}
 
+	err = -ENOMEM;
 	p = kzalloc(sizeof(*p), GFP_ATOMIC);
-	if (!p)
-		goto fatal_memory_error;
+	if (!p) {
+		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
+		goto out_free;
+	}
 
 	iommu = kzalloc(sizeof(*iommu), GFP_ATOMIC);
-	if (!iommu)
-		goto fatal_memory_error;
+	if (!iommu) {
+		printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
+		goto out_free;
+	}
+
 	pbm = &p->pbm_A;
 	pbm->iommu = iommu;
 
@@ -806,6 +810,11 @@ void __init sabre_init(struct device_node *dp, char *model_name)
 	 */
 	
 	pr_regs = of_get_property(dp, "reg", NULL);
+	err = -ENODEV;
+	if (!pr_regs) {
+		printk(KERN_ERR PFX "No reg property\n");
+		goto out_free;
+	}
 
 	/*
 	 * First REG in property is base of entire SABRE register space.
@@ -832,6 +841,10 @@ void __init sabre_init(struct device_node *dp, char *model_name)
 		(pbm->controller_regs + SABRE_CONFIGSPACE);
 
 	vdma = of_get_property(dp, "virtual-dma", NULL);
+	if (!vdma) {
+		printk(KERN_ERR PFX "No virtual-dma property\n");
+		goto out_free;
+	}
 
 	dma_mask = vdma[0];
 	switch(vdma[1]) {
@@ -849,20 +862,51 @@ void __init sabre_init(struct device_node *dp, char *model_name)
 			tsbsize = 128;
 			break;
 		default:
-			prom_printf("SABRE: strange virtual-dma size.\n");
-			prom_halt();
+			printk(KERN_ERR PFX "Strange virtual-dma size.\n");
+			goto out_free;
 	}
 
-	if (sabre_iommu_init(pbm, tsbsize, vdma[0], dma_mask))
-		goto fatal_memory_error;
+	err = sabre_iommu_init(pbm, tsbsize, vdma[0], dma_mask);
+	if (err)
+		goto out_free;
 
 	/*
 	 * Look for APB underneath.
 	 */
 	sabre_pbm_init(p, pbm, dp);
-	return;
+	return 0;
 
-fatal_memory_error:
-	prom_printf("SABRE: Fatal memory allocation error.\n");
-	prom_halt();
+out_free:
+	if (p) {
+		if (p->pbm_A.iommu)
+			kfree(p->pbm_A.iommu);
+		kfree(p);
+	}
+	return err;
 }
+
+static struct of_device_id sabre_match[] = {
+	{
+		.name = "pci",
+		.compatible = "pci108e,a001",
+		.data = (void *) 1,
+	},
+	{
+		.name = "pci",
+		.compatible = "pci108e,a000",
+	},
+	{},
+};
+
+static struct of_platform_driver sabre_driver = {
+	.name		= DRIVER_NAME,
+	.match_table	= sabre_match,
+	.probe		= sabre_probe,
+};
+
+static int __init sabre_init(void)
+{
+	return of_register_driver(&sabre_driver, &of_bus_type);
+}
+
+subsys_initcall(sabre_init);
-- 
1.5.6.5.GIT

