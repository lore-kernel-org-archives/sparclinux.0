From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 18 Mar 2019 02:47:14 +0000
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
Message-Id: <20190318023514.67gxypb4w7llcmha@vireshk-i7>
List-Id: <sparclinux.vger.kernel.org>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190315122952.GF6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On 15-03-19, 13:29, Peter Zijlstra wrote:
> On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 3fae23834069..cff8779fc0d2 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >  				void *data)
> >  {
> >  	struct cpufreq_freqs *freq = data;
> > -	unsigned long *lpj;
> > -
> > -	lpj = &boot_cpu_data.loops_per_jiffy;
> > -#ifdef CONFIG_SMP
> > -	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > -#endif
> > +	struct cpumask *cpus = freq->policy->cpus;
> > +	bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > +	unsigned long lpj;
> > +	int cpu;
> >  
> >  	if (!ref_freq) {
> >  		ref_freq = freq->old;
> > -		loops_per_jiffy_ref = *lpj;
> >  		tsc_khz_ref = tsc_khz;
> > +
> > +		if (boot_cpu)
> > +			loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > +		else
> > +			loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> >  	}
> > +
> >  	if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> >  			(val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > -		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > -
> > +		lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> >  		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > +
> >  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> >  			mark_tsc_unstable("cpufreq changes");
> >  
> > -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +		if (boot_cpu) {
> > +			boot_cpu_data.loops_per_jiffy = lpj;
> > +		} else {
> > +			for_each_cpu(cpu, cpus)
> > +				cpu_data(cpu).loops_per_jiffy = lpj;
> > +		}
> > +
> > +		for_each_cpu(cpu, cpus)
> > +			set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> 
> This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> question.

You mean rdtsc() must be locally on that CPU? The cpufreq core never guaranteed
that and it was left for the notifier to do. This patch doesn't change the
behavior at all, just that it moves the for-loop to the notifier instead of the
cpufreq core.

> That's part of the whole problem here, TSC isn't sync'ed when
> it's subject to CPUFREQ.
> 
> >  	}
> >  
> >  	return 0;

-- 
viresh
