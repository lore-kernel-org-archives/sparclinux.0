From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Dec 2020 18:43:47 +0000
Subject: [PATCH v1 13/13] sparc32: drop use of sparc_config
Message-Id: <20201218184347.2180772-14-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o

sparc_config were used to handle the differences between the machines.
With only LEON supported sparc_config is no longer required.

This has the added benefit that we get rid of a rw variable
with several function pointers thus reducing our attack surface.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/timer_32.h |   1 +
 arch/sparc/kernel/irq.h           |  32 ++-------
 arch/sparc/kernel/irq_32.c        |   3 -
 arch/sparc/kernel/leon_kernel.c   |  27 ++------
 arch/sparc/kernel/of_device_32.c  |   4 +-
 arch/sparc/kernel/time_32.c       | 110 +++++++++++++-----------------
 6 files changed, 61 insertions(+), 116 deletions(-)

diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index eecd2696922d..1cd89a99966f 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -17,6 +17,7 @@
 #include <asm/cpu_type.h>  /* For SUN4M_NCPUS */
 
 #define SBUS_CLOCK_RATE   2000000 /* 2MHz */
+#define LEON_CLOCK_RATE   1000000
 #define TIMER_VALUE_SHIFT 9
 #define TIMER_VALUE_MASK  0x3fffff
 #define TIMER_LIMIT_BIT   (1 << 31)  /* Bit 31 in Counter-Timer register */
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 0d9b740725b4..ba0db1e4df6f 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -49,33 +49,6 @@ extern struct sun4m_irq_global __iomem *sun4m_irq_global;
 #define FEAT_L10_CLOCKEVENT  (1 << 1) /* L10 timer is used as a clockevent */
 #define FEAT_L14_ONESHOT     (1 << 2) /* L14 timer clockevent can oneshot */
 
-/*
- * Platform specific configuration
- * The individual platforms assign their platform
- * specifics in their init functions.
- */
-struct sparc_config {
-	void (*init_timers)(void);
-	unsigned int (*build_device_irq)(struct platform_device *op,
-	                                 unsigned int real_irq);
-
-	/* generic clockevent features - see FEAT_* above */
-	int features;
-
-	/* clock rate used for clock event timer */
-	int clock_rate;
-
-	/* one period for clock source timer */
-	unsigned int cs_period;
-
-	/* function to obtain offsett for cs period */
-	unsigned int (*get_cycles_offset)(void);
-
-	void (*clear_clock_irq)(void);
-	void (*load_profile_irq)(int cpu, unsigned int limit);
-};
-extern struct sparc_config sparc_config;
-
 unsigned int irq_alloc(unsigned int real_irq, unsigned int pil);
 void irq_link(unsigned int irq);
 void irq_unlink(unsigned int irq);
@@ -89,6 +62,11 @@ void sun4m_nmi(struct pt_regs *regs);
 /* sun4d_irq.c */
 void sun4d_handler_irq(unsigned int pil, struct pt_regs *regs);
 
+/* leon_kernel.c */
+void leon_clear_clock_irq(void);
+void leon_load_profile_irq(int cpu, unsigned int limit);
+u32 leon_cycles_offset(void);
+
 #ifdef CONFIG_SMP
 
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index a6af08fce796..f76f57073323 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -24,9 +24,6 @@
 #include "kernel.h"
 #include "irq.h"
 
-/* platform specific irq setup */
-struct sparc_config sparc_config;
-
 unsigned long arch_local_irq_save(void)
 {
 	unsigned long retval;
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 49b37a0dcc2b..491dff89f52c 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -239,12 +239,6 @@ unsigned int leon_build_device_irq(unsigned int real_irq,
 	return irq;
 }
 
-static unsigned int _leon_build_device_irq(struct platform_device *op,
-					   unsigned int real_irq)
-{
-	return leon_build_device_irq(real_irq, handle_simple_irq, "edge", 0);
-}
-
 void leon_update_virq_handling(unsigned int virq,
 			      irq_flow_handler_t flow_handler,
 			      const char *name, int do_ack)
@@ -260,7 +254,7 @@ void leon_update_virq_handling(unsigned int virq,
 	irq_set_chip_data(virq, (void *)mask);
 }
 
-static u32 leon_cycles_offset(void)
+u32 leon_cycles_offset(void)
 {
 	u32 rld, val, ctrl, off;
 
@@ -314,14 +308,6 @@ void __init leon_init_timers(void)
 	u32 config;
 	u32 ctrl;
 
-	sparc_config.get_cycles_offset = leon_cycles_offset;
-	sparc_config.cs_period = 1000000 / HZ;
-	sparc_config.features |= FEAT_L10_CLOCKSOURCE;
-
-#ifndef CONFIG_SMP
-	sparc_config.features |= FEAT_L10_CLOCKEVENT;
-#endif
-
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
 	master_l10_counter = (u32 __iomem *)&dummy_master_l10_counter;
@@ -436,7 +422,7 @@ void __init leon_init_timers(void)
 	err = request_irq(irq, leon_percpu_timer_ce_interrupt,
 			  IRQF_PERCPU | IRQF_TIMER, "timer", NULL);
 #else
-	irq = _leon_build_device_irq(NULL, leon3_gptimer_irq);
+	irq = leon_build_device_irq(leon3_gptimer_irq, handle_simple_irq, "edge", 0);
 	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 #endif
 	if (err) {
@@ -455,7 +441,7 @@ void __init leon_init_timers(void)
 	return;
 }
 
-static void leon_clear_clock_irq(void)
+void leon_clear_clock_irq(void)
 {
 	u32 ctrl;
 
@@ -464,7 +450,7 @@ static void leon_clear_clock_irq(void)
 			      ctrl & leon3_gptimer_ackmask);
 }
 
-static void leon_load_profile_irq(int cpu, unsigned int limit)
+void leon_load_profile_irq(int cpu, unsigned int limit)
 {
 }
 
@@ -487,9 +473,4 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
 
 void __init leon_init_IRQ(void)
 {
-	sparc_config.init_timers      = leon_init_timers;
-	sparc_config.build_device_irq = _leon_build_device_irq;
-	sparc_config.clock_rate       = 1000000;
-	sparc_config.clear_clock_irq  = leon_clear_clock_irq;
-	sparc_config.load_profile_irq = leon_load_profile_irq;
 }
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4ebf51e6e78e..c846acdb4455 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -358,7 +358,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		op->archdata.num_irqs = len / sizeof(struct linux_prom_irqs);
 		for (i = 0; i < op->archdata.num_irqs; i++)
 			op->archdata.irqs[i] -			    sparc_config.build_device_irq(op, intr[i].pri);
+			    leon_build_device_irq(intr[i].pri, handle_simple_irq, "edge", 0);
 	} else {
 		const unsigned int *irq  			of_get_property(dp, "interrupts", &len);
@@ -367,7 +367,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 			op->archdata.num_irqs = len / sizeof(unsigned int);
 			for (i = 0; i < op->archdata.num_irqs; i++)
 				op->archdata.irqs[i] -				    sparc_config.build_device_irq(op, irq[i]);
+				    leon_build_device_irq(irq[i], handle_simple_irq, "edge", 0);
 		} else {
 			op->archdata.num_irqs = 0;
 		}
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 0093cf4ecb06..8619a3d9953f 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -45,6 +45,7 @@
 #include <asm/idprom.h>
 #include <asm/page.h>
 #include <asm/irq_regs.h>
+#include <asm/leon.h>
 #include <asm/setup.h>
 
 #include "kernel.h"
@@ -89,10 +90,10 @@ irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
 	if (timer_cs_enabled) {
 		write_seqlock(&timer_cs_lock);
 		timer_cs_internal_counter++;
-		sparc_config.clear_clock_irq();
+		leon_clear_clock_irq();
 		write_sequnlock(&timer_cs_lock);
 	} else {
-		sparc_config.clear_clock_irq();
+		leon_clear_clock_irq();
 	}
 
 	if (timer_ce_enabled)
@@ -101,39 +102,6 @@ irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int timer_ce_shutdown(struct clock_event_device *evt)
-{
-	timer_ce_enabled = 0;
-	smp_mb();
-	return 0;
-}
-
-static int timer_ce_set_periodic(struct clock_event_device *evt)
-{
-	timer_ce_enabled = 1;
-	smp_mb();
-	return 0;
-}
-
-static __init void setup_timer_ce(void)
-{
-	struct clock_event_device *ce = &timer_ce;
-
-	BUG_ON(smp_processor_id() != boot_cpu_id);
-
-	ce->name     = "timer_ce";
-	ce->rating   = 100;
-	ce->features = CLOCK_EVT_FEAT_PERIODIC;
-	ce->set_state_shutdown = timer_ce_shutdown;
-	ce->set_state_periodic = timer_ce_set_periodic;
-	ce->tick_resume = timer_ce_set_periodic;
-	ce->cpumask  = cpu_possible_mask;
-	ce->shift    = 32;
-	ce->mult     = div_sc(sparc_config.clock_rate, NSEC_PER_SEC,
-	                      ce->shift);
-	clockevents_register_device(ce);
-}
-
 static unsigned int sbus_cycles_offset(void)
 {
 	u32 val, offset;
@@ -143,7 +111,7 @@ static unsigned int sbus_cycles_offset(void)
 
 	/* Limit hit? */
 	if (val & TIMER_LIMIT_BIT)
-		offset += sparc_config.cs_period;
+		offset += 1000000 / HZ;
 
 	return offset;
 }
@@ -157,11 +125,11 @@ static u64 timer_cs_read(struct clocksource *cs)
 		seq = read_seqbegin(&timer_cs_lock);
 
 		cycles = timer_cs_internal_counter;
-		offset = sparc_config.get_cycles_offset();
+		offset = sbus_cycles_offset();
 	} while (read_seqretry(&timer_cs_lock, seq));
 
 	/* Count absolute cycles */
-	cycles *= sparc_config.cs_period;
+	cycles *= LEON_CLOCK_RATE / HZ;
 	cycles += offset;
 
 	return cycles;
@@ -178,15 +146,47 @@ static struct clocksource timer_cs = {
 static __init int setup_timer_cs(void)
 {
 	timer_cs_enabled = 1;
-	return clocksource_register_hz(&timer_cs, sparc_config.clock_rate);
+	return clocksource_register_hz(&timer_cs, LEON_CLOCK_RATE);
 }
 
 #ifdef CONFIG_SMP
+static int timer_ce_shutdown(struct clock_event_device *evt)
+{
+	timer_ce_enabled = 0;
+	smp_mb();
+	return 0;
+}
+
+static int timer_ce_set_periodic(struct clock_event_device *evt)
+{
+	timer_ce_enabled = 1;
+	smp_mb();
+	return 0;
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
+	ce->set_state_shutdown = timer_ce_shutdown;
+	ce->set_state_periodic = timer_ce_set_periodic;
+	ce->tick_resume = timer_ce_set_periodic;
+	ce->cpumask  = cpu_possible_mask;
+	ce->shift    = 32;
+	ce->mult     = div_sc(LEON_CLOCK_RATE, NSEC_PER_SEC, ce->shift);
+	clockevents_register_device(ce);
+}
+
 static int percpu_ce_shutdown(struct clock_event_device *evt)
 {
 	int cpu = cpumask_first(evt->cpumask);
 
-	sparc_config.load_profile_irq(cpu, 0);
+	leon_load_profile_irq(cpu, 0);
 	return 0;
 }
 
@@ -194,7 +194,7 @@ static int percpu_ce_set_periodic(struct clock_event_device *evt)
 {
 	int cpu = cpumask_first(evt->cpumask);
 
-	sparc_config.load_profile_irq(cpu, SBUS_CLOCK_RATE / HZ);
+	leon_load_profile_irq(cpu, SBUS_CLOCK_RATE / HZ);
 	return 0;
 }
 
@@ -204,7 +204,7 @@ static int percpu_ce_set_next_event(unsigned long delta,
 	int cpu = cpumask_first(evt->cpumask);
 	unsigned int next = (unsigned int)delta;
 
-	sparc_config.load_profile_irq(cpu, next);
+	leon_load_profile_irq(cpu, next);
 	return 0;
 }
 
@@ -213,9 +213,6 @@ void register_percpu_ce(int cpu)
 	struct clock_event_device *ce = &per_cpu(sparc32_clockevent, cpu);
 	unsigned int features = CLOCK_EVT_FEAT_PERIODIC;
 
-	if (sparc_config.features & FEAT_L14_ONESHOT)
-		features |= CLOCK_EVT_FEAT_ONESHOT;
-
 	ce->name           = "percpu_ce";
 	ce->rating         = 200;
 	ce->features       = features;
@@ -225,10 +222,9 @@ void register_percpu_ce(int cpu)
 	ce->set_next_event = percpu_ce_set_next_event;
 	ce->cpumask        = cpumask_of(cpu);
 	ce->shift          = 32;
-	ce->mult           = div_sc(sparc_config.clock_rate, NSEC_PER_SEC,
-	                            ce->shift);
-	ce->max_delta_ns   = clockevent_delta2ns(sparc_config.clock_rate, ce);
-	ce->max_delta_ticks = (unsigned long)sparc_config.clock_rate;
+	ce->mult           = div_sc(LEON_CLOCK_RATE, NSEC_PER_SEC, ce->shift);
+	ce->max_delta_ns   = clockevent_delta2ns(LEON_CLOCK_RATE, ce);
+	ce->max_delta_ticks = (unsigned long)LEON_CLOCK_RATE;
 	ce->min_delta_ns   = clockevent_delta2ns(100, ce);
 	ce->min_delta_ticks = 100;
 
@@ -327,26 +323,18 @@ fs_initcall(clock_init);
 
 static void __init sparc32_late_time_init(void)
 {
-	if (sparc_config.features & FEAT_L10_CLOCKEVENT)
-		setup_timer_ce();
-	if (sparc_config.features & FEAT_L10_CLOCKSOURCE)
-		setup_timer_cs();
+	setup_timer_cs();
+
 #ifdef CONFIG_SMP
+	setup_timer_ce();
 	register_percpu_ce(smp_processor_id());
 #endif
 }
 
-static void __init sbus_time_init(void)
-{
-	sparc_config.get_cycles_offset = sbus_cycles_offset;
-	sparc_config.init_timers();
-}
-
 void __init time_init(void)
 {
-	sparc_config.features = 0;
 	late_time_init = sparc32_late_time_init;
 
-	sbus_time_init();
+	leon_init_timers();
 }
 
-- 
2.27.0
