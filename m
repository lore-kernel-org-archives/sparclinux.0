From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:27:36 +0000
Subject: [PATCH 03/17] sparc64: Add 'reg_num' argument to pcr_ops methods.
Message-Id: <20120818.232736.108098143468843724.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


SPARC-T4 and later have multiple PCR registers, one for each
PIC counter.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pcr.h   |    4 ++--
 arch/sparc/kernel/nmi.c        |   14 +++++++-------
 arch/sparc/kernel/pcr.c        |    9 ++++++---
 arch/sparc/kernel/perf_event.c |   14 +++++++-------
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
index 288d7be..55e2341 100644
--- a/arch/sparc/include/asm/pcr.h
+++ b/arch/sparc/include/asm/pcr.h
@@ -2,8 +2,8 @@
 #define __PCR_H
 
 struct pcr_ops {
-	u64 (*read)(void);
-	void (*write)(u64);
+	u64 (*read)(unsigned long);
+	void (*write)(unsigned long, u64);
 };
 extern const struct pcr_ops *pcr_ops;
 
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index eb1c1f0..95df720 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -109,7 +109,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 		       pt_regs_trap_type(regs), SIGINT) = NOTIFY_STOP)
 		touched = 1;
 	else
-		pcr_ops->write(PCR_PIC_PRIV);
+		pcr_ops->write(0, PCR_PIC_PRIV);
 
 	sum = local_cpu_data().irq0_irqs;
 	if (__get_cpu_var(nmi_touch)) {
@@ -127,7 +127,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 	}
 	if (__get_cpu_var(wd_enabled)) {
 		write_pic(picl_value(nmi_hz));
-		pcr_ops->write(pcr_enable);
+		pcr_ops->write(0, pcr_enable);
 	}
 
 	restore_hardirq_stack(orig_sp);
@@ -166,7 +166,7 @@ static void report_broken_nmi(int cpu, int *prev_nmi_count)
 
 void stop_nmi_watchdog(void *unused)
 {
-	pcr_ops->write(PCR_PIC_PRIV);
+	pcr_ops->write(0, PCR_PIC_PRIV);
 	__get_cpu_var(wd_enabled) = 0;
 	atomic_dec(&nmi_active);
 }
@@ -223,10 +223,10 @@ void start_nmi_watchdog(void *unused)
 	__get_cpu_var(wd_enabled) = 1;
 	atomic_inc(&nmi_active);
 
-	pcr_ops->write(PCR_PIC_PRIV);
+	pcr_ops->write(0, PCR_PIC_PRIV);
 	write_pic(picl_value(nmi_hz));
 
-	pcr_ops->write(pcr_enable);
+	pcr_ops->write(0, pcr_enable);
 }
 
 static void nmi_adjust_hz_one(void *unused)
@@ -234,10 +234,10 @@ static void nmi_adjust_hz_one(void *unused)
 	if (!__get_cpu_var(wd_enabled))
 		return;
 
-	pcr_ops->write(PCR_PIC_PRIV);
+	pcr_ops->write(0, PCR_PIC_PRIV);
 	write_pic(picl_value(nmi_hz));
 
-	pcr_ops->write(pcr_enable);
+	pcr_ops->write(0, pcr_enable);
 }
 
 void nmi_adjust_hz(unsigned int new_hz)
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 0ce0dd2..3d9ab5b 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -60,16 +60,18 @@ void arch_irq_work_raise(void)
 const struct pcr_ops *pcr_ops;
 EXPORT_SYMBOL_GPL(pcr_ops);
 
-static u64 direct_pcr_read(void)
+static u64 direct_pcr_read(unsigned long reg_num)
 {
 	u64 val;
 
+	WARN_ON_ONCE(reg_num != 0);
 	read_pcr(val);
 	return val;
 }
 
-static void direct_pcr_write(u64 val)
+static void direct_pcr_write(unsigned long reg_num, u64 val)
 {
+	WARN_ON_ONCE(reg_num != 0);
 	write_pcr(val);
 }
 
@@ -78,10 +80,11 @@ static const struct pcr_ops direct_pcr_ops = {
 	.write	= direct_pcr_write,
 };
 
-static void n2_pcr_write(u64 val)
+static void n2_pcr_write(unsigned long reg_num, u64 val)
 {
 	unsigned long ret;
 
+	WARN_ON_ONCE(reg_num != 0);
 	if (val & PCR_N2_HTRACE) {
 		ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
 		if (ret != HV_EOK)
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 5713957..e1c9848 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -564,7 +564,7 @@ static inline void sparc_pmu_enable_event(struct cpu_hw_events *cpuc, struct hw_
 	val |= hwc->config;
 	cpuc->pcr = val;
 
-	pcr_ops->write(cpuc->pcr);
+	pcr_ops->write(0, cpuc->pcr);
 }
 
 static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw_perf_event *hwc, int idx)
@@ -578,7 +578,7 @@ static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw
 	val |= nop;
 	cpuc->pcr = val;
 
-	pcr_ops->write(cpuc->pcr);
+	pcr_ops->write(0, cpuc->pcr);
 }
 
 static u32 read_pmc(int idx)
@@ -736,7 +736,7 @@ static void sparc_pmu_enable(struct pmu *pmu)
 		cpuc->pcr = pcr | cpuc->event[0]->hw.config_base;
 	}
 
-	pcr_ops->write(cpuc->pcr);
+	pcr_ops->write(0, cpuc->pcr);
 }
 
 static void sparc_pmu_disable(struct pmu *pmu)
@@ -755,7 +755,7 @@ static void sparc_pmu_disable(struct pmu *pmu)
 		 sparc_pmu->hv_bit | sparc_pmu->irq_bit);
 	cpuc->pcr = val;
 
-	pcr_ops->write(cpuc->pcr);
+	pcr_ops->write(0, cpuc->pcr);
 }
 
 static int active_event_index(struct cpu_hw_events *cpuc,
@@ -856,7 +856,7 @@ static void perf_stop_nmi_watchdog(void *unused)
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 
 	stop_nmi_watchdog(NULL);
-	cpuc->pcr = pcr_ops->read();
+	cpuc->pcr = pcr_ops->read(0);
 }
 
 void perf_event_grab_pmc(void)
@@ -1264,7 +1264,7 @@ void perf_event_print_debug(void)
 
 	cpu = smp_processor_id();
 
-	pcr = pcr_ops->read();
+	pcr = pcr_ops->read(0);
 	read_pic(pic);
 
 	pr_info("\n");
@@ -1306,7 +1306,7 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	 * overflow so we don't lose any events.
 	 */
 	if (sparc_pmu->irq_bit)
-		pcr_ops->write(cpuc->pcr);
+		pcr_ops->write(0, cpuc->pcr);
 
 	for (i = 0; i < cpuc->n_events; i++) {
 		struct perf_event *event = cpuc->event[i];
-- 
1.7.10.4

