From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:31 +0000
Subject: [PATCH v2 15/20] s390: perf/events: advertise PMU exclusion capability
Message-Id: <1543230756-15319-16-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The s390 cpum_cf and cpum_sf PMUs have the capability to exclude
events based on context. Let's advertise that we support the
PERF_PMU_CAP_EXCLUDE capability to ensure that perf doesn't
prevent us from handling events where any exclusion flags are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 1 +
 arch/s390/kernel/perf_cpum_sf.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index cc085e2..7b583ed 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -667,6 +667,7 @@ static struct pmu cpumf_pmu = {
 	.start_txn    = cpumf_pmu_start_txn,
 	.commit_txn   = cpumf_pmu_commit_txn,
 	.cancel_txn   = cpumf_pmu_cancel_txn,
+	.capabilities = PERF_PMU_CAP_EXCLUDE,
 };
 
 static int cpumf_pmf_setup(unsigned int cpu, int flags)
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 5c53e97..25a64aa 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1885,6 +1885,8 @@ static struct pmu cpumf_sampling = {
 
 	.setup_aux    = aux_buffer_setup,
 	.free_aux     = aux_buffer_free,
+
+	.capabilities = PERF_PMU_CAP_EXCLUDE,
 };
 
 static void cpumf_measurement_alert(struct ext_code ext_code,
-- 
2.7.4
