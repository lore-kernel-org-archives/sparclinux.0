From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:48 +0000
Subject: [PATCH 35/49]: sparc: Remove SBUS layer resource and irq handling.
Message-Id: <20080827.212448.244818745.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Remove SBUS layer resource and irq handling.

All the drivers use OF device objects now for this
information.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h |   15 -----
 arch/sparc/include/asm/sbus_64.h |   16 -----
 arch/sparc/kernel/ioport.c       |   27 --------
 arch/sparc64/kernel/sbus.c       |    4 -
 drivers/sbus/sbus.c              |  124 +-------------------------------------
 5 files changed, 1 insertions(+), 185 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index 81ea0f6..8f5900b 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -51,17 +51,6 @@ struct sbus_dev {
 	int prom_node;
 	char prom_name[64];
 	int slot;
-
-	struct resource resource[PROMREG_MAX];
-
-	struct linux_prom_registers reg_addrs[PROMREG_MAX];
-	int num_registers;
-
-	struct linux_prom_ranges device_ranges[PROMREG_MAX];
-	int num_device_ranges;
-
-	unsigned int irqs[4];
-	int num_irqs;
 };
 #define to_sbus_device(d) container_of(d, struct sbus_dev, ofdev.dev)
 
@@ -73,9 +62,6 @@ struct sbus_bus {
 	int			prom_node;	/* PROM device tree node for this SBus */
 	char			prom_name[64];  /* Usually "sbus" or "sbi" */
 	int			clock_freq;
-
-	struct linux_prom_ranges sbus_ranges[PROMREG_MAX];
-	int num_sbus_ranges;
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
 
@@ -103,7 +89,6 @@ sbus_is_slave(struct sbus_dev *dev)
 void prom_adjust_ranges(struct linux_prom_ranges *, int,
 			struct linux_prom_ranges *, int);
 
-extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
 extern int sbus_arch_preinit(void);
 extern void sbus_arch_postinit(void);
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index 2b2562e..75f95ff 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -51,17 +51,6 @@ struct sbus_dev {
 	int prom_node;
 	char prom_name[64];
 	int slot;
-
-	struct resource resource[PROMREG_MAX];
-
-	struct linux_prom_registers reg_addrs[PROMREG_MAX];
-	int num_registers;
-
-	struct linux_prom_ranges device_ranges[PROMREG_MAX];
-	int num_device_ranges;
-
-	unsigned int irqs[4];
-	int num_irqs;
 };
 #define to_sbus_device(d) container_of(d, struct sbus_dev, ofdev.dev)
 
@@ -73,10 +62,6 @@ struct sbus_bus {
 	int			prom_node;      /* OBP node of SBUS	*/
 	char			prom_name[64];	/* Usually "sbus" or "sbi" */
 	int			clock_freq;
-
-	struct linux_prom_ranges sbus_ranges[PROMREG_MAX];
-	int num_sbus_ranges;
-
 	int portid;
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
@@ -94,7 +79,6 @@ extern struct sbus_bus *sbus_root;
 	for ((bus) = sbus_root; (bus); (bus) = (bus)->next) \
 		for ((device) = (bus)->devices; (device); (device) = (device)->next)
 
-extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
 extern int sbus_arch_preinit(void);
 extern void sbus_arch_postinit(void);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 0e47830..d82a810 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -394,33 +394,6 @@ void sbus_dma_sync_single_for_device(struct device *dev, dma_addr_t ba, size_t s
 }
 
 /* Support code for sbus_init().  */
-/*
- * XXX This functions appears to be a distorted version of
- * prom_sbus_ranges_init(), with all sun4d stuff cut away.
- * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
- */
-/* added back sun4d patch from Thomas Bogendoerfer - should be OK (crn) */
-void __init sbus_arch_bus_ranges_init(struct device_node *pn, struct sbus_bus *sbus)
-{
-	int parent_node = pn->node;
-
-	if (sparc_cpu_model = sun4d) {
-		struct linux_prom_ranges iounit_ranges[PROMREG_MAX];
-		int num_iounit_ranges, len;
-
-		len = prom_getproperty(parent_node, "ranges",
-				       (char *) iounit_ranges,
-				       sizeof (iounit_ranges));
-		if (len != -1) {
-			num_iounit_ranges -				(len / sizeof(struct linux_prom_ranges));
-			prom_adjust_ranges(sbus->sbus_ranges,
-					   sbus->num_sbus_ranges,
-					   iounit_ranges, num_iounit_ranges);
-		}
-	}
-}
-
 void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 {
 #ifndef CONFIG_SUN4
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index 60fac2d..0193e38 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -650,10 +650,6 @@ fatal_memory_error:
 	prom_printf("sbus_iommu_init: Fatal memory allocation error.\n");
 }
 
-void __init sbus_arch_bus_ranges_init(struct device_node *pn, struct sbus_bus *sbus)
-{
-}
-
 void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 {
 	sbus_iommu_init(dp->node, sbus);
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 08f4667..89eb922 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -51,38 +51,11 @@ static void __init fill_sbus_device_iommu(struct sbus_dev *sdev)
 static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sdev)
 {
 	struct dev_archdata *sd;
-	unsigned long base;
-	const void *pval;
-	int len, err;
+	int err;
 
 	sdev->prom_node = dp->node;
 	strcpy(sdev->prom_name, dp->name);
 
-	pval = of_get_property(dp, "reg", &len);
-	sdev->num_registers = 0;
-	if (pval) {
-		memcpy(sdev->reg_addrs, pval, len);
-
-		sdev->num_registers -			len / sizeof(struct linux_prom_registers);
-
-		base = (unsigned long) sdev->reg_addrs[0].phys_addr;
-
-		/* Compute the slot number. */
-		if (base >= SUN_SBUS_BVADDR && sparc_cpu_model = sun4m)
-			sdev->slot = sbus_dev_slot(base);
-		else
-			sdev->slot = sdev->reg_addrs[0].which_io;
-	}
-
-	pval = of_get_property(dp, "ranges", &len);
-	sdev->num_device_ranges = 0;
-	if (pval) {
-		memcpy(sdev->device_ranges, pval, len);
-		sdev->num_device_ranges -			len / sizeof(struct linux_prom_ranges);
-	}
-
 	sd = &sdev->ofdev.dev.archdata;
 	sd->prom_node = dp;
 	sd->op = &sdev->ofdev;
@@ -105,97 +78,6 @@ static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sde
 	fill_sbus_device_iommu(sdev);
 }
 
-static void __init sbus_bus_ranges_init(struct device_node *dp, struct sbus_bus *sbus)
-{
-	const void *pval;
-	int len;
-
-	pval = of_get_property(dp, "ranges", &len);
-	sbus->num_sbus_ranges = 0;
-	if (pval) {
-		memcpy(sbus->sbus_ranges, pval, len);
-		sbus->num_sbus_ranges -			len / sizeof(struct linux_prom_ranges);
-
-		sbus_arch_bus_ranges_init(dp->parent, sbus);
-	}
-}
-
-static void __init __apply_ranges_to_regs(struct linux_prom_ranges *ranges,
-					  int num_ranges,
-					  struct linux_prom_registers *regs,
-					  int num_regs)
-{
-	if (num_ranges) {
-		int regnum;
-
-		for (regnum = 0; regnum < num_regs; regnum++) {
-			int rngnum;
-
-			for (rngnum = 0; rngnum < num_ranges; rngnum++) {
-				if (regs[regnum].which_io = ranges[rngnum].ot_child_space)
-					break;
-			}
-			if (rngnum = num_ranges) {
-				/* We used to flag this as an error.  Actually
-				 * some devices do not report the regs as we expect.
-				 * For example, see SUNW,pln device.  In that case
-				 * the reg property is in a format internal to that
-				 * node, ie. it is not in the SBUS register space
-				 * per se. -DaveM
-				 */
-				return;
-			}
-			regs[regnum].which_io = ranges[rngnum].ot_parent_space;
-			regs[regnum].phys_addr -= ranges[rngnum].ot_child_base;
-			regs[regnum].phys_addr += ranges[rngnum].ot_parent_base;
-		}
-	}
-}
-
-static void __init __fixup_regs_sdev(struct sbus_dev *sdev)
-{
-	if (sdev->num_registers != 0) {
-		struct sbus_dev *parent = sdev->parent;
-		int i;
-
-		while (parent != NULL) {
-			__apply_ranges_to_regs(parent->device_ranges,
-					       parent->num_device_ranges,
-					       sdev->reg_addrs,
-					       sdev->num_registers);
-
-			parent = parent->parent;
-		}
-
-		__apply_ranges_to_regs(sdev->bus->sbus_ranges,
-				       sdev->bus->num_sbus_ranges,
-				       sdev->reg_addrs,
-				       sdev->num_registers);
-
-		for (i = 0; i < sdev->num_registers; i++) {
-			struct resource *res = &sdev->resource[i];
-
-			res->start = sdev->reg_addrs[i].phys_addr;
-			res->end = (res->start +
-				    (unsigned long)sdev->reg_addrs[i].reg_size - 1UL);
-			res->flags = IORESOURCE_IO |
-				(sdev->reg_addrs[i].which_io & 0xff);
-		}
-	}
-}
-
-static void __init sbus_fixup_all_regs(struct sbus_dev *first_sdev)
-{
-	struct sbus_dev *sdev;
-
-	for (sdev = first_sdev; sdev; sdev = sdev->next) {
-		if (sdev->child)
-			sbus_fixup_all_regs(sdev->child);
-		__fixup_regs_sdev(sdev);
-	}
-}
-
 /* We preserve the "probe order" of these bus and device lists to give
  * the same ordering as the old code.
  */
@@ -263,8 +145,6 @@ static void __init build_one_sbus(struct device_node *dp, int num_sbus)
 
 	strcpy(sbus->prom_name, dp->name);
 
-	sbus_bus_ranges_init(dp, sbus);
-
 	sbus->ofdev.node = dp;
 	sbus->ofdev.dev.parent = NULL;
 	sbus->ofdev.dev.bus = &sbus_bus_type;
@@ -295,8 +175,6 @@ static void __init build_one_sbus(struct device_node *dp, int num_sbus)
 		}
 		dev_dp = dev_dp->sibling;
 	}
-
-	sbus_fixup_all_regs(sbus->devices);
 }
 
 static int __init sbus_init(void)
-- 
1.5.6.5.GIT

