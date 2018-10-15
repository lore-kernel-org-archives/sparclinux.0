From: David Miller <davem@davemloft.net>
Date: Mon, 15 Oct 2018 03:25:21 +0000
Subject: [PATCH] sparc: Fix single-pcr perf event counter management.
Message-Id: <20181014.202521.2161495221449847573.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It is important to clear the hw->state value for non-stopped events
when they are added into the PMU.  Otherwise when the event is
scheduled out, we won't read the counter because HES_UPTODATE is still
set.  This breaks 'perf stat' and similar use cases, causing all the
events to show zero.

This worked for multi-pcr because we make explicit sparc_pmu_start()
calls in calculate_multiple_pcrs().  calculate_single_pcr() doesn't do
this because the idea there is to accumulate all of the counter
settings into the single pcr value.  So we have to add explicit
hw->state handling there.

Like x86, we use the PERF_HES_ARCH bit to track truly stopped events
so that we don't accidently start them on a reload.

Related to all of this, sparc_pmu_start() is missing a userpage update
so add it.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index d3149baaa33c..a4cc26bd89a2 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -927,6 +927,8 @@ static void read_in_all_counters(struct cpu_hw_events *cpuc)
 			sparc_perf_event_update(cp, &cp->hw,
 						cpuc->current_idx[i]);
 			cpuc->current_idx[i] = PIC_NO_INDEX;
+			if (cp->hw.state & PERF_HES_STOPPED)
+				cp->hw.state |= PERF_HES_ARCH;
 		}
 	}
 }
@@ -959,10 +961,12 @@ static void calculate_single_pcr(struct cpu_hw_events *cpuc)
 
 		enc = perf_event_get_enc(cpuc->events[i]);
 		cpuc->pcr[0] &= ~mask_for_index(idx);
-		if (hwc->state & PERF_HES_STOPPED)
+		if (hwc->state & PERF_HES_ARCH) {
 			cpuc->pcr[0] |= nop_for_index(idx);
-		else
+		} else {
 			cpuc->pcr[0] |= event_encoding(enc, idx);
+			hwc->state = 0;
+		}
 	}
 out:
 	cpuc->pcr[0] |= cpuc->event[0]->hw.config_base;
@@ -988,6 +992,9 @@ static void calculate_multiple_pcrs(struct cpu_hw_events *cpuc)
 
 		cpuc->current_idx[i] = idx;
 
+		if (cp->hw.state & PERF_HES_ARCH)
+			continue;
+
 		sparc_pmu_start(cp, PERF_EF_RELOAD);
 	}
 out:
@@ -1079,6 +1086,8 @@ static void sparc_pmu_start(struct perf_event *event, int flags)
 	event->hw.state = 0;
 
 	sparc_pmu_enable_event(cpuc, &event->hw, idx);
+
+	perf_event_update_userpage(event);
 }
 
 static void sparc_pmu_stop(struct perf_event *event, int flags)
@@ -1371,9 +1380,9 @@ static int sparc_pmu_add(struct perf_event *event, int ef_flags)
 	cpuc->events[n0] = event->hw.event_base;
 	cpuc->current_idx[n0] = PIC_NO_INDEX;
 
-	event->hw.state = PERF_HES_UPTODATE;
+	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 	if (!(ef_flags & PERF_EF_START))
-		event->hw.state |= PERF_HES_STOPPED;
+		event->hw.state |= PERF_HES_ARCH;
 
 	/*
 	 * If group events scheduling transaction was started,
-- 
2.19.1
