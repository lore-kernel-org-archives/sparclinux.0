From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 16:48:27 +0000
Subject: [v2 8/8] sparc64: optimize functions that access tick
Message-Id: <1497286107-974183-9-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Replace read tick function pointers with the new hot-patched get_tick().
This optimizes the performance of functions such as: sched_clock()

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/kernel/time_64.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 5fe595a..4a0bd18 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -752,12 +752,10 @@ void setup_sparc64_timer(void)
 
 void __delay(unsigned long loops)
 {
-	unsigned long bclock, now;
+	unsigned long bclock = get_tick();
 
-	bclock = tick_operations.get_tick();
-	do {
-		now = tick_operations.get_tick();
-	} while ((now-bclock) < loops);
+	while ((get_tick() - bclock) < loops)
+		;
 }
 EXPORT_SYMBOL(__delay);
 
@@ -769,7 +767,7 @@ void udelay(unsigned long usecs)
 
 static u64 clocksource_tick_read(struct clocksource *cs)
 {
-	return tick_operations.get_tick();
+	return get_tick();
 }
 
 static void __init get_tick_patch(void)
@@ -853,13 +851,19 @@ unsigned long long sched_clock(void)
 {
 	unsigned long quotient = tick_operations.ticks_per_nsec_quotient;
 	unsigned long offset = tick_operations.offset;
-	unsigned long ticks = tick_operations.get_tick();
 
-	return ((ticks * quotient) >> SPARC64_NSEC_PER_CYC_SHIFT) - offset;
+	/* Use wmb so the compiler emits the loads first and overlaps load
+	 * latency with reading tick, because reading %tick/%stick is a
+	 * post-sync instruction that will flush and restart subsequent
+	 * instructions after it commits.
+	 */
+	wmb();
+
+	return ((get_tick() * quotient) >> SPARC64_NSEC_PER_CYC_SHIFT) - offset;
 }
 
 int read_current_timer(unsigned long *timer_val)
 {
-	*timer_val = tick_operations.get_tick();
+	*timer_val = get_tick();
 	return 0;
 }
-- 
1.7.1

