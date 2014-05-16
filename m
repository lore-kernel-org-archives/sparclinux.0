From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:48 +0000
Subject: [PATCH 10/34] sparc: fix sparse warning in math_{32,64}
Message-Id: <1400275572-17424-10-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following sparse warning:
math_{32,64}.c: warning: symbol 'do_mathemu' was not declared. Should it be static?

Add prototype in processor_{32,64} and drop extern in traps_{32,64}.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/processor_32.h | 1 +
 arch/sparc/include/asm/processor_64.h | 2 ++
 arch/sparc/kernel/traps_32.c          | 2 --
 arch/sparc/kernel/traps_64.c          | 2 --
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 2c7baa4..2bc9818 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -116,6 +116,7 @@ extern unsigned long get_wchan(struct task_struct *);
 #ifdef __KERNEL__
 
 extern struct task_struct *last_task_used_math;
+int do_mathemu(struct pt_regs *regs, struct task_struct *fpt);
 
 #define cpu_relax()	barrier()
 extern void (*sparc_idle)(void);
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 4c3f7f0..27ff7ae 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -253,6 +253,8 @@ static inline void prefetchw(const void *x)
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
+int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap);
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__ASM_SPARC64_PROCESSOR_H) */
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index a655e5b..6fd386c 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -219,8 +219,6 @@ static unsigned long fake_fsr;
 static unsigned long fake_queue[32] __attribute__ ((aligned (8)));
 static unsigned long fake_depth;
 
-extern int do_mathemu(struct pt_regs *, struct task_struct *);
-
 void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 		 unsigned long psr)
 {
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 4ced92f..4d7e12d 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2209,8 +2209,6 @@ out:
 	exception_exit(prev_state);
 }
 
-extern int do_mathemu(struct pt_regs *, struct fpustate *, bool);
-
 void do_fpother(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
-- 
1.9.0

