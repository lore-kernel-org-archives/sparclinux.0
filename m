From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Mar 2019 09:55:59 +0000
Subject: Re: [PATCH V3] cpufreq: Call transition notifier only once for each policy
Message-Id: <CAJZ5v0jN-TqFSXRweqhv8rnJni1r8awMjiAVNbn3RuBhLS1yvA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1eb27e3bbcbb2c67e6eadc0893c9b41e5d76894b.1553057341.git.viresh.kumar@linaro.org>
 <alpine.DEB.2.21.1903211645100.1784@nanos.tec.linutronix.de> <20190322062744.efpl4itnqtny7txf@vireshk-i7>
In-Reply-To: <20190322062744.efpl4itnqtny7txf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rafael Wysocki <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, kvm@vger.kernel.org

On Fri, Mar 22, 2019 at 7:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-03-19, 16:49, Thomas Gleixner wrote:
> > On Wed, 20 Mar 2019, Viresh Kumar wrote:
> > >
> > > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > > index 3fae23834069..b2fe665878f7 100644
> > > --- a/arch/x86/kernel/tsc.c
> > > +++ b/arch/x86/kernel/tsc.c
> > > @@ -958,10 +958,15 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> > >     struct cpufreq_freqs *freq = data;
> > >     unsigned long *lpj;
> > >
> > > +   if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1)) {
> > > +           mark_tsc_unstable("cpufreq changes: related CPUs affected");
> > > +           return 0;
> > > +   }
> >
> > You might add a check which ensures that policy->cpu = smp_processor_id()
> > because if this is not the case ....
>
> How about something like this ?
>
>         if (WARN_ON_ONCE(cpumask_weight(freq->policy->related_cpus) != 1 ||
>                          freq->policy->cpu != smp_processor_id())) {
>                 mark_tsc_unstable("cpufreq changes: related CPUs affected");
>                 return 0;
>         }
>
>
> Thanks for your feedback.

Peter suggested something like this IIRC.

Anyway, I'm still concerned that this approach in general
fundamentally doesn't work on SMP with frequency synchronization,
which is the case for the platforms affected by the problem it
attempts to overcome.

The frequency has just been changed on one CPU, presumably to the
requested value (so this cannot work when turbo is enabled anyway),
but then it also has changed for all of the other CPUs in the system
(or at least in the package), so it is not sufficient to update the
single CPU here as it is only a messenger, so to speak.  However,
updating the other CPUs from here would be fundamentally racy AFAICS.
