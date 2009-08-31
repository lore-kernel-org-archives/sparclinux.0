From: konrad@gaisler.com
Date: Mon, 31 Aug 2009 13:47:21 +0000
Subject: [PATCH 1/1] sparc,leon: Sparc-Leon SMP support
Message-Id: <1251726441-1032-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

Support SMP for a Sparc-Leon multiprocessor system.
Add Leon specific SMP code to arch/sparc/kernel/leon_smp.c.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h      |   28 +++
 arch/sparc/include/asm/leon_amba.h |    3 +
 arch/sparc/include/asm/smp_32.h    |    9 +
 arch/sparc/kernel/Makefile         |    2 +-
 arch/sparc/kernel/entry.S          |   33 +++
 arch/sparc/kernel/head_32.S        |   22 ++
 arch/sparc/kernel/ioport.c         |    5 +
 arch/sparc/kernel/leon_kernel.c    |   94 +++++++
 arch/sparc/kernel/leon_smp.c       |  468 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/smp_32.c         |   10 +
 arch/sparc/kernel/trampoline_32.S  |   69 ++++++-
 arch/sparc/mm/srmmu.c              |    5 +-
 12 files changed, 745 insertions(+), 3 deletions(-)
 create mode 100644 arch/sparc/kernel/leon_smp.c

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 28a42b7..559448c 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -340,6 +340,30 @@ extern int leon_flush_needed(void);
 extern void leon_switch_mm(void);
 extern int srmmu_swprobe_trace;
 
+#ifdef CONFIG_SMP
+extern int leon_smp_nrcpus(void);
+extern void leon_clear_profile_irq(int cpu);
+extern void leon_smp_done(void);
+extern void leon_boot_cpus(void);
+extern int leon_boot_one_cpu(int i);
+void leon_init_smp(void);
+extern void cpu_probe(void);
+extern void cpu_idle(void);
+extern void init_IRQ(void);
+extern void cpu_panic(void);
+extern int __leon_processor_id(void);
+void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
+
+extern unsigned int real_irq_entry[], smpleon_ticker[];
+extern unsigned int patchme_maybe_smp_msg[];
+extern unsigned long trapbase_cpu1[];
+extern unsigned long trapbase_cpu2[];
+extern unsigned long trapbase_cpu3[];
+extern unsigned int t_nmi[], linux_trap_ipi15_leon[];
+extern unsigned int linux_trap_ipi15_sun4m[];
+
+#endif /* CONFIG_SMP */
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
@@ -356,6 +380,10 @@ extern int srmmu_swprobe_trace;
 #define leon_switch_mm() do {} while (0)
 #define leon_init_IRQ() do {} while (0)
 #define init_leon() do {} while (0)
+#define leon_smp_done() do {} while (0)
+#define leon_boot_cpus() do {} while (0)
+#define leon_boot_one_cpu(i) 1
+#define leon_init_smp() do {} while (0)
 
 #endif /* !defined(CONFIG_SPARC_LEON) */
 
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index 618e888..57d2eae 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -188,6 +188,9 @@ extern int leon_debug_irqout;
 extern unsigned long leon3_gptimer_irq;
 extern unsigned int sparc_leon_eirq;
 
+int amba_get_free_apbslv_devices(int vendor, int device, struct amba_apb_device *dev, int nr);
+
+
 #endif /* __ASSEMBLY__ */
 
 #define LEON3_IO_AREA 0xfff00000
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 58101dc..841905c 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -106,6 +106,15 @@ static inline int hard_smp4d_processor_id(void)
 	return cpuid;
 }
 
+extern inline int hard_smpleon_processor_id(void)
+{
+	int cpuid;
+	__asm__ __volatile__("rd     %%asr17,%0\n\t"
+			     "srl    %0,28,%0" :
+			     "=&r" (cpuid) : );
+	return cpuid;
+}
+
 #ifndef MODULE
 static inline int hard_smp_processor_id(void)
 {
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index b004175..7056244 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_SPARC32)     += dma.o
 obj-$(CONFIG_SPARC32_PCI) += pcic.o
 
 obj-$(CONFIG_SMP)         += trampoline_$(BITS).o smp_$(BITS).o
-obj-$(CONFIG_SPARC32_SMP) += sun4m_smp.o sun4d_smp.o
+obj-$(CONFIG_SPARC32_SMP) += sun4m_smp.o sun4d_smp.o leon_smp.o
 obj-$(CONFIG_SPARC64_SMP) += hvtramp.o
 
 obj-y                     += auxio_$(BITS).o
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index f41ecc5..ec9c7bc 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -400,6 +400,39 @@ linux_trap_ipi15_sun4d:
 	/* FIXME */
 1:	b,a	1b
 
+#ifdef CONFIG_SPARC_LEON
+
+	.globl	smpleon_ticker
+	/* SMP per-cpu ticker interrupts are handled specially. */
+smpleon_ticker:
+        SAVE_ALL
+	or	%l0, PSR_PIL, %g2
+	wr	%g2, 0x0, %psr
+	WRITE_PAUSE
+	wr	%g2, PSR_ET, %psr
+	WRITE_PAUSE
+	call	leon_percpu_timer_interrupt
+	 add	%sp, STACKFRAME_SZ, %o0
+	wr	%l0, PSR_ET, %psr
+	WRITE_PAUSE
+	RESTORE_ALL
+
+	.align	4
+	.globl	linux_trap_ipi15_leon
+linux_trap_ipi15_leon:
+	SAVE_ALL
+	or	%l0, PSR_PIL, %l4
+	wr	%l4, 0x0, %psr
+	WRITE_PAUSE
+	wr	%l4, PSR_ET, %psr
+	WRITE_PAUSE
+	call	leon_cross_call_irq
+	 nop
+	b	ret_trap_lockless_ipi
+	 clr	%l6
+
+#endif /* CONFIG_SPARC_LEON */
+
 #endif /* CONFIG_SMP */
 
 	/* This routine handles illegal instructions and privileged
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 439d82a..21bb259 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -811,9 +811,31 @@ found_version:
 got_prop:
 #ifdef CONFIG_SPARC_LEON
 	        /* no cpu-type check is needed, it is a SPARC-LEON */
+#ifdef CONFIG_SMP
+		ba leon_smp_init
+		 nop
+
+		.global leon_smp_init
+leon_smp_init:
+		sethi	%hi(boot_cpu_id), %g1    ! master always 0
+		stb	%g0, [%g1 + %lo(boot_cpu_id)]
+		sethi	%hi(boot_cpu_id4), %g1   ! master always 0
+		stb	%g0, [%g1 + %lo(boot_cpu_id4)]
+
+		rd     %asr17,%g1
+		srl    %g1,28,%g1
+
+		cmp %g0,%g1
+		 beq sun4c_continue_boot         !continue with master
+		nop
+
+		ba leon_smp_cpu_startup
+		 nop
+#else
 		ba sun4c_continue_boot
 		 nop
 #endif
+#endif
 		set	cputypval, %o2
 		ldub	[%o2 + 0x4], %l1
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 87ea0d0..ec87fb8 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -47,10 +47,15 @@
 #include <asm/dma.h>
 #include <asm/iommu.h>
 #include <asm/io-unit.h>
+#include <asm/leon.h>
 
 #include "dma.h"
 
+#ifdef CONFIG_SPARC_LEON
+#define mmu_inval_dma_area(p, l) leon_flush_dcache_all()
+#else
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
+#endif
 
 static struct resource *_sparc_find_resource(struct resource *r,
 					     unsigned long);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 54d8a5b..ab449b4 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -12,15 +12,20 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
+
 #include <asm/oplib.h>
 #include <asm/timer.h>
 #include <asm/prom.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
+#include <asm/traps.h>
+#include <asm/cacheflush.h>
 
 #include "prom.h"
 #include "irq.h"
 
+#define CONFIG_LEONSMP_USETIMER2
+
 struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address, initialized by amba_init() */
 struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address, initialized by amba_init() */
 struct amba_apb_device leon_percpu_timer_dev[16];
@@ -115,6 +120,21 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 				      (((1000000 / 100) - 1)));
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl, 0);
 
+#ifdef CONFIG_SMP
+		leon_percpu_timer_dev[0].start = (int)leon3_gptimer_regs;
+		leon_percpu_timer_dev[0].irq = leon3_gptimer_irq+1;
+
+		if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
+		      (1<<LEON3_GPTIMER_SEPIRQ))) {
+			prom_printf("irq timer not configured with seperate irqs \n");
+			BUG();
+		}
+
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].val, 0);
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].rld, (((1000000/100) - 1)));
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].ctrl, 0);
+# endif
+
 	} else {
 		printk(KERN_ERR "No Timer/irqctrl found\n");
 		BUG();
@@ -130,11 +150,49 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		prom_halt();
 	}
 
+# ifdef CONFIG_SMP
+	{
+		unsigned long flags;
+		struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (leon_percpu_timer_dev[0].irq - 1)];
+
+		/* For SMP we use the level 14 ticker, however the bootup code
+		 * has copied the firmwares level 14 vector into boot cpu's
+		 * trap table, we must fix this now or we get squashed.
+		 */
+		local_irq_save(flags);
+
+		patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
+
+		/* Adjust so that we jump directly to smpleon_ticker */
+		trap_table->inst_three += smpleon_ticker - real_irq_entry;
+
+		local_flush_cache_all();
+		local_irq_restore(flags);
+	}
+# endif
+
 	if (leon3_gptimer_regs) {
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl,
 				      LEON3_GPTIMER_EN |
 				      LEON3_GPTIMER_RL |
 				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
+
+#ifdef CONFIG_SMP
+# ifdef CONFIG_LEONSMP_USETIMER2
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD |
+				      LEON3_GPTIMER_IRQEN);
+# else
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl,
+				      LEON3_GPTIMER_EN |
+				      LEON3_GPTIMER_RL |
+				      LEON3_GPTIMER_LD |
+				      LEON3_GPTIMER_IRQEN);
+# endif
+#endif
+
 	}
 }
 
@@ -175,6 +233,42 @@ void __init leon_node_init(struct device_node *dp, struct device_node ***nextp)
 	}
 }
 
+#ifdef CONFIG_SMP
+
+void leon_set_cpu_int(int cpu, int level)
+{
+	unsigned long mask;
+	mask = get_irqmask(level);
+	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->force[cpu], mask);
+}
+
+static void leon_clear_ipi(int cpu, int level)
+{
+	unsigned long mask;
+	mask = get_irqmask(level);
+	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->force[cpu], mask<<16);
+}
+
+static void leon_set_udt(int cpu)
+{
+}
+
+void leon_clear_profile_irq(int cpu)
+{
+}
+
+void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
+{
+	unsigned long mask, flags, *addr;
+	mask = get_irqmask(irq_nr);
+	local_irq_save(flags);
+	addr = (unsigned long *)&(leon3_irqctrl_regs->mask[cpu]);
+	LEON3_BYPASS_STORE_PA(addr, (LEON3_BYPASS_LOAD_PA(addr) | (mask)));
+	local_irq_restore(flags);
+}
+
+#endif
+
 void __init leon_init_IRQ(void)
 {
 	sparc_init_timers = leon_init_timers;
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
new file mode 100644
index 0000000..05c0dad
--- /dev/null
+++ b/arch/sparc/kernel/leon_smp.c
@@ -0,0 +1,468 @@
+/* leon_smp.c: Sparc-Leon SMP support.
+ *
+ * based on sun4m_smp.c
+ * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com) Aeroflex Gaisler AB
+ * Copyright (C) 2009 Konrad Eisele (konrad@gaisler.com) Aeroflex Gaisler AB
+ */
+
+#include <asm/head.h>
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/threads.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/profile.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+#include <asm/ptrace.h>
+#include <asm/atomic.h>
+#include <asm/irq_regs.h>
+
+#include <asm/delay.h>
+#include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/oplib.h>
+#include <asm/cpudata.h>
+#include <asm/asi.h>
+#include <asm/leon.h>
+#include <asm/leon_amba.h>
+
+#ifdef CONFIG_SPARC_LEON
+
+#include "irq.h"
+
+extern ctxd_t *srmmu_ctx_table_phys;
+static int smp_processors_ready;
+extern volatile unsigned long cpu_callin_map[NR_CPUS];
+extern unsigned char boot_cpu_id;
+extern cpumask_t smp_commenced_mask;
+void __init leon_configure_cache_smp(void);
+
+static inline unsigned long do_swap(volatile unsigned long *ptr,
+				    unsigned long val)
+{
+	__asm__ __volatile__("swapa [%1] %2, %0\n\t" : "=&r"(val)
+			     : "r"(ptr), "i"(ASI_LEON_DCACHE_MISS)
+			     : "memory");
+	return val;
+}
+
+static void smp_setup_percpu_timer(void);
+
+void __cpuinit leon_callin(void)
+{
+	int cpuid = hard_smpleon_processor_id();
+
+	local_flush_cache_all();
+	local_flush_tlb_all();
+	leon_configure_cache_smp();
+
+	/* Get our local ticker going. */
+	smp_setup_percpu_timer();
+
+	calibrate_delay();
+	smp_store_cpu_info(cpuid);
+
+	local_flush_cache_all();
+	local_flush_tlb_all();
+
+	/*
+	 * Unblock the master CPU _only_ when the scheduler state
+	 * of all secondary CPUs will be up-to-date, so after
+	 * the SMP initialization the master will be just allowed
+	 * to call the scheduler code.
+	 * Allow master to continue.
+	 */
+	do_swap(&cpu_callin_map[cpuid], 1);
+
+	local_flush_cache_all();
+	local_flush_tlb_all();
+
+	cpu_probe();
+
+	/* Fix idle thread fields. */
+	__asm__ __volatile__("ld [%0], %%g6\n\t" : : "r"(&current_set[cpuid])
+			     : "memory" /* paranoid */);
+
+	/* Attach to the address space of init_task. */
+	atomic_inc(&init_mm.mm_count);
+	current->active_mm = &init_mm;
+
+	while (!cpu_isset(cpuid, smp_commenced_mask))
+		mb();
+
+	local_irq_enable();
+	cpu_set(cpuid, cpu_online_map);
+}
+
+/*
+ *	Cycle through the processors asking the PROM to start each one.
+ */
+
+extern struct linux_prom_registers smp_penguin_ctable;
+
+void __init leon_configure_cache_smp(void)
+{
+	unsigned long cfg = sparc_leon3_get_dcachecfg();
+	int me = smp_processor_id();
+
+	if (ASI_LEON3_SYSCTRL_CFG_SSIZE(cfg) > 4) {
+		printk(KERN_INFO "Note: SMP with snooping only works on 4k cache, found %dk(0x%x) on cpu %d, disabling caches\n",
+		     (unsigned int)ASI_LEON3_SYSCTRL_CFG_SSIZE(cfg),
+		     (unsigned int)cfg, (unsigned int)me);
+		sparc_leon3_disable_cache();
+	} else {
+		if (cfg & ASI_LEON3_SYSCTRL_CFG_SNOOPING) {
+			sparc_leon3_enable_snooping();
+		} else {
+			printk(KERN_INFO "Note: You have to enable snooping in the vhdl model cpu %d, disabling caches\n",
+			     me);
+			sparc_leon3_disable_cache();
+		}
+	}
+
+	local_flush_cache_all();
+	local_flush_tlb_all();
+}
+
+void leon_smp_setbroadcast(unsigned int mask)
+{
+	int broadcast +	    ((LEON3_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpstatus)) >>
+	      LEON3_IRQMPSTATUS_BROADCAST) & 1);
+	if (!broadcast) {
+		prom_printf("######## !!!! The irqmp-ctrl must have broadcast enabled, smp wont work !!!!! ####### nr cpus: %d\n",
+		     leon_smp_nrcpus());
+		if (leon_smp_nrcpus() > 1) {
+			BUG();
+		} else {
+			prom_printf("continue anyway\n");
+			return;
+		}
+	}
+	LEON_BYPASS_STORE_PA(&(leon3_irqctrl_regs->mpbroadcast), mask);
+}
+
+unsigned int leon_smp_getbroadcast(void)
+{
+	unsigned int mask;
+	mask = LEON_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpbroadcast));
+	return mask;
+}
+
+int leon_smp_nrcpus(void)
+{
+	int nrcpu +	    ((LEON3_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpstatus)) >>
+	      LEON3_IRQMPSTATUS_CPUNR) & 0xf) + 1;
+	return nrcpu;
+}
+
+void __init leon_boot_cpus(void)
+{
+	int nrcpu = leon_smp_nrcpus();
+	int me = smp_processor_id();
+
+	printk(KERN_INFO "%d:(%d:%d) cpus mpirq at 0x%x \n", (unsigned int)me,
+	       (unsigned int)nrcpu, (unsigned int)NR_CPUS,
+	       (unsigned int)&(leon3_irqctrl_regs->mpstatus));
+
+	leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, me);
+	leon_enable_irq_cpu(LEON3_IRQ_TICKER, me);
+	leon_enable_irq_cpu(LEON3_IRQ_RESCHEDULE, me);
+
+	leon_smp_setbroadcast(1 << LEON3_IRQ_TICKER);
+
+	leon_configure_cache_smp();
+	smp_setup_percpu_timer();
+	local_flush_cache_all();
+
+}
+
+int __cpuinit leon_boot_one_cpu(int i)
+{
+
+	struct task_struct *p;
+	int timeout;
+
+	/* Cook up an idler for this guy. */
+	p = fork_idle(i);
+
+	current_set[i] = task_thread_info(p);
+
+	/* See trampoline.S:leon_smp_cpu_startup for details...
+	 * Initialize the contexts table
+	 * Since the call to prom_startcpu() trashes the structure,
+	 * we need to re-initialize it for each cpu
+	 */
+	smp_penguin_ctable.which_io = 0;
+	smp_penguin_ctable.phys_addr = (unsigned int)srmmu_ctx_table_phys;
+	smp_penguin_ctable.reg_size = 0;
+
+	/* whirrr, whirrr, whirrrrrrrrr... */
+	printk(KERN_INFO "Starting CPU %d : (irqmp: 0x%x)\n", (unsigned int)i,
+	       (unsigned int)&leon3_irqctrl_regs->mpstatus);
+	local_flush_cache_all();
+
+	LEON_BYPASS_STORE_PA(&(leon3_irqctrl_regs->mpstatus), 1 << i);
+
+	/* wheee... it's going... */
+	for (timeout = 0; timeout < 10000; timeout++) {
+		if (cpu_callin_map[i])
+			break;
+		udelay(200);
+	}
+	printk(KERN_INFO "Started CPU %d \n", (unsigned int)i);
+
+	if (!(cpu_callin_map[i])) {
+		printk(KERN_ERR "Processor %d is stuck.\n", i);
+		return -ENODEV;
+	} else {
+		leon_enable_irq_cpu(LEON3_IRQ_CROSS_CALL, i);
+		leon_enable_irq_cpu(LEON3_IRQ_TICKER, i);
+		leon_enable_irq_cpu(LEON3_IRQ_RESCHEDULE, i);
+	}
+
+	local_flush_cache_all();
+	return 0;
+}
+
+void __init leon_smp_done(void)
+{
+
+	int i, first;
+	int *prev;
+
+	/* setup cpu list for irq rotation */
+	first = 0;
+	prev = &first;
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i)) {
+			*prev = i;
+			prev = &cpu_data(i).next;
+		}
+	}
+	*prev = first;
+	local_flush_cache_all();
+
+	/* Free unneeded trap tables */
+	if (!cpu_isset(1, cpu_present_map)) {
+		ClearPageReserved(virt_to_page(trapbase_cpu1));
+		init_page_count(virt_to_page(trapbase_cpu1));
+		free_page((unsigned long)trapbase_cpu1);
+		totalram_pages++;
+		num_physpages++;
+	}
+	if (!cpu_isset(2, cpu_present_map)) {
+		ClearPageReserved(virt_to_page(trapbase_cpu2));
+		init_page_count(virt_to_page(trapbase_cpu2));
+		free_page((unsigned long)trapbase_cpu2);
+		totalram_pages++;
+		num_physpages++;
+	}
+	if (!cpu_isset(3, cpu_present_map)) {
+		ClearPageReserved(virt_to_page(trapbase_cpu3));
+		init_page_count(virt_to_page(trapbase_cpu3));
+		free_page((unsigned long)trapbase_cpu3);
+		totalram_pages++;
+		num_physpages++;
+	}
+	/* Ok, they are spinning and ready to go. */
+	smp_processors_ready = 1;
+
+}
+
+void leon_irq_rotate(int cpu)
+{
+}
+
+static struct smp_funcall {
+	smpfunc_t func;
+	unsigned long arg1;
+	unsigned long arg2;
+	unsigned long arg3;
+	unsigned long arg4;
+	unsigned long arg5;
+	unsigned long processors_in[NR_CPUS];	/* Set when ipi entered. */
+	unsigned long processors_out[NR_CPUS];	/* Set when ipi exited. */
+} ccall_info;
+
+static DEFINE_SPINLOCK(cross_call_lock);
+
+/* Cross calls must be serialized, at least currently. */
+static void leon_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+			    unsigned long arg2, unsigned long arg3,
+			    unsigned long arg4)
+{
+	if (smp_processors_ready) {
+		register int high = NR_CPUS - 1;
+		unsigned long flags;
+
+		spin_lock_irqsave(&cross_call_lock, flags);
+
+		{
+			/* If you make changes here, make sure gcc generates proper code... */
+			register smpfunc_t f asm("i0") = func;
+			register unsigned long a1 asm("i1") = arg1;
+			register unsigned long a2 asm("i2") = arg2;
+			register unsigned long a3 asm("i3") = arg3;
+			register unsigned long a4 asm("i4") = arg4;
+			register unsigned long a5 asm("i5") = 0;
+
+			__asm__ __volatile__("std %0, [%6]\n\t"
+					     "std %2, [%6 + 8]\n\t"
+					     "std %4, [%6 + 16]\n\t" : :
+					     "r"(f), "r"(a1), "r"(a2), "r"(a3),
+					     "r"(a4), "r"(a5),
+					     "r"(&ccall_info.func));
+		}
+
+		/* Init receive/complete mapping, plus fire the IPI's off. */
+		{
+			register int i;
+
+			cpu_clear(smp_processor_id(), mask);
+			cpus_and(mask, cpu_online_map, mask);
+			for (i = 0; i <= high; i++) {
+				if (cpu_isset(i, mask)) {
+					ccall_info.processors_in[i] = 0;
+					ccall_info.processors_out[i] = 0;
+					set_cpu_int(i, LEON3_IRQ_CROSS_CALL);
+
+				}
+			}
+		}
+
+		{
+			register int i;
+
+			i = 0;
+			do {
+				if (!cpu_isset(i, mask))
+					continue;
+
+				while (!ccall_info.processors_in[i])
+					barrier();
+			} while (++i <= high);
+
+			i = 0;
+			do {
+				if (!cpu_isset(i, mask))
+					continue;
+
+				while (!ccall_info.processors_out[i])
+					barrier();
+			} while (++i <= high);
+		}
+
+		spin_unlock_irqrestore(&cross_call_lock, flags);
+	}
+}
+
+/* Running cross calls. */
+void leon_cross_call_irq(void)
+{
+	int i = smp_processor_id();
+
+	ccall_info.processors_in[i] = 1;
+	ccall_info.func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3,
+			ccall_info.arg4, ccall_info.arg5);
+	ccall_info.processors_out[i] = 1;
+}
+
+void leon_percpu_timer_interrupt(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	int cpu = smp_processor_id();
+
+	old_regs = set_irq_regs(regs);
+
+	leon_clear_profile_irq(cpu);
+
+	profile_tick(CPU_PROFILING);
+
+	if (!--prof_counter(cpu)) {
+		int user = user_mode(regs);
+
+		irq_enter();
+		update_process_times(user);
+		irq_exit();
+
+		prof_counter(cpu) = prof_multiplier(cpu);
+	}
+	set_irq_regs(old_regs);
+}
+
+static void __init smp_setup_percpu_timer(void)
+{
+	int cpu = smp_processor_id();
+
+	prof_counter(cpu) = prof_multiplier(cpu) = 1;
+}
+
+void __init leon_blackbox_id(unsigned *addr)
+{
+	int rd = *addr & 0x3e000000;
+	int rs1 = rd >> 11;
+
+	/* patch places where ___b_hard_smp_processor_id appears */
+	addr[0] = 0x81444000 | rd;	/* rd %asr17, reg */
+	addr[1] = 0x8130201c | rd | rs1;	/* srl reg, 0x1c, reg */
+	addr[2] = 0x01000000;	/* nop */
+}
+
+void __init leon_blackbox_current(unsigned *addr)
+{
+	int rd = *addr & 0x3e000000;
+	int rs1 = rd >> 11;
+
+	/* patch LOAD_CURRENT macro where ___b_load_current appears */
+	addr[0] = 0x81444000 | rd;	/* rd %asr17, reg */
+	addr[2] = 0x8130201c | rd | rs1;	/* srl reg, 0x1c, reg */
+	addr[4] = 0x81282002 | rd | rs1;	/* sll reg, 0x2, reg */
+
+}
+
+/*
+ * CPU idle callback function
+ * See .../arch/sparc/kernel/process.c
+ */
+void pmc_leon_idle(void)
+{
+	__asm__ volatile ("mov %g0, %asr19");
+}
+
+void __init leon_init_smp(void)
+{
+	/* Patch ipi15 trap table */
+	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_leon - linux_trap_ipi15_sun4m);
+
+	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, leon_blackbox_id);
+	BTFIXUPSET_BLACKBOX(load_current, leon_blackbox_current);
+	BTFIXUPSET_CALL(smp_cross_call, leon_cross_call, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__hard_smp_processor_id, __leon_processor_id,
+			BTFIXUPCALL_NORM);
+
+#ifndef PMC_NO_IDLE
+	/* Assign power management IDLE handler */
+	pm_idle = pmc_leon_idle;
+	printk(KERN_INFO "leon: power management initialized\n");
+#endif
+
+}
+
+#endif /* CONFIG_SPARC_LEON */
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 132d81f..91c10fb 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -32,6 +32,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/cpudata.h>
+#include <asm/leon.h>
 
 #include "irq.h"
 
@@ -96,6 +97,9 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	case sun4d:
 		smp4d_smp_done();
 		break;
+	case sparc_leon:
+		leon_smp_done();
+		break;
 	case sun4e:
 		printk("SUN4E\n");
 		BUG();
@@ -306,6 +310,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	case sun4d:
 		smp4d_boot_cpus();
 		break;
+	case sparc_leon:
+		leon_boot_cpus();
+		break;
 	case sun4e:
 		printk("SUN4E\n");
 		BUG();
@@ -376,6 +383,9 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	case sun4d:
 		ret = smp4d_boot_one_cpu(cpu);
 		break;
+	case sparc_leon:
+		ret = leon_boot_one_cpu(cpu);
+		break;
 	case sun4e:
 		printk("SUN4E\n");
 		BUG();
diff --git a/arch/sparc/kernel/trampoline_32.S b/arch/sparc/kernel/trampoline_32.S
index 5e235c5..691f484 100644
--- a/arch/sparc/kernel/trampoline_32.S
+++ b/arch/sparc/kernel/trampoline_32.S
@@ -15,7 +15,7 @@
 #include <asm/contregs.h>
 #include <asm/thread_info.h>
 
-	.globl sun4m_cpu_startup, __smp4m_processor_id
+	.globl sun4m_cpu_startup, __smp4m_processor_id, __leon_processor_id
 	.globl sun4d_cpu_startup, __smp4d_processor_id
 
 	__CPUINIT
@@ -106,6 +106,12 @@ __smp4d_processor_id:
 	retl
 	 mov	%g1, %o7
 
+__leon_processor_id:
+	rd     %asr17,%g2
+        srl    %g2,28,%g2
+	retl
+	 mov	%g1, %o7
+
 /* CPUID in bootbus can be found at PA 0xff0140000 */
 #define SUN4D_BOOTBUS_CPUID	0xf0140000
 
@@ -160,3 +166,64 @@ sun4d_cpu_startup:
 	 nop
 
 	b,a	smp_do_cpu_idle
+
+#ifdef CONFIG_SPARC_LEON
+
+	__CPUINIT
+	.align	4
+        .global leon_smp_cpu_startup, smp_penguin_ctable
+
+leon_smp_cpu_startup:
+
+        set smp_penguin_ctable,%g1
+        ld [%g1+4],%g1
+        srl %g1,4,%g1
+        set 0x00000100,%g5 /* SRMMU_CTXTBL_PTR */
+	sta %g1, [%g5] ASI_M_MMUREGS
+
+	/* Set up a sane %psr -- PIL<0xf> S<0x1> PS<0x1> CWP<0x0> */
+	set	(PSR_PIL | PSR_S | PSR_PS), %g1
+	wr	%g1, 0x0, %psr		! traps off though
+	WRITE_PAUSE
+
+	/* Our %wim is one behind CWP */
+	mov	2, %g1
+	wr	%g1, 0x0, %wim
+	WRITE_PAUSE
+
+	/* Set tbr - we use just one trap table. */
+	set	trapbase, %g1
+	wr	%g1, 0x0, %tbr
+	WRITE_PAUSE
+
+	/* Get our CPU id */
+        rd     %asr17,%g3
+
+	/* Give ourselves a stack and curptr. */
+	set	current_set, %g5
+	srl	%g3, 28, %g4
+	sll	%g4, 2, %g4
+	ld	[%g5 + %g4], %g6
+
+	sethi	%hi(THREAD_SIZE - STACKFRAME_SZ), %sp
+	or	%sp, %lo(THREAD_SIZE - STACKFRAME_SZ), %sp
+	add	%g6, %sp, %sp
+
+	/* Turn on traps (PSR_ET). */
+	rd	%psr, %g1
+	wr	%g1, PSR_ET, %psr	! traps on
+	WRITE_PAUSE
+
+	/* Init our caches, etc. */
+	set	poke_srmmu, %g5
+	ld	[%g5], %g5
+	call	%g5
+	 nop
+
+	/* Start this processor. */
+	call	leon_callin
+	 nop
+
+	b,a	smp_do_cpu_idle
+
+#endif
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 509b1ff..d55c255 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2301,7 +2301,8 @@ void __init ld_mmu_srmmu(void)
 	BTFIXUPSET_CALL(flush_cache_mm, smp_flush_cache_mm, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_range, smp_flush_cache_range, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_cache_page, smp_flush_cache_page, BTFIXUPCALL_NORM);
-	if (sparc_cpu_model != sun4d) {
+	if (sparc_cpu_model != sun4d &&
+	    sparc_cpu_model != sparc_leon) {
 		BTFIXUPSET_CALL(flush_tlb_all, smp_flush_tlb_all, BTFIXUPCALL_NORM);
 		BTFIXUPSET_CALL(flush_tlb_mm, smp_flush_tlb_mm, BTFIXUPCALL_NORM);
 		BTFIXUPSET_CALL(flush_tlb_range, smp_flush_tlb_range, BTFIXUPCALL_NORM);
@@ -2330,6 +2331,8 @@ void __init ld_mmu_srmmu(void)
 #ifdef CONFIG_SMP
 	if (sparc_cpu_model = sun4d)
 		sun4d_init_smp();
+	else if (sparc_cpu_model = sparc_leon)
+		leon_init_smp();
 	else
 		sun4m_init_smp();
 #endif
-- 
1.6.3.2

