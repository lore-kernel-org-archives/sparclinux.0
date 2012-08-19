From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:09 +0000
Subject: [PATCH 08/17] sparc64: Add perf_event abstractions for orthogonal PMUs.
Message-Id: <20120818.232809.1358836843119338478.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Starting with SPARC-T4 we have a seperate PCR control register
for each performance counter, and there are absolutely no
restrictions on what events can run on which counters.

Add flags that we can use to elide the conflict and dependency
logic used to handle older chips.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index dd12aa3..11b424b 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -148,6 +148,9 @@ struct sparc_pmu {
 	int				irq_bit;
 	int				upper_nop;
 	int				lower_nop;
+	unsigned int			flags;
+#define SPARC_PMU_ALL_EXCLUDES_SAME	0x00000001
+#define SPARC_PMU_HAS_CONFLICTS		0x00000002
 };
 
 static const struct perf_event_map ultra3_perfmon_event_map[] = {
@@ -272,6 +275,8 @@ static const struct sparc_pmu ultra3_pmu = {
 	.event_mask	= 0x3f,
 	.upper_nop	= 0x1c,
 	.lower_nop	= 0x14,
+	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
+			   SPARC_PMU_HAS_CONFLICTS),
 };
 
 /* Niagara1 is very limited.  The upper PIC is hard-locked to count
@@ -401,6 +406,8 @@ static const struct sparc_pmu niagara1_pmu = {
 	.event_mask	= 0x7,
 	.upper_nop	= 0x0,
 	.lower_nop	= 0x0,
+	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
+			   SPARC_PMU_HAS_CONFLICTS),
 };
 
 static const struct perf_event_map niagara2_perfmon_event_map[] = {
@@ -529,6 +536,8 @@ static const struct sparc_pmu niagara2_pmu = {
 	.irq_bit	= 0x30,
 	.upper_nop	= 0x220,
 	.lower_nop	= 0x220,
+	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
+			   SPARC_PMU_HAS_CONFLICTS),
 };
 
 static const struct sparc_pmu *sparc_pmu __read_mostly;
@@ -944,6 +953,14 @@ static int sparc_check_constraints(struct perf_event **evts,
 	if (n_ev > MAX_HWEVENTS)
 		return -1;
 
+	if (!(sparc_pmu->flags & SPARC_PMU_HAS_CONFLICTS)) {
+		int i;
+
+		for (i = 0; i < n_ev; i++)
+			evts[i]->hw.idx = i;
+		return 0;
+	}
+
 	msk0 = perf_event_get_msk(events[0]);
 	if (n_ev = 1) {
 		if (msk0 & PIC_LOWER)
@@ -999,6 +1016,9 @@ static int check_excludes(struct perf_event **evts, int n_prev, int n_new)
 	struct perf_event *event;
 	int i, n, first;
 
+	if (!(sparc_pmu->flags & SPARC_PMU_ALL_EXCLUDES_SAME))
+		return 0;
+
 	n = n_prev + n_new;
 	if (n <= 1)
 		return 0;
-- 
1.7.10.4

