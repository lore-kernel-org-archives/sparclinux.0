From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 16:00:36 +0000
Subject: [PATCH 1/2] sparc32: drop unused set_irq_udt
Message-Id: <20120513160036.GA538@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 8b81e2a4c7f0e2d534e84eb706861d3c3238715d Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 15:29:09 +0200
Subject: [PATCH 1/2] sparc32: drop unused set_irq_udt

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq.h         |    2 --
 arch/sparc/kernel/leon_kernel.c |    5 -----
 arch/sparc/kernel/sun4d_irq.c   |    5 -----
 arch/sparc/kernel/sun4m_irq.c   |    6 ------
 4 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 593e7a5..b965df4 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -99,11 +99,9 @@ static inline void load_profile_irq(int cpu, int limit)
 #ifdef CONFIG_SMP
 BTFIXUPDEF_CALL(void, set_cpu_int, int, int)
 BTFIXUPDEF_CALL(void, clear_cpu_int, int, int)
-BTFIXUPDEF_CALL(void, set_irq_udt, int)
 
 #define set_cpu_int(cpu,level) BTFIXUP_CALL(set_cpu_int)(cpu,level)
 #define clear_cpu_int(cpu,level) BTFIXUP_CALL(clear_cpu_int)(cpu,level)
-#define set_irq_udt(cpu) BTFIXUP_CALL(set_irq_udt)(cpu)
 
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
 #define SUN4D_IPI_IRQ 13
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 722650a..06abbb3 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -512,10 +512,6 @@ static void leon_clear_ipi(int cpu, int level)
 	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->force[cpu], mask<<16);
 }
 
-static void leon_set_udt(int cpu)
-{
-}
-
 void leon_clear_profile_irq(int cpu)
 {
 }
@@ -546,7 +542,6 @@ void __init leon_init_IRQ(void)
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, leon_set_cpu_int, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, leon_clear_ipi, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(set_irq_udt, leon_set_udt, BTFIXUPCALL_NORM);
 #endif
 
 }
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index abf5265..7796fa5 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -252,10 +252,6 @@ static void sun4d_clear_ipi(int cpu, int level)
 {
 }
 
-static void sun4d_set_udt(int cpu)
-{
-}
-
 /* Setup IRQ distribution scheme. */
 void __init sun4d_distribute_irqs(void)
 {
@@ -528,7 +524,6 @@ void __init sun4d_init_IRQ(void)
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4d_set_cpu_int, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4d_clear_ipi, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(set_irq_udt, sun4d_set_udt, BTFIXUPCALL_NOP);
 #endif
 	/* Cannot enable interrupts until OBP ticker is disabled. */
 }
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 87908a5..fd8754d 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -292,11 +292,6 @@ static void sun4m_clear_ipi(int cpu, int level)
 {
 	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->clear);
 }
-
-static void sun4m_set_udt(int cpu)
-{
-	sbus_writel(cpu, &sun4m_irq_global->interrupt_target);
-}
 #endif
 
 struct sun4m_timer_percpu {
@@ -492,7 +487,6 @@ void __init sun4m_init_IRQ(void)
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4m_clear_ipi, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(set_irq_udt, sun4m_set_udt, BTFIXUPCALL_NORM);
 #endif
 
 	/* Cannot enable interrupts until OBP ticker is disabled. */
-- 
1.6.0.6

