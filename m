From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 02 May 2014 15:03:31 +0000
Subject: [PATCH 05/12] sparc32: fix sparse warnings in time_32.c
Message-Id: <1399043018-16975-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
time_32.c:63:1: warning: symbol 'rtc_lock' was not declared. Should it be static?
time_32.c:357:13: warning: symbol 'time_init' was not declared. Should it be static?
time_32.c:148:16: warning: dereference of noderef expression

Add extern definition of rtc_lock in mc146818rtc.h
time_init() is called from init/main.c - add prototype to kernel.h
Use proper u32 __iomem * for master_l10_counter.
Fix all users.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/mc146818rtc.h | 5 +++++
 arch/sparc/include/asm/timer_32.h    | 2 +-
 arch/sparc/kernel/kernel.h           | 3 +++
 arch/sparc/kernel/leon_kernel.c      | 5 ++---
 arch/sparc/kernel/time_32.c          | 8 +++++---
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/mc146818rtc.h b/arch/sparc/include/asm/mc146818rtc.h
index 67ed9e3..d8e72f3 100644
--- a/arch/sparc/include/asm/mc146818rtc.h
+++ b/arch/sparc/include/asm/mc146818rtc.h
@@ -1,5 +1,10 @@
 #ifndef ___ASM_SPARC_MC146818RTC_H
 #define ___ASM_SPARC_MC146818RTC_H
+
+#include <linux/spinlock.h>
+
+extern spinlock_t rtc_lock;
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/mc146818rtc_64.h>
 #else
diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 93476f8..13d0035 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -32,7 +32,7 @@ static inline unsigned int timer_value(unsigned int value)
 	return (value + 1) << TIMER_VALUE_SHIFT;
 }
 
-extern volatile unsigned int __iomem *master_l10_counter;
+extern volatile u32 __iomem *master_l10_counter;
 
 extern irqreturn_t notrace timer_interrupt(int dummy, void *dev_id);
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 0a8a870..e5f1a56 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -143,6 +143,9 @@ void __init auxio_power_probe(void);
 extern void __iomem *pcic_regs;
 void pcic_nmi(unsigned int pend, struct pt_regs *regs);
 
+/* time_32.c */
+void __init time_init(void);
+
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
 #endif /* !(__SPARC_KERNEL_H) */
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index d939708..683c4af 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -32,7 +32,7 @@ struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controller base addr
 
 int leondebug_irq_disable;
 int leon_debug_irqout;
-static volatile unsigned int dummy_master_l10_counter;
+static volatile u32 dummy_master_l10_counter;
 unsigned long amba_system_id;
 static DEFINE_SPINLOCK(leon_irq_lock);
 
@@ -313,8 +313,7 @@ void __init leon_init_timers(void)
 
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
-	master_l10_counter -		(unsigned int __iomem *)&dummy_master_l10_counter;
+	master_l10_counter = (u32 __iomem *)&dummy_master_l10_counter;
 	dummy_master_l10_counter = 0;
 
 	rootnp = of_find_node_by_path("/ambapp0");
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 772b379..b2c7ab0 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -36,6 +36,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+#include <asm/mc146818rtc.h>
 #include <asm/oplib.h>
 #include <asm/timex.h>
 #include <asm/timer.h>
@@ -47,6 +48,7 @@
 #include <asm/irq_regs.h>
 #include <asm/setup.h>
 
+#include "kernel.h"
 #include "irq.h"
 
 static __cacheline_aligned_in_smp DEFINE_SEQLOCK(timer_cs_lock);
@@ -83,7 +85,7 @@ unsigned long profile_pc(struct pt_regs *regs)
 
 EXPORT_SYMBOL(profile_pc);
 
-volatile unsigned int __iomem *master_l10_counter;
+volatile u32 __iomem *master_l10_counter;
 
 int update_persistent_clock(struct timespec now)
 {
@@ -143,9 +145,9 @@ static __init void setup_timer_ce(void)
 
 static unsigned int sbus_cycles_offset(void)
 {
-	unsigned int val, offset;
+	u32 val, offset;
 
-	val = *master_l10_counter;
+	val = sbus_readw(master_l10_counter);
 	offset = (val >> TIMER_VALUE_SHIFT) & TIMER_VALUE_MASK;
 
 	/* Limit hit? */
-- 
1.9.0

