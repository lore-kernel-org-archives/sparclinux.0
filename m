From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Mon, 04 Jun 2012 06:53:19 +0000
Subject: Re: [PATCH] sparc32: refactor smp boot
Message-Id: <4FCC5A2C.1030004@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120601.135612.699120609738854050.davem@davemloft.net> <20120601185448.GA19148@merkur.ravnborg.org> <4FC94693.5050707@linux.vnet.ibm.com> <20120602065249.GA19558@merkur.ravnborg.org> <20120602074424.GA19690@merkur.ravnborg.org> <4FC9C871.60902@linux.vnet.ibm.com> <20120602151348.GA17409@merkur.ravnborg.org> <4FCA382B.6050601@linux.vnet.ibm.com> <20120602162340.GA27530@merkur.ravnborg.org> <4FCA40A5.3060409@linux.vnet.ibm.com> <20120603211752.GA7594@merkur.ravnborg.org>
In-Reply-To: <20120603211752.GA7594@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, vapier@gentoo.org, konrad@gaisler.com, tkhai@yandex.ru, sparclinux@vger.kernel.org

On 06/04/2012 02:47 AM, Sam Ravnborg wrote:

> From 531d9c538fc60c15363890768ea416897853d6af Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 3 Jun 2012 23:08:18 +0200
> Subject: [PATCH] sparc32: refactor smp boot
> 
> Introduce a common smp_callin() function to call
> from trampoline_32.S.
> Add platform specific functions to handle the
> platform details.
> 
> This is in preparation for a patch that will
> unify the smp boot stuff for all architectures.
> sparc32 was significantly different to warrant
> this patch in preparation.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> Hi Srivatsa.
> 
> This should address all your comemnts (thanks!).
> I assume you will include this patch in your serie.
> 


Of course, thanks for your work!

As soon as the Xen problem gets sorted out (patch 5), I will send out
a v2 including your patch and addressing all the comments received
so far.

> diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c

> index ddaea31..c9eb82f 100644
> --- a/arch/sparc/kernel/sun4d_smp.c
> +++ b/arch/sparc/kernel/sun4d_smp.c
> @@ -50,10 +50,9 @@ static inline void show_leds(int cpuid)
>  			      "i" (ASI_M_CTL));
>  }
> 
> -void __cpuinit smp4d_callin(void)
> +void __cpuinit sun4d_cpu_pre_starting(void *arg)
>  {
>  	int cpuid = hard_smp_processor_id();
> -	unsigned long flags;
> 
>  	/* Show we are alive */
>  	cpu_leds[cpuid] = 0x6;
> @@ -61,26 +60,20 @@ void __cpuinit smp4d_callin(void)
> 
>  	/* Enable level15 interrupt, disable level14 interrupt for now */
>  	cc_set_imsk((cc_get_imsk() & ~0x8000) | 0x4000);
> +}
> 
> -	local_ops->cache_all();
> -	local_ops->tlb_all();
> +void __cpuinit sun4d_cpu_pre_online(void *arg)
> +{
> +	unsigned long flags;
> +	int cpuid;
> 
> -	notify_cpu_starting(cpuid);
> -	/*
> -	 * Unblock the master CPU _only_ when the scheduler state
> +	cpuid = hard_smp_processor_id();
> +
> +	/* Unblock the master CPU _only_ when the scheduler state
>  	 * of all secondary CPUs will be up-to-date, so after
>  	 * the SMP initialization the master will be just allowed
>  	 * to call the scheduler code.
>  	 */


Looks like you forgot to update this comment.
Its ok, I'll update your patch and include it in the series.

Regards,
Srivatsa S. Bhat

> -	/* Get our local ticker going. */
> -	register_percpu_ce(cpuid);
> -
> -	calibrate_delay();
> -	smp_store_cpu_info(cpuid);
> -	local_ops->cache_all();
> -	local_ops->tlb_all();
> -
> -	/* Allow master to continue. */
>  	sun4d_swap((unsigned long *)&cpu_callin_map[cpuid], 1);
>  	local_ops->cache_all();
>  	local_ops->tlb_all();
> @@ -106,16 +99,12 @@ void __cpuinit smp4d_callin(void)
>  	local_ops->cache_all();
>  	local_ops->tlb_all();
> 
> -	local_irq_enable();	/* We don't allow PIL 14 yet */
> -
>  	while (!cpumask_test_cpu(cpuid, &smp_commenced_mask))
>  		barrier();
> 
>  	spin_lock_irqsave(&sun4d_imsk_lock, flags);
>  	cc_set_imsk(cc_get_imsk() & ~0x4000); /* Allow PIL 14 as well */
>  	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
> -	set_cpu_online(cpuid, true);
> -
>  }
> 


