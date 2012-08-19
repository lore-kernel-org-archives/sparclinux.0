From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:26 +0000
Subject: [PATCH 11/17] sparc64: Specify user and supervisor trace PCR bits in sparc_pmu.
Message-Id: <20120818.232826.1183283157401221064.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index fbd8029..1ab676b 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -146,6 +146,8 @@ struct sparc_pmu {
 	int				upper_shift;
 	int				lower_shift;
 	int				event_mask;
+	int				user_bit;
+	int				priv_bit;
 	int				hv_bit;
 	int				irq_bit;
 	int				upper_nop;
@@ -306,6 +308,8 @@ static const struct sparc_pmu ultra3_pmu = {
 	.upper_shift	= 11,
 	.lower_shift	= 4,
 	.event_mask	= 0x3f,
+	.user_bit	= PCR_UTRACE,
+	.priv_bit	= PCR_STRACE,
 	.upper_nop	= 0x1c,
 	.lower_nop	= 0x14,
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
@@ -440,6 +444,8 @@ static const struct sparc_pmu niagara1_pmu = {
 	.upper_shift	= 0,
 	.lower_shift	= 4,
 	.event_mask	= 0x7,
+	.user_bit	= PCR_UTRACE,
+	.priv_bit	= PCR_STRACE,
 	.upper_nop	= 0x0,
 	.lower_nop	= 0x0,
 	.flags		= (SPARC_PMU_ALL_EXCLUDES_SAME |
@@ -571,7 +577,9 @@ static const struct sparc_pmu niagara2_pmu = {
 	.upper_shift	= 19,
 	.lower_shift	= 6,
 	.event_mask	= 0xfff,
-	.hv_bit		= 0x8,
+	.user_bit	= PCR_UTRACE,
+	.priv_bit	= PCR_STRACE,
+	.hv_bit		= PCR_N2_HTRACE,
 	.irq_bit	= 0x30,
 	.upper_nop	= 0x220,
 	.lower_nop	= 0x220,
@@ -771,7 +779,7 @@ static void sparc_pmu_disable(struct pmu *pmu)
 	cpuc->n_added = 0;
 
 	val = cpuc->pcr;
-	val &= ~(PCR_UTRACE | PCR_STRACE |
+	val &= ~(sparc_pmu->user_bit | sparc_pmu->priv_bit |
 		 sparc_pmu->hv_bit | sparc_pmu->irq_bit);
 	cpuc->pcr = val;
 
@@ -1177,9 +1185,9 @@ static int sparc_pmu_event_init(struct perf_event *event)
 	/* We save the enable bits in the config_base.  */
 	hwc->config_base = sparc_pmu->irq_bit;
 	if (!attr->exclude_user)
-		hwc->config_base |= PCR_UTRACE;
+		hwc->config_base |= sparc_pmu->user_bit;
 	if (!attr->exclude_kernel)
-		hwc->config_base |= PCR_STRACE;
+		hwc->config_base |= sparc_pmu->priv_bit;
 	if (!attr->exclude_hv)
 		hwc->config_base |= sparc_pmu->hv_bit;
 
-- 
1.7.10.4

