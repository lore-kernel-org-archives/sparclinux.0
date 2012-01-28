From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 28 Jan 2012 22:32:41 +0000
Subject: Re: Clock event support on SPARC32
Message-Id: <337111327789961@web111.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1323120797.3274.20.camel@hp>
In-Reply-To: <1323120797.3274.20.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

29.12.2011, 16:42, "Sam Ravnborg" <sam.ravnborg@gmail.com>:
> On Mon, Dec 5, 2011 at 10:33 PM, Kirill Tkhai <tkhai@yandex.ru> wrote:

>> =9AThere is no clock event support on SPARC32, but it's possible to
>> =9Aimplement it.
>
> In general we would like to use as much of the generic code for
> sparc32 as possible.
> Introducing support for clock events is thus a good thing.
>
>> =9AThe plan is to use local timers as periodic and one-shot clock events,
>> =9Awhile global timer is a continuous clock source. It ticks and increas=
es
>> =9Ainternal counter of tick number every 2 seconds (it's possible to use
>> =9Amore, but I use a round number). The number "counter * size_of_tick +
>> =9Amaster_l10_counter" gives us the continuous clocksource.
>
> Sounds like a good plan.
>
>> =9AThe only problem is a fact that LEON doesn't have a master_l10_counte=
r,
>> =9Abut it's possible to use HZ-lenght clocksource for this case.
>
> Let's get it working for plain sparc32 - then we can surely work out
> somethign for LEON later.
>
> I will try to find time to review your patches (short on Linux time...)
>
> =9A=9A=9A=9ASam

Hi, Sam.

In my point of view clockevent support on sparc32 should lock like:

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

---
 arch/sparc/Kconfig                  |    6 +-
 arch/sparc/include/asm/cpudata_32.h |    1 -
 arch/sparc/include/asm/timer_32.h   |   13 ++
 arch/sparc/include/asm/timex_32.h   |    1 -
 arch/sparc/kernel/irq.h             |    7 +-
 arch/sparc/kernel/kernel.h          |    2 -
 arch/sparc/kernel/pcic.c            |   46 ++++----
 arch/sparc/kernel/smp_32.c          |   21 +---
 arch/sparc/kernel/sun4c_irq.c       |    9 +-
 arch/sparc/kernel/sun4d_irq.c       |   16 ++-
 arch/sparc/kernel/sun4d_smp.c       |   27 +---
 arch/sparc/kernel/sun4m_irq.c       |   20 ++-
 arch/sparc/kernel/sun4m_smp.c       |   37 ++----
 arch/sparc/kernel/time_32.c         |  218 ++++++++++++++++++++++++++++---=
---
 14 files changed, 273 insertions(+), 151 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 868ea08..4225559 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -70,17 +70,13 @@ config BITS
 	default 32 if SPARC32
 	default 64 if SPARC64
=20
-config ARCH_USES_GETTIMEOFFSET
-	bool
-	default y if SPARC32
-
 config GENERIC_CMOS_UPDATE
 	bool
 	default y
=20
 config GENERIC_CLOCKEVENTS
 	bool
-	default y if SPARC64
+	default y
=20
 config IOMMU_HELPER
 	bool
diff --git a/arch/sparc/include/asm/cpudata_32.h b/arch/sparc/include/asm/c=
pudata_32.h
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
diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/tim=
er_32.h
index 2ec030e..6b59ec6 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -8,10 +8,23 @@
 #ifndef _SPARC_TIMER_H
 #define _SPARC_TIMER_H
=20
+#include <linux/irqreturn.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <asm-generic/percpu.h>
 #include <asm/system.h>  /* For SUN4M_NCPUS */
 #include <asm/btfixup.h>
=20
 extern __volatile__ unsigned int *master_l10_counter;
+extern unsigned int (*get_cycles_offset)(void);
+extern unsigned int timer_cs_period;
+
+extern irqreturn_t notrace timer_interrupt(int dummy, void *dev_id);
+
+#ifdef CONFIG_SMP
+DECLARE_PER_CPU(struct clock_event_device, percpu_ce);
+extern void register_percpu_ce(int cpu);
+#endif
=20
 /* FIXME: Make do_[gs]ettimeofday btfixup calls */
 BTFIXUPDEF_CALL(int, bus_do_settimeofday, struct timespec *tv)
diff --git a/arch/sparc/include/asm/timex_32.h b/arch/sparc/include/asm/tim=
ex_32.h
index a254750..b6ccdb0 100644
--- a/arch/sparc/include/asm/timex_32.h
+++ b/arch/sparc/include/asm/timex_32.h
@@ -12,5 +12,4 @@
 typedef unsigned long cycles_t;
 #define get_cycles()	(0)
=20
-extern u32 (*do_arch_gettimeoffset)(void);
 #endif
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 4285112..74abcda 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -40,15 +40,20 @@ struct sun4m_irq_global {
 extern struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 extern struct sun4m_irq_global __iomem *sun4m_irq_global;
=20
+#define USES_TIMER_CS		(1 << 0)
+#define USES_TIMER_CE		(1 << 1)
+#define PERCPU_CE_CAN_ONESHOT	(1 << 2)
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
=20
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index fd6c36b..8abbad3 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -47,8 +47,6 @@ extern void init_IRQ(void);
 extern void sun4c_init_IRQ(void);
=20
 /* sun4m_irq.c */
-extern unsigned int lvl14_resolution;
-
 extern void sun4m_init_IRQ(void);
 extern void sun4m_unmask_profile_irq(void);
 extern void sun4m_clear_profile_irq(int cpu);
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index fcc148e..94fea35 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -703,31 +703,28 @@ static void pcic_clear_clock_irq(void)
 	pcic_timer_dummy =3D readl(pcic0.pcic_regs+PCI_SYS_LIMIT);
 }
=20
-static irqreturn_t pcic_timer_handler (int irq, void *h)
-{
-	pcic_clear_clock_irq();
-	xtime_update(1);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(get_irq_regs()));
-#endif
-	return IRQ_HANDLED;
-}
-
-#define USECS_PER_JIFFY  10000  /* We have 100HZ "standard" timer for spar=
c */
-#define TICK_TIMER_LIMIT ((100*1000000/4)/100)
+/* CPU frequency is 100 MHz, timer increments every 4 CPU clocks */
+#define USECS_PER_JIFFY  (1000000/HZ)
+#define TICK_TIMER_LIMIT ((100*1000000/4)/HZ)
=20
-u32 pci_gettimeoffset(void)
+static u32 pcic_cycles_offset(void)
 {
+	u32 value, count;
+	      =20
+	value =3D readl(pcic0.pcic_regs+PCI_SYS_COUNTER);
+	count =3D value & ~PCI_SYS_COUNTER_OVERFLOW;
+
+	if (value & PCI_SYS_COUNTER_OVERFLOW)
+		count +=3D TICK_TIMER_LIMIT;
 	/*
-	 * We divide all by 100
+	 * We divide all by HZ
 	 * to have microsecond resolution and to avoid overflow
 	 */
-	unsigned long count -	    readl(pcic0.pcic_regs+PCI_SYS_COUNTER) & ~PCI_S=
YS_COUNTER_OVERFLOW;
-	count =3D ((count/100)*USECS_PER_JIFFY) / (TICK_TIMER_LIMIT/100);
-	return count * 1000;
-}
+	count =3D ((count/HZ)*USECS_PER_JIFFY) / (TICK_TIMER_LIMIT/HZ);
=20
+	/* timer_cs rate is 2MHz */
+	return count * 2;
+}
=20
 void __init pci_time_init(void)
 {
@@ -736,9 +733,12 @@ void __init pci_time_init(void)
 	int timer_irq, irq;
 	int err;
=20
-	do_arch_gettimeoffset =3D pci_gettimeoffset;
-
-	btfixup();
+#ifndef CONFIG_SMP
+	timer_cs_period =3D 2000000/HZ;
+	sparc_irq_config.features |=3D USES_TIMER_CE;
+#endif
+	sparc_irq_config.features |=3D USES_TIMER_CS;
+	get_cycles_offset =3D pcic_cycles_offset;
=20
 	writel (TICK_TIMER_LIMIT, pcic->pcic_regs+PCI_SYS_LIMIT);
 	/* PROM should set appropriate irq */
@@ -747,7 +747,7 @@ void __init pci_time_init(void)
 	writel (PCI_COUNTER_IRQ_SET(timer_irq, 0),
 		pcic->pcic_regs+PCI_COUNTER_IRQ);
 	irq =3D pcic_build_device_irq(NULL, timer_irq);
-	err =3D request_irq(irq, pcic_timer_handler,
+	err =3D request_irq(irq, timer_interrupt,
 			  IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("time_init: unable to attach IRQ%d\n", timer_irq);
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index f671e7f..569a8a9 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -301,28 +301,9 @@ void smp_flush_sig_insns(struct mm_struct *mm, unsigne=
d long insn_addr)
 	local_flush_sig_insns(mm, insn_addr);
 }
=20
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
-		prof_multiplier(i) =3D multiplier;
-	}
-	spin_unlock_irqrestore(&prof_setup_lock, flags);
-
-	return 0;
+	return -EINVAL;
 }
=20
 void __init smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index f6bf25a..5293f59 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -174,7 +174,7 @@ static void sun4c_load_profile_irq(int cpu, unsigned in=
t limit)
 	/* Errm.. not sure how to do this.. */
 }
=20
-static void __init sun4c_init_timers(irq_handler_t counter_fn)
+static void __init sun4c_init_timers(void)
 {
 	const struct linux_prom_irqs *prom_irqs;
 	struct device_node *dp;
@@ -207,12 +207,15 @@ static void __init sun4c_init_timers(irq_handler_t co=
unter_fn)
 	 * level 14 timer limit since we are letting the prom handle
 	 * them until we have a real console driver so L1-A works.
 	 */
-	sbus_writel((((1000000/HZ) + 1) << 10), &sun4c_timers->l10_limit);
+	timer_cs_period =3D 2000000/HZ;
+	sparc_irq_config.features |=3D USES_TIMER_CS;
+	sparc_irq_config.features |=3D USES_TIMER_CE;
+	sbus_writel(((timer_cs_period + 1) << 9), &sun4c_timers->l10_limit);
=20
 	master_l10_counter =3D &sun4c_timers->l10_count;
=20
 	irq =3D sun4c_build_device_irq(NULL, prom_irqs[0].pri);
-	err =3D request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err =3D request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 1d13c5b..f667da4 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -282,7 +282,8 @@ static void sun4d_clear_clock_irq(void)
=20
 static void sun4d_load_profile_irq(int cpu, unsigned int limit)
 {
-	bw_set_prof_limit(cpu, limit);
+	unsigned int value =3D limit ? (limit + 1) << 9 : 0;
+	bw_set_prof_limit(cpu, value);
 }
=20
 static void __init sun4d_load_profile_irqs(void)
@@ -423,7 +424,7 @@ static void __init sun4d_fixup_trap_table(void)
 #endif
 }
=20
-static void __init sun4d_init_timers(irq_handler_t counter_fn)
+static void __init sun4d_init_timers(void)
 {
 	struct device_node *dp;
 	struct resource res;
@@ -466,12 +467,19 @@ static void __init sun4d_init_timers(irq_handler_t co=
unter_fn)
 		prom_halt();
 	}
=20
-	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
+#ifdef CONFIG_SMP
+	timer_cs_period =3D 4000000; /* 2 seconds */
+#else
+	timer_cs_period =3D 2000000/HZ; /* 1/HZ */
+	sparc_irq_config.features |=3D USES_TIMER_CE;
+#endif
+	sparc_irq_config.features |=3D USES_TIMER_CS;
+	sbus_writel(((timer_cs_period + 1) << 9), &sun4d_timers->l10_timer_limit);
=20
 	master_l10_counter =3D &sun4d_timers->l10_cur_count;
=20
 	irq =3D sun4d_build_timer_irq(board, SUN4D_TIMER_IRQ);
-	err =3D request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err =3D request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
 		             err);
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 1333879..5eed389 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -15,6 +15,7 @@
 #include <asm/mmu.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
+#include <asm/timer.h>
=20
 #include "kernel.h"
 #include "irq.h"
@@ -33,7 +34,6 @@ static inline unsigned long sun4d_swap(volatile unsigned =
long *ptr, unsigned lon
 }
=20
 static void smp4d_ipi_init(void);
-static void smp_setup_percpu_timer(void);
=20
 static unsigned char cpu_leds[32];
=20
@@ -69,7 +69,7 @@ void __cpuinit smp4d_callin(void)
 	 * to call the scheduler code.
 	 */
 	/* Get our local ticker going. */
-	smp_setup_percpu_timer();
+	register_percpu_ce(cpuid);
=20
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
@@ -122,7 +122,6 @@ void __init smp4d_boot_cpus(void)
 	smp4d_ipi_init();
 	if (boot_cpu_id)
 		current_set[0] =3D NULL;
-	smp_setup_percpu_timer();
 	local_flush_cache_all();
 }
=20
@@ -363,6 +362,7 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	int cpu =3D hard_smp4d_processor_id();
+	struct clock_event_device *ce;
 	static int cpu_tick[NR_CPUS];
 	static char led_mask[] =3D { 0xe, 0xd, 0xb, 0x7, 0xb, 0xd };
=20
@@ -378,28 +378,15 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *reg=
s)
 		show_leds(cpu);
 	}
=20
-	profile_tick(CPU_PROFILING);
+	ce =3D &per_cpu(percpu_ce, cpu);
=20
-	if (!--prof_counter(cpu)) {
-		int user =3D user_mode(regs);
+	irq_enter();
+	ce->event_handler(ce);
+	irq_exit();
=20
-		irq_enter();
-		update_process_times(user);
-		irq_exit();
-
-		prof_counter(cpu) =3D prof_multiplier(cpu);
-	}
 	set_irq_regs(old_regs);
 }
=20
-static void __cpuinit smp_setup_percpu_timer(void)
-{
-	int cpu =3D hard_smp4d_processor_id();
-
-	prof_counter(cpu) =3D prof_multiplier(cpu) =3D 1;
-	load_profile_irq(cpu, lvl14_resolution);
-}
-
 void __init smp4d_blackbox_id(unsigned *addr)
 {
 	int rd =3D *addr & 0x3e000000;
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index e611651..06d3910 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -318,9 +318,6 @@ struct sun4m_timer_global {
=20
 static struct sun4m_timer_global __iomem *timers_global;
=20
-
-unsigned int lvl14_resolution =3D (((1000000/HZ) + 1) << 10);
-
 static void sun4m_clear_clock_irq(void)
 {
 	sbus_readl(&timers_global->l10_limit);
@@ -369,10 +366,11 @@ void sun4m_clear_profile_irq(int cpu)
=20
 static void sun4m_load_profile_irq(int cpu, unsigned int limit)
 {
-	sbus_writel(limit, &timers_percpu[cpu]->l14_limit);
+	unsigned int value =3D limit ? (limit + 1) << 9 : 0;
+	sbus_writel(value, &timers_percpu[cpu]->l14_limit);
 }
=20
-static void __init sun4m_init_timers(irq_handler_t counter_fn)
+static void __init sun4m_init_timers(void)
 {
 	struct device_node *dp =3D of_find_node_by_name(NULL, "counter");
 	int i, err, len, num_cpu_timers;
@@ -402,13 +400,21 @@ static void __init sun4m_init_timers(irq_handler_t co=
unter_fn)
 	/* Every per-cpu timer works in timer mode */
 	sbus_writel(0x00000000, &timers_global->timer_config);
=20
-	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
+#ifdef CONFIG_SMP
+	timer_cs_period =3D 4000000; /* 2 seconds */
+	sparc_irq_config.features |=3D PERCPU_CE_CAN_ONESHOT;
+#else
+	timer_cs_period =3D 2000000/HZ; /* 1/HZ */
+	sparc_irq_config.features |=3D USES_TIMER_CE;
+#endif
+	sparc_irq_config.features |=3D USES_TIMER_CS;
+	sbus_writel(((timer_cs_period + 1) << 9), &timers_global->l10_limit);
=20
 	master_l10_counter =3D &timers_global->l10_count;
=20
 	irq =3D sun4m_build_device_irq(NULL, SUN4M_TIMER_IRQ);
=20
-	err =3D request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	err =3D request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
 			err);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 5947686..d98d307 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -11,6 +11,7 @@
=20
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/timer.h>
=20
 #include "irq.h"
 #include "kernel.h"
@@ -30,7 +31,6 @@ swap_ulong(volatile unsigned long *ptr, unsigned long val)
 }
=20
 static void smp4m_ipi_init(void);
-static void smp_setup_percpu_timer(void);
=20
 void __cpuinit smp4m_callin(void)
 {
@@ -41,8 +41,7 @@ void __cpuinit smp4m_callin(void)
=20
 	notify_cpu_starting(cpuid);
=20
-	/* Get our local ticker going. */
-	smp_setup_percpu_timer();
+	register_percpu_ce(cpuid);
=20
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
@@ -86,7 +85,7 @@ void __cpuinit smp4m_callin(void)
 void __init smp4m_boot_cpus(void)
 {
 	smp4m_ipi_init();
-	smp_setup_percpu_timer();
+	sun4m_unmask_profile_irq();
 	local_flush_cache_all();
 }
=20
@@ -259,37 +258,25 @@ void smp4m_cross_call_irq(void)
 void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
+	struct clock_event_device *ce;
 	int cpu =3D smp_processor_id();
=20
 	old_regs =3D set_irq_regs(regs);
=20
-	sun4m_clear_profile_irq(cpu);
+	ce =3D &per_cpu(percpu_ce, cpu);
=20
-	profile_tick(CPU_PROFILING);
+	if (ce->mode & CLOCK_EVT_MODE_PERIODIC)
+		sun4m_clear_profile_irq(cpu);
+	else
+		load_profile_irq(cpu, 0);
=20
-	if (!--prof_counter(cpu)) {
-		int user =3D user_mode(regs);
+	irq_enter();
+	ce->event_handler(ce);
+	irq_exit();
=20
-		irq_enter();
-		update_process_times(user);
-		irq_exit();
-
-		prof_counter(cpu) =3D prof_multiplier(cpu);
-	}
 	set_irq_regs(old_regs);
 }
=20
-static void __cpuinit smp_setup_percpu_timer(void)
-{
-	int cpu =3D smp_processor_id();
-
-	prof_counter(cpu) =3D prof_multiplier(cpu) =3D 1;
-	load_profile_irq(cpu, lvl14_resolution);
-
-	if (cpu =3D boot_cpu_id)
-		sun4m_unmask_profile_irq();
-}
-
 static void __init smp4m_blackbox_id(unsigned *addr)
 {
 	int rd =3D *addr & 0x3e000000;
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 1060e06..f541ac7 100644
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
=20
 #include "irq.h"
=20
+static __cacheline_aligned_in_smp DEFINE_SEQLOCK(timer_cs_lock);
+static __volatile__ u64 timer_cs_internal_counter =3D 0;
+/* Tick period in cycles */
+unsigned int timer_cs_period;
+static char timer_cs_enabled =3D 0;
+u32 (*get_cycles_offset)(void);
+
+static struct clock_event_device timer_ce;
+static char timer_ce_enabled =3D 0;
+
+#ifdef CONFIG_SMP
+DEFINE_PER_CPU(struct clock_event_device, percpu_ce);
+#endif
+
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
=20
@@ -76,36 +93,165 @@ EXPORT_SYMBOL(profile_pc);
=20
 __volatile__ unsigned int *master_l10_counter;
=20
-u32 (*do_arch_gettimeoffset)(void);
-
 int update_persistent_clock(struct timespec now)
 {
 	return set_rtc_mmss(now.tv_sec);
 }
=20
-/*
- * timer_interrupt() needs to keep up the real-time clock,
- * as well as call the "xtime_update()" routine every clocktick
- */
+irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
+{
+	if (timer_cs_enabled) {
+		write_seqlock(&timer_cs_lock);
+		timer_cs_internal_counter ++;
+		clear_clock_irq();
+		write_sequnlock(&timer_cs_lock);
+	} else
+		clear_clock_irq();
=20
-#define TICK_SIZE (tick_nsec / 1000)
+	if (timer_ce_enabled)
+		timer_ce.event_handler(&timer_ce);
=20
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
+			timer_ce_enabled =3D 1;
+			break;
+		case CLOCK_EVT_MODE_SHUTDOWN:
+			timer_ce_enabled =3D 0;
+			break;
+		default:
+			break;
+	}
+	smp_mb();
+}
=20
-	clear_clock_irq();
+static __init void setup_timer_ce(void)
+{
+	struct clock_event_device *ce =3D &timer_ce;
=20
-	xtime_update(1);
+	BUG_ON(smp_processor_id() !=3D boot_cpu_id);
=20
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(get_irq_regs()));
-#endif
-	return IRQ_HANDLED;
+	ce->name		=3D "timer_ce";
+	ce->rating		=3D 100;
+	ce->features		=3D CLOCK_EVT_FEAT_PERIODIC;
+	ce->set_mode		=3D timer_ce_set_mode;
+	ce->cpumask		=3D cpu_possible_mask;
+	ce->shift		=3D 32;
+	ce->mult		=3D div_sc(2000000, NSEC_PER_SEC, ce->shift);
+
+	clockevents_register_device(ce);
+}
+
+static u32 sbus_cycles_offset(void)
+{
+	unsigned int val, offset;
+
+	val =3D *master_l10_counter;
+	offset =3D (val >> 9) & 0x3fffff;
+
+	/* Limit hit? */
+	if (val & 0x80000000)
+		offset +=3D timer_cs_period;
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
+		seq =3D read_seqbegin(&timer_cs_lock);
+
+		cycles =3D timer_cs_internal_counter;
+		offset =3D get_cycles_offset();
+	} while (read_seqretry(&timer_cs_lock, seq));
+
+	/* Count absolute cycles */
+	cycles *=3D timer_cs_period;
+	cycles +=3D offset;
+
+	return cycles;
+}
+
+static struct clocksource timer_cs =3D {
+	.name	=3D "timer_cs",
+	.rating	=3D 100,
+	.read	=3D timer_cs_read,
+	.mask	=3D CLOCKSOURCE_MASK(64),
+	.shift	=3D 2,
+	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static __init int setup_timer_cs(void)
+{
+	timer_cs_enabled =3D 1;
+	/* Clock rate is 2MHz */
+	timer_cs.mult =3D clocksource_hz2mult(2000000, timer_cs.shift);
+
+	return clocksource_register(&timer_cs);
+}
+
+#ifdef CONFIG_SMP
+static void percpu_ce_setup(enum clock_event_mode mode,
+			struct clock_event_device *evt)
+{
+	int cpu =3D __first_cpu(evt->cpumask);
+
+	switch (mode) {
+		case CLOCK_EVT_MODE_PERIODIC:
+			load_profile_irq(cpu, 2000000/HZ);
+			break;
+		case CLOCK_EVT_MODE_ONESHOT:
+		case CLOCK_EVT_MODE_SHUTDOWN:
+		case CLOCK_EVT_MODE_UNUSED:
+			load_profile_irq(cpu, 0);
+			break;
+		default:
+			break;
+	}
 }
=20
+static int percpu_ce_set_next_event(unsigned long delta,
+				    struct clock_event_device *evt)
+{
+	int cpu =3D __first_cpu(evt->cpumask);
+	unsigned int next =3D (unsigned int)delta;
+
+	load_profile_irq(cpu, next);
+	return 0;
+}
+
+void register_percpu_ce(int cpu)
+{
+	struct clock_event_device *ce =3D &per_cpu(percpu_ce, cpu);
+	unsigned int features =3D CLOCK_EVT_FEAT_PERIODIC;
+
+	if (sparc_irq_config.features & PERCPU_CE_CAN_ONESHOT)
+		features |=3D CLOCK_EVT_FEAT_ONESHOT;
+
+	ce->name		=3D "percpu_ce";
+	ce->rating		=3D 200;
+	ce->features		=3D features;
+	ce->set_mode		=3D percpu_ce_setup;
+	ce->set_next_event	=3D percpu_ce_set_next_event;
+	ce->cpumask		=3D cpumask_of(cpu);
+	ce->shift		=3D 32;
+	ce->mult		=3D div_sc(2000000, NSEC_PER_SEC, ce->shift);
+	ce->max_delta_ns	=3D clockevent_delta2ns(2000000, ce);
+	ce->min_delta_ns	=3D clockevent_delta2ns(100, ce);
+
+	clockevents_register_device(ce);
+}
+#endif
+
 static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -196,42 +342,36 @@ static int __init clock_init(void)
  */
 fs_initcall(clock_init);
=20
-
-u32 sbus_do_gettimeoffset(void)
-{
-	unsigned long val =3D *master_l10_counter;
-	unsigned long usec =3D (val >> 10) & 0x1fffff;
-
-	/* Limit hit?  */
-	if (val & 0x80000000)
-		usec +=3D 1000000 / HZ;
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
+	if (sparc_irq_config.features & USES_TIMER_CE)
+		setup_timer_ce();
+	if (sparc_irq_config.features & USES_TIMER_CS)
+		setup_timer_cs();
+#ifdef CONFIG_SMP
+	register_percpu_ce(smp_processor_id());
+#endif
 }
=20
 static void __init sbus_time_init(void)
 {
-	do_arch_gettimeoffset =3D sbus_do_gettimeoffset;
-
-	btfixup();
+	get_cycles_offset =3D sbus_cycles_offset;
=20
-	sparc_irq_config.init_timers(timer_interrupt);
+	sparc_irq_config.init_timers();
 }
=20
 void __init time_init(void)
 {
+	btfixup();
+
+	sparc_irq_config.features =3D 0;
+
 	if (pcic_present())
 		pci_time_init();
 	else
 		sbus_time_init();
+
+	late_time_init =3D sparc32_late_time_init;
 }
=20
=20
