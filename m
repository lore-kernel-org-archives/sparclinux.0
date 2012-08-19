From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:39 +0000
Subject: [PATCH 14/17] sparc64: Make sparc_pmu_{enable,disable}_event() multi-pcr aware.
Message-Id: <20120818.232839.534844967649221787.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 197c79e..c3ad637 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -623,27 +623,35 @@ static u64 nop_for_index(int idx)
 static inline void sparc_pmu_enable_event(struct cpu_hw_events *cpuc, struct hw_perf_event *hwc, int idx)
 {
 	u64 val, mask = mask_for_index(idx);
+	int pcr_index = 0;
 
-	val = cpuc->pcr[0];
+	if (sparc_pmu->num_pcrs > 1)
+		pcr_index = idx;
+
+	val = cpuc->pcr[pcr_index];
 	val &= ~mask;
 	val |= hwc->config;
-	cpuc->pcr[0] = val;
+	cpuc->pcr[pcr_index] = val;
 
-	pcr_ops->write_pcr(0, cpuc->pcr[0]);
+	pcr_ops->write_pcr(pcr_index, cpuc->pcr[pcr_index]);
 }
 
 static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw_perf_event *hwc, int idx)
 {
 	u64 mask = mask_for_index(idx);
 	u64 nop = nop_for_index(idx);
+	int pcr_index = 0;
 	u64 val;
 
-	val = cpuc->pcr[0];
+	if (sparc_pmu->num_pcrs > 1)
+		pcr_index = idx;
+
+	val = cpuc->pcr[pcr_index];
 	val &= ~mask;
 	val |= nop;
-	cpuc->pcr[0] = val;
+	cpuc->pcr[pcr_index] = val;
 
-	pcr_ops->write_pcr(0, cpuc->pcr[0]);
+	pcr_ops->write_pcr(pcr_index, cpuc->pcr[pcr_index]);
 }
 
 static u64 sparc_perf_event_update(struct perf_event *event,
-- 
1.7.10.4

