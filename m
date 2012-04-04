From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Apr 2012 09:18:24 +0000
Subject: Re: [PATCH]sparc32: GENERIC_CLOCKEVENTS support
Message-Id: <20120404091824.GA22509@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1328652576.12417.3.camel@hp>
In-Reply-To: <1328652576.12417.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all.

I have started to look into this combined patch-set.

The leon part puzzeles me a bit...
Ir looks like the leon parts duplicate in several cases what
we already have in time_32.c.
But we prefer to use the same base functions for all platforms
when it is possible.


> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> index a19c8a0..62afe3f 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -10,6 +10,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/interrupt.h>
>  #include <linux/of_device.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
>  
>  #include <asm/oplib.h>
>  #include <asm/timer.h>
> @@ -27,12 +29,18 @@
>  struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address */
>  struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address */
>  
> +static __cacheline_aligned_in_smp DEFINE_SEQLOCK(leon_timer_cs_lock);
> +static __volatile__ u64 leon_timer_cs_internal_counter = 0;

time_32.c already define these..

>  int leondebug_irq_disable;
>  int leon_debug_irqout;
>  static int dummy_master_l10_counter;
>  unsigned long amba_system_id;
>  static DEFINE_SPINLOCK(leon_irq_lock);
>  
> +static char leon_timer_cs_enabled = 0;
> +#ifndef CONFIG_SMP
> +static char leon_timer_ce_enabled = 0;
> +#endif
Likewise.

>  unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
>  unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
>  int leon3_ticker_irq; /* Timer ticker IRQ */
> @@ -250,7 +258,177 @@ void leon_update_virq_handling(unsigned int virq,
>  	irq_set_chip_data(virq, (void *)mask);
>  }
>  
> -void __init leon_init_timers(irq_handler_t counter_fn)
> +static u32 leon_cycles_offset(void)
> +{
> +	u32 rld, val, off;
> +	rld = LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].rld);
> +	val = LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].val);
> +	off = rld - val;
> +	return rld - val;
> +}
OK

> +
> +static cycle_t leon_timer_cs_read(struct clocksource *cs)
> +{
> +	unsigned int seq, offset;
> +	u64 cycles;
> +
> +	do {
> +		seq = read_seqbegin(&leon_timer_cs_lock);
> +		cycles = leon_timer_cs_internal_counter;
> +		offset = leon_cycles_offset();
> +	} while (read_seqretry(&leon_timer_cs_lock, seq));
> +
> +	cycles *= timer_cs_period;
> +	cycles += offset;
> +	return cycles;
> +}
This is an exact copy of time_32.c:timer_cs_read - except that is
uses the leon specific variables.

> +
> +static struct clocksource leon_timer_cs = {
> +	.name	= "grtimer-cs",
> +	.rating	= 200,
> +	.read	= leon_timer_cs_read,
> +	.mask	= CLOCKSOURCE_MASK(32),
> +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +#ifndef CONFIG_SMP
> +
> +static void leon_timer_ce_set_mode(enum clock_event_mode mode,
> +			      struct clock_event_device *evt)
> +{
> +	switch (mode) {
> +		case CLOCK_EVT_MODE_PERIODIC:
> +		case CLOCK_EVT_MODE_RESUME:
> +			leon_timer_ce_enabled = 1;
> +			break;
> +		case CLOCK_EVT_MODE_SHUTDOWN:
> +			leon_timer_ce_enabled = 0;
> +			break;
> +		default:
> +			break;
> +	}
> +	smp_mb();
> +}
Copy of time_32.c:timer_ce_set_mode

> +
> +static struct clock_event_device leon_timer_ce = {
> +	.name	  = "grtimer-ce",
> +	.rating	  = 100,
> +	.features = CLOCK_EVT_FEAT_PERIODIC,
> +	.set_mode = leon_timer_ce_set_mode,
> +	.shift    = 32
> +};
OK
> +
> +#endif /* !CONFIG_SMP */
> +
> +static void __init leon_late_time_init(void)
> +{
> +	leon_timer_cs_enabled = 1;
> +
> +	clocksource_register_hz(&leon_timer_cs, 1000000);
> +
> +#ifdef CONFIG_SMP
> +	leon_register_percpu_ce(smp_processor_id());
> +#else
> +	BUG_ON(smp_processor_id() != boot_cpu_id);
> +	leon_timer_ce.cpumask = cpu_possible_mask;
> +	leon_timer_ce.mult    = div_sc(1000000, NSEC_PER_SEC,
> +				       leon_timer_ce.shift);
> +	clockevents_register_device(&leon_timer_ce);
> +#endif /* CONFIG_SMP */
> +}
> +
> +/* clocksource irq, non-smp clockevent */
> +irqreturn_t notrace leon_timer_interrupt(int dummy, void *dev_id)
> +{
> +	if (leon_timer_cs_enabled) {
> +		write_seqlock(&leon_timer_cs_lock);
> +		leon_timer_cs_internal_counter++;
> +		write_sequnlock(&leon_timer_cs_lock);
> +	}
> +#ifndef CONFIG_SMP
> +	if (leon_timer_ce_enabled) {
> +		if (leon_timer_ce.event_handler)
> +			leon_timer_ce.event_handler(&leon_timer_ce);
> +	}
> +	
> +#endif
> +	return IRQ_HANDLED;
> +}
Copy of time_32.c:timer_interrupt

Are there any special reason for this duplication that I have missed?

I will look a bit deeper into the patch later today or
one of the following days.

	Sam

