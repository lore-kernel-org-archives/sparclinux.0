From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:10:54 +0000
Subject: [PATCH 2/2]: sparc64: Record OF device instead of device node
Message-Id: <20080910.231054.252127133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Record OF device instead of device node pointer in pci_pbm_info.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c        |    2 +-
 arch/sparc64/kernel/pci_common.c |    8 ++++----
 arch/sparc64/kernel/pci_fire.c   |    2 +-
 arch/sparc64/kernel/pci_impl.h   |    3 ++-
 arch/sparc64/kernel/pci_msi.c    |   18 +++++++++---------
 arch/sparc64/kernel/pci_psycho.c |    4 ++--
 arch/sparc64/kernel/pci_sabre.c  |    4 ++--
 arch/sparc64/kernel/pci_schizo.c |   12 ++++++------
 arch/sparc64/kernel/pci_sun4v.c  |    6 +++---
 9 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 3070f6f..c6e81de 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -676,7 +676,7 @@ static void __devinit pci_bus_register_of_sysfs(struct pci_bus *bus)
 struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 					    struct device *parent)
 {
-	struct device_node *node = pbm->prom_node;
+	struct device_node *node = pbm->op->node;
 	struct pci_bus *bus;
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
diff --git a/arch/sparc64/kernel/pci_common.c b/arch/sparc64/kernel/pci_common.c
index 09a5ec2..23b8808 100644
--- a/arch/sparc64/kernel/pci_common.c
+++ b/arch/sparc64/kernel/pci_common.c
@@ -314,12 +314,12 @@ struct pci_ops sun4v_pci_ops = {
 
 void pci_get_pbm_props(struct pci_pbm_info *pbm)
 {
-	const u32 *val = of_get_property(pbm->prom_node, "bus-range", NULL);
+	const u32 *val = of_get_property(pbm->op->node, "bus-range", NULL);
 
 	pbm->pci_first_busno = val[0];
 	pbm->pci_last_busno = val[1];
 
-	val = of_get_property(pbm->prom_node, "ino-bitmap", NULL);
+	val = of_get_property(pbm->op->node, "ino-bitmap", NULL);
 	if (val) {
 		pbm->ino_bitmap = (((u64)val[1] << 32UL) |
 				   ((u64)val[0] <<  0UL));
@@ -365,7 +365,7 @@ static void pci_register_legacy_regions(struct resource *io_res,
 
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)
 {
-	const u32 *vdma = of_get_property(pbm->prom_node, "virtual-dma", NULL);
+	const u32 *vdma = of_get_property(pbm->op->node, "virtual-dma", NULL);
 
 	if (vdma) {
 		struct resource *rp = kmalloc(sizeof(*rp), GFP_KERNEL);
@@ -389,7 +389,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	int num_pbm_ranges;
 
 	saw_mem = saw_io = 0;
-	pbm_ranges = of_get_property(pbm->prom_node, "ranges", &i);
+	pbm_ranges = of_get_property(pbm->op->node, "ranges", &i);
 	if (!pbm_ranges) {
 		prom_printf("PCI: Fatal error, missing PBM ranges property "
 			    " for %s\n",
diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index b538bfb..7e1a9b6 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -446,7 +446,7 @@ static int __init pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	pbm->index = pci_num_pbms++;
 
 	pbm->portid = portid;
-	pbm->prom_node = dp;
+	pbm->op = op;
 	pbm->name = dp->full_name;
 
 	regs = of_get_property(dp, "reg", NULL);
diff --git a/arch/sparc64/kernel/pci_impl.h b/arch/sparc64/kernel/pci_impl.h
index 4937ce9..b300f39 100644
--- a/arch/sparc64/kernel/pci_impl.h
+++ b/arch/sparc64/kernel/pci_impl.h
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_device.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
@@ -90,7 +91,7 @@ struct pci_pbm_info {
 	char				*name;
 
 	/* OBP specific information. */
-	struct device_node		*prom_node;
+	struct of_device		*op;
 	u64				ino_bitmap;
 
 	/* PBM I/O and Memory space resources. */
diff --git a/arch/sparc64/kernel/pci_msi.c b/arch/sparc64/kernel/pci_msi.c
index 60c71e3..2e680f3 100644
--- a/arch/sparc64/kernel/pci_msi.c
+++ b/arch/sparc64/kernel/pci_msi.c
@@ -323,7 +323,7 @@ void sparc64_pbm_msi_init(struct pci_pbm_info *pbm,
 	const u32 *val;
 	int len;
 
-	val = of_get_property(pbm->prom_node, "#msi-eqs", &len);
+	val = of_get_property(pbm->op->node, "#msi-eqs", &len);
 	if (!val || len != 4)
 		goto no_msi;
 	pbm->msiq_num = *val;
@@ -346,16 +346,16 @@ void sparc64_pbm_msi_init(struct pci_pbm_info *pbm,
 			u32 msi64_len;
 		} *arng;
 
-		val = of_get_property(pbm->prom_node, "msi-eq-size", &len);
+		val = of_get_property(pbm->op->node, "msi-eq-size", &len);
 		if (!val || len != 4)
 			goto no_msi;
 
 		pbm->msiq_ent_count = *val;
 
-		mqp = of_get_property(pbm->prom_node,
+		mqp = of_get_property(pbm->op->node,
 				      "msi-eq-to-devino", &len);
 		if (!mqp)
-			mqp = of_get_property(pbm->prom_node,
+			mqp = of_get_property(pbm->op->node,
 					      "msi-eq-devino", &len);
 		if (!mqp || len != sizeof(struct msiq_prop))
 			goto no_msi;
@@ -363,27 +363,27 @@ void sparc64_pbm_msi_init(struct pci_pbm_info *pbm,
 		pbm->msiq_first = mqp->first_msiq;
 		pbm->msiq_first_devino = mqp->first_devino;
 
-		val = of_get_property(pbm->prom_node, "#msi", &len);
+		val = of_get_property(pbm->op->node, "#msi", &len);
 		if (!val || len != 4)
 			goto no_msi;
 		pbm->msi_num = *val;
 
-		mrng = of_get_property(pbm->prom_node, "msi-ranges", &len);
+		mrng = of_get_property(pbm->op->node, "msi-ranges", &len);
 		if (!mrng || len != sizeof(struct msi_range_prop))
 			goto no_msi;
 		pbm->msi_first = mrng->first_msi;
 
-		val = of_get_property(pbm->prom_node, "msi-data-mask", &len);
+		val = of_get_property(pbm->op->node, "msi-data-mask", &len);
 		if (!val || len != 4)
 			goto no_msi;
 		pbm->msi_data_mask = *val;
 
-		val = of_get_property(pbm->prom_node, "msix-data-width", &len);
+		val = of_get_property(pbm->op->node, "msix-data-width", &len);
 		if (!val || len != 4)
 			goto no_msi;
 		pbm->msix_data_width = *val;
 
-		arng = of_get_property(pbm->prom_node, "msi-address-ranges",
+		arng = of_get_property(pbm->op->node, "msi-address-ranges",
 				       &len);
 		if (!arng || len != sizeof(struct addr_range_prop))
 			goto no_msi;
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 70a7af0..4562b3e 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -690,7 +690,7 @@ static irqreturn_t psycho_pcierr_intr(int irq, void *dev_id)
 #define  PSYCHO_ECCCTRL_CE	 0x2000000000000000UL /* Enable CE INterrupts */
 static void psycho_register_error_handlers(struct pci_pbm_info *pbm)
 {
-	struct of_device *op = of_find_device_by_node(pbm->prom_node);
+	struct of_device *op = of_find_device_by_node(pbm->op->node);
 	unsigned long base = pbm->controller_regs;
 	u64 tmp;
 	int err;
@@ -967,7 +967,7 @@ static void __init psycho_pbm_init(struct pci_pbm_info *pbm,
 	pbm->chip_version = of_getintprop_default(dp, "version#", 0);
 	pbm->chip_revision = of_getintprop_default(dp, "module-revision#", 0);
 
-	pbm->prom_node = dp;
+	pbm->op = op;
 	pbm->name = dp->full_name;
 
 	printk(KERN_INFO "%s: PSYCHO PCI Bus Module ver[%x:%x]\n",
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index 8f779b5..196049b 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -543,7 +543,7 @@ static irqreturn_t sabre_pcierr_intr(int irq, void *dev_id)
 
 static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 {
-	struct device_node *dp = pbm->prom_node;
+	struct device_node *dp = pbm->op->node;
 	struct of_device *op;
 	unsigned long base = pbm->controller_regs;
 	u64 tmp;
@@ -750,7 +750,7 @@ static void __init sabre_pbm_init(struct pci_pbm_info *pbm,
 	pbm->index = pci_num_pbms++;
 
 	pbm->chip_type = PBM_CHIP_TYPE_SABRE;
-	pbm->prom_node = dp;
+	pbm->op = op;
 	pci_get_pbm_props(pbm);
 
 	pci_determine_mem_io_space(pbm);
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index 67e3640..c308565 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -862,7 +862,7 @@ static int pbm_routes_this_ino(struct pci_pbm_info *pbm, u32 ino)
  */
 static void tomatillo_register_error_handlers(struct pci_pbm_info *pbm)
 {
-	struct of_device *op = of_find_device_by_node(pbm->prom_node);
+	struct of_device *op = of_find_device_by_node(pbm->op->node);
 	u64 tmp, err_mask, err_no_mask;
 	int err;
 
@@ -958,7 +958,7 @@ static void tomatillo_register_error_handlers(struct pci_pbm_info *pbm)
 
 static void schizo_register_error_handlers(struct pci_pbm_info *pbm)
 {
-	struct of_device *op = of_find_device_by_node(pbm->prom_node);
+	struct of_device *op = of_find_device_by_node(pbm->op->node);
 	u64 tmp, err_mask, err_no_mask;
 	int err;
 
@@ -1088,7 +1088,7 @@ static void __devinit schizo_scan_bus(struct pci_pbm_info *pbm,
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable -		(of_find_property(pbm->prom_node, "66mhz-capable", NULL)
+		(of_find_property(pbm->op->node, "66mhz-capable", NULL)
 		 != NULL);
 
 	pbm->pci_bus = pci_scan_one_pbm(pbm, parent);
@@ -1158,7 +1158,7 @@ static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 	u32 dma_mask;
 	u64 control;
 
-	vdma = of_get_property(pbm->prom_node, "virtual-dma", NULL);
+	vdma = of_get_property(pbm->op->node, "virtual-dma", NULL);
 	if (!vdma)
 		vdma = vdma_default;
 
@@ -1288,7 +1288,7 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	    pbm->chip_version >= 0x2)
 		tmp |= 0x3UL << SCHIZO_PCICTRL_PTO_SHIFT;
 
-	if (!of_find_property(pbm->prom_node, "no-bus-parking", NULL))
+	if (!of_find_property(pbm->op->node, "no-bus-parking", NULL))
 		tmp |= SCHIZO_PCICTRL_PARK;
 	else
 		tmp &= ~SCHIZO_PCICTRL_PARK;
@@ -1377,7 +1377,7 @@ static int __devinit schizo_pbm_init(struct pci_pbm_info *pbm,
 	pbm->index = pci_num_pbms++;
 
 	pbm->portid = portid;
-	pbm->prom_node = dp;
+	pbm->op = op;
 
 	pbm->chip_type = chip_type;
 	pbm->chip_version = of_getintprop_default(dp, "version#", 0);
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 233b22b..97a77bc 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -550,7 +550,7 @@ static void __init pci_sun4v_scan_bus(struct pci_pbm_info *pbm,
 	struct property *prop;
 	struct device_node *dp;
 
-	dp = pbm->prom_node;
+	dp = pbm->op->node;
 	prop = of_find_property(dp, "66mhz-capable", NULL);
 	pbm->is_66mhz_capable = (prop != NULL);
 	pbm->pci_bus = pci_scan_one_pbm(pbm, parent);
@@ -594,7 +594,7 @@ static int __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	u32 dma_mask, dma_offset;
 	const u32 *vdma;
 
-	vdma = of_get_property(pbm->prom_node, "virtual-dma", NULL);
+	vdma = of_get_property(pbm->op->node, "virtual-dma", NULL);
 	if (!vdma)
 		vdma = vdma_default;
 
@@ -901,7 +901,7 @@ static int __init pci_sun4v_pbm_init(struct pci_pbm_info *pbm,
 
 	pbm->index = pci_num_pbms++;
 
-	pbm->prom_node = dp;
+	pbm->op = op;
 
 	pbm->devhandle = devhandle;
 
-- 
1.5.6.5.GIT

