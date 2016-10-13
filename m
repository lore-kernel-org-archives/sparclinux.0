From: Allen Pais <allen.pais@oracle.com>
Date: Thu, 13 Oct 2016 04:48:13 +0000
Subject: [PATCH V2 1/1] sparc64:Support User Probes for sparc
Message-Id: <1476333373-4091-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/Kconfig                            |    1 +
 arch/sparc/Kconfig                      |    3 +
 arch/sparc/configs/sparc64_defconfig    |    1 +
 arch/sparc/include/asm/kdebug_64.h      |    2 +
 arch/sparc/include/asm/ptrace.h         |   35 ++++-
 arch/sparc/include/asm/thread_info_64.h |    6 +-
 arch/sparc/include/asm/ttable.h         |    6 +
 arch/sparc/include/asm/uprobes.h        |   59 ++++++
 arch/sparc/kernel/Makefile              |    1 +
 arch/sparc/kernel/ptrace_64.c           |   54 +++++
 arch/sparc/kernel/signal_64.c           |    2 +
 arch/sparc/kernel/ttable_64.S           |    2 +-
 arch/sparc/kernel/uprobes.c             |  331 +++++++++++++++++++++++++++++++
 include/linux/uprobes.h                 |    1 +
 14 files changed, 500 insertions(+), 4 deletions(-)
 create mode 100644 arch/sparc/include/asm/uprobes.h
 create mode 100644 arch/sparc/kernel/uprobes.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 180ea33..fa2f0d1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -96,6 +96,7 @@ config KPROBES_ON_FTRACE
 
 config UPROBES
 	def_bool n
+	depends on ARCH_SUPPORTS_UPROBES
 	help
 	  Uprobes is the user-space counterpart to kprobes: they
 	  enable instrumentation applications (such as 'perf probe')
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index b23c76b..a6cbe9b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -146,6 +146,9 @@ config PGTABLE_LEVELS
 	default 4 if 64BIT
 	default 3
 
+config ARCH_SUPPORTS_UPROBES
+	def_bool y if SPARC64
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 3583d67..b2e650d 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -213,6 +213,7 @@ CONFIG_SCHEDSTATS=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_UPROBE_EVENTS=y
 CONFIG_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/sparc/include/asm/kdebug_64.h b/arch/sparc/include/asm/kdebug_64.h
index 04465de..867286b 100644
--- a/arch/sparc/include/asm/kdebug_64.h
+++ b/arch/sparc/include/asm/kdebug_64.h
@@ -10,6 +10,8 @@ enum die_val {
 	DIE_OOPS = 1,
 	DIE_DEBUG,	/* ta 0x70 */
 	DIE_DEBUG_2,	/* ta 0x71 */
+	DIE_BPT,	/* ta 0x73 */
+	DIE_SSTEP,	/* ta 0x74 */
 	DIE_DIE,
 	DIE_TRAP,
 	DIE_TRAP_TL1,
diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index bac6a94..ca57f08 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -61,7 +61,10 @@ struct global_pmu_snapshot {
 #define force_successful_syscall_return() set_thread_noerror(1)
 #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
 #define instruction_pointer(regs) ((regs)->tpc)
-#define instruction_pointer_set(regs, val) ((regs)->tpc = (val))
+#define instruction_pointer_set(regs, val) do { \
+		(regs)->tpc = (val); \
+		(regs)->tnpc = (val)+4; \
+	} while (0)
 #define user_stack_pointer(regs) ((regs)->u_regs[UREG_FP])
 static inline int is_syscall_success(struct pt_regs *regs)
 {
@@ -77,6 +80,36 @@ static inline long regs_return_value(struct pt_regs *regs)
 #else
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
+
+#define MAX_REG_OFFSET (offsetof(struct pt_regs, magic))
+
+extern int regs_query_register_offset(const char *name);
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:	pt_regs from which register value is gotten
+ * @offset:	offset number of the register.
+ *
+ * regs_get_register returns the value of a register whose
+ * offset from @regs. The @offset is the offset of the register
+ * in struct pt_regs. If @offset is bigger than MAX_REG_OFFSET,
+ * this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+					     unsigned long offset)
+{
+	if (unlikely(offset >= MAX_REG_OFFSET))
+		return 0;
+	if (offset = PT_V9_Y)
+		return *(unsigned int *)((unsigned long)regs + offset);
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
+/* Valid only for Kernel mode traps. */
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return regs->u_regs[UREG_I6];
+}
 #else /* __ASSEMBLY__ */
 #endif /* __ASSEMBLY__ */
 #else /* (defined(__sparc__) && defined(__arch64__)) */
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 3d7b925..38a24f2 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -180,7 +180,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 /* flag bit 4 is available */
 #define TIF_UNALIGNED		5	/* allowed to do unaligned accesses */
-/* flag bit 6 is available */
+#define TIF_UPROBE		6	/* breakpointed or singlestepped */
 #define TIF_32BIT		7	/* 32-bit binary */
 #define TIF_NOHZ		8	/* in adaptive nohz mode */
 #define TIF_SECCOMP		9	/* secure computing */
@@ -199,6 +199,7 @@ struct thread_info {
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_UNALIGNED		(1<<TIF_UNALIGNED)
+#define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
@@ -209,7 +210,8 @@ struct thread_info {
 #define _TIF_USER_WORK_MASK	((0xff << TI_FLAG_WSAVED_SHIFT) | \
 				 _TIF_DO_NOTIFY_RESUME_MASK | \
 				 _TIF_NEED_RESCHED)
-#define _TIF_DO_NOTIFY_RESUME_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING)
+#define _TIF_DO_NOTIFY_RESUME_MASK	(_TIF_NOTIFY_RESUME | \
+					 _TIF_SIGPENDING | _TIF_UPROBE)
 
 #define is_32bit_task()	(test_thread_flag(TIF_32BIT))
 
diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
index 781b9f1..82e7df2 100644
--- a/arch/sparc/include/asm/ttable.h
+++ b/arch/sparc/include/asm/ttable.h
@@ -186,6 +186,12 @@
 #define KPROBES_TRAP(lvl) TRAP_ARG(bad_trap, lvl)
 #endif
 
+#ifdef CONFIG_UPROBES
+#define UPROBES_TRAP(lvl) TRAP_ARG(uprobe_trap, lvl)
+#else
+#define UPROBES_TRAP(lvl) TRAP_ARG(bad_trap, lvl)
+#endif
+
 #ifdef CONFIG_KGDB
 #define KGDB_TRAP(lvl) TRAP_IRQ(kgdb_trap, lvl)
 #else
diff --git a/arch/sparc/include/asm/uprobes.h b/arch/sparc/include/asm/uprobes.h
new file mode 100644
index 0000000..f87aae5
--- /dev/null
+++ b/arch/sparc/include/asm/uprobes.h
@@ -0,0 +1,59 @@
+#ifndef _ASM_UPROBES_H
+#define _ASM_UPROBES_H
+/*
+ * User-space Probes (UProbes) for sparc
+ *
+ * Copyright (C) 2013 Oracle, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Authors:
+ *     Jose E. Marchesi <jose.marchesi@oracle.com>
+ *	Eric Saint Etienne <eric.saint.etienne@oracle.com>
+ */
+
+typedef u32 uprobe_opcode_t;
+
+#define MAX_UINSN_BYTES		4
+#define UPROBE_XOL_SLOT_BYTES	(MAX_UINSN_BYTES * 2)
+
+#define UPROBE_SWBP_INSN_SIZE	4
+#define UPROBE_SWBP_INSN	0x91d02073 /* ta 0x73 */
+#define UPROBE_STP_INSN		0x91d02074 /* ta 0x74 */
+
+#define ANNUL_BIT (1 << 29)
+
+struct arch_uprobe {
+	union {
+		u8  insn[MAX_UINSN_BYTES];
+		u32 ixol;
+	};
+};
+
+struct arch_uprobe_task {
+	u32 saved_tpc;
+	u32 saved_tnpc;
+};
+
+struct task_struct;
+struct notifier_block;
+
+extern int  arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long addr);
+extern int  arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
+extern int  arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
+extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
+extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
+extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
+
+#endif	/* _ASM_UPROBES_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index fdb1332..eb6da9b 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -116,4 +116,5 @@ obj-$(CONFIG_COMPAT)    += $(audit--y)
 pc--$(CONFIG_PERF_EVENTS) := perf_event.o
 obj-$(CONFIG_SPARC64)	+= $(pc--y)
 
+obj-$(CONFIG_UPROBES)	+= uprobes.o
 obj-$(CONFIG_SPARC64)	+= jump_label.o
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 9ddc492..44f2d63 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -46,6 +46,43 @@
 
 /* #define ALLOW_INIT_TRACING */
 
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(n, r) \
+	{.name = n, .offset = (PT_V9_##r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME("g0", G0),
+	REG_OFFSET_NAME("g1", G1),
+	REG_OFFSET_NAME("g2", G2),
+	REG_OFFSET_NAME("g3", G3),
+	REG_OFFSET_NAME("g4", G4),
+	REG_OFFSET_NAME("g5", G5),
+	REG_OFFSET_NAME("g6", G6),
+	REG_OFFSET_NAME("g7", G7),
+
+	REG_OFFSET_NAME("i0", I0),
+	REG_OFFSET_NAME("i1", I1),
+	REG_OFFSET_NAME("i2", I2),
+	REG_OFFSET_NAME("i3", I3),
+	REG_OFFSET_NAME("i4", I4),
+	REG_OFFSET_NAME("i5", I5),
+	REG_OFFSET_NAME("i6", I6),
+	REG_OFFSET_NAME("i7", I7),
+
+	REG_OFFSET_NAME("tstate", TSTATE),
+	REG_OFFSET_NAME("pc", TPC),
+	REG_OFFSET_NAME("npc", TNPC),
+	REG_OFFSET_NAME("y", Y),
+	REG_OFFSET_NAME("lr", I7),
+
+	REG_OFFSET_END,
+};
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
@@ -1099,3 +1136,20 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 	if (test_thread_flag(TIF_NOHZ))
 		user_enter();
 }
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 5ee930c..c782c9b 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -545,6 +545,8 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long thread_info_flags)
 {
 	user_exit();
+	if (thread_info_flags & _TIF_UPROBE)
+		uprobe_notify_resume(regs);
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs, orig_i0);
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
diff --git a/arch/sparc/kernel/ttable_64.S b/arch/sparc/kernel/ttable_64.S
index c6dfdaa..7bd8f65 100644
--- a/arch/sparc/kernel/ttable_64.S
+++ b/arch/sparc/kernel/ttable_64.S
@@ -165,7 +165,7 @@ tl0_resv169:	BTRAP(0x169) BTRAP(0x16a) BTRAP(0x16b) BTRAP(0x16c)
 tl0_linux64:	LINUX_64BIT_SYSCALL_TRAP
 tl0_gsctx:	TRAP(sparc64_get_context) TRAP(sparc64_set_context)
 tl0_resv170:	KPROBES_TRAP(0x170) KPROBES_TRAP(0x171) KGDB_TRAP(0x172)
-tl0_resv173:	BTRAP(0x173) BTRAP(0x174) BTRAP(0x175) BTRAP(0x176) BTRAP(0x177)
+tl0_resv173:	UPROBES_TRAP(0x173) UPROBES_TRAP(0x174) BTRAP(0x175) BTRAP(0x176) BTRAP(0x177)
 tl0_resv178:	BTRAP(0x178) BTRAP(0x179) BTRAP(0x17a) BTRAP(0x17b) BTRAP(0x17c)
 tl0_resv17d:	BTRAP(0x17d) BTRAP(0x17e) BTRAP(0x17f)
 #define BTRAPS(x) BTRAP(x) BTRAP(x+1) BTRAP(x+2) BTRAP(x+3) BTRAP(x+4) BTRAP(x+5) BTRAP(x+6) BTRAP(x+7)
diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
new file mode 100644
index 0000000..b683140
--- /dev/null
+++ b/arch/sparc/kernel/uprobes.c
@@ -0,0 +1,331 @@
+/*
+ * User-space Probes (UProbes) for sparc
+ *
+ * Copyright (C) 2013 Oracle Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Authors:
+ *	Jose E. Marchesi <jose.marchesi@oracle.com>
+ *	Eric Saint Etienne <eric.saint.etienne@oracle.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/highmem.h>
+#include <linux/uprobes.h>
+#include <linux/uaccess.h>
+#include <linux/sched.h> /* For struct task_struct */
+#include <linux/kdebug.h>
+
+#include <asm/cacheflush.h>
+#include <asm/uaccess.h>
+
+/* Compute the address of the breakpoint instruction and return it.
+ *
+ * Note that uprobe_get_swbp_addr is defined as a weak symbol in
+ * kernel/events/uprobe.c.
+ */
+unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
+{
+	return instruction_pointer(regs);
+}
+
+static void copy_to_page(struct page *page, unsigned long vaddr,
+			 const void *src, int len)
+{
+	void *kaddr = kmap_atomic(page);
+
+	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
+	kunmap_atomic(kaddr);
+}
+
+/* Fill in the xol area with the probed instruction followed by the
+ * single-step trap.  Some fixups in the copied instruction are
+ * performed at this point.
+ *
+ * Note that uprobe_xol_copy is defined as a weak symbol in
+ * kernel/events/uprobe.c.
+ */
+void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
+			   void *src, unsigned long len)
+{
+	const u32 stp_insn = UPROBE_STP_INSN;
+	u32 insn = *(u32 *) src;
+
+	/* Branches annulling their delay slot must be fixed to not do
+	 * so.  Clearing the annul bit on these instructions we can be
+	 * sure the single-step breakpoint in the XOL slot will be
+	 * executed.
+	 */
+
+	u32 op = (insn >> 30) & 0x3;
+	u32 op2 = (insn >> 22) & 0x7;
+
+	if (op = 0 &&
+	    (op2 = 1 || op2 = 2 || op2 = 3 || op2 = 5 || op2 = 6) &&
+	    (insn & ANNUL_BIT) = ANNUL_BIT)
+		insn &= ~ANNUL_BIT;
+
+	copy_to_page(page, vaddr, &insn, len);
+	copy_to_page(page, vaddr+len, &stp_insn, 4);
+}
+
+
+/* Instruction analysis/validity.
+ *
+ * This function returns 0 on success or a -ve number on error.
+ */
+int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
+			     struct mm_struct *mm, unsigned long addr)
+{
+	/* Any unsupported instruction?  Then return -EINVAL  */
+	return 0;
+}
+
+/* If INSN is a relative control transfer instruction, return the
+ * corrected branch destination value.
+ *
+ * Note that regs->tpc and regs->tnpc still hold the values of the
+ * program counters at the time of the single-step trap due to the
+ * execution of the UPROBE_STP_INSN at utask->xol_vaddr + 4.
+ *
+ */
+static unsigned long relbranch_fixup(u32 insn, struct uprobe_task *utask,
+				     struct pt_regs *regs)
+{
+	/* Branch not taken, no mods necessary.  */
+	if (regs->tnpc = regs->tpc + 0x4UL)
+		return utask->autask.saved_tnpc + 0x4UL;
+
+	/* The three cases are call, branch w/prediction,
+	 * and traditional branch.
+	 */
+	if ((insn & 0xc0000000) = 0x40000000 ||
+	    (insn & 0xc1c00000) = 0x00400000 ||
+	    (insn & 0xc1c00000) = 0x00800000) {
+		unsigned long real_pc = (unsigned long) utask->vaddr;
+		unsigned long ixol_addr = utask->xol_vaddr;
+
+		/* The instruction did all the work for us
+		 * already, just apply the offset to the correct
+		 * instruction location.
+		 */
+		return (real_pc + (regs->tnpc - ixol_addr));
+	}
+
+	/* It is jmpl or some other absolute PC modification instruction,
+	 * leave NPC as-is.
+	 */
+	return regs->tnpc;
+}
+
+/* If INSN is an instruction which writes its PC location
+ * into a destination register, fix that up.
+ */
+static int retpc_fixup(struct pt_regs *regs, u32 insn,
+		       unsigned long real_pc)
+{
+	unsigned long *slot = NULL;
+	int rc = 0;
+
+	/* Simplest case is 'call', which always uses %o7 */
+	if ((insn & 0xc0000000) = 0x40000000)
+		slot = &regs->u_regs[UREG_I7];
+
+	/* 'jmpl' encodes the register inside of the opcode */
+	if ((insn & 0xc1f80000) = 0x81c00000) {
+		unsigned long rd = ((insn >> 25) & 0x1f);
+
+		if (rd <= 15) {
+			slot = &regs->u_regs[rd];
+		} else {
+			unsigned long fp = regs->u_regs[UREG_FP];
+			/* Hard case, it goes onto the stack. */
+			flushw_all();
+
+			rd -= 16;
+			if (test_thread_64bit_stack(fp)) {
+				unsigned long __user *uslot +			(unsigned long __user *) (fp + STACK_BIAS) + rd;
+				rc = __put_user(real_pc, uslot);
+			} else {
+				unsigned int __user *uslot = (unsigned int
+						__user *) fp + rd;
+				rc = __put_user((u32) real_pc, uslot);
+			}
+		}
+	}
+	if (slot != NULL)
+		*slot = real_pc;
+	return rc;
+}
+
+/* Single-stepping can be avoided for certain instructions: NOPs and
+ * instructions that can be emulated.  This function determines
+ * whether the instruction where the uprobe is installed falls in one
+ * of these cases and emulates it.
+ *
+ * This function returns true if the single-stepping can be skipped,
+ * false otherwise.
+ */
+bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	/* We currently only emulate NOP instructions.
+	 */
+
+	if (auprobe->ixol = (1 << 24)) {
+		regs->tnpc += 4;
+		regs->tpc += 4;
+		return true;
+	}
+
+	return false;
+}
+
+/* Prepare to execute out of line.  At this point
+ * current->utask->xol_vaddr points to an allocated XOL slot properly
+ * initialized with the original instruction and the single-stepping
+ * trap instruction.
+ *
+ * This function returns 0 on success, any other number on error.
+ */
+int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+	struct arch_uprobe_task *autask = &current->utask->autask;
+
+	/* Save the current program counters so they can be restored
+	 * later.
+	 */
+	autask->saved_tpc = regs->tpc;
+	autask->saved_tnpc = regs->tnpc;
+
+	/* Adjust PC and NPC so the first instruction in the XOL slot
+	 * will be executed by the user task.
+	 */
+	instruction_pointer_set(regs, utask->xol_vaddr);
+
+	return 0;
+}
+
+/* Prepare to resume execution after the single-step.  Called after
+ * single-stepping. To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.
+ *
+ * This function returns 0 on success, any other number on error.
+ */
+int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+	struct arch_uprobe_task *autask = &utask->autask;
+	u32 insn = auprobe->ixol;
+	int rc = 0;
+
+	if (utask->state = UTASK_SSTEP_ACK) {
+		regs->tnpc = relbranch_fixup(insn, utask, regs);
+		regs->tpc = autask->saved_tnpc;
+		rc =  retpc_fixup(regs, insn, (unsigned long) utask->vaddr);
+	} else {
+		regs->tnpc = utask->vaddr+4;
+		regs->tpc = autask->saved_tnpc+4;
+	}
+	return rc;
+}
+
+/* Handler for uprobe traps.  This is called from the traps table and
+ * triggers the proper die notification.
+ */
+asmlinkage void uprobe_trap(struct pt_regs *regs,
+			    unsigned long trap_level)
+{
+	BUG_ON(trap_level != 0x173 && trap_level != 0x174);
+
+	/* We are only interested in user-mode code.  Uprobe traps
+	 * shall not be present in kernel code.
+	 */
+	if (!user_mode(regs)) {
+		local_irq_enable();
+		bad_trap(regs, trap_level);
+		return;
+	}
+
+	/* trap_level = 0x173 --> ta 0x73
+	 * trap_level = 0x174 --> ta 0x74
+	 */
+	if (notify_die((trap_level = 0x173) ? DIE_BPT : DIE_SSTEP,
+				(trap_level = 0x173) ? "bpt" : "sstep",
+				regs, 0, trap_level, SIGTRAP) != NOTIFY_STOP)
+		bad_trap(regs, trap_level);
+}
+
+/* Callback routine for handling die notifications.
+*/
+int arch_uprobe_exception_notify(struct notifier_block *self,
+				 unsigned long val, void *data)
+{
+	int ret = NOTIFY_DONE;
+	struct die_args *args = (struct die_args *)data;
+
+	/* We are only interested in userspace traps */
+	if (args->regs && !user_mode(args->regs))
+		return NOTIFY_DONE;
+
+	switch (val) {
+	case DIE_BPT:
+		if (uprobe_pre_sstep_notifier(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+
+	case DIE_SSTEP:
+		if (uprobe_post_sstep_notifier(args->regs))
+			ret = NOTIFY_STOP;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/* This function gets called when a XOL instruction either gets
+ * trapped or the thread has a fatal signal, so reset the instruction
+ * pointer to its probed address.
+ */
+void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
+{
+	struct uprobe_task *utask = current->utask;
+
+	instruction_pointer_set(regs, utask->vaddr);
+}
+
+/* If xol insn itself traps and generates a signal(Say,
+ * SIGILL/SIGSEGV/etc), then detect the case where a singlestepped
+ * instruction jumps back to its own address.
+ */
+bool arch_uprobe_xol_was_trapped(struct task_struct *t)
+{
+	return false;
+}
+
+unsigned long
+arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
+				  struct pt_regs *regs)
+{
+	unsigned long orig_ret_vaddr = regs->u_regs[UREG_I7];
+
+	regs->u_regs[UREG_I7] = trampoline_vaddr-8;
+
+	return orig_ret_vaddr + 8;
+}
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 4a29c75..0a294e9 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <linux/rbtree.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 
 struct vm_area_struct;
 struct mm_struct;
-- 
1.7.1

