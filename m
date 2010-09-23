From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 23 Sep 2010 00:27:57 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100923002757.GI19804@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTi=pJUKRUQhpcVV8XAJF+BO1440v1Py5Opr34DR1@mail.gmail.com>
 <20100922195349.GF19804@ZenIV.linux.org.uk>
 <20100922204323.GG19804@ZenIV.linux.org.uk>
 <20100922.141514.232744402.davem@davemloft.net>
In-Reply-To: <20100922.141514.232744402.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Dave, are you OK with the following patch?  That should cover both sparc32
and sparc64...

Subject: [PATCH] sparc: keep calling do_signal() as long as pending signals remain

Analog of what commit 494486a1d2697f2153199b6501ab5b4d6e15a2bb had done
to alpha (another architecture with similar bug).

One note: in rtrap_32.S part clr %l6 has been a rudiment of left after
commit 28e6103665301ce60634e8a77f0b657c6cc099de (sparc: Fix debugger syscall
restart interactions) has killed %l6 use in there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/kernel/rtrap_32.S |    6 +++---
 arch/sparc/kernel/rtrap_64.S |   36 +++---------------------------------
 2 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/sparc/kernel/rtrap_32.S b/arch/sparc/kernel/rtrap_32.S
index 4da2e1f..5f5f74c 100644
--- a/arch/sparc/kernel/rtrap_32.S
+++ b/arch/sparc/kernel/rtrap_32.S
@@ -78,9 +78,9 @@ signal_p:
 	call	do_notify_resume
 	 add	%sp, STACKFRAME_SZ, %o0	! pt_regs ptr
 
-	/* Fall through. */
-	ld	[%sp + STACKFRAME_SZ + PT_PSR], %t_psr
-	clr	%l6
+	b	signal_p
+	 ld	[%curptr + TI_FLAGS], %g2
+
 ret_trap_continue:
 	sethi	%hi(PSR_SYSCALL), %g1
 	andn	%t_psr, %g1, %t_psr
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
 
-- 
1.5.6.5

