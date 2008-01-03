From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Thu, 03 Jan 2008 17:36:39 +0000
Subject: Re: [RFC PATCH 02/11] Add fastcall to do_IRQ for i386
Message-Id: <20080103173639.GB30582@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072226.934978594@goodmis.org>
In-Reply-To: <20080103072226.934978594@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>

* Steven Rostedt (rostedt@goodmis.org) wrote:
> MCOUNT will disable the regparm parameters of the i386 compile
> options. When doing so, this breaks the prototype of do_IRQ
> where the fastcall must be explicitly called.
> 
> Also fixed some whitespace damage in the call to do_IRQ.
> 

I would propose to try to see how we can #ifdef two different __mcount
assembly functions that would prepare the stack appropriately for each
REGPARM cases.

> Signed-off-by: Steven Rostedt <srostedt@redhat.com>
> ---
>  arch/x86/kernel/irq_32.c |    2 +-
>  include/asm-x86/irq_32.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-compile.git/arch/x86/kernel/irq_32.c
> =================================> --- linux-compile.git.orig/arch/x86/kernel/irq_32.c	2007-12-20 00:20:29.000000000 -0500
> +++ linux-compile.git/arch/x86/kernel/irq_32.c	2007-12-20 00:21:55.000000000 -0500
> @@ -67,7 +67,7 @@ static union irq_ctx *softirq_ctx[NR_CPU
>   * handlers).
>   */
>  fastcall unsigned int do_IRQ(struct pt_regs *regs)
> -{	
> +{
>  	struct pt_regs *old_regs;
>  	/* high bit used in ret_from_ code */
>  	int irq = ~regs->orig_eax;
> Index: linux-compile.git/include/asm-x86/irq_32.h
> =================================> --- linux-compile.git.orig/include/asm-x86/irq_32.h	2007-12-20 00:20:29.000000000 -0500
> +++ linux-compile.git/include/asm-x86/irq_32.h	2007-12-20 00:21:55.000000000 -0500
> @@ -41,7 +41,7 @@ extern int irqbalance_disable(char *str)
>  extern void fixup_irqs(cpumask_t map);
>  #endif
>  
> -unsigned int do_IRQ(struct pt_regs *regs);
> +fastcall unsigned int do_IRQ(struct pt_regs *regs);
>  void init_IRQ(void);
>  void __init native_init_IRQ(void);
>  
> 
> -- 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
