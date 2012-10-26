From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2012 22:38:01 +0000
Subject: [PATCH] sparc64: Make montmul/montsqr/mpmul usable in 32-bit threads.
Message-Id: <20121026.183801.702833023568462303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The Montgomery Multiply, Montgomery Square, and Multiple-Precision
Multiply instructions work by loading a combination of the floating
point and multiple register windows worth of integer registers
with the inputs.

These values are 64-bit.  But for 32-bit userland processes we only
save the low 32-bits of each integer register during a register spill.
This is because the register window save area is in the user stack and
has a fixed layout.

Therefore, the only way to use these instruction in 32-bit mode is to
perform the following sequence:

1) Load the top-32bits of a choosen integer register with a sentinel,
   say "-1".  This will be in the outer-most register window.

   The idea is that we're trying to see if the outer-most register
   window gets spilled, and thus the 64-bit values were truncated.

2) Load all the inputs for the montmul/montsqr/mpmul instruction,
   down to the inner-most register window.

3) Execute the opcode.

4) Traverse back up to the outer-most register window.

5) Check the sentinel, if it's still "-1" store the results.
   Otherwise retry the entire sequence.

This retry is extremely troublesome.  If you're just unlucky and an
interrupt or other trap happens, it'll push that outer-most window to
the stack and clear the sentinel when we restore it.

We could retry forever and never make forward progress if interrupts
arrive at a fast enough rate (consider perf events as one example).
So we have do limited retries and fallback to software which is
extremely non-deterministic.

Luckily it's very straightforward to provide a mechanism to let
32-bit applications use a 64-bit stack.  Stacks in 64-bit mode are
biased by 2047 bytes, which means that the lowest bit is set in the
actual %sp register value.

So if we see bit zero set in a 32-bit application's stack we treat
it like a 64-bit stack.

Runtime detection of such a facility is tricky, and cumbersome at
best.  For example, just trying to use a biased stack and seeing if it
works is hard to recover from (the signal handler will need to use an
alt stack, plus something along the lines of longjmp).  Therefore, we
add a system call to report a bitmask of arch specific features like
this in a cheap and less hairy way.

With help from Andy Polyakov.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/compat.h         |  5 ++--
 arch/sparc/include/asm/thread_info_64.h |  5 ++++
 arch/sparc/include/asm/ttable.h         | 24 ++++++++++++-------
 arch/sparc/include/uapi/asm/unistd.h    |  6 ++++-
 arch/sparc/kernel/perf_event.c          | 22 ++++++++++++-----
 arch/sparc/kernel/process_64.c          | 42 ++++++++++++++++++---------------
 arch/sparc/kernel/ptrace_64.c           |  4 ++--
 arch/sparc/kernel/sys_sparc_64.c        |  5 ++++
 arch/sparc/kernel/systbls_64.S          |  2 ++
 arch/sparc/kernel/unaligned_64.c        | 36 ++++++++++++++++++----------
 arch/sparc/kernel/visemul.c             | 23 +++++++++++-------
 arch/sparc/kernel/winfixup.S            |  2 ++
 arch/sparc/math-emu/math_64.c           |  2 +-
 13 files changed, 117 insertions(+), 61 deletions(-)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index cef99fb..830502fe 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -232,9 +232,10 @@ static inline void __user *arch_compat_alloc_user_space(long len)
 	struct pt_regs *regs = current_thread_info()->kregs;
 	unsigned long usp = regs->u_regs[UREG_I6];
 
-	if (!(test_thread_flag(TIF_32BIT)))
+	if (test_thread_64bit_stack(usp))
 		usp += STACK_BIAS;
-	else
+
+	if (test_thread_flag(TIF_32BIT))
 		usp &= 0xffffffffUL;
 
 	usp -= len;
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 4e22766..a3fe4dc 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -259,6 +259,11 @@ static inline bool test_and_clear_restore_sigmask(void)
 
 #define tsk_is_polling(t) test_tsk_thread_flag(t, TIF_POLLING_NRFLAG)
 
+#define thread32_stack_is_64bit(__SP) (((__SP) & 0x1) != 0)
+#define test_thread_64bit_stack(__SP) \
+	((test_thread_flag(TIF_32BIT) && !thread32_stack_is_64bit(__SP)) ? \
+	 false : true)
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
index 48f2807..71b5a67 100644
--- a/arch/sparc/include/asm/ttable.h
+++ b/arch/sparc/include/asm/ttable.h
@@ -372,7 +372,9 @@ etrap_spill_fixup_64bit:				\
 
 /* Normal 32bit spill */
 #define SPILL_2_GENERIC(ASI)				\
-	srl	%sp, 0, %sp;				\
+	and	%sp, 1, %g3;				\
+	brnz,pn	%g3, (. - (128 + 4));			\
+	 srl	%sp, 0, %sp;				\
 	stwa	%l0, [%sp + %g0] ASI;			\
 	mov	0x04, %g3;				\
 	stwa	%l1, [%sp + %g3] ASI;			\
@@ -398,14 +400,16 @@ etrap_spill_fixup_64bit:				\
 	stwa	%i6, [%g1 + %g0] ASI;			\
 	stwa	%i7, [%g1 + %g3] ASI;			\
 	saved;						\
-        retry; nop; nop;				\
+        retry;						\
 	b,a,pt	%xcc, spill_fixup_dax;			\
 	b,a,pt	%xcc, spill_fixup_mna;			\
 	b,a,pt	%xcc, spill_fixup;
 
 #define SPILL_2_GENERIC_ETRAP		\
 etrap_user_spill_32bit:			\
-	srl	%sp, 0, %sp;		\
+	and	%sp, 1, %g3;		\
+	brnz,pn	%g3, etrap_user_spill_64bit;	\
+	 srl	%sp, 0, %sp;		\
 	stwa	%l0, [%sp + 0x00] %asi;	\
 	stwa	%l1, [%sp + 0x04] %asi;	\
 	stwa	%l2, [%sp + 0x08] %asi;	\
@@ -427,7 +431,7 @@ etrap_user_spill_32bit:			\
 	ba,pt	%xcc, etrap_save;	\
 	 wrpr	%g1, %cwp;		\
 	nop; nop; nop; nop;		\
-	nop; nop; nop; nop;		\
+	nop; nop;			\
 	ba,a,pt	%xcc, etrap_spill_fixup_32bit; \
 	ba,a,pt	%xcc, etrap_spill_fixup_32bit; \
 	ba,a,pt	%xcc, etrap_spill_fixup_32bit;
@@ -592,7 +596,9 @@ user_rtt_fill_64bit:					\
 
 /* Normal 32bit fill */
 #define FILL_2_GENERIC(ASI)				\
-	srl	%sp, 0, %sp;				\
+	and	%sp, 1, %g3;				\
+	brnz,pn	%g3, (. - (128 + 4));			\
+	 srl	%sp, 0, %sp;				\
 	lduwa	[%sp + %g0] ASI, %l0;			\
 	mov	0x04, %g2;				\
 	mov	0x08, %g3;				\
@@ -616,14 +622,16 @@ user_rtt_fill_64bit:					\
 	lduwa	[%g1 + %g3] ASI, %i6;			\
 	lduwa	[%g1 + %g5] ASI, %i7;			\
 	restored;					\
-	retry; nop; nop; nop; nop;			\
+	retry; nop; nop;				\
 	b,a,pt	%xcc, fill_fixup_dax;			\
 	b,a,pt	%xcc, fill_fixup_mna;			\
 	b,a,pt	%xcc, fill_fixup;
 
 #define FILL_2_GENERIC_RTRAP				\
 user_rtt_fill_32bit:					\
-	srl	%sp, 0, %sp;				\
+	and	%sp, 1, %g3;				\
+	brnz,pn	%g3, user_rtt_fill_64bit;		\
+	 srl	%sp, 0, %sp;				\
 	lduwa	[%sp + 0x00] %asi, %l0;			\
 	lduwa	[%sp + 0x04] %asi, %l1;			\
 	lduwa	[%sp + 0x08] %asi, %l2;			\
@@ -643,7 +651,7 @@ user_rtt_fill_32bit:					\
 	ba,pt	%xcc, user_rtt_pre_restore;		\
 	 restored;					\
 	nop; nop; nop; nop; nop;			\
-	nop; nop; nop; nop; nop;			\
+	nop; nop; nop;					\
 	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
 	ba,a,pt	%xcc, user_rtt_fill_fixup;		\
 	ba,a,pt	%xcc, user_rtt_fill_fixup;
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 8974ef7..bed86a8 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -405,8 +405,12 @@
 #define __NR_setns		337
 #define __NR_process_vm_readv	338
 #define __NR_process_vm_writev	339
+#define __NR_kern_features	340
 
-#define NR_syscalls		340
+#define NR_syscalls		341
+
+/* Bitmask values returned from kern_features system call.  */
+#define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
 
 #ifdef __32bit_syscall_numbers__
 /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 885a8af..b5c38fa 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1762,15 +1762,25 @@ static void perf_callchain_user_32(struct perf_callchain_entry *entry,
 
 	ufp = regs->u_regs[UREG_I6] & 0xffffffffUL;
 	do {
-		struct sparc_stackf32 *usf, sf;
 		unsigned long pc;
 
-		usf = (struct sparc_stackf32 *) ufp;
-		if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
-			break;
+		if (thread32_stack_is_64bit(ufp)) {
+			struct sparc_stackf *usf, sf;
 
-		pc = sf.callers_pc;
-		ufp = (unsigned long)sf.fp;
+			ufp += STACK_BIAS;
+			usf = (struct sparc_stackf *) ufp;
+			if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
+				break;
+			pc = sf.callers_pc & 0xffffffff;
+			ufp = ((unsigned long) sf.fp) & 0xffffffff;
+		} else {
+			struct sparc_stackf32 *usf, sf;
+			usf = (struct sparc_stackf32 *) ufp;
+			if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
+				break;
+			pc = sf.callers_pc;
+			ufp = (unsigned long)sf.fp;
+		}
 		perf_callchain_store(entry, pc);
 	} while (entry->nr < PERF_MAX_STACK_DEPTH);
 }
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d778248..c6e0c29 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -452,13 +452,16 @@ void flush_thread(void)
 /* It's a bit more tricky when 64-bit tasks are involved... */
 static unsigned long clone_stackframe(unsigned long csp, unsigned long psp)
 {
+	bool stack_64bit = test_thread_64bit_stack(psp);
 	unsigned long fp, distance, rval;
 
-	if (!(test_thread_flag(TIF_32BIT))) {
+	if (stack_64bit) {
 		csp += STACK_BIAS;
 		psp += STACK_BIAS;
 		__get_user(fp, &(((struct reg_window __user *)psp)->ins[6]));
 		fp += STACK_BIAS;
+		if (test_thread_flag(TIF_32BIT))
+			fp &= 0xffffffff;
 	} else
 		__get_user(fp, &(((struct reg_window32 __user *)psp)->ins[6]));
 
@@ -472,7 +475,7 @@ static unsigned long clone_stackframe(unsigned long csp, unsigned long psp)
 	rval = (csp - distance);
 	if (copy_in_user((void __user *) rval, (void __user *) psp, distance))
 		rval = 0;
-	else if (test_thread_flag(TIF_32BIT)) {
+	else if (!stack_64bit) {
 		if (put_user(((u32)csp),
 			     &(((struct reg_window32 __user *)rval)->ins[6])))
 			rval = 0;
@@ -507,18 +510,18 @@ void synchronize_user_stack(void)
 
 	flush_user_windows();
 	if ((window = get_thread_wsaved()) != 0) {
-		int winsize = sizeof(struct reg_window);
-		int bias = 0;
-
-		if (test_thread_flag(TIF_32BIT))
-			winsize = sizeof(struct reg_window32);
-		else
-			bias = STACK_BIAS;
-
 		window -= 1;
 		do {
-			unsigned long sp = (t->rwbuf_stkptrs[window] + bias);
 			struct reg_window *rwin = &t->reg_window[window];
+			int winsize = sizeof(struct reg_window);
+			unsigned long sp;
+
+			sp = t->rwbuf_stkptrs[window];
+
+			if (test_thread_64bit_stack(sp))
+				sp += STACK_BIAS;
+			else
+				winsize = sizeof(struct reg_window32);
 
 			if (!copy_to_user((char __user *)sp, rwin, winsize)) {
 				shift_window_buffer(window, get_thread_wsaved() - 1, t);
@@ -544,13 +547,6 @@ void fault_in_user_windows(void)
 {
 	struct thread_info *t = current_thread_info();
 	unsigned long window;
-	int winsize = sizeof(struct reg_window);
-	int bias = 0;
-
-	if (test_thread_flag(TIF_32BIT))
-		winsize = sizeof(struct reg_window32);
-	else
-		bias = STACK_BIAS;
 
 	flush_user_windows();
 	window = get_thread_wsaved();
@@ -558,8 +554,16 @@ void fault_in_user_windows(void)
 	if (likely(window != 0)) {
 		window -= 1;
 		do {
-			unsigned long sp = (t->rwbuf_stkptrs[window] + bias);
 			struct reg_window *rwin = &t->reg_window[window];
+			int winsize = sizeof(struct reg_window);
+			unsigned long sp;
+
+			sp = t->rwbuf_stkptrs[window];
+
+			if (test_thread_64bit_stack(sp))
+				sp += STACK_BIAS;
+			else
+				winsize = sizeof(struct reg_window32);
 
 			if (unlikely(sp & 0x7UL))
 				stack_unaligned(sp);
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 484daba..7ff45e4 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -151,7 +151,7 @@ static int regwindow64_get(struct task_struct *target,
 {
 	unsigned long rw_addr = regs->u_regs[UREG_I6];
 
-	if (test_tsk_thread_flag(current, TIF_32BIT)) {
+	if (!test_thread_64bit_stack(rw_addr)) {
 		struct reg_window32 win32;
 		int i;
 
@@ -176,7 +176,7 @@ static int regwindow64_set(struct task_struct *target,
 {
 	unsigned long rw_addr = regs->u_regs[UREG_I6];
 
-	if (test_tsk_thread_flag(current, TIF_32BIT)) {
+	if (!test_thread_64bit_stack(rw_addr)) {
 		struct reg_window32 win32;
 		int i;
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 11c6c96..878ef3d 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -751,3 +751,8 @@ int kernel_execve(const char *filename,
 		      : "cc");
 	return __res;
 }
+
+asmlinkage long sys_kern_features(void)
+{
+	return KERN_FEATURE_MIXED_MODE_STACK;
+}
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 3a58e0d..45ce6be 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -86,6 +86,7 @@ sys_call_table32:
 	.word compat_sys_pwritev, compat_sys_rt_tgsigqueueinfo, sys_perf_event_open, compat_sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys32_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, compat_sys_open_by_handle_at, compat_sys_clock_adjtime
 	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
+/*340*/	.word sys_kern_features
 
 #endif /* CONFIG_COMPAT */
 
@@ -163,3 +164,4 @@ sys_call_table:
 	.word sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
+/*340*/	.word sys_kern_features
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index f81d038..8201c25e 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -113,21 +113,24 @@ static inline long sign_extend_imm13(long imm)
 
 static unsigned long fetch_reg(unsigned int reg, struct pt_regs *regs)
 {
-	unsigned long value;
+	unsigned long value, fp;
 	
 	if (reg < 16)
 		return (!reg ? 0 : regs->u_regs[reg]);
+
+	fp = regs->u_regs[UREG_FP];
+
 	if (regs->tstate & TSTATE_PRIV) {
 		struct reg_window *win;
-		win = (struct reg_window *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+		win = (struct reg_window *)(fp + STACK_BIAS);
 		value = win->locals[reg - 16];
-	} else if (test_thread_flag(TIF_32BIT)) {
+	} else if (!test_thread_64bit_stack(fp)) {
 		struct reg_window32 __user *win32;
-		win32 = (struct reg_window32 __user *)((unsigned long)((u32)regs->u_regs[UREG_FP]));
+		win32 = (struct reg_window32 __user *)((unsigned long)((u32)fp));
 		get_user(value, &win32->locals[reg - 16]);
 	} else {
 		struct reg_window __user *win;
-		win = (struct reg_window __user *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+		win = (struct reg_window __user *)(fp + STACK_BIAS);
 		get_user(value, &win->locals[reg - 16]);
 	}
 	return value;
@@ -135,19 +138,24 @@ static unsigned long fetch_reg(unsigned int reg, struct pt_regs *regs)
 
 static unsigned long *fetch_reg_addr(unsigned int reg, struct pt_regs *regs)
 {
+	unsigned long fp;
+
 	if (reg < 16)
 		return &regs->u_regs[reg];
+
+	fp = regs->u_regs[UREG_FP];
+
 	if (regs->tstate & TSTATE_PRIV) {
 		struct reg_window *win;
-		win = (struct reg_window *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+		win = (struct reg_window *)(fp + STACK_BIAS);
 		return &win->locals[reg - 16];
-	} else if (test_thread_flag(TIF_32BIT)) {
+	} else if (!test_thread_64bit_stack(fp)) {
 		struct reg_window32 *win32;
-		win32 = (struct reg_window32 *)((unsigned long)((u32)regs->u_regs[UREG_FP]));
+		win32 = (struct reg_window32 *)((unsigned long)((u32)fp));
 		return (unsigned long *)&win32->locals[reg - 16];
 	} else {
 		struct reg_window *win;
-		win = (struct reg_window *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+		win = (struct reg_window *)(fp + STACK_BIAS);
 		return &win->locals[reg - 16];
 	}
 }
@@ -392,13 +400,15 @@ int handle_popc(u32 insn, struct pt_regs *regs)
 		if (rd)
 			regs->u_regs[rd] = ret;
 	} else {
-		if (test_thread_flag(TIF_32BIT)) {
+		unsigned long fp = regs->u_regs[UREG_FP];
+
+		if (!test_thread_64bit_stack(fp)) {
 			struct reg_window32 __user *win32;
-			win32 = (struct reg_window32 __user *)((unsigned long)((u32)regs->u_regs[UREG_FP]));
+			win32 = (struct reg_window32 __user *)((unsigned long)((u32)fp));
 			put_user(ret, &win32->locals[rd - 16]);
 		} else {
 			struct reg_window __user *win;
-			win = (struct reg_window __user *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+			win = (struct reg_window __user *)(fp + STACK_BIAS);
 			put_user(ret, &win->locals[rd - 16]);
 		}
 	}
@@ -554,7 +564,7 @@ void handle_ld_nf(u32 insn, struct pt_regs *regs)
 		reg[0] = 0;
 		if ((insn & 0x780000) = 0x180000)
 			reg[1] = 0;
-	} else if (test_thread_flag(TIF_32BIT)) {
+	} else if (!test_thread_64bit_stack(regs->u_regs[UREG_FP])) {
 		put_user(0, (int __user *) reg);
 		if ((insn & 0x780000) = 0x180000)
 			put_user(0, ((int __user *) reg) + 1);
diff --git a/arch/sparc/kernel/visemul.c b/arch/sparc/kernel/visemul.c
index 08e074b7..c096c62 100644
--- a/arch/sparc/kernel/visemul.c
+++ b/arch/sparc/kernel/visemul.c
@@ -149,21 +149,24 @@ static inline void maybe_flush_windows(unsigned int rs1, unsigned int rs2,
 
 static unsigned long fetch_reg(unsigned int reg, struct pt_regs *regs)
 {
-	unsigned long value;
+	unsigned long value, fp;
 	
 	if (reg < 16)
 		return (!reg ? 0 : regs->u_regs[reg]);
+
+	fp = regs->u_regs[UREG_FP];
+
 	if (regs->tstate & TSTATE_PRIV) {
 		struct reg_window *win;
-		win = (struct reg_window *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+		win = (struct reg_window *)(fp + STACK_BIAS);
 		value = win->locals[reg - 16];
-	} else if (test_thread_flag(TIF_32BIT)) {
+	} else if (!test_thread_64bit_stack(fp)) {
 		struct reg_window32 __user *win32;
-		win32 = (struct reg_window32 __user *)((unsigned long)((u32)regs->u_regs[UREG_FP]));
+		win32 = (struct reg_window32 __user *)((unsigned long)((u32)fp));
 		get_user(value, &win32->locals[reg - 16]);
 	} else {
 		struct reg_window __user *win;
-		win = (struct reg_window __user *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+		win = (struct reg_window __user *)(fp + STACK_BIAS);
 		get_user(value, &win->locals[reg - 16]);
 	}
 	return value;
@@ -172,16 +175,18 @@ static unsigned long fetch_reg(unsigned int reg, struct pt_regs *regs)
 static inline unsigned long __user *__fetch_reg_addr_user(unsigned int reg,
 							  struct pt_regs *regs)
 {
+	unsigned long fp = regs->u_regs[UREG_FP];
+
 	BUG_ON(reg < 16);
 	BUG_ON(regs->tstate & TSTATE_PRIV);
 
-	if (test_thread_flag(TIF_32BIT)) {
+	if (!test_thread_64bit_stack(fp)) {
 		struct reg_window32 __user *win32;
-		win32 = (struct reg_window32 __user *)((unsigned long)((u32)regs->u_regs[UREG_FP]));
+		win32 = (struct reg_window32 __user *)((unsigned long)((u32)fp));
 		return (unsigned long __user *)&win32->locals[reg - 16];
 	} else {
 		struct reg_window __user *win;
-		win = (struct reg_window __user *)(regs->u_regs[UREG_FP] + STACK_BIAS);
+		win = (struct reg_window __user *)(fp + STACK_BIAS);
 		return &win->locals[reg - 16];
 	}
 }
@@ -204,7 +209,7 @@ static void store_reg(struct pt_regs *regs, unsigned long val, unsigned long rd)
 	} else {
 		unsigned long __user *rd_user = __fetch_reg_addr_user(rd, regs);
 
-		if (test_thread_flag(TIF_32BIT))
+		if (!test_thread_64bit_stack(regs->u_regs[UREG_FP]))
 			__put_user((u32)val, (u32 __user *)rd_user);
 		else
 			__put_user(val, rd_user);
diff --git a/arch/sparc/kernel/winfixup.S b/arch/sparc/kernel/winfixup.S
index a6b0863..1e67ce9 100644
--- a/arch/sparc/kernel/winfixup.S
+++ b/arch/sparc/kernel/winfixup.S
@@ -43,6 +43,8 @@ spill_fixup_mna:
 spill_fixup_dax:
 	TRAP_LOAD_THREAD_REG(%g6, %g1)
 	ldx	[%g6 + TI_FLAGS], %g1
+	andcc	%sp, 0x1, %g0
+	movne	%icc, 0, %g1
 	andcc	%g1, _TIF_32BIT, %g0
 	ldub	[%g6 + TI_WSAVED], %g1
 	sll	%g1, 3, %g3
diff --git a/arch/sparc/math-emu/math_64.c b/arch/sparc/math-emu/math_64.c
index 1704068..034aadb 100644
--- a/arch/sparc/math-emu/math_64.c
+++ b/arch/sparc/math-emu/math_64.c
@@ -320,7 +320,7 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 					XR = 0;
 				else if (freg < 16)
 					XR = regs->u_regs[freg];
-				else if (test_thread_flag(TIF_32BIT)) {
+				else if (!test_thread_64bit_stack(regs->u_regs[UREG_FP])) {
 					struct reg_window32 __user *win32;
 					flushw_user ();
 					win32 = (struct reg_window32 __user *)((unsigned long)((u32)regs->u_regs[UREG_FP]));
-- 
1.7.12.2.dirty

