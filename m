From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Mar 2019 10:55:29 +0000
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
Message-Id: <CAJZ5v0jiumt_nvhc3Bv_b94Xq22h5vTwDPeM1qo+6bzChn58FQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org> <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
 <20190314101606.2aodwz5mzvstau6c@vireshk-i7>
In-Reply-To: <20190314101606.2aodwz5mzvstau6c@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Thu, Mar 14, 2019 at 11:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-03-19, 10:28, Rafael J. Wysocki wrote:
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
>
> Even if per-cpu iteration has to be done at some place, we are
> avoiding function calls here and the code/locking in the notifier
> layer as well. Will get more such info into changelog.
>
> > I guess some notifiers need to know what other CPUs there are in the
> > policy?  If so, then why?
>
> You mean about the offline CPUs? I mentioned the rationale in 1/7. It
> is to avoid bugs where we may end up using a stale value if the CPUs
> are offlined/onlined regularly.

I'm not really convinced about this.  CPU online really should take
care of updating everything anyway.

> > > This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> > > cpus, so the callback has all the information available with a single
> > > call for each policy.
> >
> > Well, you can argue that the core is simplified by it somewhat, but
> > the notifiers aren't.  They actually get more complex, conceptually
> > too, because they now need to worry about offline vs online CPUs etc.
>
> 24 different parts of the kernel register for transition notifiers and
> only 5 required update here, the other 19 don't need to do per-cpu
> stuff and they also get benefited by this work. Those routines will
> get called only once now, instead of once per every CPU of the policy.

This is a much better rationale for the change than the one given
originally IMO. :-)

> > Also I wonder why you decided to pass a cpumask in freqs instead of
> > just passing a policy pointer.  If you change things from per-CPU to
> > per-policy, passing the whole policy seems more natural.
>
> I did that because they don't need to use the other fields of the
> policy today and that doesn't look likely in near future as well.

But some of them need to combine the new cpumask with
cpu_online_mask() to get what would be policy->cpus effectively.  That
would be avoidable if you passed the policy pointer to them.
