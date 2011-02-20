From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 20 Feb 2011 00:22:01 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq support
Message-Id: <20110220002201.GA17997@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298130424-6934-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298130424-6934-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Feb 19, 2011 at 04:47:04PM +0100, Sam Ravnborg wrote:
> --- a/arch/sparc/kernel/sun4d_irq.c
> +++ b/arch/sparc/kernel/sun4d_irq.c

> -static void __init sun4d_init_timers(irq_handler_t counter_fn)
> -{
> -	struct device_node *dp;
> -	struct resource res;
> -	const u32 *reg;
> -	int err;
> -
> -	dp = of_find_node_by_name(NULL, "cpu-unit");
> -	if (!dp) {
> -		prom_printf("sun4d_init_timers: Unable to find cpu-unit\n");
> -		prom_halt();
> -	}
> -
> -	/* Which cpu-unit we use is arbitrary, we can view the bootbus timer
> -	 * registers via any cpu's mapping.  The first 'reg' property is the
> -	 * bootbus.
> -	 */
> -	reg = of_get_property(dp, "reg", NULL);
> -	of_node_put(dp);
> -	if (!reg) {
> -		prom_printf("sun4d_init_timers: No reg property\n");
> -		prom_halt();
> -	}
> -
> -	res.start = reg[1];
> -	res.end = reg[2] - 1;
> -	res.flags = reg[0] & 0xff;
> -	sun4d_timers = of_ioremap(&res, BW_TIMER_LIMIT,
> -				  sizeof(struct sun4d_timer_regs), "user timer");
> -	if (!sun4d_timers) {
> -		prom_printf("sun4d_init_timers: Can't map timer regs\n");
> -		prom_halt();
> -	}
> -
> -	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
> -
> -	master_l10_counter = &sun4d_timers->l10_cur_count;
> -
> -	err = request_irq(TIMER_IRQ, counter_fn,
> -			  (IRQF_DISABLED | SA_STATIC_ALLOC),
> -			  "timer", NULL);
> -	if (err) {
> -		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
> -		             err);
> -		prom_halt();
> -	}
> -	sun4d_load_profile_irqs();
> -	sun4d_fixup_trap_table();
> -}
> -

> +static void __init sun4d_init_timers(irq_handler_t counter_fn)
> +{
> +	struct device_node *dp;
> +	struct resource res;
> +	unsigned int irq;
> +	const u32 *reg;
> +	int err;
> +
> +	dp = of_find_node_by_name(NULL, "cpu-unit");
> +	if (!dp) {
> +		prom_printf("sun4d_init_timers: Unable to find cpu-unit\n");
> +		prom_halt();
> +	}
> +
> +	/* Which cpu-unit we use is arbitrary, we can view the bootbus timer
> +	 * registers via any cpu's mapping.  The first 'reg' property is the
> +	 * bootbus.
> +	 */
> +	reg = of_get_property(dp, "reg", NULL);
> +	of_node_put(dp);
> +	if (!reg) {
> +		prom_printf("sun4d_init_timers: No reg property\n");
> +		prom_halt();
> +	}
> +
> +	res.start = reg[1];
> +	res.end = reg[2] - 1;
> +	res.flags = reg[0] & 0xff;
> +	sun4d_timers = of_ioremap(&res, BW_TIMER_LIMIT,
> +				  sizeof(struct sun4d_timer_regs), "user timer");
> +	if (!sun4d_timers) {
> +		prom_printf("sun4d_init_timers: Can't map timer regs\n");
> +		prom_halt();
> +	}
> +
> +	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
> +
> +	master_l10_counter = &sun4d_timers->l10_cur_count;
>  
> -err_out:
> -	return interrupt;
> +	irq = sun4d_build_device_irq(NULL, SUN4D_TIMER_IRQ);
> +	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
> +	if (err) {
> +		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
> +		             err);
> +		prom_halt();
> +	}
> +	sun4d_load_profile_irqs();
> +	sun4d_fixup_trap_table();
>  }
>  
> +

In this case the diff output isn't really useful, it has to be re-diffed
manually to see the actual difference. Granted, it's nothing important
in this case, but you should try to keep the mostly identical functions in
the same place in the same commit, and then move the new version into
a new place in a later commit, so that functional changes don't get
obscured by formatting changes.

(Sorry not to be of any actual help - the oldest sparc machine I have access
to is an Ultra 5, and even that one is so slow that it makes the simple act
of compiling the kernel to test it - really tedious *shrug* :)

-- 
     2. That which causes joy or happiness.
