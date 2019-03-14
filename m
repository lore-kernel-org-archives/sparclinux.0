From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Mar 2019 09:28:49 +0000
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
Message-Id: <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Currently we call the cpufreq transition notifiers once for each CPU of
> the policy->cpus cpumask, which isn't that efficient.

Why isn't it efficient?

Transitions are per-policy anyway, so if something needs to be done
for each CPU in the policy, it doesn't matter too much which part of
the code carries out the iteration.

I guess some notifiers need to know what other CPUs there are in the
policy?  If so, then why?

> This patchset tries to simplify that by adding another field in struct cpufreq_freqs,
> cpus, so the callback has all the information available with a single
> call for each policy.

Well, you can argue that the core is simplified by it somewhat, but
the notifiers aren't.  They actually get more complex, conceptually
too, because they now need to worry about offline vs online CPUs etc.

Also I wonder why you decided to pass a cpumask in freqs instead of
just passing a policy pointer.  If you change things from per-CPU to
per-policy, passing the whole policy seems more natural.
