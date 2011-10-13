From: David Miller <davem@davemloft.net>
Date: Thu, 13 Oct 2011 20:43:41 +0000
Subject: [PATCH 1/2] sparc: Use set_current_blocked()
Message-Id: <20111013.164341.1652323898090353802.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


From: Matt Fleming <matt.fleming@intel.com>

As described in e6fa16ab ("signal: sigprocmask() should do
retarget_shared_pending()") the modification of current->blocked is
incorrect as we need to check whether the signal we're about to block
is pending in the shared queue.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---

There was a bug in the originally submitted version of this patch, namely
one of the set_current_blocked() calls was being passed &set (of type
old_sigset_t) instead of &blocked.  I fixed them up here.

 arch/sparc/kernel/signal32.c  |   19 ++++++-------------
 arch/sparc/kernel/signal_32.c |   30 ++++++++++++------------------
 arch/sparc/kernel/signal_64.c |   30 ++++++++++++------------------
 3 files changed, 30 insertions(+), 49 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 1ba95af..3b3a3fc 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -273,10 +273,7 @@ void do_sigreturn32(struct pt_regs *regs)
 		case 1: set.sig[0] = seta[0] + (((long)seta[1]) << 32);
 	}
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 	return;
 
 segv:
@@ -377,10 +374,7 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs)
 		case 1: set.sig[0] = seta.sig[0] + (((long)seta.sig[1]) << 32);
 	}
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 	return;
 segv:
 	force_sig(SIGSEGV, current);
@@ -782,6 +776,7 @@ static inline int handle_signal32(unsigned long signr, struct k_sigaction *ka,
 				  siginfo_t *info,
 				  sigset_t *oldset, struct pt_regs *regs)
 {
+	sigset_t blocked;
 	int err;
 
 	if (ka->sa.sa_flags & SA_SIGINFO)
@@ -792,12 +787,10 @@ static inline int handle_signal32(unsigned long signr, struct k_sigaction *ka,
 	if (err)
 		return err;
 
-	spin_lock_irq(&current->sighand->siglock);
-	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
 	if (!(ka->sa.sa_flags & SA_NOMASK))
-		sigaddset(&current->blocked,signr);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+		sigaddset(&blocked, signr);
+	set_current_blocked(&blocked);
 
 	tracehook_signal_handler(signr, info, ka, regs, 0);
 
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 04ede8f..030087a 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -62,12 +62,13 @@ struct rt_signal_frame {
 
 static int _sigpause_common(old_sigset_t set)
 {
-	set &= _BLOCKABLE;
-	spin_lock_irq(&current->sighand->siglock);
+	sigset_t blocked;
+
 	current->saved_sigmask = current->blocked;
-	siginitset(&current->blocked, set);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+
+	set &= _BLOCKABLE;
+	siginitset(&blocked, set);
+	set_current_blocked(&blocked);
 
 	current->state = TASK_INTERRUPTIBLE;
 	schedule();
@@ -139,10 +140,7 @@ asmlinkage void do_sigreturn(struct pt_regs *regs)
 		goto segv_and_exit;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 	return;
 
 segv_and_exit:
@@ -209,10 +207,7 @@ asmlinkage void do_rt_sigreturn(struct pt_regs *regs)
 	}
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 	return;
 segv:
 	force_sig(SIGSEGV, current);
@@ -470,6 +465,7 @@ static inline int
 handle_signal(unsigned long signr, struct k_sigaction *ka,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
+	sigset_t blocked;
 	int err;
 
 	if (ka->sa.sa_flags & SA_SIGINFO)
@@ -480,12 +476,10 @@ handle_signal(unsigned long signr, struct k_sigaction *ka,
 	if (err)
 		return err;
 
-	spin_lock_irq(&current->sighand->siglock);
-	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
 	if (!(ka->sa.sa_flags & SA_NOMASK))
-		sigaddset(&current->blocked, signr);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+		sigaddset(&blocked, signr);
+	set_current_blocked(&blocked);
 
 	tracehook_signal_handler(signr, info, ka, regs, 0);
 
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 47509df..f895c40 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -70,10 +70,7 @@ asmlinkage void sparc64_set_context(struct pt_regs *regs)
 				goto do_sigsegv;
 		}
 		sigdelsetmask(&set, ~_BLOCKABLE);
-		spin_lock_irq(&current->sighand->siglock);
-		current->blocked = set;
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
+		set_current_blocked(&set);
 	}
 	if (test_thread_flag(TIF_32BIT)) {
 		pc &= 0xffffffff;
@@ -242,12 +239,13 @@ struct rt_signal_frame {
 
 static long _sigpause_common(old_sigset_t set)
 {
-	set &= _BLOCKABLE;
-	spin_lock_irq(&current->sighand->siglock);
+	sigset_t blocked;
+
 	current->saved_sigmask = current->blocked;
-	siginitset(&current->blocked, set);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+
+	set &= _BLOCKABLE;
+	siginitset(&blocked, set);
+	set_current_blocked(&blocked);
 
 	current->state = TASK_INTERRUPTIBLE;
 	schedule();
@@ -327,10 +325,7 @@ void do_rt_sigreturn(struct pt_regs *regs)
 	pt_regs_clear_syscall(regs);
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	set_current_blocked(&set);
 	return;
 segv:
 	force_sig(SIGSEGV, current);
@@ -484,18 +479,17 @@ static inline int handle_signal(unsigned long signr, struct k_sigaction *ka,
 				siginfo_t *info,
 				sigset_t *oldset, struct pt_regs *regs)
 {
+	sigset_t blocked;
 	int err;
 
 	err = setup_rt_frame(ka, regs, signr, oldset,
 			     (ka->sa.sa_flags & SA_SIGINFO) ? info : NULL);
 	if (err)
 		return err;
-	spin_lock_irq(&current->sighand->siglock);
-	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
 	if (!(ka->sa.sa_flags & SA_NOMASK))
-		sigaddset(&current->blocked,signr);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+		sigaddset(&blocked, signr);
+	set_current_blocked(&blocked);
 
 	tracehook_signal_handler(signr, info, ka, regs, 0);
 
-- 
1.7.6.401.g6a319

