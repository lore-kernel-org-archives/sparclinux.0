From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 27 Jan 2011 11:26:58 +0000
Subject: [PATCH v2] SPARC/LEON: power down instruction different of different LEONs
Message-Id: <1296127618-10894-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The way a LEON is powered down is implemented differently depending
on CHIP type. The AMBA Plug&Play system ID tells revision of GRLIB
and CHIP.

This is for example needed by the GR-LEON4-ITX board and the UT699.

Previously the power down support for LEON was limited to SMP, now
both SMP and UP systems use the instruction.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon_amba.h |    6 +++
 arch/sparc/kernel/Makefile         |    1 +
 arch/sparc/kernel/leon_kernel.c    |    9 ++++-
 arch/sparc/kernel/leon_pmc.c       |   82 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/leon_smp.c       |   16 -------
 5 files changed, 97 insertions(+), 17 deletions(-)
 create mode 100644 arch/sparc/kernel/leon_pmc.c

diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index 263c719..e50f326 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -180,6 +180,7 @@ struct amba_ahb_device {
 struct device_node;
 void _amba_init(struct device_node *dp, struct device_node ***nextp);
 
+extern unsigned long amba_system_id;
 extern struct leon3_irqctrl_regs_map *leon3_irqctrl_regs;
 extern struct leon3_gptimer_regs_map *leon3_gptimer_regs;
 extern struct amba_apb_device leon_percpu_timer_dev[16];
@@ -254,6 +255,11 @@ extern unsigned int sparc_leon_eirq;
 #define GAISLER_L2C      0xffe	/* internal device: leon2compat */
 #define GAISLER_PLUGPLAY 0xfff	/* internal device: plug & play configarea */
 
+/* Chip IDs */
+#define AEROFLEX_UT699    0x0699
+#define LEON4_NEXTREME1   0x0102
+#define GAISLER_GR712RC   0x0712
+
 #define amba_vendor(x) (((x) >> 24) & 0xff)
 
 #define amba_device(x) (((x) >> 12) & 0xfff)
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 599398f..27e7f25 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -54,6 +54,7 @@ obj-y                   += of_device_$(BITS).o
 obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
 obj-$(CONFIG_SPARC_LEON)+= leon_kernel.o
+obj-$(CONFIG_SPARC_LEON)+= leon_pmc.o
 
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index fdab7f8..2f8a9a2 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -30,6 +30,7 @@ struct amba_apb_device leon_percpu_timer_dev[16];
 int leondebug_irq_disable;
 int leon_debug_irqout;
 static int dummy_master_l10_counter;
+unsigned long amba_system_id;
 
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
@@ -117,10 +118,16 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
 	dummy_master_l10_counter = 0;
 
-	/*Find IRQMP IRQ Controller Registers base address otherwise bail out.*/
 	rootnp = of_find_node_by_path("/ambapp0");
 	if (!rootnp)
 		goto bad;
+
+	/* Find System ID: GRLIB build ID and optional CHIP ID */
+	pp = of_find_property(rootnp, "systemid", &len);
+	if (pp)
+		amba_system_id = *(unsigned long *)pp->value;
+
+	/* Find IRQMP IRQ Controller Registers base adr otherwise bail out */
 	np = of_find_node_by_name(rootnp, "GAISLER_IRQMP");
 	if (!np) {
 		np = of_find_node_by_name(rootnp, "01_00d");
diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
new file mode 100644
index 0000000..519ca92
--- /dev/null
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -0,0 +1,82 @@
+/* leon_pmc.c: LEON Power-down cpu_idle() handler
+ *
+ * Copyright (C) 2011 Daniel Hellstrom (daniel@gaisler.com) Aeroflex Gaisler AB
+ */
+
+#include <linux/init.h>
+#include <linux/pm.h>
+
+#include <asm/leon_amba.h>
+#include <asm/leon.h>
+
+/* List of Systems that need fixup instructions around power-down instruction */
+unsigned int pmc_leon_fixup_ids[] = {
+	AEROFLEX_UT699,
+	GAISLER_GR712RC,
+	LEON4_NEXTREME1,
+	0
+};
+
+int pmc_leon_need_fixup(void)
+{
+	unsigned int systemid = amba_system_id >> 16;
+	unsigned int *id;
+
+	id = &pmc_leon_fixup_ids[0];
+	while (*id != 0) {
+		if (*id = systemid)
+			return 1;
+		id++;
+	}
+
+	return 0;
+}
+
+/*
+ * CPU idle callback function for systems that need some extra handling
+ * See .../arch/sparc/kernel/process.c
+ */
+void pmc_leon_idle_fixup(void)
+{
+	/* Prepare an address to a non-cachable region. APB is always
+	 * none-cachable. One instruction is executed after the Sleep
+	 * instruction, we make sure to read the bus and throw away the
+	 * value by accessing a non-cachable area, also we make sure the
+	 * MMU does not get a TLB miss here by using the MMU BYPASS ASI.
+	 */
+	register unsigned int address = (unsigned int)leon3_irqctrl_regs;
+	__asm__ __volatile__ (
+		"mov	%%g0, %%asr19\n"
+		"lda	[%0] %1, %%g0\n"
+		:
+		: "r"(address), "i"(ASI_LEON_BYPASS));
+}
+
+/*
+ * CPU idle callback function
+ * See .../arch/sparc/kernel/process.c
+ */
+void pmc_leon_idle(void)
+{
+	/* For systems without power-down, this will be no-op */
+	__asm__ __volatile__ ("mov	%g0, %asr19\n\t");
+}
+
+/* Install LEON Power Down function */
+static int __init leon_pmc_install(void)
+{
+	/* Assign power management IDLE handler */
+	if (pmc_leon_need_fixup())
+		pm_idle = pmc_leon_idle_fixup;
+	else
+		pm_idle = pmc_leon_idle;
+
+	printk(KERN_INFO "leon: power management initialized\n");
+
+	return 0;
+}
+
+/* This driver is not critical to the boot process, don't care
+ * if initialized late.
+ */
+late_initcall(leon_pmc_install);
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 16582d8..e9df87f 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -437,15 +437,6 @@ void __init leon_blackbox_current(unsigned *addr)
 
 }
 
-/*
- * CPU idle callback function
- * See .../arch/sparc/kernel/process.c
- */
-void pmc_leon_idle(void)
-{
-	__asm__ volatile ("mov %g0, %asr19");
-}
-
 void __init leon_init_smp(void)
 {
 	/* Patch ipi15 trap table */
@@ -456,13 +447,6 @@ void __init leon_init_smp(void)
 	BTFIXUPSET_CALL(smp_cross_call, leon_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __leon_processor_id,
 			BTFIXUPCALL_NORM);
-
-#ifndef PMC_NO_IDLE
-	/* Assign power management IDLE handler */
-	pm_idle = pmc_leon_idle;
-	printk(KERN_INFO "leon: power management initialized\n");
-#endif
-
 }
 
 #endif /* CONFIG_SPARC_LEON */
-- 
1.5.4

