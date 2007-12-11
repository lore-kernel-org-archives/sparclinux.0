From: David Miller <davem@davemloft.net>
Date: Tue, 11 Dec 2007 14:19:44 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071211.061944.38159530.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 16 Nov 2007 22:17:07 +0100

> the v880 (4x US III) here was hit by a stuck process again, after
> running fine for some time now. But the machine didn't freeze, one CPU
> was running at 100%, but otherwise the machine was responsible.

In your dump all of the cpus seem to be alive and healthy, and
thus able to receive cpu messages, yet we are stuck on one cpu
in cheetah_xcall_deliver().

I suspect that the code in cheetah_xcall_deliver() can get into an
endless loop because of the way it interprets the dispatch status
register.

For example, if there are stray BUSY or NACK bits set in that register
for processors we are not trying to send a message to (for example,
from a previous message send) the logic can clear all the bits in the
cpu mask and then endlessly cycle in that function because no new
messages are sent and therefore no forward progress is made.  The
cycle repeats forever.

I shoule be easily fixed using the patch below.  It records which bits
we should actually be concerned about, and only tests those specific
bits in the dispatch status register.

Could you please give this patch a test?

Thanks.

diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 894b506..c399449 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -476,7 +476,7 @@ static inline void spitfire_xcall_deliver(u64 data0, u64 data1, u64 data2, cpuma
  */
 static void cheetah_xcall_deliver(u64 data0, u64 data1, u64 data2, cpumask_t mask)
 {
-	u64 pstate, ver;
+	u64 pstate, ver, busy_mask;
 	int nack_busy_id, is_jbus, need_more;
 
 	if (cpus_empty(mask))
@@ -508,14 +508,20 @@ retry:
 			       "i" (ASI_INTR_W));
 
 	nack_busy_id = 0;
+	busy_mask = 0;
 	{
 		int i;
 
 		for_each_cpu_mask(i, mask) {
 			u64 target = (i << 14) | 0x70;
 
-			if (!is_jbus)
+			if (is_jbus) {
+				busy_mask |= (0x1UL << (i * 2));
+			} else {
 				target |= (nack_busy_id << 24);
+				busy_mask |= (0x1UL <<
+					      (nack_busy_id * 2));
+			}
 			__asm__ __volatile__(
 				"stxa	%%g0, [%0] %1\n\t"
 				"membar	#Sync\n\t"
@@ -531,15 +537,16 @@ retry:
 
 	/* Now, poll for completion. */
 	{
-		u64 dispatch_stat;
+		u64 dispatch_stat, nack_mask;
 		long stuck;
 
 		stuck = 100000 * nack_busy_id;
+		nack_mask = busy_mask << 1;
 		do {
 			__asm__ __volatile__("ldxa	[%%g0] %1, %0"
 					     : "=r" (dispatch_stat)
 					     : "i" (ASI_INTR_DISPATCH_STAT));
-			if (dispatch_stat = 0UL) {
+			if (!(dispatch_stat & (busy_mask | nack_mask))) {
 				__asm__ __volatile__("wrpr %0, 0x0, %%pstate"
 						     : : "r" (pstate));
 				if (unlikely(need_more)) {
@@ -556,12 +563,12 @@ retry:
 			}
 			if (!--stuck)
 				break;
-		} while (dispatch_stat & 0x5555555555555555UL);
+		} while (dispatch_stat & busy_mask);
 
 		__asm__ __volatile__("wrpr %0, 0x0, %%pstate"
 				     : : "r" (pstate));
 
-		if ((dispatch_stat & ~(0x5555555555555555UL)) = 0) {
+		if (dispatch_stat & busy_mask) {
 			/* Busy bits will not clear, continue instead
 			 * of freezing up on this cpu.
 			 */
