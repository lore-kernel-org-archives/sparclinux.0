From: David Miller <davem@davemloft.net>
Date: Fri, 30 Jan 2009 08:26:04 +0000
Subject: [PATCH 3/3]: sparc64: Implement NMI watchdog on capable cpus.
Message-Id: <20090130.002604.241038136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/cpudata_64.h |    2 +-
 arch/sparc/include/asm/irq_64.h     |    4 +-
 arch/sparc/include/asm/kdebug_64.h  |    2 +
 arch/sparc/include/asm/nmi.h        |   10 ++
 arch/sparc/include/asm/pcr.h        |   16 +++
 arch/sparc/kernel/Makefile          |    1 +
 arch/sparc/kernel/irq_64.c          |   68 +----------
 arch/sparc/kernel/nmi.c             |  224 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/pcr.c             |   17 +++-
 arch/sparc/oprofile/init.c          |  128 ++++++---------------
 10 files changed, 309 insertions(+), 163 deletions(-)
 create mode 100644 arch/sparc/include/asm/nmi.h
 create mode 100644 arch/sparc/kernel/nmi.c

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 7da7c13..a11b89e 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -17,7 +17,7 @@
 typedef struct {
 	/* Dcache line 1 */
 	unsigned int	__softirq_pending; /* must be 1st, see rtrap.S */
-	unsigned int	__pad0;
+	unsigned int	__nmi_count;
 	unsigned long	clock_tick;	/* %tick's per second */
 	unsigned long	__pad;
 	unsigned int	__pad1;
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index d47d4a1..1934f2c 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -66,9 +66,6 @@ extern void virt_irq_free(unsigned int virt_irq);
 extern void __init init_IRQ(void);
 extern void fixup_irqs(void);
 
-extern int register_perfctr_intr(void (*handler)(struct pt_regs *));
-extern void release_perfctr_intr(void (*handler)(struct pt_regs *));
-
 static inline void set_softint(unsigned long bits)
 {
 	__asm__ __volatile__("wr	%0, 0x0, %%set_softint"
@@ -98,5 +95,6 @@ void __trigger_all_cpu_backtrace(void);
 extern void *hardirq_stack[NR_CPUS];
 extern void *softirq_stack[NR_CPUS];
 #define __ARCH_HAS_DO_SOFTIRQ
+#define ARCH_HAS_NMI_WATCHDOG
 
 #endif
diff --git a/arch/sparc/include/asm/kdebug_64.h b/arch/sparc/include/asm/kdebug_64.h
index f905b77..feb3578 100644
--- a/arch/sparc/include/asm/kdebug_64.h
+++ b/arch/sparc/include/asm/kdebug_64.h
@@ -14,6 +14,8 @@ enum die_val {
 	DIE_TRAP,
 	DIE_TRAP_TL1,
 	DIE_CALL,
+	DIE_NMI,
+	DIE_NMIWATCHDOG,
 };
 
 #endif
diff --git a/arch/sparc/include/asm/nmi.h b/arch/sparc/include/asm/nmi.h
new file mode 100644
index 0000000..fbd546d
--- /dev/null
+++ b/arch/sparc/include/asm/nmi.h
@@ -0,0 +1,10 @@
+#ifndef __NMI_H
+#define __NMI_H
+
+extern int __init nmi_init(void);
+extern void perfctr_irq(int irq, struct pt_regs *regs);
+extern void nmi_adjust_hz(unsigned int new_hz);
+
+extern int nmi_usable;
+
+#endif /* __NMI_H */
diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
index 4249bb5..a2f5c61 100644
--- a/arch/sparc/include/asm/pcr.h
+++ b/arch/sparc/include/asm/pcr.h
@@ -27,4 +27,20 @@ extern void schedule_deferred_pcr_work(void);
 #define PCR_N2_SL1_SHIFT	27
 #define PCR_N2_OV1		0x80000000
 
+extern unsigned int picl_shift;
+
+/* In order to commonize as much of the implementation as
+ * possible, we use PICH as our counter.  Mostly this is
+ * to accomodate Niagara-1 which can only count insn cycles
+ * in PICH.
+ */
+static inline u64 picl_value(unsigned int nmi_hz)
+{
+	u32 delta = local_cpu_data().clock_tick / (nmi_hz << picl_shift);
+
+	return ((u64)((0 - delta) & 0xffffffff)) << 32;
+}
+
+extern u64 pcr_enable;
+
 #endif /* __PCR_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index cb182d9..54742e5 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_SPARC64)   += hvapi.o
 obj-$(CONFIG_SPARC64)   += sstate.o
 obj-$(CONFIG_SPARC64)   += mdesc.o
 obj-$(CONFIG_SPARC64)	+= pcr.o
+obj-$(CONFIG_SPARC64)	+= nmi.o
 
 # sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implementation
 obj-$(CONFIG_SPARC32)     += devres.o
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index cab8e02..e289376 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -196,6 +196,11 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+	} else if (i = NR_IRQS) {
+		seq_printf(p, "NMI: ");
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", cpu_data(j).__nmi_count);
+		seq_printf(p, "     Non-maskable interrupts\n");
 	}
 	return 0;
 }
@@ -778,69 +783,6 @@ void do_softirq(void)
 	local_irq_restore(flags);
 }
 
-static void unhandled_perf_irq(struct pt_regs *regs)
-{
-	unsigned long pcr, pic;
-
-	read_pcr(pcr);
-	read_pic(pic);
-
-	write_pcr(0);
-
-	printk(KERN_EMERG "CPU %d: Got unexpected perf counter IRQ.\n",
-	       smp_processor_id());
-	printk(KERN_EMERG "CPU %d: PCR[%016lx] PIC[%016lx]\n",
-	       smp_processor_id(), pcr, pic);
-}
-
-/* Almost a direct copy of the powerpc PMC code.  */
-static DEFINE_SPINLOCK(perf_irq_lock);
-static void *perf_irq_owner_caller; /* mostly for debugging */
-static void (*perf_irq)(struct pt_regs *regs) = unhandled_perf_irq;
-
-/* Invoked from level 15 PIL handler in trap table.  */
-void perfctr_irq(int irq, struct pt_regs *regs)
-{
-	clear_softint(1 << irq);
-	perf_irq(regs);
-}
-
-int register_perfctr_intr(void (*handler)(struct pt_regs *))
-{
-	int ret;
-
-	if (!handler)
-		return -EINVAL;
-
-	spin_lock(&perf_irq_lock);
-	if (perf_irq != unhandled_perf_irq) {
-		printk(KERN_WARNING "register_perfctr_intr: "
-		       "perf IRQ busy (reserved by caller %p)\n",
-		       perf_irq_owner_caller);
-		ret = -EBUSY;
-		goto out;
-	}
-
-	perf_irq_owner_caller = __builtin_return_address(0);
-	perf_irq = handler;
-
-	ret = 0;
-out:
-	spin_unlock(&perf_irq_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_perfctr_intr);
-
-void release_perfctr_intr(void (*handler)(struct pt_regs *))
-{
-	spin_lock(&perf_irq_lock);
-	perf_irq_owner_caller = NULL;
-	perf_irq = unhandled_perf_irq;
-	spin_unlock(&perf_irq_lock);
-}
-EXPORT_SYMBOL_GPL(release_perfctr_intr);
-
 #ifdef CONFIG_HOTPLUG_CPU
 void fixup_irqs(void)
 {
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
new file mode 100644
index 0000000..ffc6900
--- /dev/null
+++ b/arch/sparc/kernel/nmi.c
@@ -0,0 +1,224 @@
+/* Pseudo NMI support on sparc64 systems.
+ *
+ * Copyright (C) 2009 David S. Miller <davem@davemloft.net>
+ *
+ * The NMI watchdog support and infrastructure is based almost
+ * entirely upon the x86 NMI support code.
+ */
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/nmi.h>
+#include <linux/module.h>
+#include <linux/kprobes.h>
+#include <linux/kernel_stat.h>
+#include <linux/slab.h>
+#include <linux/kdebug.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+
+#include <asm/ptrace.h>
+#include <asm/local.h>
+#include <asm/pcr.h>
+
+/* We don't have a real NMI on sparc64, but we can fake one
+ * up using profiling counter overflow interrupts and interrupt
+ * levels.
+ *
+ * The profile overflow interrupts at level 15, so we use
+ * level 14 as our IRQ off level.
+ */
+
+static int nmi_watchdog_active;
+static int panic_on_timeout;
+
+int nmi_usable;
+EXPORT_SYMBOL_GPL(nmi_usable);
+
+static unsigned int nmi_hz = HZ;
+
+static DEFINE_PER_CPU(unsigned int, last_irq_sum);
+static DEFINE_PER_CPU(local_t, alert_counter);
+static DEFINE_PER_CPU(int, nmi_touch);
+
+void touch_nmi_watchdog(void)
+{
+	if (nmi_watchdog_active) {
+		int cpu;
+
+		for_each_present_cpu(cpu) {
+			if (per_cpu(nmi_touch, cpu) != 1)
+				per_cpu(nmi_touch, cpu) = 1;
+		}
+	}
+
+	touch_softlockup_watchdog();
+}
+EXPORT_SYMBOL(touch_nmi_watchdog);
+
+static void die_nmi(const char *str, struct pt_regs *regs, int do_panic)
+{
+	if (notify_die(DIE_NMIWATCHDOG, str, regs, 0,
+		       pt_regs_trap_type(regs), SIGINT) = NOTIFY_STOP)
+		return;
+
+	console_verbose();
+	bust_spinlocks(1);
+
+	printk(KERN_EMERG "%s", str);
+	printk(" on CPU%d, ip %08lx, registers:\n",
+	       smp_processor_id(), regs->tpc);
+	show_regs(regs);
+
+	bust_spinlocks(0);
+
+	if (do_panic || panic_on_oops)
+		panic("Non maskable interrupt");
+
+	local_irq_enable();
+	do_exit(SIGBUS);
+}
+
+notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
+{
+	unsigned int sum, touched = 0;
+	int cpu = smp_processor_id();
+
+	clear_softint(1 << irq);
+	pcr_ops->write(PCR_PIC_PRIV);
+
+	local_cpu_data().__nmi_count++;
+
+	if (notify_die(DIE_NMI, "nmi", regs, 0,
+		       pt_regs_trap_type(regs), SIGINT) = NOTIFY_STOP)
+		touched = 1;
+
+	sum = kstat_cpu(cpu).irqs[0];
+	if (__get_cpu_var(nmi_touch)) {
+		__get_cpu_var(nmi_touch) = 0;
+		touched = 1;
+	}
+	if (!touched && __get_cpu_var(last_irq_sum) = sum) {
+		local_inc(&__get_cpu_var(alert_counter));
+		if (local_read(&__get_cpu_var(alert_counter)) = 5 * nmi_hz)
+			die_nmi("BUG: NMI Watchdog detected LOCKUP",
+				regs, panic_on_timeout);
+	} else {
+		__get_cpu_var(last_irq_sum) = sum;
+		local_set(&__get_cpu_var(alert_counter), 0);
+	}
+	if (nmi_usable) {
+		write_pic(picl_value(nmi_hz));
+		pcr_ops->write(pcr_enable);
+	}
+}
+
+static inline unsigned int get_nmi_count(int cpu)
+{
+	return cpu_data(cpu).__nmi_count;
+}
+
+static int endflag __initdata;
+
+static __init void nmi_cpu_busy(void *data)
+{
+	local_irq_enable_in_hardirq();
+	while (endflag = 0)
+		mb();
+}
+
+static void report_broken_nmi(int cpu, int *prev_nmi_count)
+{
+	printk(KERN_CONT "\n");
+
+	printk(KERN_WARNING
+		"WARNING: CPU#%d: NMI appears to be stuck (%d->%d)!\n",
+			cpu, prev_nmi_count[cpu], get_nmi_count(cpu));
+
+	printk(KERN_WARNING
+		"Please report this to bugzilla.kernel.org,\n");
+	printk(KERN_WARNING
+		"and attach the output of the 'dmesg' command.\n");
+
+	nmi_usable = 0;
+}
+
+static void stop_watchdog(void *unused)
+{
+	pcr_ops->write(PCR_PIC_PRIV);
+}
+
+static int __init check_nmi_watchdog(void)
+{
+	unsigned int *prev_nmi_count;
+	int cpu, err;
+
+	prev_nmi_count = kmalloc(nr_cpu_ids * sizeof(unsigned int), GFP_KERNEL);
+	if (!prev_nmi_count) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	printk(KERN_INFO "Testing NMI watchdog ... ");
+
+	smp_call_function(nmi_cpu_busy, (void *)&endflag, 0);
+
+	for_each_possible_cpu(cpu)
+		prev_nmi_count[cpu] = get_nmi_count(cpu);
+	local_irq_enable();
+	mdelay((20 * 1000) / nmi_hz); /* wait 20 ticks */
+
+	for_each_online_cpu(cpu) {
+		if (get_nmi_count(cpu) - prev_nmi_count[cpu] <= 5)
+			report_broken_nmi(cpu, prev_nmi_count);
+	}
+	endflag = 1;
+	if (!nmi_usable) {
+		kfree(prev_nmi_count);
+		err = -ENODEV;
+		goto error;
+	}
+	printk("OK.\n");
+
+	nmi_hz = 1;
+
+	kfree(prev_nmi_count);
+	return 0;
+error:
+	on_each_cpu(stop_watchdog, NULL, 1);
+	return err;
+}
+
+static void start_watchdog(void *unused)
+{
+	pcr_ops->write(PCR_PIC_PRIV);
+	write_pic(picl_value(nmi_hz));
+
+	pcr_ops->write(pcr_enable);
+}
+
+void nmi_adjust_hz(unsigned int new_hz)
+{
+	nmi_hz = new_hz;
+	on_each_cpu(start_watchdog, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(nmi_adjust_hz);
+
+int __init nmi_init(void)
+{
+	nmi_usable = 1;
+
+	on_each_cpu(start_watchdog, NULL, 1);
+
+	return check_nmi_watchdog();
+}
+
+static int __init setup_nmi_watchdog(char *str)
+{
+	if (!strncmp(str, "panic", 5))
+		panic_on_timeout = 1;
+
+	return 0;
+}
+__setup("nmi_watchdog=", setup_nmi_watchdog);
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index c4f2470..92e0dda 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -9,12 +9,22 @@
 
 #include <asm/pil.h>
 #include <asm/pcr.h>
+#include <asm/nmi.h>
 
 /* This code is shared between various users of the performance
  * counters.  Users will be oprofile, pseudo-NMI watchdog, and the
  * perf_counter support layer.
  */
 
+#define PCR_SUN4U_ENABLE	(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE)
+#define PCR_N2_ENABLE		(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE | \
+				 PCR_N2_TOE_OV1 | \
+				 (2 << PCR_N2_SL1_SHIFT) | \
+				 (0xff << PCR_N2_MASK1_SHIFT))
+
+u64 pcr_enable;
+unsigned int picl_shift;
+
 /* Performance counter interrupts run unmasked at PIL level 15.
  * Therefore we can't do things like wakeups and other work
  * that expects IRQ disabling to be adhered to in locking etc.
@@ -117,12 +127,15 @@ int __init pcr_arch_init(void)
 	switch (tlb_type) {
 	case hypervisor:
 		pcr_ops = &n2_pcr_ops;
+		pcr_enable = PCR_N2_ENABLE;
+		picl_shift = 2;
 		break;
 
-	case spitfire:
 	case cheetah:
 	case cheetah_plus:
+	case spitfire:
 		pcr_ops = &direct_pcr_ops;
+		pcr_enable = PCR_SUN4U_ENABLE;
 		break;
 
 	default:
@@ -130,7 +143,7 @@ int __init pcr_arch_init(void)
 		goto out_unregister;
 	}
 
-	return 0;
+	return nmi_init();
 
 out_unregister:
 	unregister_perf_hsvc();
diff --git a/arch/sparc/oprofile/init.c b/arch/sparc/oprofile/init.c
index c8877a5..d172f86 100644
--- a/arch/sparc/oprofile/init.c
+++ b/arch/sparc/oprofile/init.c
@@ -13,117 +13,57 @@
 #include <linux/init.h>
  
 #ifdef CONFIG_SPARC64
-#include <asm/hypervisor.h>
-#include <asm/spitfire.h>
-#include <asm/cpudata.h>
-#include <asm/irq.h>
-#include <asm/pcr.h>
+#include <linux/notifier.h>
+#include <linux/rcupdate.h>
+#include <linux/kdebug.h>
+#include <asm/nmi.h>
 
-static int nmi_enabled;
-
-/* In order to commonize as much of the implementation as
- * possible, we use PICH as our counter.  Mostly this is
- * to accomodate Niagara-1 which can only count insn cycles
- * in PICH.
- */
-static u64 picl_value(void)
-{
-	u32 delta = local_cpu_data().clock_tick / HZ;
-
-	return ((u64)((0 - delta) & 0xffffffff)) << 32;
-}
-
-#define PCR_SUN4U_ENABLE	(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE)
-#define PCR_N2_ENABLE		(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE | \
-				 PCR_N2_TOE_OV1 | \
-				 (2 << PCR_N2_SL1_SHIFT) | \
-				 (0xff << PCR_N2_MASK1_SHIFT))
-
-static u64 pcr_enable;
-
-static void nmi_handler(struct pt_regs *regs)
+static int profile_timer_exceptions_notify(struct notifier_block *self,
+					   unsigned long val, void *data)
 {
-	pcr_ops->write(PCR_PIC_PRIV);
+	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
 
-	if (nmi_enabled) {
-		oprofile_add_sample(regs, 0);
-
-		write_pic(picl_value());
-		pcr_ops->write(pcr_enable);
+	switch (val) {
+	case DIE_NMI:
+		oprofile_add_sample(args->regs, 0);
+		ret = NOTIFY_STOP;
+		break;
+	default:
+		break;
 	}
+	return ret;
 }
 
-/* We count "clock cycle" events in the lower 32-bit PIC.
- * Then configure it such that it overflows every HZ, and thus
- * generates a level 15 interrupt at that frequency.
- */
-static void cpu_nmi_start(void *_unused)
-{
-	pcr_ops->write(PCR_PIC_PRIV);
-	write_pic(picl_value());
-
-	pcr_ops->write(pcr_enable);
-}
+static struct notifier_block profile_timer_exceptions_nb = {
+	.notifier_call	= profile_timer_exceptions_notify,
+};
 
-static void cpu_nmi_stop(void *_unused)
+static int timer_start(void)
 {
-	pcr_ops->write(PCR_PIC_PRIV);
+	if (register_die_notifier(&profile_timer_exceptions_nb))
+		return 1;
+	nmi_adjust_hz(HZ);
+	return 0;
 }
 
-static int nmi_start(void)
-{
-	int err = register_perfctr_intr(nmi_handler);
-
-	if (!err) {
-		nmi_enabled = 1;
-		wmb();
-		err = on_each_cpu(cpu_nmi_start, NULL, 1);
-		if (err) {
-			nmi_enabled = 0;
-			wmb();
-			on_each_cpu(cpu_nmi_stop, NULL, 1);
-			release_perfctr_intr(nmi_handler);
-		}
-	}
-
-	return err;
-}
 
-static void nmi_stop(void)
+static void timer_stop(void)
 {
-	nmi_enabled = 0;
-	wmb();
-
-	on_each_cpu(cpu_nmi_stop, NULL, 1);
-	release_perfctr_intr(nmi_handler);
-	synchronize_sched();
+	nmi_adjust_hz(1);
+	unregister_die_notifier(&profile_timer_exceptions_nb);
+	synchronize_sched();  /* Allow already-started NMIs to complete. */
 }
 
-static int oprofile_nmi_init(struct oprofile_operations *ops)
+static int op_nmi_timer_init(struct oprofile_operations *ops)
 {
-	switch (tlb_type) {
-	case hypervisor:
-		pcr_enable = PCR_N2_ENABLE;
-		break;
-
-	case cheetah:
-	case cheetah_plus:
-		pcr_enable = PCR_SUN4U_ENABLE;
-		break;
-
-	default:
+	if (!nmi_usable)
 		return -ENODEV;
-	}
 
-	ops->create_files = NULL;
-	ops->setup = NULL;
-	ops->shutdown = NULL;
-	ops->start = nmi_start;
-	ops->stop = nmi_stop;
+	ops->start = timer_start;
+	ops->stop = timer_stop;
 	ops->cpu_type = "timer";
-
-	printk(KERN_INFO "oprofile: Using perfctr based NMI timer interrupt.\n");
-
+	printk(KERN_INFO "oprofile: Using perfctr NMI timer interrupt.\n");
 	return 0;
 }
 #endif
@@ -133,7 +73,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	int ret = -ENODEV;
 
 #ifdef CONFIG_SPARC64
-	ret = oprofile_nmi_init(ops);
+	ret = op_nmi_timer_init(ops);
 	if (!ret)
 		return ret;
 #endif
-- 
1.6.1.2.253.ga34a

