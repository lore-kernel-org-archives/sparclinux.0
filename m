From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2019 11:20:00 +0000
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
Message-Id: <CAJZ5v0guJoSanBRs232aVdHgiBRysdLs+LFhSnKaPbeKSrrtzA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net> <20190318023514.67gxypb4w7llcmha@vireshk-i7>
 <20190318105356.GM6058@hirez.programming.kicks-ass.net> <CAJZ5v0h5k72Oer0v6iaqfzNU6fNfoPK+YLsKxi6ZE14P_rWD1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0h5k72Oer0v6iaqfzNU6fNfoPK+YLsKxi6ZE14P_rWD1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On Mon, Mar 18, 2019 at 12:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Mar 18, 2019 at 11:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 18, 2019 at 08:05:14AM +0530, Viresh Kumar wrote:
> > > On 15-03-19, 13:29, Peter Zijlstra wrote:
> > > > On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:
> > > > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > > > index 3fae23834069..cff8779fc0d2 100644
> > > > > --- a/arch/x86/kernel/tsc.c
> > > > > +++ b/arch/x86/kernel/tsc.c
> > > > > @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > > > >                           void *data)
> > > > >  {
> > > > >   struct cpufreq_freqs *freq = data;
> > > > > - unsigned long *lpj;
> > > > > -
> > > > > - lpj = &boot_cpu_data.loops_per_jiffy;
> > > > > -#ifdef CONFIG_SMP
> > > > > - if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > > > -         lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> > > > > -#endif
> > > > > + struct cpumask *cpus = freq->policy->cpus;
> > > > > + bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> > > > > + unsigned long lpj;
> > > > > + int cpu;
> > > > >
> > > > >   if (!ref_freq) {
> > > > >           ref_freq = freq->old;
> > > > > -         loops_per_jiffy_ref = *lpj;
> > > > >           tsc_khz_ref = tsc_khz;
> > > > > +
> > > > > +         if (boot_cpu)
> > > > > +                 loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> > > > > +         else
> > > > > +                 loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
> > > > >   }
> > > > > +
> > > > >   if ((val = CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> > > > >                   (val = CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> > > > > -         *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > > > -
> > > > > +         lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> > > > >           tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> > > > > +
> > > > >           if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> > > > >                   mark_tsc_unstable("cpufreq changes");
> > > > >
> > > > > -         set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > > > > +         if (boot_cpu) {
> > > > > +                 boot_cpu_data.loops_per_jiffy = lpj;
> > > > > +         } else {
> > > > > +                 for_each_cpu(cpu, cpus)
> > > > > +                         cpu_data(cpu).loops_per_jiffy = lpj;
> > > > > +         }
> > > > > +
> > > > > +         for_each_cpu(cpu, cpus)
> > > > > +                 set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> > > >
> > > > This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> > > > question.
> > >
> > > You mean rdtsc() must be locally on that CPU? The cpufreq core never guaranteed
> > > that and it was left for the notifier to do. This patch doesn't change the
> > > behavior at all, just that it moves the for-loop to the notifier instead of the
> > > cpufreq core.
> >
> > Yuck..
> >
> > Rafael; how does this work in practise? Earlier you said that on x86 the
> > policies typically have a single cpu in them anyway.
>
> Yes.
>
> > Is the freq change also notified from _that_ cpu?
>
> May not be, depending on what CPU runs the work item/thread changing
> the freq.  It generally is not guaranteed to always be the same as the
> target CPU.

Actually, scratch that.

On x86, with one CPU per cpufreq policy, that will always be the target CPU.

> > I don't think I have old enough hardware around anymore to test any of
> > this. This was truly ancient p6 era stuff IIRC.
> >
> > Because in that case, I'm all for not doing the changes to this notifier
> > Viresh is proposing but simply adding something like:
> >
> >
> >         WARN_ON_ONCE(cpumask_weight(cpuc) != 1);
> >         WARN_ON_ONCE(cpumask_first(cpuc) != smp_processor_id());
> >
> > And leave it at that.
>
> That may not work I'm afraid.

So something like that could work.
