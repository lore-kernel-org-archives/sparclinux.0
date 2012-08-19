From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:27:42 +0000
Subject: [PATCH 04/17] sparc64: Abstract away PIC register accesses.
Message-Id: <20120818.232742.607516152399184485.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


And, like for the PCR, allow indexing of different PIC register
numbers.

This also removes all of the non-__KERNEL__ bits from asm/perfctr.h,
nothing kernel side should include it any more.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pcr.h     |    6 +++--
 arch/sparc/include/asm/perfctr.h |   30 -------------------------
 arch/sparc/kernel/nmi.c          |   21 +++++++++---------
 arch/sparc/kernel/pcr.c          |   45 ++++++++++++++++++++++++++++++--------
 arch/sparc/kernel/perf_event.c   |   23 ++++++++++---------
 5 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
index 55e2341..d53abf7 100644
--- a/arch/sparc/include/asm/pcr.h
+++ b/arch/sparc/include/asm/pcr.h
@@ -2,8 +2,10 @@
 #define __PCR_H
 
 struct pcr_ops {
-	u64 (*read)(unsigned long);
-	void (*write)(unsigned long, u64);
+	u64 (*read_pcr)(unsigned long);
+	void (*write_pcr)(unsigned long, u64);
+	u64 (*read_pic)(unsigned long);
+	void (*write_pic)(unsigned long, u64);
 };
 extern const struct pcr_ops *pcr_ops;
 
diff --git a/arch/sparc/include/asm/perfctr.h b/arch/sparc/include/asm/perfctr.h
index 3332d2c..214feef 100644
--- a/arch/sparc/include/asm/perfctr.h
+++ b/arch/sparc/include/asm/perfctr.h
@@ -54,11 +54,6 @@ enum perfctr_opcode {
 	PERFCTR_GETPCR
 };
 
-/* I don't want the kernel's namespace to be polluted with this
- * stuff when this file is included.  --DaveM
- */
-#ifndef __KERNEL__
-
 #define  PRIV 0x00000001
 #define  SYS  0x00000002
 #define  USR  0x00000004
@@ -168,29 +163,4 @@ struct vcounter_struct {
   unsigned long long vcnt1;
 };
 
-#else /* !(__KERNEL__) */
-
-#ifndef CONFIG_SPARC32
-
-/* Performance counter register access. */
-#define read_pcr(__p)  __asm__ __volatile__("rd	%%pcr, %0" : "=r" (__p))
-#define write_pcr(__p) __asm__ __volatile__("wr	%0, 0x0, %%pcr" : : "r" (__p))
-#define read_pic(__p)  __asm__ __volatile__("rd %%pic, %0" : "=r" (__p))
-
-/* Blackbird errata workaround.  See commentary in
- * arch/sparc64/kernel/smp.c:smp_percpu_timer_interrupt()
- * for more information.
- */
-#define write_pic(__p)  					\
-	__asm__ __volatile__("ba,pt	%%xcc, 99f\n\t"		\
-			     " nop\n\t"				\
-			     ".align	64\n"			\
-			  "99:wr	%0, 0x0, %%pic\n\t"	\
-			     "rd	%%pic, %%g0" : : "r" (__p))
-#define reset_pic()	write_pic(0)
-
-#endif /* !CONFIG_SPARC32 */
-
-#endif /* !(__KERNEL__) */
-
 #endif /* !(PERF_COUNTER_API) */
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 95df720..ef22b9b 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -22,7 +22,6 @@
 #include <asm/perf_event.h>
 #include <asm/ptrace.h>
 #include <asm/pcr.h>
-#include <asm/perfctr.h>
 
 #include "kstack.h"
 
@@ -109,7 +108,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 		       pt_regs_trap_type(regs), SIGINT) = NOTIFY_STOP)
 		touched = 1;
 	else
-		pcr_ops->write(0, PCR_PIC_PRIV);
+		pcr_ops->write_pcr(0, PCR_PIC_PRIV);
 
 	sum = local_cpu_data().irq0_irqs;
 	if (__get_cpu_var(nmi_touch)) {
@@ -126,8 +125,8 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 		__this_cpu_write(alert_counter, 0);
 	}
 	if (__get_cpu_var(wd_enabled)) {
-		write_pic(picl_value(nmi_hz));
-		pcr_ops->write(0, pcr_enable);
+		pcr_ops->write_pic(0, picl_value(nmi_hz));
+		pcr_ops->write_pcr(0, pcr_enable);
 	}
 
 	restore_hardirq_stack(orig_sp);
@@ -166,7 +165,7 @@ static void report_broken_nmi(int cpu, int *prev_nmi_count)
 
 void stop_nmi_watchdog(void *unused)
 {
-	pcr_ops->write(0, PCR_PIC_PRIV);
+	pcr_ops->write_pcr(0, PCR_PIC_PRIV);
 	__get_cpu_var(wd_enabled) = 0;
 	atomic_dec(&nmi_active);
 }
@@ -223,10 +222,10 @@ void start_nmi_watchdog(void *unused)
 	__get_cpu_var(wd_enabled) = 1;
 	atomic_inc(&nmi_active);
 
-	pcr_ops->write(0, PCR_PIC_PRIV);
-	write_pic(picl_value(nmi_hz));
+	pcr_ops->write_pcr(0, PCR_PIC_PRIV);
+	pcr_ops->write_pic(0, picl_value(nmi_hz));
 
-	pcr_ops->write(0, pcr_enable);
+	pcr_ops->write_pcr(0, pcr_enable);
 }
 
 static void nmi_adjust_hz_one(void *unused)
@@ -234,10 +233,10 @@ static void nmi_adjust_hz_one(void *unused)
 	if (!__get_cpu_var(wd_enabled))
 		return;
 
-	pcr_ops->write(0, PCR_PIC_PRIV);
-	write_pic(picl_value(nmi_hz));
+	pcr_ops->write_pcr(0, PCR_PIC_PRIV);
+	pcr_ops->write_pic(0, picl_value(nmi_hz));
 
-	pcr_ops->write(0, pcr_enable);
+	pcr_ops->write_pcr(0, pcr_enable);
 }
 
 void nmi_adjust_hz(unsigned int new_hz)
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 3d9ab5b..e82ae89 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -14,7 +14,6 @@
 #include <asm/pcr.h>
 #include <asm/nmi.h>
 #include <asm/spitfire.h>
-#include <asm/perfctr.h>
 
 /* This code is shared between various users of the performance
  * counters.  Users will be oprofile, pseudo-NMI watchdog, and the
@@ -65,19 +64,45 @@ static u64 direct_pcr_read(unsigned long reg_num)
 	u64 val;
 
 	WARN_ON_ONCE(reg_num != 0);
-	read_pcr(val);
+	__asm__ __volatile__("rd %%pcr, %0" : "=r" (val));
 	return val;
 }
 
 static void direct_pcr_write(unsigned long reg_num, u64 val)
 {
 	WARN_ON_ONCE(reg_num != 0);
-	write_pcr(val);
+	__asm__ __volatile__("wr %0, 0x0, %%pcr" : : "r" (val));
+}
+
+static u64 direct_pic_read(unsigned long reg_num)
+{
+	u64 val;
+
+	WARN_ON_ONCE(reg_num != 0);
+	__asm__ __volatile__("rd %%pic, %0" : "=r" (val));
+	return val;
+}
+
+static void direct_pic_write(unsigned long reg_num, u64 val)
+{
+	WARN_ON_ONCE(reg_num != 0);
+
+	/* Blackbird errata workaround.  See commentary in
+	 * arch/sparc64/kernel/smp.c:smp_percpu_timer_interrupt()
+	 * for more information.
+	 */
+	__asm__ __volatile__("ba,pt	%%xcc, 99f\n\t"
+			     " nop\n\t"
+			     ".align	64\n"
+			  "99:wr	%0, 0x0, %%pic\n\t"
+			     "rd	%%pic, %%g0" : : "r" (val));
 }
 
 static const struct pcr_ops direct_pcr_ops = {
-	.read	= direct_pcr_read,
-	.write	= direct_pcr_write,
+	.read_pcr	= direct_pcr_read,
+	.write_pcr	= direct_pcr_write,
+	.read_pic	= direct_pic_read,
+	.write_pic	= direct_pic_write,
 };
 
 static void n2_pcr_write(unsigned long reg_num, u64 val)
@@ -88,14 +113,16 @@ static void n2_pcr_write(unsigned long reg_num, u64 val)
 	if (val & PCR_N2_HTRACE) {
 		ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
 		if (ret != HV_EOK)
-			write_pcr(val);
+			direct_pcr_write(reg_num, val);
 	} else
-		write_pcr(val);
+		direct_pcr_write(reg_num, val);
 }
 
 static const struct pcr_ops n2_pcr_ops = {
-	.read	= direct_pcr_read,
-	.write	= n2_pcr_write,
+	.read_pcr	= direct_pcr_read,
+	.write_pcr	= n2_pcr_write,
+	.read_pic	= direct_pic_read,
+	.write_pic	= direct_pic_write,
 };
 
 static unsigned long perf_hsvc_group;
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index e1c9848..dd12aa3 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -25,7 +25,6 @@
 #include <linux/atomic.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
-#include <asm/perfctr.h>
 #include <asm/cacheflush.h>
 
 #include "kernel.h"
@@ -564,7 +563,7 @@ static inline void sparc_pmu_enable_event(struct cpu_hw_events *cpuc, struct hw_
 	val |= hwc->config;
 	cpuc->pcr = val;
 
-	pcr_ops->write(0, cpuc->pcr);
+	pcr_ops->write_pcr(0, cpuc->pcr);
 }
 
 static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw_perf_event *hwc, int idx)
@@ -578,14 +577,14 @@ static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw
 	val |= nop;
 	cpuc->pcr = val;
 
-	pcr_ops->write(0, cpuc->pcr);
+	pcr_ops->write_pcr(0, cpuc->pcr);
 }
 
 static u32 read_pmc(int idx)
 {
 	u64 val;
 
-	read_pic(val);
+	val = pcr_ops->read_pic(0);
 	if (idx = PIC_UPPER_INDEX)
 		val >>= 32;
 
@@ -603,10 +602,10 @@ static void write_pmc(int idx, u64 val)
 	mask = ((u64) 0xffffffff) << shift;
 	val <<= shift;
 
-	read_pic(pic);
+	pic = pcr_ops->read_pic(0);
 	pic &= ~mask;
 	pic |= val;
-	write_pic(pic);
+	pcr_ops->write_pic(0, pic);
 }
 
 static u64 sparc_perf_event_update(struct perf_event *event,
@@ -736,7 +735,7 @@ static void sparc_pmu_enable(struct pmu *pmu)
 		cpuc->pcr = pcr | cpuc->event[0]->hw.config_base;
 	}
 
-	pcr_ops->write(0, cpuc->pcr);
+	pcr_ops->write_pcr(0, cpuc->pcr);
 }
 
 static void sparc_pmu_disable(struct pmu *pmu)
@@ -755,7 +754,7 @@ static void sparc_pmu_disable(struct pmu *pmu)
 		 sparc_pmu->hv_bit | sparc_pmu->irq_bit);
 	cpuc->pcr = val;
 
-	pcr_ops->write(0, cpuc->pcr);
+	pcr_ops->write_pcr(0, cpuc->pcr);
 }
 
 static int active_event_index(struct cpu_hw_events *cpuc,
@@ -856,7 +855,7 @@ static void perf_stop_nmi_watchdog(void *unused)
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 
 	stop_nmi_watchdog(NULL);
-	cpuc->pcr = pcr_ops->read(0);
+	cpuc->pcr = pcr_ops->read_pcr(0);
 }
 
 void perf_event_grab_pmc(void)
@@ -1264,8 +1263,8 @@ void perf_event_print_debug(void)
 
 	cpu = smp_processor_id();
 
-	pcr = pcr_ops->read(0);
-	read_pic(pic);
+	pcr = pcr_ops->read_pcr(0);
+	pic = pcr_ops->read_pic(0);
 
 	pr_info("\n");
 	pr_info("CPU#%d: PCR[%016llx] PIC[%016llx]\n",
@@ -1306,7 +1305,7 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	 * overflow so we don't lose any events.
 	 */
 	if (sparc_pmu->irq_bit)
-		pcr_ops->write(0, cpuc->pcr);
+		pcr_ops->write_pcr(0, cpuc->pcr);
 
 	for (i = 0; i < cpuc->n_events; i++) {
 		struct perf_event *event = cpuc->event[i];
-- 
1.7.10.4

