From: Chris Torek <chris.torek@windriver.com>
Date: Sat, 14 Mar 2009 23:32:39 +0000
Subject: Re: question on sparc64 switch_to macro
Message-Id: <200903142332.n2ENWdn13881@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903141853.n2EIrqn13598@elf.torek.net>
In-Reply-To: <200903141853.n2EIrqn13598@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>It's a 2 minute hack, just test this patch below.

I'll give it to our guys here (the guy who has been working on it
for a couple of weeks now, and we now have Jason poking at it too:
we've fixed a couple of other machine-independent buglets in trying to
make the kgdbts code work, I assume Jason will send them on once we
have finalized them).

>BTW, there are things which we know won't work with KGDB on platforms
>like sparc that do single-step in software.  SMP KGDB usage on such
>platforms is basically hit-or-miss because it's very racy.  See:
>
>	http://kerneltrap.org/mailarchive/linux-kernel/2008/4/29/1647204

WRT this, I'll toss you this code that does part (but not all) of
what I think you are talking about in that mail archive thread.
This is not necessarily the final "we think it works" version yet
though :-) (and of course is for an older kernel, viz arch/sparc64/
path).

Chris

diff --git a/arch/sparc64/kernel/kgdb.c b/arch/sparc64/kernel/kgdb.c
index 5671b2a..b763ef8 100644
--- a/arch/sparc64/kernel/kgdb.c
+++ b/arch/sparc64/kernel/kgdb.c
@@ -5,11 +5,21 @@
 
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
+#include <linux/uaccess.h>
 
 #include <asm/kdebug.h>
 #include <asm/ptrace.h>
 #include <asm/irq.h>
 
+#include "../kernel/kstack.h"
+
+/* #define DEBUG_SPARC64_KGDB 1 */
+
+static unsigned long stepped_address_npc = 0;
+static unsigned int stepped_opcode_npc = 0;
+static unsigned long stepped_address_nnpc = 0;
+static unsigned int stepped_opcode_nnpc = 0;
+
 
 void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
@@ -134,6 +144,220 @@ void smp_kgdb_capture_client(struct pt_regs *regs)
 }
 #endif
 
+
+/* Macros below and sparc64GetNpc() code is mainly borrowed 
+ * from gdb::sparc-tdep.c and gdb::sparc64-linux-tdep.c 
+ */
+
+#define X_OP(i)		(((i) >> 30) & 0x3)
+#define X_RD(i)		(((i) >> 25) & 0x1f)
+#define X_A(i)			(((i) >> 29) & 1)
+#define X_COND(i)		(((i) >> 25) & 0xf)
+#define X_OP2(i)		(((i) >> 22) & 0x7)
+#define X_IMM22(i)	((i) & 0x3fffff)
+#define X_OP3(i)		(((i) >> 19) & 0x3f)
+#define X_RS1(i)		(((i) >> 14) & 0x1f)
+#define X_RS2(i)		((i) & 0x1f)
+#define X_I(i)			(((i) >> 13) & 1)
+
+/* Sign extension macros.  */
+#define X_DISP22(i)		((X_IMM22 (i) ^ 0x200000) - 0x200000)
+#define X_DISP19(i)		((((i) & 0x7ffff) ^ 0x40000) - 0x40000)
+#define X_SIMM13(i)		((((i) & 0x1fff) ^ 0x1000) - 0x1000)
+
+
+static unsigned long sparc64GetNpc(unsigned long pc, unsigned long *npc, const struct pt_regs *regs)
+{
+	unsigned int insn;
+	int conditional_p;
+	int branch_p = 0;
+	long offset = 0;			/* Must be signed for sign-extend. */
+	int error;
+
+	/* Read the current instruction at the PC */
+	error = probe_kernel_read(&insn, (char *)pc, BREAK_INSTR_SIZE);
+	if (error) {
+		return -EINVAL;
+	}
+
+	conditional_p = X_COND(insn) & 0x7;
+
+	if (X_OP(insn) = 0 && X_OP2(insn) = 3 && (insn & 0x1000000) = 0) {
+		/* Branch on Integer Register with Prediction (BPr). */
+		branch_p = 1;
+		conditional_p = 1;
+	}
+	else if (X_OP(insn) = 0 && X_OP2(insn) = 6) {
+		/* Branch on Floating-Point Condition Codes (FBfcc). */
+		branch_p = 1;
+		offset = 4 * X_DISP22(insn);
+	}
+	else if (X_OP(insn) = 0 && X_OP2(insn) = 5) {
+		/* Branch on Floating-Point Condition Codes with Prediction (FBPfcc). */
+		branch_p = 1;
+		offset = 4 * X_DISP19(insn);
+	}
+	else if (X_OP(insn) = 0 && X_OP2(insn) = 2) {
+		/* Branch on Integer Condition Codes (Bicc). */
+		branch_p = 1;
+		offset = 4 * X_DISP22(insn);
+	}
+	else if (X_OP(insn) = 0 && X_OP2(insn) = 1) {
+		/* Branch on Integer Condition Codes with Prediction (BPcc). */
+		branch_p = 1;
+		offset = 4 * X_DISP19(insn);
+	}
+	else if (X_OP(insn) = 2 && X_OP3(insn) = 0x3a) {
+		/* Trap instruction (TRAP). */
+		if (insn = 0x91d0206d) {
+
+			/* 
+			 * 0x91d0206d = "ta 0x16d" = tl0_linux64 (LINUX_64BIT_SYSCALL_TRAP).
+			 * Return the address of a system call's alternative return
+			 * address. 
+			 */
+
+			unsigned long trap_nnpc, trap_nnpc_addr;
+			unsigned long top_fp = regs->u_regs[UREG_FP];
+
+			if (top_fp & 1)
+				top_fp += STACK_BIAS;
+
+			/* 
+			 * The kernel puts the sigreturn registers on the stack,
+			 * and this is where the signal unwinding state is take from
+			 * when returning from a signal.
+			 * A siginfo_t sits 192 bytes from the base of the stack.  This
+			 * siginfo_t is 128 bytes, and is followed by the sigreturn
+			 * register save area. The saved PC sits at a 136 byte offset
+			 * into there. 
+			 */
+
+			trap_nnpc_addr = top_fp + 192 + 128 + 136;
+			if (!probe_kernel_read((char *)trap_nnpc_addr, &trap_nnpc, 8)) 
+				return trap_nnpc;
+			else
+				printk(KERN_CRIT "KGDB: Cannot read address 0x%lx\n", trap_nnpc_addr);
+		}
+		return 0;
+	}
+	else if (X_OP(insn) = 2 && X_OP3(insn) = 0x3e) {
+		/* 
+		 * DONE and RETRY instructions.
+		 * Here kgdb must happen in an irq trap handler. 
+		 * Therefore need to find pt_regs of the irq trap 
+		 * handler. Note that "regs" is not actually valid
+		 * unless kstack_is_trap_frame() is true.
+		 * The kstack_is_trap_frame() code handles this properly,
+		 * but we must use "regs" only if it says "yes".
+		 */
+
+		unsigned long top_fp = regs->u_regs[UREG_FP];
+		struct sparc_stackf *sf;
+		struct pt_regs *regs_irq;
+
+		if (top_fp & 1)
+			top_fp += STACK_BIAS;
+
+		sf = (struct sparc_stackf *) top_fp;
+		regs_irq = (struct pt_regs *) (sf + 1);
+
+		if (kstack_is_trap_frame(current_thread_info(), regs_irq)) {
+			if (X_RD(insn) = 0) {
+				/* DONE instruction */
+				return regs_irq->tnpc;
+			}
+			else if (X_RD(insn) = 1) {
+				/* RETRY instruction */
+				return regs_irq->tpc;
+			}
+		}
+		else
+			printk(KERN_CRIT "KGDB: Not in irq trap handler ???\n");
+
+		return 0;
+	}
+
+#ifdef DEBUG_SPARC64_KGDB
+	printk(KERN_CRIT "%s(%d): insn=0x%x branch=%d cond=%d offset=%ld\n", 
+				__FUNCTION__, __LINE__, insn, branch_p, conditional_p, offset);
+#endif
+
+	if (branch_p) {
+		if (conditional_p) {
+			/* For conditional branches, return nPC + 4 iff the annul bit is 1. */
+			return (X_A(insn) ? *npc + 4 : 0);
+		}
+		else {
+			/* 
+			 * For unconditional branches, return the target if its
+			 * specified condition is "always" and return nPC + 4 if the
+			 * condition is "never". If the annul bit is 1, set *NPC to
+			 * zero.
+			 */
+			if (X_COND(insn) = 0x0) {
+				pc = *npc, offset = 4;
+			}
+			if (X_A(insn)) {
+				*npc = 0;
+			}
+
+			if (!offset) {
+				printk(KERN_CRIT "KGDB: offset for inst=0x%x must no be 0\n", insn);
+			}
+
+			return pc + offset;
+		}
+	}
+
+	return 0;
+}
+
+
+struct kgdb_arch arch_kgdb_ops;
+static int sparc64_set_singlestep_breakpoint(unsigned long addr, unsigned int *opcode_p)
+{
+	int error;
+
+	/* First get the orignal opcode */
+	error = probe_kernel_read(opcode_p, (char *)addr, BREAK_INSTR_SIZE);
+	if (error != 0) {
+		printk(KERN_CRIT "KGDB: Unable to access opcode at next pc 0x%lx\n", addr);
+		return error;
+	}
+
+	/* Set the temporary breakpoint which put me back into kgdb trap */
+	error = probe_kernel_write((char *)addr, arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE);
+	if (error != 0) {
+		printk(KERN_CRIT "KGDB: Unable to write tmp BP at next pc 0x%lx\n", addr);
+		return error;
+	}
+
+	flushi(addr);
+	flushi(addr + 4);
+	return 0;
+}
+
+
+static int sparc64_remove_singlestep_breakpoint(unsigned long *addr_p, unsigned int *opcode_p)
+{
+	/* restores original instruction */
+	int error = probe_kernel_write((char*)(*addr_p), opcode_p, BREAK_INSTR_SIZE);
+	if (error != 0) {
+		printk(KERN_CRIT "KGDB: FATAL ERROR on instruction "
+			   "restore at 0x%lx\n", *addr_p);
+		return error;
+	}
+
+	flushi(*addr_p);
+	flushi(*addr_p + 4);
+
+	*addr_p = 0;
+	*opcode_p = 0;
+	return 0;
+}
+
+
 int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 			       char *remcomInBuffer, char *remcomOutBuffer,
 			       struct pt_regs *linux_regs)
@@ -141,7 +365,57 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 	unsigned long addr;
 	char *ptr;
 
+#ifdef DEBUG_SPARC64_KGDB
+	printk(KERN_CRIT "%s(%d): entering, cmd=%c\n", 
+				__FUNCTION__, __LINE__, remcomInBuffer[0]);
+
+#endif
+
+	atomic_set(&kgdb_cpu_doing_single_step, -1);
+
 	switch (remcomInBuffer[0]) {
+	case 's':
+	{
+		int error;
+		unsigned long pc, npc, nnpc;
+
+		/* Try to read optional parameter, pc unchanged if no parm */
+		ptr = &remcomInBuffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
+			linux_regs->tpc = addr;
+			linux_regs->tnpc = addr + 4;
+		}
+
+		/* Now try to predict the next instructions to put breakpoints */
+		pc = linux_regs->tpc;
+		npc = linux_regs->tnpc;
+		nnpc = sparc64GetNpc(pc, &npc, linux_regs);
+
+		if (npc != 0) {
+			stepped_address_npc = npc;
+			error = sparc64_set_singlestep_breakpoint(npc, &stepped_opcode_npc);
+			if (error != 0) {
+				return error;
+			}
+		}
+
+		if (nnpc != 0) {
+			stepped_address_nnpc = nnpc;
+			error = sparc64_set_singlestep_breakpoint(nnpc, &stepped_opcode_nnpc);
+			if (error != 0) {
+				return error;
+			}
+		}
+
+		if (linux_regs->tpc = (unsigned long) arch_kgdb_breakpoint) {
+			linux_regs->tpc = linux_regs->tnpc;
+			linux_regs->tnpc += 4;
+		}
+
+		atomic_set(&kgdb_cpu_doing_single_step, raw_smp_processor_id());
+
+		return 0;
+	}
 	case 'c':
 		/* try to read optional parameter, pc unchanged if no parm */
 		ptr = &remcomInBuffer[1];
@@ -166,6 +440,17 @@ asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs)
 {
 	unsigned long flags;
 
+#ifdef DEBUG_SPARC64_KGDB
+	printk(KERN_CRIT "\n%s(%d): ENTER KGDB - ad_npc=0x%lx, op_npc=0x%x, ad_nnpc=0x%lx, "
+				"op_nnpc=0x%x, pc=0x%lx, npc=0x%lx, cpu=%d, kgdb_active=%d, kgdb_single_step=%d, "
+				"ss_cpu=%d, kgdb_contthread=0x%lx, tl=0x%lx, pid=%d \n",
+				__FUNCTION__, __LINE__, stepped_address_npc, stepped_opcode_npc,
+				stepped_address_nnpc, stepped_opcode_nnpc, regs->tpc, regs->tnpc,
+				raw_smp_processor_id(), atomic_read(&kgdb_active), kgdb_single_step,
+				atomic_read(&kgdb_cpu_doing_single_step), kgdb_contthread,
+				trap_level, (current!=0?current->pid:0));
+#endif
+
 	if (user_mode(regs)) {
 		bad_trap(regs, trap_level);
 		return;
@@ -174,8 +459,35 @@ asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs)
 	flushw_all();
 
 	local_irq_save(flags);
+
+	if (atomic_read(&kgdb_active) != -1)
+		kgdb_nmicallback(raw_smp_processor_id(), regs);
+
+	/* Need to clean up the existing single step breakpoints */
+	if (stepped_address_npc != 0 && stepped_opcode_npc != 0) {
+		if (sparc64_remove_singlestep_breakpoint(&stepped_address_npc, &stepped_opcode_npc) != 0) {
+			return;
+		}
+	}
+	if (stepped_address_nnpc != 0 && stepped_opcode_nnpc != 0) {
+		if (sparc64_remove_singlestep_breakpoint(&stepped_address_nnpc, &stepped_opcode_nnpc) != 0) {
+			return;
+		}
+	}
+
 	kgdb_handle_exception(0x172, SIGTRAP, 0, regs);
 	local_irq_restore(flags);
+
+#ifdef DEBUG_SPARC64_KGDB
+	printk(KERN_CRIT "%s(%d): LEAVE KGDB - ad_npc=0x%lx, op_npc=0x%x, ad_nnpc=0x%lx, "
+				"op_nnpc=0x%x, pc=0x%lx, npc=0x%lx, cpu=%d, kgdb_active=%d, kgdb_single_step=%d, "
+				"ss_cpu=%d, kgdb_contthread=0x%lx, tl=0x%lx, pid=%d \n",
+				__FUNCTION__, __LINE__, stepped_address_npc, stepped_opcode_npc,
+				stepped_address_nnpc, stepped_opcode_nnpc, regs->tpc, regs->tnpc,
+				raw_smp_processor_id(), atomic_read(&kgdb_active), kgdb_single_step,
+				atomic_read(&kgdb_cpu_doing_single_step), kgdb_contthread,
+				trap_level, (current!=0?current->pid:0));
+#endif
 }
 
 int kgdb_arch_init(void)
diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 866f841..70b7105 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -133,11 +133,7 @@ static int force_hwbrks;
 static int hwbreaks_ok;
 static int hw_break_val;
 static int hw_break_val2;
-#if defined(CONFIG_SPARC)
-static int arch_needs_sstep_emulation = 1;
-#else
 static int arch_needs_sstep_emulation;
-#endif
 static unsigned long sstep_addr;
 static int sstep_state;
 
