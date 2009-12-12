From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:47 +0000
Subject: [PATCH 6/10]: sparc64: Add syscall tracepoint support.
Message-Id: <20091211.225547.183027053.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig                      |    1 +
 arch/sparc/include/asm/thread_info_64.h |    2 ++
 arch/sparc/include/asm/unistd.h         |    2 +-
 arch/sparc/kernel/entry.S               |    2 +-
 arch/sparc/kernel/ftrace.c              |   11 +++++++++++
 arch/sparc/kernel/ptrace_64.c           |   10 ++++++++++
 arch/sparc/kernel/syscalls.S            |   14 +++++++-------
 7 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 33ac1a9..108197a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,6 +43,7 @@ config SPARC64
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_SYSCALL_TRACEPOINTS
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 1b45a7b..7257ebb 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -227,6 +227,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 /* flag bit 8 is available */
 #define TIF_SECCOMP		9	/* secure computing */
 #define TIF_SYSCALL_AUDIT	10	/* syscall auditing active */
+#define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
 /* flag bit 11 is available */
 /* NOTE: Thread flags >= 12 should be ones we have no interest
  *       in using in assembly, else we can't use the mask as
@@ -246,6 +247,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index d8d25bd..cb4b9bf 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -398,7 +398,7 @@
 #define __NR_perf_event_open	327
 #define __NR_recvmmsg		328
 
-#define NR_SYSCALLS		329
+#define NR_syscalls		329
 
 #ifdef __32bit_syscall_numbers__
 /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ec9c7bc..1504df8 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1294,7 +1294,7 @@ linux_sparc_syscall:
 	sethi	%hi(PSR_SYSCALL), %l4
 	or	%l0, %l4, %l0
 	/* Direct access to user regs, must faster. */
-	cmp	%g1, NR_SYSCALLS
+	cmp	%g1, NR_syscalls
 	bgeu	linux_sparc_ni_syscall
 	 sll	%g1, 2, %l4
 	ld	[%l7 + %l4], %l7
diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index d3b1a30..29973da 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -4,6 +4,7 @@
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <trace/syscall.h>
 
 #include <asm/ftrace.h>
 
@@ -91,3 +92,13 @@ int __init ftrace_dyn_arch_init(void *data)
 }
 #endif
 
+#ifdef CONFIG_FTRACE_SYSCALLS
+
+extern unsigned int sys_call_table[];
+
+unsigned long __init arch_syscall_addr(int nr)
+{
+	return (unsigned long)sys_call_table[nr];
+}
+
+#endif
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 4ae91dc..2f6524d 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -23,6 +23,7 @@
 #include <linux/signal.h>
 #include <linux/regset.h>
 #include <linux/tracehook.h>
+#include <trace/syscall.h>
 #include <linux/compat.h>
 #include <linux/elf.h>
 
@@ -37,6 +38,9 @@
 #include <asm/cpudata.h>
 #include <asm/cacheflush.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 #include "entry.h"
 
 /* #define ALLOW_INIT_TRACING */
@@ -1059,6 +1063,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ret = tracehook_report_syscall_entry(regs);
 
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_enter(regs, regs->u_regs[UREG_G1]);
+
 	if (unlikely(current->audit_context) && !ret)
 		audit_syscall_entry((test_thread_flag(TIF_32BIT) ?
 				     AUDIT_ARCH_SPARC :
@@ -1084,6 +1091,9 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 		audit_syscall_exit(result, regs->u_regs[UREG_I0]);
 	}
 
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_exit(regs, regs->u_regs[UREG_G1]);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall_exit(regs, 0);
 }
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index d150c2a..dc4a458 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -62,7 +62,7 @@ sys32_rt_sigreturn:
 #endif
 	.align	32
 1:	ldx	[%g6 + TI_FLAGS], %l5
-	andcc	%l5, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %g0
+	andcc	%l5, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
 	be,pt	%icc, rtrap
 	 nop
 	call	syscall_trace_leave
@@ -187,7 +187,7 @@ linux_syscall_trace:
 	.globl	linux_sparc_syscall32
 linux_sparc_syscall32:
 	/* Direct access to user regs, much faster. */
-	cmp	%g1, NR_SYSCALLS			! IEU1	Group
+	cmp	%g1, NR_syscalls			! IEU1	Group
 	bgeu,pn	%xcc, linux_sparc_ni_syscall		! CTI
 	 srl	%i0, 0, %o0				! IEU0
 	sll	%g1, 2, %l4				! IEU0	Group
@@ -198,7 +198,7 @@ linux_sparc_syscall32:
 
 	srl	%i5, 0, %o5				! IEU1
 	srl	%i2, 0, %o2				! IEU0	Group
-	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %g0
+	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
 	bne,pn	%icc, linux_syscall_trace32		! CTI
 	 mov	%i0, %l5				! IEU1
 	call	%l7					! CTI	Group brk forced
@@ -210,7 +210,7 @@ linux_sparc_syscall32:
 	.globl	linux_sparc_syscall
 linux_sparc_syscall:
 	/* Direct access to user regs, much faster. */
-	cmp	%g1, NR_SYSCALLS			! IEU1	Group
+	cmp	%g1, NR_syscalls			! IEU1	Group
 	bgeu,pn	%xcc, linux_sparc_ni_syscall		! CTI
 	 mov	%i0, %o0				! IEU0
 	sll	%g1, 2, %l4				! IEU0	Group
@@ -221,7 +221,7 @@ linux_sparc_syscall:
 
 	mov	%i3, %o3				! IEU1
 	mov	%i4, %o4				! IEU0	Group
-	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %g0
+	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
 	bne,pn	%icc, linux_syscall_trace		! CTI	Group
 	 mov	%i0, %l5				! IEU0
 2:	call	%l7					! CTI	Group brk forced
@@ -245,7 +245,7 @@ ret_sys_call:
 
 	cmp	%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn	%xcc, 1f
-	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %l6
+	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %l6
 80:
 	/* System call success, clear Carry condition code. */
 	andn	%g3, %g2, %g3
@@ -260,7 +260,7 @@ ret_sys_call:
 	/* System call failure, set Carry condition code.
 	 * Also, get abs(errno) to return to the process.
 	 */
-	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %l6	
+	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %l6	
 	sub	%g0, %o0, %o0
 	or	%g3, %g2, %g3
 	stx	%o0, [%sp + PTREGS_OFF + PT_V9_I0]
-- 
1.6.5

