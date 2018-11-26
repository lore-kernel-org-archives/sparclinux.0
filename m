From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:34 +0000
Subject: [PATCH v2 18/20] x86: perf/core remove unnecessary checks for exclusion
Message-Id: <1543230756-15319-19-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

For x86 PMUs that do not support context exclusion we do not
advertise the PERF_PMU_CAP_EXCLUDE capability. This ensures
that perf will prevent us from handling events where any
exclusion flags are set. Let's remove the now unnecessary
check for exclusion flags.

This change means that amd/iommu and amd/uncore will now
also indicate that they do not support exclude_{hv|idle} and
intel/uncore that it does not support exclude_{guest|host}.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/amd/iommu.c    | 5 -----
 arch/x86/events/amd/uncore.c   | 5 -----
 arch/x86/events/intel/uncore.c | 8 --------
 3 files changed, 18 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 3210fee..eb35fe4 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -223,11 +223,6 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* IOMMU counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 8671de1..d6ade30 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -201,11 +201,6 @@ static int amd_uncore_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* NB and Last level cache counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* and we do not enable counter overflow interrupts */
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a4614..f1d78d9 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -695,14 +695,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	if (pmu->func_id < 0)
 		return -ENOENT;
 
-	/*
-	 * Uncore PMU does measure at all privilege level all the time.
-	 * So it doesn't make sense to specify any exclude bits.
-	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-			event->attr.exclude_hv || event->attr.exclude_idle)
-		return -EINVAL;
-
 	/* Sampling not supported yet */
 	if (hwc->sample_period)
 		return -EINVAL;
-- 
2.7.4
