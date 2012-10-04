From: David Miller <davem@davemloft.net>
Date: Thu, 04 Oct 2012 21:22:35 +0000
Subject: [PATCH 2/2] sparc64: Fix strace hiccups when force_successful_syscall() triggers.
Message-Id: <20121004.172235.9779511592641673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


From: Al Viro <viro@zeniv.linux.org.uk>

When force_successful_syscall() triggers, the syscall return status
reported the ptrace applications gets garbled.

Fix this by reordering the events and tests in the ret_sys_call path.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/syscalls.S |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index ed277e2..b0ac103 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -212,24 +212,19 @@ linux_sparc_syscall:
 3:	stx	%o0, [%sp + PTREGS_OFF + PT_V9_I0]
 ret_sys_call:
 	ldx	[%sp + PTREGS_OFF + PT_V9_TSTATE], %g3
-	ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1 ! pc = npc
 	sra	%o0, 0, %o0
 	mov	%ulo(TSTATE_XCARRY | TSTATE_ICARRY), %g2
 	sllx	%g2, 32, %g2
 
-	/* Check if force_successful_syscall_return()
-	 * was invoked.
-	 */
-	ldub	[%g6 + TI_SYS_NOERROR], %l2
-	brnz,pn %l2, 80f
-	 nop
-
 	cmp	%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn	%xcc, 1f
-	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %l6
-80:
+	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
+	ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1 ! pc = npc
+
+2:
 	/* System call success, clear Carry condition code. */
 	andn	%g3, %g2, %g3
+3:
 	stx	%g3, [%sp + PTREGS_OFF + PT_V9_TSTATE]	
 	bne,pn	%icc, linux_syscall_trace2
 	 add	%l1, 0x4, %l2			! npc = npc+4
@@ -238,20 +233,20 @@ ret_sys_call:
 	 stx	%l2, [%sp + PTREGS_OFF + PT_V9_TNPC]
 
 1:
+	/* Check if force_successful_syscall_return()
+	 * was invoked.
+	 */
+	ldub	[%g6 + TI_SYS_NOERROR], %l2
+	brnz,pn %l2, 2b
+	 ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1 ! pc = npc
 	/* System call failure, set Carry condition code.
 	 * Also, get abs(errno) to return to the process.
 	 */
-	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %l6	
 	sub	%g0, %o0, %o0
-	or	%g3, %g2, %g3
 	stx	%o0, [%sp + PTREGS_OFF + PT_V9_I0]
-	stx	%g3, [%sp + PTREGS_OFF + PT_V9_TSTATE]
-	bne,pn	%icc, linux_syscall_trace2
-	 add	%l1, 0x4, %l2			! npc = npc+4
-	stx	%l1, [%sp + PTREGS_OFF + PT_V9_TPC]
+	ba,pt	%xcc, 3b
+	 or	%g3, %g2, %g3
 
-	b,pt	%xcc, rtrap
-	 stx	%l2, [%sp + PTREGS_OFF + PT_V9_TNPC]
 linux_syscall_trace2:
 	call	syscall_trace_leave
 	 add	%sp, PTREGS_OFF, %o0
-- 
1.7.10.4

