From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 19:27:47 +0000
Subject: [PATCH 2/4] sparc32: introduce build_device_irq
Message-Id: <20110213192747.GB25069@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From d28c1be53f7170f578318da0754ccb3ae8771daf Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 Feb 2011 20:59:18 +0100
Subject: [PATCH 2/4] sparc32: introduce build_device_irq

build_device_irq() is used to encapsulate the plaform specific details
we we build an irq.
For now the default is a simple 1:1 but sun4d differs.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq.h          |    3 ++
 arch/sparc/kernel/irq_32.c       |    6 ++++
 arch/sparc/kernel/of_device_32.c |   59 +++----------------------------------
 arch/sparc/kernel/sun4d_irq.c    |   52 +++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 54 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 4b4e54f..d8d2daa 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -1,3 +1,5 @@
+#include <linux/platform_device.h>
+
 #include <asm/btfixup.h>
 
 /*
@@ -7,6 +9,7 @@
  */
 struct sparc_irq_config {
 	void (*init_timers)(irq_handler_t);
+	int (*build_device_irq)(struct platform_device *op, int interrupt);
 };
 extern struct sparc_irq_config sparc_irq_config;
 
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 7297b8a..8f31959 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -587,6 +587,11 @@ int probe_irq_off(unsigned long mask)
 }
 EXPORT_SYMBOL(probe_irq_off);
 
+static int build_device_irq(struct platform_device *op, int interrupt)
+{
+	return interrupt;
+}
+
 /* djhr
  * This could probably be made indirect too and assigned in the CPU
  * bits of the code. That would be much nicer I think and would also
@@ -598,6 +603,7 @@ EXPORT_SYMBOL(probe_irq_off);
 void __init init_IRQ(void)
 {
 	sparc_irq_config.init_timers = irq_panic;
+	sparc_irq_config.build_device_irq = build_device_irq;
 
 	switch (sparc_cpu_model) {
 	case sun4c:
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 2d055a1..a312af4 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -13,6 +13,7 @@
 #include <asm/leon_amba.h>
 
 #include "of_device_common.h"
+#include "irq.h"
 
 /*
  * PCI bus specific translator
@@ -355,7 +356,8 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	if (intr) {
 		op->archdata.num_irqs = len / sizeof(struct linux_prom_irqs);
 		for (i = 0; i < op->archdata.num_irqs; i++)
-			op->archdata.irqs[i] = intr[i].pri;
+			op->archdata.irqs[i] +			    sparc_irq_config.build_device_irq(op, intr[i].pri);
 	} else {
 		const unsigned int *irq  			of_get_property(dp, "interrupts", &len);
@@ -363,64 +365,13 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		if (irq) {
 			op->archdata.num_irqs = len / sizeof(unsigned int);
 			for (i = 0; i < op->archdata.num_irqs; i++)
-				op->archdata.irqs[i] = irq[i];
+				op->archdata.irqs[i] +				    sparc_irq_config.build_device_irq(op, irq[i]);
 		} else {
 			op->archdata.num_irqs = 0;
 		}
 	}
-	if (sparc_cpu_model = sun4d) {
-		static int pil_to_sbus[] = {
-			0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
-		};
-		struct device_node *io_unit, *sbi = dp->parent;
-		const struct linux_prom_registers *regs;
-		int board, slot;
-
-		while (sbi) {
-			if (!strcmp(sbi->name, "sbi"))
-				break;
-
-			sbi = sbi->parent;
-		}
-		if (!sbi)
-			goto build_resources;
-
-		regs = of_get_property(dp, "reg", NULL);
-		if (!regs)
-			goto build_resources;
-
-		slot = regs->which_io;
-
-		/* If SBI's parent is not io-unit or the io-unit lacks
-		 * a "board#" property, something is very wrong.
-		 */
-		if (!sbi->parent || strcmp(sbi->parent->name, "io-unit")) {
-			printk("%s: Error, parent is not io-unit.\n",
-			       sbi->full_name);
-			goto build_resources;
-		}
-		io_unit = sbi->parent;
-		board = of_getintprop_default(io_unit, "board#", -1);
-		if (board = -1) {
-			printk("%s: Error, lacks board# property.\n",
-			       io_unit->full_name);
-			goto build_resources;
-		}
-
-		for (i = 0; i < op->archdata.num_irqs; i++) {
-			int this_irq = op->archdata.irqs[i];
-			int sbusl = pil_to_sbus[this_irq];
-
-			if (sbusl)
-				this_irq = (((board + 1) << 5) +
-					    (sbusl << 2) +
-					    slot);
-
-			op->archdata.irqs[i] = this_irq;
-		}
-	}
 
-build_resources:
 	build_device_resources(op, parent);
 
 	op->dev.parent = parent;
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 5b58a43..6388087 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -549,6 +549,55 @@ void __init sun4d_init_sbi_irq(void)
 	}
 }
 
+int sun4d_build_device_irq(struct platform_device *op, int interrupt)
+{
+	static int pil_to_sbus[] = {
+		0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
+	};
+	struct device_node *dp = op->dev.of_node;
+	struct device_node *io_unit, *sbi = dp->parent;
+	const struct linux_prom_registers *regs;
+	int board, slot;
+	int sbusl;
+
+	while (sbi) {
+		if (!strcmp(sbi->name, "sbi"))
+			break;
+
+		sbi = sbi->parent;
+	}
+	if (!sbi)
+		goto err_out;
+
+	regs = of_get_property(dp, "reg", NULL);
+	if (!regs)
+		goto err_out;
+
+	slot = regs->which_io;
+
+	/*
+	 *  If SBI's parent is not io-unit or the io-unit lacks
+	 * a "board#" property, something is very wrong.
+	 */
+	if (!sbi->parent || strcmp(sbi->parent->name, "io-unit")) {
+		printk("%s: Error, parent is not io-unit.\n", sbi->full_name);
+		goto err_out;
+	}
+	io_unit = sbi->parent;
+	board = of_getintprop_default(io_unit, "board#", -1);
+	if (board = -1) {
+		printk("%s: Error, lacks board# property.\n", io_unit->full_name);
+		goto err_out;
+	}
+
+	sbusl = pil_to_sbus[interrupt];
+	if (sbusl)
+		return (((board + 1) << 5) + (sbusl << 2) + slot);
+
+err_out:
+	return interrupt;
+}
+
 void __init sun4d_init_IRQ(void)
 {
 	local_irq_disable();
@@ -557,7 +606,10 @@ void __init sun4d_init_IRQ(void)
 	BTFIXUPSET_CALL(disable_irq, sun4d_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NORM);
+
 	sparc_irq_config.init_timers = sun4d_init_timers;
+	sparc_irq_config.build_device_irq = sun4d_build_device_irq;
+
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4d_clear_ipi, BTFIXUPCALL_NOP);
-- 
1.6.0.6

