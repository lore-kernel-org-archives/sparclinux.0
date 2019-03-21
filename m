From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 21 Mar 2019 11:45:35 +0000
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each policy
Message-Id: <20190321114535.GM6058@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
In-Reply-To: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-pm@vger.kernel.org, x86@kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On Wed, Mar 20, 2019 at 10:22:23AM +0530, Viresh Kumar wrote:
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

I suspect this is a big fat nop, but it won't hurt.

> +		return 0;
> +	}
> +
>  	lpj = &boot_cpu_data.loops_per_jiffy;
>  #ifdef CONFIG_SMP
>  	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> +		lpj = &cpu_data(freq->policy->cpu).loops_per_jiffy;
>  #endif
>  
>  	if (!ref_freq) {
> @@ -977,7 +982,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
>  			mark_tsc_unstable("cpufreq changes");
>  
> -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> +		set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
>  	}
>  
>  	return 0;

Just wondering, since we say x86 cpufreq handlers will only have a
single CPU here,

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 65e4559eef2f..1ac8c710cccc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6649,10 +6649,8 @@ static void kvm_hyperv_tsc_notifier(void)
>  }
>  #endif
>  
> -static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> -				     void *data)
> +static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
>  {
> -	struct cpufreq_freqs *freq = data;
>  	struct kvm *kvm;
>  	struct kvm_vcpu *vcpu;
>  	int i, send_ipi = 0;
> @@ -6696,17 +6694,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
>  	 *
>  	 */
>  
> -	if (val = CPUFREQ_PRECHANGE && freq->old > freq->new)
> -		return 0;
> -	if (val = CPUFREQ_POSTCHANGE && freq->old < freq->new)
> -		return 0;
> -
> -	smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> +	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
>  
>  	spin_lock(&kvm_lock);
>  	list_for_each_entry(kvm, &vm_list, vm_list) {
>  		kvm_for_each_vcpu(i, vcpu, kvm) {
> -			if (vcpu->cpu != freq->cpu)
> +			if (vcpu->cpu != cpu)
>  				continue;
>  			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
>  			if (vcpu->cpu != smp_processor_id())
> @@ -6728,8 +6721,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
>  		 * guest context is entered kvmclock will be updated,
>  		 * so the guest will not see stale values.
>  		 */
> -		smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> +		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
>  	}
> +}
> +
> +static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> +				     void *data)
> +{
> +	struct cpufreq_freqs *freq = data;
> +	int cpu;
> +
> +	if (val = CPUFREQ_PRECHANGE && freq->old > freq->new)
> +		return 0;
> +	if (val = CPUFREQ_POSTCHANGE && freq->old < freq->new)
> +		return 0;
> +
> +	for_each_cpu(cpu, freq->policy->cpus)
> +		__kvmclock_cpufreq_notifier(freq, cpu);
> +
>  	return 0;
>  }
>  

Then why to we pretend otherwise here?
