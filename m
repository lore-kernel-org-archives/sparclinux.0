From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2019 10:45:00 +0000
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
Message-Id: <CAJZ5v0g=VYSKAHuncceD-8a1AY+isR7-TMX2dbdMzpZgVkRfBg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190315122952.GF6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On Fri, Mar 15, 2019 at 1:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 3fae23834069..cff8779fc0d2 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >                               void *data)
> >  {
> >       struct cpufreq_freqs *freq = data;
> > -     unsigned long *lpj;
> > -
> > -     lpj = &boot_cpu_data.loops_per_jiffy;
> > -#ifdef CONFIG_SMP
> > -     if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > -             lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > -#endif
> > +     struct cpumask *cpus = freq->policy->cpus;
> > +     bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > +     unsigned long lpj;
> > +     int cpu;
> >
> >       if (!ref_freq) {
> >               ref_freq = freq->old;
> > -             loops_per_jiffy_ref = *lpj;
> >               tsc_khz_ref = tsc_khz;
> > +
> > +             if (boot_cpu)
> > +                     loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > +             else
> > +                     loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> >       }
> > +
> >       if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> >                       (val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > -             *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > -
> > +             lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> >               tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > +
> >               if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> >                       mark_tsc_unstable("cpufreq changes");
> >
> > -             set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +             if (boot_cpu) {
> > +                     boot_cpu_data.loops_per_jiffy = lpj;
> > +             } else {
> > +                     for_each_cpu(cpu, cpus)
> > +                             cpu_data(cpu).loops_per_jiffy = lpj;
> > +             }
> > +
> > +             for_each_cpu(cpu, cpus)
> > +                     set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
>
> This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> question.

Well, strictly speaking the TSC value here comes from the CPU running the code.

The original code has this problem too, though (as Viresh said), so
the patch really doesn't make it worse in that respect. :-)

I'm not going to defend the original code (I ldidn't invent it
anyway), but it clearly assumes that different CPUs cannot run at
different frequencies and that kind of explains what happens in it.

> That's part of the whole problem here, TSC isn't sync'ed when
> it's subject to CPUFREQ.

So what would you recommend us to do here?

Obviously, this won't run on any new hardware.  Frankly, I'm not even
sure what the most recent HW where this hack would make a difference
is (the comment talking about Opterons suggests early 2000s), so this
clearly falls into the "legacy" bucket to me.

Does it make sense to try to preserve it, or can we simply make
cpufreq init fail on the systems where the TSC rate depends on the
frequency?
