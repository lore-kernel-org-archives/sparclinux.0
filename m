From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 02:07:08 +0000
Subject: [PATCH 2/2]: sparc64: Pass proper parent device down into root
Message-Id: <20080901.190708.246126240.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Pass proper parent device down into root pci_create_bus() call.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c        |    6 +++---
 arch/sparc64/kernel/pci_fire.c   |   18 +++++++-----------
 arch/sparc64/kernel/pci_psycho.c |   14 ++++++++------
 arch/sparc64/kernel/pci_sabre.c  |   13 ++++++++-----
 arch/sparc64/kernel/pci_schizo.c |   19 +++++++++++--------
 arch/sparc64/kernel/pci_sun4v.c  |   14 ++++++++------
 6 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 2da32e4..8e18fdf 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -673,15 +673,15 @@ static void __devinit pci_bus_register_of_sysfs(struct pci_bus *bus)
 		pci_bus_register_of_sysfs(child_bus);
 }
 
-struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm)
+struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
+					    struct device *parent)
 {
 	struct device_node *node = pbm->prom_node;
 	struct pci_bus *bus;
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
-	/* XXX parent device? XXX */
-	bus = pci_create_bus(NULL, pbm->pci_first_busno, pbm->pci_ops, pbm);
+	bus = pci_create_bus(parent, pbm->pci_first_busno, pbm->pci_ops, pbm);
 	if (!bus) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index 4fb1ef9..1b44153 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -33,13 +33,6 @@
 			       "i" (ASI_PHYS_BYPASS_EC_E) \
 			     : "memory")
 
-static void __init pci_fire_scan_bus(struct pci_pbm_info *pbm)
-{
-	pbm->pci_bus = pci_scan_one_pbm(pbm);
-
-	/* XXX register error interrupt handlers XXX */
-}
-
 #define FIRE_IOMMU_CONTROL	0x40000UL
 #define FIRE_IOMMU_TSBBASE	0x40008UL
 #define FIRE_IOMMU_FLUSH	0x40100UL
@@ -439,9 +432,10 @@ static void pci_fire_hw_init(struct pci_pbm_info *pbm)
 }
 
 static int __init pci_fire_pbm_init(struct pci_controller_info *p,
-				    struct device_node *dp, u32 portid)
+				    struct of_device *op, u32 portid)
 {
 	const struct linux_prom64_registers *regs;
+	struct device_node *dp = op->node;
 	struct pci_pbm_info *pbm;
 	int err;
 
@@ -483,7 +477,9 @@ static int __init pci_fire_pbm_init(struct pci_controller_info *p,
 
 	pci_fire_msi_init(pbm);
 
-	pci_fire_scan_bus(pbm);
+	pbm->pci_bus = pci_scan_one_pbm(pbm, &op->dev);
+
+	/* XXX register error interrupt handlers XXX */
 
 	return 0;
 }
@@ -508,7 +504,7 @@ static int __devinit fire_probe(struct of_device *op,
 	portid = of_getintprop_default(dp, "portid", 0xff);
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		if (portid_compare(pbm->portid, portid))
-			return pci_fire_pbm_init(pbm->parent, dp, portid);
+			return pci_fire_pbm_init(pbm->parent, op, portid);
 	}
 
 	err = -ENOMEM;
@@ -534,7 +530,7 @@ static int __devinit fire_probe(struct of_device *op,
 
 	p->pbm_B.iommu = iommu;
 
-	return pci_fire_pbm_init(p, dp, portid);
+	return pci_fire_pbm_init(p, op, portid);
 
 out_free_iommu_A:
 	kfree(p->pbm_A.iommu);
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 5ee84c5..47db875 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -803,11 +803,12 @@ static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 	pci_config_write8(addr, 64);
 }
 
-static void __init psycho_scan_bus(struct pci_pbm_info *pbm)
+static void __init psycho_scan_bus(struct pci_pbm_info *pbm,
+				   struct device *parent)
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable = 0;
-	pbm->pci_bus = pci_scan_one_pbm(pbm);
+	pbm->pci_bus = pci_scan_one_pbm(pbm, parent);
 
 	/* After the PCI bus scan is complete, we can register
 	 * the error interrupt handlers.
@@ -971,8 +972,9 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 #define PSYCHO_MEMSPACE_SIZE	0x07fffffffUL
 
 static void __init psycho_pbm_init(struct pci_controller_info *p,
-			    struct device_node *dp, int is_pbm_a)
+				   struct of_device *op, int is_pbm_a)
 {
+	struct device_node *dp = op->node;
 	struct property *prop;
 	struct pci_pbm_info *pbm;
 
@@ -1015,7 +1017,7 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 
 	psycho_pbm_strbuf_init(pbm, is_pbm_a);
 
-	psycho_scan_bus(pbm);
+	psycho_scan_bus(pbm, &op->dev);
 }
 
 #define PSYCHO_CONFIGSPACE	0x001000000UL
@@ -1042,7 +1044,7 @@ static int __devinit psycho_probe(struct of_device *op,
 
 		if (p->pbm_A.portid = upa_portid) {
 			is_pbm_a = (p->pbm_A.prom_node = NULL);
-			psycho_pbm_init(p, dp, is_pbm_a);
+			psycho_pbm_init(p, op, is_pbm_a);
 			return 0;
 		}
 	}
@@ -1086,7 +1088,7 @@ static int __devinit psycho_probe(struct of_device *op,
 
 	is_pbm_a = ((pr_regs[0].phys_addr & 0x6000) = 0x2000);
 
-	psycho_pbm_init(p, dp, is_pbm_a);
+	psycho_pbm_init(p, op, is_pbm_a);
 
 	return 0;
 
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index eee8fdc..707d6d6 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -634,7 +634,8 @@ static void apb_init(struct pci_bus *sabre_bus)
 	}
 }
 
-static void __init sabre_scan_bus(struct pci_pbm_info *pbm)
+static void __init sabre_scan_bus(struct pci_pbm_info *pbm,
+				  struct device *parent)
 {
 	static int once;
 
@@ -662,7 +663,7 @@ static void __init sabre_scan_bus(struct pci_pbm_info *pbm)
 	}
 	once++;
 
-	pbm->pci_bus = pci_scan_one_pbm(pbm);
+	pbm->pci_bus = pci_scan_one_pbm(pbm, parent);
 	if (!pbm->pci_bus)
 		return;
 
@@ -734,8 +735,10 @@ static int sabre_iommu_init(struct pci_pbm_info *pbm,
 }
 
 static void __init sabre_pbm_init(struct pci_controller_info *p,
-				  struct pci_pbm_info *pbm, struct device_node *dp)
+				  struct pci_pbm_info *pbm, struct of_device *op)
 {
+	struct device_node *dp = op->node;
+
 	pbm->name = dp->full_name;
 	printk("%s: SABRE PCI Bus Module\n", pbm->name);
 
@@ -753,7 +756,7 @@ static void __init sabre_pbm_init(struct pci_controller_info *p,
 
 	pci_determine_mem_io_space(pbm);
 
-	sabre_scan_bus(pbm);
+	sabre_scan_bus(pbm, &op->dev);
 }
 
 static int __devinit sabre_probe(struct of_device *op,
@@ -873,7 +876,7 @@ static int __devinit sabre_probe(struct of_device *op,
 	/*
 	 * Look for APB underneath.
 	 */
-	sabre_pbm_init(p, pbm, dp);
+	sabre_pbm_init(p, pbm, op);
 	return 0;
 
 out_free_iommu:
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index bd7612a..64904b1 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -1085,14 +1085,15 @@ static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 	pci_config_write8(addr, 64);
 }
 
-static void __devinit schizo_scan_bus(struct pci_pbm_info *pbm)
+static void __devinit schizo_scan_bus(struct pci_pbm_info *pbm,
+				      struct device *parent)
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable  		(of_find_property(pbm->prom_node, "66mhz-capable", NULL)
 		 != NULL);
 
-	pbm->pci_bus = pci_scan_one_pbm(pbm);
+	pbm->pci_bus = pci_scan_one_pbm(pbm, parent);
 
 	if (pbm->chip_type = PBM_CHIP_TYPE_TOMATILLO)
 		tomatillo_register_error_handlers(pbm);
@@ -1338,10 +1339,11 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 }
 
 static int __devinit schizo_pbm_init(struct pci_controller_info *p,
-				     struct device_node *dp, u32 portid,
+				     struct of_device *op, u32 portid,
 				     int chip_type)
 {
 	const struct linux_prom64_registers *regs;
+	struct device_node *dp = op->node;
 	struct pci_pbm_info *pbm;
 	const char *chipset_name;
 	int is_pbm_a, err;
@@ -1422,7 +1424,7 @@ static int __devinit schizo_pbm_init(struct pci_controller_info *p,
 
 	schizo_pbm_strbuf_init(pbm);
 
-	schizo_scan_bus(pbm);
+	schizo_scan_bus(pbm, &op->dev);
 
 	return 0;
 }
@@ -1437,8 +1439,9 @@ static inline int portid_compare(u32 x, u32 y, int chip_type)
 	return (x = y);
 }
 
-static int __devinit __schizo_init(struct device_node *dp, unsigned long chip_type)
+static int __devinit __schizo_init(struct of_device *op, unsigned long chip_type)
 {
+	struct device_node *dp = op->node;
 	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -1450,7 +1453,7 @@ static int __devinit __schizo_init(struct device_node *dp, unsigned long chip_ty
 	err = -ENOMEM;
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		if (portid_compare(pbm->portid, portid, chip_type)) {
-			if (schizo_pbm_init(pbm->parent, dp,
+			if (schizo_pbm_init(pbm->parent, op,
 					    portid, chip_type))
 				goto out_err;
 			return 0;
@@ -1479,7 +1482,7 @@ static int __devinit __schizo_init(struct device_node *dp, unsigned long chip_ty
 
 	p->pbm_B.iommu = iommu;
 
-	if (schizo_pbm_init(p, dp, portid, chip_type))
+	if (schizo_pbm_init(p, op, portid, chip_type))
 		goto out_free_iommu_B;
 
 	return 0;
@@ -1500,7 +1503,7 @@ out_err:
 static int __devinit schizo_probe(struct of_device *op,
 				  const struct of_device_id *match)
 {
-	return __schizo_init(op->node, (unsigned long) match->data);
+	return __schizo_init(op, (unsigned long) match->data);
 }
 
 /* The ordering of this table is very important.  Some Tomatillo
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 21864f0..4839c50 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -543,7 +543,8 @@ static const struct dma_ops sun4v_dma_ops = {
 	.sync_sg_for_cpu		= dma_4v_sync_sg_for_cpu,
 };
 
-static void __init pci_sun4v_scan_bus(struct pci_pbm_info *pbm)
+static void __init pci_sun4v_scan_bus(struct pci_pbm_info *pbm,
+				      struct device *parent)
 {
 	struct property *prop;
 	struct device_node *dp;
@@ -551,7 +552,7 @@ static void __init pci_sun4v_scan_bus(struct pci_pbm_info *pbm)
 	dp = pbm->prom_node;
 	prop = of_find_property(dp, "66mhz-capable", NULL);
 	pbm->is_66mhz_capable = (prop != NULL);
-	pbm->pci_bus = pci_scan_one_pbm(pbm);
+	pbm->pci_bus = pci_scan_one_pbm(pbm, parent);
 
 	/* XXX register error interrupt handlers XXX */
 }
@@ -894,8 +895,9 @@ static void pci_sun4v_msi_init(struct pci_pbm_info *pbm)
 #endif /* !(CONFIG_PCI_MSI) */
 
 static int __init pci_sun4v_pbm_init(struct pci_controller_info *p,
-				     struct device_node *dp, u32 devhandle)
+				     struct of_device *op, u32 devhandle)
 {
+	struct device_node *dp = op->node;
 	struct pci_pbm_info *pbm;
 	int err;
 
@@ -934,7 +936,7 @@ static int __init pci_sun4v_pbm_init(struct pci_controller_info *p,
 
 	pci_sun4v_msi_init(pbm);
 
-	pci_sun4v_scan_bus(pbm);
+	pci_sun4v_scan_bus(pbm, &op->dev);
 
 	return 0;
 }
@@ -979,7 +981,7 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		if (pbm->devhandle = (devhandle ^ 0x40)) {
-			return pci_sun4v_pbm_init(pbm->parent, dp, devhandle);
+			return pci_sun4v_pbm_init(pbm->parent, op, devhandle);
 		}
 	}
 
@@ -1015,7 +1017,7 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 
 	p->pbm_B.iommu = iommu;
 
-	return pci_sun4v_pbm_init(p, dp, devhandle);
+	return pci_sun4v_pbm_init(p, op, devhandle);
 
 out_free_iommu_A:
 	kfree(p->pbm_A.iommu);
-- 
1.5.6.5.GIT

