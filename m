From: David Miller <davem@davemloft.net>
Date: Mon, 30 May 2016 02:33:48 +0000
Subject: sparc: Harden signal return frame checks.
Message-Id: <20160529.193348.253460759566118196.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


All signal frames must be at least 16-byte aligned, because that is
the alignment we explicitly create when we build signal return stack
frames.

All stack pointers must be at least 8-byte aligned.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/signal32.c   | 46 +++++++++++++++++++++++++++---------------
 arch/sparc/kernel/signal_32.c  | 41 +++++++++++++++++++++++--------------
 arch/sparc/kernel/signal_64.c  | 31 ++++++++++++++++++----------
 arch/sparc/kernel/sigutil_32.c |  9 ++++++++-
 arch/sparc/kernel/sigutil_64.c | 10 +++++++--
 5 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 3c25241..91cc2f4 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -138,12 +138,24 @@ int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
 	return 0;
 }
 
+/* Checks if the fp is valid.  We always build signal frames which are
+ * 16-byte aligned, therefore we can always enforce that the restore
+ * frame has that property as well.
+ */
+static bool invalid_frame_pointer(void __user *fp, int fplen)
+{
+	if ((((unsigned long) fp) & 15) ||
+	    ((unsigned long)fp) > 0x100000000ULL - fplen)
+		return true;
+	return false;
+}
+
 void do_sigreturn32(struct pt_regs *regs)
 {
 	struct signal_frame32 __user *sf;
 	compat_uptr_t fpu_save;
 	compat_uptr_t rwin_save;
-	unsigned int psr;
+	unsigned int psr, ufp;
 	unsigned int pc, npc;
 	sigset_t set;
 	compat_sigset_t seta;
@@ -158,11 +170,16 @@ void do_sigreturn32(struct pt_regs *regs)
 	sf = (struct signal_frame32 __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
-	    (((unsigned long) sf) & 3))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
+		goto segv;
+
+	if (get_user(ufp, &sf->info.si_regs.u_regs[UREG_FP]))
+		goto segv;
+
+	if (ufp & 0x7)
 		goto segv;
 
-	if (get_user(pc, &sf->info.si_regs.pc) ||
+	if (__get_user(pc, &sf->info.si_regs.pc) ||
 	    __get_user(npc, &sf->info.si_regs.npc))
 		goto segv;
 
@@ -227,7 +244,7 @@ segv:
 asmlinkage void do_rt_sigreturn32(struct pt_regs *regs)
 {
 	struct rt_signal_frame32 __user *sf;
-	unsigned int psr, pc, npc;
+	unsigned int psr, pc, npc, ufp;
 	compat_uptr_t fpu_save;
 	compat_uptr_t rwin_save;
 	sigset_t set;
@@ -242,11 +259,16 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs)
 	sf = (struct rt_signal_frame32 __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
-	    (((unsigned long) sf) & 3))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
 		goto segv;
 
-	if (get_user(pc, &sf->regs.pc) || 
+	if (get_user(ufp, &sf->regs.u_regs[UREG_FP]))
+		goto segv;
+
+	if (ufp & 0x7)
+		goto segv;
+
+	if (__get_user(pc, &sf->regs.pc) || 
 	    __get_user(npc, &sf->regs.npc))
 		goto segv;
 
@@ -307,14 +329,6 @@ segv:
 	force_sig(SIGSEGV, current);
 }
 
-/* Checks if the fp is valid */
-static int invalid_frame_pointer(void __user *fp, int fplen)
-{
-	if ((((unsigned long) fp) & 7) || ((unsigned long)fp) > 0x100000000ULL - fplen)
-		return 1;
-	return 0;
-}
-
 static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
 {
 	unsigned long sp;
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 52aa5e4..c3c12ef 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -60,10 +60,22 @@ struct rt_signal_frame {
 #define SF_ALIGNEDSZ  (((sizeof(struct signal_frame) + 7) & (~7)))
 #define RT_ALIGNEDSZ  (((sizeof(struct rt_signal_frame) + 7) & (~7)))
 
+/* Checks if the fp is valid.  We always build signal frames which are
+ * 16-byte aligned, therefore we can always enforce that the restore
+ * frame has that property as well.
+ */
+static inline bool invalid_frame_pointer(void __user *fp, int fplen)
+{
+	if ((((unsigned long) fp) & 15) || !__access_ok((unsigned long)fp, fplen))
+		return true;
+
+	return false;
+}
+
 asmlinkage void do_sigreturn(struct pt_regs *regs)
 {
+	unsigned long up_psr, pc, npc, ufp;
 	struct signal_frame __user *sf;
-	unsigned long up_psr, pc, npc;
 	sigset_t set;
 	__siginfo_fpu_t __user *fpu_save;
 	__siginfo_rwin_t __user *rwin_save;
@@ -77,10 +89,13 @@ asmlinkage void do_sigreturn(struct pt_regs *regs)
 	sf = (struct signal_frame __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)))
+	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+		goto segv_and_exit;
+
+	if (get_user(ufp, &sf->info.si_regs.u_regs[UREG_FP]))
 		goto segv_and_exit;
 
-	if (((unsigned long) sf) & 3)
+	if (ufp & 0x7)
 		goto segv_and_exit;
 
 	err = __get_user(pc,  &sf->info.si_regs.pc);
@@ -127,7 +142,7 @@ segv_and_exit:
 asmlinkage void do_rt_sigreturn(struct pt_regs *regs)
 {
 	struct rt_signal_frame __user *sf;
-	unsigned int psr, pc, npc;
+	unsigned int psr, pc, npc, ufp;
 	__siginfo_fpu_t __user *fpu_save;
 	__siginfo_rwin_t __user *rwin_save;
 	sigset_t set;
@@ -135,8 +150,13 @@ asmlinkage void do_rt_sigreturn(struct pt_regs *regs)
 
 	synchronize_user_stack();
 	sf = (struct rt_signal_frame __user *) regs->u_regs[UREG_FP];
-	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
-	    (((unsigned long) sf) & 0x03))
+	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+		goto segv;
+
+	if (get_user(ufp, &sf->regs.u_regs[UREG_FP]))
+		goto segv;
+
+	if (ufp & 0x7)
 		goto segv;
 
 	err = __get_user(pc, &sf->regs.pc);
@@ -178,15 +198,6 @@ segv:
 	force_sig(SIGSEGV, current);
 }
 
-/* Checks if the fp is valid */
-static inline int invalid_frame_pointer(void __user *fp, int fplen)
-{
-	if ((((unsigned long) fp) & 7) || !__access_ok((unsigned long)fp, fplen))
-		return 1;
-
-	return 0;
-}
-
 static inline void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
 {
 	unsigned long sp = regs->u_regs[UREG_FP];
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 39aaec1..5ee930c 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -234,6 +234,17 @@ do_sigsegv:
 	goto out;
 }
 
+/* Checks if the fp is valid.  We always build rt signal frames which
+ * are 16-byte aligned, therefore we can always enforce that the
+ * restore frame has that property as well.
+ */
+static bool invalid_frame_pointer(void __user *fp)
+{
+	if (((unsigned long) fp) & 15)
+		return true;
+	return false;
+}
+
 struct rt_signal_frame {
 	struct sparc_stackf	ss;
 	siginfo_t		info;
@@ -246,8 +257,8 @@ struct rt_signal_frame {
 
 void do_rt_sigreturn(struct pt_regs *regs)
 {
+	unsigned long tpc, tnpc, tstate, ufp;
 	struct rt_signal_frame __user *sf;
-	unsigned long tpc, tnpc, tstate;
 	__siginfo_fpu_t __user *fpu_save;
 	__siginfo_rwin_t __user *rwin_save;
 	sigset_t set;
@@ -261,10 +272,16 @@ void do_rt_sigreturn(struct pt_regs *regs)
 		(regs->u_regs [UREG_FP] + STACK_BIAS);
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (((unsigned long) sf) & 3)
+	if (invalid_frame_pointer(sf))
+		goto segv;
+
+	if (get_user(ufp, &sf->regs.u_regs[UREG_FP]))
 		goto segv;
 
-	err = get_user(tpc, &sf->regs.tpc);
+	if ((ufp + STACK_BIAS) & 0x7)
+		goto segv;
+
+	err = __get_user(tpc, &sf->regs.tpc);
 	err |= __get_user(tnpc, &sf->regs.tnpc);
 	if (test_thread_flag(TIF_32BIT)) {
 		tpc &= 0xffffffff;
@@ -308,14 +325,6 @@ segv:
 	force_sig(SIGSEGV, current);
 }
 
-/* Checks if the fp is valid */
-static int invalid_frame_pointer(void __user *fp)
-{
-	if (((unsigned long) fp) & 15)
-		return 1;
-	return 0;
-}
-
 static inline void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
 {
 	unsigned long sp = regs->u_regs[UREG_FP] + STACK_BIAS;
diff --git a/arch/sparc/kernel/sigutil_32.c b/arch/sparc/kernel/sigutil_32.c
index 0f6eebe..e5fe8ce 100644
--- a/arch/sparc/kernel/sigutil_32.c
+++ b/arch/sparc/kernel/sigutil_32.c
@@ -48,6 +48,10 @@ int save_fpu_state(struct pt_regs *regs, __siginfo_fpu_t __user *fpu)
 int restore_fpu_state(struct pt_regs *regs, __siginfo_fpu_t __user *fpu)
 {
 	int err;
+
+	if (((unsigned long) fpu) & 3)
+		return -EFAULT;
+
 #ifdef CONFIG_SMP
 	if (test_tsk_thread_flag(current, TIF_USEDFPU))
 		regs->psr &= ~PSR_EF;
@@ -97,7 +101,10 @@ int restore_rwin_state(__siginfo_rwin_t __user *rp)
 	struct thread_info *t = current_thread_info();
 	int i, wsaved, err;
 
-	__get_user(wsaved, &rp->wsaved);
+	if (((unsigned long) rp) & 3)
+		return -EFAULT;
+
+	get_user(wsaved, &rp->wsaved);
 	if (wsaved > NSWINS)
 		return -EFAULT;
 
diff --git a/arch/sparc/kernel/sigutil_64.c b/arch/sparc/kernel/sigutil_64.c
index 387834a..36aadcb 100644
--- a/arch/sparc/kernel/sigutil_64.c
+++ b/arch/sparc/kernel/sigutil_64.c
@@ -37,7 +37,10 @@ int restore_fpu_state(struct pt_regs *regs, __siginfo_fpu_t __user *fpu)
 	unsigned long fprs;
 	int err;
 
-	err = __get_user(fprs, &fpu->si_fprs);
+	if (((unsigned long) fpu) & 7)
+		return -EFAULT;
+
+	err = get_user(fprs, &fpu->si_fprs);
 	fprs_write(0);
 	regs->tstate &= ~TSTATE_PEF;
 	if (fprs & FPRS_DL)
@@ -72,7 +75,10 @@ int restore_rwin_state(__siginfo_rwin_t __user *rp)
 	struct thread_info *t = current_thread_info();
 	int i, wsaved, err;
 
-	__get_user(wsaved, &rp->wsaved);
+	if (((unsigned long) rp) & 7)
+		return -EFAULT;
+
+	get_user(wsaved, &rp->wsaved);
 	if (wsaved > NSWINS)
 		return -EFAULT;
 
-- 
2.1.2.532.g19b5d50

