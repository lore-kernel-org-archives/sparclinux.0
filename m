From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 22 Jun 2020 23:43:11 +0000
Subject: [PATCH 02/17] sparc64: enable HAVE_COPY_THREAD_TLS
Message-Id: <20200622234326.906346-3-christian.brauner@ubuntu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <christian.brauner@ubuntu.com>, "David S . Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org

This is part of a larger series that aims at getting rid of the
copy_thread()/copy_thread_tls() split that makes the process creation
codepaths in the kernel more convoluted and error-prone than they need
to be.
It also unblocks implementing clone3() on architectures not support
copy_thread_tls(). Any architecture that wants to implement clone3()
will need to select HAVE_COPY_THREAD_TLS and thus need to implement
copy_thread_tls(). So both goals are connected but independently
beneficial.

HAVE_COPY_THREAD_TLS means that a given architecture supports
CLONE_SETTLS and not setting it should usually mean that the
architectures doesn't implement it but that's not how things are. In
fact all architectures support CLONE_TLS it's just that they don't
follow the calling convention that HAVE_COPY_THREAD_TLS implies. That
means all architectures can be switched over to select
HAVE_COPY_THREAD_TLS. Once that is done we can remove that macro (yay,
less code), the unnecessary do_fork() export in kernel/fork.c, and also
rename copy_thread_tls() back to copy_thread(). At this point
copy_thread() becomes the main architecture specific part of process
creation but it will be the same layout and calling convention for all
architectures. (Once that is done we can probably cleanup each
copy_thread() function even more but that's for the future.)

Since sparc does support CLONE_SETTLS there's no reason to not select
HAVE_COPY_THREAD_TLS. This brings us one step closer to getting rid of
the copy_thread()/copy_thread_tls() split we still have and ultimately
the HAVE_COPY_THREAD_TLS define in general. A lot of architectures have
already converted and sparc is one of the few hat haven't yet. This also
unblocks implementing the clone3() syscall on sparc which I will follow
up later (if no one gets there before me). Once that is done we can get
of another ARCH_WANTS_* macro.

This patch just switches sparc64 over to HAVE_COPY_THREAD_TLS but not
sparc32 which will be done in the next patch. Once Any architecture that
supports HAVE_COPY_THREAD_TLS cannot call the do_fork() helper anymore.
This is fine and intended since it should be removed in favor of the
new, cleaner _do_fork() calling convention based on struct
kernel_clone_args. In fact, most architectures have already switched.
With this patch, sparc joins the other arches which can't use the
fork(), vfork(), clone(), clone3() syscalls directly and who follow the
new process creation calling convention that is based on struct
kernel_clone_args which we introduced a while back. This means less
custom assembly in the architectures entry path to set up the registers
before calling into the process creation helper and it is easier to to
support new features without having to adapt calling conventions. It
also unifies all process creation paths between fork(), vfork(),
clone(), and clone3(). (We can't fix the ABI nightmare that legacy
clone() is but we can prevent stuff like this happening in the future.)

Note that sparc can't easily call into the syscalls directly because of
its return value conventions when a new process is created which
needs to clobber the UREG_I1 register in copy_thread{_tls()} and it
needs to restore it if process creation fails. That's not a big deal
since the new process creation calling convention makes things simpler.

This removes sparc_do_fork() and replaces it with 3 clean helpers,
sparc_fork(), sparc_vfork(), and sparc_clone(). That means a little more
C code until the next patch unifies sparc 32bit and sparc64. It has the
advantage that we can remove quite a bit of assembler and it makes the
whole syscall.S process creation bits easier to read.
The follow-up patch will remove the custom sparc_do_fork() helper for
32bi sparc and move sparc_fork(), sparc_vfork(), and sparc_clone() into
a common process.c file. This allows us to remove quite a bit of
custom assembly form 32bit sparc's entry.S file too and allows to remove
even more code because now all helpers are shared between 32bit sparc
and sparc64 instead of having to maintain two separate sparc_do_fork()
implementations.

For some more context, please see:
commit 606e9ad20094f6d500166881d301f31a51bc8aa7
Merge: ac61145a725a 457677c70c76
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Jan 11 15:33:48 2020 -0800

    Merge tag 'clone3-tls-v5.5-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux

    Pull thread fixes from Christian Brauner:
     "This contains a series of patches to fix CLONE_SETTLS when used with
      clone3().

      The clone3() syscall passes the tls argument through struct clone_args
      instead of a register. This means, all architectures that do not
      implement copy_thread_tls() but still support CLONE_SETTLS via
      copy_thread() expecting the tls to be located in a register argument
      based on clone() are currently unfortunately broken. Their tls value
      will be garbage.

      The patch series fixes this on all architectures that currently define
      __ARCH_WANT_SYS_CLONE3. It also adds a compile-time check to ensure
      that any architecture that enables clone3() in the future is forced to
      also implement copy_thread_tls().

      My ultimate goal is to get rid of the copy_thread()/copy_thread_tls()
      split and just have copy_thread_tls() at some point in the not too
      distant future (Maybe even renaming copy_thread_tls() back to simply
      copy_thread() once the old function is ripped from all arches). This
      is dependent now on all arches supporting clone3().

      While all relevant arches do that now there are still four missing:
      ia64, m68k, sh and sparc. They have the system call reserved, but not
      implemented. Once they all implement clone3() we can get rid of
      ARCH_WANT_SYS_CLONE3 and HAVE_COPY_THREAD_TLS.

Note that in the meantime, m68k has already switched to the new calling
convention.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
See: d95b56c77ef ("openrisc: Cleanup copy_thread_tls docs and comments")
See: 0b9f386c4be ("csky: Implement copy_thread_tls")
Link: https://lore.kernel.org/r/20200512171527.570109-2-christian.brauner@ubuntu.com
---
 arch/sparc/Kconfig                |  1 +
 arch/sparc/include/asm/syscalls.h |  7 +--
 arch/sparc/kernel/process_64.c    | 91 ++++++++++++++++++++++++++-----
 arch/sparc/kernel/syscalls.S      | 23 ++++----
 4 files changed, 93 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5bf2dc163540..e2bb4956e130 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -94,6 +94,7 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
+	select HAVE_COPY_THREAD_TLS
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/include/asm/syscalls.h b/arch/sparc/include/asm/syscalls.h
index 1d819f5e21da..35575fbfb9dc 100644
--- a/arch/sparc/include/asm/syscalls.h
+++ b/arch/sparc/include/asm/syscalls.h
@@ -4,9 +4,8 @@
 
 struct pt_regs;
 
-asmlinkage long sparc_do_fork(unsigned long clone_flags,
-			      unsigned long stack_start,
-			      struct pt_regs *regs,
-			      unsigned long stack_size);
+asmlinkage long sparc_fork(struct pt_regs *regs);
+asmlinkage long sparc_vfork(struct pt_regs *regs);
+asmlinkage long sparc_clone(struct pt_regs *regs);
 
 #endif /* _SPARC64_SYSCALLS_H */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 54945eacd3b5..8c400fca4e9f 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -572,31 +572,91 @@ void fault_in_user_windows(struct pt_regs *regs)
 	force_sig(SIGSEGV);
 }
 
-asmlinkage long sparc_do_fork(unsigned long clone_flags,
-			      unsigned long stack_start,
-			      struct pt_regs *regs,
-			      unsigned long stack_size)
+asmlinkage long sparc_fork(struct pt_regs *regs)
 {
-	int __user *parent_tid_ptr, *child_tid_ptr;
 	unsigned long orig_i1 = regs->u_regs[UREG_I1];
 	long ret;
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
 
 #ifdef CONFIG_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
-		parent_tid_ptr = compat_ptr(regs->u_regs[UREG_I2]);
-		child_tid_ptr = compat_ptr(regs->u_regs[UREG_I4]);
+		args.pidfd	= compat_ptr(regs->u_regs[UREG_I2]);
+		args.child_tid	= compat_ptr(regs->u_regs[UREG_I4]);
+		args.parent_tid	= compat_ptr(regs->u_regs[UREG_I2]);
 	} else
 #endif
 	{
-		parent_tid_ptr = (int __user *) regs->u_regs[UREG_I2];
-		child_tid_ptr = (int __user *) regs->u_regs[UREG_I4];
+		args.pidfd	= (int __user *)regs->u_regs[UREG_I2];
+		args.child_tid	= (int __user *)regs->u_regs[UREG_I4];
+		args.parent_tid	= (int __user *)regs->u_regs[UREG_I2];
 	}
 
-	ret = do_fork(clone_flags, stack_start, stack_size,
-		      parent_tid_ptr, child_tid_ptr);
+	/* Did userspace setup a separate stack for the child or are we
+	 * copying the parent's?
+	 */
+	if (regs->u_regs[UREG_I1])
+		args.stack = regs->u_regs[UREG_I1];
+	else
+		args.stack = regs->u_regs[UREG_FP];
+
+	ret = _do_fork(&args);
 
 	/* If we get an error and potentially restart the system
-	 * call, we're screwed because copy_thread() clobbered
+	 * call, we're screwed because copy_thread_tls() clobbered
 	 * the parent's %o1.  So detect that case and restore it
 	 * here.
 	 */
@@ -611,8 +671,9 @@ asmlinkage long sparc_do_fork(unsigned long clone_flags,
  * Parent -->  %o0 = childs  pid, %o1 = 0
  * Child  -->  %o0 = parents pid, %o1 = 1
  */
-int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
+		    unsigned long arg, struct task_struct *p,
+		    unsigned long tls)
 {
 	struct thread_info *t = task_thread_info(p);
 	struct pt_regs *regs = current_pt_regs();
@@ -670,7 +731,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	regs->u_regs[UREG_I1] = 0;
 
 	if (clone_flags & CLONE_SETTLS)
-		t->kregs->u_regs[UREG_G7] = regs->u_regs[UREG_I3];
+		t->kregs->u_regs[UREG_G7] = tls;
 
 	return 0;
 }
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index db42b4fb3708..192f3a28a2b7 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -86,19 +86,22 @@ sys32_rt_sigreturn:
 	 * during system calls...
 	 */
 	.align	32
-sys_vfork: /* Under Linux, vfork and fork are just special cases of clone. */
-	sethi	%hi(0x4000 | 0x0100 | SIGCHLD), %o0
-	or	%o0, %lo(0x4000 | 0x0100 | SIGCHLD), %o0
-	ba,pt	%xcc, sys_clone
+sys_vfork:
+	flushw
+	ba,pt	%xcc, sparc_vfork
+	add	%sp, PTREGS_OFF, %o0
+
+	.align	32
 sys_fork:
-	 clr	%o1
-	mov	SIGCHLD, %o0
+	flushw
+	ba,pt	%xcc, sparc_fork
+	add	%sp, PTREGS_OFF, %o0
+
+	.align	32
 sys_clone:
 	flushw
-	movrz	%o1, %fp, %o1
-	mov	0, %o3
-	ba,pt	%xcc, sparc_do_fork
-	 add	%sp, PTREGS_OFF, %o2
+	ba,pt	%xcc, sparc_clone
+	add	%sp, PTREGS_OFF, %o0
 
 	.globl	ret_from_fork
 ret_from_fork:
-- 
2.27.0
