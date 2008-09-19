From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:24 +0000
Subject: [PATCH 12/13]: sparc32: Kill irq_rcvreg from sun4m_irq.c
Message-Id: <20080919.153924.108589184.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Kill irq_rcvreg from sun4m_irq.c

Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4m_irq.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index c09ec39..c6096fc 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -59,9 +59,6 @@ struct sun4m_irq_global {
 struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 struct sun4m_irq_global __iomem *sun4m_irq_global;
 
-static unsigned long dummy;
-unsigned long *irq_rcvreg = &dummy;
-
 /* Dave Redman (djhr@tadpole.co.uk)
  * The sun4m interrupt registers.
  */
@@ -369,10 +366,9 @@ void __init sun4m_init_IRQ(void)
 	for (i = 0; !cpu_find_by_instance(i, NULL, &mid); i++)
 		sbus_writel(~0x17fff, &sun4m_irq_percpu[mid]->clear);
 
-	if (num_cpu_iregs = 4) {
-		irq_rcvreg = (unsigned long *) &sun4m_irq_global->interrupt_target;
+	if (num_cpu_iregs = 4)
 		sbus_writel(0, &sun4m_irq_global->interrupt_target);
-	}
+
 	BTFIXUPSET_CALL(enable_irq, sun4m_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, sun4m_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(enable_pil_irq, sun4m_enable_pil_irq, BTFIXUPCALL_NORM);
-- 
1.5.6.5

