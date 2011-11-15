From: David Miller <davem@davemloft.net>
Date: Tue, 15 Nov 2011 04:53:51 +0000
Subject: [PATCH] sparc: Fix handling of orig_i0 wrt. debugging when
Message-Id: <20111114.235351.467624122814997359.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Although we provide a proper way for a debugger to control whether
syscall restart occurs, we run into problems because orig_i0 is not
saved and restored properly.

Luckily we can solve this problem without having to make debuggers
aware of the issue.  Across system calls, several registers are
considered volatile and can be safely clobbered.

Therefore we use the pt_regs save area of one of those registers, %g2,
as a place to save and restore orig_i0.

Debuggers transparently will do the right thing because they save and
restore this register already.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/signal32.c  |   18 ++++++++++--------
 arch/sparc/kernel/signal_32.c |   20 +++++++++++++++-----
 arch/sparc/kernel/signal_64.c |   32 ++++++++++++++++++--------------
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 2caa556..2e86fd1 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -822,21 +822,23 @@ static inline void syscall_restart32(unsigned long orig_i0, struct pt_regs *regs
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void do_signal32(sigset_t *oldset, struct pt_regs * regs,
-		 int restart_syscall, unsigned long orig_i0)
+void do_signal32(sigset_t *oldset, struct pt_regs * regs)
 {
 	struct k_sigaction ka;
+	unsigned long orig_i0;
+	int restart_syscall;
 	siginfo_t info;
 	int signr;
 	
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 
-	/* If the debugger messes with the program counter, it clears
-	 * the "in syscall" bit, directing us to not perform a syscall
-	 * restart.
-	 */
-	if (restart_syscall && !pt_regs_is_syscall(regs))
-		restart_syscall = 0;
+	restart_syscall = 0;
+	orig_i0 = 0;
+	if (pt_regs_is_syscall(regs) &&
+	    (regs->tstate & (TSTATE_XCARRY | TSTATE_ICARRY))) {
+		restart_syscall = 1;
+		orig_i0 = regs->u_regs[UREG_G2];
+	}
 
 	if (signr > 0) {
 		if (restart_syscall)
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 8ce247a..7dfaff6 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -519,10 +519,16 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	siginfo_t info;
 	int signr;
 
+	/* It's a lot of work and synchronization to add a new ptrace
+	 * register for GDB to save and restore in order to get
+	 * orig_i0 correct for syscall restarts when debugging.
+	 *
+	 * However, we luckily can use the fact that several registers
+	 * are volatile across system calls.  One such register is
+	 * %g2, so use that as a place to save away orig_i0.
+	 */
 	if (pt_regs_is_syscall(regs) && (regs->psr & PSR_C))
-		restart_syscall = 1;
-	else
-		restart_syscall = 0;
+		regs->u_regs[UREG_G2] = orig_i0;
 
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
@@ -535,8 +541,12 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	 * the software "in syscall" bit, directing us to not perform
 	 * a syscall restart.
 	 */
-	if (restart_syscall && !pt_regs_is_syscall(regs))
-		restart_syscall = 0;
+	restart_syscall = 0;
+	if (pt_regs_is_syscall(regs) && (regs->psr & PSR_C)) {
+		restart_syscall = 1;
+		orig_i0 = regs->u_regs[UREG_G2];
+	}
+
 
 	if (signr > 0) {
 		if (restart_syscall)
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index a2b8159..1ddf0de 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -529,11 +529,17 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	siginfo_t info;
 	int signr;
 	
+	/* It's a lot of work and synchronization to add a new ptrace
+	 * register for GDB to save and restore in order to get
+	 * orig_i0 correct for syscall restarts when debugging.
+	 *
+	 * However, we luckily can use the fact that several registers
+	 * are volatile across system calls.  One such register is
+	 * %g2, so use that as a place to save away orig_i0.
+	 */
 	if (pt_regs_is_syscall(regs) &&
-	    (regs->tstate & (TSTATE_XCARRY | TSTATE_ICARRY))) {
-		restart_syscall = 1;
-	} else
-		restart_syscall = 0;
+	    (regs->tstate & (TSTATE_XCARRY | TSTATE_ICARRY)))
+		regs->u_regs[UREG_G2] = orig_i0;
 
 	if (current_thread_info()->status & TS_RESTORE_SIGMASK)
 		oldset = &current->saved_sigmask;
@@ -542,22 +548,20 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 
 #ifdef CONFIG_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
-		extern void do_signal32(sigset_t *, struct pt_regs *,
-					int restart_syscall,
-					unsigned long orig_i0);
-		do_signal32(oldset, regs, restart_syscall, orig_i0);
+		extern void do_signal32(sigset_t *, struct pt_regs *);
+		do_signal32(oldset, regs);
 		return;
 	}
 #endif	
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 
-	/* If the debugger messes with the program counter, it clears
-	 * the software "in syscall" bit, directing us to not perform
-	 * a syscall restart.
-	 */
-	if (restart_syscall && !pt_regs_is_syscall(regs))
-		restart_syscall = 0;
+	restart_syscall = 0;
+	if (pt_regs_is_syscall(regs) &&
+	    (regs->tstate & (TSTATE_XCARRY | TSTATE_ICARRY))) {
+		restart_syscall = 1;
+		orig_i0 = regs->u_regs[UREG_G2];
+	}
 
 	if (signr > 0) {
 		if (restart_syscall)
-- 
1.7.6.401.g6a319

