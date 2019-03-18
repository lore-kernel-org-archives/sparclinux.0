From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 18 Mar 2019 11:01:00 +0000
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
Message-Id: <20190318110100.GN6058@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
 <20190315122952.GF6058@hirez.programming.kicks-ass.net>
 <CAJZ5v0g=VYSKAHuncceD-8a1AY+isR7-TMX2dbdMzpZgVkRfBg@mail.gmail.com>
In-Reply-To: <CAJZ5v0g=VYSKAHuncceD-8a1AY+isR7-TMX2dbdMzpZgVkRfBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Mar 18, 2019 at 11:45:00AM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 15, 2019 at 1:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Mar 15, 2019 at 02:43:07PM +0530, Viresh Kumar wrote:

> > > +             for_each_cpu(cpu, cpus)
> > > +                     set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
> >
> > This code doesn't make sense, the rdtsc() _must_ be called on the CPU in
> > question.
> 
> Well, strictly speaking the TSC value here comes from the CPU running the code.
> 
> The original code has this problem too, though (as Viresh said), so
> the patch really doesn't make it worse in that respect. :-)
> 
> I'm not going to defend the original code (I ldidn't invent it
> anyway), but it clearly assumes that different CPUs cannot run at
> different frequencies and that kind of explains what happens in it.

The assumption was always that if CPUs ran at different frequencies, the
notifier would run on the affected CPU. After all, only that CPU would
know its frequency changed.

> > That's part of the whole problem here, TSC isn't sync'ed when
> > it's subject to CPUFREQ.
> 
> So what would you recommend us to do here?
> 
> Obviously, this won't run on any new hardware.  Frankly, I'm not even
> sure what the most recent HW where this hack would make a difference
> is (the comment talking about Opterons suggests early 2000s), so this
> clearly falls into the "legacy" bucket to me.
> 
> Does it make sense to try to preserve it, or can we simply make
> cpufreq init fail on the systems where the TSC rate depends on the
> frequency?

I'm all for deleting this and basically dropping support for anything
that needs this, but I suspect some people digging their legacy systems
(*cough* Pavel *cough*) might object to that.

Heck, I'm even ok with just calling panic() when TSC goes wobbly :-) I'm
fed up with all that broken crap. And yes, I know, that's systems sold
today :-(
