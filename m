From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 22 Jun 2020 23:43:12 +0000
Subject: [PATCH 03/17] sparc: share process creation helpers between sparc and sparc64
Message-Id: <20200622234326.906346-4-christian.brauner@ubuntu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <christian.brauner@ubuntu.com>, "David S . Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org

As promised in the previous patch, this moves the process creation
helpers into a common process.c file that is shared between sparc and
sparc64. It allows us to get rid of quite a bit custom assembler and the
to remove the separe 32bit specific sparc_do_fork() call.

One thing to note, is that when clone() was called with a separate stack
for the child the assembler would align it. But copy_thread() has always
been doing that too so that line wasn't needed and can thus simply be
removed.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Link: https://lore.kernel.org/r/20200512171527.570109-3-christian.brauner@ubuntu.com
---
 arch/sparc/kernel/Makefile     |   1 +
 arch/sparc/kernel/entry.S      |  29 +++------
 arch/sparc/kernel/kernel.h     |  11 ++--
 arch/sparc/kernel/process.c    | 110 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/process_32.c |  27 --------
 arch/sparc/kernel/process_64.c |  94 ----------------------------
 6 files changed, 123 insertions(+), 149 deletions(-)
 create mode 100644 arch/sparc/kernel/process.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 97c0e19263d1..d3a0e072ebe8 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -33,6 +33,7 @@ obj-y                   += irq_$(BITS).o
 obj-$(CONFIG_SPARC32)   += sun4m_irq.o sun4d_irq.o
 
 obj-y                   += process_$(BITS).o
+obj-y                   += process.o
 obj-y                   += signal_$(BITS).o
 obj-y                   += sigutil_$(BITS).o
 obj-$(CONFIG_SPARC32)   += ioport.o
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index f636acf3312f..d58940280f8d 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -869,14 +869,11 @@ flush_patch_two:
 	ld	[%curptr + TI_TASK], %o4
 	rd	%psr, %g4
 	WRITE_PAUSE
-	mov	SIGCHLD, %o0			! arg0:	clone flags
 	rd	%wim, %g5
 	WRITE_PAUSE
-	mov	%fp, %o1			! arg1:	usp
 	std	%g4, [%o4 + AOFF_task_thread + AOFF_thread_fork_kpsr]
-	add	%sp, STACKFRAME_SZ, %o2		! arg2:	pt_regs ptr
-	mov	0, %o3
-	call	sparc_do_fork
+	add	%sp, STACKFRAME_SZ, %o0
+	call	sparc_fork
 	 mov	%l5, %o7
 
 	/* Whee, kernel threads! */
@@ -888,19 +885,11 @@ flush_patch_three:
 	ld	[%curptr + TI_TASK], %o4
 	rd	%psr, %g4
 	WRITE_PAUSE
-
-	/* arg0,1: flags,usp  -- loaded already */
-	cmp	%o1, 0x0			! Is new_usp NULL?
 	rd	%wim, %g5
 	WRITE_PAUSE
-	be,a	1f
-	 mov	%fp, %o1			! yes, use callers usp
-	andn	%o1, 7, %o1			! no, align to 8 bytes
-1:
 	std	%g4, [%o4 + AOFF_task_thread + AOFF_thread_fork_kpsr]
-	add	%sp, STACKFRAME_SZ, %o2		! arg2:	pt_regs ptr
-	mov	0, %o3
-	call	sparc_do_fork
+	add	%sp, STACKFRAME_SZ, %o0
+	call	sparc_clone
 	 mov	%l5, %o7
 
 	/* Whee, real vfork! */
@@ -914,13 +903,9 @@ flush_patch_four:
 	rd	%wim, %g5
 	WRITE_PAUSE
 	std	%g4, [%o4 + AOFF_task_thread + AOFF_thread_fork_kpsr]
-	sethi	%hi(0x4000 | 0x0100 | SIGCHLD), %o0
-	mov	%fp, %o1
-	or	%o0, %lo(0x4000 | 0x0100 | SIGCHLD), %o0
-	sethi	%hi(sparc_do_fork), %l1
-	mov	0, %o3
-	jmpl	%l1 + %lo(sparc_do_fork), %g0
-	 add	%sp, STACKFRAME_SZ, %o2
+	sethi	%hi(sparc_vfork), %l1
+	jmpl	%l1 + %lo(sparc_vfork), %g0
+	 add	%sp, STACKFRAME_SZ, %o0
 
         .align  4
 linux_sparc_ni_syscall:
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index f6f498ba3198..9cd09a3ef35f 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -14,6 +14,11 @@ extern const char *sparc_pmu_type;
 extern unsigned int fsr_storage;
 extern int ncpus_probed;
 
+/* process{_32,_64}.c */
+asmlinkage long sparc_clone(struct pt_regs *regs);
+asmlinkage long sparc_fork(struct pt_regs *regs);
+asmlinkage long sparc_vfork(struct pt_regs *regs);
+
 #ifdef CONFIG_SPARC64
 /* setup_64.c */
 struct seq_file;
@@ -153,12 +158,6 @@ void floppy_hardint(void);
 extern unsigned long sun4m_cpu_startup;
 extern unsigned long sun4d_cpu_startup;
 
-/* process_32.c */
-asmlinkage int sparc_do_fork(unsigned long clone_flags,
-                             unsigned long stack_start,
-                             struct pt_regs *regs,
-                             unsigned long stack_size);
-
 /* signal_32.c */
 asmlinkage void do_sigreturn(struct pt_regs *regs);
 asmlinkage void do_rt_sigreturn(struct pt_regs *regs);
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
new file mode 100644
index 000000000000..8bbe62d77b77
--- /dev/null
+++ b/arch/sparc/kernel/process.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * This file handles the architecture independent parts of process handling..
+ */
+
+#include <linux/compat.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <linux/sched/task_stack.h>
+#include <linux/signal.h>
+
+#include "kernel.h"
+
+asmlinkage long sparc_fork(struct pt_regs *regs)
+{
+	unsigned long orig_i1 = regs->u_regs[UREG_I1];
+	long ret;
+	struct kernel_clone_args args = {
+		.exit_signal	= SIGCHLD,
+		/* Reuse the parent's stack for the child. */
+		.stack		= regs->u_regs[UREG_FP],
+	};
+
+	ret = _do_fork(&args);
+
+	/* If we get an error and potentially restart the system
+	 * call, we're screwed because copy_thread_tls() clobbered
+	 * the parent's %o1.  So detect that case and restore it
+	 * here.
+	 */
+	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
+		regs->u_regs[UREG_I1] = orig_i1;
+
+	return ret;
+}
+
+asmlinkage long sparc_vfork(struct pt_regs *regs)
+{
+	unsigned long orig_i1 = regs->u_regs[UREG_I1];
+	long ret;
+
+	struct kernel_clone_args args = {
+		.flags		= CLONE_VFORK | CLONE_VM,
+		.exit_signal	= SIGCHLD,
+		/* Reuse the parent's stack for the child. */
+		.stack		= regs->u_regs[UREG_FP],
+	};
+
+	ret = _do_fork(&args);
+
+	/* If we get an error and potentially restart the system
+	 * call, we're screwed because copy_thread_tls() clobbered
+	 * the parent's %o1.  So detect that case and restore it
+	 * here.
+	 */
+	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
+		regs->u_regs[UREG_I1] = orig_i1;
+
+	return ret;
+}
+
+asmlinkage long sparc_clone(struct pt_regs *regs)
+{
+	unsigned long orig_i1 = regs->u_regs[UREG_I1];
+	unsigned int flags = lower_32_bits(regs->u_regs[UREG_I0]);
+	long ret;
+
+	struct kernel_clone_args args = {
+		.flags		= (flags & ~CSIGNAL),
+		.exit_signal	= (flags & CSIGNAL),
+		.tls		= regs->u_regs[UREG_I3],
+	};
+
+#ifdef CONFIG_COMPAT
+	if (test_thread_flag(TIF_32BIT)) {
+		args.pidfd	= compat_ptr(regs->u_regs[UREG_I2]);
+		args.child_tid	= compat_ptr(regs->u_regs[UREG_I4]);
+		args.parent_tid	= compat_ptr(regs->u_regs[UREG_I2]);
+	} else
+#endif
+	{
+		args.pidfd	= (int __user *)regs->u_regs[UREG_I2];
+		args.child_tid	= (int __user *)regs->u_regs[UREG_I4];
+		args.parent_tid	= (int __user *)regs->u_regs[UREG_I2];
+	}
+
+	/* Did userspace give setup a separate stack for the child or are we
+	 * reusing the parent's?
+	 */
+	if (regs->u_regs[UREG_I1])
+		args.stack = regs->u_regs[UREG_I1];
+	else
+		args.stack = regs->u_regs[UREG_FP];
+
+	ret = _do_fork(&args);
+
+	/* If we get an error and potentially restart the system
+	 * call, we're screwed because copy_thread_tls() clobbered
+	 * the parent's %o1.  So detect that case and restore it
+	 * here.
+	 */
+	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
+		regs->u_regs[UREG_I1] = orig_i1;
+
+	return ret;
+}
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 13cb5638fab8..229a10bab74a 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -257,33 +257,6 @@ clone_stackframe(struct sparc_stackf __user *dst,
 	return sp;
 }
 
-asmlinkage int sparc_do_fork(unsigned long clone_flags,
-                             unsigned long stack_start,
-                             struct pt_regs *regs,
-                             unsigned long stack_size)
-{
-	unsigned long parent_tid_ptr, child_tid_ptr;
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
-	long ret;
-
-	parent_tid_ptr = regs->u_regs[UREG_I2];
-	child_tid_ptr = regs->u_regs[UREG_I4];
-
-	ret = do_fork(clone_flags, stack_start, stack_size,
-		      (int __user *) parent_tid_ptr,
-		      (int __user *) child_tid_ptr);
-
-	/* If we get an error and potentially restart the system
-	 * call, we're screwed because copy_thread() clobbered
-	 * the parent's %o1.  So detect that case and restore it
-	 * here.
-	 */
-	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
-		regs->u_regs[UREG_I1] = orig_i1;
-
-	return ret;
-}
-
 /* Copy a Sparc thread.  The fork() return value conventions
  * under SunOS are nothing short of bletcherous:
  * Parent -->  %o0 = childs  pid, %o1 = 0
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 8c400fca4e9f..278bf287c4be 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -572,100 +572,6 @@ void fault_in_user_windows(struct pt_regs *regs)
 	force_sig(SIGSEGV);
 }
 
-asmlinkage long sparc_fork(struct pt_regs *regs)
-{
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
-	long ret;
-	struct kernel_clone_args args = {
-		.exit_signal	= SIGCHLD,
-		/* Reuse the parent's stack for the child. */
-		.stack		= regs->u_regs[UREG_FP],
-	};
-
-	ret = _do_fork(&args);
-
-	/* If we get an error and potentially restart the system
-	 * call, we're screwed because copy_thread_tls() clobbered
-	 * the parent's %o1.  So detect that case and restore it
-	 * here.
-	 */
-	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
-		regs->u_regs[UREG_I1] = orig_i1;
-
-	return ret;
-}
-
-asmlinkage long sparc_vfork(struct pt_regs *regs)
-{
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
-	long ret;
-
-	struct kernel_clone_args args = {
-		.flags		= CLONE_VFORK | CLONE_VM,
-		.exit_signal	= SIGCHLD,
-		/* Reuse the parent's stack for the child. */
-		.stack		= regs->u_regs[UREG_FP],
-	};
-
-	ret = _do_fork(&args);
-
-	/* If we get an error and potentially restart the system
-	 * call, we're screwed because copy_thread_tls() clobbered
-	 * the parent's %o1.  So detect that case and restore it
-	 * here.
-	 */
-	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
-		regs->u_regs[UREG_I1] = orig_i1;
-
-	return ret;
-}
-
-asmlinkage long sparc_clone(struct pt_regs *regs)
-{
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
-	unsigned int flags = lower_32_bits(regs->u_regs[UREG_I0]);
-	long ret;
-
-	struct kernel_clone_args args = {
-		.flags		= (flags & ~CSIGNAL),
-		.exit_signal	= (flags & CSIGNAL),
-		.tls		= regs->u_regs[UREG_I3],
-	};
-
-#ifdef CONFIG_COMPAT
-	if (test_thread_flag(TIF_32BIT)) {
-		args.pidfd	= compat_ptr(regs->u_regs[UREG_I2]);
-		args.child_tid	= compat_ptr(regs->u_regs[UREG_I4]);
-		args.parent_tid	= compat_ptr(regs->u_regs[UREG_I2]);
-	} else
-#endif
-	{
-		args.pidfd	= (int __user *)regs->u_regs[UREG_I2];
-		args.child_tid	= (int __user *)regs->u_regs[UREG_I4];
-		args.parent_tid	= (int __user *)regs->u_regs[UREG_I2];
-	}
-
-	/* Did userspace setup a separate stack for the child or are we
-	 * copying the parent's?
-	 */
-	if (regs->u_regs[UREG_I1])
-		args.stack = regs->u_regs[UREG_I1];
-	else
-		args.stack = regs->u_regs[UREG_FP];
-
-	ret = _do_fork(&args);
-
-	/* If we get an error and potentially restart the system
-	 * call, we're screwed because copy_thread_tls() clobbered
-	 * the parent's %o1.  So detect that case and restore it
-	 * here.
-	 */
-	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
-		regs->u_regs[UREG_I1] = orig_i1;
-
-	return ret;
-}
-
 /* Copy a Sparc thread.  The fork() return value conventions
  * under SunOS are nothing short of bletcherous:
  * Parent -->  %o0 = childs  pid, %o1 = 0
-- 
2.27.0
