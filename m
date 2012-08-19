From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:33 +0000
Subject: [PATCH 13/17] sparc64: Rework sparc_pmu_enable() so that the side effects are clearer.
Message-Id: <20120818.232833.1014846262877017501.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


When cpuc->n_events is zero, we actually don't do anything and we just
write the cpuc->pcr[0] value as-is without any modifications.

The "pcr = 0;" assignment there was just useless and confusing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 9be089a..197c79e 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -752,7 +752,6 @@ out:
 static void sparc_pmu_enable(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
-	u64 pcr;
 
 	if (cpuc->enabled)
 		return;
@@ -760,11 +759,8 @@ static void sparc_pmu_enable(struct pmu *pmu)
 	cpuc->enabled = 1;
 	barrier();
 
-	pcr = cpuc->pcr[0];
-	if (!cpuc->n_events) {
-		pcr = 0;
-	} else {
-		pcr = maybe_change_configuration(cpuc, pcr);
+	if (cpuc->n_events) {
+		u64 pcr = maybe_change_configuration(cpuc, cpuc->pcr[0]);
 
 		/* We require that all of the events have the same
 		 * configuration, so just fetch the settings from the
-- 
1.7.10.4

