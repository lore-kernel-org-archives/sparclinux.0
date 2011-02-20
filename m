From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Feb 2011 20:39:57 +0000
Subject: [PATCH 2/5] sparc32: introduce sparc_irq_config
Message-Id: <1298234400-22378-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc_irq_config is used to hold the platform specific irq setup.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq.h         |   17 +++++++++++------
 arch/sparc/kernel/irq_32.c      |   10 +++-------
 arch/sparc/kernel/leon_kernel.c |    2 +-
 arch/sparc/kernel/sun4c_irq.c   |    4 +++-
 arch/sparc/kernel/sun4d_irq.c   |    4 +++-
 arch/sparc/kernel/sun4m_irq.c   |    4 +++-
 arch/sparc/kernel/time_32.c     |    2 +-
 7 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index db75138..4b4e54f 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -1,5 +1,16 @@
 #include <asm/btfixup.h>
 
+/*
+ * Platform specific irq configuration
+ * The individual platforms assign their platform
+ * specifics in their init functions.
+ */
+struct sparc_irq_config {
+	void (*init_timers)(irq_handler_t);
+};
+extern struct sparc_irq_config sparc_irq_config;
+
+
 /* Dave Redman (djhr@tadpole.co.uk)
  * changed these to function pointers.. it saves cycles and will allow
  * the irq dependencies to be split into different files at a later date
@@ -45,12 +56,6 @@ static inline void load_profile_irq(int cpu, int limit)
 	BTFIXUP_CALL(load_profile_irq)(cpu, limit);
 }
 
-extern void (*sparc_init_timers)(irq_handler_t lvl10_irq);
-
-extern void claim_ticker14(irq_handler_t irq_handler,
-			   int irq,
-			   unsigned int timeout);
-
 #ifdef CONFIG_SMP
 BTFIXUPDEF_CALL(void, set_cpu_int, int, int)
 BTFIXUPDEF_CALL(void, clear_cpu_int, int, int)
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 93afee0..b80b8bf 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -29,6 +29,9 @@
 #define SMP_NOP3
 #endif /* SMP */
 
+/* platform specific irq setup */
+struct sparc_irq_config sparc_irq_config;
+
 unsigned long arch_local_irq_save(void)
 {
 	unsigned long retval;
@@ -100,14 +103,7 @@ EXPORT_SYMBOL(arch_local_irq_restore);
  *
  */
 
-static void irq_panic(void)
-{
-	prom_printf("machine: %s doesn't have irq handlers defined!\n",
-		    &cputypval[0]);
-	prom_halt();
-}
 
-void (*sparc_init_timers)(irq_handler_t) = (void (*)(irq_handler_t))irq_panic;
 
 /*
  * Dave Redman (djhr@tadpole.co.uk)
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 2f8a9a2..2969f77 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -347,7 +347,7 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
 
 void __init leon_init_IRQ(void)
 {
-	sparc_init_timers = leon_init_timers;
+	sparc_irq_config.init_timers = leon_init_timers;
 
 	BTFIXUPSET_CALL(enable_irq, leon_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, leon_disable_irq, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index f543b45..90eea38 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -221,7 +221,9 @@ void __init sun4c_init_IRQ(void)
 	BTFIXUPSET_CALL(disable_pil_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4c_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4c_load_profile_irq, BTFIXUPCALL_NOP);
-	sparc_init_timers = sun4c_init_timers;
+
+	sparc_irq_config.init_timers = sun4c_init_timers;
+
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 609a13c..fc1c22f 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -557,7 +557,9 @@ void __init sun4d_init_IRQ(void)
 	BTFIXUPSET_CALL(disable_irq, sun4d_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NORM);
-	sparc_init_timers = sun4d_init_timers;
+
+	sparc_irq_config.init_timers = sun4d_init_timers;
+
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4d_clear_ipi, BTFIXUPCALL_NOP);
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 3c6657a..1e13ce9 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -470,7 +470,9 @@ void __init sun4m_init_IRQ(void)
 	BTFIXUPSET_CALL(disable_pil_irq, sun4m_disable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4m_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4m_load_profile_irq, BTFIXUPCALL_NORM);
-	sparc_init_timers = sun4m_init_timers;
+
+	sparc_irq_config.init_timers = sun4m_init_timers;
+
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4m_clear_ipi, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 9c743b1..fe5ab2d 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -224,7 +224,7 @@ static void __init sbus_time_init(void)
 
 	btfixup();
 
-	sparc_init_timers(timer_interrupt);
+	sparc_irq_config.init_timers(timer_interrupt);
 }
 
 void __init time_init(void)
-- 
1.6.0.6

