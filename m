From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:32 +0000
Subject: [PATCH v2 16/20] sparc: perf/core: advertise PMU exclusion capability
Message-Id: <1543230756-15319-17-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The SPARC PMU has the capability to exclude events based on context
 - let's advertise that we support the PERF_PMU_CAP_EXCLUDE
capability to ensure that perf doesn't prevent us from handling
events where any exclusion flags are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/sparc/kernel/perf_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index d3149ba..38fac17 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1571,6 +1571,7 @@ static struct pmu pmu = {
 	.start_txn	= sparc_pmu_start_txn,
 	.cancel_txn	= sparc_pmu_cancel_txn,
 	.commit_txn	= sparc_pmu_commit_txn,
+	.capabilities	= PERF_PMU_CAP_EXCLUDE,
 };
 
 void perf_event_print_debug(void)
-- 
2.7.4
