From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 10:19:22 +0000
Subject: [PATCH 6/6]: sparc64: Convert FIRE PCI controller driver into a
Message-Id: <20080830.031922.123876645.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Convert FIRE PCI controller driver into a real driver.

And now all the by-hand PCI controller probing junk in pci.c can die too.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c      |   96 ----------------------------------------
 arch/sparc64/kernel/pci_fire.c |   80 ++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 118 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index c2ff2de..2da32e4 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -164,79 +164,6 @@ void pci_config_write32(u32 *addr, u32 val)
 	spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
-/* Probe for all PCI controllers in the system. */
-extern void fire_pci_init(struct device_node *, const char *);
-
-static struct {
-	char *model_name;
-	void (*init)(struct device_node *, const char *);
-} pci_controller_table[] __initdata = {
-	{ "pciex108e,80f0", fire_pci_init },
-};
-#define PCI_NUM_CONTROLLER_TYPES	ARRAY_SIZE(pci_controller_table)
-
-static int __init pci_controller_init(const char *model_name, int namelen, struct device_node *dp)
-{
-	int i;
-
-	for (i = 0; i < PCI_NUM_CONTROLLER_TYPES; i++) {
-		if (!strncmp(model_name,
-			     pci_controller_table[i].model_name,
-			     namelen)) {
-			pci_controller_table[i].init(dp, model_name);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static int __init pci_controller_scan(int (*handler)(const char *, int, struct device_node *))
-{
-	struct device_node *dp;
-	int count = 0;
-
-	for_each_node_by_name(dp, "pci") {
-		struct property *prop;
-		int len;
-
-		prop = of_find_property(dp, "model", &len);
-		if (!prop)
-			prop = of_find_property(dp, "compatible", &len);
-
-		if (prop) {
-			const char *model = prop->value;
-			int item_len = 0;
-
-			/* Our value may be a multi-valued string in the
-			 * case of some compatible properties. For sanity,
-			 * only try the first one.
-			 */
-			while (model[item_len] && len) {
-				len--;
-				item_len++;
-			}
-
-			if (handler(model, item_len, dp))
-				count++;
-		}
-	}
-
-	return count;
-}
-
-/* Find each controller in the system, attach and initialize
- * software state structure for each and link into the
- * pci_pbm_root.  Setup the controller enough such
- * that bus scanning can be done.
- */
-static void __init pci_controller_probe(void)
-{
-	printk("PCI: Probing for controllers.\n");
-
-	pci_controller_scan(pci_controller_init);
-}
-
 static int ofpci_verbose;
 
 static int __init ofpci_debug(char *str)
@@ -773,29 +700,6 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm)
 	return bus;
 }
 
-static void __init pci_scan_each_controller_bus(void)
-{
-	struct pci_pbm_info *pbm;
-
-	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
-		if (pbm->scan_bus)
-			pbm->scan_bus(pbm);
-	}
-}
-
-static int __init pcibios_init(void)
-{
-	pci_controller_probe();
-	if (pci_pbm_root = NULL)
-		return 0;
-
-	pci_scan_each_controller_bus();
-
-	return 0;
-}
-
-subsys_initcall(pcibios_init);
-
 void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
 {
 	struct pci_pbm_info *pbm = pbus->sysdata;
diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index d23bb6f..adc3fe4 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -8,13 +8,16 @@
 #include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/irq.h>
+#include <linux/of_device.h>
 
-#include <asm/oplib.h>
 #include <asm/prom.h>
 #include <asm/irq.h>
 
 #include "pci_impl.h"
 
+#define DRIVER_NAME	"fire"
+#define PFX		DRIVER_NAME ": "
+
 #define fire_read(__reg) \
 ({	u64 __ret; \
 	__asm__ __volatile__("ldxa [%1] %2, %0" \
@@ -452,7 +455,6 @@ static int __init pci_fire_pbm_init(struct pci_controller_info *p,
 
 	pbm->numa_node = -1;
 
-	pbm->scan_bus = pci_fire_scan_bus;
 	pbm->pci_ops = &sun4u_pci_ops;
 	pbm->config_space_reg_bits = 12;
 
@@ -481,6 +483,8 @@ static int __init pci_fire_pbm_init(struct pci_controller_info *p,
 
 	pci_fire_msi_init(pbm);
 
+	pci_fire_scan_bus(pbm);
+
 	return 0;
 }
 
@@ -491,43 +495,75 @@ static inline int portid_compare(u32 x, u32 y)
 	return 0;
 }
 
-void __init fire_pci_init(struct device_node *dp, const char *model_name)
+static int __devinit fire_probe(struct of_device *op,
+				const struct of_device_id *match)
 {
+	struct device_node *dp = op->node;
 	struct pci_controller_info *p;
-	u32 portid = of_getintprop_default(dp, "portid", 0xff);
-	struct iommu *iommu;
 	struct pci_pbm_info *pbm;
+	struct iommu *iommu;
+	u32 portid;
+	int err;
 
+	portid = of_getintprop_default(dp, "portid", 0xff);
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
-		if (portid_compare(pbm->portid, portid)) {
-			if (pci_fire_pbm_init(pbm->parent, dp, portid))
-				goto fatal_memory_error;
-			return;
-		}
+		if (portid_compare(pbm->portid, portid))
+			return pci_fire_pbm_init(pbm->parent, dp, portid);
 	}
 
+	err = -ENOMEM;
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
+		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
+		goto out_free;
+	}
 
 	p->pbm_B.iommu = iommu;
 
-	if (pci_fire_pbm_init(p, dp, portid))
-		goto fatal_memory_error;
+	return pci_fire_pbm_init(p, dp, portid);
 
-	return;
+out_free:
+	if (p) {
+		if (p->pbm_A.iommu)
+			kfree(p->pbm_A.iommu);
+		if (p->pbm_B.iommu)
+			kfree(p->pbm_B.iommu);
+		kfree(p);
+	}
+	return err;
+}
+
+static struct of_device_id fire_match[] = {
+	{
+		.name = "pci",
+		.compatible = "pciex108e,80f0",
+	},
+	{},
+};
 
-fatal_memory_error:
-	prom_printf("PCI_FIRE: Fatal memory allocation error.\n");
-	prom_halt();
+static struct of_platform_driver fire_driver = {
+	.name		= DRIVER_NAME,
+	.match_table	= fire_match,
+	.probe		= fire_probe,
+};
+
+static int __init fire_init(void)
+{
+	return of_register_driver(&fire_driver, &of_bus_type);
 }
+
+subsys_initcall(fire_init);
-- 
1.5.6.5.GIT

