From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 18 Mar 2019 10:53:56 +0000
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
Message-Id: <20190318105356.GM6058@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
 <20190318023514.67gxypb4w7llcmha@vireshk-i7>
In-Reply-To: <20190318023514.67gxypb4w7llcmha@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-pm@vger.kernel.org, x86@kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On Mon, Mar 18, 2019 at 08:05:14AM +0530, Viresh Kumar wrote:
> On 15-03-19, 13:29, Peter Zijlstra wrote:
> > On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index 3fae23834069..cff8779fc0d2 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > >  				void *data)
> > >  {
> > >  	struct cpufreq_freqs *freq = data;
> > > -	unsigned long *lpj;
> > > -
> > > -	lpj = &boot_cpu_data.loops_per_jiffy;
> > > -#ifdef CONFIG_SMP
> > > -	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > -		lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > > -#endif
> > > +	struct cpumask *cpus = freq->policy->cpus;
> > > +	bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > > +	unsigned long lpj;
> > > +	int cpu;
> > >  
> > >  	if (!ref_freq) {
> > >  		ref_freq = freq->old;
> > > -		loops_per_jiffy_ref = *lpj;
> > >  		tsc_khz_ref = tsc_khz;
> > > +
> > > +		if (boot_cpu)
> > > +			loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > > +		else
> > > +			loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> > >  	}
> > > +
> > >  	if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> > >  			(val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > > -		*lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > -
> > > +		lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > >  		tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > > +
> > >  		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > >  			mark_tsc_unstable("cpufreq changes");
> > >  
> > > -		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > > +		if (boot_cpu) {
> > > +			boot_cpu_data.loops_per_jiffy = lpj;
> > > +		} else {
> > > +			for_each_cpu(cpu, cpus)
> > > +				cpu_data(cpu).loops_per_jiffy = lpj;
> > > +		}
> > > +
> > > +		for_each_cpu(cpu, cpus)
> > > +			set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> > 
> > This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> > question.
> 
> You mean rdtsc() must be locally on that CPU? The cpufreq core never guaranteed
> that and it was left for the notifier to do. This patch doesn't change the
> behavior at all, just that it moves the for-loop to the notifier instead of the
> cpufreq core.

Yuck..

Rafael; how does this work in practise? Earlier you said that on x86 the
policies typically have a single cpu in them anyway. Is the freq change
also notified from _that_ cpu?

I don't think I have old enough hardware around anymore to test any of
this. This was truly ancient p6 era stuff IIRC.

Because in that case, I'm all for not doing the changes to this notifier
Viresh is proposing but simply adding something like:


	WARN_ON_ONCE(cpumask_weight(cpuc) != 1);
	WARN_ON_ONCE(cpumask_first(cpuc) != smp_processor_id());

And leave it at that.
