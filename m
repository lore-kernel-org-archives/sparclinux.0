From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:15 +0000
Subject: [PATCH 9/13]: sparc32: Use PROM device probing for sun4c interrupt
Message-Id: <20080919.153915.127702120.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Use PROM device probing for sun4c interrupt register.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4c_irq.c |   47 ++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index ae3149e..8033132 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -59,7 +59,7 @@
  *
  * so don't go making it static, like I tried. sigh.
  */
-unsigned char *interrupt_enable = NULL;
+unsigned char __iomem *interrupt_enable = NULL;
 
 static void sun4c_disable_irq(unsigned int irq_nr)
 {
@@ -68,7 +68,7 @@ static void sun4c_disable_irq(unsigned int irq_nr)
     
 	local_irq_save(flags);
 	irq_nr &= (NR_IRQS - 1);
-	current_mask = *interrupt_enable;
+	current_mask = sbus_readb(interrupt_enable);
 	switch(irq_nr) {
 	case 1:
 		new_mask = ((current_mask) & (~(SUN4C_INT_E1)));
@@ -86,7 +86,7 @@ static void sun4c_disable_irq(unsigned int irq_nr)
 		local_irq_restore(flags);
 		return;
 	}
-	*interrupt_enable = new_mask;
+	sbus_writeb(new_mask, interrupt_enable);
 	local_irq_restore(flags);
 }
 
@@ -97,7 +97,7 @@ static void sun4c_enable_irq(unsigned int irq_nr)
     
 	local_irq_save(flags);
 	irq_nr &= (NR_IRQS - 1);
-	current_mask = *interrupt_enable;
+	current_mask = sbus_readb(interrupt_enable);
 	switch(irq_nr) {
 	case 1:
 		new_mask = ((current_mask) | SUN4C_INT_E1);
@@ -115,7 +115,7 @@ static void sun4c_enable_irq(unsigned int irq_nr)
 		local_irq_restore(flags);
 		return;
 	}
-	*interrupt_enable = new_mask;
+	sbus_writeb(new_mask, interrupt_enable);
 	local_irq_restore(flags);
 }
 
@@ -172,27 +172,22 @@ static void sun4c_nop(void) {}
 
 void __init sun4c_init_IRQ(void)
 {
-	struct linux_prom_registers int_regs[2];
-	int ie_node;
-	struct resource phyres;
-
-	ie_node = prom_searchsiblings (prom_getchild(prom_root_node),
-				       "interrupt-enable");
-	if(ie_node = 0)
-		panic("Cannot find /interrupt-enable node");
-
-	/* Depending on the "address" property is bad news... */
-	interrupt_enable = NULL;
-	if (prom_getproperty(ie_node, "reg", (char *) int_regs,
-			     sizeof(int_regs)) != -1) {
-		memset(&phyres, 0, sizeof(struct resource));
-		phyres.flags = int_regs[0].which_io;
-		phyres.start = int_regs[0].phys_addr;
-		interrupt_enable = (char *) of_ioremap(&phyres, 0,
-		    int_regs[0].reg_size, "sun4c_intr");
+	struct device_node *dp;
+	const u32 *addr;
+
+	dp = of_find_node_by_name(NULL, "interrupt-enable");
+	if (!dp) {
+		prom_printf("sun4c_init_IRQ: Unable to find interrupt-enable\n");
+		prom_halt();
+	}
+
+	addr = of_get_property(dp, "address", NULL);
+	if (!addr) {
+		prom_printf("sun4c_init_IRQ: No address property\n");
+		prom_halt();
 	}
-	if (!interrupt_enable)
-		panic("Cannot map interrupt_enable");
+
+	interrupt_enable = (void __iomem *) (unsigned long) addr[0];
 
 	BTFIXUPSET_CALL(enable_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
@@ -206,6 +201,6 @@ void __init sun4c_init_IRQ(void)
 	BTFIXUPSET_CALL(clear_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(set_irq_udt, sun4c_nop, BTFIXUPCALL_NOP);
 #endif
-	*interrupt_enable = (SUN4C_INT_ENABLE);
+	sbus_writeb(SUN4C_INT_ENABLE, interrupt_enable);
 	/* Cannot enable interrupts until OBP ticker is disabled. */
 }
-- 
1.5.6.5

