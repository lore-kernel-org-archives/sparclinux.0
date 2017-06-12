From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 20:41:46 +0000
Subject: [v3 6/8] sparc64: initialize time early
Message-Id: <1497300108-158125-7-git-send-email-pasha.tatashin@oracle.com>
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
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/kernel/kernel.h   |    3 +++
 arch/sparc/kernel/setup_64.c |    1 +
 arch/sparc/kernel/time_64.c  |   21 ++++++++-------------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 6ae1e77..b625db4 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -52,6 +52,9 @@ static inline unsigned long kimage_addr_to_ra(const void *p)
 void do_signal32(struct pt_regs * regs);
 asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp);
 
+/* time_64.c */
+void __init time_init_early(void);
+
 /* compat_audit.c */
 extern unsigned int sparc32_dir_class[];
 extern unsigned int sparc32_chattr_class[];
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 4a85f92..4d9c3e1 100644
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
index 3bd9e49..d149276 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -49,6 +49,7 @@
 #include <asm/irq_regs.h>
 
 #include "entry.h"
+#include "kernel.h"
 
 DEFINE_SPINLOCK(rtc_lock);
 
@@ -258,9 +259,7 @@ static int stick_add_compare(unsigned long adj)
 
 static unsigned long stick_get_frequency(void)
 {
-	struct device_node *dp = of_find_node_by_path("/");
-
-	return of_getintprop_default(dp, "stick-frequency", 0);
+	return prom_getint(prom_root_node, "stick-frequency");
 }
 
 static struct sparc64_tick_ops stick_operations __read_mostly = {
@@ -792,10 +791,8 @@ static void init_tick_ops(struct sparc64_tick_ops *ops)
 	tick_operations = *ops;
 }
 
-void __init time_init(void)
+void __init time_init_early(void)
 {
-	unsigned long freq;
-
 	if (tlb_type = spitfire) {
 		if (is_hummingbird())
 			init_tick_ops(&hbtick_operations);
@@ -804,17 +801,15 @@ void __init time_init(void)
 	} else {
 		init_tick_ops(&stick_operations);
 	}
+}
+
+void __init time_init(void)
+{
+	unsigned long freq;
 
 	freq = tick_operations.frequency;
 	tb_ticks_per_usec = freq / USEC_PER_SEC;
 
-	tick_operations.ticks_per_nsec_quotient -		clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
-
-	tick_operations.offset = (tick_operations.get_tick()
-			* tick_operations.ticks_per_nsec_quotient)
-			>> SPARC64_NSEC_PER_CYC_SHIFT;
-
 	clocksource_tick.name = tick_operations.name;
 	clocksource_tick.read = clocksource_tick_read;
 
-- 
1.7.1

