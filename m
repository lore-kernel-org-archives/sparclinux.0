From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:28 +0000
Subject: [PATCH v2 12/20] mips: perf/core: advertise PMU exclusion capability
Message-Id: <1543230756-15319-13-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The MIPS PMU has the capability to exclude events based on
context. Let's advertise that we support the PERF_PMU_CAP_EXCLUDE
capability to ensure that perf doesn't prevent us from handling
events where any exclusion flags are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 4138635..d7813d0 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -670,6 +670,7 @@ static struct pmu pmu = {
 	.start		= mipspmu_start,
 	.stop		= mipspmu_stop,
 	.read		= mipspmu_read,
+	.capabilities	= PERF_PMU_CAP_EXCLUDE,
 };
 
 static unsigned int mipspmu_perf_event_encode(const struct mips_perf_event *pev)
-- 
2.7.4
