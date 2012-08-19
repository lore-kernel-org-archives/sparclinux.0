From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:21 +0000
Subject: [PATCH 10/17] sparc64: Abstract PMC read/write behind sparc_pmu.
Message-Id: <20120818.232821.1918122564367972667.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |   68 ++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index f7b9ae3..fbd8029 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -141,6 +141,8 @@ struct sparc_pmu {
 	const struct perf_event_map	*(*event_map)(int);
 	const cache_map_t		*cache_map;
 	int				max_events;
+	u32				(*read_pmc)(int);
+	void				(*write_pmc)(int, u64);
 	int				upper_shift;
 	int				lower_shift;
 	int				event_mask;
@@ -154,6 +156,34 @@ struct sparc_pmu {
 	int				max_hw_events;
 };
 
+static u32 sparc_default_read_pmc(int idx)
+{
+	u64 val;
+
+	val = pcr_ops->read_pic(0);
+	if (idx = PIC_UPPER_INDEX)
+		val >>= 32;
+
+	return val & 0xffffffff;
+}
+
+static void sparc_default_write_pmc(int idx, u64 val)
+{
+	u64 shift, mask, pic;
+
+	shift = 0;
+	if (idx = PIC_UPPER_INDEX)
+		shift = 32;
+
+	mask = ((u64) 0xffffffff) << shift;
+	val <<= shift;
+
+	pic = pcr_ops->read_pic(0);
+	pic &= ~mask;
+	pic |= val;
+	pcr_ops->write_pic(0, pic);
+}
+
 static const struct perf_event_map ultra3_perfmon_event_map[] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = { 0x0000, PIC_UPPER | PIC_LOWER },
 	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x0001, PIC_UPPER | PIC_LOWER },
@@ -271,6 +301,8 @@ static const struct sparc_pmu ultra3_pmu = {
 	.event_map	= ultra3_event_map,
 	.cache_map	= &ultra3_cache_map,
 	.max_events	= ARRAY_SIZE(ultra3_perfmon_event_map),
+	.read_pmc	= sparc_default_read_pmc,
+	.write_pmc	= sparc_default_write_pmc,
 	.upper_shift	= 11,
 	.lower_shift	= 4,
 	.event_mask	= 0x3f,
@@ -403,6 +435,8 @@ static const struct sparc_pmu niagara1_pmu = {
 	.event_map	= niagara1_event_map,
 	.cache_map	= &niagara1_cache_map,
 	.max_events	= ARRAY_SIZE(niagara1_perfmon_event_map),
+	.read_pmc	= sparc_default_read_pmc,
+	.write_pmc	= sparc_default_write_pmc,
 	.upper_shift	= 0,
 	.lower_shift	= 4,
 	.event_mask	= 0x7,
@@ -532,6 +566,8 @@ static const struct sparc_pmu niagara2_pmu = {
 	.event_map	= niagara2_event_map,
 	.cache_map	= &niagara2_cache_map,
 	.max_events	= ARRAY_SIZE(niagara2_perfmon_event_map),
+	.read_pmc	= sparc_default_read_pmc,
+	.write_pmc	= sparc_default_write_pmc,
 	.upper_shift	= 19,
 	.lower_shift	= 6,
 	.event_mask	= 0xfff,
@@ -593,34 +629,6 @@ static inline void sparc_pmu_disable_event(struct cpu_hw_events *cpuc, struct hw
 	pcr_ops->write_pcr(0, cpuc->pcr);
 }
 
-static u32 read_pmc(int idx)
-{
-	u64 val;
-
-	val = pcr_ops->read_pic(0);
-	if (idx = PIC_UPPER_INDEX)
-		val >>= 32;
-
-	return val & 0xffffffff;
-}
-
-static void write_pmc(int idx, u64 val)
-{
-	u64 shift, mask, pic;
-
-	shift = 0;
-	if (idx = PIC_UPPER_INDEX)
-		shift = 32;
-
-	mask = ((u64) 0xffffffff) << shift;
-	val <<= shift;
-
-	pic = pcr_ops->read_pic(0);
-	pic &= ~mask;
-	pic |= val;
-	pcr_ops->write_pic(0, pic);
-}
-
 static u64 sparc_perf_event_update(struct perf_event *event,
 				   struct hw_perf_event *hwc, int idx)
 {
@@ -630,7 +638,7 @@ static u64 sparc_perf_event_update(struct perf_event *event,
 
 again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	new_raw_count = read_pmc(idx);
+	new_raw_count = sparc_pmu->read_pmc(idx);
 
 	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
 			     new_raw_count) != prev_raw_count)
@@ -670,7 +678,7 @@ static int sparc_perf_event_set_period(struct perf_event *event,
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	write_pmc(idx, (u64)(-left) & 0xffffffff);
+	sparc_pmu->write_pmc(idx, (u64)(-left) & 0xffffffff);
 
 	perf_event_update_userpage(event);
 
-- 
1.7.10.4

