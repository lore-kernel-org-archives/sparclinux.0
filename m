From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 16:48:23 +0000
Subject: [v2 4/8] sparc64: optimize loads in clock_sched()
Message-Id: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In clock sched we now have three loads:
	- Function pointer
	- quotient for multiplication
	- offset

However, it is possible to improve performance substantially, by
guaranteeing that all three loads are from the same cacheline.

By moving these three values first in sparc64_tick_ops, and by having
tick_operations 64-byte aligned we guarantee this.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/include/asm/timer_64.h |    5 +++++
 arch/sparc/kernel/time_64.c       |   17 +++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index fce4150..bde2cc4 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -9,7 +9,12 @@
 #include <linux/types.h>
 #include <linux/init.h>
 
+/* The most frequently accessed fields should be first,
+ * to fit into the same cacheline.
+ */
 struct sparc64_tick_ops {
+	unsigned long ticks_per_nsec_quotient;
+	unsigned long offset;
 	unsigned long long (*get_tick)(void);
 	int (*add_compare)(unsigned long);
 	unsigned long softint_mask;
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 5f53b74..d654f5c 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -164,7 +164,7 @@ static unsigned long tick_add_tick(unsigned long adj)
 	return new_tick;
 }
 
-static struct sparc64_tick_ops tick_operations __read_mostly = {
+static struct sparc64_tick_ops tick_operations __aligned(64) __read_mostly = {
 	.name		=	"tick",
 	.init_tick	=	tick_init_tick,
 	.disable_irq	=	tick_disable_irq,
@@ -391,9 +391,6 @@ static int hbtick_add_compare(unsigned long adj)
 	.softint_mask	=	1UL << 0,
 };
 
-static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
-static unsigned long timer_offset __read_mostly;
-
 unsigned long cmos_regs;
 EXPORT_SYMBOL(cmos_regs);
 
@@ -784,11 +781,11 @@ void __init time_init(void)
 
 	tb_ticks_per_usec = freq / USEC_PER_SEC;
 
-	timer_ticks_per_nsec_quotient +	tick_operations.ticks_per_nsec_quotient  		clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
 
-	timer_offset = (tick_operations.get_tick()
-			* timer_ticks_per_nsec_quotient)
+	tick_operations.offset = (tick_operations.get_tick()
+			* tick_operations.ticks_per_nsec_quotient)
 			>> SPARC64_NSEC_PER_CYC_SHIFT;
 
 	clocksource_tick.name = tick_operations.name;
@@ -816,11 +813,11 @@ void __init time_init(void)
 
 unsigned long long sched_clock(void)
 {
+	unsigned long quotient = tick_operations.ticks_per_nsec_quotient;
+	unsigned long offset = tick_operations.offset;
 	unsigned long ticks = tick_operations.get_tick();
 
-	return ((ticks * timer_ticks_per_nsec_quotient)
-		>> SPARC64_NSEC_PER_CYC_SHIFT)
-		- timer_offset;
+	return ((ticks * quotient) >> SPARC64_NSEC_PER_CYC_SHIFT) - offset;
 }
 
 int read_current_timer(unsigned long *timer_val)
-- 
1.7.1

