From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:58:06 +0000
Subject: [PATCH 07/11] sparc64: prepare signal_64 for unification
Message-Id: <1230595090-23982-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o add a sparc32 only definition
o fix a few style issues (white space errors etc).
o include compiler.h (for __user)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/signal_64.h |   40 +++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/include/asm/signal_64.h b/arch/sparc/include/asm/signal_64.h
index ab1509a..41535e7 100644
--- a/arch/sparc/include/asm/signal_64.h
+++ b/arch/sparc/include/asm/signal_64.h
@@ -1,7 +1,8 @@
-#ifndef _ASMSPARC64_SIGNAL_H
-#define _ASMSPARC64_SIGNAL_H
+#ifndef __SPARC_SIGNAL_H
+#define __SPARC_SIGNAL_H
 
 #include <asm/sigcontext.h>
+#include <linux/compiler.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -83,8 +84,8 @@
 
 #define __OLD_NSIG	32
 #define __NEW_NSIG      64
-#define _NSIG_BPW     	64
-#define _NSIG_WORDS   	(__NEW_NSIG / _NSIG_BPW)
+#define _NSIG_BPW       64
+#define _NSIG_WORDS     (__NEW_NSIG / _NSIG_BPW)
 
 #define SIGRTMIN       32
 #define SIGRTMAX       __NEW_NSIG
@@ -156,20 +157,35 @@ struct sigstack {
 #define MINSIGSTKSZ	4096
 #define SIGSTKSZ	16384
 
+#ifdef __KERNEL__
+/*
+ * DJHR
+ * SA_STATIC_ALLOC is used for the sparc32 system to indicate that this
+ * interrupt handler's irq structure should be statically allocated
+ * by the request_irq routine.
+ * The alternative is that arch/sparc/kernel/irq.c has carnal knowledge
+ * of interrupt usage and that sucks. Also without a flag like this
+ * it may be possible for the free_irq routine to attempt to free
+ * statically allocated data.. which is NOT GOOD.
+ *
+ */
+#define SA_STATIC_ALLOC         0x8000
+#endif
+
 #include <asm-generic/signal.h>
 
 struct __new_sigaction {
 	__sighandler_t		sa_handler;
 	unsigned long		sa_flags;
-	__sigrestore_t 		sa_restorer;  /* not used by Linux/SPARC yet */
+	__sigrestore_t		sa_restorer;  /* not used by Linux/SPARC yet */
 	__new_sigset_t		sa_mask;
 };
 
 struct __old_sigaction {
-	__sighandler_t  	sa_handler;
-	__old_sigset_t  	sa_mask;
-	unsigned long   	sa_flags;
-	void 			(*sa_restorer)(void);     /* not used by Linux/SPARC yet */
+	__sighandler_t		sa_handler;
+	__old_sigset_t		sa_mask;
+	unsigned long		sa_flags;
+	void			(*sa_restorer)(void);  /* not used by Linux/SPARC yet */
 };
 
 typedef struct sigaltstack {
@@ -181,8 +197,8 @@ typedef struct sigaltstack {
 #ifdef __KERNEL__
 
 struct k_sigaction {
-	struct __new_sigaction 	sa;
-	void __user		*ka_restorer;
+	struct			__new_sigaction sa;
+	void			__user *ka_restorer;
 };
 
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
@@ -191,4 +207,4 @@ struct k_sigaction {
 
 #endif /* !(__ASSEMBLY__) */
 
-#endif /* !(_ASMSPARC64_SIGNAL_H) */
+#endif /* !(__SPARC_SIGNAL_H) */
-- 
1.6.0.2.GIT

