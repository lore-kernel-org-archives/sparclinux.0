From: David Miller <davem@davemloft.net>
Date: Tue, 16 Oct 2012 20:16:36 +0000
Subject: [PATCH 3/3] sparc64: Fix bit twiddling in sparc_pmu_enable_event().
Message-Id: <20121016.161636.1501221544995056693.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


There was a serious disconnect in the logic happening in
sparc_pmu_disable_event() vs. sparc_pmu_enable_event().

Event disable is implemented by programming a NOP event into the PCR.

However, event enable was not reversing this operation.  Instead, it
was setting the User/Priv/Hypervisor trace enable bits.

That's not sparc_pmu_enable_event()'s job, that's what
sparc_pmu_enable() and sparc_pmu_disable() do .

The intent of sparc_pmu_enable_event() is clear, since it first clear
out the event type encoding field.  So fix this by OR'ing in the event
encoding rather than the trace enable bits.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 9e96f84..885a8af 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -817,15 +817,17 @@ static u64 nop_for_index(int idx)
 
 static inline void sparc_pmu_enable_event(struct cpu_hw_events *cpuc, struct hw_perf_event *hwc, int idx)
 {
-	u64 val, mask = mask_for_index(idx);
+	u64 enc, val, mask = mask_for_index(idx);
 	int pcr_index = 0;
 
 	if (sparc_pmu->num_pcrs > 1)
 		pcr_index = idx;
 
+	enc = perf_event_get_enc(cpuc->events[idx]);
+
 	val = cpuc->pcr[pcr_index];
 	val &= ~mask;
-	val |= hwc->config;
+	val |= event_encoding(enc, idx);
 	cpuc->pcr[pcr_index] = val;
 
 	pcr_ops->write_pcr(pcr_index, cpuc->pcr[pcr_index]);
-- 
1.7.12.2.dirty

