From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 26 Jul 2013 12:42:39 +0000
Subject: [PATCH]sparc64: cleanup: Rename ret_from_syscall to ret_from_fork
Message-Id: <63481374842559@web28d.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Rename to make the function name better conform to its goal.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
(Of course, if there is no historical reason...)
 arch/sparc/include/asm/switch_to_64.h |    4 ++--
 arch/sparc/kernel/kgdb_64.c           |    4 ++--
 arch/sparc/kernel/syscalls.S          |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
diff --git a/arch/sparc/include/asm/switch_to_64.h b/arch/sparc/include/asm/switch_to_64.h
index c7de332..8d28480 100644
--- a/arch/sparc/include/asm/switch_to_64.h
+++ b/arch/sparc/include/asm/switch_to_64.h
@@ -48,8 +48,8 @@ do {	save_and_clear_fpu();						\
 	"wrpr	%%g0, 14, %%pil\n\t"					\
 	"brz,pt %%o7, switch_to_pc\n\t"					\
 	" mov	%%g7, %0\n\t"						\
-	"sethi	%%hi(ret_from_syscall), %%g1\n\t"			\
-	"jmpl	%%g1 + %%lo(ret_from_syscall), %%g0\n\t"		\
+	"sethi	%%hi(ret_from_fork), %%g1\n\t"				\
+	"jmpl	%%g1 + %%lo(ret_from_fork), %%g0\n\t"			\
 	" nop\n\t"							\
 	".globl switch_to_pc\n\t"					\
 	"switch_to_pc:\n\t"						\
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index c875955..53c0a82 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -42,7 +42,7 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 {
 	struct thread_info *t = task_thread_info(p);
 	extern unsigned int switch_to_pc;
-	extern unsigned int ret_from_syscall;
+	extern unsigned int ret_from_fork;
 	struct reg_window *win;
 	unsigned long pc, cwp;
 	int i;
@@ -66,7 +66,7 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 		gdb_regs[i] = 0;
 
 	if (t->new_child)
-		pc = (unsigned long) &ret_from_syscall;
+		pc = (unsigned long) &ret_from_fork;
 	else
 		pc = (unsigned long) &switch_to_pc;
 
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 22a1098..868ed22 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -98,8 +98,8 @@ sys_clone:
 	ba,pt	%xcc, sparc_do_fork
 	 add	%sp, PTREGS_OFF, %o2
 
-	.globl	ret_from_syscall
-ret_from_syscall:
+	.globl	ret_from_fork
+ret_from_fork:
 	/* Clear current_thread_info()->new_child. */
 	stb	%g0, [%g6 + TI_NEW_CHILD]
 	call	schedule_tail
