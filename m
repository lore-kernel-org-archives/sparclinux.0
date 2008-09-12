From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:48:08 +0000
Subject: [PATCH 6/16]: sparc64: Fix sparse warnings in kernel/time.c
Message-Id: <20080912.144808.235398821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in kernel/time.c

1) Using "clock" as a local variable shadows a global variable of
   the same name declared in linux/clocksource.h

2) rtc_cmos_resource should be static

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/time.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 8d2ca04..80d71a5 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -409,7 +409,7 @@ int update_persistent_clock(struct timespec now)
 unsigned long cmos_regs;
 EXPORT_SYMBOL(cmos_regs);
 
-struct resource rtc_cmos_resource;
+static struct resource rtc_cmos_resource;
 
 static struct platform_device rtc_cmos_device = {
 	.name		= "rtc_cmos",
@@ -621,7 +621,7 @@ fs_initcall(clock_init);
 static unsigned long sparc64_init_timers(void)
 {
 	struct device_node *dp;
-	unsigned long clock;
+	unsigned long freq;
 
 	dp = of_find_node_by_path("/");
 	if (tlb_type = spitfire) {
@@ -634,17 +634,17 @@ static unsigned long sparc64_init_timers(void)
 		if (manuf = 0x17 && impl = 0x13) {
 			/* Hummingbird, aka Ultra-IIe */
 			tick_ops = &hbtick_operations;
-			clock = of_getintprop_default(dp, "stick-frequency", 0);
+			freq = of_getintprop_default(dp, "stick-frequency", 0);
 		} else {
 			tick_ops = &tick_operations;
-			clock = local_cpu_data().clock_tick;
+			freq = local_cpu_data().clock_tick;
 		}
 	} else {
 		tick_ops = &stick_operations;
-		clock = of_getintprop_default(dp, "stick-frequency", 0);
+		freq = of_getintprop_default(dp, "stick-frequency", 0);
 	}
 
-	return clock;
+	return freq;
 }
 
 struct freq_table {
@@ -836,16 +836,16 @@ EXPORT_SYMBOL(udelay);
 
 void __init time_init(void)
 {
-	unsigned long clock = sparc64_init_timers();
+	unsigned long freq = sparc64_init_timers();
 
-	tb_ticks_per_usec = clock / USEC_PER_SEC;
+	tb_ticks_per_usec = freq / USEC_PER_SEC;
 
 	timer_ticks_per_nsec_quotient -		clocksource_hz2mult(clock, SPARC64_NSEC_PER_CYC_SHIFT);
+		clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
 
 	clocksource_tick.name = tick_ops->name;
 	clocksource_tick.mult -		clocksource_hz2mult(clock,
+		clocksource_hz2mult(freq,
 				    clocksource_tick.shift);
 	clocksource_tick.read = tick_ops->get_tick;
 
@@ -856,7 +856,7 @@ void __init time_init(void)
 
 	sparc64_clockevent.name = tick_ops->name;
 
-	setup_clockevent_multiplier(clock);
+	setup_clockevent_multiplier(freq);
 
 	sparc64_clockevent.max_delta_ns  		clockevent_delta2ns(0x7fffffffffffffffUL, &sparc64_clockevent);
-- 
1.5.6.5.GIT

