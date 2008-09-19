From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:19 +0000
Subject: [PATCH 11/13]: sparc32: Delete master_l10_limit.
Message-Id: <20080919.153919.195922981.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Delete master_l10_limit.

It is only set, never used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/timer_32.h |    1 -
 arch/sparc/kernel/sun4c_irq.c     |    1 -
 arch/sparc/kernel/sun4d_irq.c     |    1 -
 arch/sparc/kernel/sun4m_irq.c     |    1 -
 arch/sparc/kernel/time.c          |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 351f257..2ec030e 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -12,7 +12,6 @@
 #include <asm/btfixup.h>
 
 extern __volatile__ unsigned int *master_l10_counter;
-extern __volatile__ unsigned int *master_l10_limit;
 
 /* FIXME: Make do_[gs]ettimeofday btfixup calls */
 BTFIXUPDEF_CALL(int, bus_do_settimeofday, struct timespec *tv)
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 92096ba..5dc8a57 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -172,7 +172,6 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 	sbus_writel((((1000000/HZ) + 1) << 10), &sun4c_timers->l10_limit);
 
 	master_l10_counter = &sun4c_timers->l10_count;
-	master_l10_limit = &sun4c_timers->l10_limit;
 
 	err = request_irq(irq[0].pri, counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC),
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index d376d38..d3cb76c 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -526,7 +526,6 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
 
 	master_l10_counter = &sun4d_timers->l10_cur_count;
-	master_l10_limit = &sun4d_timers->l10_timer_limit;
 
 	err = request_irq(TIMER_IRQ, counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC),
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index ab309ec..c09ec39 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -303,7 +303,6 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
 
 	master_l10_counter = &timers_global->l10_count;
-	master_l10_limit = &timers_global->l10_limit;
 
 	err = request_irq(TIMER_IRQ, counter_fn,
 			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index fa54d58..62c1d94 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -73,7 +73,6 @@ unsigned long profile_pc(struct pt_regs *regs)
 EXPORT_SYMBOL(profile_pc);
 
 __volatile__ unsigned int *master_l10_counter;
-__volatile__ unsigned int *master_l10_limit;
 
 /*
  * timer_interrupt() needs to keep up the real-time clock,
-- 
1.5.6.5

