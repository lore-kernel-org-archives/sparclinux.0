From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 14 Sep 2013 12:02:11 +0000
Subject: [PATCH 2/2] sparc64: Implement HAVE_CONTEXT_TRACKING
Message-Id: <149311379160131@web12j.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mark the places when the system are in user or are in kernel.
This is used to make full dynticks system (tickless) --
CONFIG_NO_HZ_FULL dependence.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig                      |    1 +
 arch/sparc/include/asm/thread_info_64.h |    3 +-
 arch/sparc/kernel/kgdb_64.c             |    5 ++-
 arch/sparc/kernel/kprobes.c             |    7 ++-
 arch/sparc/kernel/process_64.c          |    2 +
 arch/sparc/kernel/ptrace_64.c           |   10 ++++
 arch/sparc/kernel/rtrap_64.S            |    8 +++-
 arch/sparc/kernel/signal_64.c           |   13 ++++-
 arch/sparc/kernel/sys_sparc_64.c        |    3 +
 arch/sparc/kernel/syscalls.S            |    8 ++--
 arch/sparc/kernel/traps_64.c            |   85 ++++++++++++++++++++++++-------
 arch/sparc/kernel/unaligned_64.c        |   16 ++++--
 arch/sparc/mm/fault_64.c                |   14 +++--
 13 files changed, 137 insertions(+), 38 deletions(-)
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a00cbd3..e3644e0 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -66,6 +66,7 @@ config SPARC64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_CONTEXT_TRACKING
 	select HAVE_DEBUG_KMEMLEAK
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index d5e5042..5d9292a 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -192,7 +192,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TIF_UNALIGNED		5	/* allowed to do unaligned accesses */
 /* flag bit 6 is available */
 #define TIF_32BIT		7	/* 32-bit binary */
-/* flag bit 8 is available */
+#define TIF_NOHZ		8	/* in adaptive nohz mode */
 #define TIF_SECCOMP		9	/* secure computing */
 #define TIF_SYSCALL_AUDIT	10	/* syscall auditing active */
 #define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
@@ -210,6 +210,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_UNALIGNED		(1<<TIF_UNALIGNED)
 #define _TIF_32BIT		(1<<TIF_32BIT)
+#define _TIF_NOHZ		(1<<TIF_NOHZ)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index 53c0a82..60b19f5 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -159,11 +159,12 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 
 asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	unsigned long flags;
 
 	if (user_mode(regs)) {
 		bad_trap(regs, trap_level);
-		return;
+		goto out;
 	}
 
 	flushw_all();
@@ -171,6 +172,8 @@ asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs)
 	local_irq_save(flags);
 	kgdb_handle_exception(0x172, SIGTRAP, 0, regs);
 	local_irq_restore(flags);
+out:
+	exception_exit(prev_state);
 }
 
 int kgdb_arch_init(void)
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index e722121..5a09fd3 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/kdebug.h>
 #include <linux/slab.h>
+#include <linux/context_tracking.h>
 #include <asm/signal.h>
 #include <asm/cacheflush.h>
 #include <asm/uaccess.h>
@@ -418,12 +419,14 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
 				      struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
+
 	BUG_ON(trap_level != 0x170 && trap_level != 0x171);
 
 	if (user_mode(regs)) {
 		local_irq_enable();
 		bad_trap(regs, trap_level);
-		return;
+		goto out;
 	}
 
 	/* trap_level = 0x170 --> ta 0x70
@@ -433,6 +436,8 @@ asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
 		       (trap_level = 0x170) ? "debug" : "debug_2",
 		       regs, 0, trap_level, SIGTRAP) != NOTIFY_STOP)
 		bad_trap(regs, trap_level);
+out:
+	exception_exit(prev_state);
 }
 
 /* Jprobes support.  */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index baebab2..32a280e 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -31,6 +31,7 @@
 #include <linux/elfcore.h>
 #include <linux/sysrq.h>
 #include <linux/nmi.h>
+#include <linux/context_tracking.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -557,6 +558,7 @@ void fault_in_user_windows(void)
 
 barf:
 	set_thread_wsaved(window + 1);
+	user_exit();
 	do_exit(SIGILL);
 }
 
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 773c1f2..c13c9f2 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -27,6 +27,7 @@
 #include <trace/syscall.h>
 #include <linux/compat.h>
 #include <linux/elf.h>
+#include <linux/context_tracking.h>
 
 #include <asm/asi.h>
 #include <asm/pgtable.h>
@@ -1066,6 +1067,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	/* do the secure computing check first */
 	secure_computing_strict(regs->u_regs[UREG_G1]);
 
+	if (test_thread_flag(TIF_NOHZ))
+		user_exit();
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ret = tracehook_report_syscall_entry(regs);
 
@@ -1086,6 +1090,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 
 asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 {
+	if (test_thread_flag(TIF_NOHZ))
+		user_exit();
+
 	audit_syscall_exit(regs);
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
@@ -1093,4 +1100,7 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall_exit(regs, 0);
+
+	if (test_thread_flag(TIF_NOHZ))
+		user_enter();
 }
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index afa2a9e..a954eb8 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -18,10 +18,16 @@
 #define		RTRAP_PSTATE_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV)
 #define		RTRAP_PSTATE_AG_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV|PSTATE_AG)
 
+#ifdef CONFIG_CONTEXT_TRACKING
+# define SCHEDULE_USER schedule_user
+#else
+# define SCHEDULE_USER schedule
+#endif
+
 		.text
 		.align			32
 __handle_preemption:
-		call			schedule
+		call			SCHEDULE_USER
 		 wrpr			%g0, RTRAP_PSTATE, %pstate
 		ba,pt			%xcc, __handle_preemption_continue
 		 wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 35923e8..cd91d01 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -23,6 +23,7 @@
 #include <linux/tty.h>
 #include <linux/binfmts.h>
 #include <linux/bitops.h>
+#include <linux/context_tracking.h>
 
 #include <asm/uaccess.h>
 #include <asm/ptrace.h>
@@ -43,6 +44,7 @@ asmlinkage void sparc64_set_context(struct pt_regs *regs)
 {
 	struct ucontext __user *ucp = (struct ucontext __user *)
 		regs->u_regs[UREG_I0];
+	enum ctx_state prev_state = exception_enter();
 	mc_gregset_t __user *grp;
 	unsigned long pc, npc, tstate;
 	unsigned long fp, i7;
@@ -129,16 +131,19 @@ asmlinkage void sparc64_set_context(struct pt_regs *regs)
 	}
 	if (err)
 		goto do_sigsegv;
-
+out:
+	exception_exit(prev_state);
 	return;
 do_sigsegv:
 	force_sig(SIGSEGV, current);
+	goto out;
 }
 
 asmlinkage void sparc64_get_context(struct pt_regs *regs)
 {
 	struct ucontext __user *ucp = (struct ucontext __user *)
 		regs->u_regs[UREG_I0];
+	enum ctx_state prev_state = exception_enter();
 	mc_gregset_t __user *grp;
 	mcontext_t __user *mcp;
 	unsigned long fp, i7;
@@ -220,10 +225,12 @@ asmlinkage void sparc64_get_context(struct pt_regs *regs)
 	}
 	if (err)
 		goto do_sigsegv;
-
+out:
+	exception_exit(prev_state);
 	return;
 do_sigsegv:
 	force_sig(SIGSEGV, current);
+	goto out;
 }
 
 struct rt_signal_frame {
@@ -528,11 +535,13 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 
 void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long thread_info_flags)
 {
+	user_exit();
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs, orig_i0);
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
 	}
+	user_enter();
 }
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 51561b8..6065829 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -24,6 +24,7 @@
 #include <linux/personality.h>
 #include <linux/random.h>
 #include <linux/export.h>
+#include <linux/context_tracking.h>
 
 #include <asm/uaccess.h>
 #include <asm/utrap.h>
@@ -499,6 +500,7 @@ asmlinkage unsigned long c_sys_nis_syscall(struct pt_regs *regs)
 
 asmlinkage void sparc_breakpoint(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	siginfo_t info;
 
 	if (test_thread_flag(TIF_32BIT)) {
@@ -517,6 +519,7 @@ asmlinkage void sparc_breakpoint(struct pt_regs *regs)
 #ifdef DEBUG_SPARC_BREAKPOINT
 	printk ("TRAP: Returning to space: PC=%lx nPC=%lx\n", regs->tpc, regs->tnpc);
 #endif
+	exception_exit(prev_state);
 }
 
 extern void check_pending(int signum);
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index d950197..87729ff 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -52,7 +52,7 @@ sys32_rt_sigreturn:
 #endif
 	.align	32
 1:	ldx	[%g6 + TI_FLAGS], %l5
-	andcc	%l5, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
+	andcc	%l5, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT|_TIF_NOHZ), %g0
 	be,pt	%icc, rtrap
 	 nop
 	call	syscall_trace_leave
@@ -184,7 +184,7 @@ linux_sparc_syscall32:
 
 	srl	%i3, 0, %o3				! IEU0
 	srl	%i2, 0, %o2				! IEU0	Group
-	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
+	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT|_TIF_NOHZ), %g0
 	bne,pn	%icc, linux_syscall_trace32		! CTI
 	 mov	%i0, %l5				! IEU1
 5:	call	%l7					! CTI	Group brk forced
@@ -207,7 +207,7 @@ linux_sparc_syscall:
 
 	mov	%i3, %o3				! IEU1
 	mov	%i4, %o4				! IEU0	Group
-	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
+	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT|_TIF_NOHZ), %g0
 	bne,pn	%icc, linux_syscall_trace		! CTI	Group
 	 mov	%i0, %l5				! IEU0
 2:	call	%l7					! CTI	Group brk forced
@@ -223,7 +223,7 @@ ret_sys_call:
 
 	cmp	%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn	%xcc, 1f
-	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
+	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT|_TIF_NOHZ), %g0
 	ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1 ! pc = npc
 
 2:
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index b3f833a..4ced92f 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -20,6 +20,7 @@
 #include <linux/ftrace.h>
 #include <linux/reboot.h>
 #include <linux/gfp.h>
+#include <linux/context_tracking.h>
 
 #include <asm/smp.h>
 #include <asm/delay.h>
@@ -186,11 +187,12 @@ EXPORT_SYMBOL_GPL(unregister_dimm_printer);
 
 void spitfire_insn_access_exception(struct pt_regs *regs, unsigned long sfsr, unsigned long sfar)
 {
+	enum ctx_state prev_state = exception_enter();
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "instruction access exception", regs,
 		       0, 0x8, SIGTRAP) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	if (regs->tstate & TSTATE_PRIV) {
 		printk("spitfire_insn_access_exception: SFSR[%016lx] "
@@ -207,6 +209,8 @@ void spitfire_insn_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 	info.si_addr = (void __user *)regs->tpc;
 	info.si_trapno = 0;
 	force_sig_info(SIGSEGV, &info, current);
+out:
+	exception_exit(prev_state);
 }
 
 void spitfire_insn_access_exception_tl1(struct pt_regs *regs, unsigned long sfsr, unsigned long sfar)
@@ -260,11 +264,12 @@ void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, u
 
 void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, unsigned long sfar)
 {
+	enum ctx_state prev_state = exception_enter();
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "data access exception", regs,
 		       0, 0x30, SIGTRAP) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	if (regs->tstate & TSTATE_PRIV) {
 		/* Test if this comes from uaccess places. */
@@ -280,7 +285,7 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 #endif
 			regs->tpc = entry->fixup;
 			regs->tnpc = regs->tpc + 4;
-			return;
+			goto out;
 		}
 		/* Shit... */
 		printk("spitfire_data_access_exception: SFSR[%016lx] "
@@ -294,6 +299,8 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 	info.si_addr = (void __user *)sfar;
 	info.si_trapno = 0;
 	force_sig_info(SIGSEGV, &info, current);
+out:
+	exception_exit(prev_state);
 }
 
 void spitfire_data_access_exception_tl1(struct pt_regs *regs, unsigned long sfsr, unsigned long sfar)
@@ -1994,6 +2001,7 @@ static void sun4v_log_error(struct pt_regs *regs, struct sun4v_error_entry *ent,
  */
 void sun4v_resum_error(struct pt_regs *regs, unsigned long offset)
 {
+	enum ctx_state prev_state = exception_enter();
 	struct sun4v_error_entry *ent, local_copy;
 	struct trap_per_cpu *tb;
 	unsigned long paddr;
@@ -2022,12 +2030,14 @@ void sun4v_resum_error(struct pt_regs *regs, unsigned long offset)
 		pr_info("Shutdown request, %u seconds...\n",
 			local_copy.err_secs);
 		orderly_poweroff(true);
-		return;
+		goto out;
 	}
 
 	sun4v_log_error(regs, &local_copy, cpu,
 			KERN_ERR "RESUMABLE ERROR",
 			&sun4v_resum_oflow_cnt);
+out:
+	exception_exit(prev_state);
 }
 
 /* If we try to printk() we'll probably make matters worse, by trying
@@ -2152,7 +2162,7 @@ void hypervisor_tlbop_error_xcall(unsigned long err, unsigned long op)
 	       err, op);
 }
 
-void do_fpe_common(struct pt_regs *regs)
+static void do_fpe_common(struct pt_regs *regs)
 {
 	if (regs->tstate & TSTATE_PRIV) {
 		regs->tpc = regs->tnpc;
@@ -2188,23 +2198,28 @@ void do_fpe_common(struct pt_regs *regs)
 
 void do_fpieee(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
+
 	if (notify_die(DIE_TRAP, "fpu exception ieee", regs,
 		       0, 0x24, SIGFPE) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	do_fpe_common(regs);
+out:
+	exception_exit(prev_state);
 }
 
 extern int do_mathemu(struct pt_regs *, struct fpustate *, bool);
 
 void do_fpother(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	struct fpustate *f = FPUSTATE;
 	int ret = 0;
 
 	if (notify_die(DIE_TRAP, "fpu exception other", regs,
 		       0, 0x25, SIGFPE) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	switch ((current_thread_info()->xfsr[0] & 0x1c000)) {
 	case (2 << 14): /* unfinished_FPop */
@@ -2213,17 +2228,20 @@ void do_fpother(struct pt_regs *regs)
 		break;
 	}
 	if (ret)
-		return;
+		goto out;
 	do_fpe_common(regs);
+out:
+	exception_exit(prev_state);
 }
 
 void do_tof(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "tagged arithmetic overflow", regs,
 		       0, 0x26, SIGEMT) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	if (regs->tstate & TSTATE_PRIV)
 		die_if_kernel("Penguin overflow trap from kernel mode", regs);
@@ -2237,15 +2255,18 @@ void do_tof(struct pt_regs *regs)
 	info.si_addr = (void __user *)regs->tpc;
 	info.si_trapno = 0;
 	force_sig_info(SIGEMT, &info, current);
+out:
+	exception_exit(prev_state);
 }
 
 void do_div0(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "integer division by zero", regs,
 		       0, 0x28, SIGFPE) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	if (regs->tstate & TSTATE_PRIV)
 		die_if_kernel("TL0: Kernel divide by zero.", regs);
@@ -2259,6 +2280,8 @@ void do_div0(struct pt_regs *regs)
 	info.si_addr = (void __user *)regs->tpc;
 	info.si_trapno = 0;
 	force_sig_info(SIGFPE, &info, current);
+out:
+	exception_exit(prev_state);
 }
 
 static void instruction_dump(unsigned int *pc)
@@ -2415,6 +2438,7 @@ extern int handle_ldf_stq(u32 insn, struct pt_regs *regs);
 
 void do_illegal_instruction(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	unsigned long pc = regs->tpc;
 	unsigned long tstate = regs->tstate;
 	u32 insn;
@@ -2422,7 +2446,7 @@ void do_illegal_instruction(struct pt_regs *regs)
 
 	if (notify_die(DIE_TRAP, "illegal instruction", regs,
 		       0, 0x10, SIGILL) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	if (tstate & TSTATE_PRIV)
 		die_if_kernel("Kernel illegal instruction", regs);
@@ -2431,14 +2455,14 @@ void do_illegal_instruction(struct pt_regs *regs)
 	if (get_user(insn, (u32 __user *) pc) != -EFAULT) {
 		if ((insn & 0xc1ffc000) = 0x81700000) /* POPC */ {
 			if (handle_popc(insn, regs))
-				return;
+				goto out;
 		} else if ((insn & 0xc1580000) = 0xc1100000) /* LDQ/STQ */ {
 			if (handle_ldf_stq(insn, regs))
-				return;
+				goto out;
 		} else if (tlb_type = hypervisor) {
 			if ((insn & VIS_OPCODE_MASK) = VIS_OPCODE_VAL) {
 				if (!vis_emul(regs, insn))
-					return;
+					goto out;
 			} else {
 				struct fpustate *f = FPUSTATE;
 
@@ -2448,7 +2472,7 @@ void do_illegal_instruction(struct pt_regs *regs)
 				 * Trap in the %fsr to unimplemented_FPop.
 				 */
 				if (do_mathemu(regs, f, true))
-					return;
+					goto out;
 			}
 		}
 	}
@@ -2458,21 +2482,24 @@ void do_illegal_instruction(struct pt_regs *regs)
 	info.si_addr = (void __user *)pc;
 	info.si_trapno = 0;
 	force_sig_info(SIGILL, &info, current);
+out:
+	exception_exit(prev_state);
 }
 
 extern void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn);
 
 void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr)
 {
+	enum ctx_state prev_state = exception_enter();
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "memory address unaligned", regs,
 		       0, 0x34, SIGSEGV) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	if (regs->tstate & TSTATE_PRIV) {
 		kernel_unaligned_trap(regs, *((unsigned int *)regs->tpc));
-		return;
+		goto out;
 	}
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
@@ -2480,6 +2507,8 @@ void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned lo
 	info.si_addr = (void __user *)sfar;
 	info.si_trapno = 0;
 	force_sig_info(SIGBUS, &info, current);
+out:
+	exception_exit(prev_state);
 }
 
 void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
@@ -2504,11 +2533,12 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
 
 void do_privop(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "privileged operation", regs,
 		       0, 0x11, SIGILL) = NOTIFY_STOP)
-		return;
+		goto out;
 
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc &= 0xffffffff;
@@ -2520,6 +2550,8 @@ void do_privop(struct pt_regs *regs)
 	info.si_addr = (void __user *)regs->tpc;
 	info.si_trapno = 0;
 	force_sig_info(SIGILL, &info, current);
+out:
+	exception_exit(prev_state);
 }
 
 void do_privact(struct pt_regs *regs)
@@ -2530,99 +2562,116 @@ void do_privact(struct pt_regs *regs)
 /* Trap level 1 stuff or other traps we should never see... */
 void do_cee(struct pt_regs *regs)
 {
+	exception_enter();
 	die_if_kernel("TL0: Cache Error Exception", regs);
 }
 
 void do_cee_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: Cache Error Exception", regs);
 }
 
 void do_dae_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: Data Access Exception", regs);
 }
 
 void do_iae_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: Instruction Access Exception", regs);
 }
 
 void do_div0_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: DIV0 Exception", regs);
 }
 
 void do_fpdis_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: FPU Disabled", regs);
 }
 
 void do_fpieee_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: FPU IEEE Exception", regs);
 }
 
 void do_fpother_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: FPU Other Exception", regs);
 }
 
 void do_ill_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: Illegal Instruction Exception", regs);
 }
 
 void do_irq_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: IRQ Exception", regs);
 }
 
 void do_lddfmna_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: LDDF Exception", regs);
 }
 
 void do_stdfmna_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: STDF Exception", regs);
 }
 
 void do_paw(struct pt_regs *regs)
 {
+	exception_enter();
 	die_if_kernel("TL0: Phys Watchpoint Exception", regs);
 }
 
 void do_paw_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: Phys Watchpoint Exception", regs);
 }
 
 void do_vaw(struct pt_regs *regs)
 {
+	exception_enter();
 	die_if_kernel("TL0: Virt Watchpoint Exception", regs);
 }
 
 void do_vaw_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: Virt Watchpoint Exception", regs);
 }
 
 void do_tof_tl1(struct pt_regs *regs)
 {
+	exception_enter();
 	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
 	die_if_kernel("TL1: Tag Overflow Exception", regs);
 }
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 8201c25e..3c1a7cb 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -21,9 +21,12 @@
 #include <linux/bitops.h>
 #include <linux/perf_event.h>
 #include <linux/ratelimit.h>
+#include <linux/context_tracking.h>
 #include <asm/fpumacro.h>
 #include <asm/cacheflush.h>
 
+#include "entry.h"
+
 enum direction {
 	load,    /* ld, ldd, ldh, ldsh */
 	store,   /* st, std, sth, stsh */
@@ -418,9 +421,6 @@ int handle_popc(u32 insn, struct pt_regs *regs)
 
 extern void do_fpother(struct pt_regs *regs);
 extern void do_privact(struct pt_regs *regs);
-extern void spitfire_data_access_exception(struct pt_regs *regs,
-					   unsigned long sfsr,
-					   unsigned long sfar);
 extern void sun4v_data_access_exception(struct pt_regs *regs,
 					unsigned long addr,
 					unsigned long type_ctx);
@@ -578,6 +578,7 @@ void handle_ld_nf(u32 insn, struct pt_regs *regs)
 
 void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr)
 {
+	enum ctx_state prev_state = exception_enter();
 	unsigned long pc = regs->tpc;
 	unsigned long tstate = regs->tstate;
 	u32 insn;
@@ -632,13 +633,16 @@ daex:
 			sun4v_data_access_exception(regs, sfar, sfsr);
 		else
 			spitfire_data_access_exception(regs, sfsr, sfar);
-		return;
+		goto out;
 	}
 	advance(regs);
+out:
+	exception_exit(prev_state);
 }
 
 void handle_stdfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr)
 {
+	enum ctx_state prev_state = exception_enter();
 	unsigned long pc = regs->tpc;
 	unsigned long tstate = regs->tstate;
 	u32 insn;
@@ -680,7 +684,9 @@ daex:
 			sun4v_data_access_exception(regs, sfar, sfsr);
 		else
 			spitfire_data_access_exception(regs, sfsr, sfar);
-		return;
+		goto out;
 	}
 	advance(regs);
+out:
+	exception_exit(prev_state);
 }
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 5062ff3..45ab8ef 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -21,6 +21,7 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/percpu.h>
+#include <linux/context_tracking.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -272,6 +273,7 @@ static void noinline __kprobes bogus_32bit_fault_address(struct pt_regs *regs,
 
 asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 {
+	enum ctx_state prev_state = exception_enter();
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned int insn = 0;
@@ -282,7 +284,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	fault_code = get_thread_fault_code();
 
 	if (notify_page_fault(regs))
-		return;
+		goto exit_exception;
 
 	si_code = SEGV_MAPERR;
 	address = current_thread_info()->fault_address;
@@ -313,7 +315,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			/* Valid, no problems... */
 		} else {
 			bad_kernel_pc(regs, address);
-			return;
+			goto exit_exception;
 		}
 	}
 
@@ -428,7 +430,7 @@ good_area:
 	fault = handle_mm_fault(mm, vma, address, flags);
 
 	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
-		return;
+		goto exit_exception;
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
@@ -480,6 +482,8 @@ good_area:
 
 	}
 #endif
+exit_exception:
+	exception_exit(prev_state);
 	return;
 
 	/*
@@ -492,7 +496,7 @@ bad_area:
 
 handle_kernel_fault:
 	do_kernel_fault(regs, si_code, fault_code, insn, address);
-	return;
+	goto exit_exception;
 
 /*
  * We ran out of memory, or some other thing happened to us that made
@@ -503,7 +507,7 @@ out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (!(regs->tstate & TSTATE_PRIV)) {
 		pagefault_out_of_memory();
-		return;
+		goto exit_exception;
 	}
 	goto handle_kernel_fault;
 
