From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Mar 2019 15:44:28 +0000
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
Message-Id: <CAJZ5v0j05RwxjXAiES4WZitSA2LW3bij3kHPnFxxD2C6AQcWAA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <CAJZ5v0jr-XJ6VbNf3ipYQuycah-GNZKLgGe5wGknkWF7bKSY2w@mail.gmail.com>
 <20190319055044.xbxr6ph5hl4zcucb@vireshk-i7> <CAJZ5v0gzjXNizE=e+AdqMdJvE_-wYCq0kvzB-thE=SufKfyRrQ@mail.gmail.com>
 <20190319104933.vj6zcscubyp4gwxq@vireshk-i7>
In-Reply-To: <20190319104933.vj6zcscubyp4gwxq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On Tue, Mar 19, 2019 at 11:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-03-19, 10:41, Rafael J. Wysocki wrote:
> > On Tue, Mar 19, 2019 at 6:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 18-03-19, 12:49, Rafael J. Wysocki wrote:
> > > > To summarize, I think that it would be sufficient to do this just for
> > > > policy->cpu and, as Peter said, warn once if there are more CPUs in
> > > > the policy or policy->cpu is not the CPU running this code.  And mark
> > > > the TSC as unstable in both of these cases.
> > >
> > > How about this ?
> >
> > We guarantee that this will always run on policy->cpu IIRC, so it LGTM
>
> Yeah, the governor guarantees that unless dvfs_possible_from_any_cpu is set for
> the policy. But there are few direct invocations to cpufreq_driver_target() and
> __cpufreq_driver_target() which don't take that into account. First one is done
> from cpufreq_online(), which can get called on any CPU I believe. Other one is
> from cpufreq_generic_suspend(). But I think none of them gets called for x86 and
> so below code should be safe.

I meant on x86, sorry.

> > overall, but the new message is missing "one".
>
> Talking about print message ?

Yes.

> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index 3fae23834069..4d3681cfb6e0 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -958,10 +958,13 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > >         struct cpufreq_freqs *freq = data;
> > >         unsigned long *lpj;
> > >
> > > +       if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1))
> > > +               mark_tsc_unstable("cpufreq policy has more than CPU");
> >
> > Also I would check policy->cpus here.  After all, we don't care about
> > CPUs that are never online.
>
> Because the CPU isn't in the policy->cpus mask, we can't say it was *never*
> online. Just that it isn't online at that moment of time. I used related_cpus as
> the code here should be robust against any corner cases and shouldn't have
> different behavior based on value of policy->cpus.
>
> If the cpufreq driver is probed after all but one CPUs of a policy are offlined,
> then you won't see the warning if policy->cpus is used. But the warning will
> appear if any other CPU is onlined. For me that is wrong, we should have got the
> warning earlier as well as it was just wrong to not warn earlier.

Fair enough.

> > And the message could be something like "cpufreq changes: related CPUs
> > affected".
>
> Sure.
>
> I also forgot to add a "return" statement here. We shouldn't continue in this
> case, right ?

It makes a little sense to continue then, so it's better to return
immediately in that case IMO.

> > > +
> > >         lpj = &boot_cpu_data.loops_per_jiffy;
> > >  #ifdef CONFIG_SMP
> > >         if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > -               lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > > +               lpj = &cpu_data(freq->policy->cpu).loops_per_jiffy;
> > >  #endif
> > >
> > >         if (!ref_freq) {
> > > @@ -977,7 +980,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > >                 if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > >                         mark_tsc_unstable("cpufreq changes");
> > >
> > > -               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > > +               set_cyc2ns_scale(tsc_khz, freq->policy->cpu, rdtsc());
> > >         }
> > >
> > >         return 0;
