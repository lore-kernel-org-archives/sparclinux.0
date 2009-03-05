From: David Miller <davem@davemloft.net>
Date: Thu, 05 Mar 2009 08:04:17 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090305.000417.106711161.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 12 Feb 2009 16:30:30 +0100

> __call_usermodehelper: wait=0

So kernel_thread() is where it hangs...

The only big thing changing in sparc64 between 2.6.26.5 (which works)
and 2.6.27 are IRQ stacks.

Here is a test patch which reverts sparc64 IRQ stacks.  If this makes
your machine work it will be a big clue.

(BTW, why do you get "OpenBoot Diagnostics failed" from the firmware
 on reset/poweron?)

sparc64: Revert IRQ stacks.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/irq_64.h  |    4 --
 arch/sparc64/kernel/irq.c        |   52 --------------------------------
 arch/sparc64/kernel/kstack.h     |   60 --------------------------------------
 arch/sparc64/kernel/process.c    |   27 ++++++++++++----
 arch/sparc64/kernel/stacktrace.c |   10 ++++--
 arch/sparc64/kernel/traps.c      |    7 ++--
 arch/sparc64/lib/mcount.S        |   22 --------------
 arch/sparc64/mm/init.c           |   11 -------
 8 files changed, 30 insertions(+), 163 deletions(-)
 delete mode 100644 arch/sparc64/kernel/kstack.h

diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index e3dd930..3473e25 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -93,8 +93,4 @@ static inline unsigned long get_softint(void)
 void __trigger_all_cpu_backtrace(void);
 #define trigger_all_cpu_backtrace() __trigger_all_cpu_backtrace()
 
-extern void *hardirq_stack[NR_CPUS];
-extern void *softirq_stack[NR_CPUS];
-#define __ARCH_HAS_DO_SOFTIRQ
-
 #endif
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 7495bc7..0bb3f50 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -683,32 +683,10 @@ void ack_bad_irq(unsigned int virt_irq)
 	       ino, virt_irq);
 }
 
-void *hardirq_stack[NR_CPUS];
-void *softirq_stack[NR_CPUS];
-
-static __attribute__((always_inline)) void *set_hardirq_stack(void)
-{
-	void *orig_sp, *sp = hardirq_stack[smp_processor_id()];
-
-	__asm__ __volatile__("mov %%sp, %0" : "=r" (orig_sp));
-	if (orig_sp < sp ||
-	    orig_sp > (sp + THREAD_SIZE)) {
-		sp += THREAD_SIZE - 192 - STACK_BIAS;
-		__asm__ __volatile__("mov %0, %%sp" : : "r" (sp));
-	}
-
-	return orig_sp;
-}
-static __attribute__((always_inline)) void restore_hardirq_stack(void *orig_sp)
-{
-	__asm__ __volatile__("mov %0, %%sp" : : "r" (orig_sp));
-}
-
 void handler_irq(int irq, struct pt_regs *regs)
 {
 	unsigned long pstate, bucket_pa;
 	struct pt_regs *old_regs;
-	void *orig_sp;
 
 	clear_softint(1 << irq);
 
@@ -726,8 +704,6 @@ void handler_irq(int irq, struct pt_regs *regs)
 			       "i" (PSTATE_IE)
 			     : "memory");
 
-	orig_sp = set_hardirq_stack();
-
 	while (bucket_pa) {
 		struct irq_desc *desc;
 		unsigned long next_pa;
@@ -744,38 +720,10 @@ void handler_irq(int irq, struct pt_regs *regs)
 		bucket_pa = next_pa;
 	}
 
-	restore_hardirq_stack(orig_sp);
-
 	irq_exit();
 	set_irq_regs(old_regs);
 }
 
-void do_softirq(void)
-{
-	unsigned long flags;
-
-	if (in_interrupt())
-		return;
-
-	local_irq_save(flags);
-
-	if (local_softirq_pending()) {
-		void *orig_sp, *sp = softirq_stack[smp_processor_id()];
-
-		sp += THREAD_SIZE - 192 - STACK_BIAS;
-
-		__asm__ __volatile__("mov %%sp, %0\n\t"
-				     "mov %1, %%sp"
-				     : "=&r" (orig_sp)
-				     : "r" (sp));
-		__do_softirq();
-		__asm__ __volatile__("mov %0, %%sp"
-				     : : "r" (orig_sp));
-	}
-
-	local_irq_restore(flags);
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 void fixup_irqs(void)
 {
diff --git a/arch/sparc64/kernel/kstack.h b/arch/sparc64/kernel/kstack.h
deleted file mode 100644
index 4248d96..0000000
--- a/arch/sparc64/kernel/kstack.h
+++ /dev/null
@@ -1,60 +0,0 @@
-#ifndef _KSTACK_H
-#define _KSTACK_H
-
-#include <linux/thread_info.h>
-#include <linux/sched.h>
-#include <asm/ptrace.h>
-#include <asm/irq.h>
-
-/* SP must be STACK_BIAS adjusted already.  */
-static inline bool kstack_valid(struct thread_info *tp, unsigned long sp)
-{
-	unsigned long base = (unsigned long) tp;
-
-	if (sp >= (base + sizeof(struct thread_info)) &&
-	    sp <= (base + THREAD_SIZE - sizeof(struct sparc_stackf)))
-		return true;
-
-	if (hardirq_stack[tp->cpu]) {
-		base = (unsigned long) hardirq_stack[tp->cpu];
-		if (sp >= base &&
-		    sp <= (base + THREAD_SIZE - sizeof(struct sparc_stackf)))
-			return true;
-		base = (unsigned long) softirq_stack[tp->cpu];
-		if (sp >= base &&
-		    sp <= (base + THREAD_SIZE - sizeof(struct sparc_stackf)))
-			return true;
-	}
-	return false;
-}
-
-/* Does "regs" point to a valid pt_regs trap frame?  */
-static inline bool kstack_is_trap_frame(struct thread_info *tp, struct pt_regs *regs)
-{
-	unsigned long base = (unsigned long) tp;
-	unsigned long addr = (unsigned long) regs;
-
-	if (addr >= base &&
-	    addr <= (base + THREAD_SIZE - sizeof(*regs)))
-		goto check_magic;
-
-	if (hardirq_stack[tp->cpu]) {
-		base = (unsigned long) hardirq_stack[tp->cpu];
-		if (addr >= base &&
-		    addr <= (base + THREAD_SIZE - sizeof(*regs)))
-			goto check_magic;
-		base = (unsigned long) softirq_stack[tp->cpu];
-		if (addr >= base &&
-		    addr <= (base + THREAD_SIZE - sizeof(*regs)))
-			goto check_magic;
-	}
-	return false;
-
-check_magic:
-	if ((regs->magic & ~0x1ff) = PT_REGS_MAGIC)
-		return true;
-	return false;
-
-}
-
-#endif /* _KSTACK_H */
diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index 15f4178..7f5debd 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -52,8 +52,6 @@
 #include <asm/irq_regs.h>
 #include <asm/smp.h>
 
-#include "kstack.h"
-
 static void sparc64_yield(int cpu)
 {
 	if (tlb_type != hypervisor)
@@ -237,6 +235,19 @@ void show_regs(struct pt_regs *regs)
 struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
 static DEFINE_SPINLOCK(global_reg_snapshot_lock);
 
+static bool kstack_valid(struct thread_info *tp, struct reg_window *rw)
+{
+	unsigned long thread_base, fp;
+
+	thread_base = (unsigned long) tp;
+	fp = (unsigned long) rw;
+
+	if (fp < (thread_base + sizeof(struct thread_info)) ||
+	    fp >= (thread_base + THREAD_SIZE))
+		return false;
+	return true;
+}
+
 static void __global_reg_self(struct thread_info *tp, struct pt_regs *regs,
 			      int this_cpu)
 {
@@ -253,11 +264,11 @@ static void __global_reg_self(struct thread_info *tp, struct pt_regs *regs,
 
 		rw = (struct reg_window *)
 			(regs->u_regs[UREG_FP] + STACK_BIAS);
-		if (kstack_valid(tp, (unsigned long) rw)) {
+		if (kstack_valid(tp, rw)) {
 			global_reg_snapshot[this_cpu].i7 = rw->ins[7];
 			rw = (struct reg_window *)
 				(rw->ins[6] + STACK_BIAS);
-			if (kstack_valid(tp, (unsigned long) rw))
+			if (kstack_valid(tp, rw))
 				global_reg_snapshot[this_cpu].rpc = rw->ins[7];
 		}
 	} else {
@@ -817,7 +828,7 @@ out:
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
-	struct thread_info *tp;
+	unsigned long thread_info_base;
 	struct reg_window *rw;
         unsigned long ret = 0;
 	int count = 0; 
@@ -826,12 +837,14 @@ unsigned long get_wchan(struct task_struct *task)
             task->state = TASK_RUNNING)
 		goto out;
 
-	tp = task_thread_info(task);
+	thread_info_base = (unsigned long) task_stack_page(task);
 	bias = STACK_BIAS;
 	fp = task_thread_info(task)->ksp + bias;
 
 	do {
-		if (!kstack_valid(tp, fp))
+		/* Bogus frame pointer? */
+		if (fp < (thread_info_base + sizeof(struct thread_info)) ||
+		    fp >= (thread_info_base + THREAD_SIZE))
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
diff --git a/arch/sparc64/kernel/stacktrace.c b/arch/sparc64/kernel/stacktrace.c
index 4e21d4a..7ef61cc 100644
--- a/arch/sparc64/kernel/stacktrace.c
+++ b/arch/sparc64/kernel/stacktrace.c
@@ -5,8 +5,6 @@
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
-#include "kstack.h"
-
 void save_stack_trace(struct stack_trace *trace)
 {
 	struct thread_info *tp = task_thread_info(current);
@@ -25,13 +23,17 @@ void save_stack_trace(struct stack_trace *trace)
 		struct pt_regs *regs;
 		unsigned long pc;
 
-		if (!kstack_valid(tp, fp))
+		/* Bogus frame pointer? */
+		if (fp < (thread_base + sizeof(struct thread_info)) ||
+		    fp > (thread_base + THREAD_SIZE - sizeof(struct sparc_stackf)))
 			break;
 
 		sf = (struct sparc_stackf *) fp;
 		regs = (struct pt_regs *) (sf + 1);
 
-		if (kstack_is_trap_frame(tp, regs)) {
+		if (((unsigned long)regs <+		     (thread_base + THREAD_SIZE - sizeof(*regs))) &&
+		    (regs->magic & ~0x1ff) = PT_REGS_MAGIC) {
 			if (!(regs->tstate & TSTATE_PRIV))
 				break;
 			pc = regs->tpc;
diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index eb19724..69f8dd9 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -40,7 +40,6 @@
 #include <asm/prom.h>
 
 #include "entry.h"
-#include "kstack.h"
 
 /* When an irrecoverable trap occurs at tl > 0, the trap entry
  * code logs the trap state registers at every level in the trap
@@ -2132,12 +2131,14 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 		struct pt_regs *regs;
 		unsigned long pc;
 
-		if (!kstack_valid(tp, fp))
+		/* Bogus frame pointer? */
+		if (fp < (thread_base + sizeof(struct thread_info)) ||
+		    fp >= (thread_base + THREAD_SIZE))
 			break;
 		sf = (struct sparc_stackf *) fp;
 		regs = (struct pt_regs *) (sf + 1);
 
-		if (kstack_is_trap_frame(tp, regs)) {
+		if ((regs->magic & ~0x1ff) = PT_REGS_MAGIC) {
 			if (!(regs->tstate & TSTATE_PRIV))
 				break;
 			pc = regs->tpc;
diff --git a/arch/sparc64/lib/mcount.S b/arch/sparc64/lib/mcount.S
index fad90dd..734caf0 100644
--- a/arch/sparc64/lib/mcount.S
+++ b/arch/sparc64/lib/mcount.S
@@ -49,28 +49,6 @@ mcount:
 	cmp		%sp, %g3
 	bg,pt		%xcc, 1f
 	 nop
-	lduh		[%g6 + TI_CPU], %g1
-	sethi		%hi(hardirq_stack), %g3
-	or		%g3, %lo(hardirq_stack), %g3
-	sllx		%g1, 3, %g1
-	ldx		[%g3 + %g1], %g7
-	sub		%g7, STACK_BIAS, %g7
-	cmp		%sp, %g7
-	bleu,pt		%xcc, 2f
-	 sethi		%hi(THREAD_SIZE), %g3
-	add		%g7, %g3, %g7
-	cmp		%sp, %g7
-	blu,pn		%xcc, 1f
-2:	 sethi		%hi(softirq_stack), %g3
-	or		%g3, %lo(softirq_stack), %g3
-	ldx		[%g3 + %g1], %g7
-	cmp		%sp, %g7
-	bleu,pt		%xcc, 2f
-	 sethi		%hi(THREAD_SIZE), %g3
-	add		%g7, %g3, %g7
-	cmp		%sp, %g7
-	blu,pn		%xcc, 1f
-	 nop
 	/* If we are already on ovstack, don't hop onto it
 	 * again, we are already trying to output the stack overflow
 	 * message.
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index a41df7b..0ea8838 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -49,7 +49,6 @@
 #include <asm/sstate.h>
 #include <asm/mdesc.h>
 #include <asm/cpudata.h>
-#include <asm/irq.h>
 
 #define MAX_PHYS_ADDRESS	(1UL << 42UL)
 #define KPTE_BITMAP_CHUNK_SZ	(256UL * 1024UL * 1024UL)
@@ -1774,16 +1773,6 @@ void __init paging_init(void)
 	if (tlb_type = hypervisor)
 		sun4v_mdesc_init();
 
-	/* Once the OF device tree and MDESC have been setup, we know
-	 * the list of possible cpus.  Therefore we can allocate the
-	 * IRQ stacks.
-	 */
-	for_each_possible_cpu(i) {
-		/* XXX Use node local allocations... XXX */
-		softirq_stack[i] = __va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
-		hardirq_stack[i] = __va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
-	}
-
 	/* Setup bootmem... */
 	last_valid_pfn = end_pfn = bootmem_init(phys_base);
 
-- 
1.6.2

