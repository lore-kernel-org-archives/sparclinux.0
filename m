From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 06 Feb 2012 21:55:44 +0000
Subject: Re: Clock event support on SPARC32
Message-Id: <1328565344.10141.87.camel@hp>
List-Id: <sparclinux.vger.kernel.org>
References: <1323120797.3274.20.camel@hp>
In-Reply-To: <1323120797.3274.20.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2012-02-05 at 15:39 +0100, Sam Ravnborg wrote:
> Hi Kirill,
> 
> thanks for looking into this!
> A few comments below - mostly on style issues.
> 
> I have tested this on my SPARCstation 5 - it could
> boot.

Great review, Sam, thanks a lot!

I took into account the remarks and I'll send new patch soon.
Could I add you as "Reviewed-by"?

> Can I do more to test that this is actually working as expected?

Yes, could you do two next testing actions?

The first thing is /proc/timer_list file. It must contain
hrtimer_interrupt event handler.

The second is the following program should have smaller diff column in
case of patched kernel. I don't know an exact value, but it should be
different.

#include <stdio.h>
#include <time.h>
#include <sched.h>

int main()
{
	struct sched_param param;
	int n;
	unsigned long fact;
	
	param.sched_priority = 50;
	sched_setscheduler(0, SCHED_FIFO, &param);

	for (n = 10; n--;) {
		struct timespec a, b;
		struct timespec sl = { .tv_nsec = 100000000l };
		clock_gettime(CLOCK_REALTIME, &a);
		nanosleep(&sl, NULL);
		clock_gettime(CLOCK_REALTIME, &b);

		fact = b.tv_nsec - a.tv_nsec + (b.tv_sec - a.tv_sec) * 1000000000l;
		printf("sl=%lu, fact=%lu, diff=%lu\n", sl.tv_nsec, fact, fact-sl.tv_nsec);
    }
}

> > --- a/arch/sparc/include/asm/timer_32.h
> > +++ b/arch/sparc/include/asm/timer_32.h
> > @@ -8,10 +8,23 @@
> >  #ifndef _SPARC_TIMER_H
> >  #define _SPARC_TIMER_H
> >  
> > +#include <linux/irqreturn.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/clocksource.h>
> > +#include <asm-generic/percpu.h>
> 
> Looks like you add more includes than strictly required for the .h file.
> 

#include <linux/clockchips.h> is unnecessary. I'm removed it, thanks.

> 
> > --- a/arch/sparc/kernel/irq.h
> > +++ b/arch/sparc/kernel/irq.h
> > @@ -40,15 +40,20 @@ struct sun4m_irq_global {
> >  extern struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
> >  extern struct sun4m_irq_global __iomem *sun4m_irq_global;
> >  
> > +#define USES_TIMER_CS		(1 << 0)
> > +#define USES_TIMER_CE		(1 << 1)
> > +#define PERCPU_CE_CAN_ONESHOT	(1 << 2)
> 
> A comment about what each flag indicate would be good.
> 

OK. The new look of this is below.

> > +#define USECS_PER_JIFFY  (1000000/HZ)
> > +#define TICK_TIMER_LIMIT ((100*1000000/4)/HZ)
> 
> Spaces around operators please.
> 

Fixed

> I miss:
> #define SPARC32_NSEC_PER_CYC_SHIFT      9UL

> As I assume this is what the hardcoded "9" is about.
> Used the sparc64 name as template.
> 

SPARC32_NSEC_PER_CYC_SHIFT is similar to timer_cs.shift,
which is equal to 2. The number "9" is a register shift.

According to SUN4* documentation, 9 low bits of register
are meaningless and value must be shifted.

Counter starts to count from 0x200 (1 << 9).

It wasn't defined, should I do it?

> > +static u32 pcic_cycles_offset(void)
> >  {
> > +	u32 value, count;
> > +	       
> > +	value = readl(pcic0.pcic_regs+PCI_SYS_COUNTER);
> Spaces around operators.
> 

Fixed

> > +	count = ((count/HZ)*USECS_PER_JIFFY) / (TICK_TIMER_LIMIT/HZ);
> Spaces..
> In several spots below - I will stop complining here.
> 

Everything was fixed.

> >  	/* Errm.. not sure how to do this.. */
> >  }
> >  
> > -static void __init sun4c_init_timers(irq_handler_t counter_fn)
> > +static void __init sun4c_init_timers(void)
> >  {
> >  	const struct linux_prom_irqs *prom_irqs;
> >  	struct device_node *dp;
> > @@ -207,12 +207,15 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
> >  	 * level 14 timer limit since we are letting the prom handle
> >  	 * them until we have a real console driver so L1-A works.
> >  	 */
> > -	sbus_writel((((1000000/HZ) + 1) << 10), &sun4c_timers->l10_limit);
> > +	timer_cs_period = 2000000/HZ;
> 
> Where does 2000000 come from? Is looks like it deserve a constant.
> 

Fixed

> > +	sparc_irq_config.features |= USES_TIMER_CS;
> > +	sparc_irq_config.features |= USES_TIMER_CE;
> 
> Could we name USES_xxx FEATURE_xxx as it is then more obvious that is is
> used as flags in the sparc_irq_config.features field?
> 

I'm agree, and it seems to me that it's better to make names of definitions shorter:

/* The following definitions describe the individual platform features:   */
#define FEAT_L10_CS  (1 << 0) /* L10 timer is used as a clocksource    */
#define FEAT_L10_CE  (1 << 1) /* L10 timer is used as a clockevent     */
#define FEAT_L14_OS  (1 << 2) /* L14 timer clockevent can oneshot mode */

> > +#ifdef CONFIG_SMP
> > +	timer_cs_period = 4000000; /* 2 seconds */
> > +#else
> 
> This value also deserve a descriptive constant.
> 

Fixed

> >  	static int cpu_tick[NR_CPUS];
> >  	static char led_mask[] = { 0xe, 0xd, 0xb, 0x7, 0xb, 0xd };
> >  
> > @@ -378,28 +378,15 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
> >  		show_leds(cpu);
> >  	}
> >  
> > -	profile_tick(CPU_PROFILING);
> > +	ce = &per_cpu(percpu_ce, cpu);
> >  
> > -	if (!--prof_counter(cpu)) {
> > -		int user = user_mode(regs);
> > +	irq_enter();
> > +	ce->event_handler(ce);
> > +	irq_exit();
> 
> On sparc64 we check if ce->event_handler is NULL before we do the call.
> Something we should do on sparc32 too?
> 

I don't completely understand sparc64 timers. But in case of sparc32,
clockevent handler is always set before percpu_ce_setup is called. And
there's no interrupts before percpu_ce_setup call. Other cases like
suspend and resume don't touch us.

> > -		irq_exit();
> > -
> > -		prof_counter(cpu) = prof_multiplier(cpu);
> > -	}
> >  	set_irq_regs(old_regs);
> >  }
> >  
> 
> > diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
> > index e611651..06d3910 100644
> > --- a/arch/sparc/kernel/sun4m_irq.c
> > +++ b/arch/sparc/kernel/sun4m_irq.c
> > @@ -318,9 +318,6 @@ struct sun4m_timer_global {
> >  
> >  static struct sun4m_timer_global __iomem *timers_global;
> >  
> > -
> > -unsigned int lvl14_resolution = (((1000000/HZ) + 1) << 10);
> > -
> >  static void sun4m_clear_clock_irq(void)
> >  {
> >  	sbus_readl(&timers_global->l10_limit);
> > @@ -369,10 +366,11 @@ void sun4m_clear_profile_irq(int cpu)
> >  
> >  static void sun4m_load_profile_irq(int cpu, unsigned int limit)
> >  {
> > -	sbus_writel(limit, &timers_percpu[cpu]->l14_limit);
> > +	unsigned int value = limit ? (limit + 1) << 9 : 0;
> > +	sbus_writel(value, &timers_percpu[cpu]->l14_limit);
> >  }
> >  
> > -static void __init sun4m_init_timers(irq_handler_t counter_fn)
> > +static void __init sun4m_init_timers(void)
> >  {
> >  	struct device_node *dp = of_find_node_by_name(NULL, "counter");
> >  	int i, err, len, num_cpu_timers;
> > @@ -402,13 +400,21 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
> >  	/* Every per-cpu timer works in timer mode */
> >  	sbus_writel(0x00000000, &timers_global->timer_config);
> >  
> > -	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
> > +#ifdef CONFIG_SMP
> > +	timer_cs_period = 4000000; /* 2 seconds */
> > +	sparc_irq_config.features |= PERCPU_CE_CAN_ONESHOT;
> > +#else
> > +	timer_cs_period = 2000000/HZ; /* 1/HZ */
> > +	sparc_irq_config.features |= USES_TIMER_CE;
> > +#endif
> > +	sparc_irq_config.features |= USES_TIMER_CS;
> > +	sbus_writel(((timer_cs_period + 1) << 9), &timers_global->l10_limit);
> >  
> >  	master_l10_counter = &timers_global->l10_count;
> >  
> >  	irq = sun4m_build_device_irq(NULL, SUN4M_TIMER_IRQ);
> >  
> > -	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
> > +	err = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL);
> >  	if (err) {
> >  		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
> >  			err);
> > diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
> > index 5947686..d98d307 100644
> > --- a/arch/sparc/kernel/sun4m_smp.c
> > +++ b/arch/sparc/kernel/sun4m_smp.c
> > @@ -11,6 +11,7 @@
> >  
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> > +#include <asm/timer.h>
> >  
> >  #include "irq.h"
> >  #include "kernel.h"
> > @@ -30,7 +31,6 @@ swap_ulong(volatile unsigned long *ptr, unsigned long val)
> >  }
> >  
> >  static void smp4m_ipi_init(void);
> > -static void smp_setup_percpu_timer(void);
> >  
> >  void __cpuinit smp4m_callin(void)
> >  {
> > @@ -41,8 +41,7 @@ void __cpuinit smp4m_callin(void)
> >  
> >  	notify_cpu_starting(cpuid);
> >  
> > -	/* Get our local ticker going. */
> > -	smp_setup_percpu_timer();
> > +	register_percpu_ce(cpuid);
> >  
> >  	calibrate_delay();
> >  	smp_store_cpu_info(cpuid);
> > @@ -86,7 +85,7 @@ void __cpuinit smp4m_callin(void)
> >  void __init smp4m_boot_cpus(void)
> >  {
> >  	smp4m_ipi_init();
> > -	smp_setup_percpu_timer();
> > +	sun4m_unmask_profile_irq();
> >  	local_flush_cache_all();
> >  }
> > 
> 
> The comments you raised in private mail should be refelced as comment
> in the code too I think.
> 
> "
> In case of sun4m's oneshot mode, profile irq is zeroed in smp4m_percpu_timer_interrupt().
> It maybe needless (double, triple etc overflow does nothing)
> "
> 

Fixed

> > @@ -259,37 +258,25 @@ void smp4m_cross_call_irq(void)
> >  void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
> >  {
> >  	struct pt_regs *old_regs;
> > +	struct clock_event_device *ce;
> >  	int cpu = smp_processor_id();
> >  
> >  	old_regs = set_irq_regs(regs);
> >  
> > -	sun4m_clear_profile_irq(cpu);
> > +	ce = &per_cpu(percpu_ce, cpu);
> >  
> > -	profile_tick(CPU_PROFILING);
> > +	if (ce->mode & CLOCK_EVT_MODE_PERIODIC)
> > +		sun4m_clear_profile_irq(cpu);
> > +	else
> > +		load_profile_irq(cpu, 0);
> >  
> > -	if (!--prof_counter(cpu)) {
> > -		int user = user_mode(regs);
> > +	irq_enter();
> > +	ce->event_handler(ce);
> > +	irq_exit();
> >  
> > -		irq_enter();
> > -		update_process_times(user);
> > -		irq_exit();
> > -
> > -		prof_counter(cpu) = prof_multiplier(cpu);
> > -	}
> >  	set_irq_regs(old_regs);
> >  }
> >  
> > -static void __cpuinit smp_setup_percpu_timer(void)
> > -{
> > -	int cpu = smp_processor_id();
> > -
> > -	prof_counter(cpu) = prof_multiplier(cpu) = 1;
> > -	load_profile_irq(cpu, lvl14_resolution);
> > -
> > -	if (cpu = boot_cpu_id)
> > -		sun4m_unmask_profile_irq();
> > -}
> > -
> >  static void __init smp4m_blackbox_id(unsigned *addr)
> >  {
> >  	int rd = *addr & 0x3e000000;
> > diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
> > index 1060e06..f541ac7 100644
> > --- a/arch/sparc/kernel/time_32.c
> > +++ b/arch/sparc/kernel/time_32.c
> > @@ -26,6 +26,8 @@
> >  #include <linux/rtc.h>
> >  #include <linux/rtc/m48t59.h>
> >  #include <linux/timex.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/clockchips.h>
> >  #include <linux/init.h>
> >  #include <linux/pci.h>
> >  #include <linux/ioport.h>
> > @@ -45,9 +47,24 @@
> >  #include <asm/page.h>
> >  #include <asm/pcic.h>
> >  #include <asm/irq_regs.h>
> > +#include <asm/setup.h>
> >  
> >  #include "irq.h"
> >  
> > +static __cacheline_aligned_in_smp DEFINE_SEQLOCK(timer_cs_lock);
> > +static __volatile__ u64 timer_cs_internal_counter = 0;
> 
> Init to zero is worthless. We do it during startup anyway.
> 
> > +/* Tick period in cycles */
> > +unsigned int timer_cs_period;
> > +static char timer_cs_enabled = 0;
> Init to zero is worthless.
> 

Sam, I've just grepped ./arch/sparc directory and see that there are
the different variants of static initialization.

In my opinion, zero increases readability a little bit.

> > +u32 (*get_cycles_offset)(void);
> > +
> > +static struct clock_event_device timer_ce;
> > +static char timer_ce_enabled = 0;
> Init to zero is worthless.
> > +
> > +#ifdef CONFIG_SMP
> > +DEFINE_PER_CPU(struct clock_event_device, percpu_ce);
> > +#endif
> 
> I would prefer we keep naming consistent with sparc64 naming.
> Here we name it sparc64_events - but I can see why you used another name too.
> 

Good idea.

> 
> Why is this only SMP?
> 

The appropriate code of level 14 timer support is SMP-only. There are
pieces of assembler code and I'm afraid of changing it on not sun4m
platforms. It's difficult to test it now.

May be it'll be implemented in one of the future patches, but I'm not
sure...

> 
> > +
> >  DEFINE_SPINLOCK(rtc_lock);
> >  EXPORT_SYMBOL(rtc_lock);
> >  
> > @@ -76,36 +93,165 @@ EXPORT_SYMBOL(profile_pc);
> >  
> >  __volatile__ unsigned int *master_l10_counter;
> >  
> > -u32 (*do_arch_gettimeoffset)(void);
> > -
> >  int update_persistent_clock(struct timespec now)
> >  {
> >  	return set_rtc_mmss(now.tv_sec);
> >  }
> >  
> > -/*
> > - * timer_interrupt() needs to keep up the real-time clock,
> > - * as well as call the "xtime_update()" routine every clocktick
> > - */
> > +irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
> > +{
> > +	if (timer_cs_enabled) {
> > +		write_seqlock(&timer_cs_lock);
> > +		timer_cs_internal_counter ++;
> 
> Drop space before ++
> 

Fixed

> > +		clear_clock_irq();
> > +		write_sequnlock(&timer_cs_lock);
> > +	} else
> > +		clear_clock_irq();
> >  
> > -#define TICK_SIZE (tick_nsec / 1000)
> > +	if (timer_ce_enabled)
> > +		timer_ce.event_handler(&timer_ce);
> >  
> > -static irqreturn_t timer_interrupt(int dummy, void *dev_id)
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void timer_ce_set_mode(enum clock_event_mode mode,
> > +			      struct clock_event_device *evt)
> >  {
> > -#ifndef CONFIG_SMP
> > -	profile_tick(CPU_PROFILING);
> > -#endif
> > +	switch (mode) {
> > +		case CLOCK_EVT_MODE_PERIODIC:
> > +		case CLOCK_EVT_MODE_RESUME:
> > +			timer_ce_enabled = 1;
> > +			break;
> > +		case CLOCK_EVT_MODE_SHUTDOWN:
> > +			timer_ce_enabled = 0;
> > +			break;
> > +		default:
> > +			break;
> > +	}
> > +	smp_mb();
> > +}
> >  
> > -	clear_clock_irq();
> > +static __init void setup_timer_ce(void)
> > +{
> > +	struct clock_event_device *ce = &timer_ce;
> >  
> > -	xtime_update(1);
> > +	BUG_ON(smp_processor_id() != boot_cpu_id);
> >  
> > -#ifndef CONFIG_SMP
> > -	update_process_times(user_mode(get_irq_regs()));
> > -#endif
> > -	return IRQ_HANDLED;
> > +	ce->name		= "timer_ce";
> > +	ce->rating		= 100;
> > +	ce->features		= CLOCK_EVT_FEAT_PERIODIC;
> > +	ce->set_mode		= timer_ce_set_mode;
> > +	ce->cpumask		= cpu_possible_mask;
> > +	ce->shift		= 32;
> > +	ce->mult		= div_sc(2000000, NSEC_PER_SEC, ce->shift);
> > +
> > +	clockevents_register_device(ce);
> > +}
> > +
> > +static u32 sbus_cycles_offset(void)
> > +{
> > +	unsigned int val, offset;
> > +
> > +	val = *master_l10_counter;
> > +	offset = (val >> 9) & 0x3fffff;
> > +
> > +	/* Limit hit? */
> > +	if (val & 0x80000000)
> > +		offset += timer_cs_period;
> > +
> > +	return offset;
> > +}
> > +
> > +static cycle_t timer_cs_read(struct clocksource *cs)
> > +{
> > +	unsigned int seq, offset;
> > +	u64 cycles;
> > +
> > +	do {
> > +		seq = read_seqbegin(&timer_cs_lock);
> > +
> > +		cycles = timer_cs_internal_counter;
> > +		offset = get_cycles_offset();
> > +	} while (read_seqretry(&timer_cs_lock, seq));
> > +
> > +	/* Count absolute cycles */
> > +	cycles *= timer_cs_period;
> > +	cycles += offset;
> > +
> > +	return cycles;
> > +}
> > +
> > +static struct clocksource timer_cs = {
> > +	.name	= "timer_cs",
> > +	.rating	= 100,
> > +	.read	= timer_cs_read,
> > +	.mask	= CLOCKSOURCE_MASK(64),
> > +	.shift	= 2,
> > +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> > +
> > +static __init int setup_timer_cs(void)
> > +{
> > +	timer_cs_enabled = 1;
> > +	/* Clock rate is 2MHz */
> > +	timer_cs.mult = clocksource_hz2mult(2000000, timer_cs.shift);
> > +
> > +	return clocksource_register(&timer_cs);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static void percpu_ce_setup(enum clock_event_mode mode,
> > +			struct clock_event_device *evt)
> > +{
> > +	int cpu = __first_cpu(evt->cpumask);
> > +
> > +	switch (mode) {
> > +		case CLOCK_EVT_MODE_PERIODIC:
> > +			load_profile_irq(cpu, 2000000/HZ);
> > +			break;
> > +		case CLOCK_EVT_MODE_ONESHOT:
> > +		case CLOCK_EVT_MODE_SHUTDOWN:
> > +		case CLOCK_EVT_MODE_UNUSED:
> > +			load_profile_irq(cpu, 0);
> > +			break;
> > +		default:
> > +			break;
> > +	}
> >  }
> >  
> > +static int percpu_ce_set_next_event(unsigned long delta,
> > +				    struct clock_event_device *evt)
> > +{
> > +	int cpu = __first_cpu(evt->cpumask);
> > +	unsigned int next = (unsigned int)delta;
> > +
> > +	load_profile_irq(cpu, next);
> > +	return 0;
> > +}
> > +
> > +void register_percpu_ce(int cpu)
> > +{
> > +	struct clock_event_device *ce = &per_cpu(percpu_ce, cpu);
> > +	unsigned int features = CLOCK_EVT_FEAT_PERIODIC;
> > +
> > +	if (sparc_irq_config.features & PERCPU_CE_CAN_ONESHOT)
> > +		features |= CLOCK_EVT_FEAT_ONESHOT;
> > +
> > +	ce->name		= "percpu_ce";
> > +	ce->rating		= 200;
> > +	ce->features		= features;
> > +	ce->set_mode		= percpu_ce_setup;
> > +	ce->set_next_event	= percpu_ce_set_next_event;
> > +	ce->cpumask		= cpumask_of(cpu);
> > +	ce->shift		= 32;
> > +	ce->mult		= div_sc(2000000, NSEC_PER_SEC, ce->shift);
> > +	ce->max_delta_ns	= clockevent_delta2ns(2000000, ce);
> > +	ce->min_delta_ns	= clockevent_delta2ns(100, ce);
> > +
> > +	clockevents_register_device(ce);
> > +}
> > +#endif
> > +
> >  static unsigned char mostek_read_byte(struct device *dev, u32 ofs)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> > @@ -196,42 +342,36 @@ static int __init clock_init(void)
> >   */
> >  fs_initcall(clock_init);
> >  
> > -
> > -u32 sbus_do_gettimeoffset(void)
> > -{
> > -	unsigned long val = *master_l10_counter;
> > -	unsigned long usec = (val >> 10) & 0x1fffff;
> > -
> > -	/* Limit hit?  */
> > -	if (val & 0x80000000)
> > -		usec += 1000000 / HZ;
> > -
> > -	return usec * 1000;
> > -}
> > -
> > -
> > -u32 arch_gettimeoffset(void)
> > +static void __init sparc32_late_time_init(void)
> >  {
> > -	if (unlikely(!do_arch_gettimeoffset))
> > -		return 0;
> > -	return do_arch_gettimeoffset();
> > +	if (sparc_irq_config.features & USES_TIMER_CE)
> > +		setup_timer_ce();
> > +	if (sparc_irq_config.features & USES_TIMER_CS)
> > +		setup_timer_cs();
> > +#ifdef CONFIG_SMP
> > +	register_percpu_ce(smp_processor_id());
> > +#endif
> >  }
> >  
> >  static void __init sbus_time_init(void)
> >  {
> > -	do_arch_gettimeoffset = sbus_do_gettimeoffset;
> > -
> > -	btfixup();
> > +	get_cycles_offset = sbus_cycles_offset;
> >  
> > -	sparc_irq_config.init_timers(timer_interrupt);
> > +	sparc_irq_config.init_timers();
> >  }
> >  
> >  void __init time_init(void)
> >  {
> > +	btfixup();
> > +
> > +	sparc_irq_config.features = 0;
> > +
> >  	if (pcic_present())
> >  		pci_time_init();
> >  	else
> >  		sbus_time_init();
> > +
> > +	late_time_init = sparc32_late_time_init;
> >  }
> 
> In the next patch please include relevant LEON people,
> so they can try to check how to enable this on LEON.
> 
> And submit it as a new mail - so it get attention.
> 
> 	Sam

Kirill

> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


