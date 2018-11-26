From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:30 +0000
Subject: [PATCH v2 14/20] powerpc: perf/core: remove unnecessary checks for exclusion
Message-Id: <1543230756-15319-15-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

For PowerPC PMUs that do not support context exclusion we do not
advertise the PERF_PMU_CAP_EXCLUDE capability. This ensures that
perf will prevent us from handling events where any exclusion
flags are set. Let's remove the now unnecessary check for exclusion
flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/powerpc/perf/hv-24x7.c |  9 ---------
 arch/powerpc/perf/hv-gpci.c |  9 ---------
 arch/powerpc/perf/imc-pmu.c | 18 ------------------
 3 files changed, 36 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 72238ee..d13d8a9 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1306,15 +1306,6 @@ static int h_24x7_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 43fabb3..e0ce0e0 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -232,15 +232,6 @@ static int h_gpci_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 1fafc32b..49c0b1c 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -473,15 +473,6 @@ static int nest_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -748,15 +739,6 @@ static int core_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
-- 
2.7.4
