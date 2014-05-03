From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:20 +0000
Subject: [PATCH 15/34] sparc64: fix sparse warnings in signal_64.c
Message-Id: <1399157559-19901-15-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
kernel/signal_64.c:292:16: warning: incorrect type in assignment (different address spaces)
kernel/signal_64.c:378:24: warning: cast removes address space of expression
kernel/signal_64.c:386:24: warning: cast removes address space of expression

rwin_save declared __user - because is points to user data.
Drop cast of pointer to u64 in calls to __put_user.
Pointers are 64 bits and __put_user supports pointers too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/signal_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index cd91d01..015ac1d 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -240,7 +240,7 @@ struct rt_signal_frame {
 	__siginfo_fpu_t __user	*fpu_save;
 	stack_t			stack;
 	sigset_t		mask;
-	__siginfo_rwin_t	*rwin_save;
+	__siginfo_rwin_t __user	*rwin_save;
 };
 
 void do_rt_sigreturn(struct pt_regs *regs)
@@ -375,7 +375,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 		__siginfo_fpu_t __user *fpu_save = tail;
 		tail += sizeof(__siginfo_fpu_t);
 		err |= save_fpu_state(regs, fpu_save);
-		err |= __put_user((u64)fpu_save, &sf->fpu_save);
+		err |= __put_user(fpu_save, &sf->fpu_save);
 	} else {
 		err |= __put_user(0, &sf->fpu_save);
 	}
@@ -383,7 +383,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 		__siginfo_rwin_t __user *rwin_save = tail;
 		tail += sizeof(__siginfo_rwin_t);
 		err |= save_rwin_state(wsaved, rwin_save);
-		err |= __put_user((u64)rwin_save, &sf->rwin_save);
+		err |= __put_user(rwin_save, &sf->rwin_save);
 		set_thread_wsaved(0);
 	} else {
 		err |= __put_user(0, &sf->rwin_save);
-- 
1.9.0

