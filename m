From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:28:46 +0000
Subject: [PATCH 16/17] sparc64: Add SPARC-T4 perf event support.
Message-Id: <20120818.232846.492704451528628910.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |  189 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 6441592..1885370 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -53,8 +53,8 @@
  * normal code.
  */
 
-#define MAX_HWEVENTS			2
-#define MAX_PCRS			1
+#define MAX_HWEVENTS			4
+#define MAX_PCRS			4
 #define MAX_PERIOD			((1UL << 32) - 1)
 
 #define PIC_UPPER_INDEX			0
@@ -597,6 +597,187 @@ static const struct sparc_pmu niagara2_pmu = {
 	.num_pic_regs	= 1,
 };
 
+static const struct perf_event_map niagara4_perfmon_event_map[] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { (26 << 6) },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { (3 << 6) | 0x3f },
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { (3 << 6) | 0x04 },
+	[PERF_COUNT_HW_CACHE_MISSES] = { (16 << 6) | 0x07 },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { (4 << 6) | 0x01 },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { (25 << 6) | 0x0f },
+};
+
+static const struct perf_event_map *niagara4_event_map(int event_id)
+{
+	return &niagara4_perfmon_event_map[event_id];
+}
+
+static const cache_map_t niagara4_cache_map = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = { (3 << 6) | 0x04 },
+		[C(RESULT_MISS)] = { (16 << 6) | 0x07 },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = { (3 << 6) | 0x08 },
+		[C(RESULT_MISS)] = { (16 << 6) | 0x07 },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = { CACHE_OP_UNSUPPORTED },
+		[C(RESULT_MISS)] = { CACHE_OP_UNSUPPORTED },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = { (3 << 6) | 0x3f },
+		[C(RESULT_MISS)] = { (11 << 6) | 0x03 },
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_NONSENSE },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_NONSENSE },
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = { (3 << 6) | 0x04 },
+		[C(RESULT_MISS)] = { CACHE_OP_UNSUPPORTED },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = { (3 << 6) | 0x08 },
+		[C(RESULT_MISS)] = { CACHE_OP_UNSUPPORTED },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = { CACHE_OP_UNSUPPORTED },
+		[C(RESULT_MISS)] = { CACHE_OP_UNSUPPORTED },
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = { CACHE_OP_UNSUPPORTED },
+		[C(RESULT_MISS)] = { (17 << 6) | 0x3f },
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = { CACHE_OP_UNSUPPORTED },
+		[C(RESULT_MISS)] = { (6 << 6) | 0x3f },
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = { CACHE_OP_UNSUPPORTED },
+		[C(RESULT_MISS)] = { CACHE_OP_UNSUPPORTED },
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+},
+[C(NODE)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = { CACHE_OP_UNSUPPORTED },
+		[C(RESULT_MISS)  ] = { CACHE_OP_UNSUPPORTED },
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = { CACHE_OP_UNSUPPORTED },
+		[ C(RESULT_MISS)   ] = { CACHE_OP_UNSUPPORTED },
+	},
+},
+};
+
+static u32 sparc_vt_read_pmc(int idx)
+{
+	u64 val = pcr_ops->read_pic(idx);
+
+	return val & 0xffffffff;
+}
+
+static void sparc_vt_write_pmc(int idx, u64 val)
+{
+	u64 pcr;
+
+	/* There seems to be an internal latch on the overflow event
+	 * on SPARC-T4 that prevents it from triggering unless you
+	 * update the PIC exactly as we do here.  The requirement
+	 * seems to be that you have to turn off event counting in the
+	 * PCR around the PIC update.
+	 *
+	 * For example, after the following sequence:
+	 *
+	 * 1) set PIC to -1
+	 * 2) enable event counting and overflow reporting in PCR
+	 * 3) overflow triggers, softint 15 handler invoked
+	 * 4) clear OV bit in PCR
+	 * 5) write PIC to -1
+	 *
+	 * a subsequent overflow event will not trigger.  This
+	 * sequence works on SPARC-T3 and previous chips.
+	 */
+	pcr = pcr_ops->read_pcr(idx);
+	pcr_ops->write_pcr(idx, PCR_N4_PICNPT);
+
+	pcr_ops->write_pic(idx, val & 0xffffffff);
+
+	pcr_ops->write_pcr(idx, pcr);
+}
+
+static const struct sparc_pmu niagara4_pmu = {
+	.event_map	= niagara4_event_map,
+	.cache_map	= &niagara4_cache_map,
+	.max_events	= ARRAY_SIZE(niagara4_perfmon_event_map),
+	.read_pmc	= sparc_vt_read_pmc,
+	.write_pmc	= sparc_vt_write_pmc,
+	.upper_shift	= 5,
+	.lower_shift	= 5,
+	.event_mask	= 0x7ff,
+	.user_bit	= PCR_N4_UTRACE,
+	.priv_bit	= PCR_N4_STRACE,
+
+	/* We explicitly don't support hypervisor tracing.  The T4
+	 * generates the overflow event for precise events via a trap
+	 * which will not be generated (ie. it's completely lost) if
+	 * we happen to be in the hypervisor when the event triggers.
+	 * Essentially, the overflow event reporting is completely
+	 * unusable when you have hypervisor mode tracing enabled.
+	 */
+	.hv_bit		= 0,
+
+	.irq_bit	= PCR_N4_TOE,
+	.upper_nop	= 0,
+	.lower_nop	= 0,
+	.flags		= 0,
+	.max_hw_events	= 4,
+	.num_pcrs	= 4,
+	.num_pic_regs	= 4,
+};
+
 static const struct sparc_pmu *sparc_pmu __read_mostly;
 
 static u64 event_encoding(u64 event_id, int idx)
@@ -1465,6 +1646,10 @@ static bool __init supported_pmu(void)
 		sparc_pmu = &niagara2_pmu;
 		return true;
 	}
+	if (!strcmp(sparc_pmu_type, "niagara4")) {
+		sparc_pmu = &niagara4_pmu;
+		return true;
+	}
 	return false;
 }
 
-- 
1.7.10.4

