From: Dave Martin <Dave.Martin@arm.com>
Date: Thu, 19 Apr 2018 08:26:57 +0000
Subject: Re: [RFC PATCH 1/3] signal: Ensure every siginfo we send has all bits initialized
Message-Id: <20180419082656.GK16308@e103592.cambridge.arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
 <20180413184522.GD16308@e103592.cambridge.arm.com>
 <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
 <20180415131206.GR16141@n2100.armlinux.org.uk>
 <87604sa2fu.fsf_-_@xmission.com>
 <87zi248nte.fsf_-_@xmission.com>
 <20180417132328.GF16308@e103592.cambridge.arm.com>
 <87d0yxzksd.fsf@xmission.com>
 <20180418124717.GI16308@e103592.cambridge.arm.com>
 <87h8o8y4q6.fsf@xmission.com>
In-Reply-To: <87h8o8y4q6.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, sparclinux <sparclinux@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 18, 2018 at 09:22:09AM -0500, Eric W. Biederman wrote:
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > On Tue, Apr 17, 2018 at 02:37:38PM -0500, Eric W. Biederman wrote:

[...]

> >> My intention is to leave 0 instances of clear_siginfo in the
> >> architecture specific code.  Ideally struct siginfo will be limited to
> >> kernel/signal.c but I am not certain I can quite get that far.
> >> The function do_coredump appears to have a legit need for siginfo.
> >
> > So, you mean we can't detect that the caller didn't initialise all the
> > members, or initialised the wrong union member?
> 
> Correct.  Even when we smuggled the the union member in the upper bits
> of si_code we got it wrong.  So an interface that helps out and does
> more and is harder to misues looks desirable.
> 
> > What would be the alternative?  Have a separate interface for each SIL_
> > type, with only kernel/signal.c translating that into the siginfo_t that
> > userspace sees?
> 
> Yes.  It really isn't bad as architecture specific code only generates
> faults.  In general faults only take a pointer.  I have already merged
> the needed helpers into kernel/signal.c

Good point.  I hadn't considered that only one class of signal comes
from the arch code, but now that you point it out, it sounds right.

> > Either way, I don't see how we force the caller to initilise the whole
> > structure.
> 
> In general the plan is to convert the callers to call force_sig_fault,
> and then there is no need to have siginfo in the architecture specific
> code.  I have all of the necessary helpers are already merged into
> kernel/signal.c

Makes sense.

I wonder if all the relevant siginfo data could be passed to
force_sig_fault() (or whatever) as arguments.  Then the problem of
uninitialised fields goes away.  Perhaps that's what you had in mind.

[...]

> >> Unless gcc has changed it's stance on type-punning through unions
> >> or it's semantics with -fno-strict_aliasing we should be good.
> >
> > In practice you're probably right.
> >
> > Today, gcc is pretty conservative in this area, and I haven't been able
> > to convince clang to optimise away memset in this way either.
> >
> > My concern is that is this assumption turns out to be wrong it may be
> > some time before anybody notices, because the leakage of kernel stack may
> > be the only symptom.
> >
> > I'll try to nail down a compiler guy to see if we can get a promise on
> > this at least with -fno-strict-aliasing.
> >
> >
> > I wonder whether it's worth protecting ourselves with something like:
> >
> >
> > static void clear_siginfo(siginfo_t *si)
> > {
> > 	asm ("" : "=m" (*si));
> > 	memset(si, 0, sizeof(*si));
> > 	asm ("" : "+m" (*si));
> > }
> >
> > Probably needs to be thought about more widely though.  I guess it's out
> > of scope for this series.
> 
> It is definitely a question worth asking.

I may follow it up later if I find myself at a loose end...

Cheers
---Dave
