From: David Miller <davem@davemloft.net>
Date: Thu, 13 Oct 2011 20:43:47 +0000
Subject: [PATCH 2/2] sparc: Avoid calling sigprocmask()
Message-Id: <20111013.164347.1255892680974257303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Use set_current_blocked() instead.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/signal32.c  |    2 +-
 arch/sparc/kernel/signal_32.c |    2 +-
 arch/sparc/kernel/signal_64.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 3b3a3fc..2caa556 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -874,7 +874,7 @@ void do_signal32(sigset_t *oldset, struct pt_regs * regs,
 	 */
 	if (current_thread_info()->status & TS_RESTORE_SIGMASK) {
 		current_thread_info()->status &= ~TS_RESTORE_SIGMASK;
-		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+		set_current_blocked(&current->saved_sigmask);
 	}
 }
 
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 030087a..8ce247a 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -575,7 +575,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	 */
 	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
 		clear_thread_flag(TIF_RESTORE_SIGMASK);
-		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+		set_current_blocked(&current->saved_sigmask);
 	}
 }
 
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index f895c40..a2b8159 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -595,7 +595,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 	 */
 	if (current_thread_info()->status & TS_RESTORE_SIGMASK) {
 		current_thread_info()->status &= ~TS_RESTORE_SIGMASK;
-		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+		set_current_blocked(&current->saved_sigmask);
 	}
 }
 
-- 
1.7.6.401.g6a319

