From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:16 +0000
Subject: [PATCH 09/17] sparc64: Allow max hw perf events to be variable.
Message-Id: <20120818.232816.1656927869418708256.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Now specified in sparc_pmu descriptor.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 11b424b..f7b9ae3 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -151,6 +151,7 @@ struct sparc_pmu {
 	unsigned int			flags;
 #define SPARC_PMU_ALL_EXCLUDES_SAME	0x00000001
 #define SPARC_PMU_HAS_CONFLICTS		0x00000002
+	int				max_hw_events;
 };
 
 static const struct perf_event_map ultra3_perfmon_event_map[] = {
@@ -277,6 +278,7 @@ static const struct sparc_pmu ultra3_pmu = {
 	.lower_nop	= 0x14,
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
 			   SPARC_PMU_HAS_CONFLICTS),
+	.max_hw_events	= 2,
 };
 
 /* Niagara1 is very limited.  The upper PIC is hard-locked to count
@@ -408,6 +410,7 @@ static const struct sparc_pmu niagara1_pmu = {
 	.lower_nop	= 0x0,
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
 			   SPARC_PMU_HAS_CONFLICTS),
+	.max_hw_events	= 2,
 };
 
 static const struct perf_event_map niagara2_perfmon_event_map[] = {
@@ -538,6 +541,7 @@ static const struct sparc_pmu niagara2_pmu = {
 	.lower_nop	= 0x220,
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
 			   SPARC_PMU_HAS_CONFLICTS),
+	.max_hw_events	= 2,
 };
 
 static const struct sparc_pmu *sparc_pmu __read_mostly;
@@ -950,7 +954,7 @@ static int sparc_check_constraints(struct perf_event **evts,
 	if (!n_ev)
 		return 0;
 
-	if (n_ev > MAX_HWEVENTS)
+	if (n_ev > sparc_pmu->max_hw_events)
 		return -1;
 
 	if (!(sparc_pmu->flags & SPARC_PMU_HAS_CONFLICTS)) {
@@ -1078,7 +1082,7 @@ static int sparc_pmu_add(struct perf_event *event, int ef_flags)
 	perf_pmu_disable(event->pmu);
 
 	n0 = cpuc->n_events;
-	if (n0 >= MAX_HWEVENTS)
+	if (n0 >= sparc_pmu->max_hw_events)
 		goto out;
 
 	cpuc->event[n0] = event;
@@ -1174,7 +1178,7 @@ static int sparc_pmu_event_init(struct perf_event *event)
 	n = 0;
 	if (event->group_leader != event) {
 		n = collect_events(event->group_leader,
-				   MAX_HWEVENTS - 1,
+				   sparc_pmu->max_hw_events - 1,
 				   evts, events, current_idx_dmy);
 		if (n < 0)
 			return -EINVAL;
-- 
1.7.10.4

