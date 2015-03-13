From: Alex Dowad <alexinbeijing@gmail.com>
Date: Fri, 13 Mar 2015 18:14:50 +0000
Subject: [PATCH 27/32] sparc: copy_thread(): rename 'arg' argument to 'kthread_arg'
Message-Id: <1426270496-26362-17-git-send-email-alexinbeijing@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
In-Reply-To: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, Aaron Tomlin <atomlin@redhat.com>, Don Zickus <dzickus@redhat.com>, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>

The 'arg' argument to copy_thread() is only ever used when forking a new
kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
with do_fork() and other arch-specific implementations of copy_thread()).

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/sparc/kernel/process_32.c | 10 ++++++++--
 arch/sparc/kernel/process_64.c |  6 ++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 50e7b62..ba6492f 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -305,8 +305,11 @@ asmlinkage int sparc_do_fork(unsigned long clone_flags,
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
@@ -343,6 +346,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	p->thread.kregs = childregs;
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
@@ -350,12 +354,14 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		p->thread.current_ds = KERNEL_DS;
 		ti->kpc = (((unsigned long) ret_from_kernel_thread) - 0x8);
 		childregs->u_regs[UREG_G1] = sp; /* function */
-		childregs->u_regs[UREG_G2] = arg;
+		childregs->u_regs[UREG_G2] = kthread_arg;
 		psr = childregs->psr = get_psr();
 		ti->kpsr = psr | PSR_PIL;
 		ti->kwim = 1 << (((psr & PSR_CWP) + 1) % nwindows);
 		return 0;
 	}
+
+	/* user thread */
 	memcpy(new_stack, (char *)regs - STACKFRAME_SZ, STACKFRAME_SZ + TRACEREG_SZ);
 	childregs->u_regs[UREG_FP] = sp;
 	p->thread.flags &= ~SPARC_FLAG_KTHREAD;
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 0be7bf9..3f203c8 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -613,7 +613,7 @@ asmlinkage long sparc_do_fork(unsigned long clone_flags,
  * Child  -->  %o0 = parents pid, %o1 = 1
  */
 int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct thread_info *t = task_thread_info(p);
 	struct pt_regs *regs = current_pt_regs();
@@ -633,15 +633,17 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	t->fpsaved[0] = 0;
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
 		t->current_ds = ASI_P;
 		t->kregs->u_regs[UREG_G1] = sp; /* function */
-		t->kregs->u_regs[UREG_G2] = arg;
+		t->kregs->u_regs[UREG_G2] = kthread_arg;
 		return 0;
 	}
 
+	/* user thread */
 	parent_sf = ((struct sparc_stackf *) regs) - 1;
 	memcpy(child_trap_frame, parent_sf, child_stack_sz);
 	if (t->flags & _TIF_32BIT) {
-- 
2.0.0.GIT

