From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 03 Jan 2008 17:55:02 +0000
Subject: Re: [RFC PATCH 01/11] Add basic support for gcc profiler instrumentation
Message-Id: <Pine.LNX.4.58.0801031248510.4826@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072226.776141236@goodmis.org>
 <20080103173506.GA30582@Krystal>
In-Reply-To: <20080103173506.GA30582@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>



On Thu, 3 Jan 2008, Mathieu Desnoyers wrote:
> .....
> > Index: linux-compile.git/arch/x86/kernel/mcount-wrapper.S
> > =================================> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-compile.git/arch/x86/kernel/mcount-wrapper.S	2008-01-03 01:02:33.000000000 -0500
> > @@ -0,0 +1,25 @@
> > +/*
> > + *  linux/arch/x86/mcount-wrapper.S
> > + *
> > + *  Copyright (C) 2004 Ingo Molnar
> > + */
> > +
> > +.globl mcount
> > +mcount:
> > +	cmpl $0, mcount_enabled
> > +	jz out
> > +
> > +	push %ebp
> > +	mov %esp, %ebp
> > +	pushl %eax
> > +	pushl %ecx
> > +	pushl %edx
> > +
> > +	call __mcount
> > +
> > +	popl %edx
> > +	popl %ecx
> > +	popl %eax
> > +	popl %ebp
>
> Writing this stack setup in assembly may be the one thing that conflicts
> with REGPARM ?

Could be.

> > +
> > +/** __mcount - hook for profiling
> > + *
> > + * This routine is called from the arch specific mcount routine, that in turn is
> > + * called from code inserted by gcc -pg.
> > + */
> > +notrace void __mcount(void)
> > +{
> > +	if (mcount_trace_function != dummy_mcount_tracer)
> > +		mcount_trace_function(CALLER_ADDR1, CALLER_ADDR2);
> > +}
>
> I don't see what the mcount_trace_function test gives us here : we
> already tested mcount_enabled.

It's probably me being anal. I did a compare over a function call.
I guess calling dummy_mcount_tracer is OK. I originally had it as NULL
and that had too many races.

> > Index: linux-compile.git/arch/x86/kernel/entry_64.S
> > =================================> > --- linux-compile.git.orig/arch/x86/kernel/entry_64.S	2008-01-03 01:02:28.000000000 -0500
> > +++ linux-compile.git/arch/x86/kernel/entry_64.S	2008-01-03 01:02:33.000000000 -0500
> > @@ -53,6 +53,52 @@
> >
> >  	.code64
> >
> > +#ifdef CONFIG_MCOUNT
> > +
> > +ENTRY(mcount)
> > +	cmpl $0, mcount_enabled
> > +	jz out
> > +
> > +	push %rbp
> > +
> > +	lea dummy_mcount_tracer, %rbp
> > +	cmpq %rbp, mcount_trace_function
>
>
> Ok, so we normally jump over the function call (with mcount_enabled being 0)
> but we can call it in rare cases when it is being set concurrently (even
> though the mcount_trace_function is there, concurrency could still allow
> the call).
>
> Therefore we have one data cache hit when disabled (mcount_enabled), and
> must do a supplementary comparison before the call when enabled. I
> wonder why the cmpq %rbp, mcount_trace_function test is there at all ?

We can have mcount_enabled on without a tracing function to call. So this
simply saves us from doing another function call.

I've been debating about getting rid of the mcount_enabled, but it makes
it easy for systemtap to disable tracing. We don't even need to modify
systemtap with this, since systemtap already has the ability to turn
mcount_enabled on and off. But it will be a bit uglier to have systemtap
modify the tracing function.

Perhaps calling dummy_mcount_tracer isn't that bad. I'll need to do some
benchmarks between the two.

-- Steve

>
>
> > +	jz out_rbp
> > +
> > +	mov %rsp,%rbp
> > +
> > +	push %r11
> > +	push %r10
> > +	push %r9
> > +	push %r8
> > +	push %rdi
> > +	push %rsi
> > +	push %rdx
> > +	push %rcx
> > +	push %rax
> > +
> > +	mov 0x0(%rbp),%rax
> > +	mov 0x8(%rbp),%rdi
> > +	mov 0x8(%rax),%rsi
> > +
> > +	call   *mcount_trace_function
> > +
> > +	pop %rax
> > +	pop %rcx
> > +	pop %rdx
> > +	pop %rsi
> > +	pop %rdi
> > +	pop %r8
> > +	pop %r9
> > +	pop %r10
> > +	pop %r11
> > +
> > +out_rbp:
> > +	pop %rbp
> > +out:
> > +	ret
> > +#endif
> > +
> >  #ifndef CONFIG_PREEMPT
> >  #define retint_kernel retint_restore_args
> >  #endif
> >
> > --
