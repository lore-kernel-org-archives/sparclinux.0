From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 16:01:13 +0000
Subject: [PATCH 2/2] sparc32: drop unused clear_cpu_int
Message-Id: <20120513160113.GB538@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From f64a6777f42ef6937d306d8e926879b39dc6e06b Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 15:43:41 +0200
Subject: [PATCH 2/2] sparc32: drop unused clear_cpu_int

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq.h         |    2 --
 arch/sparc/kernel/leon_kernel.c |    8 --------
 arch/sparc/kernel/sun4d_irq.c   |    5 -----
 arch/sparc/kernel/sun4m_irq.c   |    6 ------
 4 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index b965df4..e2b5d5c 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -98,10 +98,8 @@ static inline void load_profile_irq(int cpu, int limit)
 
 #ifdef CONFIG_SMP
 BTFIXUPDEF_CALL(void, set_cpu_int, int, int)
-BTFIXUPDEF_CALL(void, clear_cpu_int, int, int)
 
 #define set_cpu_int(cpu,level) BTFIXUP_CALL(set_cpu_int)(cpu,level)
-#define clear_cpu_int(cpu,level) BTFIXUP_CALL(clear_cpu_int)(cpu,level)
 
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
 #define SUN4D_IPI_IRQ 13
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 06abbb3..e57435f 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -505,13 +505,6 @@ void leon_set_cpu_int(int cpu, int level)
 	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->force[cpu], mask);
 }
 
-static void leon_clear_ipi(int cpu, int level)
-{
-	unsigned long mask;
-	mask = get_irqmask(level);
-	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->force[cpu], mask<<16);
-}
-
 void leon_clear_profile_irq(int cpu)
 {
 }
@@ -541,7 +534,6 @@ void __init leon_init_IRQ(void)
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, leon_set_cpu_int, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(clear_cpu_int, leon_clear_ipi, BTFIXUPCALL_NORM);
 #endif
 
 }
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 7796fa5..15593ee 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -248,10 +248,6 @@ static void sun4d_set_cpu_int(int cpu, int level)
 	sun4d_send_ipi(cpu, level);
 }
 
-static void sun4d_clear_ipi(int cpu, int level)
-{
-}
-
 /* Setup IRQ distribution scheme. */
 void __init sun4d_distribute_irqs(void)
 {
@@ -523,7 +519,6 @@ void __init sun4d_init_IRQ(void)
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(clear_cpu_int, sun4d_clear_ipi, BTFIXUPCALL_NOP);
 #endif
 	/* Cannot enable interrupts until OBP ticker is disabled. */
 }
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index fd8754d..93f4603 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -287,11 +287,6 @@ static void sun4m_send_ipi(int cpu, int level)
 {
 	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->set);
 }
-
-static void sun4m_clear_ipi(int cpu, int level)
-{
-	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->clear);
-}
 #endif
 
 struct sun4m_timer_percpu {
@@ -486,7 +481,6 @@ void __init sun4m_init_IRQ(void)
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(clear_cpu_int, sun4m_clear_ipi, BTFIXUPCALL_NORM);
 #endif
 
 	/* Cannot enable interrupts until OBP ticker is disabled. */
-- 
1.6.0.6

