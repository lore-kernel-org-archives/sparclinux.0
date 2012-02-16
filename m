From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 16 Feb 2012 07:47:33 +0000
Subject: Re: [PATCH] sparc32: GENERIC_CLOCKEVENTS support
Message-Id: <4F3CB495.6080303@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120215170246.GA7847@merkur.ravnborg.org>
In-Reply-To: <20120215170246.GA7847@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 02/15/2012 06:02 PM, Sam Ravnborg wrote:
> Hi Kirill.
>
> On Wed, Feb 08, 2012 at 02:09:36AM +0400, Kirill Tkhai wrote:
>> This patch implements GENERIC_CLOCKEVENTS support on sparc32.
>>
>> The kernel uses l14 timers as clockevents. l10 timer is used
>> as clocksource if platform master_l10_counter isn't constantly
>> zero. The clocksource is continuous, so it's possible to use
>> high resolution timers. l10 timer is also used as clockevent
>> on UP configurations.
>>
>> This realization is for sun4m, sun4d, sun4c and microsparc-IIep
>> platforms.
> I have looked through the code and I had a couple of minor
> issues with it. See attached patch which go on top of yours.
>
> > From a functionality point of view I saw no problems,
> but I am not intiminate with neither sparc timers
> nor clockevents.
>
> I have tried out the patch on my sun4m box,
> and /proc/timer_list showed the new timers.
> I did not try your test-program - but I can do so if you like.
>
>
>> It's necessary to make appropriate changes for LEON
>> part (it should not have l10 based cs and ce in case of SMP
>> because of LEON's master_l10_counter is zero).
> How do we go forward with Leon now?
> Daniel - can you help here?

I have started looking at the code, but I haven't got into the clocksource/event interface yet.

As I understand the master_l10_counter points to a timer counter register (similar on all SUN SPARCs) which can be access to get the current time in nanoseconds between ticks. However on LEON I think 
it is faulty declared to always point to zero, on LEON one can get an exact usec value from the LEON timer (GPTIMER), however the calculation to get usec is different than from pcic/sbus. I try to 
understand what impact that has, probably that gettimeofday() only has "tick" accuracy. It look as a LEON bug to me.

Do you know if there are documentation available on the clocksource/event interface?

Daniel

>> Thanks to Sam Ravnborg for the review and comments.
> You can add my:
> Reviewed-by: Sam Ravnborg<sam@ravnborg.org>
>
> 	Sam
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 3ee5d1f..71794fc 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -77,8 +77,7 @@ config GENERIC_CMOS_UPDATE
>   	default y
>
>   config GENERIC_CLOCKEVENTS
> -	bool
> -	default y
> +	def_bool y
>
>   config IOMMU_HELPER
>   	bool
> diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
> index 3a5c24b..492190d 100644
> --- a/arch/sparc/include/asm/timer_32.h
> +++ b/arch/sparc/include/asm/timer_32.h
> @@ -15,6 +15,21 @@
>   #include<asm/btfixup.h>
>
>   #define SBUS_CLOCK_RATE	2000000 /* 2MHz */
> +#define TIMER_VALUE_SHIFT 9
> +#define TIMER_VALUE_MASK 0x3fffff
> +#define TIMER_LIMIT_BIT (1<<  31)  /* Bit 31 in Counter-Timer register */
> +
> +/* The counter timer register has the value offset by 9 bits.
> + * From sun4m manual:
> + * When a counter reaches the value in the corresponding limit register,
> + * the Limit bit is set and the counter is set to 500 nS (i.e. 0x00000200).
> + *
> + * To compensate for this add one to the value.
> + */
> +static inline unsigned int timer_value(unsigned int value)
> +{
> +	return (value + 1)<<  TIMER_VALUE_SHIFT;
> +}
>
>   extern __volatile__ unsigned int *master_l10_counter;
>   extern unsigned int (*get_cycles_offset)(void);
> diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
> index cbfba9f..fc59aab 100644
> --- a/arch/sparc/kernel/irq.h
> +++ b/arch/sparc/kernel/irq.h
> @@ -40,10 +40,10 @@ struct sun4m_irq_global {
>   extern struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
>   extern struct sun4m_irq_global __iomem *sun4m_irq_global;
>
> -/* The following definitions describe the individual platform features:   */
> -#define FEAT_L10_CS	(1<<  0) /* L10 timer is used as a clocksource    */
> -#define FEAT_L10_CE	(1<<  1) /* L10 timer is used as a clockevent     */
> -#define FEAT_L14_OS	(1<<  2) /* L14 timer clockevent can oneshot mode */
> +/* The following definitions describe the individual platform features: */
> +#define FEAT_L10_CLOCKSOURCE (1<<  0) /* L10 timer is used as a clocksource */
> +#define FEAT_L10_CLOCKEVENT  (1<<  1) /* L10 timer is used as a clockevent */
> +#define FEAT_L14_ONESHOT     (1<<  2) /* L14 timer clockevent can oneshot */
>
>   /*
>    * Platform specific irq configuration
> diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
> index 090f6af..5dce17a 100644
> --- a/arch/sparc/kernel/pcic.c
> +++ b/arch/sparc/kernel/pcic.c
> @@ -710,7 +710,7 @@ static void pcic_clear_clock_irq(void)
>   static u32 pcic_cycles_offset(void)
>   {
>   	u32 value, count;
> -	
> +
>   	value = readl(pcic0.pcic_regs + PCI_SYS_COUNTER);
>   	count = value&  ~PCI_SYS_COUNTER_OVERFLOW;
>
> @@ -739,9 +739,9 @@ void __init pci_time_init(void)
>   	 * We take into account this in pcic_cycles_offset()
>   	 */
>   	timer_cs_period = SBUS_CLOCK_RATE / HZ;
> -	sparc_irq_config.features |= FEAT_L10_CE;
> +	sparc_irq_config.features |= FEAT_L10_CLOCKEVENT;
>   #endif
> -	sparc_irq_config.features |= FEAT_L10_CS;
> +	sparc_irq_config.features |= FEAT_L10_CLOCKSOURCE;
>   	get_cycles_offset = pcic_cycles_offset;
>
>   	writel (TICK_TIMER_LIMIT, pcic->pcic_regs+PCI_SYS_LIMIT);
> diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
> index caaa7b9..bbd1954 100644
> --- a/arch/sparc/kernel/sun4c_irq.c
> +++ b/arch/sparc/kernel/sun4c_irq.c
> @@ -208,8 +208,9 @@ static void __init sun4c_init_timers(void)
>   	 * them until we have a real console driver so L1-A works.
>   	 */
>   	timer_cs_period = SBUS_CLOCK_RATE / HZ;
> -	sparc_irq_config.features |= (FEAT_L10_CS | FEAT_L10_CE);
> -	sbus_writel(((timer_cs_period + 1)<<  9),&sun4c_timers->l10_limit);
> +	sparc_irq_config.features |> +	    FEAT_L10_CLOCKSOURCE | FEAT_L10_CLOCKEVENT;
> +	sbus_writel(timer_value(timer_cs_period),&sun4c_timers->l10_limit);
>
>   	master_l10_counter =&sun4c_timers->l10_count;
>
> diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
> index 7fb9437..5f8068a 100644
> --- a/arch/sparc/kernel/sun4d_irq.c
> +++ b/arch/sparc/kernel/sun4d_irq.c
> @@ -282,7 +282,7 @@ static void sun4d_clear_clock_irq(void)
>
>   static void sun4d_load_profile_irq(int cpu, unsigned int limit)
>   {
> -	unsigned int value = limit ? (limit + 1)<<  9 : 0;
> +	unsigned int value = limit ? timer_value(limit) : 0;
>   	bw_set_prof_limit(cpu, value);
>   }
>
> @@ -471,10 +471,11 @@ static void __init sun4d_init_timers(void)
>   	timer_cs_period = SBUS_CLOCK_RATE * 2;  /* 2 seconds */
>   #else
>   	timer_cs_period = SBUS_CLOCK_RATE / HZ; /* 1/HZ sec  */
> -	sparc_irq_config.features |= FEAT_L10_CE;
> +	sparc_irq_config.features |= FEAT_L10_CLOCKEVENT;
>   #endif
> -	sparc_irq_config.features |= FEAT_L10_CS;
> -	sbus_writel(((timer_cs_period + 1)<<  9),&sun4d_timers->l10_timer_limit);
> +	sparc_irq_config.features |= FEAT_L10_CLOCKSOURCE;
> +	sbus_writel(timer_value(timer_cs_period),
> +		&sun4d_timers->l10_timer_limit);
>
>   	master_l10_counter =&sun4d_timers->l10_cur_count;
>
> diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
> index 0f8f3b6..a81553e 100644
> --- a/arch/sparc/kernel/sun4m_irq.c
> +++ b/arch/sparc/kernel/sun4m_irq.c
> @@ -366,7 +366,7 @@ void sun4m_clear_profile_irq(int cpu)
>
>   static void sun4m_load_profile_irq(int cpu, unsigned int limit)
>   {
> -	unsigned int value = limit ? (limit + 1)<<  9 : 0;
> +	unsigned int value = limit ? timer_value(limit) : 0;
>   	sbus_writel(value,&timers_percpu[cpu]->l14_limit);
>   }
>
> @@ -402,13 +402,13 @@ static void __init sun4m_init_timers(void)
>
>   #ifdef CONFIG_SMP
>   	timer_cs_period = SBUS_CLOCK_RATE * 2;  /* 2 seconds */
> -	sparc_irq_config.features |= FEAT_L14_OS;
> +	sparc_irq_config.features |= FEAT_L14_ONESHOT;
>   #else
>   	timer_cs_period = SBUS_CLOCK_RATE / HZ; /* 1/HZ sec  */
> -	sparc_irq_config.features |= FEAT_L10_CE;
> +	sparc_irq_config.features |= FEAT_L10_CLOCKEVENT;
>   #endif
> -	sparc_irq_config.features |= FEAT_L10_CS;
> -	sbus_writel(((timer_cs_period + 1)<<  9),&timers_global->l10_limit);
> +	sparc_irq_config.features |= FEAT_L10_CLOCKSOURCE;
> +	sbus_writel(timer_value(timer_cs_period),&timers_global->l10_limit);
>
>   	master_l10_counter =&timers_global->l10_count;
>
> diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
> index fc66bff..bc27bb5 100644
> --- a/arch/sparc/kernel/time_32.c
> +++ b/arch/sparc/kernel/time_32.c
> @@ -153,10 +153,10 @@ static u32 sbus_cycles_offset(void)
>   	unsigned int val, offset;
>
>   	val = *master_l10_counter;
> -	offset = (val>>  9)&  0x3fffff;
> +	offset = (val>>  TIMER_VALUE_SHIFT)&  TIMER_VALUE_MASK;
>
>   	/* Limit hit? */
> -	if (val&  0x80000000)
> +	if (val&  TIMER_LIMIT_BIT)
>   		offset += timer_cs_period;
>
>   	return offset;
> @@ -207,7 +207,7 @@ static void percpu_ce_setup(enum clock_event_mode mode,
>
>   	switch (mode) {
>   		case CLOCK_EVT_MODE_PERIODIC:
> -			load_profile_irq(cpu, SBUS_CLOCK_RATE/HZ);
> +			load_profile_irq(cpu, SBUS_CLOCK_RATE / HZ);
>   			break;
>   		case CLOCK_EVT_MODE_ONESHOT:
>   		case CLOCK_EVT_MODE_SHUTDOWN:
> @@ -234,7 +234,7 @@ void register_percpu_ce(int cpu)
>   	struct clock_event_device *ce =&per_cpu(sparc32_clockevent, cpu);
>   	unsigned int features = CLOCK_EVT_FEAT_PERIODIC;
>
> -	if (sparc_irq_config.features&  FEAT_L14_OS)
> +	if (sparc_irq_config.features&  FEAT_L14_ONESHOT)
>   		features |= CLOCK_EVT_FEAT_ONESHOT;
>
>   	ce->name		= "l14_ce";
> @@ -345,9 +345,9 @@ fs_initcall(clock_init);
>
>   static void __init sparc32_late_time_init(void)
>   {
> -	if (sparc_irq_config.features&  FEAT_L10_CE)
> +	if (sparc_irq_config.features&  FEAT_L10_CLOCKEVENT)
>   		setup_timer_ce();
> -	if (sparc_irq_config.features&  FEAT_L10_CS)
> +	if (sparc_irq_config.features&  FEAT_L10_CLOCKSOURCE)
>   		setup_timer_cs();
>   #ifdef CONFIG_SMP
>   	register_percpu_ce(smp_processor_id());
>
>

