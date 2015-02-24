From: David Ahern <david.ahern@oracle.com>
Date: Tue, 24 Feb 2015 03:07:37 +0000
Subject: [PATCH 3/3] sparc: perf: Make counting mode actually work
Message-Id: <1424747257-141252-3-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Currently perf-stat (aka, counting mode) does not work:

perf stat ./1bi

 Performance counter stats for './1bi':

        131.864070      task-clock (msec)         #    0.993 CPUs utilized
                 0      context-switches          #    0.000 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                30      page-faults               #    0.228 K/sec
                 0      cycles                    #    0.000 GHz
   <not supported>      stalled-cycles-frontend:HG
   <not supported>      stalled-cycles-backend:HG
                 0      instructions:HG
                 0      branches:HG               #    0.000 K/sec
                 0      branch-misses:HG          #    0.00% of all branches

       0.132778349 seconds time elapsed

The reason is that state is never reset (stays with PERF_HES_UPTODATE set).
Add a call to sparc_pmu_enable_event during the added_event handling.
Clean up the encoding since pmu_start calls sparc_pmu_enable_event which
does the same. Passing PERF_EF_RELOAD to sparc_pmu_start means the call
to sparc_perf_event_set_period can be removed as well.

With this patch:
perf stat ./1bi

 Performance counter stats for './1bi':

        131.893485      task-clock (msec)         #    0.992 CPUs utilized
                 0      context-switches          #    0.000 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                30      page-faults               #    0.227 K/sec
       546,781,981      cycles                    #    4.146 GHz
   <not supported>      stalled-cycles-frontend:HG
   <not supported>      stalled-cycles-backend:HG
     1,090,528,128      instructions:HG           #    1.99  insns per cycle
        10,089,375      branches:HG               #   76.496 M/sec
             7,182      branch-misses:HG          #    0.07% of all branches

       0.132918320 seconds time elapsed

Signed-off-by: David Ahern <david.ahern@oracle.com>
---
 arch/sparc/kernel/perf_event.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 48b565fdb486..86eebfa3b158 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -996,6 +996,8 @@ static void calculate_single_pcr(struct cpu_hw_events *cpuc)
 	cpuc->pcr[0] |= cpuc->event[0]->hw.config_base;
 }
 
+static void sparc_pmu_start(struct perf_event *event, int flags);
+
 /* On this PMU each PIC has it's own PCR control register.  */
 static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
 {
@@ -1008,20 +1010,13 @@ static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
 		struct perf_event *cp = cpuc->event[i];
 		struct hw_perf_event *hwc = &cp->hw;
 		int idx = hwc->idx;
-		u64 enc;
 
 		if (cpuc->current_idx[i] != PIC_NO_INDEX)
 			continue;
 
-		sparc_perf_event_set_period(cp, hwc, idx);
 		cpuc->current_idx[i] = idx;
 
-		enc = perf_event_get_enc(cpuc->events[i]);
-		cpuc->pcr[idx] &= ~mask_for_index(idx);
-		if (hwc->state & PERF_HES_STOPPED)
-			cpuc->pcr[idx] |= nop_for_index(idx);
-		else
-			cpuc->pcr[idx] |= event_encoding(enc, idx);
+		sparc_pmu_start(cp, PERF_EF_RELOAD);
 	}
 out:
 	for (i = 0; i < cpuc->n_events; i++) {
-- 
2.3.0

