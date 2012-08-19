From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:42 +0000
Subject: [PATCH 15/17] sparc64: Support perf event encoding for multi-PCR PMUs.
Message-Id: <20120818.232842.1202917155920134747.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   98 ++++++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index c3ad637..6441592 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -710,18 +710,10 @@ static int sparc_perf_event_set_period(struct perf_event *event,
 	return ret;
 }
 
-/* If performance event entries have been added, move existing
- * events around (if necessary) and then assign new entries to
- * counters.
- */
-static u64 maybe_change_configuration(struct cpu_hw_events *cpuc, u64 pcr)
+static void read_in_all_counters(struct cpu_hw_events *cpuc)
 {
 	int i;
 
-	if (!cpuc->n_added)
-		goto out;
-
-	/* Read in the counters which are moving.  */
 	for (i = 0; i < cpuc->n_events; i++) {
 		struct perf_event *cp = cpuc->event[i];
 
@@ -732,6 +724,20 @@ static u64 maybe_change_configuration(struct cpu_hw_events *cpuc, u64 pcr)
 			cpuc->current_idx[i] = PIC_NO_INDEX;
 		}
 	}
+}
+
+/* On this PMU all PICs are programmed using a single PCR.  Calculate
+ * the combined control register value.
+ *
+ * For such chips we require that all of the events have the same
+ * configuration, so just fetch the settings from the first entry.
+ */
+static void calculate_single_pcr(struct cpu_hw_events *cpuc)
+{
+	int i;
+
+	if (!cpuc->n_added)
+		goto out;
 
 	/* Assign to counters all unassigned events.  */
 	for (i = 0; i < cpuc->n_events; i++) {
@@ -747,19 +753,71 @@ static u64 maybe_change_configuration(struct cpu_hw_events *cpuc, u64 pcr)
 		cpuc->current_idx[i] = idx;
 
 		enc = perf_event_get_enc(cpuc->events[i]);
-		pcr &= ~mask_for_index(idx);
+		cpuc->pcr[0] &= ~mask_for_index(idx);
 		if (hwc->state & PERF_HES_STOPPED)
-			pcr |= nop_for_index(idx);
+			cpuc->pcr[0] |= nop_for_index(idx);
 		else
-			pcr |= event_encoding(enc, idx);
+			cpuc->pcr[0] |= event_encoding(enc, idx);
 	}
 out:
-	return pcr;
+	cpuc->pcr[0] |= cpuc->event[0]->hw.config_base;
+}
+
+/* On this PMU each PIC has it's own PCR control register.  */
+static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
+{
+	int i;
+
+	if (!cpuc->n_added)
+		goto out;
+
+	for (i = 0; i < cpuc->n_events; i++) {
+		struct perf_event *cp = cpuc->event[i];
+		struct hw_perf_event *hwc = &cp->hw;
+		int idx = hwc->idx;
+		u64 enc;
+
+		if (cpuc->current_idx[i] != PIC_NO_INDEX)
+			continue;
+
+		sparc_perf_event_set_period(cp, hwc, idx);
+		cpuc->current_idx[i] = idx;
+
+		enc = perf_event_get_enc(cpuc->events[i]);
+		cpuc->pcr[idx] &= ~mask_for_index(idx);
+		if (hwc->state & PERF_HES_STOPPED)
+			cpuc->pcr[idx] |= nop_for_index(idx);
+		else
+			cpuc->pcr[idx] |= event_encoding(enc, idx);
+	}
+out:
+	for (i = 0; i < cpuc->n_events; i++) {
+		struct perf_event *cp = cpuc->event[i];
+		int idx = cp->hw.idx;
+
+		cpuc->pcr[idx] |= cp->hw.config_base;
+	}
+}
+
+/* If performance event entries have been added, move existing events
+ * around (if necessary) and then assign new entries to counters.
+ */
+static void update_pcrs_for_enable(struct cpu_hw_events *cpuc)
+{
+	if (cpuc->n_added)
+		read_in_all_counters(cpuc);
+
+	if (sparc_pmu->num_pcrs = 1) {
+		calculate_single_pcr(cpuc);
+	} else {
+		calculate_multiple_pcrs(cpuc);
+	}
 }
 
 static void sparc_pmu_enable(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	int i;
 
 	if (cpuc->enabled)
 		return;
@@ -767,17 +825,11 @@ static void sparc_pmu_enable(struct pmu *pmu)
 	cpuc->enabled = 1;
 	barrier();
 
-	if (cpuc->n_events) {
-		u64 pcr = maybe_change_configuration(cpuc, cpuc->pcr[0]);
-
-		/* We require that all of the events have the same
-		 * configuration, so just fetch the settings from the
-		 * first entry.
-		 */
-		cpuc->pcr[0] = pcr | cpuc->event[0]->hw.config_base;
-	}
+	if (cpuc->n_events)
+		update_pcrs_for_enable(cpuc);
 
-	pcr_ops->write_pcr(0, cpuc->pcr[0]);
+	for (i = 0; i < sparc_pmu->num_pcrs; i++)
+		pcr_ops->write_pcr(i, cpuc->pcr[i]);
 }
 
 static void sparc_pmu_disable(struct pmu *pmu)
-- 
1.7.10.4

