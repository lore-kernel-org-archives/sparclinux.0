From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:46 +0000
Subject: [PATCH 34/49]: sparc: Kill SBUS layer IRQ hooks.
Message-Id: <20080827.212446.76448152.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill SBUS layer IRQ hooks.

IRQs are obtained by drivers from the of_device struct.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h |   17 ------------
 arch/sparc/include/asm/sbus_64.h |    3 --
 arch/sparc/kernel/ioport.c       |   53 --------------------------------------
 arch/sparc/kernel/sun4c_irq.c    |   13 ---------
 arch/sparc/kernel/sun4d_irq.c    |   21 ---------------
 arch/sparc/kernel/sun4m_irq.c    |   13 ---------
 arch/sparc64/kernel/sbus.c       |   24 -----------------
 drivers/sbus/sbus.c              |    4 ---
 8 files changed, 0 insertions(+), 148 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index 435ae39..81ea0f6 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -76,9 +76,6 @@ struct sbus_bus {
 
 	struct linux_prom_ranges sbus_ranges[PROMREG_MAX];
 	int num_sbus_ranges;
-
-	int devid;
-	int board;
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
 
@@ -102,26 +99,12 @@ sbus_is_slave(struct sbus_dev *dev)
 	for ((bus) = sbus_root; (bus); (bus) = (bus)->next) \
 		for ((device) = (bus)->devices; (device); (device) = (device)->next)
 
-extern void sbus_fill_device_irq(struct sbus_dev *);
-
 /* These yield IOMMU mappings in consistent mode. */
 void prom_adjust_ranges(struct linux_prom_ranges *, int,
 			struct linux_prom_ranges *, int);
 
-/* Eric Brower (ebrower@usa.net)
- * Translate SBus interrupt levels to ino values--
- * this is used when converting sbus "interrupts" OBP
- * node values to "intr" node values, and is platform
- * dependent.  If only we could call OBP with
- * "sbus-intr>cpu (sbint -- ino)" from kernel...
- * See .../drivers/sbus/sbus.c for details.
- */
-BTFIXUPDEF_CALL(unsigned int, sbint_to_irq, struct sbus_dev *sdev, unsigned int)
-#define sbint_to_irq(sdev, sbint) BTFIXUP_CALL(sbint_to_irq)(sdev, sbint)
-
 extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
-extern void sbus_setup_arch_props(struct sbus_bus *, struct device_node *);
 extern int sbus_arch_preinit(void);
 extern void sbus_arch_postinit(void);
 
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index 79719c2..2b2562e 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -94,11 +94,8 @@ extern struct sbus_bus *sbus_root;
 	for ((bus) = sbus_root; (bus); (bus) = (bus)->next) \
 		for ((device) = (bus)->devices; (device); (device) = (device)->next)
 
-extern void sbus_fill_device_irq(struct sbus_dev *);
-
 extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
-extern void sbus_setup_arch_props(struct sbus_bus *, struct device_node *);
 extern int sbus_arch_preinit(void);
 extern void sbus_arch_postinit(void);
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index d65fb9b..0e47830 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -255,49 +255,6 @@ void sbus_set_sbus64(struct device *dev, int x)
 	printk("sbus_set_sbus64: unsupported\n");
 }
 
-extern unsigned int sun4d_build_irq(struct sbus_dev *sdev, int irq);
-void __init sbus_fill_device_irq(struct sbus_dev *sdev)
-{
-	struct linux_prom_irqs irqs[PROMINTR_MAX];
-	int len;
-
-	len = prom_getproperty(sdev->prom_node, "intr",
-			       (char *)irqs, sizeof(irqs));
-	if (len != -1) {
-		sdev->num_irqs = len / 8;
-		if (sdev->num_irqs = 0) {
-			sdev->irqs[0] = 0;
-		} else if (sparc_cpu_model = sun4d) {
-			for (len = 0; len < sdev->num_irqs; len++)
-				sdev->irqs[len] -					sun4d_build_irq(sdev, irqs[len].pri);
-		} else {
-			for (len = 0; len < sdev->num_irqs; len++)
-				sdev->irqs[len] = irqs[len].pri;
-		}
-	} else {
-		int interrupts[PROMINTR_MAX];
-
-		/* No "intr" node found-- check for "interrupts" node.
-		 * This node contains SBus interrupt levels, not IPLs
-		 * as in "intr", and no vector values.  We convert
-		 * SBus interrupt levels to PILs (platform specific).
-		 */
-		len = prom_getproperty(sdev->prom_node, "interrupts",
-				       (char *)interrupts, sizeof(interrupts));
-		if (len = -1) {
-			sdev->irqs[0] = 0;
-			sdev->num_irqs = 0;
-		} else {
-			sdev->num_irqs = len / sizeof(int);
-			for (len = 0; len < sdev->num_irqs; len++) {
-				sdev->irqs[len] -					sbint_to_irq(sdev, interrupts[len]);
-			}
-		}
-	} 
-}
-
 /*
  * Allocate a chunk of memory suitable for DMA.
  * Typically devices use them for control blocks.
@@ -479,16 +436,6 @@ void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 #endif
 }
 
-void __init sbus_setup_arch_props(struct sbus_bus *sbus, struct device_node *dp)
-{
-	if (sparc_cpu_model = sun4d) {
-		struct device_node *parent = dp->parent;
-
-		sbus->devid = of_getintprop_default(parent, "device-id", 0);
-		sbus->board = of_getintprop_default(parent, "board#", 0);
-	}
-}
-
 int __init sbus_arch_preinit(void)
 {
 	register_proc_sparc_ioport();
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 340fc39..a5a32a0 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -66,18 +66,6 @@ static struct resource sun4c_intr_eb = { "sun4c_intr" };
  */
 unsigned char *interrupt_enable = NULL;
 
-static int sun4c_pil_map[] = { 0, 1, 2, 3, 5, 7, 8, 9 };
-
-static unsigned int sun4c_sbint_to_irq(struct sbus_dev *sdev,
-				       unsigned int sbint)
-{
-	if (sbint >= sizeof(sun4c_pil_map)) {
-		printk(KERN_ERR "%s: bogus SBINT %d\n", sdev->prom_name, sbint);
-		BUG();
-	}
-	return sun4c_pil_map[sbint];
-}
-
 static void sun4c_disable_irq(unsigned int irq_nr)
 {
 	unsigned long flags;
@@ -243,7 +231,6 @@ void __init sun4c_init_IRQ(void)
 	if (!interrupt_enable)
 		panic("Cannot map interrupt_enable");
 
-	BTFIXUPSET_CALL(sbint_to_irq, sun4c_sbint_to_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(enable_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(enable_pil_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 7424967..acfb447 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -257,26 +257,6 @@ void sun4d_handler_irq(int irq, struct pt_regs * regs)
 	set_irq_regs(old_regs);
 }
 
-unsigned int sun4d_build_irq(struct sbus_dev *sdev, int irq)
-{
-	int sbusl = pil_to_sbus[irq];
-
-	if (sbusl)
-		return ((sdev->bus->board + 1) << 5) + (sbusl << 2) + sdev->slot;
-	else
-		return irq;
-}
-
-static unsigned int sun4d_sbint_to_irq(struct sbus_dev *sdev,
-				       unsigned int sbint)
-{
-	if (sbint >= sizeof(sbus_to_pil)) {
-		printk(KERN_ERR "%s: bogus SBINT %d\n", sdev->prom_name, sbint);
-		BUG();
-	}
-	return sun4d_build_irq(sdev, sbus_to_pil[sbint]);
-}
-
 int sun4d_request_irq(unsigned int irq,
 		irq_handler_t handler,
 		unsigned long irqflags, const char * devname, void *dev_id)
@@ -585,7 +565,6 @@ void __init sun4d_init_IRQ(void)
 {
 	local_irq_disable();
 
-	BTFIXUPSET_CALL(sbint_to_irq, sun4d_sbint_to_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(enable_irq, sun4d_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, sun4d_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 94e02de..d66334b 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -152,18 +152,6 @@ static unsigned long irq_mask[] = {
 	SUN4M_INT_SBUS(6)				  /* 14 irq 13 */
 };
 
-static int sun4m_pil_map[] = { 0, 2, 3, 5, 7, 9, 11, 13 };
-
-static unsigned int sun4m_sbint_to_irq(struct sbus_dev *sdev,
-				       unsigned int sbint)
-{
-	if (sbint >= sizeof(sun4m_pil_map)) {
-		printk(KERN_ERR "%s: bogus SBINT %d\n", sdev->prom_name, sbint);
-		BUG();
-	}
-	return sun4m_pil_map[sbint] | 0x30;
-}
-
 static unsigned long sun4m_get_irqmask(unsigned int irq)
 {
 	unsigned long mask;
@@ -447,7 +435,6 @@ void __init sun4m_init_IRQ(void)
 				&sun4m_interrupts->undirected_target;
 		sun4m_interrupts->undirected_target = 0;
 	}
-	BTFIXUPSET_CALL(sbint_to_irq, sun4m_sbint_to_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(enable_irq, sun4m_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, sun4m_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(enable_pil_irq, sun4m_enable_pil_irq, BTFIXUPCALL_NORM);
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index aa47022..60fac2d 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -650,26 +650,6 @@ fatal_memory_error:
 	prom_printf("sbus_iommu_init: Fatal memory allocation error.\n");
 }
 
-void sbus_fill_device_irq(struct sbus_dev *sdev)
-{
-	struct device_node *dp = of_find_node_by_phandle(sdev->prom_node);
-	const struct linux_prom_irqs *irqs;
-
-	irqs = of_get_property(dp, "interrupts", NULL);
-	if (!irqs) {
-		sdev->irqs[0] = 0;
-		sdev->num_irqs = 0;
-	} else {
-		unsigned int pri = irqs[0].pri;
-
-		sdev->num_irqs = 1;
-		if (pri < 0x20)
-			pri += sdev->slot * 8;
-
-		sdev->irqs[0] =	sbus_build_irq(sdev->bus, pri);
-	}
-}
-
 void __init sbus_arch_bus_ranges_init(struct device_node *pn, struct sbus_bus *sbus)
 {
 }
@@ -679,10 +659,6 @@ void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 	sbus_iommu_init(dp->node, sbus);
 }
 
-void __init sbus_setup_arch_props(struct sbus_bus *sbus, struct device_node *dp)
-{
-}
-
 int __init sbus_arch_preinit(void)
 {
 	return 0;
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index db0766e..08f4667 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -83,8 +83,6 @@ static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sde
 			len / sizeof(struct linux_prom_ranges);
 	}
 
-	sbus_fill_device_irq(sdev);
-
 	sd = &sdev->ofdev.dev.archdata;
 	sd->prom_node = dp;
 	sd->op = &sdev->ofdev;
@@ -265,8 +263,6 @@ static void __init build_one_sbus(struct device_node *dp, int num_sbus)
 
 	strcpy(sbus->prom_name, dp->name);
 
-	sbus_setup_arch_props(sbus, dp);
-
 	sbus_bus_ranges_init(dp, sbus);
 
 	sbus->ofdev.node = dp;
-- 
1.5.6.5.GIT

