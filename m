From: David Miller <davem@davemloft.net>
Date: Wed, 03 Mar 2010 16:09:34 +0000
Subject: [PATCH] sparc64: Kill off old sys_perfctr system call and state.
Message-Id: <20100303.080934.179359794.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just committed the following patch to sparc-2.6

sparc64: Kill off old sys_perfctr system call and state.

People should be using the perf events interfaces, and
the way these system call facilities used the %pcr conflicts
with the usage of the NMI watchdog and perf events.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/perfctr.h        |    4 +-
 arch/sparc/include/asm/system_64.h      |   15 +----
 arch/sparc/include/asm/thread_info_64.h |   25 ++-----
 arch/sparc/kernel/entry.h               |    1 -
 arch/sparc/kernel/process_64.c          |   23 -------
 arch/sparc/kernel/rtrap_64.S            |   54 +---------------
 arch/sparc/kernel/sys32.S               |    1 -
 arch/sparc/kernel/sys_sparc_64.c        |  104 -------------------------------
 arch/sparc/kernel/syscalls.S            |   23 +------
 arch/sparc/kernel/systbls.h             |    2 -
 arch/sparc/kernel/systbls_64.S          |    4 +-
 arch/sparc/kernel/traps_64.c            |    9 ---
 12 files changed, 18 insertions(+), 247 deletions(-)

diff --git a/arch/sparc/include/asm/perfctr.h b/arch/sparc/include/asm/perfctr.h
index 8368730..8d8720a 100644
--- a/arch/sparc/include/asm/perfctr.h
+++ b/arch/sparc/include/asm/perfctr.h
@@ -10,8 +10,8 @@
  * from enumeration below.  The meaning of further arguments
  * are determined by the operation code.
  *
- * int sys_perfctr(int opcode, unsigned long arg0,
- *                 unsigned long arg1, unsigned long arg2)
+ * NOTE: This system call is no longer provided, use the perf_events
+ *       infrastructure.
  *
  * Pointers which are passed by the user are pointers to 64-bit
  * integers.
diff --git a/arch/sparc/include/asm/system_64.h b/arch/sparc/include/asm/system_64.h
index d47a98e..d24cfe1 100644
--- a/arch/sparc/include/asm/system_64.h
+++ b/arch/sparc/include/asm/system_64.h
@@ -143,15 +143,7 @@ do {						\
 	 * and 2 stores in this critical code path.  -DaveM
 	 */
 #define switch_to(prev, next, last)					\
-do {	if (test_thread_flag(TIF_PERFCTR)) {				\
-		unsigned long __tmp;					\
-		read_pcr(__tmp);					\
-		current_thread_info()->pcr_reg = __tmp;			\
-		read_pic(__tmp);					\
-		current_thread_info()->kernel_cntd0 += (unsigned int)(__tmp);\
-		current_thread_info()->kernel_cntd1 += ((__tmp) >> 32);	\
-	}								\
-	flush_tlb_pending();						\
+do {	flush_tlb_pending();						\
 	save_and_clear_fpu();						\
 	/* If you are tempted to conditionalize the following */	\
 	/* so that ASI is only written if it changes, think again. */	\
@@ -197,11 +189,6 @@ do {	if (test_thread_flag(TIF_PERFCTR)) {				\
 	        "l1", "l2", "l3", "l4", "l5", "l6", "l7",		\
 	  "i0", "i1", "i2", "i3", "i4", "i5",				\
 	  "o0", "o1", "o2", "o3", "o4", "o5",       "o7");		\
-	/* If you fuck with this, update ret_from_syscall code too. */	\
-	if (test_thread_flag(TIF_PERFCTR)) {				\
-		write_pcr(current_thread_info()->pcr_reg);		\
-		reset_pic();						\
-	}								\
 } while(0)
 
 static inline unsigned long xchg32(__volatile__ unsigned int *m, unsigned int val)
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 39be9f2..9e2d944 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -58,11 +58,6 @@ struct thread_info {
 	unsigned long		gsr[7];
 	unsigned long		xfsr[7];
 
-	__u64			__user *user_cntd0;
-	__u64			__user *user_cntd1;
-	__u64			kernel_cntd0, kernel_cntd1;
-	__u64			pcr_reg;
-
 	struct restart_block	restart_block;
 
 	struct pt_regs		*kern_una_regs;
@@ -96,15 +91,10 @@ struct thread_info {
 #define TI_RWIN_SPTRS	0x000003c8
 #define TI_GSR		0x00000400
 #define TI_XFSR		0x00000438
-#define TI_USER_CNTD0	0x00000470
-#define TI_USER_CNTD1	0x00000478
-#define TI_KERN_CNTD0	0x00000480
-#define TI_KERN_CNTD1	0x00000488
-#define TI_PCR		0x00000490
-#define TI_RESTART_BLOCK 0x00000498
-#define TI_KUNA_REGS	0x000004c8
-#define TI_KUNA_INSN	0x000004d0
-#define TI_FPREGS	0x00000500
+#define TI_RESTART_BLOCK 0x00000470
+#define TI_KUNA_REGS	0x000004a0
+#define TI_KUNA_INSN	0x000004a8
+#define TI_FPREGS	0x000004c0
 
 /* We embed this in the uppermost byte of thread_info->flags */
 #define FAULT_CODE_WRITE	0x01	/* Write access, implies D-TLB	   */
@@ -199,7 +189,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
  *
  * On trap return we need to test several values:
  *
- * user:	need_resched, notify_resume, sigpending, wsaved, perfctr
+ * user:	need_resched, notify_resume, sigpending, wsaved
  * kernel:	fpdepth
  *
  * So to check for work in the kernel case we simply load the fpdepth
@@ -220,7 +210,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_PERFCTR		4	/* performance counters active */
+/* flag bit 4 is available */
 #define TIF_UNALIGNED		5	/* allowed to do unaligned accesses */
 /* flag bit 6 is available */
 #define TIF_32BIT		7	/* 32-bit binary */
@@ -241,7 +231,6 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-#define _TIF_PERFCTR		(1<<TIF_PERFCTR)
 #define _TIF_UNALIGNED		(1<<TIF_UNALIGNED)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
@@ -252,7 +241,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 
 #define _TIF_USER_WORK_MASK	((0xff << TI_FLAG_WSAVED_SHIFT) | \
 				 _TIF_DO_NOTIFY_RESUME_MASK | \
-				 _TIF_NEED_RESCHED | _TIF_PERFCTR)
+				 _TIF_NEED_RESCHED)
 #define _TIF_DO_NOTIFY_RESUME_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING)
 
 /*
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 4f53a23..c011b93 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -48,7 +48,6 @@ extern void __init boot_cpu_id_too_large(int cpu);
 extern unsigned int dcache_parity_tl1_occurred;
 extern unsigned int icache_parity_tl1_occurred;
 
-extern asmlinkage void update_perfctrs(void);
 extern asmlinkage void sparc_breakpoint(struct pt_regs *regs);
 extern void timer_interrupt(int irq, struct pt_regs *regs);
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index cb70476..a5cf386 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -352,12 +352,6 @@ void exit_thread(void)
 		else
 			t->utraps[0]--;
 	}
-
-	if (test_and_clear_thread_flag(TIF_PERFCTR)) {
-		t->user_cntd0 = t->user_cntd1 = NULL;
-		t->pcr_reg = 0;
-		write_pcr(0);
-	}
 }
 
 void flush_thread(void)
@@ -371,13 +365,6 @@ void flush_thread(void)
 
 	set_thread_wsaved(0);
 
-	/* Turn off performance counters if on. */
-	if (test_and_clear_thread_flag(TIF_PERFCTR)) {
-		t->user_cntd0 = t->user_cntd1 = NULL;
-		t->pcr_reg = 0;
-		write_pcr(0);
-	}
-
 	/* Clear FPU register state. */
 	t->fpsaved[0] = 0;
 	
@@ -591,16 +578,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		t->kregs->u_regs[UREG_FP]  		  ((unsigned long) child_sf) - STACK_BIAS;
 
-		/* Special case, if we are spawning a kernel thread from
-		 * a userspace task (usermode helper, NFS or similar), we
-		 * must disable performance counters in the child because
-		 * the address space and protection realm are changing.
-		 */
-		if (t->flags & _TIF_PERFCTR) {
-			t->user_cntd0 = t->user_cntd1 = NULL;
-			t->pcr_reg = 0;
-			t->flags &= ~_TIF_PERFCTR;
-		}
 		t->flags |= ((long)ASI_P << TI_FLAG_CURRENT_DS_SHIFT);
 		t->kregs->u_regs[UREG_G6] = (unsigned long) t;
 		t->kregs->u_regs[UREG_G4] = (unsigned long) t->task;
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index fd3cee4..e829a42 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -65,48 +65,6 @@ __handle_user_windows:
 		ba,pt			%xcc, __handle_user_windows_continue
 
 		 andn			%l1, %l4, %l1
-__handle_perfctrs:
-		call			update_perfctrs
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
-		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-		ldub			[%g6 + TI_WSAVED], %o2
-		brz,pt			%o2, 1f
-		 nop
-		/* Redo userwin+sched+sig checks */
-		call			fault_in_user_windows
-
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
-		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-		ldx			[%g6 + TI_FLAGS], %l0
-		andcc			%l0, _TIF_NEED_RESCHED, %g0
-		be,pt			%xcc, 1f
-
-		 nop
-		call			schedule
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
-		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-		ldx			[%g6 + TI_FLAGS], %l0
-1:		andcc			%l0, _TIF_DO_NOTIFY_RESUME_MASK, %g0
-
-		be,pt			%xcc, __handle_perfctrs_continue
-		 sethi			%hi(TSTATE_PEF), %o0
-		mov			%l5, %o1
-		add			%sp, PTREGS_OFF, %o0
-		mov			%l0, %o2
-		call			do_notify_resume
-
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
-		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
-		/* Signal delivery can modify pt_regs tstate, so we must
-		 * reload it.
-		 */
-		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
-		sethi			%hi(0xf << 20), %l4
-		and			%l1, %l4, %l4
-		andn			%l1, %l4, %l1
-		ba,pt			%xcc, __handle_perfctrs_continue
-
-		 sethi			%hi(TSTATE_PEF), %o0
 __handle_userfpu:
 		rd			%fprs, %l5
 		andcc			%l5, FPRS_FEF, %g0
@@ -191,9 +149,9 @@ rtrap_no_irq_enable:
 		 * take until the next local IRQ before the signal/resched
 		 * event would be handled.
 		 *
-		 * This also means that if we have to deal with performance
-		 * counters or user windows, we have to redo all of these
-		 * sched+signal checks with IRQs disabled.
+		 * This also means that if we have to deal with user
+		 * windows, we have to redo all of these sched+signal checks
+		 * with IRQs disabled.
 		 */
 to_user:	wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 		wrpr			0, %pil
@@ -214,12 +172,8 @@ __handle_signal_continue:
 		brnz,pn			%o2, __handle_user_windows
 		 nop
 __handle_user_windows_continue:
-		ldx			[%g6 + TI_FLAGS], %l5
-		andcc			%l5, _TIF_PERFCTR, %g0
 		sethi			%hi(TSTATE_PEF), %o0
-		bne,pn			%xcc, __handle_perfctrs
-__handle_perfctrs_continue:
-		 andcc			%l1, %o0, %g0
+		andcc			%l1, %o0, %g0
 
 		/* This fpdepth clear is necessary for non-syscall rtraps only */
 user_nowork:
diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
index e706113..46a76ba 100644
--- a/arch/sparc/kernel/sys32.S
+++ b/arch/sparc/kernel/sys32.S
@@ -51,7 +51,6 @@ SIGN1(sys32_exit_group, sys_exit_group, %o0)
 SIGN1(sys32_wait4, compat_sys_wait4, %o2)
 SIGN1(sys32_creat, sys_creat, %o1)
 SIGN1(sys32_mknod, sys_mknod, %o1)
-SIGN1(sys32_perfctr, sys_perfctr, %o0)
 SIGN1(sys32_umount, sys_umount, %o1)
 SIGN1(sys32_signal, sys_signal, %o0)
 SIGN1(sys32_access, sys_access, %o1)
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index d77f543..cb1bef6 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -27,7 +27,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/utrap.h>
-#include <asm/perfctr.h>
 #include <asm/unistd.h>
 
 #include "entry.h"
@@ -766,109 +765,6 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig, const struct sigaction __user *, act,
 	return ret;
 }
 
-/* Invoked by rtrap code to update performance counters in
- * user space.
- */
-asmlinkage void update_perfctrs(void)
-{
-	unsigned long pic, tmp;
-
-	read_pic(pic);
-	tmp = (current_thread_info()->kernel_cntd0 += (unsigned int)pic);
-	__put_user(tmp, current_thread_info()->user_cntd0);
-	tmp = (current_thread_info()->kernel_cntd1 += (pic >> 32));
-	__put_user(tmp, current_thread_info()->user_cntd1);
-	reset_pic();
-}
-
-SYSCALL_DEFINE4(perfctr, int, opcode, unsigned long, arg0,
-		unsigned long, arg1, unsigned long, arg2)
-{
-	int err = 0;
-
-	switch(opcode) {
-	case PERFCTR_ON:
-		current_thread_info()->pcr_reg = arg2;
-		current_thread_info()->user_cntd0 = (u64 __user *) arg0;
-		current_thread_info()->user_cntd1 = (u64 __user *) arg1;
-		current_thread_info()->kernel_cntd0 -			current_thread_info()->kernel_cntd1 = 0;
-		write_pcr(arg2);
-		reset_pic();
-		set_thread_flag(TIF_PERFCTR);
-		break;
-
-	case PERFCTR_OFF:
-		err = -EINVAL;
-		if (test_thread_flag(TIF_PERFCTR)) {
-			current_thread_info()->user_cntd0 -				current_thread_info()->user_cntd1 = NULL;
-			current_thread_info()->pcr_reg = 0;
-			write_pcr(0);
-			clear_thread_flag(TIF_PERFCTR);
-			err = 0;
-		}
-		break;
-
-	case PERFCTR_READ: {
-		unsigned long pic, tmp;
-
-		if (!test_thread_flag(TIF_PERFCTR)) {
-			err = -EINVAL;
-			break;
-		}
-		read_pic(pic);
-		tmp = (current_thread_info()->kernel_cntd0 += (unsigned int)pic);
-		err |= __put_user(tmp, current_thread_info()->user_cntd0);
-		tmp = (current_thread_info()->kernel_cntd1 += (pic >> 32));
-		err |= __put_user(tmp, current_thread_info()->user_cntd1);
-		reset_pic();
-		break;
-	}
-
-	case PERFCTR_CLRPIC:
-		if (!test_thread_flag(TIF_PERFCTR)) {
-			err = -EINVAL;
-			break;
-		}
-		current_thread_info()->kernel_cntd0 -			current_thread_info()->kernel_cntd1 = 0;
-		reset_pic();
-		break;
-
-	case PERFCTR_SETPCR: {
-		u64 __user *user_pcr = (u64 __user *)arg0;
-
-		if (!test_thread_flag(TIF_PERFCTR)) {
-			err = -EINVAL;
-			break;
-		}
-		err |= __get_user(current_thread_info()->pcr_reg, user_pcr);
-		write_pcr(current_thread_info()->pcr_reg);
-		current_thread_info()->kernel_cntd0 -			current_thread_info()->kernel_cntd1 = 0;
-		reset_pic();
-		break;
-	}
-
-	case PERFCTR_GETPCR: {
-		u64 __user *user_pcr = (u64 __user *)arg0;
-
-		if (!test_thread_flag(TIF_PERFCTR)) {
-			err = -EINVAL;
-			break;
-		}
-		err |= __put_user(current_thread_info()->pcr_reg, user_pcr);
-		break;
-	}
-
-	default:
-		err = -EINVAL;
-		break;
-	};
-	return err;
-}
-
 /*
  * Do a system call from kernel instead of calling sys_execve so we
  * end up with proper pt_regs.
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index dc4a458..1d7e274 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -110,31 +110,12 @@ sys_clone:
 
 	.globl	ret_from_syscall
 ret_from_syscall:
-	/* Clear current_thread_info()->new_child, and
-	 * check performance counter stuff too.
-	 */
+	/* Clear current_thread_info()->new_child. */
 	stb	%g0, [%g6 + TI_NEW_CHILD]
 	ldx	[%g6 + TI_FLAGS], %l0
 	call	schedule_tail
 	 mov	%g7, %o0
-	andcc	%l0, _TIF_PERFCTR, %g0
-	be,pt	%icc, 1f
-	 nop
-	ldx	[%g6 + TI_PCR], %o7
-	wr	%g0, %o7, %pcr
-
-	/* Blackbird errata workaround.  See commentary in
-	 * smp.c:smp_percpu_timer_interrupt() for more
-	 * information.
-	 */
-	ba,pt	%xcc, 99f
-	 nop
-
-	.align	64
-99:	wr	%g0, %g0, %pic
-	rd	%pic, %g0
-
-1:	ba,pt	%xcc, ret_sys_call
+	ba,pt	%xcc, ret_sys_call
 	 ldx	[%sp + PTREGS_OFF + PT_V9_I0], %o0
 
 	.globl	sparc_exit
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index d2f999a..68312fe 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -36,8 +36,6 @@ extern asmlinkage long sys_rt_sigaction(int sig,
 					struct sigaction __user *oact,
 					void __user *restorer,
 					size_t sigsetsize);
-extern asmlinkage long sys_perfctr(int opcode, unsigned long arg0,
-				   unsigned long arg1, unsigned long arg2);
 
 extern asmlinkage void sparc64_set_context(struct pt_regs *regs);
 extern asmlinkage void sparc64_get_context(struct pt_regs *regs);
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index e575b46..1761425 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -21,7 +21,7 @@ sys_call_table32:
 /*0*/	.word sys_restart_syscall, sys32_exit, sys_fork, sys_read, sys_write
 /*5*/	.word sys32_open, sys_close, sys32_wait4, sys32_creat, sys_link
 /*10*/  .word sys_unlink, sunos_execv, sys_chdir, sys_chown16, sys32_mknod
-/*15*/	.word sys_chmod, sys_lchown16, sys_brk, sys32_perfctr, sys32_lseek
+/*15*/	.word sys_chmod, sys_lchown16, sys_brk, sys_nis_syscall, sys32_lseek
 /*20*/	.word sys_getpid, sys_capget, sys_capset, sys_setuid16, sys_getuid16
 /*25*/	.word sys32_vmsplice, compat_sys_ptrace, sys_alarm, sys32_sigaltstack, sys_pause
 /*30*/	.word compat_sys_utime, sys_lchown, sys_fchown, sys32_access, sys32_nice
@@ -96,7 +96,7 @@ sys_call_table:
 /*0*/	.word sys_restart_syscall, sparc_exit, sys_fork, sys_read, sys_write
 /*5*/	.word sys_open, sys_close, sys_wait4, sys_creat, sys_link
 /*10*/  .word sys_unlink, sys_nis_syscall, sys_chdir, sys_chown, sys_mknod
-/*15*/	.word sys_chmod, sys_lchown, sys_brk, sys_perfctr, sys_lseek
+/*15*/	.word sys_chmod, sys_lchown, sys_brk, sys_nis_syscall, sys_lseek
 /*20*/	.word sys_getpid, sys_capget, sys_capset, sys_setuid, sys_getuid
 /*25*/	.word sys_vmsplice, sys_ptrace, sys_alarm, sys_sigaltstack, sys_nis_syscall
 /*30*/	.word sys_utime, sys_nis_syscall, sys_nis_syscall, sys_access, sys_nice
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 10f7bb9..bdc05a2 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2548,15 +2548,6 @@ void __init trap_init(void)
 					       rwbuf_stkptrs) ||
 		     TI_GSR != offsetof(struct thread_info, gsr) ||
 		     TI_XFSR != offsetof(struct thread_info, xfsr) ||
-		     TI_USER_CNTD0 != offsetof(struct thread_info,
-					       user_cntd0) ||
-		     TI_USER_CNTD1 != offsetof(struct thread_info,
-					       user_cntd1) ||
-		     TI_KERN_CNTD0 != offsetof(struct thread_info,
-					       kernel_cntd0) ||
-		     TI_KERN_CNTD1 != offsetof(struct thread_info,
-					       kernel_cntd1) ||
-		     TI_PCR != offsetof(struct thread_info, pcr_reg) ||
 		     TI_PRE_COUNT != offsetof(struct thread_info,
 					      preempt_count) ||
 		     TI_NEW_CHILD != offsetof(struct thread_info, new_child) ||
-- 
1.6.6.1

