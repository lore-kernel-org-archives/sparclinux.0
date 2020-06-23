From: Marco Elver <elver@google.com>
Date: Tue, 23 Jun 2020 18:39:35 +0000
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to per-cpu variables
Message-Id: <CANpmjNMmYYa-mVo_Ao_n+9KzwxhGYcb6B6C72yCHyD9sZudDfA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200623083645.277342609@infradead.org> <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net> <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net> <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200623181232.GB4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, bigeasy@linutronix.de, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk, Qian Cai <cai@lca.pw>

On Tue, 23 Jun 2020 at 20:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 23, 2020 at 07:59:57PM +0200, Marco Elver wrote:
> > On Tue, Jun 23, 2020 at 06:37PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 23, 2020 at 06:13:21PM +0200, Ahmed S. Darwish wrote:
> > > > Well, freshly merged code is using it. For example, KCSAN:
> > > >
> > > >     => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
> > > >     => kernel/kcsan/report.c:
> > > >
> > > >     void kcsan_report(...)
> > > >     {
> > > >   ...
> > > >         /*
> > > >          * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
> > > >          * we do not turn off lockdep here; this could happen due to recursion
> > > >          * into lockdep via KCSAN if we detect a race in utilities used by
> > > >          * lockdep.
> > > >          */
> > > >         lockdep_off();
> > > >   ...
> > > >     }
> > >
> > > Marco, do you remember what exactly happened there? Because I'm about to
> > > wreck that. That is, I'm going to make TRACE_IRQFLAGS ignore
> > > lockdep_off().
> >
> > Yeah, I was trying to squash any kind of recursion:
> >
> >       lockdep -> other libs ->
> >               -> KCSAN
> >               -> print report
> >               -> dump stack, printk and friends
> >               -> lockdep -> other libs
> >                       -> KCSAN ...
> >
> > Some history:
> >
> > * Initial patch to fix:
> >       https://lore.kernel.org/lkml/20200115162512.70807-1-elver@google.com/
>
> That patch is weird; just :=n on lockdep.c should've cured that, the
> rest is massive overkill.
>
> > * KCSAN+lockdep+ftrace:
> >       https://lore.kernel.org/lkml/20200214211035.209972-1-elver@google.com/
>
> That doesn't really have anything useful..
>
> > lockdep now has KCSAN_SANITIZE := n, but we still need to ensure that
> > there are no paths out of lockdep, or the IRQ flags tracing code, that
> > might lead through other libs, through KCSAN, libs used to generate a
> > report, and back to lockdep.
> >
> > I never quite figured out the exact trace that led to corruption, but
> > avoiding any kind of potential for recursion was the only thing that
> > would avoid the check_flags() warnings.
>
> Fair enough; I'll rip it all up and boot a KCSAN kernel, see what if
> anything happens.

Thanks!

This was happening with Qian Cai's (Cc'd) test cases. If the kernel or
this patch changed things around so this doesn't happen anymore
regardless, then I don't see a problem.

Thanks,
-- Marco
