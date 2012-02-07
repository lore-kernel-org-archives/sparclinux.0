From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 07 Feb 2012 22:09:36 +0000
Subject: [PATCH]sparc32: GENERIC_CLOCKEVENTS support
Message-Id: <1328652576.12417.3.camel@hp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch implements GENERIC_CLOCKEVENTS support on sparc32.

The kernel uses l14 timers as clockevents. l10 timer is used
as clocksource if platform master_l10_counter isn't constantly
zero. The clocksource is continuous, so it's possible to use
high resolution timers. l10 timer is also used as clockevent
on UP configurations.

This realization is for sun4m, sun4d, sun4c and microsparc-IIep
platforms. It's necessary to make appropriate changes for LEON
part (it should not have l10 based cs and ce in case of SMP
because of LEON's master_l10_counter is zero).

Thanks to Sam Ravnborg for the review and comments.


Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>

---
 arch/sparc/Kconfig                  |    6 +-
 arch/sparc/include/asm/cpudata_32.h |    1 -
 arch/sparc/include/asm/timer_32.h   |   14 +++
 arch/sparc/include/asm/timex_32.h   |    1 -
 arch/sparc/kernel/irq.h             |    8 +-
 arch/sparc/kernel/kernel.h          |    2 -
 arch/sparc/kernel/pcic.c            |   50 +++++----
 arch/sparc/kernel/smp_32.c          |   21 +---
 arch/sparc/kernel/sun4c_irq.c       |    8 +-
 arch/sparc/kernel/sun4d_irq.c       |   16 ++-
 arch/sparc/kernel/sun4d_smp.c       |   28 ++---
 arch/sparc/kernel/sun4m_irq.c       |   20 ++-
 arch/sparc/kernel/sun4m_smp.c       |   38 ++----
 arch/sparc/kernel/time_32.c         |  219 ++++++++++++++++++++++++++++------
 14 files changed, 281 insertions(+), 151 deletions(-)
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 868ea08..4225559 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -70,17 +70,13 @@ config BITS
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
 	bool
-	default y if SPARC64
+	default y
 
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
diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 2ec030e..3a5c24b 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -8,10 +8,24 @@
 #ifndef _SPARC_TIMER_H
 #define _SPARC_TIMER_H
 
+#include <linux/irqreturn.h>
+#include <linux/clocksource.h>
+#include <asm-generic/percpu.h>
 #include <asm/system.h>  /* For SUN4M_NCPUS */
 #include <asm/btfixup.h>
 
+#define SBUS_CLOCK_RATE	2000000 /* 2MHz */
+
 extern __volatile__ unsigned int *master_l10_counter;
+extern unsigned int (*get_cycles_offset)(void);
+extern unsigned int timer_cs_period;
+
+extern irqreturn_t notrace timer_interrupt(int dummy, void *dev_id);
+
+#ifdef CONFIG_SMP
+DECLARE_PER_CPU(struct clock_event_device, sparc32_clockevent);
+extern void register_percpu_ce(int cpu);
+#endif
 
 /* FIXME: Make do_[gs]ettimeofday btfixup calls */
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
index 4285112..cbfba9f 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -40,15 +40,21 @@ struct sun4m_irq_global {
 extern struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 extern struct sun4m_irq_global __iomem *sun4m_irq_global;
 
+/* The following definitions describe the individual platform features:   */
+#define FEAT_L10_CS	(1 << 0) /* L10 timer is used as a clocksource    */
+#define FEAT_L10_CE	(1 << 1) /* L10 timer is used as a clockevent     */
+#define FEAT_L14_OS	(1 << 2) /* L14 timer clockevent can oneshot mode */
+
 /*
  * Platform specific irq configuration
  * The individual platforms assign their platform
  * specifics in their init functions.
  */
 struct sparc_irq_config {
-	void (*init_timers)(irq_handler_t);
+	void (*init_timers)(void);
 	unsigned int (*build_device_irq)(struct platform_device *op,
 	                                 unsigned int real_irq);
+	unsigned int features;
 };
 extern struct sparc_irq_config sparc_irq_config;
 
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
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index fcc148e..090f6af 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -703,31 +703,28 @@ static void pcic_clear_clock_irq(void)
 	pcic_timer_dummy = readl(pcic0.pcic_regs+PCI_SYS_LIMIT);
 }
 
-static irqreturn_t pcic_timer_handler (int irq, void *h)
-{
-	pcic_clear_clock_irq();
-	xtime_update(1);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(get_irq_regs()));
-#endif
-	return IRQ_HANDLED;
-}
+/* CPU frequency is 100 MHz, timer increments every 4 CPU clocks */
+#define USECS_PER_JIFFY  (1000000 / HZ)
+#define TICK_TIMER_LIMIT ((100 * 1000000 / 4) / HZ)
 
-#define USECS_PER_JIFFY  10000  /* We have 100HZ "standard" timer for sparc */
-#define TICK_TIMER_LIMIT ((100*1000000/4)/100)
-
-u32 pci_gettimeoffset(void)
+static u32 pcic_cycles_offset(void)
 {
+	u32 value, count;
+	       
+	value = readl(pcic0.pcic_regs + PCI_SYS_COUNTER);
+	count = value & ~PCI_SYS_COUNTER_OVERFLOW;
+
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
+	sparc_irq_config.features |= FEAT_L10_CE;
+#endif
+	sparc_irq_config.features |= FEAT_L10_CS;
+	get_cycles_offset = pcic_cycles_offset;
 
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
index f6bf25a..caaa7b9 100644
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
@@ -207,12 +207,14 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 	 * level 14 timer limit since we are letting the prom handle
 	 * them until we have a real console driver so L1-A works.
 	 */
-	sbus_writel((((1000000/HZ) + 1) << 10), &sun4c_timers->l10_limit);
+	timer_cs_period = SBUS_CLOCK_RATE / HZ;
+	sparc_irq_config.features |= (FEAT_L10_CS | FEAT_L10_CE);
+	sbus_writel(((timer_cs_period + 1) << 9), &sun4c_timers->l10_limit);
 
 	master_l10_counter = &sun4c_timers->l10_count;
 
 	irq = sun4c_build_device_irq(NULL, prom_irqs[0].pri);
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 1d13c5b..7fb9437 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -282,7 +282,8 @@ static void sun4d_clear_clock_irq(void)
 
 static void sun4d_load_profile_irq(int cpu, unsigned int limit)
 {
-	bw_set_prof_limit(cpu, limit);
+	unsigned int value = limit ? (limit + 1) << 9 : 0;
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
@@ -466,12 +467,19 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 		prom_halt();
 	}
 
-	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
+#ifdef CONFIG_SMP
+	timer_cs_period = SBUS_CLOCK_RATE * 2;  /* 2 seconds */
+#else
+	timer_cs_period = SBUS_CLOCK_RATE / HZ; /* 1/HZ sec  */
+	sparc_irq_config.features |= FEAT_L10_CE;
+#endif
+	sparc_irq_config.features |= FEAT_L10_CS;
+	sbus_writel(((timer_cs_period + 1) << 9), &sun4d_timers->l10_timer_limit);
 
 	master_l10_counter = &sun4d_timers->l10_cur_count;
 
 	irq = sun4d_build_timer_irq(board, SUN4D_TIMER_IRQ);
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
 		             err);
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 1333879..b0b92e7 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -10,11 +10,13 @@
 #include <linux/profile.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/clockchips.h>
 
 #include <asm/sbi.h>
 #include <asm/mmu.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
+#include <asm/timer.h>
 
 #include "kernel.h"
 #include "irq.h"
@@ -33,7 +35,6 @@ static inline unsigned long sun4d_swap(volatile unsigned long *ptr, unsigned lon
 }
 
 static void smp4d_ipi_init(void);
-static void smp_setup_percpu_timer(void);
 
 static unsigned char cpu_leds[32];
 
@@ -69,7 +70,7 @@ void __cpuinit smp4d_callin(void)
 	 * to call the scheduler code.
 	 */
 	/* Get our local ticker going. */
-	smp_setup_percpu_timer();
+	register_percpu_ce(cpuid);
 
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
@@ -122,7 +123,6 @@ void __init smp4d_boot_cpus(void)
 	smp4d_ipi_init();
 	if (boot_cpu_id)
 		current_set[0] = NULL;
-	smp_setup_percpu_timer();
 	local_flush_cache_all();
 }
 
@@ -363,6 +363,7 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	int cpu = hard_smp4d_processor_id();
+	struct clock_event_device *ce;
 	static int cpu_tick[NR_CPUS];
 	static char led_mask[] = { 0xe, 0xd, 0xb, 0x7, 0xb, 0xd };
 
@@ -378,28 +379,15 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 		show_leds(cpu);
 	}
 
-	profile_tick(CPU_PROFILING);
+	ce = &per_cpu(sparc32_clockevent, cpu);
 
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
index e611651..0f8f3b6 100644
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
+	unsigned int value = limit ? (limit + 1) << 9 : 0;
+	sbus_writel(value, &timers_percpu[cpu]->l14_limit);
 }
 
-static void __init sun4m_init_timers(irq_handler_t counter_fn)
+static void __init sun4m_init_timers(void)
 {
 	struct device_node *dp = of_find_node_by_name(NULL, "counter");
 	int i, err, len, num_cpu_timers;
@@ -402,13 +400,21 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 	/* Every per-cpu timer works in timer mode */
 	sbus_writel(0x00000000, &timers_global->timer_config);
 
-	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
+#ifdef CONFIG_SMP
+	timer_cs_period = SBUS_CLOCK_RATE * 2;  /* 2 seconds */
+	sparc_irq_config.features |= FEAT_L14_OS;
+#else
+	timer_cs_period = SBUS_CLOCK_RATE / HZ; /* 1/HZ sec  */
+	sparc_irq_config.features |= FEAT_L10_CE;
+#endif
+	sparc_irq_config.features |= FEAT_L10_CS;
+	sbus_writel(((timer_cs_period + 1) << 9), &timers_global->l10_limit);
 
 	master_l10_counter = &timers_global->l10_count;
 
 	irq = sun4m_build_device_irq(NULL, SUN4M_TIMER_IRQ);
 
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
 			err);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 5947686..7447729 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -8,9 +8,11 @@
 #include <linux/profile.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/clockchips.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/timer.h>
 
 #include "irq.h"
 #include "kernel.h"
@@ -30,7 +32,6 @@ swap_ulong(volatile unsigned long *ptr, unsigned long val)
 }
 
 static void smp4m_ipi_init(void);
-static void smp_setup_percpu_timer(void);
 
 void __cpuinit smp4m_callin(void)
 {
@@ -41,8 +42,7 @@ void __cpuinit smp4m_callin(void)
 
 	notify_cpu_starting(cpuid);
 
-	/* Get our local ticker going. */
-	smp_setup_percpu_timer();
+	register_percpu_ce(cpuid);
 
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
@@ -86,7 +86,7 @@ void __cpuinit smp4m_callin(void)
 void __init smp4m_boot_cpus(void)
 {
 	smp4m_ipi_init();
-	smp_setup_percpu_timer();
+	sun4m_unmask_profile_irq();
 	local_flush_cache_all();
 }
 
@@ -259,37 +259,25 @@ void smp4m_cross_call_irq(void)
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
index 1060e06..fc66bff 100644
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
@@ -45,9 +47,24 @@
 #include <asm/page.h>
 #include <asm/pcic.h>
 #include <asm/irq_regs.h>
+#include <asm/setup.h>
 
 #include "irq.h"
 
+static __cacheline_aligned_in_smp DEFINE_SEQLOCK(timer_cs_lock);
+static __volatile__ u64 timer_cs_internal_counter = 0;
+/* Tick period in cycles */
+unsigned int timer_cs_period;
+static char timer_cs_enabled = 0;
+u32 (*get_cycles_offset)(void);
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
 
@@ -76,36 +93,166 @@ EXPORT_SYMBOL(profile_pc);
 
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
+	} else
+		clear_clock_irq();
 
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
+	ce->name		= "l10_ce";
+	ce->rating		= 100;
+	ce->features		= CLOCK_EVT_FEAT_PERIODIC;
+	ce->set_mode		= timer_ce_set_mode;
+	ce->cpumask		= cpu_possible_mask;
+	ce->shift		= 32;
+	ce->mult		= div_sc(SBUS_CLOCK_RATE, NSEC_PER_SEC,
+					 ce->shift);
+	clockevents_register_device(ce);
+}
 
-	clear_clock_irq();
+static u32 sbus_cycles_offset(void)
+{
+	unsigned int val, offset;
 
-	xtime_update(1);
+	val = *master_l10_counter;
+	offset = (val >> 9) & 0x3fffff;
 
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(get_irq_regs()));
-#endif
-	return IRQ_HANDLED;
+	/* Limit hit? */
+	if (val & 0x80000000)
+		offset += timer_cs_period;
+
+	return offset;
+}
+
+static cycle_t timer_cs_read(struct clocksource *cs)
+{
+	unsigned int seq, offset;
+	u64 cycles;
+
+	do {
+		seq = read_seqbegin(&timer_cs_lock);
+
+		cycles = timer_cs_internal_counter;
+		offset = get_cycles_offset();
+	} while (read_seqretry(&timer_cs_lock, seq));
+
+	/* Count absolute cycles */
+	cycles *= timer_cs_period;
+	cycles += offset;
+
+	return cycles;
 }
 
+static struct clocksource timer_cs = {
+	.name	= "l10_cs",
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
+	/* Clock rate is 2MHz */
+	timer_cs.mult = clocksource_hz2mult(SBUS_CLOCK_RATE, timer_cs.shift);
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
+			load_profile_irq(cpu, SBUS_CLOCK_RATE/HZ);
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
+	if (sparc_irq_config.features & FEAT_L14_OS)
+		features |= CLOCK_EVT_FEAT_ONESHOT;
+
+	ce->name		= "l14_ce";
+	ce->rating		= 200;
+	ce->features		= features;
+	ce->set_mode		= percpu_ce_setup;
+	ce->set_next_event	= percpu_ce_set_next_event;
+	ce->cpumask		= cpumask_of(cpu);
+	ce->shift		= 32;
+	ce->mult		= div_sc(SBUS_CLOCK_RATE, NSEC_PER_SEC,
+					 ce->shift);
+	ce->max_delta_ns	= clockevent_delta2ns(SBUS_CLOCK_RATE, ce);
+	ce->min_delta_ns	= clockevent_delta2ns(100, ce);
+
+	clockevents_register_device(ce);
+}
+#endif
+
 static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -196,42 +343,36 @@ static int __init clock_init(void)
  */
 fs_initcall(clock_init);
 
-
-u32 sbus_do_gettimeoffset(void)
-{
-	unsigned long val = *master_l10_counter;
-	unsigned long usec = (val >> 10) & 0x1fffff;
-
-	/* Limit hit?  */
-	if (val & 0x80000000)
-		usec += 1000000 / HZ;
-
-	return usec * 1000;
-}
-
-
-u32 arch_gettimeoffset(void)
+static void __init sparc32_late_time_init(void)
 {
-	if (unlikely(!do_arch_gettimeoffset))
-		return 0;
-	return do_arch_gettimeoffset();
+	if (sparc_irq_config.features & FEAT_L10_CE)
+		setup_timer_ce();
+	if (sparc_irq_config.features & FEAT_L10_CS)
+		setup_timer_cs();
+#ifdef CONFIG_SMP
+	register_percpu_ce(smp_processor_id());
+#endif
 }
 
 static void __init sbus_time_init(void)
 {
-	do_arch_gettimeoffset = sbus_do_gettimeoffset;
-
-	btfixup();
+	get_cycles_offset = sbus_cycles_offset;
 
-	sparc_irq_config.init_timers(timer_interrupt);
+	sparc_irq_config.init_timers();
 }
 
 void __init time_init(void)
 {
+	btfixup();
+
+	sparc_irq_config.features = 0;
+
 	if (pcic_present())
 		pci_time_init();
 	else
 		sbus_time_init();
+
+	late_time_init = sparc32_late_time_init;
 }
 
 


