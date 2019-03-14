From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 14 Mar 2019 10:30:44 +0000
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
Message-Id: <20190314101844.2q7nlxukxjyrwvv5@vireshk-i7>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
 <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
 <CAJZ5v0izRO4zmc-TovmZBjWa+Or0oN89Ny8rdxf=81ogMJM4oQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0izRO4zmc-TovmZBjWa+Or0oN89Ny8rdxf=81ogMJM4oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On 14-03-19, 10:40, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2019 at 10:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Currently we call the cpufreq transition notifiers once for each CPU of
> > > the policy->cpus cpumask, which isn't that efficient.
> >
> > Why isn't it efficient?
> >
> > Transitions are per-policy anyway, so if something needs to be done
> > for each CPU in the policy, it doesn't matter too much which part of
> > the code carries out the iteration.
> >
> > I guess some notifiers need to know what other CPUs there are in the
> > policy?  If so, then why?
> >
> > > This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> > > cpus, so the callback has all the information available with a single
> > > call for each policy.
> >
> > Well, you can argue that the core is simplified by it somewhat, but
> > the notifiers aren't.  They actually get more complex, conceptually
> > too, because they now need to worry about offline vs online CPUs etc.
> >
> > Also I wonder why you decided to pass a cpumask in freqs instead of
> > just passing a policy pointer.  If you change things from per-CPU to
> > per-policy, passing the whole policy seems more natural.
> 
> It also looks to me like all that needs to be one patch, or you have
> the ugly transition situation in which notifiers are still invoked for
> each CPU, but they assume to be invoked once per policy.

I assumed that calling something like set_cyc2ns_scale() in x86
multiple times for each CPU shouldn't be that bad even if the
frequency changes only once, but such things may actually have
side-effects. I should merged them all.

-- 
viresh
