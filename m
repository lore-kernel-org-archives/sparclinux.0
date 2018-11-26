From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:35 +0000
Subject: [PATCH v2 19/20] x86: perf/core: advertise PMU exclusion capability
Message-Id: <1543230756-15319-20-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

For PMUs that have the capability to exclude events based
on context. Let's advertise that we support the
PERF_PMU_CAP_EXCLUDE capability to ensure that perf doesn't
prevent us from handling events where any exclusion flags
are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/core.c      | 2 ++
 arch/x86/events/intel/bts.c | 2 +-
 arch/x86/events/intel/pt.c  | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c..3f51916 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2297,6 +2297,8 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+
+	.capabilities		= PERF_PMU_CAP_EXCLUDE,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 24ffa1e..4976695 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -601,7 +601,7 @@ static __init int bts_init(void)
 	}
 
 	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
-				  PERF_PMU_CAP_EXCLUSIVE;
+				  PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_EXCLUDE;
 	bts_pmu.task_ctx_nr	= perf_sw_context;
 	bts_pmu.event_init	= bts_event_init;
 	bts_pmu.add		= bts_event_add;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8d016ce..2d811f8 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1516,7 +1516,9 @@ static __init int pt_init(void)
 		pt_pmu.pmu.capabilities  			PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_SW_DOUBLEBUF;
 
-	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
+	pt_pmu.pmu.capabilities		 = PERF_PMU_CAP_EXCLUSIVE |
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_EXCLUDE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
 	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
 	pt_pmu.pmu.event_init		 = pt_event_init;
-- 
2.7.4
