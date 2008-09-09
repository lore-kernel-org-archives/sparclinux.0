From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2008 05:20:28 +0000
Subject: [PATCH 2/2]: sparc32: Use OF device probing for sun4m irq
Message-Id: <20080908.222028.203662832.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Use OF device probing for sun4m irq registers.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S     |   38 ++++----
 arch/sparc/kernel/sun4m_irq.c |  192 +++++++++++++++++------------------------
 2 files changed, 99 insertions(+), 131 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 68689fa..19b20a0 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -272,17 +272,18 @@ smp4m_ticker:
 	 */
 maybe_smp4m_msg:
 	GET_PROCESSOR4M_ID(o3)
-	set	sun4m_interrupts, %l5
-	ld	[%l5], %o5
+	sethi	%hi(sun4m_irq_percpu), %l5
+	ld	[%l5 + %lo(sun4m_irq_percpu)], %o5
 	sethi	%hi(0x40000000), %o2
-	sll	%o3, 12, %o3
+	sll	%o3, 2, %o3
 	ld	[%o5 + %o3], %o1
+	ld	[%o1 + 0x00], %o1	! sun4m_irq_percpu[cpu]->pending
 	andcc	%o1, %o2, %g0
 	be,a	smp4m_ticker
 	 cmp	%l7, 14
-	st	%o2, [%o5 + 0x4]
+	st	%o2, [%o1 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x40000000
 	WRITE_PAUSE
-	ld	[%o5], %g0
+	ld	[%o1 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
 	WRITE_PAUSE
 	or	%l0, PSR_PIL, %l4
 	wr	%l4, 0x0, %psr
@@ -300,16 +301,16 @@ linux_trap_ipi15_sun4m:
 	SAVE_ALL
 	sethi	%hi(0x80000000), %o2
 	GET_PROCESSOR4M_ID(o0)
-	set	sun4m_interrupts, %l5
-	ld	[%l5], %o5
-	sll	%o0, 12, %o0
-	add	%o5, %o0, %o5
-	ld	[%o5], %o3
+	sethi	%hi(sun4m_irq_percpu), %l5
+	ld	[%l5 + %lo(sun4m_irq_percpu)], %o5
+	sll	%o0, 2, %o0
+	ld	[%o5 + %o0], %o5
+	ld	[%o5 + 0x00], %o3	! sun4m_irq_percpu[cpu]->pending
 	andcc	%o3, %o2, %g0
 	be	1f			! Must be an NMI async memory error
-	 st	%o2, [%o5 + 4]
+	 st	%o2, [%o5 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x80000000
 	WRITE_PAUSE
-	ld	[%o5], %g0
+	ld	[%o5 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
 	WRITE_PAUSE
 	or	%l0, PSR_PIL, %l4
 	wr	%l4, 0x0, %psr
@@ -323,12 +324,11 @@ linux_trap_ipi15_sun4m:
 1:
 	/* NMI async memory error handling. */
 	sethi	%hi(0x80000000), %l4
-	sethi	%hi(0x4000), %o3
-	sub	%o5, %o0, %o5
-	add	%o5, %o3, %l5
-	st	%l4, [%l5 + 0xc]
+	sethi	%hi(sun4m_irq_global), %o5
+	ld	[%o5 + %lo(sun4m_irq_global)], %l5
+	st	%l4, [%l5 + 0x0c]	! sun4m_irq_global->mask_set=0x80000000
 	WRITE_PAUSE
-	ld	[%l5], %g0
+	ld	[%l5 + 0x00], %g0	! sun4m_irq_global->pending
 	WRITE_PAUSE
 	or	%l0, PSR_PIL, %l4
 	wr	%l4, 0x0, %psr
@@ -337,9 +337,9 @@ linux_trap_ipi15_sun4m:
 	WRITE_PAUSE
 	call	sun4m_nmi
 	 nop
-	st	%l4, [%l5 + 0x8]
+	st	%l4, [%l5 + 0x08]	! sun4m_irq_global->mask_clear=0x80000000
 	WRITE_PAUSE
-	ld	[%l5], %g0
+	ld	[%l5 + 0x00], %g0	! sun4m_irq_global->pending
 	WRITE_PAUSE
 	RESTORE_ALL
 
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 1b72c95..f39a70d 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -41,53 +41,25 @@
 
 #include "irq.h"
 
-/* On the sun4m, just like the timers, we have both per-cpu and master
- * interrupt registers.
- */
-
-/* These registers are used for sending/receiving irqs from/to
- * different cpu's.
- */
-struct sun4m_intreg_percpu {
-	unsigned int tbt;        /* Interrupts still pending for this cpu. */
-
-	/* These next two registers are WRITE-ONLY and are only
-	 * "on bit" sensitive, "off bits" written have NO affect.
-	 */
-	unsigned int clear;  /* Clear this cpus irqs here. */
-	unsigned int set;    /* Set this cpus irqs here. */
-	unsigned char space[PAGE_SIZE - 12];
+struct sun4m_irq_percpu {
+	u32		pending;
+	u32		clear;
+	u32		set;
 };
 
-/*
- * djhr
- * Actually the clear and set fields in this struct are misleading..
- * according to the SLAVIO manual (and the same applies for the SEC)
- * the clear field clears bits in the mask which will ENABLE that IRQ
- * the set field sets bits in the mask to DISABLE the IRQ.
- *
- * Also the undirected_xx address in the SLAVIO is defined as
- * RESERVED and write only..
- *
- * DAVEM_NOTE: The SLAVIO only specifies behavior on uniprocessor
- *             sun4m machines, for MP the layout makes more sense.
- */
-struct sun4m_intregs {
-	struct sun4m_intreg_percpu cpu_intregs[SUN4M_NCPUS];
-	unsigned int tbt;                /* IRQ's that are still pending. */
-	unsigned int irqs;               /* Master IRQ bits. */
-
-	/* Again, like the above, two these registers are WRITE-ONLY. */
-	unsigned int clear;              /* Clear master IRQ's by setting bits here. */
-	unsigned int set;                /* Set master IRQ's by setting bits here. */
-
-	/* This register is both READ and WRITE. */
-	unsigned int undirected_target;  /* Which cpu gets undirected irqs. */
+struct sun4m_irq_global {
+	u32		pending;
+	u32		mask;
+	u32		mask_clear;
+	u32		mask_set;
+	u32		interrupt_target;
 };
 
-static unsigned long dummy;
+/* Code in entry.S needs to get at these register mappings.  */
+struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
+struct sun4m_irq_global __iomem *sun4m_irq_global;
 
-struct sun4m_intregs *sun4m_interrupts;
+static unsigned long dummy;
 unsigned long *irq_rcvreg = &dummy;
 
 /* Dave Redman (djhr@tadpole.co.uk)
@@ -182,9 +154,9 @@ static void sun4m_disable_irq(unsigned int irq_nr)
 	mask = sun4m_get_irqmask(irq_nr);
 	local_irq_save(flags);
 	if (irq_nr > 15)
-		sun4m_interrupts->set = mask;
+		sbus_writel(mask, &sun4m_irq_global->mask_set);
 	else
-		sun4m_interrupts->cpu_intregs[cpu].set = mask;
+		sbus_writel(mask, &sun4m_irq_percpu[cpu]->set);
 	local_irq_restore(flags);    
 }
 
@@ -201,13 +173,13 @@ static void sun4m_enable_irq(unsigned int irq_nr)
 		mask = sun4m_get_irqmask(irq_nr);
 		local_irq_save(flags);
 		if (irq_nr > 15)
-			sun4m_interrupts->clear = mask;
+			sbus_writel(mask, &sun4m_irq_global->mask_clear);
 		else
-			sun4m_interrupts->cpu_intregs[cpu].clear = mask;
+			sbus_writel(mask, &sun4m_irq_percpu[cpu]->clear);
 		local_irq_restore(flags);    
 	} else {
 		local_irq_save(flags);
-		sun4m_interrupts->clear = SUN4M_INT_FLOPPY;
+		sbus_writel(SUN4M_INT_FLOPPY, &sun4m_irq_global->mask_clear);
 		local_irq_restore(flags);
 	}
 }
@@ -236,34 +208,30 @@ static unsigned long cpu_pil_to_imask[16] = {
  */
 static void sun4m_disable_pil_irq(unsigned int pil)
 {
-	sun4m_interrupts->set = cpu_pil_to_imask[pil];
+	sbus_writel(cpu_pil_to_imask[pil], &sun4m_irq_global->mask_set);
 }
 
 static void sun4m_enable_pil_irq(unsigned int pil)
 {
-	sun4m_interrupts->clear = cpu_pil_to_imask[pil];
+	sbus_writel(cpu_pil_to_imask[pil], &sun4m_irq_global->mask_clear);
 }
 
 #ifdef CONFIG_SMP
 static void sun4m_send_ipi(int cpu, int level)
 {
-	unsigned long mask;
-
-	mask = sun4m_get_irqmask(level);
-	sun4m_interrupts->cpu_intregs[cpu].set = mask;
+	unsigned long mask = sun4m_get_irqmask(level);
+	sbus_writel(mask, &sun4m_irq_global->mask_set);
 }
 
 static void sun4m_clear_ipi(int cpu, int level)
 {
-	unsigned long mask;
-
-	mask = sun4m_get_irqmask(level);
-	sun4m_interrupts->cpu_intregs[cpu].clear = mask;
+	unsigned long mask = sun4m_get_irqmask(level);
+	sbus_writel(mask, &sun4m_irq_global->mask_clear);
 }
 
 static void sun4m_set_udt(int cpu)
 {
-	sun4m_interrupts->undirected_target = cpu;
+	sbus_writel(cpu, &sun4m_irq_global->interrupt_target);
 }
 #endif
 
@@ -339,7 +307,7 @@ static int __init counter_probe(struct of_device *op,
 	for (i = 0; i < num_cpu_timers; i++)
 		sbus_writel(0, &timers_percpu[i]->l14_limit);
 	if (num_cpu_timers = 4)
-		sbus_writel(SUN4M_INT_E14, &sun4m_interrupts->set);
+		sbus_writel(SUN4M_INT_E14, &sun4m_irq_global->mask_set);
 
 #ifdef CONFIG_SMP
 	{
@@ -392,64 +360,34 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 	(void) of_register_driver(&counter_driver, &of_bus_type);
 }
 
-void __init sun4m_init_IRQ(void)
+static int __init interrupt_probe(struct of_device *op,
+				  const struct of_device_id *match)
 {
-	int ie_node,i;
-	struct linux_prom_registers int_regs[PROMREG_MAX];
-	int num_regs;
-	struct resource r;
-	int mid;
-    
-	local_irq_disable();
-	if((ie_node = prom_searchsiblings(prom_getchild(prom_root_node), "obio")) = 0 ||
-	   (ie_node = prom_getchild (ie_node)) = 0 ||
-	   (ie_node = prom_searchsiblings (ie_node, "interrupt")) = 0) {
-		prom_printf("Cannot find /obio/interrupt node\n");
-		prom_halt();
-	}
-	num_regs = prom_getproperty(ie_node, "reg", (char *) int_regs,
-				    sizeof(int_regs));
-	num_regs = (num_regs/sizeof(struct linux_prom_registers));
-    
-	/* Apply the obio ranges to these registers. */
-	prom_apply_obio_ranges(int_regs, num_regs);
-    
-	int_regs[4].phys_addr = int_regs[num_regs-1].phys_addr;
-	int_regs[4].reg_size = int_regs[num_regs-1].reg_size;
-	int_regs[4].which_io = int_regs[num_regs-1].which_io;
-	for(ie_node = 1; ie_node < 4; ie_node++) {
-		int_regs[ie_node].phys_addr = int_regs[ie_node-1].phys_addr + PAGE_SIZE;
-		int_regs[ie_node].reg_size = int_regs[ie_node-1].reg_size;
-		int_regs[ie_node].which_io = int_regs[ie_node-1].which_io;
-	}
+	int err, i, mid, num_cpu_iregs = op->resource[2].flags ? 4 : 1;
 
-	memset((char *)&r, 0, sizeof(struct resource));
-	/* Map the interrupt registers for all possible cpus. */
-	r.flags = int_regs[0].which_io;
-	r.start = int_regs[0].phys_addr;
-	sun4m_interrupts = (struct sun4m_intregs *) of_ioremap(&r, 0,
-	    PAGE_SIZE*SUN4M_NCPUS, "interrupts_percpu");
+	err = -ENOMEM;
+	for (i = 0; i < num_cpu_iregs; i++) {
+		sun4m_irq_percpu[i] = of_ioremap(&op->resource[i], 0,
+						 resource_size(&op->resource[i]),
+						 "interrupt_percpu");
+		if (!sun4m_irq_percpu[i])
+			goto out_iounmap_percpu;
+	}
+	sun4m_irq_global = of_ioremap(&op->resource[num_cpu_iregs], 0,
+				      resource_size(&op->resource[num_cpu_iregs]),
+				      "interrupt_global");
+	if (!sun4m_irq_global)
+		goto out_iounmap_percpu;
 
-	/* Map the system interrupt control registers. */
-	r.flags = int_regs[4].which_io;
-	r.start = int_regs[4].phys_addr;
-	of_ioremap(&r, 0, int_regs[4].reg_size, "interrupts_system");
+	local_irq_disable();
 
-	sun4m_interrupts->set = ~SUN4M_INT_MASKALL;
+	sbus_writel(~SUN4M_INT_MASKALL, &sun4m_irq_global->mask_set);
 	for (i = 0; !cpu_find_by_instance(i, NULL, &mid); i++)
-		sun4m_interrupts->cpu_intregs[mid].clear = ~0x17fff;
-
-	if (!cpu_find_by_instance(1, NULL, NULL)) {
-		/* system wide interrupts go to cpu 0, this should always
-		 * be safe because it is guaranteed to be fitted or OBP doesn't
-		 * come up
-		 *
-		 * Not sure, but writing here on SLAVIO systems may puke
-		 * so I don't do it unless there is more than 1 cpu.
-		 */
-		irq_rcvreg = (unsigned long *)
-				&sun4m_interrupts->undirected_target;
-		sun4m_interrupts->undirected_target = 0;
+		sbus_writel(~0x17fff, &sun4m_irq_percpu[mid]->clear);
+
+	if (num_cpu_iregs = 4) {
+		irq_rcvreg = (unsigned long *) &sun4m_irq_global->interrupt_target;
+		sbus_writel(0, &sun4m_irq_global->interrupt_target);
 	}
 	BTFIXUPSET_CALL(enable_irq, sun4m_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, sun4m_disable_irq, BTFIXUPCALL_NORM);
@@ -464,5 +402,35 @@ void __init sun4m_init_IRQ(void)
 	BTFIXUPSET_CALL(clear_cpu_int, sun4m_clear_ipi, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(set_irq_udt, sun4m_set_udt, BTFIXUPCALL_NORM);
 #endif
+
+	err = 0;
+
 	/* Cannot enable interrupts until OBP ticker is disabled. */
+out:
+	return err;
+
+out_iounmap_percpu:
+	for (i = 0; i < num_cpu_iregs; i++) {
+		if (sun4m_irq_percpu[i])
+			of_iounmap(&op->resource[i], sun4m_irq_percpu[i],
+				   resource_size(&op->resource[i]));
+	}
+	goto out;
+}
+
+static struct of_device_id __initdata interrupt_match[] = {
+	{ .name = "interrupt", }, {},
+};
+MODULE_DEVICE_TABLE(of, interrupt_match);
+
+static struct of_platform_driver interrupt_driver = {
+	.name		= "interrupt",
+	.match_table	= interrupt_match,
+	.probe		= interrupt_probe,
+};
+
+
+void __init sun4m_init_IRQ(void)
+{
+	(void) of_register_driver(&interrupt_driver, &of_bus_type);
 }
-- 
1.5.6.5.GIT

