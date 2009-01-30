From: David Miller <davem@davemloft.net>
Date: Fri, 30 Jan 2009 08:25:55 +0000
Subject: [PATCH 1/3]: sparc64: Move generic PCR support code to seperate
Message-Id: <20090130.002555.47128964.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It all lives in the oprofile support code currently and we will need
to share this stuff with NMI watchdog and perf_counter support.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pcr.h |   30 +++++++++
 arch/sparc/include/asm/pil.h |    1 +
 arch/sparc/kernel/Makefile   |    1 +
 arch/sparc/kernel/pcr.c      |  140 ++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/ttable.S   |    3 +-
 arch/sparc/oprofile/init.c   |  110 +--------------------------------
 6 files changed, 177 insertions(+), 108 deletions(-)
 create mode 100644 arch/sparc/include/asm/pcr.h
 create mode 100644 arch/sparc/kernel/pcr.c

diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
new file mode 100644
index 0000000..4249bb5
--- /dev/null
+++ b/arch/sparc/include/asm/pcr.h
@@ -0,0 +1,30 @@
+#ifndef __PCR_H
+#define __PCR_H
+
+struct pcr_ops {
+	u64 (*read)(void);
+	void (*write)(u64);
+};
+extern const struct pcr_ops *pcr_ops;
+
+extern void deferred_pcr_work_irq(int irq, struct pt_regs *regs);
+extern void schedule_deferred_pcr_work(void);
+
+#define PCR_PIC_PRIV		0x00000001 /* PIC access is privileged */
+#define PCR_STRACE		0x00000002 /* Trace supervisor events  */
+#define PCR_UTRACE		0x00000004 /* Trace user events        */
+#define PCR_N2_HTRACE		0x00000008 /* Trace hypervisor events  */
+#define PCR_N2_TOE_OV0		0x00000010 /* Trap if PIC 0 overflows  */
+#define PCR_N2_TOE_OV1		0x00000020 /* Trap if PIC 1 overflows  */
+#define PCR_N2_MASK0		0x00003fc0
+#define PCR_N2_MASK0_SHIFT	6
+#define PCR_N2_SL0		0x0003c000
+#define PCR_N2_SL0_SHIFT	14
+#define PCR_N2_OV0		0x00040000
+#define PCR_N2_MASK1		0x07f80000
+#define PCR_N2_MASK1_SHIFT	19
+#define PCR_N2_SL1		0x78000000
+#define PCR_N2_SL1_SHIFT	27
+#define PCR_N2_OV1		0x80000000
+
+#endif /* __PCR_H */
diff --git a/arch/sparc/include/asm/pil.h b/arch/sparc/include/asm/pil.h
index d573820..32a7efe 100644
--- a/arch/sparc/include/asm/pil.h
+++ b/arch/sparc/include/asm/pil.h
@@ -23,6 +23,7 @@
 #define PIL_SMP_CTX_NEW_VERSION	4
 #define PIL_DEVICE_IRQ		5
 #define PIL_SMP_CALL_FUNC_SNGL	6
+#define PIL_DEFERRED_PCR_WORK	7
 #define PIL_NORMAL_MAX		14
 #define PIL_NMI			15
 
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 53adcaa..cb182d9 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_SPARC64)   += visemul.o
 obj-$(CONFIG_SPARC64)   += hvapi.o
 obj-$(CONFIG_SPARC64)   += sstate.o
 obj-$(CONFIG_SPARC64)   += mdesc.o
+obj-$(CONFIG_SPARC64)	+= pcr.o
 
 # sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implementation
 obj-$(CONFIG_SPARC32)     += devres.o
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
new file mode 100644
index 0000000..c4f2470
--- /dev/null
+++ b/arch/sparc/kernel/pcr.c
@@ -0,0 +1,140 @@
+/* pcr.c: Generic sparc64 performance counter infrastructure.
+ *
+ * Copyright (C) 2009 David S. Miller (davem@davemloft.net)
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <asm/pil.h>
+#include <asm/pcr.h>
+
+/* This code is shared between various users of the performance
+ * counters.  Users will be oprofile, pseudo-NMI watchdog, and the
+ * perf_counter support layer.
+ */
+
+/* Performance counter interrupts run unmasked at PIL level 15.
+ * Therefore we can't do things like wakeups and other work
+ * that expects IRQ disabling to be adhered to in locking etc.
+ *
+ * Therefore in such situations we defer the work by signalling
+ * a lower level cpu IRQ.
+ */
+void deferred_pcr_work_irq(int irq, struct pt_regs *regs)
+{
+	clear_softint(1 << PIL_DEFERRED_PCR_WORK);
+}
+
+void schedule_deferred_pcr_work(void)
+{
+	set_softint(1 << PIL_DEFERRED_PCR_WORK);
+}
+
+const struct pcr_ops *pcr_ops;
+EXPORT_SYMBOL_GPL(pcr_ops);
+
+static u64 direct_pcr_read(void)
+{
+	u64 val;
+
+	read_pcr(val);
+	return val;
+}
+
+static void direct_pcr_write(u64 val)
+{
+	write_pcr(val);
+}
+
+static const struct pcr_ops direct_pcr_ops = {
+	.read	= direct_pcr_read,
+	.write	= direct_pcr_write,
+};
+
+static void n2_pcr_write(u64 val)
+{
+	unsigned long ret;
+
+	ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
+	if (val != HV_EOK)
+		write_pcr(val);
+}
+
+static const struct pcr_ops n2_pcr_ops = {
+	.read	= direct_pcr_read,
+	.write	= n2_pcr_write,
+};
+
+static unsigned long perf_hsvc_group;
+static unsigned long perf_hsvc_major;
+static unsigned long perf_hsvc_minor;
+
+static int __init register_perf_hsvc(void)
+{
+	if (tlb_type = hypervisor) {
+		switch (sun4v_chip_type) {
+		case SUN4V_CHIP_NIAGARA1:
+			perf_hsvc_group = HV_GRP_NIAG_PERF;
+			break;
+
+		case SUN4V_CHIP_NIAGARA2:
+			perf_hsvc_group = HV_GRP_N2_CPU;
+			break;
+
+		default:
+			return -ENODEV;
+		}
+
+
+		perf_hsvc_major = 1;
+		perf_hsvc_minor = 0;
+		if (sun4v_hvapi_register(perf_hsvc_group,
+					 perf_hsvc_major,
+					 &perf_hsvc_minor)) {
+			printk("perfmon: Could not register hvapi.\n");
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+static void __init unregister_perf_hsvc(void)
+{
+	if (tlb_type != hypervisor)
+		return;
+	sun4v_hvapi_unregister(perf_hsvc_group);
+}
+
+int __init pcr_arch_init(void)
+{
+	int err = register_perf_hsvc();
+
+	if (err)
+		return err;
+
+	switch (tlb_type) {
+	case hypervisor:
+		pcr_ops = &n2_pcr_ops;
+		break;
+
+	case spitfire:
+	case cheetah:
+	case cheetah_plus:
+		pcr_ops = &direct_pcr_ops;
+		break;
+
+	default:
+		err = -ENODEV;
+		goto out_unregister;
+	}
+
+	return 0;
+
+out_unregister:
+	unregister_perf_hsvc();
+	return err;
+}
+
+arch_initcall(pcr_arch_init);
diff --git a/arch/sparc/kernel/ttable.S b/arch/sparc/kernel/ttable.S
index ea92550..d9bdfb9 100644
--- a/arch/sparc/kernel/ttable.S
+++ b/arch/sparc/kernel/ttable.S
@@ -63,7 +63,8 @@ tl0_irq6:	TRAP_IRQ(smp_call_function_single_client, 6)
 #else
 tl0_irq6:	BTRAP(0x46)
 #endif
-tl0_irq7:	BTRAP(0x47) BTRAP(0x48) BTRAP(0x49)
+tl0_irq7:	TRAP_IRQ(deferred_pcr_work_irq, 7)
+tl0_irq8:	BTRAP(0x48) BTRAP(0x49)
 tl0_irq10:	BTRAP(0x4a) BTRAP(0x4b) BTRAP(0x4c) BTRAP(0x4d)
 tl0_irq14:	TRAP_IRQ(timer_interrupt, 14)
 tl0_irq15:	TRAP_NMI_IRQ(perfctr_irq, 15)
diff --git a/arch/sparc/oprofile/init.c b/arch/sparc/oprofile/init.c
index d6e170c..c8877a5 100644
--- a/arch/sparc/oprofile/init.c
+++ b/arch/sparc/oprofile/init.c
@@ -17,47 +17,10 @@
 #include <asm/spitfire.h>
 #include <asm/cpudata.h>
 #include <asm/irq.h>
+#include <asm/pcr.h>
 
 static int nmi_enabled;
 
-struct pcr_ops {
-	u64 (*read)(void);
-	void (*write)(u64);
-};
-static const struct pcr_ops *pcr_ops;
-
-static u64 direct_pcr_read(void)
-{
-	u64 val;
-
-	read_pcr(val);
-	return val;
-}
-
-static void direct_pcr_write(u64 val)
-{
-	write_pcr(val);
-}
-
-static const struct pcr_ops direct_pcr_ops = {
-	.read	= direct_pcr_read,
-	.write	= direct_pcr_write,
-};
-
-static void n2_pcr_write(u64 val)
-{
-	unsigned long ret;
-
-	ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
-	if (val != HV_EOK)
-		write_pcr(val);
-}
-
-static const struct pcr_ops n2_pcr_ops = {
-	.read	= direct_pcr_read,
-	.write	= n2_pcr_write,
-};
-
 /* In order to commonize as much of the implementation as
  * possible, we use PICH as our counter.  Mostly this is
  * to accomodate Niagara-1 which can only count insn cycles
@@ -70,30 +33,13 @@ static u64 picl_value(void)
 	return ((u64)((0 - delta) & 0xffffffff)) << 32;
 }
 
-#define PCR_PIC_PRIV		0x00000001 /* PIC access is privileged */
-#define PCR_STRACE		0x00000002 /* Trace supervisor events  */
-#define PCR_UTRACE		0x00000004 /* Trace user events        */
-#define PCR_N2_HTRACE		0x00000008 /* Trace hypervisor events  */
-#define PCR_N2_TOE_OV0		0x00000010 /* Trap if PIC 0 overflows  */
-#define PCR_N2_TOE_OV1		0x00000020 /* Trap if PIC 1 overflows  */
-#define PCR_N2_MASK0		0x00003fc0
-#define PCR_N2_MASK0_SHIFT	6
-#define PCR_N2_SL0		0x0003c000
-#define PCR_N2_SL0_SHIFT	14
-#define PCR_N2_OV0		0x00040000
-#define PCR_N2_MASK1		0x07f80000
-#define PCR_N2_MASK1_SHIFT	19
-#define PCR_N2_SL1		0x78000000
-#define PCR_N2_SL1_SHIFT	27
-#define PCR_N2_OV1		0x80000000
-
 #define PCR_SUN4U_ENABLE	(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE)
 #define PCR_N2_ENABLE		(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE | \
 				 PCR_N2_TOE_OV1 | \
 				 (2 << PCR_N2_SL1_SHIFT) | \
 				 (0xff << PCR_N2_MASK1_SHIFT))
 
-static u64 pcr_enable = PCR_SUN4U_ENABLE;
+static u64 pcr_enable;
 
 static void nmi_handler(struct pt_regs *regs)
 {
@@ -153,62 +99,16 @@ static void nmi_stop(void)
 	synchronize_sched();
 }
 
-static unsigned long perf_hsvc_group;
-static unsigned long perf_hsvc_major;
-static unsigned long perf_hsvc_minor;
-
-static int __init register_perf_hsvc(void)
-{
-	if (tlb_type = hypervisor) {
-		switch (sun4v_chip_type) {
-		case SUN4V_CHIP_NIAGARA1:
-			perf_hsvc_group = HV_GRP_NIAG_PERF;
-			break;
-
-		case SUN4V_CHIP_NIAGARA2:
-			perf_hsvc_group = HV_GRP_N2_CPU;
-			break;
-
-		default:
-			return -ENODEV;
-		}
-
-
-		perf_hsvc_major = 1;
-		perf_hsvc_minor = 0;
-		if (sun4v_hvapi_register(perf_hsvc_group,
-					 perf_hsvc_major,
-					 &perf_hsvc_minor)) {
-			printk("perfmon: Could not register N2 hvapi.\n");
-			return -ENODEV;
-		}
-	}
-	return 0;
-}
-
-static void unregister_perf_hsvc(void)
-{
-	if (tlb_type != hypervisor)
-		return;
-	sun4v_hvapi_unregister(perf_hsvc_group);
-}
-
 static int oprofile_nmi_init(struct oprofile_operations *ops)
 {
-	int err = register_perf_hsvc();
-
-	if (err)
-		return err;
-
 	switch (tlb_type) {
 	case hypervisor:
-		pcr_ops = &n2_pcr_ops;
 		pcr_enable = PCR_N2_ENABLE;
 		break;
 
 	case cheetah:
 	case cheetah_plus:
-		pcr_ops = &direct_pcr_ops;
+		pcr_enable = PCR_SUN4U_ENABLE;
 		break;
 
 	default:
@@ -241,10 +141,6 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	return ret;
 }
 
-
 void oprofile_arch_exit(void)
 {
-#ifdef CONFIG_SPARC64
-	unregister_perf_hsvc();
-#endif
 }
-- 
1.6.1.2.253.ga34a

