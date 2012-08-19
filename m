From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:30 +0000
Subject: [PATCH 12/17] sparc64: Prepare perf event layer for handling multiple PCR registers.
Message-Id: <20120818.232830.1330376124979585013.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Make the per-cpu pcr save area an array instead of one u64.

Describe how many PCR and PIC registers the chip has in the sparc_pmu
descriptor.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   72 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 1ab676b..9be089a 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -54,6 +54,7 @@
  */
 
 #define MAX_HWEVENTS			2
+#define MAX_PCRS			1
 #define MAX_PERIOD			((1UL << 32) - 1)
 
 #define PIC_UPPER_INDEX			0
@@ -89,8 +90,8 @@ struct cpu_hw_events {
 	 */
 	int			current_idx[MAX_HWEVENTS];
 
-	/* Software copy of %pcr register on this cpu.  */
-	u64			pcr;
+	/* Software copy of %pcr register(s) on this cpu.  */
+	u64			pcr[MAX_HWEVENTS];
 
 	/* Enabled/disable state.  */
 	int			enabled;
@@ -156,6 +157,8 @@ struct sparc_pmu {
 #define SPARC_PMU_ALL_EXCLUDES_SAME	0x00000001
 #define SPARC_PMU_HAS_CONFLICTS		0x00000002
 	int				max_hw_events;
+	int				num_pcrs;
+	int				num_pic_regs;
 };
 
 static u32 sparc_default_read_pmc(int idx)
@@ -315,6 +318,8 @@ static const struct sparc_pmu ultra3_pmu = {
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
 			   SPARC_PMU_HAS_CONFLICTS),
 	.max_hw_events	= 2,
+	.num_pcrs	= 1,
+	.num_pic_regs	= 1,
 };
 
 /* Niagara1 is very limited.  The upper PIC is hard-locked to count
@@ -451,6 +456,8 @@ static const struct sparc_pmu niagara1_pmu = {
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
 			   SPARC_PMU_HAS_CONFLICTS),
 	.max_hw_events	= 2,
+	.num_pcrs	= 1,
+	.num_pic_regs	= 1,
 };
 
 static const struct perf_event_map niagara2_perfmon_event_map[] = {
@@ -586,6 +593,8 @@ static const struct sparc_pmu niagara2_pmu = {
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
 			   SPARC_PMU_HAS_CONFLICTS),
 	.max_hw_events	= 2,
+	.num_pcrs	= 1,
+	.num_pic_regs	= 1,
 };
 
 static const struct sparc_pmu *sparc_pmu __read_mostly;
@@ -615,12 +624,12 @@ static inline void sparc_pmu_enable_event(struct cpu_hw_events *cpuc, struct hw_
 {
 	u64 val, mask = mask_for_index(idx);
 
-	val = cpuc->pcr;
+	val = cpuc->pcr[0];
 	val &= ~mask;
 	val |= hwc->config;
-	cpuc->pcr = val;
+	cpuc->pcr[0] = val;
 
-	pcr_ops->write_pcr(0, cpuc->pcr);
+	pcr_ops->write_pcr(0, cpuc->pcr[0]);
 }
 
 static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw_perf_event *hwc, int idx)
@@ -629,12 +638,12 @@ static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw
 	u64 nop = nop_for_index(idx);
 	u64 val;
 
-	val = cpuc->pcr;
+	val = cpuc->pcr[0];
 	val &= ~mask;
 	val |= nop;
-	cpuc->pcr = val;
+	cpuc->pcr[0] = val;
 
-	pcr_ops->write_pcr(0, cpuc->pcr);
+	pcr_ops->write_pcr(0, cpuc->pcr[0]);
 }
 
 static u64 sparc_perf_event_update(struct perf_event *event,
@@ -751,7 +760,7 @@ static void sparc_pmu_enable(struct pmu *pmu)
 	cpuc->enabled = 1;
 	barrier();
 
-	pcr = cpuc->pcr;
+	pcr = cpuc->pcr[0];
 	if (!cpuc->n_events) {
 		pcr = 0;
 	} else {
@@ -761,16 +770,16 @@ static void sparc_pmu_enable(struct pmu *pmu)
 		 * configuration, so just fetch the settings from the
 		 * first entry.
 		 */
-		cpuc->pcr = pcr | cpuc->event[0]->hw.config_base;
+		cpuc->pcr[0] = pcr | cpuc->event[0]->hw.config_base;
 	}
 
-	pcr_ops->write_pcr(0, cpuc->pcr);
+	pcr_ops->write_pcr(0, cpuc->pcr[0]);
 }
 
 static void sparc_pmu_disable(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
-	u64 val;
+	int i;
 
 	if (!cpuc->enabled)
 		return;
@@ -778,12 +787,14 @@ static void sparc_pmu_disable(struct pmu *pmu)
 	cpuc->enabled = 0;
 	cpuc->n_added = 0;
 
-	val = cpuc->pcr;
-	val &= ~(sparc_pmu->user_bit | sparc_pmu->priv_bit |
-		 sparc_pmu->hv_bit | sparc_pmu->irq_bit);
-	cpuc->pcr = val;
+	for (i = 0; i < sparc_pmu->num_pcrs; i++) {
+		u64 val = cpuc->pcr[i];
 
-	pcr_ops->write_pcr(0, cpuc->pcr);
+		val &= ~(sparc_pmu->user_bit | sparc_pmu->priv_bit |
+			 sparc_pmu->hv_bit | sparc_pmu->irq_bit);
+		cpuc->pcr[i] = val;
+		pcr_ops->write_pcr(i, cpuc->pcr[i]);
+	}
 }
 
 static int active_event_index(struct cpu_hw_events *cpuc,
@@ -882,9 +893,11 @@ static DEFINE_MUTEX(pmc_grab_mutex);
 static void perf_stop_nmi_watchdog(void *unused)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	int i;
 
 	stop_nmi_watchdog(NULL);
-	cpuc->pcr = pcr_ops->read_pcr(0);
+	for (i = 0; i < sparc_pmu->num_pcrs; i++)
+		cpuc->pcr[i] = pcr_ops->read_pcr(i);
 }
 
 void perf_event_grab_pmc(void)
@@ -1293,8 +1306,7 @@ static struct pmu pmu = {
 void perf_event_print_debug(void)
 {
 	unsigned long flags;
-	u64 pcr, pic;
-	int cpu;
+	int cpu, i;
 
 	if (!sparc_pmu)
 		return;
@@ -1303,12 +1315,13 @@ void perf_event_print_debug(void)
 
 	cpu = smp_processor_id();
 
-	pcr = pcr_ops->read_pcr(0);
-	pic = pcr_ops->read_pic(0);
-
 	pr_info("\n");
-	pr_info("CPU#%d: PCR[%016llx] PIC[%016llx]\n",
-		cpu, pcr, pic);
+	for (i = 0; i < sparc_pmu->num_pcrs; i++)
+		pr_info("CPU#%d: PCR%d[%016llx]\n",
+			cpu, i, pcr_ops->read_pcr(i));
+	for (i = 0; i < sparc_pmu->num_pic_regs; i++)
+		pr_info("CPU#%d: PIC%d[%016llx]\n",
+			cpu, i, pcr_ops->read_pic(i));
 
 	local_irq_restore(flags);
 }
@@ -1344,8 +1357,9 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	 * Do this before we peek at the counters to determine
 	 * overflow so we don't lose any events.
 	 */
-	if (sparc_pmu->irq_bit)
-		pcr_ops->write_pcr(0, cpuc->pcr);
+	if (sparc_pmu->irq_bit &&
+	    sparc_pmu->num_pcrs = 1)
+		pcr_ops->write_pcr(0, cpuc->pcr[0]);
 
 	for (i = 0; i < cpuc->n_events; i++) {
 		struct perf_event *event = cpuc->event[i];
@@ -1353,6 +1367,10 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		struct hw_perf_event *hwc;
 		u64 val;
 
+		if (sparc_pmu->irq_bit &&
+		    sparc_pmu->num_pcrs > 1)
+			pcr_ops->write_pcr(idx, cpuc->pcr[idx]);
+
 		hwc = &event->hw;
 		val = sparc_perf_event_update(event, hwc, idx);
 		if (val & (1ULL << 31))
-- 
1.7.10.4

