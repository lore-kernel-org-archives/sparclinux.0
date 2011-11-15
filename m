From: David Miller <davem@davemloft.net>
Date: Tue, 15 Nov 2011 21:07:29 +0000
Subject: Re: [PATCH] sparc: Fix handling of orig_i0 wrt. debugging when
Message-Id: <20111115.160729.517452082832358119.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111114.235351.467624122814997359.davem@davemloft.net>
In-Reply-To: <20111114.235351.467624122814997359.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 15 Nov 2011 12:40:32 -0500 (EST)

> From: David Miller <davem@davemloft.net>
> Date: Mon, 14 Nov 2011 23:53:51 -0500 (EST)
> 
>> Luckily we can solve this problem without having to make debuggers
>> aware of the issue.  Across system calls, several registers are
>> considered volatile and can be safely clobbered.
>> 
>> Therefore we use the pt_regs save area of one of those registers, %g2,
>> as a place to save and restore orig_i0.
> 
> Unfortunately this doesn't work, for example the clone implementation
> in glibc expects %g2 and several other global registers to be preserved
> across a system call.
> 
> I'll need to find another place to stash this value away.

Ok, here is how I've decided to handle this:

--------------------
[PATCH] sparc: Stash orig_i0 into %g6 instead of %g2

As per the comments added by this commit, %g2 turns out to not be a
usable place to save away orig_i0 for syscall restart handling.

In fact all of %g2, %g3, %g4, and %g5 are assumed to be saved across
a system call by various bits of code in glibc.

%g1 can't be used because that holds the syscall number, which would
need to be saved and restored for syscall restart handling too, and
that would only compound our problems :-)

This leaves us with %g6 and %g7 which are for "system use".  %g7 is
used as the "thread register" by glibc, but %g6 is used as a compiler
and assembler temporary scratch register.  And in no instance is %g6
used to hold a value across a system call.

Therefore %g6 is safe for storing away orig_i0, at least for now.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/signal32.c  |    2 +-
 arch/sparc/kernel/signal_32.c |   20 +++++++++++++++-----
 arch/sparc/kernel/signal_64.c |   20 +++++++++++++++-----
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 2e86fd1..023b886 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -837,7 +837,7 @@ void do_signal32(sigset_t *oldset, struct pt_regs * regs)
 	if (pt_regs_is_syscall(regs) &&
 	    (regs->tstate & (TSTATE_XCARRY | TSTATE_ICARRY))) {
 		restart_syscall = 1;
-		orig_i0 = regs->u_regs[UREG_G2];
+		orig_i0 = regs->u_regs[UREG_G6];
 	}
 
 	if (signr > 0) {
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 7dfaff6..d54c6e5 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -523,12 +523,22 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	 * register for GDB to save and restore in order to get
 	 * orig_i0 correct for syscall restarts when debugging.
 	 *
-	 * However, we luckily can use the fact that several registers
-	 * are volatile across system calls.  One such register is
-	 * %g2, so use that as a place to save away orig_i0.
+	 * Although it should be the case that most of the global
+	 * registers are volatile across a system call, glibc already
+	 * depends upon that fact that we preserve them.  So we can't
+	 * just use any global register to save away the orig_i0 value.
+	 *
+	 * In particular %g2, %g3, %g4, and %g5 are all assumed to be
+	 * preserved across a system call trap by various pieces of
+	 * code in glibc.
+	 *
+	 * %g7 is used as the "thread register".   %g6 is not used in
+	 * any fixed manner.  %g6 is used as a scratch register and
+	 * a compiler temporary, but it's value is never used across
+	 * a system call.  Therefore %g6 is usable for orig_i0 storage.
 	 */
 	if (pt_regs_is_syscall(regs) && (regs->psr & PSR_C))
-		regs->u_regs[UREG_G2] = orig_i0;
+		regs->u_regs[UREG_G6] = orig_i0;
 
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
@@ -544,7 +554,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	restart_syscall = 0;
 	if (pt_regs_is_syscall(regs) && (regs->psr & PSR_C)) {
 		restart_syscall = 1;
-		orig_i0 = regs->u_regs[UREG_G2];
+		orig_i0 = regs->u_regs[UREG_G6];
 	}
 
 
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 1ddf0de..f0836cd 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -533,13 +533,23 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	 * register for GDB to save and restore in order to get
 	 * orig_i0 correct for syscall restarts when debugging.
 	 *
-	 * However, we luckily can use the fact that several registers
-	 * are volatile across system calls.  One such register is
-	 * %g2, so use that as a place to save away orig_i0.
+	 * Although it should be the case that most of the global
+	 * registers are volatile across a system call, glibc already
+	 * depends upon that fact that we preserve them.  So we can't
+	 * just use any global register to save away the orig_i0 value.
+	 *
+	 * In particular %g2, %g3, %g4, and %g5 are all assumed to be
+	 * preserved across a system call trap by various pieces of
+	 * code in glibc.
+	 *
+	 * %g7 is used as the "thread register".   %g6 is not used in
+	 * any fixed manner.  %g6 is used as a scratch register and
+	 * a compiler temporary, but it's value is never used across
+	 * a system call.  Therefore %g6 is usable for orig_i0 storage.
 	 */
 	if (pt_regs_is_syscall(regs) &&
 	    (regs->tstate & (TSTATE_XCARRY | TSTATE_ICARRY)))
-		regs->u_regs[UREG_G2] = orig_i0;
+		regs->u_regs[UREG_G6] = orig_i0;
 
 	if (current_thread_info()->status & TS_RESTORE_SIGMASK)
 		oldset = &current->saved_sigmask;
@@ -560,7 +570,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	if (pt_regs_is_syscall(regs) &&
 	    (regs->tstate & (TSTATE_XCARRY | TSTATE_ICARRY))) {
 		restart_syscall = 1;
-		orig_i0 = regs->u_regs[UREG_G2];
+		orig_i0 = regs->u_regs[UREG_G6];
 	}
 
 	if (signr > 0) {
-- 
1.7.6.401.g6a319

