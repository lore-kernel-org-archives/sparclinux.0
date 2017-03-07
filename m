From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 07 Mar 2017 22:28:36 +0000
Subject: [PATCH v1 1/4] sparc64: initialize time early
Message-Id: <1488925719-647821-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In Linux it is possible to configure printk() to output timestamp next to
every line. This is very useful to determine the slow parts of the boot
process, and also to avoid regressions, as boot time is visiable to
everyone.

Also, there are scripts that change these time stamps to intervals.

However, on larger machines these timestamps start appearing many seconds,
and even minutes into the boot process. This patch gets stick-frequency
property early from OpenBoot, and uses its value to initialize time stamps
before the first printk() messages are printed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/kernel.h   |    3 ++
 arch/sparc/kernel/setup_64.c |    1 +
 arch/sparc/kernel/time_64.c  |   60 ++++++++++++++++++++++++++---------------
 3 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index c980455..275973b 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -53,6 +53,9 @@ static inline unsigned long kimage_addr_to_ra(const void *p)
 void do_signal32(struct pt_regs * regs);
 asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp);
 
+/* time_64.c */
+void __init time_init_early(void);
+
 /* compat_audit.c */
 extern unsigned int sparc32_dir_class[];
 extern unsigned int sparc32_chattr_class[];
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6b7331d..f20d394 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -365,6 +365,7 @@ void __init start_early_boot(void)
 	}
 	current_thread_info()->cpu = cpu;
 
+	time_init_early();
 	prom_init_report();
 	start_kernel();
 }
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 12a6d35..8334042 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -49,6 +49,7 @@
 #include <asm/irq_regs.h>
 
 #include "entry.h"
+#include "kernel.h"
 
 DEFINE_SPINLOCK(rtc_lock);
 
@@ -177,6 +178,8 @@ static unsigned long tick_add_tick(unsigned long adj)
 struct sparc64_tick_ops *tick_ops __read_mostly = &tick_operations;
 EXPORT_SYMBOL(tick_ops);
 
+static unsigned long stick_frequency;
+
 static void stick_disable_irq(void)
 {
 	__asm__ __volatile__(
@@ -583,30 +586,25 @@ static int __init clock_init(void)
 fs_initcall(clock_init);
 
 /* This is gets the master TICK_INT timer going. */
-static unsigned long sparc64_init_timers(void)
+static unsigned long sparc64_init_timers_spitfire(void)
 {
 	struct device_node *dp;
 	unsigned long freq;
+	unsigned long ver, manuf, impl;
 
 	dp = of_find_node_by_path("/");
-	if (tlb_type = spitfire) {
-		unsigned long ver, manuf, impl;
-
-		__asm__ __volatile__ ("rdpr %%ver, %0"
-				      : "=&r" (ver));
-		manuf = ((ver >> 48) & 0xffff);
-		impl = ((ver >> 32) & 0xffff);
-		if (manuf = 0x17 && impl = 0x13) {
-			/* Hummingbird, aka Ultra-IIe */
-			tick_ops = &hbtick_operations;
-			freq = of_getintprop_default(dp, "stick-frequency", 0);
-		} else {
-			tick_ops = &tick_operations;
-			freq = local_cpu_data().clock_tick;
-		}
-	} else {
-		tick_ops = &stick_operations;
+
+	__asm__ __volatile__ ("rdpr %%ver, %0"
+			      : "=&r" (ver));
+	manuf = ((ver >> 48) & 0xffff);
+	impl = ((ver >> 32) & 0xffff);
+	if (manuf = 0x17 && impl = 0x13) {
+		/* Hummingbird, aka Ultra-IIe */
+		tick_ops = &hbtick_operations;
 		freq = of_getintprop_default(dp, "stick-frequency", 0);
+	} else {
+		tick_ops = &tick_operations;
+		freq = local_cpu_data().clock_tick;
 	}
 
 	return freq;
@@ -775,14 +773,32 @@ static u64 clocksource_tick_read(struct clocksource *cs)
 	return tick_ops->get_tick();
 }
 
+void __init time_init_early(void)
+{
+	if (tlb_type = spitfire)
+		return;
+
+	stick_frequency = prom_getint(prom_root_node, "stick-frequency");
+	tick_ops = &stick_operations;
+	timer_ticks_per_nsec_quotient +		clocksource_hz2mult(stick_frequency,
+				    SPARC64_NSEC_PER_CYC_SHIFT);
+}
+
 void __init time_init(void)
 {
-	unsigned long freq = sparc64_init_timers();
+	unsigned long freq;
 
-	tb_ticks_per_usec = freq / USEC_PER_SEC;
+	if (tlb_type = spitfire) {
+		stick_frequency = sparc64_init_timers_spitfire();
 
-	timer_ticks_per_nsec_quotient -		clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
+		timer_ticks_per_nsec_quotient +			clocksource_hz2mult(stick_frequency,
+					    SPARC64_NSEC_PER_CYC_SHIFT);
+	}
+	freq = stick_frequency;
+
+	tb_ticks_per_usec = freq / USEC_PER_SEC;
 
 	clocksource_tick.name = tick_ops->name;
 	clocksource_tick.read = clocksource_tick_read;
-- 
1.7.1

