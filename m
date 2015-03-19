From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 20:06:17 +0000
Subject: [PATCH] sparc: perf: Make counting mode actually work
Message-Id: <1426795577-135680-1-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Currently perf-stat (aka, counting mode) does not work:

$ perf stat ls
...
 Performance counter stats for 'ls':

          1.585665      task-clock (msec)         #    0.580 CPUs utilized
                24      context-switches          #    0.015 M/sec
                 0      cpu-migrations            #    0.000 K/sec
                86      page-faults               #    0.054 M/sec
   <not supported>      cycles
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
   <not supported>      instructions
   <not supported>      branches
   <not supported>      branch-misses

       0.002735100 seconds time elapsed

The reason is that state is never reset (stays with PERF_HES_UPTODATE set).
Add a call to sparc_pmu_enable_event during the added_event handling.
Clean up the encoding since pmu_start calls sparc_pmu_enable_event which
does the same. Passing PERF_EF_RELOAD to sparc_pmu_start means the call
to sparc_perf_event_set_period can be removed as well.

With this patch:

$ perf stat ls
...
 Performance counter stats for 'ls':

          1.552890      task-clock (msec)         #    0.552 CPUs utilized
                24      context-switches          #    0.015 M/sec
                 0      cpu-migrations            #    0.000 K/sec
                86      page-faults               #    0.055 M/sec
         5,748,997      cycles                    #    3.702 GHz
   <not supported>      stalled-cycles-frontend:HG
   <not supported>      stalled-cycles-backend:HG
         1,684,362      instructions:HG           #    0.29  insns per cycle
           295,133      branches:HG               #  190.054 M/sec
            28,007      branch-misses:HG          #    9.49% of all branches

       0.002815665 seconds time elapsed

Signed-off-by: David Ahern <david.ahern@oracle.com>
Acked-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/kernel/perf_event.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 6dc4e793df4c..af53c25da2e7 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -960,6 +960,8 @@ static void calculate_single_pcr(struct cpu_hw_events *cpuc)
 	cpuc->pcr[0] |= cpuc->event[0]->hw.config_base;
 }
 
+static void sparc_pmu_start(struct perf_event *event, int flags);
+
 /* On this PMU each PIC has it's own PCR control register.  */
 static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
 {
@@ -972,20 +974,13 @@ static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
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

