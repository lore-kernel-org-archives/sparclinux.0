From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:29 +0000
Subject: [PATCH v2 13/20] powerpc: perf/core: advertise PMU exclusion capability
Message-Id: <1543230756-15319-14-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

For PowerPC PMUs that have the capability to exclude events
based on context. Let's advertise that we support the
PERF_PMU_CAP_EXCLUDE capability to ensure that perf doesn't
prevent us from handling events where any exclusion flags are
set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/powerpc/perf/core-book3s.c  | 1 +
 arch/powerpc/perf/core-fsl-emb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 81f8a0c..2f44b09 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2007,6 +2007,7 @@ static struct pmu power_pmu = {
 	.commit_txn	= power_pmu_commit_txn,
 	.event_idx	= power_pmu_event_idx,
 	.sched_task	= power_pmu_sched_task,
+	.capabilities	= PERF_PMU_CAP_EXCLUDE,
 };
 
 /*
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index ba48584..cea5bcb 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -596,6 +596,7 @@ static struct pmu fsl_emb_pmu = {
 	.start		= fsl_emb_pmu_start,
 	.stop		= fsl_emb_pmu_stop,
 	.read		= fsl_emb_pmu_read,
+	.capabilities	= PERF_PMU_CAP_EXCLUDE,
 };
 
 /*
-- 
2.7.4
