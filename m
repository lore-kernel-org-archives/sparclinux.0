From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:26 +0000
Subject: [PATCH 11/29] sparc32: fix sparse warnings in signal_32.c
Message-Id: <1398109184-3283-11-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
signal_32.c:62:17: warning: symbol 'do_sigreturn' was not declared. Should it be static?
signal_32.c:126:17: warning: symbol 'do_rt_sigreturn' was not declared. Should it be static?
signal_32.c:344:39: warning: incorrect type in initializer (different address spaces)
signal_32.c:344:39:    expected struct __siginfo_fpu_t [usertype] *fp
signal_32.c:344:39:    got void [noderef] <asn:1>*[assigned] tail
signal_32.c:346:45: warning: incorrect type in argument 2 (different address spaces)
signal_32.c:346:45:    expected struct __siginfo_fpu_t [noderef] [usertype] <asn:1>*fpu
signal_32.c:346:45:    got struct __siginfo_fpu_t [usertype] *fp
signal_32.c:352:41: warning: incorrect type in initializer (different address spaces)
signal_32.c:352:41:    expected struct __siginfo_rwin_t [usertype] *rwp
signal_32.c:352:41:    got void [noderef] <asn:1>*[assigned] tail
signal_32.c:354:48: warning: incorrect type in argument 2 (different address spaces)
signal_32.c:354:48:    expected struct __siginfo_rwin_t [noderef] [usertype] <asn:1>*rwin
signal_32.c:354:48:    got struct __siginfo_rwin_t [usertype] *rwp
signal_32.c:509:6: warning: symbol 'do_notify_resume' was not declared. Should it be static?
signal_32.c:520:16: warning: symbol 'do_sys_sigstack' was not declared. Should it be static?

Add missing prototypes and annotate two variables with __user.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h    |  8 ++++++++
 arch/sparc/kernel/signal_32.c | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index a922753..b293265 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -101,6 +101,14 @@ asmlinkage int sparc_do_fork(unsigned long clone_flags,
                              struct pt_regs *regs,
                              unsigned long stack_size);
 
+/* signal_32.c */
+asmlinkage void do_sigreturn(struct pt_regs *regs);
+asmlinkage void do_rt_sigreturn(struct pt_regs *regs);
+void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0,
+                      unsigned long thread_info_flags);
+asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
+                               struct sigstack __user *ossptr,
+                               unsigned long sp);
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
 #endif /* !(__SPARC_KERNEL_H) */
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 7d5d8e1..9ee72fc 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -28,6 +28,7 @@
 #include <asm/switch_to.h>
 
 #include "sigutil.h"
+#include "kernel.h"
 
 extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
 		   void *fpqueue, unsigned long *fpqdepth);
@@ -341,7 +342,7 @@ static int setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs,
 	err |= __put_user(0, &sf->extra_size);
 
 	if (psr & PSR_EF) {
-		__siginfo_fpu_t *fp = tail;
+		__siginfo_fpu_t __user *fp = tail;
 		tail += sizeof(*fp);
 		err |= save_fpu_state(regs, fp);
 		err |= __put_user(fp, &sf->fpu_save);
@@ -349,7 +350,7 @@ static int setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs,
 		err |= __put_user(0, &sf->fpu_save);
 	}
 	if (wsaved) {
-		__siginfo_rwin_t *rwp = tail;
+		__siginfo_rwin_t __user *rwp = tail;
 		tail += sizeof(*rwp);
 		err |= save_rwin_state(wsaved, rwp);
 		err |= __put_user(rwp, &sf->rwin_save);
@@ -517,9 +518,9 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0,
 	}
 }
 
-asmlinkage int
-do_sys_sigstack(struct sigstack __user *ssptr, struct sigstack __user *ossptr,
-		unsigned long sp)
+asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
+                               struct sigstack __user *ossptr,
+                               unsigned long sp)
 {
 	int ret = -EFAULT;
 
-- 
1.8.3.1

