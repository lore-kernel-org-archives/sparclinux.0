From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:15 +0000
Subject: [PATCH 03/24] sparc32: fix sparse warnings in sun4d_irq.c
Message-Id: <1398100356-19794-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
sun4d_irq.c:146:6: warning: symbol 'sun4d_handler_irq' was not declared. Should it be static?
sun4d_irq.c:239:17: warning: symbol 'sun4d_irq' was not declared. Should it be static?
sun4d_irq.c:288:14: warning: symbol '_sun4d_build_device_irq' was not declared. Should it be static?
sun4d_irq.c:323:14: warning: symbol 'sun4d_build_device_irq' was not declared. Should it be static?
sun4d_irq.c:386:14: warning: symbol 'sun4d_build_timer_irq' was not declared. Should it be static?
sun4d_irq.c:482:13: warning: symbol 'sun4d_init_sbi_irq' was not declared. Should it be static?

Apply static when applicable, otherwise add extern definition

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/irq_32.h |  1 +
 arch/sparc/kernel/irq.h         |  3 +++
 arch/sparc/kernel/sun4d_irq.c   | 17 +++++++++--------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_32.h
index 2ae3aca..b3cef1d 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -17,6 +17,7 @@
 #define irq_canonicalize(irq)	(irq)
 
 extern void __init init_IRQ(void);
+extern void __init sun4d_init_sbi_irq(void);
 
 #define NO_IRQ		0xffffffff
 
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index c17bf8c..35b7c92 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -85,6 +85,9 @@ unsigned long leon_get_irqmask(unsigned int irq);
 /* sun4m_irq.c */
 extern void sun4m_nmi(struct pt_regs *regs);
 
+/* sun4d_irq.c */
+void sun4d_handler_irq(unsigned int pil, struct pt_regs *regs);
+
 #ifdef CONFIG_SMP
 
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index f8933be..a1bb267 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -143,7 +143,7 @@ static void sun4d_sbus_handler_irq(int sbusl)
 	}
 }
 
-void sun4d_handler_irq(int pil, struct pt_regs *regs)
+void sun4d_handler_irq(unsigned int pil, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 	/* SBUS IRQ level (1 - 7) */
@@ -236,7 +236,7 @@ static void sun4d_shutdown_irq(struct irq_data *data)
 	irq_unlink(data->irq);
 }
 
-struct irq_chip sun4d_irq = {
+static struct irq_chip sun4d_irq = {
 	.name		= "sun4d",
 	.irq_startup	= sun4d_startup_irq,
 	.irq_shutdown	= sun4d_shutdown_irq,
@@ -285,9 +285,9 @@ static void __init sun4d_load_profile_irqs(void)
 	}
 }
 
-unsigned int _sun4d_build_device_irq(unsigned int real_irq,
-                                     unsigned int pil,
-                                     unsigned int board)
+static unsigned int _sun4d_build_device_irq(unsigned int real_irq,
+                                            unsigned int pil,
+                                            unsigned int board)
 {
 	struct sun4d_handler_data *handler_data;
 	unsigned int irq;
@@ -320,8 +320,8 @@ err_out:
 
 
 
-unsigned int sun4d_build_device_irq(struct platform_device *op,
-                                    unsigned int real_irq)
+static unsigned int sun4d_build_device_irq(struct platform_device *op,
+                                           unsigned int real_irq)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct device_node *board_parent, *bus = dp->parent;
@@ -383,7 +383,8 @@ err_out:
 	return irq;
 }
 
-unsigned int sun4d_build_timer_irq(unsigned int board, unsigned int real_irq)
+static unsigned int sun4d_build_timer_irq(unsigned int board,
+                                          unsigned int real_irq)
 {
 	return _sun4d_build_device_irq(real_irq, real_irq, board);
 }
-- 
1.8.3.1

