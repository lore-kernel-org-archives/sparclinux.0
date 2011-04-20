From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 08:39:05 +0000
Subject: [PATCH 3/7 v2] sparc32,leon: per-cpu ticker use genirq per-cpu handler
Message-Id: <1303288747-28521-3-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/leon.h   |    6 ++++--
 arch/sparc/kernel/entry.S       |   16 ----------------
 arch/sparc/kernel/leon_kernel.c |   39 ++++++++++++++-------------------------
 arch/sparc/kernel/leon_smp.c    |   12 ++++--------
 4 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 1271254..204dc0f 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -239,7 +239,7 @@ static inline int sparc_leon3_cpuid(void)
 
 #ifdef CONFIG_SMP
 # define LEON3_IRQ_RESCHEDULE		13
-# define LEON3_IRQ_TICKER		(leon_percpu_timer_dev[0].irq)
+# define LEON3_IRQ_TICKER		(leon3_ticker_irq)
 # define LEON3_IRQ_CROSS_CALL		15
 #endif
 
@@ -357,6 +357,7 @@ extern void leon3_getCacheRegs(struct leon3_cacheregs *regs);
 extern int leon_flush_needed(void);
 extern void leon_switch_mm(void);
 extern int srmmu_swprobe_trace;
+extern int leon3_ticker_irq;
 
 #ifdef CONFIG_SMP
 extern int leon_smp_nrcpus(void);
@@ -371,8 +372,9 @@ extern void init_IRQ(void);
 extern void cpu_panic(void);
 extern int __leon_processor_id(void);
 void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
+extern irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused);
 
-extern unsigned int real_irq_entry[], smpleon_ticker[];
+extern unsigned int real_irq_entry[];
 extern unsigned int patchme_maybe_smp_msg[];
 extern unsigned int t_nmi[], linux_trap_ipi15_leon[];
 extern unsigned int linux_trap_ipi15_sun4m[];
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 6da784a..1879739 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -401,22 +401,6 @@ linux_trap_ipi15_sun4d:
 1:	b,a	1b
 
 #ifdef CONFIG_SPARC_LEON
-
-	.globl	smpleon_ticker
-	/* SMP per-cpu ticker interrupts are handled specially. */
-smpleon_ticker:
-        SAVE_ALL
-	or	%l0, PSR_PIL, %g2
-	wr	%g2, 0x0, %psr
-	WRITE_PAUSE
-	wr	%g2, PSR_ET, %psr
-	WRITE_PAUSE
-	call	leon_percpu_timer_interrupt
-	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
-	WRITE_PAUSE
-	RESTORE_ALL
-
 	.align	4
 	.globl	linux_trap_ipi15_leon
 linux_trap_ipi15_leon:
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 210f4a0..d867543 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -26,7 +26,6 @@
 
 struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt controller base address */
 struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base address */
-struct amba_apb_device leon_percpu_timer_dev[16];
 
 int leondebug_irq_disable;
 int leon_debug_irqout;
@@ -36,6 +35,7 @@ static DEFINE_SPINLOCK(leon_irq_lock);
 
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
 unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
+int leon3_ticker_irq; /* Timer ticker IRQ */
 unsigned int sparc_leon_eirq;
 #define LEON_IMASK (&leon3_irqctrl_regs->mask[0])
 #define LEON_IACK (&leon3_irqctrl_regs->iclear)
@@ -271,9 +271,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 			&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl, 0);
 
 #ifdef CONFIG_SMP
-		leon_percpu_timer_dev[0].start = (int)leon3_gptimer_regs;
-		leon_percpu_timer_dev[0].irq = leon3_gptimer_irq + 1 +
-					       leon3_gptimer_idx;
+		leon3_ticker_irq = leon3_gptimer_irq + 1 + leon3_gptimer_idx;
 
 		if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
 		      (1<<LEON3_GPTIMER_SEPIRQ))) {
@@ -322,27 +320,6 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		prom_halt();
 	}
 
-# ifdef CONFIG_SMP
-	{
-		unsigned long flags;
-		struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (leon_percpu_timer_dev[0].irq - 1)];
-
-		/* For SMP we use the level 14 ticker, however the bootup code
-		 * has copied the firmwares level 14 vector into boot cpu's
-		 * trap table, we must fix this now or we get squashed.
-		 */
-		local_irq_save(flags);
-
-		patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
-
-		/* Adjust so that we jump directly to smpleon_ticker */
-		trap_table->inst_three += smpleon_ticker - real_irq_entry;
-
-		local_flush_cache_all();
-		local_irq_restore(flags);
-	}
-# endif
-
 	if (leon3_gptimer_regs) {
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
 				      LEON3_GPTIMER_EN |
@@ -350,6 +327,18 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 				      LEON3_GPTIMER_LD | LEON3_GPTIMER_IRQEN);
 
 #ifdef CONFIG_SMP
+		/* Install per-cpu IRQ handler for broadcasted ticker */
+		irq = leon_build_device_irq(leon3_ticker_irq,
+						handle_percpu_irq, "per-cpu",
+						0);
+		err = request_irq(irq, leon_percpu_timer_interrupt,
+					IRQF_PERCPU | IRQF_TIMER, "ticker",
+					NULL);
+		if (err) {
+			printk(KERN_ERR "unable to attach ticker IRQ%d\n", irq);
+			prom_halt();
+		}
+
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx+1].ctrl,
 				      LEON3_GPTIMER_EN |
 				      LEON3_GPTIMER_RL |
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 8f5de4a..053eca9 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -386,27 +386,23 @@ void leon_cross_call_irq(void)
 	ccall_info.processors_out[i] = 1;
 }
 
-void leon_percpu_timer_interrupt(struct pt_regs *regs)
+irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused)
 {
-	struct pt_regs *old_regs;
 	int cpu = smp_processor_id();
 
-	old_regs = set_irq_regs(regs);
-
 	leon_clear_profile_irq(cpu);
 
 	profile_tick(CPU_PROFILING);
 
 	if (!--prof_counter(cpu)) {
-		int user = user_mode(regs);
+		int user = user_mode(get_irq_regs());
 
-		irq_enter();
 		update_process_times(user);
-		irq_exit();
 
 		prof_counter(cpu) = prof_multiplier(cpu);
 	}
-	set_irq_regs(old_regs);
+
+	return IRQ_HANDLED;
 }
 
 static void __init smp_setup_percpu_timer(void)
-- 
1.5.4

