From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 24 Apr 2019 06:59:53 +0000
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each policy
Message-Id: <20190424064753.lwfsdeodncaai5oz@vireshk-i7>
List-Id: <sparclinux.vger.kernel.org>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
 <20190321114535.GM6058@hirez.programming.kicks-ass.net>
 <20190322061957.hzhnlbmnkpuqviiv@vireshk-i7>
In-Reply-To: <20190322061957.hzhnlbmnkpuqviiv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On 22-03-19, 11:49, Viresh Kumar wrote:
> On 21-03-19, 12:45, Peter Zijlstra wrote:
> > On Wed, Mar 20, 2019 at 10:22:23AM +0530, Viresh Kumar wrote:

> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 65e4559eef2f..1ac8c710cccc 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -6649,10 +6649,8 @@ static void kvm_hyperv_tsc_notifier(void)
> > >  }
> > >  #endif
> > >  
> > > -static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > -				     void *data)
> > > +static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
> > >  {
> > > -	struct cpufreq_freqs *freq = data;
> > >  	struct kvm *kvm;
> > >  	struct kvm_vcpu *vcpu;
> > >  	int i, send_ipi = 0;
> > > @@ -6696,17 +6694,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> > >  	 *
> > >  	 */
> > >  
> > > -	if (val = CPUFREQ_PRECHANGE && freq->old > freq->new)
> > > -		return 0;
> > > -	if (val = CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > > -		return 0;
> > > -
> > > -	smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > > +	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> > >  
> > >  	spin_lock(&kvm_lock);
> > >  	list_for_each_entry(kvm, &vm_list, vm_list) {
> > >  		kvm_for_each_vcpu(i, vcpu, kvm) {
> > > -			if (vcpu->cpu != freq->cpu)
> > > +			if (vcpu->cpu != cpu)
> > >  				continue;
> > >  			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> > >  			if (vcpu->cpu != smp_processor_id())
> > > @@ -6728,8 +6721,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
> > >  		 * guest context is entered kvmclock will be updated,
> > >  		 * so the guest will not see stale values.
> > >  		 */
> > > -		smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
> > > +		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
> > >  	}
> > > +}
> > > +
> > > +static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > +				     void *data)
> > > +{
> > > +	struct cpufreq_freqs *freq = data;
> > > +	int cpu;
> > > +
> > > +	if (val = CPUFREQ_PRECHANGE && freq->old > freq->new)
> > > +		return 0;
> > > +	if (val = CPUFREQ_POSTCHANGE && freq->old < freq->new)
> > > +		return 0;
> > > +
> > > +	for_each_cpu(cpu, freq->policy->cpus)
> > > +		__kvmclock_cpufreq_notifier(freq, cpu);
> > > +
> > >  	return 0;
> > >  }
> > >  
> > 
> > Then why to we pretend otherwise here?
> 
> My intention was to not add any bug here because of lack of my
> knowledge of the architecture in question and so I tried to be safe.
> 
> If you guys think the behavior should be same here as of the tsc, then
> we can add similar checks here.

I am rebasing this patch over Rafael's patch [1] and wondering if I
should change anything here.

-- 
viresh

[1] https://lore.kernel.org/lkml/38900622.ao2n2t5aPS@kreacher/
