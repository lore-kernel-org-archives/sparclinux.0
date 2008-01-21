From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Jan 2008 20:22:10 +0000
Subject: [PATCH] sparc64: fix of section mismatch warnings
Message-Id: <20080121202210.GA552@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following Section mismatch warning in sparc64:

WARNING: arch/sparc64/kernel/built-in.o(.text+0x13dec): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'psycho_scan_bus' and 'psycho_pbm_init')
WARNING: arch/sparc64/kernel/built-in.o(.text+0x14b58): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'sabre_scan_bus' and 'sabre_init')
WARNING: arch/sparc64/kernel/built-in.o(.text+0x15ea4): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'schizo_scan_bus' and 'schizo_pbm_init')
WARNING: arch/sparc64/kernel/built-in.o(.text+0x17780): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'pci_sun4v_scan_bus' and 'pci_sun4v_get_head')
WARNING: arch/sparc64/kernel/built-in.o(.text+0x17d5c): Section mismatch: reference to .devinit.text:pci_scan_one_pbm (between 'pci_fire_scan_bus' and 'pci_fire_get_head')
WARNING: arch/sparc64/kernel/built-in.o(.text+0x23860): Section mismatch: reference to .devinit.text:vio_dev_release (between 'vio_create_one' and 'vio_add')
WARNING: arch/sparc64/kernel/built-in.o(.text+0x23868): Section mismatch: reference to .devinit.text:vio_dev_release (between 'vio_create_one' and 'vio_add')

The pci_* were all missing __init annotations.
For the vio.c case it was a function with a wrong annotation which was removed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

It all looked trivial to me but plase review.
Note: The warnigns were generated with a more recent modpost than
in mainline / kbuild.git.
I had -fno-inline-functions-called-once added to gcc when seeing these.

	Sam

diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index fef3b37..7571ed5 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -30,7 +30,7 @@
 			       "i" (ASI_PHYS_BYPASS_EC_E) \
 			     : "memory")
 
-static void pci_fire_scan_bus(struct pci_pbm_info *pbm)
+static void __init pci_fire_scan_bus(struct pci_pbm_info *pbm)
 {
 	pbm->pci_bus = pci_scan_one_pbm(pbm);
 
@@ -434,8 +434,8 @@ static void pci_fire_hw_init(struct pci_pbm_info *pbm)
 	fire_write(pbm->pbm_regs + FIRE_PEC_IENAB, ~(u64)0);
 }
 
-static int pci_fire_pbm_init(struct pci_controller_info *p,
-			     struct device_node *dp, u32 portid)
+static int __init pci_fire_pbm_init(struct pci_controller_info *p,
+				    struct device_node *dp, u32 portid)
 {
 	const struct linux_prom64_registers *regs;
 	struct pci_pbm_info *pbm;
@@ -488,7 +488,7 @@ static inline int portid_compare(u32 x, u32 y)
 	return 0;
 }
 
-void fire_pci_init(struct device_node *dp, const char *model_name)
+void __init fire_pci_init(struct device_node *dp, const char *model_name)
 {
 	struct pci_controller_info *p;
 	u32 portid = of_getintprop_default(dp, "portid", 0xff);
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index d27ee5d..0bad96e 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -801,7 +801,7 @@ static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 	pci_config_write8(addr, 64);
 }
 
-static void psycho_scan_bus(struct pci_pbm_info *pbm)
+static void __init psycho_scan_bus(struct pci_pbm_info *pbm)
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable = 0;
@@ -965,7 +965,7 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 #define PSYCHO_MEMSPACE_B	0x180000000UL
 #define PSYCHO_MEMSPACE_SIZE	0x07fffffffUL
 
-static void psycho_pbm_init(struct pci_controller_info *p,
+static void __init psycho_pbm_init(struct pci_controller_info *p,
 			    struct device_node *dp, int is_pbm_a)
 {
 	struct property *prop;
@@ -1012,7 +1012,7 @@ static void psycho_pbm_init(struct pci_controller_info *p,
 
 #define PSYCHO_CONFIGSPACE	0x001000000UL
 
-void psycho_init(struct device_node *dp, char *model_name)
+void __init psycho_init(struct device_node *dp, char *model_name)
 {
 	struct linux_prom64_registers *pr_regs;
 	struct pci_controller_info *p;
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index fba67c3..1c5f5fa 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -633,7 +633,7 @@ static void apb_init(struct pci_bus *sabre_bus)
 	}
 }
 
-static void sabre_scan_bus(struct pci_pbm_info *pbm)
+static void __init sabre_scan_bus(struct pci_pbm_info *pbm)
 {
 	static int once;
 
@@ -731,7 +731,8 @@ static int sabre_iommu_init(struct pci_pbm_info *pbm,
 	return 0;
 }
 
-static void sabre_pbm_init(struct pci_controller_info *p, struct pci_pbm_info *pbm, struct device_node *dp)
+static void __init sabre_pbm_init(struct pci_controller_info *p,
+				  struct pci_pbm_info *pbm, struct device_node *dp)
 {
 	pbm->name = dp->full_name;
 	printk("%s: SABRE PCI Bus Module\n", pbm->name);
@@ -750,7 +751,7 @@ static void sabre_pbm_init(struct pci_controller_info *p, struct pci_pbm_info *p
 	pci_determine_mem_io_space(pbm);
 }
 
-void sabre_init(struct device_node *dp, char *model_name)
+void __init sabre_init(struct device_node *dp, char *model_name)
 {
 	const struct linux_prom64_registers *pr_regs;
 	struct pci_controller_info *p;
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index e752e75..e306093 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -1084,7 +1084,7 @@ static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 	pci_config_write8(addr, 64);
 }
 
-static void schizo_scan_bus(struct pci_pbm_info *pbm)
+static void __init schizo_scan_bus(struct pci_pbm_info *pbm)
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable @@ -1333,9 +1333,9 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	}
 }
 
-static int schizo_pbm_init(struct pci_controller_info *p,
-			   struct device_node *dp, u32 portid,
-			   int chip_type)
+static int __init schizo_pbm_init(struct pci_controller_info *p,
+				  struct device_node *dp, u32 portid,
+				  int chip_type)
 {
 	const struct linux_prom64_registers *regs;
 	struct pci_pbm_info *pbm;
@@ -1430,7 +1430,8 @@ static inline int portid_compare(u32 x, u32 y, int chip_type)
 	return (x = y);
 }
 
-static void __schizo_init(struct device_node *dp, char *model_name, int chip_type)
+static void __init __schizo_init(struct device_node *dp, char *model_name,
+				 int chip_type)
 {
 	struct pci_controller_info *p;
 	struct pci_pbm_info *pbm;
@@ -1474,17 +1475,17 @@ fatal_memory_error:
 	prom_halt();
 }
 
-void schizo_init(struct device_node *dp, char *model_name)
+void __init schizo_init(struct device_node *dp, char *model_name)
 {
 	__schizo_init(dp, model_name, PBM_CHIP_TYPE_SCHIZO);
 }
 
-void schizo_plus_init(struct device_node *dp, char *model_name)
+void __init schizo_plus_init(struct device_node *dp, char *model_name)
 {
 	__schizo_init(dp, model_name, PBM_CHIP_TYPE_SCHIZO_PLUS);
 }
 
-void tomatillo_init(struct device_node *dp, char *model_name)
+void __init tomatillo_init(struct device_node *dp, char *model_name)
 {
 	__schizo_init(dp, model_name, PBM_CHIP_TYPE_TOMATILLO);
 }
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index e587a37..1aa8e04 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -612,7 +612,7 @@ const struct dma_ops sun4v_dma_ops = {
 	.sync_sg_for_cpu		= dma_4v_sync_sg_for_cpu,
 };
 
-static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm)
+static void __init pci_sun4v_scan_bus(struct pci_pbm_info *pbm)
 {
 	struct property *prop;
 	struct device_node *dp;
@@ -960,7 +960,8 @@ static void pci_sun4v_msi_init(struct pci_pbm_info *pbm)
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
-static void __init pci_sun4v_pbm_init(struct pci_controller_info *p, struct device_node *dp, u32 devhandle)
+static void __init pci_sun4v_pbm_init(struct pci_controller_info *p,
+				      struct device_node *dp, u32 devhandle)
 {
 	struct pci_pbm_info *pbm;
 
diff --git a/arch/sparc64/kernel/vio.c b/arch/sparc64/kernel/vio.c
index 0c1ee61..e78b351 100644
--- a/arch/sparc64/kernel/vio.c
+++ b/arch/sparc64/kernel/vio.c
@@ -131,7 +131,7 @@ void vio_unregister_driver(struct vio_driver *viodrv)
 }
 EXPORT_SYMBOL(vio_unregister_driver);
 
-static void __devinit vio_dev_release(struct device *dev)
+static void vio_dev_release(struct device *dev)
 {
 	kfree(to_vio_dev(dev));
 }

