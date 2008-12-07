From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 20:37:36 +0000
Subject: [PATCH 5/5] sparc: fix sparse warnings in irq_32.c
Message-Id: <1228682256-27812-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following sparse warnings:
symbol 'static_irqaction' was not declared. Should it be static?
symbol 'static_irq_count' was not declared. Should it be static?
symbol 'irq_action_lock' was not declared. Should it be static?
symbol 'unexpected_irq' was not declared. Should it be static?
symbol 'handler_irq' was not declared. Should it be static?
returning void-valued expression
returning void-valued expression
returning void-valued expression
symbol 'init_IRQ' was not declared. Should it be static?

Warnings were fixed by addding proper declarations
and fixing return path of a few functions.

There remains several warnings all related to the floppy driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/irq_32.h |    1 +
 arch/sparc/kernel/entry.h       |    4 +++-
 arch/sparc/kernel/irq_32.c      |    7 ++++---
 arch/sparc/kernel/kernel.h      |   11 +++++++++++
 arch/sparc/kernel/sun4d_irq.c   |    2 +-
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_32.h
index fe205cc..ea43057 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -12,4 +12,5 @@
 
 #define irq_canonicalize(irq)	(irq)
 
+extern void __init init_IRQ(void);
 #endif
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 06db4f1..4f53a23 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -5,6 +5,9 @@
 #include <linux/types.h>
 #include <linux/init.h>
 
+/* irq */
+extern void handler_irq(int irq, struct pt_regs *regs);
+
 #ifdef CONFIG_SPARC32
 /* traps */
 extern void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
@@ -219,7 +222,6 @@ struct ino_bucket {
 extern struct ino_bucket *ivector_table;
 extern unsigned long ivector_table_pa;
 
-extern void handler_irq(int irq, struct pt_regs *regs);
 extern void init_irqwork_curcpu(void);
 extern void __cpuinit sun4v_register_mondo_queues(int this_cpu);
 
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 93e1d1c..f3488c4 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -46,6 +46,7 @@
 #include <asm/cacheflush.h>
 #include <asm/irq_regs.h>
 
+#include "kernel.h"
 #include "irq.h"
 
 #ifdef CONFIG_SMP
@@ -592,19 +593,19 @@ EXPORT_SYMBOL(request_irq);
 
 void disable_irq_nosync(unsigned int irq)
 {
-	return __disable_irq(irq);
+	__disable_irq(irq);
 }
 EXPORT_SYMBOL(disable_irq_nosync);
 
 void disable_irq(unsigned int irq)
 {
-	return __disable_irq(irq);
+	__disable_irq(irq);
 }
 EXPORT_SYMBOL(disable_irq);
 
 void enable_irq(unsigned int irq)
 {
-	return __enable_irq(irq);
+	__enable_irq(irq);
 }
 
 EXPORT_SYMBOL(enable_irq);
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 48e7037..81a972e 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -1,5 +1,8 @@
 #ifndef __SPARC_KERNEL_H
 #define __SPARC_KERNEL_H
+
+#include <linux/interrupt.h>
+
 /* cpu.c */
 extern const char *sparc_cpu_type;
 extern const char *sparc_fpu_type;
@@ -15,6 +18,14 @@ extern void handle_hw_divzero(struct pt_regs *regs, unsigned long pc,
                               unsigned long npc, unsigned long psr);
 /* muldiv.c */
 extern int do_user_muldiv (struct pt_regs *, unsigned long);
+
+/* irq_32.c */
+extern struct irqaction static_irqaction[];
+extern int static_irq_count;
+extern spinlock_t irq_action_lock;
+
+extern void unexpected_irq(int irq, void *dev_id, struct pt_regs * regs);
+
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
 #endif /* !(__SPARC_KERNEL_H) */
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 1c98821..3369fef 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -40,6 +40,7 @@
 #include <asm/cacheflush.h>
 #include <asm/irq_regs.h>
 
+#include "kernel.h"
 #include "irq.h"
 
 /* If you trust current SCSI layer to handle different SCSI IRQs, enable this. I don't trust it... -jj */
@@ -58,7 +59,6 @@ static struct sun4d_timer_regs __iomem *sun4d_timers;
 #define TIMER_IRQ	10
 
 #define MAX_STATIC_ALLOC	4
-extern struct irqaction static_irqaction[MAX_STATIC_ALLOC];
 extern int static_irq_count;
 static unsigned char sbus_tid[32];
 
-- 
1.5.6.GIT

