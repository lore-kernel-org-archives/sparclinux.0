From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Apr 2012 15:23:40 +0000
Subject: [RFC PATCH 1/2] sparc32: rename sparc_irq_config to sparc_config
Message-Id: <20120404152340.GA4884@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From e12a1c767cf41a9dbeaf333e71b437731b20c0c8 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Apr 2012 13:21:13 +0200
Subject: [PATCH] sparc32: rename sparc_irq_config to sparc_config

This struct holds platform specific config and is thus not
limited to irq stuff.
Do not let the name confuse us to think this is irq only.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq.h          |    6 +++---
 arch/sparc/kernel/irq_32.c       |    2 +-
 arch/sparc/kernel/leon_kernel.c  |    4 ++--
 arch/sparc/kernel/of_device_32.c |    4 ++--
 arch/sparc/kernel/pcic.c         |    2 +-
 arch/sparc/kernel/sun4c_irq.c    |    4 ++--
 arch/sparc/kernel/sun4d_irq.c    |    4 ++--
 arch/sparc/kernel/sun4m_irq.c    |    4 ++--
 arch/sparc/kernel/time_32.c      |    2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 5a021dd..3f6ca4d 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -42,16 +42,16 @@ extern struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 extern struct sun4m_irq_global __iomem *sun4m_irq_global;
 
 /*
- * Platform specific irq configuration
+ * Platform specific configuration
  * The individual platforms assign their platform
  * specifics in their init functions.
  */
-struct sparc_irq_config {
+struct sparc_config {
 	void (*init_timers)(irq_handler_t);
 	unsigned int (*build_device_irq)(struct platform_device *op,
 	                                 unsigned int real_irq);
 };
-extern struct sparc_irq_config sparc_irq_config;
+extern struct sparc_config sparc_config;
 
 unsigned int irq_alloc(unsigned int real_irq, unsigned int pil);
 void irq_link(unsigned int irq);
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index b2668af..4a2b801 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -32,7 +32,7 @@
 #endif /* SMP */
 
 /* platform specific irq setup */
-struct sparc_irq_config sparc_irq_config;
+struct sparc_config sparc_config;
 
 unsigned long arch_local_irq_save(void)
 {
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 35e4367..a94122b 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -494,8 +494,8 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
 
 void __init leon_init_IRQ(void)
 {
-	sparc_irq_config.init_timers      = leon_init_timers;
-	sparc_irq_config.build_device_irq = _leon_build_device_irq;
+	sparc_config.init_timers      = leon_init_timers;
+	sparc_config.build_device_irq = _leon_build_device_irq;
 
 	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq,
 			BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4ee8ce0..185aa96 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -356,7 +356,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		op->archdata.num_irqs = len / sizeof(struct linux_prom_irqs);
 		for (i = 0; i < op->archdata.num_irqs; i++)
 			op->archdata.irqs[i] -			    sparc_irq_config.build_device_irq(op, intr[i].pri);
+			    sparc_config.build_device_irq(op, intr[i].pri);
 	} else {
 		const unsigned int *irq  			of_get_property(dp, "interrupts", &len);
@@ -365,7 +365,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 			op->archdata.num_irqs = len / sizeof(unsigned int);
 			for (i = 0; i < op->archdata.num_irqs; i++)
 				op->archdata.irqs[i] -				    sparc_irq_config.build_device_irq(op, irq[i]);
+				    sparc_config.build_device_irq(op, irq[i]);
 		} else {
 			op->archdata.num_irqs = 0;
 		}
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index fcc148e..6edec80 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -875,7 +875,7 @@ static void pcic_load_profile_irq(int cpu, unsigned int limit)
 
 void __init sun4m_pci_init_IRQ(void)
 {
-	sparc_irq_config.build_device_irq = pcic_build_device_irq;
+	sparc_config.build_device_irq = pcic_build_device_irq;
 
 	BTFIXUPSET_CALL(clear_clock_irq, pcic_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, pcic_load_profile_irq, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index f6bf25a..d4e3c83 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -251,8 +251,8 @@ void __init sun4c_init_IRQ(void)
 	BTFIXUPSET_CALL(clear_clock_irq, sun4c_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4c_load_profile_irq, BTFIXUPCALL_NOP);
 
-	sparc_irq_config.init_timers      = sun4c_init_timers;
-	sparc_irq_config.build_device_irq = sun4c_build_device_irq;
+	sparc_config.init_timers      = sun4c_init_timers;
+	sparc_config.build_device_irq = sun4c_build_device_irq;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 1d13c5b..30119f6 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -512,8 +512,8 @@ void __init sun4d_init_IRQ(void)
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NORM);
 
-	sparc_irq_config.init_timers      = sun4d_init_timers;
-	sparc_irq_config.build_device_irq = sun4d_build_device_irq;
+	sparc_config.init_timers      = sun4d_init_timers;
+	sparc_config.build_device_irq = sun4d_build_device_irq;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index e611651..0d3a2d8 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -478,8 +478,8 @@ void __init sun4m_init_IRQ(void)
 	BTFIXUPSET_CALL(clear_clock_irq, sun4m_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4m_load_profile_irq, BTFIXUPCALL_NORM);
 
-	sparc_irq_config.init_timers = sun4m_init_timers;
-	sparc_irq_config.build_device_irq = sun4m_build_device_irq;
+	sparc_config.init_timers = sun4m_init_timers;
+	sparc_config.build_device_irq = sun4m_build_device_irq;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 7d0c088..68e0284 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -222,7 +222,7 @@ static void __init sbus_time_init(void)
 
 	btfixup();
 
-	sparc_irq_config.init_timers(timer_interrupt);
+	sparc_config.init_timers(timer_interrupt);
 }
 
 void __init time_init(void)
-- 
1.6.0.6

