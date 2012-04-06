From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Apr 2012 16:14:07 +0000
Subject: [PATCH 2/2 - v2] sparc32: generic clockevent support
Message-Id: <20120406161407.GA17310@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From aa76a8eb7aa0e5747adccaa8b8ba11a461a9baab Mon Sep 17 00:00:00 2001
From: Tkhai Kirill <tkhai@yandex.ru>
Date: Wed, 4 Apr 2012 21:49:26 +0200
Subject: [PATCH 2/2] sparc32: generic clockevent support

The kernel uses l14 timers as clockevents. l10 timer is used
as clocksource if platform master_l10_counter isn't constantly
zero. The clocksource is continuous, so it's possible to use
high resolution timers. l10 timer is also used as clockevent
on UP configurations.

This realization is for sun4m, sun4d, sun4c, microsparc-IIep
and LEON platforms. The appropriate LEON changes was made by
Konrad Eisele.

In case of sun4m's oneshot mode, profile irq is zeroed in
smp4m_percpu_timer_interrupt(). It is maybe
needless (double, triple etc overflow does nothing).

sun4d is able to have oneshot mode too, but I haven't
any way to test it. So code of its percpu timer handler
is made as much equal to the current code as possible.

The patch is tested on sun4m box in SMP mode by me,
and tested by Konrad on leon in up mode (leon smp
is broken atm - due to other reasons).

Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>
Tested-by: Konrad Eisele <konrad@gaisler.com> [leon up]
[sam: revised patch to provide generic support for leon]
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Fixed "From:" line - as Tkhai is the author of this.

	Sam


 arch/sparc/Kconfig                  |    7 +-
 arch/sparc/include/asm/cpudata_32.h |    1 -
 arch/sparc/include/asm/leon.h       |    2 +-
 arch/sparc/include/asm/timer_32.h   |   29 +++++
 arch/sparc/include/asm/timex_32.h   |    1 -
 arch/sparc/kernel/irq.h             |   19 +++-
 arch/sparc/kernel/kernel.h          |    2 -
 arch/sparc/kernel/leon_kernel.c     |   49 +++++++-
 arch/sparc/kernel/leon_smp.c        |   34 +-----
 arch/sparc/kernel/pcic.c            |   48 ++++----
 arch/sparc/kernel/smp_32.c          |   21 +----
 arch/sparc/kernel/sun4c_irq.c       |   11 ++-
 arch/sparc/kernel/sun4d_irq.c       |   18 +++-
 arch/sparc/kernel/sun4d_smp.c       |   34 ++----
 arch/sparc/kernel/sun4m_irq.c       |   22 +++-
 arch/sparc/kernel/sun4m_smp.c       |   38 ++----
 arch/sparc/kernel/time_32.c         |  215 ++++++++++++++++++++++++++++-------
 17 files changed, 362 insertions(+), 189 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6c0683d..db4e821 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -73,17 +73,12 @@ config BITS
 	default 32 if SPARC32
 	default 64 if SPARC64
 
-config ARCH_USES_GETTIMEOFFSET
-	bool
-	default y if SPARC32
-
 config GENERIC_CMOS_UPDATE
 	bool
 	default y
 
 config GENERIC_CLOCKEVENTS
-	bool
-	default y if SPARC64
+	def_bool y
 
 config IOMMU_HELPER
 	bool
diff --git a/arch/sparc/include/asm/cpudata_32.h b/arch/sparc/include/asm/cpudata_32.h
index a4c5a93..0300d94 100644
--- a/arch/sparc/include/asm/cpudata_32.h
+++ b/arch/sparc/include/asm/cpudata_32.h
@@ -14,7 +14,6 @@
 typedef struct {
 	unsigned long udelay_val;
 	unsigned long clock_tick;
-	unsigned int multiplier;
 	unsigned int counter;
 #ifdef CONFIG_SMP
 	unsigned int irq_resched_count;
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index a4e457f..cf35a26 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -323,7 +323,7 @@ extern void leon_update_virq_handling(unsigned int virq,
 			      const char *name, int do_ack);
 extern void leon_clear_clock_irq(void);
 extern void leon_load_profile_irq(int cpu, unsigned int limit);
-extern void leon_init_timers(irq_handler_t counter_fn);
+extern void leon_init_timers(void);
 extern void leon_clear_clock_irq(void);
 extern void leon_load_profile_irq(int cpu, unsigned int limit);
 extern void leon_trans_init(struct device_node *dp);
diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 1a91e11..e6e6667 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -8,11 +8,40 @@
 #ifndef _SPARC_TIMER_H
 #define _SPARC_TIMER_H
 
+#include <linux/clocksource.h>
+#include <linux/irqreturn.h>
+
+#include <asm-generic/percpu.h>
+
 #include <asm/cpu_type.h>  /* For SUN4M_NCPUS */
 #include <asm/btfixup.h>
 
+#define SBUS_CLOCK_RATE   2000000 /* 2MHz */
+#define TIMER_VALUE_SHIFT 9
+#define TIMER_VALUE_MASK  0x3fffff
+#define TIMER_LIMIT_BIT   (1 << 31)  /* Bit 31 in Counter-Timer register */
+
+/* The counter timer register has the value offset by 9 bits.
+ * From sun4m manual:
+ * When a counter reaches the value in the corresponding limit register,
+ * the Limit bit is set and the counter is set to 500 nS (i.e. 0x00000200).
+ *
+ * To compensate for this add one to the value.
+ */
+static inline unsigned int timer_value(unsigned int value)
+{
+	return (value + 1) << TIMER_VALUE_SHIFT;
+}
+
 extern __volatile__ unsigned int *master_l10_counter;
 
+extern irqreturn_t notrace timer_interrupt(int dummy, void *dev_id);
+
+#ifdef CONFIG_SMP
+DECLARE_PER_CPU(struct clock_event_device, sparc32_clockevent);
+extern void register_percpu_ce(int cpu);
+#endif
+
 /* FIXME: Make do_[gs]ettimeofday btfixup calls */
 struct timespec;
 BTFIXUPDEF_CALL(int, bus_do_settimeofday, struct timespec *tv)
diff --git a/arch/sparc/include/asm/timex_32.h b/arch/sparc/include/asm/timex_32.h
index a254750..b6ccdb0 100644
--- a/arch/sparc/include/asm/timex_32.h
+++ b/arch/sparc/include/asm/timex_32.h
@@ -12,5 +12,4 @@
 typedef unsigned long cycles_t;
 #define get_cycles()	(0)
 
-extern u32 (*do_arch_gettimeoffset)(void);
 #endif
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 3f6ca4d..8b946b1 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -41,15 +41,32 @@ struct sun4m_irq_global {
 extern struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 extern struct sun4m_irq_global __iomem *sun4m_irq_global;
 
+/* The following definitions describe the individual platform features: */
+#define FEAT_L10_CLOCKSOURCE (1 << 0) /* L10 timer is used as a clocksource */
+#define FEAT_L10_CLOCKEVENT  (1 << 1) /* L10 timer is used as a clockevent */
+#define FEAT_L14_ONESHOT     (1 << 2) /* L14 timer clockevent can oneshot */
+
 /*
  * Platform specific configuration
  * The individual platforms assign their platform
  * specifics in their init functions.
  */
 struct sparc_config {
-	void (*init_timers)(irq_handler_t);
+	void (*init_timers)(void);
 	unsigned int (*build_device_irq)(struct platform_device *op,
 	                                 unsigned int real_irq);
+
+	/* generic clockevent features - see FEAT_* above */
+	int features;
+
+	/* clock rate used for clock event timer */
+	int clock_rate;
+
+	/* one period for clock source timer */
+	unsigned int cs_period;
+
+	/* function to obtain offsett for cs period */
+	unsigned int (*get_cycles_offset)(void);
 };
 extern struct sparc_config sparc_config;
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index fd6c36b..8abbad3 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -47,8 +47,6 @@ extern void init_IRQ(void);
 extern void sun4c_init_IRQ(void);
 
 /* sun4m_irq.c */
-extern unsigned int lvl14_resolution;
-
 extern void sun4m_init_IRQ(void);
 extern void sun4m_unmask_profile_irq(void);
 extern void sun4m_clear_profile_irq(int cpu);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index a94122b..722650a 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -10,6 +10,8 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/oplib.h>
 #include <asm/timer.h>
@@ -250,7 +252,38 @@ void leon_update_virq_handling(unsigned int virq,
 	irq_set_chip_data(virq, (void *)mask);
 }
 
-void __init leon_init_timers(irq_handler_t counter_fn)
+static u32 leon_cycles_offset(void)
+{
+	u32 rld, val, off;
+	rld = LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].rld);
+	val = LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].val);
+	off = rld - val;
+	return rld - val;
+}
+
+#ifdef CONFIG_SMP
+
+/* smp clockevent irq */
+irqreturn_t leon_percpu_timer_ce_interrupt(int irq, void *unused)
+{
+	struct clock_event_device *ce;
+	int cpu = smp_processor_id();
+
+	leon_clear_profile_irq(cpu);
+
+	ce = &per_cpu(sparc32_clockevent, cpu);
+
+	irq_enter();
+	if (ce->event_handler)
+		ce->event_handler(ce);
+	irq_exit();
+
+	return IRQ_HANDLED;
+}
+
+#endif /* CONFIG_SMP */
+
+void __init leon_init_timers(void)
 {
 	int irq, eirq;
 	struct device_node *rootnp, *np, *nnp;
@@ -260,6 +293,14 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	int ampopts;
 	int err;
 
+	sparc_config.get_cycles_offset = leon_cycles_offset;
+	sparc_config.cs_period = 1000000 / HZ;
+	sparc_config.features |= FEAT_L10_CLOCKSOURCE;
+
+#ifndef CONFIG_SMP
+	sparc_config.features |= FEAT_L10_CLOCKEVENT;
+#endif
+
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
 	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
@@ -369,7 +410,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		leon_eirq_setup(eirq);
 
 	irq = _leon_build_device_irq(NULL, leon3_gptimer_irq+leon3_gptimer_idx);
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "unable to attach timer IRQ%d\n", irq);
 		prom_halt();
@@ -401,7 +442,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	/* Install per-cpu IRQ handler for broadcasted ticker */
 	irq = leon_build_device_irq(leon3_ticker_irq, handle_percpu_irq,
 				    "per-cpu", 0);
-	err = request_irq(irq, leon_percpu_timer_interrupt,
+	err = request_irq(irq, leon_percpu_timer_ce_interrupt,
 			  IRQF_PERCPU | IRQF_TIMER, "ticker",
 			  NULL);
 	if (err) {
@@ -428,7 +469,6 @@ void leon_clear_clock_irq(void)
 
 void leon_load_profile_irq(int cpu, unsigned int limit)
 {
-	BUG();
 }
 
 void __init leon_trans_init(struct device_node *dp)
@@ -496,6 +536,7 @@ void __init leon_init_IRQ(void)
 {
 	sparc_config.init_timers      = leon_init_timers;
 	sparc_config.build_device_irq = _leon_build_device_irq;
+	sparc_config.clock_rate = 1000000;
 
 	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq,
 			BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1210fde..6173f4d 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -23,6 +23,8 @@
 #include <linux/pm.h>
 #include <linux/delay.h>
 #include <linux/gfp.h>
+#include <linux/cpu.h>
+#include <linux/clockchips.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -42,6 +44,7 @@
 #include <asm/asi.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
+#include <asm/timer.h>
 
 #include "kernel.h"
 
@@ -68,8 +71,6 @@ static inline unsigned long do_swap(volatile unsigned long *ptr,
 	return val;
 }
 
-static void smp_setup_percpu_timer(void);
-
 void __cpuinit leon_callin(void)
 {
 	int cpuid = hard_smpleon_processor_id();
@@ -79,7 +80,7 @@ void __cpuinit leon_callin(void)
 	leon_configure_cache_smp();
 
 	/* Get our local ticker going. */
-	smp_setup_percpu_timer();
+	register_percpu_ce(cpuid);
 
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
@@ -196,7 +197,6 @@ void __init leon_boot_cpus(void)
 	leon_smp_setbroadcast(1 << LEON3_IRQ_TICKER);
 
 	leon_configure_cache_smp();
-	smp_setup_percpu_timer();
 	local_flush_cache_all();
 
 }
@@ -489,32 +489,6 @@ void leon_cross_call_irq(void)
 	ccall_info.processors_out[i] = 1;
 }
 
-irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused)
-{
-	int cpu = smp_processor_id();
-
-	leon_clear_profile_irq(cpu);
-
-	profile_tick(CPU_PROFILING);
-
-	if (!--prof_counter(cpu)) {
-		int user = user_mode(get_irq_regs());
-
-		update_process_times(user);
-
-		prof_counter(cpu) = prof_multiplier(cpu);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static void __init smp_setup_percpu_timer(void)
-{
-	int cpu = smp_processor_id();
-
-	prof_counter(cpu) = prof_multiplier(cpu) = 1;
-}
-
 void __init leon_blackbox_id(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 6edec80..118a3f5 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -703,31 +703,28 @@ static void pcic_clear_clock_irq(void)
 	pcic_timer_dummy = readl(pcic0.pcic_regs+PCI_SYS_LIMIT);
 }
 
-static irqreturn_t pcic_timer_handler (int irq, void *h)
+/* CPU frequency is 100 MHz, timer increments every 4 CPU clocks */
+#define USECS_PER_JIFFY  (1000000 / HZ)
+#define TICK_TIMER_LIMIT ((100 * 1000000 / 4) / HZ)
+
+static unsigned int pcic_cycles_offset(void)
 {
-	pcic_clear_clock_irq();
-	xtime_update(1);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(get_irq_regs()));
-#endif
-	return IRQ_HANDLED;
-}
+	u32 value, count;
 
-#define USECS_PER_JIFFY  10000  /* We have 100HZ "standard" timer for sparc */
-#define TICK_TIMER_LIMIT ((100*1000000/4)/100)
+	value = readl(pcic0.pcic_regs + PCI_SYS_COUNTER);
+	count = value & ~PCI_SYS_COUNTER_OVERFLOW;
 
-u32 pci_gettimeoffset(void)
-{
+	if (value & PCI_SYS_COUNTER_OVERFLOW)
+		count += TICK_TIMER_LIMIT;
 	/*
-	 * We divide all by 100
+	 * We divide all by HZ
 	 * to have microsecond resolution and to avoid overflow
 	 */
-	unsigned long count -	    readl(pcic0.pcic_regs+PCI_SYS_COUNTER) & ~PCI_SYS_COUNTER_OVERFLOW;
-	count = ((count/100)*USECS_PER_JIFFY) / (TICK_TIMER_LIMIT/100);
-	return count * 1000;
-}
+	count = ((count / HZ) * USECS_PER_JIFFY) / (TICK_TIMER_LIMIT / HZ);
 
+	/* Coordinate with the fact that timer_cs rate is 2MHz */
+	return count * 2;
+}
 
 void __init pci_time_init(void)
 {
@@ -736,9 +733,16 @@ void __init pci_time_init(void)
 	int timer_irq, irq;
 	int err;
 
-	do_arch_gettimeoffset = pci_gettimeoffset;
-
-	btfixup();
+#ifndef CONFIG_SMP
+	/*
+	 * It's in SBUS dimension, because timer_cs is in this dimension.
+	 * We take into account this in pcic_cycles_offset()
+	 */
+	timer_cs_period = SBUS_CLOCK_RATE / HZ;
+	sparc_config.features |= FEAT_L10_CLOCKEVENT;
+#endif
+	sparc_config.features |= FEAT_L10_CLOCKSOURCE;
+	sparc_config.get_cycles_offset = pcic_cycles_offset;
 
 	writel (TICK_TIMER_LIMIT, pcic->pcic_regs+PCI_SYS_LIMIT);
 	/* PROM should set appropriate irq */
@@ -747,7 +751,7 @@ void __init pci_time_init(void)
 	writel (PCI_COUNTER_IRQ_SET(timer_irq, 0),
 		pcic->pcic_regs+PCI_COUNTER_IRQ);
 	irq = pcic_build_device_irq(NULL, timer_irq);
-	err = request_irq(irq, pcic_timer_handler,
+	err = request_irq(irq, timer_interrupt,
 			  IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("time_init: unable to attach IRQ%d\n", timer_irq);
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index f671e7f..569a8a9 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -301,28 +301,9 @@ void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
 	local_flush_sig_insns(mm, insn_addr);
 }
 
-extern unsigned int lvl14_resolution;
-
-/* /proc/profile writes can call this, don't __init it please. */
-static DEFINE_SPINLOCK(prof_setup_lock);
-
 int setup_profiling_timer(unsigned int multiplier)
 {
-	int i;
-	unsigned long flags;
-
-	/* Prevent level14 ticker IRQ flooding. */
-	if((!multiplier) || (lvl14_resolution / multiplier) < 500)
-		return -EINVAL;
-
-	spin_lock_irqsave(&prof_setup_lock, flags);
-	for_each_possible_cpu(i) {
-		load_profile_irq(i, lvl14_resolution / multiplier);
-		prof_multiplier(i) = multiplier;
-	}
-	spin_unlock_irqrestore(&prof_setup_lock, flags);
-
-	return 0;
+	return -EINVAL;
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index d4e3c83..39c6421 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -174,7 +174,7 @@ static void sun4c_load_profile_irq(int cpu, unsigned int limit)
 	/* Errm.. not sure how to do this.. */
 }
 
-static void __init sun4c_init_timers(irq_handler_t counter_fn)
+static void __init sun4c_init_timers(void)
 {
 	const struct linux_prom_irqs *prom_irqs;
 	struct device_node *dp;
@@ -207,12 +207,16 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 	 * level 14 timer limit since we are letting the prom handle
 	 * them until we have a real console driver so L1-A works.
 	 */
-	sbus_writel((((1000000/HZ) + 1) << 10), &sun4c_timers->l10_limit);
+	sparc_config.cs_period = SBUS_CLOCK_RATE / HZ;
+	sparc_config.features |+	    FEAT_L10_CLOCKSOURCE | FEAT_L10_CLOCKEVENT;
+	sbus_writel(timer_value(sparc_config.cs_period),
+	            &sun4c_timers->l10_limit);
 
 	master_l10_counter = &sun4c_timers->l10_count;
 
 	irq = sun4c_build_device_irq(NULL, prom_irqs[0].pri);
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
@@ -253,6 +257,7 @@ void __init sun4c_init_IRQ(void)
 
 	sparc_config.init_timers      = sun4c_init_timers;
 	sparc_config.build_device_irq = sun4c_build_device_irq;
+	sparc_config.clock_rate       = SBUS_CLOCK_RATE;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 30119f6..abf5265 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -282,7 +282,8 @@ static void sun4d_clear_clock_irq(void)
 
 static void sun4d_load_profile_irq(int cpu, unsigned int limit)
 {
-	bw_set_prof_limit(cpu, limit);
+	unsigned int value = limit ? timer_value(limit) : 0;
+	bw_set_prof_limit(cpu, value);
 }
 
 static void __init sun4d_load_profile_irqs(void)
@@ -423,7 +424,7 @@ static void __init sun4d_fixup_trap_table(void)
 #endif
 }
 
-static void __init sun4d_init_timers(irq_handler_t counter_fn)
+static void __init sun4d_init_timers(void)
 {
 	struct device_node *dp;
 	struct resource res;
@@ -466,12 +467,20 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 		prom_halt();
 	}
 
-	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
+#ifdef CONFIG_SMP
+	sparc_config.cs_period = SBUS_CLOCK_RATE * 2;  /* 2 seconds */
+#else
+	sparc_config.cs_period = SBUS_CLOCK_RATE / HZ; /* 1/HZ sec  */
+	sparc_config.features |= FEAT_L10_CLOCKEVENT;
+#endif
+	sparc_config.features |= FEAT_L10_CLOCKSOURCE;
+	sbus_writel(timer_value(sparc_config.cs_period),
+		    &sun4d_timers->l10_timer_limit);
 
 	master_l10_counter = &sun4d_timers->l10_cur_count;
 
 	irq = sun4d_build_timer_irq(board, SUN4D_TIMER_IRQ);
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
 		             err);
@@ -514,6 +523,7 @@ void __init sun4d_init_IRQ(void)
 
 	sparc_config.init_timers      = sun4d_init_timers;
 	sparc_config.build_device_irq = sun4d_build_device_irq;
+	sparc_config.clock_rate       = SBUS_CLOCK_RATE;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 540b2fe..576fe74 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -6,16 +6,18 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 
+#include <asm/cacheflush.h>
+#include <asm/switch_to.h>
+#include <asm/tlbflush.h>
+#include <asm/timer.h>
 #include <asm/sbi.h>
 #include <asm/mmu.h>
-#include <asm/tlbflush.h>
-#include <asm/switch_to.h>
-#include <asm/cacheflush.h>
 
 #include "kernel.h"
 #include "irq.h"
@@ -34,7 +36,6 @@ static inline unsigned long sun4d_swap(volatile unsigned long *ptr, unsigned lon
 }
 
 static void smp4d_ipi_init(void);
-static void smp_setup_percpu_timer(void);
 
 static unsigned char cpu_leds[32];
 
@@ -70,7 +71,7 @@ void __cpuinit smp4d_callin(void)
 	 * to call the scheduler code.
 	 */
 	/* Get our local ticker going. */
-	smp_setup_percpu_timer();
+	register_percpu_ce(cpuid);
 
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
@@ -123,7 +124,6 @@ void __init smp4d_boot_cpus(void)
 	smp4d_ipi_init();
 	if (boot_cpu_id)
 		current_set[0] = NULL;
-	smp_setup_percpu_timer();
 	local_flush_cache_all();
 }
 
@@ -364,6 +364,7 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	int cpu = hard_smp4d_processor_id();
+	struct clock_event_device *ce;
 	static int cpu_tick[NR_CPUS];
 	static char led_mask[] = { 0xe, 0xd, 0xb, 0x7, 0xb, 0xd };
 
@@ -379,28 +380,15 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 		show_leds(cpu);
 	}
 
-	profile_tick(CPU_PROFILING);
-
-	if (!--prof_counter(cpu)) {
-		int user = user_mode(regs);
+	ce = &per_cpu(sparc32_clockevent, cpu);
 
-		irq_enter();
-		update_process_times(user);
-		irq_exit();
+	irq_enter();
+	ce->event_handler(ce);
+	irq_exit();
 
-		prof_counter(cpu) = prof_multiplier(cpu);
-	}
 	set_irq_regs(old_regs);
 }
 
-static void __cpuinit smp_setup_percpu_timer(void)
-{
-	int cpu = hard_smp4d_processor_id();
-
-	prof_counter(cpu) = prof_multiplier(cpu) = 1;
-	load_profile_irq(cpu, lvl14_resolution);
-}
-
 void __init smp4d_blackbox_id(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 0d3a2d8..87908a5 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -318,9 +318,6 @@ struct sun4m_timer_global {
 
 static struct sun4m_timer_global __iomem *timers_global;
 
-
-unsigned int lvl14_resolution = (((1000000/HZ) + 1) << 10);
-
 static void sun4m_clear_clock_irq(void)
 {
 	sbus_readl(&timers_global->l10_limit);
@@ -369,10 +366,11 @@ void sun4m_clear_profile_irq(int cpu)
 
 static void sun4m_load_profile_irq(int cpu, unsigned int limit)
 {
-	sbus_writel(limit, &timers_percpu[cpu]->l14_limit);
+	unsigned int value = limit ? timer_value(limit) : 0;
+	sbus_writel(value, &timers_percpu[cpu]->l14_limit);
 }
 
-static void __init sun4m_init_timers(irq_handler_t counter_fn)
+static void __init sun4m_init_timers(void)
 {
 	struct device_node *dp = of_find_node_by_name(NULL, "counter");
 	int i, err, len, num_cpu_timers;
@@ -402,13 +400,22 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 	/* Every per-cpu timer works in timer mode */
 	sbus_writel(0x00000000, &timers_global->timer_config);
 
-	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
+#ifdef CONFIG_SMP
+	sparc_config.cs_period = SBUS_CLOCK_RATE * 2;  /* 2 seconds */
+	sparc_config.features |= FEAT_L14_ONESHOT;
+#else
+	sparc_config.cs_period = SBUS_CLOCK_RATE / HZ; /* 1/HZ sec  */
+	sparc_config.features |= FEAT_L10_CLOCKEVENT;
+#endif
+	sparc_config.features |= FEAT_L10_CLOCKSOURCE;
+	sbus_writel(timer_value(sparc_config.cs_period),
+	            &timers_global->l10_limit);
 
 	master_l10_counter = &timers_global->l10_count;
 
 	irq = sun4m_build_device_irq(NULL, SUN4M_TIMER_IRQ);
 
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
 			err);
@@ -480,6 +487,7 @@ void __init sun4m_init_IRQ(void)
 
 	sparc_config.init_timers = sun4m_init_timers;
 	sparc_config.build_device_irq = sun4m_build_device_irq;
+	sparc_config.clock_rate       = SBUS_CLOCK_RATE;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 02db9a0..29f8ace 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -4,6 +4,7 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
@@ -12,6 +13,7 @@
 #include <asm/cacheflush.h>
 #include <asm/switch_to.h>
 #include <asm/tlbflush.h>
+#include <asm/timer.h>
 
 #include "irq.h"
 #include "kernel.h"
@@ -31,7 +33,6 @@ swap_ulong(volatile unsigned long *ptr, unsigned long val)
 }
 
 static void smp4m_ipi_init(void);
-static void smp_setup_percpu_timer(void);
 
 void __cpuinit smp4m_callin(void)
 {
@@ -42,8 +43,7 @@ void __cpuinit smp4m_callin(void)
 
 	notify_cpu_starting(cpuid);
 
-	/* Get our local ticker going. */
-	smp_setup_percpu_timer();
+	register_percpu_ce(cpuid);
 
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
@@ -87,7 +87,7 @@ void __cpuinit smp4m_callin(void)
 void __init smp4m_boot_cpus(void)
 {
 	smp4m_ipi_init();
-	smp_setup_percpu_timer();
+	sun4m_unmask_profile_irq();
 	local_flush_cache_all();
 }
 
@@ -260,37 +260,25 @@ void smp4m_cross_call_irq(void)
 void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
+	struct clock_event_device *ce;
 	int cpu = smp_processor_id();
 
 	old_regs = set_irq_regs(regs);
 
-	sun4m_clear_profile_irq(cpu);
+	ce = &per_cpu(sparc32_clockevent, cpu);
 
-	profile_tick(CPU_PROFILING);
+	if (ce->mode & CLOCK_EVT_MODE_PERIODIC)
+		sun4m_clear_profile_irq(cpu);
+	else
+		load_profile_irq(cpu, 0); /* Is this needless? */
 
-	if (!--prof_counter(cpu)) {
-		int user = user_mode(regs);
+	irq_enter();
+	ce->event_handler(ce);
+	irq_exit();
 
-		irq_enter();
-		update_process_times(user);
-		irq_exit();
-
-		prof_counter(cpu) = prof_multiplier(cpu);
-	}
 	set_irq_regs(old_regs);
 }
 
-static void __cpuinit smp_setup_percpu_timer(void)
-{
-	int cpu = smp_processor_id();
-
-	prof_counter(cpu) = prof_multiplier(cpu) = 1;
-	load_profile_irq(cpu, lvl14_resolution);
-
-	if (cpu = boot_cpu_id)
-		sun4m_unmask_profile_irq();
-}
-
 static void __init smp4m_blackbox_id(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 68e0284..89e890b 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -26,6 +26,8 @@
 #include <linux/rtc.h>
 #include <linux/rtc/m48t59.h>
 #include <linux/timex.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
@@ -44,9 +46,21 @@
 #include <asm/page.h>
 #include <asm/pcic.h>
 #include <asm/irq_regs.h>
+#include <asm/setup.h>
 
 #include "irq.h"
 
+static __cacheline_aligned_in_smp DEFINE_SEQLOCK(timer_cs_lock);
+static __volatile__ u64 timer_cs_internal_counter = 0;
+static char timer_cs_enabled = 0;
+
+static struct clock_event_device timer_ce;
+static char timer_ce_enabled = 0;
+
+#ifdef CONFIG_SMP
+DEFINE_PER_CPU(struct clock_event_device, sparc32_clockevent);
+#endif
+
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
@@ -75,36 +89,167 @@ EXPORT_SYMBOL(profile_pc);
 
 __volatile__ unsigned int *master_l10_counter;
 
-u32 (*do_arch_gettimeoffset)(void);
-
 int update_persistent_clock(struct timespec now)
 {
 	return set_rtc_mmss(now.tv_sec);
 }
 
-/*
- * timer_interrupt() needs to keep up the real-time clock,
- * as well as call the "xtime_update()" routine every clocktick
- */
+irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
+{
+	if (timer_cs_enabled) {
+		write_seqlock(&timer_cs_lock);
+		timer_cs_internal_counter++;
+		clear_clock_irq();
+		write_sequnlock(&timer_cs_lock);
+	} else {
+		clear_clock_irq();
+	}
 
-#define TICK_SIZE (tick_nsec / 1000)
+	if (timer_ce_enabled)
+		timer_ce.event_handler(&timer_ce);
 
-static irqreturn_t timer_interrupt(int dummy, void *dev_id)
+	return IRQ_HANDLED;
+}
+
+static void timer_ce_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
 {
-#ifndef CONFIG_SMP
-	profile_tick(CPU_PROFILING);
-#endif
+	switch (mode) {
+		case CLOCK_EVT_MODE_PERIODIC:
+		case CLOCK_EVT_MODE_RESUME:
+			timer_ce_enabled = 1;
+			break;
+		case CLOCK_EVT_MODE_SHUTDOWN:
+			timer_ce_enabled = 0;
+			break;
+		default:
+			break;
+	}
+	smp_mb();
+}
+
+static __init void setup_timer_ce(void)
+{
+	struct clock_event_device *ce = &timer_ce;
+
+	BUG_ON(smp_processor_id() != boot_cpu_id);
+
+	ce->name     = "timer_ce";
+	ce->rating   = 100;
+	ce->features = CLOCK_EVT_FEAT_PERIODIC;
+	ce->set_mode = timer_ce_set_mode;
+	ce->cpumask  = cpu_possible_mask;
+	ce->shift    = 32;
+	ce->mult     = div_sc(sparc_config.clock_rate, NSEC_PER_SEC,
+	                      ce->shift);
+	clockevents_register_device(ce);
+}
 
-	clear_clock_irq();
+static unsigned int sbus_cycles_offset(void)
+{
+	unsigned int val, offset;
 
-	xtime_update(1);
+	val = *master_l10_counter;
+	offset = (val >> TIMER_VALUE_SHIFT) & TIMER_VALUE_MASK;
 
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(get_irq_regs()));
-#endif
-	return IRQ_HANDLED;
+	/* Limit hit? */
+	if (val & TIMER_LIMIT_BIT)
+		offset += sparc_config.cs_period;
+
+	return offset;
 }
 
+static cycle_t timer_cs_read(struct clocksource *cs)
+{
+	unsigned int seq, offset;
+	u64 cycles;
+
+	do {
+		seq = read_seqbegin(&timer_cs_lock);
+
+		cycles = timer_cs_internal_counter;
+		offset = sparc_config.get_cycles_offset();
+	} while (read_seqretry(&timer_cs_lock, seq));
+
+	/* Count absolute cycles */
+	cycles *= sparc_config.cs_period;
+	cycles += offset;
+
+	return cycles;
+}
+
+static struct clocksource timer_cs = {
+	.name	= "timer_cs",
+	.rating	= 100,
+	.read	= timer_cs_read,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.shift	= 2,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static __init int setup_timer_cs(void)
+{
+	timer_cs_enabled = 1;
+	timer_cs.mult = clocksource_hz2mult(sparc_config.clock_rate,
+	                                    timer_cs.shift);
+
+	return clocksource_register(&timer_cs);
+}
+
+#ifdef CONFIG_SMP
+static void percpu_ce_setup(enum clock_event_mode mode,
+			struct clock_event_device *evt)
+{
+	int cpu = __first_cpu(evt->cpumask);
+
+	switch (mode) {
+		case CLOCK_EVT_MODE_PERIODIC:
+			load_profile_irq(cpu, SBUS_CLOCK_RATE / HZ);
+			break;
+		case CLOCK_EVT_MODE_ONESHOT:
+		case CLOCK_EVT_MODE_SHUTDOWN:
+		case CLOCK_EVT_MODE_UNUSED:
+			load_profile_irq(cpu, 0);
+			break;
+		default:
+			break;
+	}
+}
+
+static int percpu_ce_set_next_event(unsigned long delta,
+				    struct clock_event_device *evt)
+{
+	int cpu = __first_cpu(evt->cpumask);
+	unsigned int next = (unsigned int)delta;
+
+	load_profile_irq(cpu, next);
+	return 0;
+}
+
+void register_percpu_ce(int cpu)
+{
+	struct clock_event_device *ce = &per_cpu(sparc32_clockevent, cpu);
+	unsigned int features = CLOCK_EVT_FEAT_PERIODIC;
+
+	if (sparc_config.features & FEAT_L14_ONESHOT)
+		features |= CLOCK_EVT_FEAT_ONESHOT;
+
+	ce->name           = "percpu_ce";
+	ce->rating         = 200;
+	ce->features       = features;
+	ce->set_mode       = percpu_ce_setup;
+	ce->set_next_event = percpu_ce_set_next_event;
+	ce->cpumask        = cpumask_of(cpu);
+	ce->shift          = 32;
+	ce->mult           = div_sc(sparc_config.clock_rate, NSEC_PER_SEC,
+	                            ce->shift);
+	ce->max_delta_ns   = clockevent_delta2ns(sparc_config.clock_rate, ce);
+	ce->min_delta_ns   = clockevent_delta2ns(100, ce);
+
+	clockevents_register_device(ce);
+}
+#endif
+
 static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -195,38 +340,30 @@ static int __init clock_init(void)
  */
 fs_initcall(clock_init);
 
-
-u32 sbus_do_gettimeoffset(void)
+static void __init sparc32_late_time_init(void)
 {
-	unsigned long val = *master_l10_counter;
-	unsigned long usec = (val >> 10) & 0x1fffff;
-
-	/* Limit hit?  */
-	if (val & 0x80000000)
-		usec += 1000000 / HZ;
-
-	return usec * 1000;
+	if (sparc_config.features & FEAT_L10_CLOCKEVENT)
+		setup_timer_ce();
+	if (sparc_config.features & FEAT_L10_CLOCKSOURCE)
+		setup_timer_cs();
+#ifdef CONFIG_SMP
+	register_percpu_ce(smp_processor_id());
+#endif
 }
 
-
-u32 arch_gettimeoffset(void)
+static void __init sbus_time_init(void)
 {
-	if (unlikely(!do_arch_gettimeoffset))
-		return 0;
-	return do_arch_gettimeoffset();
+	sparc_config.get_cycles_offset = sbus_cycles_offset;
+	sparc_config.init_timers();
 }
 
-static void __init sbus_time_init(void)
+void __init time_init(void)
 {
-	do_arch_gettimeoffset = sbus_do_gettimeoffset;
-
 	btfixup();
 
-	sparc_config.init_timers(timer_interrupt);
-}
+	sparc_config.features = 0;
+	late_time_init = sparc32_late_time_init;
 
-void __init time_init(void)
-{
 	if (pcic_present())
 		pci_time_init();
 	else
-- 
1.6.0.6

