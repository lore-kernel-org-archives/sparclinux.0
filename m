From: David Miller <davem@davemloft.net>
Date: Tue, 21 Apr 2015 20:15:45 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <20150421.161545.1637323746907705825.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Mon, 13 Apr 2015 11:53:03 -0600

> T7-4 showed no problems with the patch that was accepted. Through
> several 'perf record -- make -j 1024' sessions (make clean in between)
> and with a perf-top running in a separate window for a long period of
> time, all sessions continued to see samples.
> 
> I changed the T4 write_pmc handler to use the m7 variant:
> 
> +static void sparc_m7_write_pmc(int idx, u64 val);
 ...
> and a T4-1 showed no problems either (-j 64 for this one).

Ok, I'm convinced, and just pushed the following into my tree.

Thanks.

==========
[PATCH] sparc64: Use M7 PMC write on all chips T4 and onward.

They both work equally well, and the M7 implementation is
simpler and cheaper (less register writes).

With help from David Ahern.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 86eebfa..59cf917 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -737,25 +737,9 @@ static void sparc_vt_write_pmc(int idx, u64 val)
 {
 	u64 pcr;
 
-	/* There seems to be an internal latch on the overflow event
-	 * on SPARC-T4 that prevents it from triggering unless you
-	 * update the PIC exactly as we do here.  The requirement
-	 * seems to be that you have to turn off event counting in the
-	 * PCR around the PIC update.
-	 *
-	 * For example, after the following sequence:
-	 *
-	 * 1) set PIC to -1
-	 * 2) enable event counting and overflow reporting in PCR
-	 * 3) overflow triggers, softint 15 handler invoked
-	 * 4) clear OV bit in PCR
-	 * 5) write PIC to -1
-	 *
-	 * a subsequent overflow event will not trigger.  This
-	 * sequence works on SPARC-T3 and previous chips.
-	 */
 	pcr = pcr_ops->read_pcr(idx);
-	pcr_ops->write_pcr(idx, PCR_N4_PICNPT);
+	/* ensure ov and ntc are reset */
+	pcr &= ~(PCR_N4_OV | PCR_N4_NTC);
 
 	pcr_ops->write_pic(idx, val & 0xffffffff);
 
@@ -792,25 +776,12 @@ static const struct sparc_pmu niagara4_pmu = {
 	.num_pic_regs	= 4,
 };
 
-static void sparc_m7_write_pmc(int idx, u64 val)
-{
-	u64 pcr;
-
-	pcr = pcr_ops->read_pcr(idx);
-	/* ensure ov and ntc are reset */
-	pcr &= ~(PCR_N4_OV | PCR_N4_NTC);
-
-	pcr_ops->write_pic(idx, val & 0xffffffff);
-
-	pcr_ops->write_pcr(idx, pcr);
-}
-
 static const struct sparc_pmu sparc_m7_pmu = {
 	.event_map	= niagara4_event_map,
 	.cache_map	= &niagara4_cache_map,
 	.max_events	= ARRAY_SIZE(niagara4_perfmon_event_map),
 	.read_pmc	= sparc_vt_read_pmc,
-	.write_pmc	= sparc_m7_write_pmc,
+	.write_pmc	= sparc_vt_write_pmc,
 	.upper_shift	= 5,
 	.lower_shift	= 5,
 	.event_mask	= 0x7ff,
-- 
2.1.2.532.g19b5d50

