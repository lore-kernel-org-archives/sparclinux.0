From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 21 Mar 2019 15:49:37 +0000
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each policy
Message-Id: <alpine.DEB.2.21.1903211645100.1784@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
In-Reply-To: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On Wed, 20 Mar 2019, Viresh Kumar wrote:

> Currently we call these notifiers once for each CPU of the policy->cpus

Nitpick: We call nothing. The notifiers are called ....

> cpumask. It would be more optimal if the notifier can be called only
> once and all the relevant information be provided to it. Out of the 23
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3fae23834069..b2fe665878f7 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -958,10 +958,15 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_freqs *freq = data;
>  	unsigned long *lpj;
>  
> +	if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1)) {
> +		mark_tsc_unstable("cpufreq changes: related CPUs affected");
> +		return 0;
> +	}

You might add a check which ensures that policy->cpu = smp_processor_id()
because if this is not the case ....

Thanks,

	tglx
