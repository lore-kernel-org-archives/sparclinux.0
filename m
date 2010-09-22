From: David Miller <davem@davemloft.net>
Date: Wed, 22 Sep 2010 06:36:26 +0000
Subject: [PATCH 3/3] sparc: Prevent no-handler signal syscall restart
Message-Id: <20100921.233626.242134739.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Explicitly clear the "in-syscall" bit when we have no signal
handler and back up the program counters to back up the system
call.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/signal32.c  |    4 +++-
 arch/sparc/kernel/signal_32.c |    2 ++
 arch/sparc/kernel/signal_64.c |    2 ++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 643a354..75fad42 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -616,7 +616,7 @@ static int setup_frame32(struct k_sigaction *ka, struct pt_regs *regs,
 
 		flush_signal_insns(address);
 	}
-	return;
+	return 0;
 
 sigill:
 	do_exit(SIGILL);
@@ -840,12 +840,14 @@ void do_signal32(sigset_t *oldset, struct pt_regs * regs,
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->tpc -= 4;
 		regs->tnpc -= 4;
+		pt_regs_clear_syscall(regs);
 	}
 	if (restart_syscall &&
 	    regs->u_regs[UREG_I0] = ERESTART_RESTARTBLOCK) {
 		regs->u_regs[UREG_G1] = __NR_restart_syscall;
 		regs->tpc -= 4;
 		regs->tnpc -= 4;
+		pt_regs_clear_syscall(regs);
 	}
 
 	/* If there's no signal to deliver, we just put the saved sigmask
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 99c85e9..5e5c5fd 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -580,12 +580,14 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->pc -= 4;
 		regs->npc -= 4;
+		pt_regs_clear_syscall(regs);
 	}
 	if (restart_syscall &&
 	    regs->u_regs[UREG_I0] = ERESTART_RESTARTBLOCK) {
 		regs->u_regs[UREG_G1] = __NR_restart_syscall;
 		regs->pc -= 4;
 		regs->npc -= 4;
+		pt_regs_clear_syscall(regs);
 	}
 
 	/* if there's no signal to deliver, we just put the saved sigmask
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 3f19e67..006fe45 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -600,12 +600,14 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->tpc -= 4;
 		regs->tnpc -= 4;
+		pt_regs_clear_syscall(regs);
 	}
 	if (restart_syscall &&
 	    regs->u_regs[UREG_I0] = ERESTART_RESTARTBLOCK) {
 		regs->u_regs[UREG_G1] = __NR_restart_syscall;
 		regs->tpc -= 4;
 		regs->tnpc -= 4;
+		pt_regs_clear_syscall(regs);
 	}
 
 	/* If there's no signal to deliver, we just put the saved sigmask
-- 
1.7.3

