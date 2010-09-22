From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 22 Sep 2010 18:32:00 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100922183200.GC19804@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922.111019.200357319.davem@davemloft.net>
In-Reply-To: <20100922.111019.200357319.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 22, 2010 at 11:10:19AM -0700, David Miller wrote:
> 
> Al Viro has been auditing signal handling in various architectures,
> and he found some sparc bugs along the way.
> 
> Those he found are fixed here, as well as a short patch to add
> raw perf event support.

Actually, there's one more problem; I have a tentative fix for sparc64,
but not for sparc32 (yet).

Basically, sparc is unlike all other architectures in this respect:
normally, after do_signal() has handled a signal the syscall exit
glue loops back, rechecks if we need to be rescheduled, if we need
to deal with more signals, etc.  As the result, we build all sigframes
at once.  sparc (and, until recently, alpha) normally calls do_signal()
only once; sparc64 _may_ call it twice, but that's it.  sparc32 may
call it up to three times if we had userland window spill on entry.

That has unpleasant results - for starters, delivery of SIGSEGV upon
failure to set sigframe up is delayed unpredictably; we will take it
only when we trap again.  Moreover, sigsuspend() has inconsistent
behaviour in case when we have several pending signals unmasked by
new mask.  E.g. if we do the following on anything but sparc
	block signals 1 and 2
	set handlers for both
	get signals 1 and 2 sent to you
	sigsuspend(&emptyset)
we'll get both handlers run.  On sparc we'll get only one of them, except
that if we get an IRQ while running in its handler, we'll get both run...

What happens is that sparc (and alpha until it got fixed) sets up one sigframe
and happily buggers off to userland; the first handler runs until we hit
a trap.  If that trap happens to be the call of sigreturn() in the end of
handler, the first thing it'll do will be restoring the original sigmask.
Anything else will leave sigmask alone, see that we have another pending
signal and handle it...

Anyway, the sparc64 part of fix follows; I'm still digging through the
sparc32 side of things.  Dave, could you take a look at that and ACK or NAK
it?

diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 090b9e9..77f1b95 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -34,37 +34,9 @@ __handle_preemption:
 __handle_user_windows:
 		call			fault_in_user_windows
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
-		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-		/* Redo sched+sig checks */
-		ldx			[%g6 + TI_FLAGS], %l0
-		andcc			%l0, _TIF_NEED_RESCHED, %g0
-
-		be,pt			%xcc, 1f
-		 nop
-		call			schedule
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
-		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-		ldx			[%g6 + TI_FLAGS], %l0
-
-1:		andcc			%l0, _TIF_DO_NOTIFY_RESUME_MASK, %g0
-		be,pt			%xcc, __handle_user_windows_continue
-		 nop
-		mov			%l5, %o1
-		add			%sp, PTREGS_OFF, %o0
-		mov			%l0, %o2
-
-		call			do_notify_resume
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
-		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-		/* Signal delivery can modify pt_regs tstate, so we must
-		 * reload it.
-		 */
-		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
-		sethi			%hi(0xf << 20), %l4
-		and			%l1, %l4, %l4
-		ba,pt			%xcc, __handle_user_windows_continue
+		ba,pt			%xcc, __handle_preemption_continue
+		 wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 
-		 andn			%l1, %l4, %l1
 __handle_userfpu:
 		rd			%fprs, %l5
 		andcc			%l5, FPRS_FEF, %g0
@@ -87,7 +59,7 @@ __handle_signal:
 		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 		sethi			%hi(0xf << 20), %l4
 		and			%l1, %l4, %l4
-		ba,pt			%xcc, __handle_signal_continue
+		ba,pt			%xcc, __handle_preemption_continue
 		 andn			%l1, %l4, %l1
 
 		/* When returning from a NMI (%pil=15) interrupt we want to
@@ -177,11 +149,9 @@ __handle_preemption_continue:
 		bne,pn			%xcc, __handle_preemption
 		 andcc			%l0, _TIF_DO_NOTIFY_RESUME_MASK, %g0
 		bne,pn			%xcc, __handle_signal
-__handle_signal_continue:
 		 ldub			[%g6 + TI_WSAVED], %o2
 		brnz,pn			%o2, __handle_user_windows
 		 nop
-__handle_user_windows_continue:
 		sethi			%hi(TSTATE_PEF), %o0
 		andcc			%l1, %o0, %g0
 
