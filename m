From: Kjetil Oftedal <oftedal@gmail.com>
Date: Wed, 01 Jun 2011 20:43:50 +0000
Subject: [PATCH 1/3] Restructure sun4d_build_device_irq so that timer interrupts
Message-Id: <Pine.LNX.4.64.1106012229460.16937@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sun4d_build_device_irq was called without a valid platform_device when 
the system timer was initialized on sun4d systems. This caused a NULL 
pointer crash. 

Josip Rodin suggested that the current sun4d_build_device_irq should be 
split into two functions. So that the timer initialization could skip 
the slot and sbus interface detection code in sun4d_build_device_irq, as 
this does not make sence due to the timer interrupts not being generated 
from a device located on sbus. 

Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>
---

 arch/sparc/kernel/sun4d_irq.c |   78 
++++++++++++++++++++++++++++------------
 1 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index a9ea60e..487c1bb 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -299,19 +299,53 @@ static void __init sun4d_load_profile_irqs(void)
 	}
 }
 
+unsigned int _sun4d_build_device_irq(unsigned int real_irq,
+                                     unsigned int pil,
+                                     unsigned int board)
+{
+	struct sun4d_handler_data *handler_data;
+	unsigned int irq;
+
+	irq = irq_alloc(real_irq, pil);
+	if (irq = 0) {
+		prom_printf("IRQ: allocate for %d %d %d failed\n",
+			real_irq, pil, board);
+		goto err_out;
+	}
+
+	handler_data = irq_get_handler_data(irq);
+	if (unlikely(handler_data))
+		goto err_out;
+
+	handler_data = kzalloc(sizeof(struct sun4d_handler_data), GFP_ATOMIC);
+	if (unlikely(!handler_data)) {
+		prom_printf("IRQ: kzalloc(sun4d_handler_data) failed.\n");
+		prom_halt();
+	}
+	handler_data->cpuid    = board_to_cpu[board];
+	handler_data->real_irq = real_irq;
+	irq_set_chip_and_handler_name(irq, &sun4d_irq,
+	                              handle_level_irq, "level");
+	irq_set_handler_data(irq, handler_data);
+
+err_out:
+	return irq;
+}
+
+
+
 unsigned int sun4d_build_device_irq(struct platform_device *op,
                                     unsigned int real_irq)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct device_node *io_unit, *sbi = dp->parent;
 	const struct linux_prom_registers *regs;
-	struct sun4d_handler_data *handler_data;
 	unsigned int pil;
 	unsigned int irq;
 	int board, slot;
 	int sbusl;
 
-	irq = 0;
+	irq = real_irq;
 	while (sbi) {
 		if (!strcmp(sbi->name, "sbi"))
 			break;
@@ -348,29 +382,17 @@ unsigned int sun4d_build_device_irq(struct platform_device *op,
 	else
 		pil = real_irq;
 
-	irq = irq_alloc(real_irq, pil);
-	if (irq = 0)
-		goto err_out;
-
-	handler_data = irq_get_handler_data(irq);
-	if (unlikely(handler_data))
-		goto err_out;
-
-	handler_data = kzalloc(sizeof(struct sun4d_handler_data), GFP_ATOMIC);
-	if (unlikely(!handler_data)) {
-		prom_printf("IRQ: kzalloc(sun4d_handler_data) failed.\n");
-		prom_halt();
-	}
-	handler_data->cpuid    = board_to_cpu[board];
-	handler_data->real_irq = real_irq;
-	irq_set_chip_and_handler_name(irq, &sun4d_irq,
-	                              handle_level_irq, "level");
-	irq_set_handler_data(irq, handler_data);
-
+	irq = _sun4d_build_device_irq(real_irq, pil, board);
 err_out:
-	return real_irq;
+	return irq;
 }
 
+unsigned int sun4d_build_timer_irq(unsigned int board, unsigned int real_irq)
+{
+	return _sun4d_build_device_irq(real_irq, real_irq, board);
+}
+
+
 static void __init sun4d_fixup_trap_table(void)
 {
 #ifdef CONFIG_SMP
@@ -402,6 +424,7 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 	unsigned int irq;
 	const u32 *reg;
 	int err;
+	int board;
 
 	dp = of_find_node_by_name(NULL, "cpu-unit");
 	if (!dp) {
@@ -414,12 +437,19 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 	 * bootbus.
 	 */
 	reg = of_get_property(dp, "reg", NULL);
-	of_node_put(dp);
 	if (!reg) {
 		prom_printf("sun4d_init_timers: No reg property\n");
 		prom_halt();
 	}
 
+	board = of_getintprop_default(dp, "board#", -1);
+	if (board = -1) {
+		prom_printf("sun4d_init_timers: No board# property on cpu-unit\n");
+		prom_halt();
+	}
+
+	of_node_put(dp);
+
 	res.start = reg[1];
 	res.end = reg[2] - 1;
 	res.flags = reg[0] & 0xff;
@@ -434,7 +464,7 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 
 	master_l10_counter = &sun4d_timers->l10_cur_count;
 
-	irq = sun4d_build_device_irq(NULL, SUN4D_TIMER_IRQ);
+	irq = sun4d_build_timer_irq(board, SUN4D_TIMER_IRQ);
 	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
