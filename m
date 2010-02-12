From: Roland McGrath <roland@redhat.com>
Date: Fri, 12 Feb 2010 03:07:25 +0000
Subject: Re: parsic/sh/sparc tracehook breakage when tracing signals
Message-Id: <20100212030725.B6D6DC81B@magilla.sf.frob.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201002111910.50596.vapier@gentoo.org>
In-Reply-To: Mike Frysinger's message of  Thursday, 11 February 2010 19:10:47 -0500 <201002111910.50596.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

> when i ported the Blackfin code to the tracehook framework, i copied a latent 
> bug from the sparc port.  trying to trace another process while handling 
> signals no longer worked (and subsequently broke some of the gdb tests).

What you mean is that single-step into a signal handler fails to stop at
the first instruction of the handler.  (Instead it stops after the first
instruction in the handler's prologue.)

> this was due to calling tracehook_signal_handler() with the last argument 
> (stepping) always as 0.  if we look at the definition of this function in 
> linux/tracehook.h, we see that calling the function stepping=0 is pointless:
> 	if (stepping)
> 		ptrace_notify(SIGTRAP);

Indeed, it doesn't do anything else right now.  But the reason to call it
regardless is so that every arch is consistent in telling the generic code
what is going on.  If we add a future feature to ptrace (or something else)
to track signal handler setups, that feature may very well not be one that
fires only when single-step is in use.  An arch that is set up now to call
tracehook_signal_handler() exactly as that function's kerneldoc says to do
will be prepared for such things to work without later arch changes.

> after Roland pointed out some more stuff, i went back and looked at all the 
> tracehook arches in the tree.  it seems like these arches are all broken in 
> the same way:
> 	parisc (arch/parisc/kernel/signal.c)
> 	SuperH (64bit only) (arch/sh/kernel/signal_64.c)
> 	Sparc (all bits) (arch/sparc/kernel/signal{_32,32,_64}.c)
> 
> seems like you guys should just change the last argument to:
> 	test_thread_flag(TIF_SINGLESTEP)

Whether there is a TIF_SINGLESTEP and what it means is arch-specific.
If arch_has_single_step(), then the argument should be nonzero if
user_enable_single_step() is in force at the time of handler setup.

In parisc, it should test for either TIF_SINGLESTEP or TIF_BLOCKSTEP.

In sh, going from what signal_32.c does, it should indeed do as you say.

In sparc, arch_has_single_step()=0, so there is nothing to do.



Thanks,
Roland
