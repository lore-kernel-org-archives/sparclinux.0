From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:58:08 +0000
Subject: [PATCH 09/11] sparc: add '32' suffix to reg_window, sigcontext, __siginfo_t
Message-Id: <1230595090-23982-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Renaming a few types to contain a 32 suffix makes the
type names compatible with sparc64 and thus makes sharing
between the two a lot easier.

Note: None of these definitions are expected part of the
stable ABI towards suerspace.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/processor_32.h   |    2 +-
 arch/sparc/include/asm/ptrace_32.h      |    2 +-
 arch/sparc/include/asm/sigcontext_32.h  |    9 +++------
 arch/sparc/include/asm/thread_info_32.h |    2 +-
 arch/sparc/kernel/kgdb_32.c             |   12 ++++++------
 arch/sparc/kernel/muldiv.c              |    8 ++++----
 arch/sparc/kernel/process_32.c          |   16 ++++++++--------
 arch/sparc/kernel/signal_32.c           |    6 +++---
 arch/sparc/kernel/traps_32.c            |    4 ++--
 arch/sparc/kernel/unaligned_32.c        |   12 ++++++------
 arch/sparc/kernel/windows.c             |    6 +++---
 11 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 2ae67a2..09521c6 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -99,7 +99,7 @@ static inline void start_thread(struct pt_regs * regs, unsigned long pc,
 			     "st\t%%g0, [%0 + %3 + 0x3c]"
 			     : /* no outputs */
 			     : "r" (regs),
-			       "r" (sp - sizeof(struct reg_window)),
+			       "r" (sp - sizeof(struct reg_window32)),
 			       "r" (zero),
 			       "i" ((const unsigned long)(&((struct pt_regs *)0)->u_regs[0]))
 			     : "memory");
diff --git a/arch/sparc/include/asm/ptrace_32.h b/arch/sparc/include/asm/ptrace_32.h
index 4cef450..acb2d89 100644
--- a/arch/sparc/include/asm/ptrace_32.h
+++ b/arch/sparc/include/asm/ptrace_32.h
@@ -41,7 +41,7 @@ struct pt_regs {
 #define UREG_RETPC     UREG_I7
 
 /* A register window */
-struct reg_window {
+struct reg_window32 {
 	unsigned long locals[8];
 	unsigned long ins[8];
 };
diff --git a/arch/sparc/include/asm/sigcontext_32.h b/arch/sparc/include/asm/sigcontext_32.h
index c5fb60d..756e996 100644
--- a/arch/sparc/include/asm/sigcontext_32.h
+++ b/arch/sparc/include/asm/sigcontext_32.h
@@ -9,7 +9,7 @@
 #define __SUNOS_MAXWIN   31
 
 /* This is what SunOS does, so shall I. */
-struct sigcontext {
+struct sigcontext32 {
 	int sigc_onstack;      /* state to restore */
 	int sigc_mask;         /* sigmask to restore */
 	int sigc_sp;           /* stack pointer */
@@ -28,10 +28,7 @@ struct sigcontext {
 	char *sigc_spbuf[__SUNOS_MAXWIN];
 
 	/* Windows to restore after signal */
-	struct {
-		unsigned long	locals[8];
-		unsigned long	ins[8];
-	} sigc_wbuf[__SUNOS_MAXWIN];
+	struct reg_window32 sigc_wbuf[__SUNOS_MAXWIN];
 };
 
 typedef struct {
@@ -43,7 +40,7 @@ typedef struct {
 		unsigned long u_regs[16]; /* globals and ins */
 	}		si_regs;
 	int		si_mask;
-} __siginfo_t;
+} __siginfo32_t;
 
 typedef struct {
 	unsigned   long si_float_regs [32];
diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index 80fe547..0f7b0e5 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -45,7 +45,7 @@ struct thread_info {
 	/* A place to store user windows and stack pointers
 	 * when the stack needs inspection.
 	 */
-	struct reg_window	reg_window[NSWINS];	/* align for ldd! */
+	struct reg_window32	reg_window[NSWINS];	/* align for ldd! */
 	unsigned long		rwbuf_stkptrs[NSWINS];
 	unsigned long		w_saved;
 
diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index 757805c..04df4ed 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -14,14 +14,14 @@ extern unsigned long trapbase;
 
 void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
-	struct reg_window *win;
+	struct reg_window32 *win;
 	int i;
 
 	gdb_regs[GDB_G0] = 0;
 	for (i = 0; i < 15; i++)
 		gdb_regs[GDB_G1 + i] = regs->u_regs[UREG_G1 + i];
 
-	win = (struct reg_window *) regs->u_regs[UREG_FP];
+	win = (struct reg_window32 *) regs->u_regs[UREG_FP];
 	for (i = 0; i < 8; i++)
 		gdb_regs[GDB_L0 + i] = win->locals[i];
 	for (i = 0; i < 8; i++)
@@ -43,7 +43,7 @@ void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 {
 	struct thread_info *t = task_thread_info(p);
-	struct reg_window *win;
+	struct reg_window32 *win;
 	int i;
 
 	for (i = GDB_G0; i < GDB_G6; i++)
@@ -55,7 +55,7 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 	gdb_regs[GDB_SP] = t->ksp;
 	gdb_regs[GDB_O7] = 0;
 
-	win = (struct reg_window *) t->ksp;
+	win = (struct reg_window32 *) t->ksp;
 	for (i = 0; i < 8; i++)
 		gdb_regs[GDB_L0 + i] = win->locals[i];
 	for (i = 0; i < 8; i++)
@@ -77,7 +77,7 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 
 void gdb_regs_to_pt_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
-	struct reg_window *win;
+	struct reg_window32 *win;
 	int i;
 
 	for (i = 0; i < 15; i++)
@@ -96,7 +96,7 @@ void gdb_regs_to_pt_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 	regs->npc = gdb_regs[GDB_NPC];
 	regs->y = gdb_regs[GDB_Y];
 
-	win = (struct reg_window *) regs->u_regs[UREG_FP];
+	win = (struct reg_window32 *) regs->u_regs[UREG_FP];
 	for (i = 0; i < 8; i++)
 		win->locals[i] = gdb_regs[GDB_L0 + i];
 	for (i = 0; i < 8; i++)
diff --git a/arch/sparc/kernel/muldiv.c b/arch/sparc/kernel/muldiv.c
index ba960c0..6ce1021 100644
--- a/arch/sparc/kernel/muldiv.c
+++ b/arch/sparc/kernel/muldiv.c
@@ -60,7 +60,7 @@ static inline void maybe_flush_windows(unsigned int rs1, unsigned int rs2,
 }
 
 #define fetch_reg(reg, regs) ({						\
-	struct reg_window __user *win;					\
+	struct reg_window32 __user *win;					\
 	register unsigned long ret;					\
 									\
 	if (!(reg)) ret = 0;						\
@@ -68,7 +68,7 @@ static inline void maybe_flush_windows(unsigned int rs1, unsigned int rs2,
 		ret = regs->u_regs[(reg)];				\
 	} else {							\
 		/* Ho hum, the slightly complicated case. */		\
-		win = (struct reg_window __user *)regs->u_regs[UREG_FP];\
+		win = (struct reg_window32 __user *)regs->u_regs[UREG_FP];\
 		if (get_user (ret, &win->locals[(reg) - 16])) return -1;\
 	}								\
 	ret;								\
@@ -77,7 +77,7 @@ static inline void maybe_flush_windows(unsigned int rs1, unsigned int rs2,
 static inline int
 store_reg(unsigned int result, unsigned int reg, struct pt_regs *regs)
 {
-	struct reg_window __user *win;
+	struct reg_window32 __user *win;
 
 	if (!reg)
 		return 0;
@@ -86,7 +86,7 @@ store_reg(unsigned int result, unsigned int reg, struct pt_regs *regs)
 		return 0;
 	} else {
 		/* need to use put_user() in this case: */
-		win = (struct reg_window __user *) regs->u_regs[UREG_FP];
+		win = (struct reg_window32 __user *) regs->u_regs[UREG_FP];
 		return (put_user(result, &win->locals[reg - 16]));
 	}
 }
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 69d9315..5a8d8ce 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -180,13 +180,13 @@ static DEFINE_SPINLOCK(sparc_backtrace_lock);
 
 void __show_backtrace(unsigned long fp)
 {
-	struct reg_window *rw;
+	struct reg_window32 *rw;
 	unsigned long flags;
 	int cpu = smp_processor_id();
 
 	spin_lock_irqsave(&sparc_backtrace_lock, flags);
 
-	rw = (struct reg_window *)fp;
+	rw = (struct reg_window32 *)fp;
         while(rw && (((unsigned long) rw) >= PAGE_OFFSET) &&
             !(((unsigned long) rw) & 0x7)) {
 		printk("CPU[%d]: ARGS[%08lx,%08lx,%08lx,%08lx,%08lx,%08lx] "
@@ -196,7 +196,7 @@ void __show_backtrace(unsigned long fp)
 		       rw->ins[6],
 		       rw->ins[7]);
 		printk("%pS\n", (void *) rw->ins[7]);
-		rw = (struct reg_window *) rw->ins[6];
+		rw = (struct reg_window32 *) rw->ins[6];
 	}
 	spin_unlock_irqrestore(&sparc_backtrace_lock, flags);
 }
@@ -258,7 +258,7 @@ void show_stackframe(struct sparc_stackf *sf)
 
 void show_regs(struct pt_regs *r)
 {
-	struct reg_window *rw = (struct reg_window *) r->u_regs[14];
+	struct reg_window32 *rw = (struct reg_window32 *) r->u_regs[14];
 
         printk("PSR: %08lx PC: %08lx NPC: %08lx Y: %08lx    %s\n",
 	       r->psr, r->pc, r->npc, r->y, print_tainted());
@@ -287,7 +287,7 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 {
 	unsigned long pc, fp;
 	unsigned long task_base;
-	struct reg_window *rw;
+	struct reg_window32 *rw;
 	int count = 0;
 
 	if (tsk != NULL)
@@ -301,7 +301,7 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 		if (fp < (task_base + sizeof(struct thread_info)) ||
 		    fp >= (task_base + (PAGE_SIZE << 1)))
 			break;
-		rw = (struct reg_window *) fp;
+		rw = (struct reg_window32 *) fp;
 		pc = rw->ins[7];
 		printk("[%08lx : ", pc);
 		printk("%pS ] ", (void *) pc);
@@ -679,7 +679,7 @@ unsigned long get_wchan(struct task_struct *task)
 	unsigned long pc, fp, bias = 0;
 	unsigned long task_base = (unsigned long) task;
         unsigned long ret = 0;
-	struct reg_window *rw;
+	struct reg_window32 *rw;
 	int count = 0;
 
 	if (!task || task = current ||
@@ -692,7 +692,7 @@ unsigned long get_wchan(struct task_struct *task)
 		if (fp < (task_base + sizeof(struct thread_info)) ||
 		    fp >= (task_base + (2 * PAGE_SIZE)))
 			break;
-		rw = (struct reg_window *) fp;
+		rw = (struct reg_window32 *) fp;
 		pc = rw->ins[7];
 		if (!in_sched_functions(pc)) {
 			ret = pc;
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index c94f91c..181d069 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -34,7 +34,7 @@ extern void fpload(unsigned long *fpregs, unsigned long *fsr);
 
 struct signal_frame {
 	struct sparc_stackf	ss;
-	__siginfo_t		info;
+	__siginfo32_t		info;
 	__siginfo_fpu_t __user	*fpu_save;
 	unsigned long		insns[2] __attribute__ ((aligned (8)));
 	unsigned int		extramask[_NSIG_WORDS - 1];
@@ -351,7 +351,7 @@ static void setup_frame(struct k_sigaction *ka, struct pt_regs *regs,
 	err |= __copy_to_user(sf->extramask, &oldset->sig[1],
 			      (_NSIG_WORDS - 1) * sizeof(unsigned int));
 	err |= __copy_to_user(sf, (char *) regs->u_regs[UREG_FP],
-			      sizeof(struct reg_window));
+			      sizeof(struct reg_window32));
 	if (err)
 		goto sigsegv;
 	
@@ -433,7 +433,7 @@ static void setup_rt_frame(struct k_sigaction *ka, struct pt_regs *regs,
 	err |= __put_user(current->sas_ss_size, &sf->stack.ss_size);
 	
 	err |= __copy_to_user(sf, (char *) regs->u_regs[UREG_FP],
-			      sizeof(struct reg_window));	
+			      sizeof(struct reg_window32));
 
 	err |= copy_siginfo_to_user(&sf->info, info);
 
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 716f394..213645b 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -67,7 +67,7 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 	__RESTORE; __RESTORE; __RESTORE; __RESTORE;
 
 	{
-		struct reg_window *rw = (struct reg_window *)regs->u_regs[UREG_FP];
+		struct reg_window32 *rw = (struct reg_window32 *)regs->u_regs[UREG_FP];
 
 		/* Stop the back trace when we hit userland or we
 		 * find some badly aligned kernel stack. Set an upper
@@ -79,7 +79,7 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 		      !(((unsigned long) rw) & 0x7)) {
 			printk("Caller[%08lx]: %pS\n", rw->ins[7],
 			       (void *) rw->ins[7]);
-			rw = (struct reg_window *)rw->ins[6];
+			rw = (struct reg_window32 *)rw->ins[6];
 		}
 	}
 	printk("Instruction DUMP:");
diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
index c2a28c5..6b1e6cd 100644
--- a/arch/sparc/kernel/unaligned_32.c
+++ b/arch/sparc/kernel/unaligned_32.c
@@ -97,26 +97,26 @@ static inline int sign_extend_imm13(int imm)
 
 static inline unsigned long fetch_reg(unsigned int reg, struct pt_regs *regs)
 {
-	struct reg_window *win;
+	struct reg_window32 *win;
 
 	if(reg < 16)
 		return (!reg ? 0 : regs->u_regs[reg]);
 
 	/* Ho hum, the slightly complicated case. */
-	win = (struct reg_window *) regs->u_regs[UREG_FP];
+	win = (struct reg_window32 *) regs->u_regs[UREG_FP];
 	return win->locals[reg - 16]; /* yes, I know what this does... */
 }
 
 static inline unsigned long safe_fetch_reg(unsigned int reg, struct pt_regs *regs)
 {
-	struct reg_window __user *win;
+	struct reg_window32 __user *win;
 	unsigned long ret;
 
 	if (reg < 16)
 		return (!reg ? 0 : regs->u_regs[reg]);
 
 	/* Ho hum, the slightly complicated case. */
-	win = (struct reg_window __user *) regs->u_regs[UREG_FP];
+	win = (struct reg_window32 __user *) regs->u_regs[UREG_FP];
 
 	if ((unsigned long)win & 3)
 		return -1;
@@ -129,11 +129,11 @@ static inline unsigned long safe_fetch_reg(unsigned int reg, struct pt_regs *reg
 
 static inline unsigned long *fetch_reg_addr(unsigned int reg, struct pt_regs *regs)
 {
-	struct reg_window *win;
+	struct reg_window32 *win;
 
 	if(reg < 16)
 		return &regs->u_regs[reg];
-	win = (struct reg_window *) regs->u_regs[UREG_FP];
+	win = (struct reg_window32 *) regs->u_regs[UREG_FP];
 	return &win->locals[reg - 16];
 }
 
diff --git a/arch/sparc/kernel/windows.c b/arch/sparc/kernel/windows.c
index 9cc93ea..f24d298 100644
--- a/arch/sparc/kernel/windows.c
+++ b/arch/sparc/kernel/windows.c
@@ -42,7 +42,7 @@ static inline void shift_window_buffer(int first_win, int last_win, struct threa
 
 	for(i = first_win; i < last_win; i++) {
 		tp->rwbuf_stkptrs[i] = tp->rwbuf_stkptrs[i+1];
-		memcpy(&tp->reg_window[i], &tp->reg_window[i+1], sizeof(struct reg_window));
+		memcpy(&tp->reg_window[i], &tp->reg_window[i+1], sizeof(struct reg_window32));
 	}
 }
 
@@ -70,7 +70,7 @@ void synchronize_user_stack(void)
 
 		/* Ok, let it rip. */
 		if (copy_to_user((char __user *) sp, &tp->reg_window[window],
-				 sizeof(struct reg_window)))
+				 sizeof(struct reg_window32)))
 			continue;
 
 		shift_window_buffer(window, tp->w_saved - 1, tp);
@@ -119,7 +119,7 @@ void try_to_clear_window_buffer(struct pt_regs *regs, int who)
 
 		if ((sp & 7) ||
 		    copy_to_user((char __user *) sp, &tp->reg_window[window],
-				 sizeof(struct reg_window)))
+				 sizeof(struct reg_window32)))
 			do_exit(SIGILL);
 	}
 	tp->w_saved = 0;
-- 
1.6.0.2.GIT

