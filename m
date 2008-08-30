From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 10:19:18 +0000
Subject: [PATCH 4/6]: sparc64: Convert PSYCHO PCI controller driver into a
Message-Id: <20080830.031918.155540584.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Convert PSYCHO PCI controller driver into a real driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c        |    3 -
 arch/sparc64/kernel/pci_psycho.c |   95 ++++++++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 445f588..c66c9bb 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -166,7 +166,6 @@ void pci_config_write32(u32 *addr, u32 val)
 
 /* Probe for all PCI controllers in the system. */
 extern void sabre_init(struct device_node *, const char *);
-extern void psycho_init(struct device_node *, const char *);
 extern void fire_pci_init(struct device_node *, const char *);
 
 static struct {
@@ -176,8 +175,6 @@ static struct {
 	{ "SUNW,sabre", sabre_init },
 	{ "pci108e,a000", sabre_init },
 	{ "pci108e,a001", sabre_init },
-	{ "SUNW,psycho", psycho_init },
-	{ "pci108e,8000", psycho_init },
 	{ "pciex108e,80f0", fire_pci_init },
 };
 #define PCI_NUM_CONTROLLER_TYPES	ARRAY_SIZE(pci_controller_table)
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index ef5fe29..4e8f87a 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -17,11 +17,13 @@
 #include <asm/irq.h>
 #include <asm/starfire.h>
 #include <asm/prom.h>
-#include <asm/oplib.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
 
+#define DRIVER_NAME	"psycho"
+#define PFX		DRIVER_NAME ": "
+
 /* All PSYCHO registers are 64-bits.  The following accessor
  * routines are how they are accessed.  The REG parameter
  * is a physical address.
@@ -840,7 +842,7 @@ static int psycho_iommu_init(struct pci_pbm_info *pbm)
 	control = psycho_read(pbm->controller_regs + PSYCHO_IOMMU_CONTROL);
 	control |= PSYCHO_IOMMU_CTRL_DENAB;
 	psycho_write(pbm->controller_regs + PSYCHO_IOMMU_CONTROL, control);
-	for(i = 0; i < 16; i++) {
+	for (i = 0; i < 16; i++) {
 		psycho_write(pbm->controller_regs + PSYCHO_IOMMU_TAG + (i * 8UL), 0);
 		psycho_write(pbm->controller_regs + PSYCHO_IOMMU_DATA + (i * 8UL), 0);
 	}
@@ -850,8 +852,10 @@ static int psycho_iommu_init(struct pci_pbm_info *pbm)
 	 */
 	err = iommu_table_init(iommu, IO_TSB_SIZE, 0xc0000000, 0xffffffff,
 			       pbm->numa_node);
-	if (err)
+	if (err) {
+		printk(KERN_ERR PFX "iommu_table_init() fails\n");
 		return err;
+	}
 
 	psycho_write(pbm->controller_regs + PSYCHO_IOMMU_TSBBASE,
 		     __pa(iommu->page_table));
@@ -982,7 +986,6 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 
 	pbm->numa_node = -1;
 
-	pbm->scan_bus = psycho_scan_bus;
 	pbm->pci_ops = &sun4u_pci_ops;
 	pbm->config_space_reg_bits = 8;
 
@@ -1002,7 +1005,7 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 	pbm->prom_node = dp;
 	pbm->name = dp->full_name;
 
-	printk("%s: PSYCHO PCI Bus Module ver[%x:%x]\n",
+	printk(KERN_INFO "%s: PSYCHO PCI Bus Module ver[%x:%x]\n",
 	       pbm->name,
 	       pbm->chip_version, pbm->chip_revision);
 
@@ -1011,24 +1014,28 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 	pci_get_pbm_props(pbm);
 
 	psycho_pbm_strbuf_init(pbm, is_pbm_a);
+
+	psycho_scan_bus(pbm);
 }
 
 #define PSYCHO_CONFIGSPACE	0x001000000UL
 
-void __init psycho_init(struct device_node *dp, char *model_name)
+static int __devinit psycho_probe(struct of_device *op,
+				  const struct of_device_id *match)
 {
-	struct linux_prom64_registers *pr_regs;
+	const struct linux_prom64_registers *pr_regs;
+	struct device_node *dp = op->node;
 	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
-	struct property *prop;
+	int is_pbm_a, err;
+	const u32 *p32;
 	u32 upa_portid;
-	int is_pbm_a;
 
 	upa_portid = 0xff;
-	prop = of_find_property(dp, "upa-portid", NULL);
-	if (prop)
-		upa_portid = *(u32 *) prop->value;
+	p32 = of_get_property(dp, "upa-portid", NULL);
+	if (p32)
+		upa_portid = *p32;
 
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		struct pci_controller_info *p = pbm->parent;
@@ -1036,24 +1043,34 @@ void __init psycho_init(struct device_node *dp, char *model_name)
 		if (p->pbm_A.portid = upa_portid) {
 			is_pbm_a = (p->pbm_A.prom_node = NULL);
 			psycho_pbm_init(p, dp, is_pbm_a);
-			return;
+			return 0;
 		}
 	}
 
+	err = -ENOMEM;
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p)
-		goto fatal_memory_error;
+	if (!p) {
+		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
+		goto out_free;
+	}
+
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu)
-		goto fatal_memory_error;
+	if (!iommu) {
+		printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
+		goto out_free;
+	}
 
 	p->pbm_A.iommu = p->pbm_B.iommu = iommu;
 
 	p->pbm_A.portid = upa_portid;
 	p->pbm_B.portid = upa_portid;
 
-	prop = of_find_property(dp, "reg", NULL);
-	pr_regs = prop->value;
+	pr_regs = of_get_property(dp, "reg", NULL);
+	err = -ENODEV;
+	if (!pr_regs) {
+		printk(KERN_ERR PFX "No reg property.\n");
+		goto out_free;
+	}
 
 	p->pbm_A.controller_regs = pr_regs[2].phys_addr;
 	p->pbm_B.controller_regs = pr_regs[2].phys_addr;
@@ -1063,14 +1080,42 @@ void __init psycho_init(struct device_node *dp, char *model_name)
 
 	psycho_controller_hwinit(&p->pbm_A);
 
-	if (psycho_iommu_init(&p->pbm_A))
-		goto fatal_memory_error;
+	err = psycho_iommu_init(&p->pbm_A);
+	if (err)
+		goto out_free;
 
 	is_pbm_a = ((pr_regs[0].phys_addr & 0x6000) = 0x2000);
+
 	psycho_pbm_init(p, dp, is_pbm_a);
-	return;
 
-fatal_memory_error:
-	prom_printf("PSYCHO: Fatal memory allocation error.\n");
-	prom_halt();
+	return 0;
+
+out_free:
+	if (p) {
+		if (p->pbm_A.iommu)
+			kfree(p->pbm_A.iommu);
+		kfree(p);
+	}
+	return err;
+}
+
+static struct of_device_id psycho_match[] = {
+	{
+		.name = "pci",
+		.compatible = "pci108e,8000",
+	},
+	{},
+};
+
+static struct of_platform_driver psycho_driver = {
+	.name		= DRIVER_NAME,
+	.match_table	= psycho_match,
+	.probe		= psycho_probe,
+};
+
+static int __init psycho_init(void)
+{
+	return of_register_driver(&psycho_driver, &of_bus_type);
 }
+
+subsys_initcall(psycho_init);
-- 
1.5.6.5.GIT

