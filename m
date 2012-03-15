From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 15 Mar 2012 10:33:39 +0000
Subject: [PATCH 1/1] sparc32,leon: GENERIC_CLOCKEVENTS support for SPARC-LEON
Message-Id: <1331807619-9575-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add GENERIC_CLOCKEVENTS support for SPARC-LEON.

The late_time_init initialization has been moved to
enable overriding it for SPARC-LEON.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h   |    3 +-
 arch/sparc/kernel/leon_kernel.c |  189 ++++++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/leon_smp.c    |   34 +------
 arch/sparc/kernel/time_32.c     |    4 +-
 4 files changed, 193 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index a4e457f..9b9b24f 100644
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
@@ -351,6 +351,7 @@ extern void init_IRQ(void);
 extern void cpu_panic(void);
 extern int __leon_processor_id(void);
 void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
+extern void leon_register_percpu_ce(int cpu);
 extern irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused);
 
 extern unsigned int real_irq_entry[];
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index a19c8a0..62afe3f 100644
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
@@ -27,12 +29,18 @@
 struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address */
 struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address */
 
+static __cacheline_aligned_in_smp DEFINE_SEQLOCK(leon_timer_cs_lock);
+static __volatile__ u64 leon_timer_cs_internal_counter = 0;
 int leondebug_irq_disable;
 int leon_debug_irqout;
 static int dummy_master_l10_counter;
 unsigned long amba_system_id;
 static DEFINE_SPINLOCK(leon_irq_lock);
 
+static char leon_timer_cs_enabled = 0;
+#ifndef CONFIG_SMP
+static char leon_timer_ce_enabled = 0;
+#endif
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
 int leon3_ticker_irq; /* Timer ticker IRQ */
@@ -250,7 +258,177 @@ void leon_update_virq_handling(unsigned int virq,
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
+static cycle_t leon_timer_cs_read(struct clocksource *cs)
+{
+	unsigned int seq, offset;
+	u64 cycles;
+
+	do {
+		seq = read_seqbegin(&leon_timer_cs_lock);
+		cycles = leon_timer_cs_internal_counter;
+		offset = leon_cycles_offset();
+	} while (read_seqretry(&leon_timer_cs_lock, seq));
+
+	cycles *= timer_cs_period;
+	cycles += offset;
+	return cycles;
+}
+
+static struct clocksource leon_timer_cs = {
+	.name	= "grtimer-cs",
+	.rating	= 200,
+	.read	= leon_timer_cs_read,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+#ifndef CONFIG_SMP
+
+static void leon_timer_ce_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	switch (mode) {
+		case CLOCK_EVT_MODE_PERIODIC:
+		case CLOCK_EVT_MODE_RESUME:
+			leon_timer_ce_enabled = 1;
+			break;
+		case CLOCK_EVT_MODE_SHUTDOWN:
+			leon_timer_ce_enabled = 0;
+			break;
+		default:
+			break;
+	}
+	smp_mb();
+}
+
+static struct clock_event_device leon_timer_ce = {
+	.name	  = "grtimer-ce",
+	.rating	  = 100,
+	.features = CLOCK_EVT_FEAT_PERIODIC,
+	.set_mode = leon_timer_ce_set_mode,
+	.shift    = 32
+};
+
+#endif /* !CONFIG_SMP */
+
+static void __init leon_late_time_init(void)
+{
+	leon_timer_cs_enabled = 1;
+
+	clocksource_register_hz(&leon_timer_cs, 1000000);
+
+#ifdef CONFIG_SMP
+	leon_register_percpu_ce(smp_processor_id());
+#else
+	BUG_ON(smp_processor_id() != boot_cpu_id);
+	leon_timer_ce.cpumask = cpu_possible_mask;
+	leon_timer_ce.mult    = div_sc(1000000, NSEC_PER_SEC,
+				       leon_timer_ce.shift);
+	clockevents_register_device(&leon_timer_ce);
+#endif /* CONFIG_SMP */
+}
+
+/* clocksource irq, non-smp clockevent */
+irqreturn_t notrace leon_timer_interrupt(int dummy, void *dev_id)
+{
+	if (leon_timer_cs_enabled) {
+		write_seqlock(&leon_timer_cs_lock);
+		leon_timer_cs_internal_counter++;
+		write_sequnlock(&leon_timer_cs_lock);
+	}
+#ifndef CONFIG_SMP
+	if (leon_timer_ce_enabled) {
+		if (leon_timer_ce.event_handler)
+			leon_timer_ce.event_handler(&leon_timer_ce);
+	}
+	
+#endif
+	return IRQ_HANDLED;
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
+static void leon_percpu_ce_setup(enum clock_event_mode mode,
+			struct clock_event_device *evt)
+{
+	int cpu = __first_cpu(evt->cpumask);
+
+	switch (mode) {
+		case CLOCK_EVT_MODE_PERIODIC:
+			leon_load_profile_irq(cpu, (1000000 / HZ));
+			break;
+		case CLOCK_EVT_MODE_ONESHOT:
+		case CLOCK_EVT_MODE_SHUTDOWN:
+		case CLOCK_EVT_MODE_UNUSED:
+			leon_load_profile_irq(cpu, 0);
+			break;
+		default:
+			break;
+	}
+}
+
+static int leon_percpu_ce_set_next_event(unsigned long delta,
+				    struct clock_event_device *evt)
+{
+	int cpu = __first_cpu(evt->cpumask);
+	unsigned int next = (unsigned int)delta;
+	leon_load_profile_irq(cpu, next);
+	return 0;
+}
+
+void leon_register_percpu_ce(int cpu)
+{
+	struct clock_event_device *ce = &per_cpu(sparc32_clockevent, cpu);
+	unsigned int features = CLOCK_EVT_FEAT_PERIODIC;
+
+	if (sparc_irq_config.features & FEAT_L14_OS)
+		features |= CLOCK_EVT_FEAT_ONESHOT;
+
+	ce->name		= "grtimer-ce";
+	ce->rating		= 200;
+	ce->features		= features;
+	ce->set_mode		= leon_percpu_ce_setup;
+	ce->set_next_event	= leon_percpu_ce_set_next_event;
+	ce->cpumask		= cpumask_of(cpu);
+	ce->shift		= 32;
+	ce->mult		= div_sc(1000000, NSEC_PER_SEC,
+					 ce->shift);
+	ce->max_delta_ns	= clockevent_delta2ns(1000000, ce);
+	ce->min_delta_ns	= clockevent_delta2ns(100, ce);
+
+	clockevents_register_device(ce);
+}
+
+#endif /* CONFIG_SMP */
+
+void __init leon_init_timers(void)
 {
 	int irq, eirq;
 	struct device_node *rootnp, *np, *nnp;
@@ -260,6 +438,10 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	int ampopts;
 	int err;
 
+	late_time_init = leon_late_time_init;
+	get_cycles_offset = leon_cycles_offset;
+	timer_cs_period = 1000000 / HZ;
+
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
 	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
@@ -369,7 +551,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		leon_eirq_setup(eirq);
 
 	irq = _leon_build_device_irq(NULL, leon3_gptimer_irq+leon3_gptimer_idx);
-	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err = request_irq(irq, leon_timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "unable to attach timer IRQ%d\n", irq);
 		prom_halt();
@@ -401,7 +583,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	/* Install per-cpu IRQ handler for broadcasted ticker */
 	irq = leon_build_device_irq(leon3_ticker_irq, handle_percpu_irq,
 				    "per-cpu", 0);
-	err = request_irq(irq, leon_percpu_timer_interrupt,
+	err = request_irq(irq, leon_percpu_timer_ce_interrupt,
 			  IRQF_PERCPU | IRQF_TIMER, "ticker",
 			  NULL);
 	if (err) {
@@ -428,7 +610,6 @@ void leon_clear_clock_irq(void)
 
 void leon_load_profile_irq(int cpu, unsigned int limit)
 {
-	BUG();
 }
 
 void __init leon_trans_init(struct device_node *dp)
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1210fde..0bda9b1 100644
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
+	leon_register_percpu_ce(cpuid);
 
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
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index fc66bff..7427a49 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -367,12 +367,12 @@ void __init time_init(void)
 
 	sparc_irq_config.features = 0;
 
+	late_time_init = sparc32_late_time_init;
+
 	if (pcic_present())
 		pci_time_init();
 	else
 		sbus_time_init();
-
-	late_time_init = sparc32_late_time_init;
 }
 
 
-- 
1.6.1.3

