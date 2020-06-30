From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 30 Jun 2020 09:40:19 +0000
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to per-cpu variables
Message-Id: <20200630094019.GL4800@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200630055939.GA3676007@debian-buster-darwi.lab.linutronix.de>
In-Reply-To: <20200630055939.GA3676007@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

On Tue, Jun 30, 2020 at 07:59:39AM +0200, Ahmed S. Darwish wrote:
> Peter Zijlstra wrote:
> 
> ...
> 
> > -#define lockdep_assert_irqs_disabled()	do {			\
> > -		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> > -			  current->hardirqs_enabled,			\
> > -			  "IRQs not disabled as expected\n");		\
> > -	} while (0)
> 
> ...
> 
> > +#define lockdep_assert_irqs_disabled()				\
> > +do {									\
> > +	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
> > +} while (0)
> 
> I think it would be nice to keep the "IRQs not disabled as expected"
> message. It makes the lockdep splat much more readable.
> 
> This is similarly the case for the v3 lockdep preemption macros:
> 
>   https://lkml.kernel.org/r/20200630054452.3675847-5-a.darwish@linutronix.de
> 
> I did not add a message though to get in-sync with the IRQ macros above.

Hurmph.. the file:line output of a splat is usually all I look at, also
__WARN_printf() generates such atrocious crap code that try and not use
it.

I suppose I should do a __WARN_str() or something, but then people are
unlikely to want to use that, too much variation etc. :/

Cursed if you do, cursed if you don't.
