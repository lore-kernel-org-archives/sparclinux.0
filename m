From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 10:19:15 +0000
Subject: [PATCH 3/6]: sparc64: Convert SUN4V PCI controller driver into a
Message-Id: <20080830.031915.196230924.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Convert SUN4V PCI controller driver into a real driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c       |    2 -
 arch/sparc64/kernel/pci_sun4v.c |  123 ++++++++++++++++++++++++++-------------
 2 files changed, 83 insertions(+), 42 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 73f1d42..445f588 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -167,7 +167,6 @@ void pci_config_write32(u32 *addr, u32 val)
 /* Probe for all PCI controllers in the system. */
 extern void sabre_init(struct device_node *, const char *);
 extern void psycho_init(struct device_node *, const char *);
-extern void sun4v_pci_init(struct device_node *, const char *);
 extern void fire_pci_init(struct device_node *, const char *);
 
 static struct {
@@ -179,7 +178,6 @@ static struct {
 	{ "pci108e,a001", sabre_init },
 	{ "SUNW,psycho", psycho_init },
 	{ "pci108e,8000", psycho_init },
-	{ "SUNW,sun4v-pci", sun4v_pci_init },
 	{ "pciex108e,80f0", fire_pci_init },
 };
 #define PCI_NUM_CONTROLLER_TYPES	ARRAY_SIZE(pci_controller_table)
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index a104c80..c1e72be 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -13,12 +13,10 @@
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/log2.h>
+#include <linux/of_device.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
-#include <asm/upa.h>
-#include <asm/pstate.h>
-#include <asm/oplib.h>
 #include <asm/hypervisor.h>
 #include <asm/prom.h>
 
@@ -27,6 +25,9 @@
 
 #include "pci_sun4v.h"
 
+#define DRIVER_NAME	"pci_sun4v"
+#define PFX		DRIVER_NAME ": "
+
 static unsigned long vpci_major = 1;
 static unsigned long vpci_minor = 1;
 
@@ -583,7 +584,7 @@ static unsigned long __init probe_existing_entries(struct pci_pbm_info *pbm,
 	return cnt;
 }
 
-static void __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
+static int __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 {
 	struct iommu *iommu = pbm->iommu;
 	struct property *prop;
@@ -603,9 +604,9 @@ static void __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	}
 
 	if ((vdma[0] | vdma[1]) & ~IO_PAGE_MASK) {
-		prom_printf("PCI-SUN4V: strange virtual-dma[%08x:%08x].\n",
-			    vdma[0], vdma[1]);
-		prom_halt();
+		printk(KERN_ERR PFX "Strange virtual-dma[%08x:%08x].\n",
+		       vdma[0], vdma[1]);
+		return -EINVAL;
 	};
 
 	dma_mask = (roundup_pow_of_two(vdma[1]) - 1UL);
@@ -625,8 +626,8 @@ static void __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	sz = (sz + 7UL) & ~7UL;
 	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
 	if (!iommu->arena.map) {
-		prom_printf("PCI_IOMMU: Error, kmalloc(arena.map) failed.\n");
-		prom_halt();
+		printk(KERN_ERR PFX "Error, kmalloc(arena.map) failed.\n");
+		return -ENOMEM;
 	}
 	iommu->arena.limit = num_tsb_entries;
 
@@ -634,6 +635,8 @@ static void __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	if (sz)
 		printk("%s: Imported %lu TSB entries from OBP\n",
 		       pbm->name, sz);
+
+	return 0;
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -890,10 +893,11 @@ static void pci_sun4v_msi_init(struct pci_pbm_info *pbm)
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
-static void __init pci_sun4v_pbm_init(struct pci_controller_info *p,
-				      struct device_node *dp, u32 devhandle)
+static int __init pci_sun4v_pbm_init(struct pci_controller_info *p,
+				     struct device_node *dp, u32 devhandle)
 {
 	struct pci_pbm_info *pbm;
+	int err;
 
 	if (devhandle & 0x40)
 		pbm = &p->pbm_B;
@@ -905,7 +909,6 @@ static void __init pci_sun4v_pbm_init(struct pci_controller_info *p,
 
 	pbm->numa_node = of_node_to_nid(dp);
 
-	pbm->scan_bus = pci_sun4v_scan_bus;
 	pbm->pci_ops = &sun4v_pci_ops;
 	pbm->config_space_reg_bits = 12;
 
@@ -924,50 +927,58 @@ static void __init pci_sun4v_pbm_init(struct pci_controller_info *p,
 	pci_determine_mem_io_space(pbm);
 
 	pci_get_pbm_props(pbm);
-	pci_sun4v_iommu_init(pbm);
+
+	err = pci_sun4v_iommu_init(pbm);
+	if (err)
+		return err;
+
 	pci_sun4v_msi_init(pbm);
+
+	pci_sun4v_scan_bus(pbm);
+
+	return 0;
 }
 
-void __init sun4v_pci_init(struct device_node *dp, char *model_name)
+static int __devinit pci_sun4v_probe(struct of_device *op,
+				     const struct of_device_id *match)
 {
+	const struct linux_prom64_registers *regs;
 	static int hvapi_negotiated = 0;
 	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
+	struct device_node *dp;
 	struct iommu *iommu;
-	struct property *prop;
-	struct linux_prom64_registers *regs;
 	u32 devhandle;
 	int i;
 
+	dp = op->node;
+
 	if (!hvapi_negotiated++) {
 		int err = sun4v_hvapi_register(HV_GRP_PCI,
 					       vpci_major,
 					       &vpci_minor);
 
 		if (err) {
-			prom_printf("SUN4V_PCI: Could not register hvapi, "
-				    "err=%d\n", err);
-			prom_halt();
+			printk(KERN_ERR PFX "Could not register hvapi, "
+			       "err=%d\n", err);
+			return err;
 		}
-		printk("SUN4V_PCI: Registered hvapi major[%lu] minor[%lu]\n",
+		printk(KERN_INFO PFX "Registered hvapi major[%lu] minor[%lu]\n",
 		       vpci_major, vpci_minor);
 
 		dma_ops = &sun4v_dma_ops;
 	}
 
-	prop = of_find_property(dp, "reg", NULL);
-	if (!prop) {
-		prom_printf("SUN4V_PCI: Could not find config registers\n");
-		prom_halt();
+	regs = of_get_property(dp, "reg", NULL);
+	if (!regs) {
+		printk(KERN_ERR PFX "Could not find config registers\n");
+		return -ENODEV;
 	}
-	regs = prop->value;
-
 	devhandle = (regs->phys_addr >> 32UL) & 0x0fffffff;
 
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		if (pbm->devhandle = (devhandle ^ 0x40)) {
-			pci_sun4v_pbm_init(pbm->parent, dp, devhandle);
-			return;
+			return pci_sun4v_pbm_init(pbm->parent, dp, devhandle);
 		}
 	}
 
@@ -975,31 +986,63 @@ void __init sun4v_pci_init(struct device_node *dp, char *model_name)
 		unsigned long page = get_zeroed_page(GFP_ATOMIC);
 
 		if (!page)
-			goto fatal_memory_error;
+			return -ENOMEM;
 
 		per_cpu(iommu_batch, i).pglist = (u64 *) page;
 	}
 
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p)
-		goto fatal_memory_error;
+	if (!p) {
+		printk(KERN_ERR PFX "Could not allocate pci_controller_info\n");
+		goto out_free;
+	}
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu)
-		goto fatal_memory_error;
+	if (!iommu) {
+		printk(KERN_ERR PFX "Could not allocate pbm A iommu\n");
+		goto out_free;
+	}
 
 	p->pbm_A.iommu = iommu;
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu)
-		goto fatal_memory_error;
+	if (!iommu) {
+		printk(KERN_ERR PFX "Could not allocate pbm B iommu\n");
+		goto out_free;
+	}
 
 	p->pbm_B.iommu = iommu;
 
-	pci_sun4v_pbm_init(p, dp, devhandle);
-	return;
+	return pci_sun4v_pbm_init(p, dp, devhandle);
 
-fatal_memory_error:
-	prom_printf("SUN4V_PCI: Fatal memory allocation error.\n");
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
+
+static struct of_device_id pci_sun4v_match[] = {
+	{
+		.name = "pci",
+		.compatible = "SUNW,sun4v-pci",
+	},
+	{},
+};
+
+static struct of_platform_driver pci_sun4v_driver = {
+	.name		= DRIVER_NAME,
+	.match_table	= pci_sun4v_match,
+	.probe		= pci_sun4v_probe,
+};
+
+static int __init pci_sun4v_init(void)
+{
+	return of_register_driver(&pci_sun4v_driver, &of_bus_type);
+}
+
+subsys_initcall(pci_sun4v_init);
-- 
1.5.6.5.GIT

