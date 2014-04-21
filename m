From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:14 +0000
Subject: [PATCH 02/24] sparc32: fix sparse warnings in sun4m_irq.c and sun4d_irq.c
Message-Id: <1398100356-19794-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:

sun4m_irq.c
sun4m_irq.c:308:6: warning: symbol 'sun4m_nmi' was not declared. Should it be static?
sun4m_irq.c:396:28: warning: incorrect type in assignment (different address spaces)
sun4m_irq.c:396:28:    expected unsigned int volatile *extern [addressable] [toplevel] master_l10_counter
sun4d_irq.c:469:28: warning: incorrect type in assignment (different address spaces)
sun4d_irq.c:469:28:    expected unsigned int volatile *extern [addressable] [toplevel] master_l10_counter

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/timer_32.h | 2 +-
 arch/sparc/kernel/irq.h           | 3 +++
 arch/sparc/kernel/leon_kernel.c   | 5 +++--
 arch/sparc/kernel/time_32.c       | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 72f40a5..93476f8 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -32,7 +32,7 @@ static inline unsigned int timer_value(unsigned int value)
 	return (value + 1) << TIMER_VALUE_SHIFT;
 }
 
-extern __volatile__ unsigned int *master_l10_counter;
+extern volatile unsigned int __iomem *master_l10_counter;
 
 extern irqreturn_t notrace timer_interrupt(int dummy, void *dev_id);
 
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index b66b6aa..c17bf8c 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -82,6 +82,9 @@ void handler_irq(unsigned int pil, struct pt_regs *regs);
 
 unsigned long leon_get_irqmask(unsigned int irq);
 
+/* sun4m_irq.c */
+extern void sun4m_nmi(struct pt_regs *regs);
+
 #ifdef CONFIG_SMP
 
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index b7c6897..b9a2599 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -32,7 +32,7 @@ struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base addr
 
 int leondebug_irq_disable;
 int leon_debug_irqout;
-static int dummy_master_l10_counter;
+static volatile unsigned int dummy_master_l10_counter;
 unsigned long amba_system_id;
 static DEFINE_SPINLOCK(leon_irq_lock);
 
@@ -313,7 +313,8 @@ void __init leon_init_timers(void)
 
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
-	master_l10_counter = (unsigned int *)&dummy_master_l10_counter;
+	master_l10_counter +		(unsigned int __iomem *)&dummy_master_l10_counter;
 	dummy_master_l10_counter = 0;
 
 	rootnp = of_find_node_by_path("/ambapp0");
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index c4c27b0..772b379 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -83,7 +83,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 
 EXPORT_SYMBOL(profile_pc);
 
-__volatile__ unsigned int *master_l10_counter;
+volatile unsigned int __iomem *master_l10_counter;
 
 int update_persistent_clock(struct timespec now)
 {
-- 
1.8.3.1

