From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 20:41:42 +0000
Subject: [v3 2/8] sparc64: access tick function from variable
Message-Id: <1497300108-158125-3-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In timer_64.c tick functions are access via pointer (tick_ops), every time
clock is read, there is one extra load to get to the function.

This patch optimizes it, by accessing functions pointer from value.

Current ched_clock():
sethi  %hi(0xb9b400), %g1
ldx  [ %g1 + 0x250 ], %g1  ! <tick_ops>
ldx  [ %g1 ], %g1
call  %g1
nop
sethi  %hi(0xb9b400), %g1
ldx  [ %g1 + 0x300 ], %g1  ! <timer_ticks_per_nsec_quotient>
mulx  %o0, %g1, %g1
rett  %i7 + 8
srlx  %g1, 0xa, %o0

New sched_clock():
sethi  %hi(0xb9b400), %g1
ldx  [ %g1 + 0x340 ], %g1
call  %g1
nop
sethi  %hi(0xb9b400), %g1
ldx  [ %g1 + 0x378 ], %g1
mulx  %o0, %g1, %g1
rett  %i7 + 8
srlx  %g1, 0xa, %o0

Before three loads, now two loads.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/kernel/time_64.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 98d05de..6724bcb 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -585,6 +585,7 @@ static int __init clock_init(void)
 /* This is gets the master TICK_INT timer going. */
 static unsigned long sparc64_init_timers(void)
 {
+	struct sparc64_tick_ops *ops = NULL;
 	struct device_node *dp;
 	unsigned long freq;
 
@@ -598,16 +599,17 @@ static unsigned long sparc64_init_timers(void)
 		impl = ((ver >> 32) & 0xffff);
 		if (manuf = 0x17 && impl = 0x13) {
 			/* Hummingbird, aka Ultra-IIe */
-			tick_ops = &hbtick_operations;
+			ops = &hbtick_operations;
 			freq = of_getintprop_default(dp, "stick-frequency", 0);
 		} else {
-			tick_ops = &tick_operations;
 			freq = local_cpu_data().clock_tick;
 		}
 	} else {
-		tick_ops = &stick_operations;
+		ops = &stick_operations;
 		freq = of_getintprop_default(dp, "stick-frequency", 0);
 	}
+	if (ops)
+		memcpy(&tick_operations, ops, sizeof(struct sparc64_tick_ops));
 
 	return freq;
 }
@@ -671,12 +673,12 @@ static int __init register_sparc64_cpufreq_notifier(void)
 static int sparc64_next_event(unsigned long delta,
 			      struct clock_event_device *evt)
 {
-	return tick_ops->add_compare(delta) ? -ETIME : 0;
+	return tick_operations.add_compare(delta) ? -ETIME : 0;
 }
 
 static int sparc64_timer_shutdown(struct clock_event_device *evt)
 {
-	tick_ops->disable_irq();
+	tick_operations.disable_irq();
 	return 0;
 }
 
@@ -693,7 +695,7 @@ static int sparc64_timer_shutdown(struct clock_event_device *evt)
 void __irq_entry timer_interrupt(int irq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned long tick_mask = tick_ops->softint_mask;
+	unsigned long tick_mask = tick_operations.softint_mask;
 	int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(sparc64_events, cpu);
 
@@ -728,7 +730,7 @@ void setup_sparc64_timer(void)
 			     : "=r" (pstate)
 			     : "i" (PSTATE_IE));
 
-	tick_ops->init_tick();
+	tick_operations.init_tick();
 
 	/* Restore PSTATE_IE. */
 	__asm__ __volatile__("wrpr	%0, 0x0, %%pstate"
@@ -757,9 +759,9 @@ void __delay(unsigned long loops)
 {
 	unsigned long bclock, now;
 
-	bclock = tick_ops->get_tick();
+	bclock = tick_operations.get_tick();
 	do {
-		now = tick_ops->get_tick();
+		now = tick_operations.get_tick();
 	} while ((now-bclock) < loops);
 }
 EXPORT_SYMBOL(__delay);
@@ -772,7 +774,7 @@ void udelay(unsigned long usecs)
 
 static u64 clocksource_tick_read(struct clocksource *cs)
 {
-	return tick_ops->get_tick();
+	return tick_operations.get_tick();
 }
 
 void __init time_init(void)
@@ -784,14 +786,14 @@ void __init time_init(void)
 	timer_ticks_per_nsec_quotient  		clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
 
-	clocksource_tick.name = tick_ops->name;
+	clocksource_tick.name = tick_operations.name;
 	clocksource_tick.read = clocksource_tick_read;
 
 	clocksource_register_hz(&clocksource_tick, freq);
 	printk("clocksource: mult[%x] shift[%d]\n",
 	       clocksource_tick.mult, clocksource_tick.shift);
 
-	sparc64_clockevent.name = tick_ops->name;
+	sparc64_clockevent.name = tick_operations.name;
 	clockevents_calc_mult_shift(&sparc64_clockevent, freq, 4);
 
 	sparc64_clockevent.max_delta_ns @@ -809,7 +811,7 @@ void __init time_init(void)
 
 unsigned long long sched_clock(void)
 {
-	unsigned long ticks = tick_ops->get_tick();
+	unsigned long ticks = tick_operations.get_tick();
 
 	return (ticks * timer_ticks_per_nsec_quotient)
 		>> SPARC64_NSEC_PER_CYC_SHIFT;
@@ -817,6 +819,6 @@ unsigned long long sched_clock(void)
 
 int read_current_timer(unsigned long *timer_val)
 {
-	*timer_val = tick_ops->get_tick();
+	*timer_val = tick_operations.get_tick();
 	return 0;
 }
-- 
1.7.1

