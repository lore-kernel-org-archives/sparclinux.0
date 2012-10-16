From: David Miller <davem@davemloft.net>
Date: Tue, 16 Oct 2012 20:16:30 +0000
Subject: [PATCH 2/3] sparc64: Add global PMU register dumping via sysrq.
Message-Id: <20121016.161630.2171422709096322741.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 Documentation/sysrq.txt         |   1 +
 arch/sparc/include/asm/ptrace.h |  13 ++++-
 arch/sparc/include/asm/smp_64.h |   2 +
 arch/sparc/kernel/process_64.c  | 120 +++++++++++++++++++++++++++++++++-------
 arch/sparc/kernel/smp_64.c      |  11 ++++
 arch/sparc/mm/ultra.S           |  64 ++++++++++++++++++++-
 drivers/tty/sysrq.c             |   1 +
 7 files changed, 189 insertions(+), 23 deletions(-)

diff --git a/Documentation/sysrq.txt b/Documentation/sysrq.txt
index 642f844..2a4cdda 100644
--- a/Documentation/sysrq.txt
+++ b/Documentation/sysrq.txt
@@ -116,6 +116,7 @@ On all -  write a character to /proc/sysrq-trigger.  e.g.:
 'w'	- Dumps tasks that are in uninterruptable (blocked) state.
 
 'x'	- Used by xmon interface on ppc/powerpc platforms.
+          Show global PMU Registers on sparc64.
 
 'y'	- Show global CPU Registers [SPARC-64 specific]
 
diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index 0c6f6b0..da43bdc 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -42,7 +42,18 @@ struct global_reg_snapshot {
 	struct thread_info	*thread;
 	unsigned long		pad1;
 };
-extern struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
+
+struct global_pmu_snapshot {
+	unsigned long		pcr[4];
+	unsigned long		pic[4];
+};
+
+union global_cpu_snapshot {
+	struct global_reg_snapshot	reg;
+	struct global_pmu_snapshot	pmu;
+};
+
+extern union global_cpu_snapshot global_cpu_snapshot[NR_CPUS];
 
 #define force_successful_syscall_return()	    \
 do {	current_thread_info()->syscall_noerror = 1; \
diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 29862a9..dd3bef4 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -48,6 +48,7 @@ extern void smp_fill_in_sib_core_maps(void);
 extern void cpu_play_dead(void);
 
 extern void smp_fetch_global_regs(void);
+extern void smp_fetch_global_pmu(void);
 
 struct seq_file;
 void smp_bogo(struct seq_file *);
@@ -65,6 +66,7 @@ extern void __cpu_die(unsigned int cpu);
 #define hard_smp_processor_id()		0
 #define smp_fill_in_sib_core_maps() do { } while (0)
 #define smp_fetch_global_regs() do { } while (0)
+#define smp_fetch_global_pmu() do { } while (0)
 
 #endif /* !(CONFIG_SMP) */
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index fcaa594..d778248 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -27,6 +27,7 @@
 #include <linux/tick.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
+#include <linux/perf_event.h>
 #include <linux/elfcore.h>
 #include <linux/sysrq.h>
 #include <linux/nmi.h>
@@ -47,6 +48,7 @@
 #include <asm/syscalls.h>
 #include <asm/irq_regs.h>
 #include <asm/smp.h>
+#include <asm/pcr.h>
 
 #include "kstack.h"
 
@@ -204,18 +206,22 @@ void show_regs(struct pt_regs *regs)
 	show_stack(current, (unsigned long *) regs->u_regs[UREG_FP]);
 }
 
-struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
-static DEFINE_SPINLOCK(global_reg_snapshot_lock);
+union global_cpu_snapshot global_cpu_snapshot[NR_CPUS];
+static DEFINE_SPINLOCK(global_cpu_snapshot_lock);
 
 static void __global_reg_self(struct thread_info *tp, struct pt_regs *regs,
 			      int this_cpu)
 {
+	struct global_reg_snapshot *rp;
+
 	flushw_all();
 
-	global_reg_snapshot[this_cpu].tstate = regs->tstate;
-	global_reg_snapshot[this_cpu].tpc = regs->tpc;
-	global_reg_snapshot[this_cpu].tnpc = regs->tnpc;
-	global_reg_snapshot[this_cpu].o7 = regs->u_regs[UREG_I7];
+	rp = &global_cpu_snapshot[this_cpu].reg;
+
+	rp->tstate = regs->tstate;
+	rp->tpc = regs->tpc;
+	rp->tnpc = regs->tnpc;
+	rp->o7 = regs->u_regs[UREG_I7];
 
 	if (regs->tstate & TSTATE_PRIV) {
 		struct reg_window *rw;
@@ -223,17 +229,17 @@ static void __global_reg_self(struct thread_info *tp, struct pt_regs *regs,
 		rw = (struct reg_window *)
 			(regs->u_regs[UREG_FP] + STACK_BIAS);
 		if (kstack_valid(tp, (unsigned long) rw)) {
-			global_reg_snapshot[this_cpu].i7 = rw->ins[7];
+			rp->i7 = rw->ins[7];
 			rw = (struct reg_window *)
 				(rw->ins[6] + STACK_BIAS);
 			if (kstack_valid(tp, (unsigned long) rw))
-				global_reg_snapshot[this_cpu].rpc = rw->ins[7];
+				rp->rpc = rw->ins[7];
 		}
 	} else {
-		global_reg_snapshot[this_cpu].i7 = 0;
-		global_reg_snapshot[this_cpu].rpc = 0;
+		rp->i7 = 0;
+		rp->rpc = 0;
 	}
-	global_reg_snapshot[this_cpu].thread = tp;
+	rp->thread = tp;
 }
 
 /* In order to avoid hangs we do not try to synchronize with the
@@ -261,9 +267,9 @@ void arch_trigger_all_cpu_backtrace(void)
 	if (!regs)
 		regs = tp->kregs;
 
-	spin_lock_irqsave(&global_reg_snapshot_lock, flags);
+	spin_lock_irqsave(&global_cpu_snapshot_lock, flags);
 
-	memset(global_reg_snapshot, 0, sizeof(global_reg_snapshot));
+	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
 
 	this_cpu = raw_smp_processor_id();
 
@@ -272,7 +278,7 @@ void arch_trigger_all_cpu_backtrace(void)
 	smp_fetch_global_regs();
 
 	for_each_online_cpu(cpu) {
-		struct global_reg_snapshot *gp = &global_reg_snapshot[cpu];
+		struct global_reg_snapshot *gp = &global_cpu_snapshot[cpu].reg;
 
 		__global_reg_poll(gp);
 
@@ -295,9 +301,9 @@ void arch_trigger_all_cpu_backtrace(void)
 		}
 	}
 
-	memset(global_reg_snapshot, 0, sizeof(global_reg_snapshot));
+	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
 
-	spin_unlock_irqrestore(&global_reg_snapshot_lock, flags);
+	spin_unlock_irqrestore(&global_cpu_snapshot_lock, flags);
 }
 
 #ifdef CONFIG_MAGIC_SYSRQ
@@ -309,16 +315,90 @@ static void sysrq_handle_globreg(int key)
 
 static struct sysrq_key_op sparc_globalreg_op = {
 	.handler	= sysrq_handle_globreg,
-	.help_msg	= "Globalregs",
+	.help_msg	= "global-regs(Y)",
 	.action_msg	= "Show Global CPU Regs",
 };
 
-static int __init sparc_globreg_init(void)
+static void __global_pmu_self(int this_cpu)
+{
+	struct global_pmu_snapshot *pp;
+	int i, num;
+
+	pp = &global_cpu_snapshot[this_cpu].pmu;
+
+	num = 1;
+	if (tlb_type = hypervisor &&
+	    sun4v_chip_type >= SUN4V_CHIP_NIAGARA4)
+		num = 4;
+
+	for (i = 0; i < num; i++) {
+		pp->pcr[i] = pcr_ops->read_pcr(i);
+		pp->pic[i] = pcr_ops->read_pic(i);
+	}
+}
+
+static void __global_pmu_poll(struct global_pmu_snapshot *pp)
+{
+	int limit = 0;
+
+	while (!pp->pcr[0] && ++limit < 100) {
+		barrier();
+		udelay(1);
+	}
+}
+
+static void pmu_snapshot_all_cpus(void)
 {
-	return register_sysrq_key('y', &sparc_globalreg_op);
+	unsigned long flags;
+	int this_cpu, cpu;
+
+	spin_lock_irqsave(&global_cpu_snapshot_lock, flags);
+
+	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
+
+	this_cpu = raw_smp_processor_id();
+
+	__global_pmu_self(this_cpu);
+
+	smp_fetch_global_pmu();
+
+	for_each_online_cpu(cpu) {
+		struct global_pmu_snapshot *pp = &global_cpu_snapshot[cpu].pmu;
+
+		__global_pmu_poll(pp);
+
+		printk("%c CPU[%3d]: PCR[%08lx:%08lx:%08lx:%08lx] PIC[%08lx:%08lx:%08lx:%08lx]\n",
+		       (cpu = this_cpu ? '*' : ' '), cpu,
+		       pp->pcr[0], pp->pcr[1], pp->pcr[2], pp->pcr[3],
+		       pp->pic[0], pp->pic[1], pp->pic[2], pp->pic[3]);
+	}
+
+	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
+
+	spin_unlock_irqrestore(&global_cpu_snapshot_lock, flags);
+}
+
+static void sysrq_handle_globpmu(int key)
+{
+	pmu_snapshot_all_cpus();
+}
+
+static struct sysrq_key_op sparc_globalpmu_op = {
+	.handler	= sysrq_handle_globpmu,
+	.help_msg	= "global-pmu(X)",
+	.action_msg	= "Show Global PMU Regs",
+};
+
+static int __init sparc_sysrq_init(void)
+{
+	int ret = register_sysrq_key('y', &sparc_globalreg_op);
+
+	if (!ret)
+		ret = register_sysrq_key('x', &sparc_globalpmu_op);
+	return ret;
 }
 
-core_initcall(sparc_globreg_init);
+core_initcall(sparc_sysrq_init);
 
 #endif
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 781bcb1..d94b878 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -852,6 +852,8 @@ extern unsigned long xcall_flush_tlb_mm;
 extern unsigned long xcall_flush_tlb_pending;
 extern unsigned long xcall_flush_tlb_kernel_range;
 extern unsigned long xcall_fetch_glob_regs;
+extern unsigned long xcall_fetch_glob_pmu;
+extern unsigned long xcall_fetch_glob_pmu_n4;
 extern unsigned long xcall_receive_signal;
 extern unsigned long xcall_new_mmu_context_version;
 #ifdef CONFIG_KGDB
@@ -1000,6 +1002,15 @@ void smp_fetch_global_regs(void)
 	smp_cross_call(&xcall_fetch_glob_regs, 0, 0, 0);
 }
 
+void smp_fetch_global_pmu(void)
+{
+	if (tlb_type = hypervisor &&
+	    sun4v_chip_type >= SUN4V_CHIP_NIAGARA4)
+		smp_cross_call(&xcall_fetch_glob_pmu_n4, 0, 0, 0);
+	else
+		smp_cross_call(&xcall_fetch_glob_pmu, 0, 0, 0);
+}
+
 /* We know that the window frames of the user have been flushed
  * to the stack before we get here because all callers of us
  * are flush_tlb_*() routines, and these run after flush_cache_*()
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 874162a..f8e13d4 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -481,8 +481,8 @@ xcall_sync_tick:
 
 	.globl		xcall_fetch_glob_regs
 xcall_fetch_glob_regs:
-	sethi		%hi(global_reg_snapshot), %g1
-	or		%g1, %lo(global_reg_snapshot), %g1
+	sethi		%hi(global_cpu_snapshot), %g1
+	or		%g1, %lo(global_cpu_snapshot), %g1
 	__GET_CPUID(%g2)
 	sllx		%g2, 6, %g3
 	add		%g1, %g3, %g1
@@ -509,6 +509,66 @@ xcall_fetch_glob_regs:
 	stx		%g3, [%g1 + GR_SNAP_THREAD]
 	retry
 
+	.globl		xcall_fetch_glob_pmu
+xcall_fetch_glob_pmu:
+	sethi		%hi(global_cpu_snapshot), %g1
+	or		%g1, %lo(global_cpu_snapshot), %g1
+	__GET_CPUID(%g2)
+	sllx		%g2, 6, %g3
+	add		%g1, %g3, %g1
+	rd		%pic, %g7
+	stx		%g7, [%g1 + (4 * 8)]
+	rd		%pcr, %g7
+	stx		%g7, [%g1 + (0 * 8)]
+	retry
+
+	.globl		xcall_fetch_glob_pmu_n4
+xcall_fetch_glob_pmu_n4:
+	sethi		%hi(global_cpu_snapshot), %g1
+	or		%g1, %lo(global_cpu_snapshot), %g1
+	__GET_CPUID(%g2)
+	sllx		%g2, 6, %g3
+	add		%g1, %g3, %g1
+
+	ldxa		[%g0] ASI_PIC, %g7
+	stx		%g7, [%g1 + (4 * 8)]
+	mov		0x08, %g3
+	ldxa		[%g3] ASI_PIC, %g7
+	stx		%g7, [%g1 + (5 * 8)]
+	mov		0x10, %g3
+	ldxa		[%g3] ASI_PIC, %g7
+	stx		%g7, [%g1 + (6 * 8)]
+	mov		0x18, %g3
+	ldxa		[%g3] ASI_PIC, %g7
+	stx		%g7, [%g1 + (7 * 8)]
+
+	mov		%o0, %g2
+	mov		%o1, %g3
+	mov		%o5, %g7
+
+	mov		HV_FAST_VT_GET_PERFREG, %o5
+	mov		3, %o0
+	ta		HV_FAST_TRAP
+	stx		%o1, [%g1 + (3 * 8)]
+	mov		HV_FAST_VT_GET_PERFREG, %o5
+	mov		2, %o0
+	ta		HV_FAST_TRAP
+	stx		%o1, [%g1 + (2 * 8)]
+	mov		HV_FAST_VT_GET_PERFREG, %o5
+	mov		1, %o0
+	ta		HV_FAST_TRAP
+	stx		%o1, [%g1 + (1 * 8)]
+	mov		HV_FAST_VT_GET_PERFREG, %o5
+	mov		0, %o0
+	ta		HV_FAST_TRAP
+	stx		%o1, [%g1 + (0 * 8)]
+
+	mov		%g2, %o0
+	mov		%g3, %o1
+	mov		%g7, %o5
+
+	retry
+
 #ifdef DCACHE_ALIASING_POSSIBLE
 	.align		32
 	.globl		xcall_flush_dcache_page_cheetah
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 05728894..16ee6ce 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -452,6 +452,7 @@ static struct sysrq_key_op *sysrq_key_table[36] = {
 	NULL,				/* v */
 	&sysrq_showstate_blocked_op,	/* w */
 	/* x: May be registered on ppc/powerpc for xmon */
+	/* x: May be registered on sparc64 for global PMU dump */
 	NULL,				/* x */
 	/* y: May be registered on sparc64 for global register dump */
 	NULL,				/* y */
-- 
1.7.12.2.dirty

