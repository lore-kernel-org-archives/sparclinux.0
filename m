From: David Ahern <david.ahern@oracle.com>
Date: Tue, 24 Feb 2015 03:07:35 +0000
Subject: [PATCH 1/3] sparc: perf: Remove redundant perf_pmu_{en|dis}able calls
Message-Id: <1424747257-141252-1-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

perf_pmu_disable is called by core perf code before pmu->del and the
enable function is called by core perf code afterwards. No need to
call again within sparc_pmu_del.

Ditto for pmu->add and sparc_pmu_add.

Signed-off-by: David Ahern <david.ahern@oracle.com>
---
 arch/sparc/kernel/perf_event.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 46a5e4508752..6dc4e793df4c 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1101,7 +1101,6 @@ static void sparc_pmu_del(struct perf_event *event, int _flags)
 	int i;
 
 	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
 
 	for (i = 0; i < cpuc->n_events; i++) {
 		if (event = cpuc->event[i]) {
@@ -1127,7 +1126,6 @@ static void sparc_pmu_del(struct perf_event *event, int _flags)
 		}
 	}
 
-	perf_pmu_enable(event->pmu);
 	local_irq_restore(flags);
 }
 
@@ -1361,7 +1359,6 @@ static int sparc_pmu_add(struct perf_event *event, int ef_flags)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	perf_pmu_disable(event->pmu);
 
 	n0 = cpuc->n_events;
 	if (n0 >= sparc_pmu->max_hw_events)
@@ -1394,7 +1391,6 @@ static int sparc_pmu_add(struct perf_event *event, int ef_flags)
 
 	ret = 0;
 out:
-	perf_pmu_enable(event->pmu);
 	local_irq_restore(flags);
 	return ret;
 }
-- 
2.3.0

