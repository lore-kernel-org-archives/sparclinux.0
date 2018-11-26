From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:19 +0000
Subject: [PATCH v2 03/20] perf/core: add PERF_PMU_CAP_EXCLUDE for exclusion capable PMUs
Message-Id: <1543230756-15319-4-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Many PMU drivers do not have the capability to exclude counting events
that occur in specific contexts such as idle, kernel, guest, etc. These
drivers indicate this by returning an error in their event_init upon
testing the events attribute flags. This approach is error prone and
often inconsistent.

Let's instead allow PMU drivers to advertise their ability to exclude
based on context via a new capability: PERF_PMU_CAP_EXCLUDE. This
allows the perf core to reject requests for exclusion events where
there is no support in the PMU.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b2e806f..69b3d65 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -244,6 +244,7 @@ struct perf_event;
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
+#define PERF_PMU_CAP_EXCLUDE			0x80
 
 /**
  * struct pmu - generic performance monitoring unit
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a97f34..9afb33c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9743,6 +9743,15 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	if (ctx)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
+	if (!ret) {
+		if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUDE) &&
+				event_has_any_exclude_flag(event)) {
+			if (event->destroy)
+				event->destroy(event);
+			ret = -EINVAL;
+		}
+	}
+
 	if (ret)
 		module_put(pmu->module);
 
-- 
2.7.4
