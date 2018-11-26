From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:20 +0000
Subject: [PATCH v2 04/20] perf/hw_breakpoint: perf/core: advertise PMU exclusion capability
Message-Id: <1543230756-15319-5-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The breakpoint PMU has the capability to exclude kernel contexts,
let's advertise that we support the PERF_PMU_CAP_EXCLUDE
capability so that perf doesn't prevent us from handling events
with any exclusion flags set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 kernel/events/hw_breakpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index d6b5618..fefe3d5 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -669,6 +669,8 @@ static struct pmu perf_breakpoint = {
 	.start		= hw_breakpoint_start,
 	.stop		= hw_breakpoint_stop,
 	.read		= hw_breakpoint_pmu_read,
+
+	.capabilities	= PERF_PMU_CAP_EXCLUDE,
 };
 
 int __init init_hw_breakpoint(void)
-- 
2.7.4
