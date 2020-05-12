From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 17:15:26 +0000
Subject: [PATCH 2/3] sparc: share process creation helpers between sparc and sparc64
Message-Id: <20200512171527.570109-3-christian.brauner@ubuntu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>

As promised in the previous patch, this moves the process creation
helpers into a common process.c file that is shared between sparc and
sparc64. It allows us to get rid of quite a bit custom assembler and the
to remove the separe 32bit specific sparc_do_fork() call.

One thing to note, is that when clone() was called with a separate stack
for the child the assembler would align it. But copy_thread() has always
been doing that too so that line wasn't needed and can thus simply be
removed.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/sparc/kernel/Makefile     |   1 +
 arch/sparc/kernel/entry.S      |  29 +++------
 arch/sparc/kernel/kernel.h     |   7 +--
 arch/sparc/kernel/process.c    | 111 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/process_32.c |  27 --------
 arch/sparc/kernel/process_64.c |  97 ----------------------------
 6 files changed, 122 insertions(+), 150 deletions(-)
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
index 4d3696973325..7925e8e5092b 100644
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
index f6f498ba3198..3529e16ece20 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -154,10 +154,9 @@ extern unsigned long sun4m_cpu_startup;
 extern unsigned long sun4d_cpu_startup;
 
 /* process_32.c */
-asmlinkage int sparc_do_fork(unsigned long clone_flags,
-                             unsigned long stack_start,
-                             struct pt_regs *regs,
-                             unsigned long stack_size);
+asmlinkage int sparc_clone(struct pt_regs *regs);
+asmlinkage int sparc_fork(struct pt_regs *regs);
+asmlinkage int sparc_vfork(struct pt_regs *regs);
 
 /* signal_32.c */
 asmlinkage void do_sigreturn(struct pt_regs *regs);
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
new file mode 100644
index 000000000000..9d81edafbad5
--- /dev/null
+++ b/arch/sparc/kernel/process.c
@@ -0,0 +1,111 @@
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
+	if (!legacy_clone_args_valid(&args))
+		return -EINVAL;
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
index 26cca65e9246..9c510e6625aa 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -258,33 +258,6 @@ clone_stackframe(struct sparc_stackf __user *dst,
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
index 0222f638bdb2..309e17f3d01c 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -573,103 +573,6 @@ void fault_in_user_windows(struct pt_regs *regs)
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
-	if (!legacy_clone_args_valid(&args))
-		return -EINVAL;
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
2.26.2
