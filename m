From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:22 +0000
Subject: [PATCH v2 06/20] arc: perf/core: advertise PMU exclusion capability
Message-Id: <1543230756-15319-7-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The ARC PMU has the capability to exclude events based on
context. Let's advertise that we support the
PERF_PMU_CAP_EXCLUDE capability to ensure that perf doesn't
prevent us from handling events where any exclusion flags are
set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arc/kernel/perf_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 8aec462..cf8ea6d 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -514,6 +514,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		.start		= arc_pmu_start,
 		.stop		= arc_pmu_stop,
 		.read		= arc_pmu_read,
+		.capabilities	= PERF_PMU_CAP_EXCLUDE,
 	};
 
 	if (has_interrupts) {
-- 
2.7.4
