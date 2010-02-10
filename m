From: David Miller <davem@davemloft.net>
Date: Wed, 10 Feb 2010 00:50:06 +0000
Subject: [PATCH] sparc: Align clone and signal stacks to 16 bytes.
Message-Id: <20100209.165006.142022647.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


[ Josip, when I hit this I thought that if it were a gcc bug it might
  explain your gcc-4.4 kernel failures.  That's why I haven't played
  with your machines yet.  Now that I know this is actually a kernel
  bug effecting only user applications, I will go pursue your
  issues. ]

I originally thought this was a gcc bug:

	http://gcc.gnu.org/bugzilla/show_bug.cgi?idC004

But it's actually a kernel issue.

When we clone or create a signal stack we only 8-byte align the stack
frame, it should be 16-byte aligned on 64-bit.  Use 16-byte alignment
for 32-bit too since that's harmless and it's cheaper that way.

Distribution folks you really want this in your kernels, otherwise
64-bit threads and signal handlers will have broken alloca() and
corrupt their stacks.

I'll push this to Linus and -stable.

--------------------
sparc: Align clone and signal stacks to 16 bytes.

This is mandatory for 64-bit processes, and doing it also for 32-bit
processes saves a conditional in the compat case.

This fixes the glibc/nptl/tst-stdio1 test case, as well
as many others, on 64-bit.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/process_32.c |    2 +-
 arch/sparc/kernel/process_64.c |    8 ++++----
 arch/sparc/kernel/signal32.c   |   10 ++++++----
 arch/sparc/kernel/signal_32.c  |    6 ++++--
 arch/sparc/kernel/signal_64.c  |    8 +++++---
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 2830b41..f23c8fd 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -526,7 +526,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 			 * Set some valid stack frames to give to the child.
 			 */
 			childstack = (struct sparc_stackf __user *)
-				(sp & ~0x7UL);
+				(sp & ~0x15UL);
 			parentstack = (struct sparc_stackf __user *)
 				regs->u_regs[UREG_FP];
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 18d6785..6679eeb 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -406,11 +406,11 @@ static unsigned long clone_stackframe(unsigned long csp, unsigned long psp)
 	} else
 		__get_user(fp, &(((struct reg_window32 __user *)psp)->ins[6]));
 
-	/* Now 8-byte align the stack as this is mandatory in the
-	 * Sparc ABI due to how register windows work.  This hides
-	 * the restriction from thread libraries etc.  -DaveM
+	/* Now align the stack as this is mandatory in the Sparc ABI
+	 * due to how register windows work.  This hides the
+	 * restriction from thread libraries etc.
 	 */
-	csp &= ~7UL;
+	csp &= ~15UL;
 
 	distance = fp - psp;
 	rval = (csp - distance);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index ba5b09a..ea22cd3 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -120,8 +120,8 @@ struct rt_signal_frame32 {
 };
 
 /* Align macros */
-#define SF_ALIGNEDSZ  (((sizeof(struct signal_frame32) + 7) & (~7)))
-#define RT_ALIGNEDSZ  (((sizeof(struct rt_signal_frame32) + 7) & (~7)))
+#define SF_ALIGNEDSZ  (((sizeof(struct signal_frame32) + 15) & (~15)))
+#define RT_ALIGNEDSZ  (((sizeof(struct rt_signal_frame32) + 15) & (~15)))
 
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 {
@@ -420,15 +420,17 @@ static void __user *get_sigframe(struct sigaction *sa, struct pt_regs *regs, uns
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
+	sp -= framesize;
+
 	/* Always align the stack frame.  This handles two cases.  First,
 	 * sigaltstack need not be mindful of platform specific stack
 	 * alignment.  Second, if we took this signal because the stack
 	 * is not aligned properly, we'd like to take the signal cleanly
 	 * and report that.
 	 */
-	sp &= ~7UL;
+	sp &= ~15UL;
 
-	return (void __user *)(sp - framesize);
+	return (void __user *) sp;
 }
 
 static int save_fpu_state32(struct pt_regs *regs, __siginfo_fpu_t __user *fpu)
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 7ce1a10..9882df9 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -267,15 +267,17 @@ static inline void __user *get_sigframe(struct sigaction *sa, struct pt_regs *re
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
+	sp -= framesize;
+
 	/* Always align the stack frame.  This handles two cases.  First,
 	 * sigaltstack need not be mindful of platform specific stack
 	 * alignment.  Second, if we took this signal because the stack
 	 * is not aligned properly, we'd like to take the signal cleanly
 	 * and report that.
 	 */
-	sp &= ~7UL;
+	sp &= ~15UL;
 
-	return (void __user *)(sp - framesize);
+	return (void __user *) sp;
 }
 
 static inline int
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 647afbd..9fa48c3 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -353,7 +353,7 @@ segv:
 /* Checks if the fp is valid */
 static int invalid_frame_pointer(void __user *fp, int fplen)
 {
-	if (((unsigned long) fp) & 7)
+	if (((unsigned long) fp) & 15)
 		return 1;
 	return 0;
 }
@@ -396,15 +396,17 @@ static inline void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
+	sp -= framesize;
+
 	/* Always align the stack frame.  This handles two cases.  First,
 	 * sigaltstack need not be mindful of platform specific stack
 	 * alignment.  Second, if we took this signal because the stack
 	 * is not aligned properly, we'd like to take the signal cleanly
 	 * and report that.
 	 */
-	sp &= ~7UL;
+	sp &= ~15UL;
 
-	return (void __user *)(sp - framesize);
+	return (void __user *) sp;
 }
 
 static inline void
-- 
1.6.6.1

