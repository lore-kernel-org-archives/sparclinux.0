From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 20:37:34 +0000
Subject: [PATCH 3/5] sparc: fix sparse warnings in traps_32.c
Message-Id: <1228682256-27812-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o add decalrations to entry.h for functions only used from assembler
o add declaratiosn to kernel.h for functions only used from .c
o removed unused functions/extern declarations

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/entry.h    |   35 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/kernel.h   |    9 +++++++++
 arch/sparc/kernel/muldiv.c   |    5 ++---
 arch/sparc/kernel/traps_32.c |   34 +++-------------------------------
 4 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index a9ab19a..06db4f1 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -5,6 +5,40 @@
 #include <linux/types.h>
 #include <linux/init.h>
 
+#ifdef CONFIG_SPARC32
+/* traps */
+extern void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
+extern void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
+                                   unsigned long npc, unsigned long psr);
+
+extern void do_priv_instruction(struct pt_regs *regs, unsigned long pc,
+                                unsigned long npc, unsigned long psr);
+extern void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc,
+                                   unsigned long npc,
+                                   unsigned long psr);
+extern void do_fpd_trap(struct pt_regs *regs, unsigned long pc,
+                        unsigned long npc, unsigned long psr);
+extern void do_fpe_trap(struct pt_regs *regs, unsigned long pc,
+                        unsigned long npc, unsigned long psr);
+extern void handle_tag_overflow(struct pt_regs *regs, unsigned long pc,
+                                unsigned long npc, unsigned long psr);
+extern void handle_watchpoint(struct pt_regs *regs, unsigned long pc,
+                              unsigned long npc, unsigned long psr);
+extern void handle_reg_access(struct pt_regs *regs, unsigned long pc,
+                              unsigned long npc, unsigned long psr);
+extern void handle_cp_disabled(struct pt_regs *regs, unsigned long pc,
+                               unsigned long npc, unsigned long psr);
+extern void handle_cp_exception(struct pt_regs *regs, unsigned long pc,
+                                unsigned long npc, unsigned long psr);
+
+
+
+/* entry.S */
+extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
+                   void *fpqueue, unsigned long *fpqdepth);
+extern void fpload(unsigned long *fpregs, unsigned long *fsr);
+
+#else /* CONFIG_SPARC32 */
 extern void __init per_cpu_patch(void);
 extern void __init sun4v_patch(void);
 extern void __init boot_cpu_id_too_large(int cpu);
@@ -189,4 +223,5 @@ extern void handler_irq(int irq, struct pt_regs *regs);
 extern void init_irqwork_curcpu(void);
 extern void __cpuinit sun4v_register_mondo_queues(int this_cpu);
 
+#endif /* CONFIG_SPARC32 */
 #endif /* _ENTRY_H */
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 7f02aad..3fa8338 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -4,5 +4,14 @@ extern const char *sparc_fpu_type;
 
 extern unsigned int fsr_storage;
 
+#ifdef CONFIG_SPARC32
+/* cpu.c */
 extern void cpu_probe(void);
 
+/* traps_32.c */
+extern void handle_hw_divzero(struct pt_regs *regs, unsigned long pc,
+                              unsigned long npc, unsigned long psr);
+/* muldiv.c */
+extern int do_user_muldiv (struct pt_regs *, unsigned long);
+#else /* CONFIG_SPARC32 */
+#endif
diff --git a/arch/sparc/kernel/muldiv.c b/arch/sparc/kernel/muldiv.c
index e352239..ba960c0 100644
--- a/arch/sparc/kernel/muldiv.c
+++ b/arch/sparc/kernel/muldiv.c
@@ -17,6 +17,8 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
+#include "kernel.h"
+
 /* #define DEBUG_MULDIV */
 
 static inline int has_imm13(int insn)
@@ -88,9 +90,6 @@ store_reg(unsigned int result, unsigned int reg, struct pt_regs *regs)
 		return (put_user(result, &win->locals[reg - 16]));
 	}
 }
-		
-extern void handle_hw_divzero (struct pt_regs *regs, unsigned long pc,
-			       unsigned long npc, unsigned long psr);
 
 /* Should return 0 if mul/div emulation succeeded and SIGILL should
  * not be issued.
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 2b7d506..716f394 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -25,31 +25,10 @@
 #include <asm/unistd.h>
 #include <asm/traps.h>
 
-/* #define TRAP_DEBUG */
-
-struct trap_trace_entry {
-	unsigned long pc;
-	unsigned long type;
-};
-
-void syscall_trace_entry(struct pt_regs *regs)
-{
-	printk("%s[%d]: ", current->comm, task_pid_nr(current));
-	printk("scall<%d> (could be %d)\n", (int) regs->u_regs[UREG_G1],
-	       (int) regs->u_regs[UREG_I0]);
-}
-
-void syscall_trace_exit(struct pt_regs *regs)
-{
-}
+#include "entry.h"
+#include "kernel.h"
 
-void sun4d_nmi(struct pt_regs *regs)
-{
-	printk("Aieee: sun4d NMI received!\n");
-	printk("you lose buddy boy...\n");
-	show_regs(regs);
-	prom_halt();
-}
+/* #define TRAP_DEBUG */
 
 static void instruction_dump(unsigned long *pc)
 {
@@ -134,7 +113,6 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
-	extern int do_user_muldiv (struct pt_regs *, unsigned long);
 	siginfo_t info;
 
 	if(psr & PSR_PS)
@@ -195,10 +173,6 @@ void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc, unsigned lon
 	send_sig_info(SIGBUS, &info, current);
 }
 
-extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
-		   void *fpqueue, unsigned long *fpqdepth);
-extern void fpload(unsigned long *fpregs, unsigned long *fsr);
-
 static unsigned long init_fsr = 0x0UL;
 static unsigned long init_fregs[32] __attribute__ ((aligned (8)))                  { ~0UL, ~0UL, ~0UL, ~0UL, ~0UL, ~0UL, ~0UL, ~0UL,
@@ -456,8 +430,6 @@ void do_BUG(const char *file, int line)
  * up here so that timer interrupts work during initialization.
  */
 
-extern void sparc_cpu_startup(void);
-
 void trap_init(void)
 {
 	extern void thread_info_offsets_are_bolixed_pete(void);
-- 
1.5.6.GIT

