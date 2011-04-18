From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 18 Apr 2011 21:25:44 +0000
Subject: [PATCH 3/3] sparc32: genirq support
Message-Id: <1303161944-13611-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The conversion of sparc32 to genirq is based on original work done
by David S. Miller.
Daniel Hellstrom has helped in the conversion and implemented
the shutdowm functionality.
Marcel van Nies <morcles@gmail.com> has tested this on Sparc Station 20

Test status:
sun4c      - not tested
sun4m,pci  - not tested
sun4m,sbus - tested (Sparc Classic, Sparc Station 5, Sparc Station 20)
sun4d      - not tested
leon       - tested on various combinations of leon boards,
             including SMP variants

generic
   Introduce use of GENERIC_HARDIRQS and GENERIC_IRQ_SHOW
   Allocate 64 IRQs - which is enough even for SS2000
   Use a table of irq_bucket to maintain uses IRQs
      irq_bucket is also used to chain several irq's that
      must be called when the same intrrupt is asserted
   Use irq_link to link a interrupt source to the irq
   All plafforms must now supply their own build_device_irq method
   handler_irq rewriten to use generic irq support

floppy
   Read FLOPPY_IRQ from platform device
   Use generic request_irq to register the floppy interrupt
   Rewrote sparc_floppy_irq to use the generic irq support

pcic:
   Introduce irq_chip
   Store mask in chip_data for use in mask/unmask functions
   Add build_device_irq for pcic
   Use pcic_build_device_irq in pci_time_init
   allocate virtual irqs in pcic_fill_irq

sun4c:
   Introduce irq_chip
   Store mask in chip_data for use in mask/unmask functions
   Add build_device_irq for sun4c
   Use sun4c_build_device_irq in sun4c_init_timers

sun4m:
   Introduce irq_chip
   Introduce dedicated mask/unmask methods
   Introduce sun4m_handler_data that allow easy access to necessary
     data in the mask/unmask functions
   Add a helper method to enable profile_timer (used from smp)
   Added sun4m_build_device_irq
   Use sun4m_build_device_irq in sun4m_init_timers

   TODO:
      There is no replacement for smp_rotate that always scheduled
      next CPU as interrupt target upon an interrupt

sun4d:
   Introduce irq_chip
   Introduce dedicated mask/unmask methods
   Introduce sun4d_handler_data that allow easy access to
   necessary data in mask/unmask fuctions
   Rewrote sun4d_handler_irq to use generic irq support

   TODO:
      The original implmentation of enable/disable had:

          if (irq < NR_IRQS)
               return;

      The new implmentation does not distingush between SBUS and cpu
      interrupts.
      I am no sure what is right here. I assume we need to do
      something for the cpu interrupts.

      I have not succeeded booting my sun4d box (with or without this patch)
      and my understanding of this platfrom is limited.
      So I would be a bit suprised if this works.

leon:
   Introduce irq_chip
   Store mask in chip_data for use in mask/unmask functions
   Add build_device_irq for leon
   Use leon_build_device_irq in leon_init_timers

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Daniel Hellstrom <daniel@gaisler.com>
Tested-by: Daniel Hellstrom <daniel@gaisler.com>
Tested-by: Marcel van Nies <morcles@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/sparc/Kconfig                 |    6 +-
 arch/sparc/include/asm/floppy_32.h |   40 ++-
 arch/sparc/include/asm/irq_32.h    |    6 +-
 arch/sparc/include/asm/system_32.h |    5 -
 arch/sparc/kernel/Makefile         |    4 -
 arch/sparc/kernel/irq.h            |   45 ++--
 arch/sparc/kernel/irq_32.c         |  494 ++++++++----------------------------
 arch/sparc/kernel/kernel.h         |    1 +
 arch/sparc/kernel/leon_kernel.c    |   70 ++++-
 arch/sparc/kernel/pcic.c           |   83 ++++--
 arch/sparc/kernel/sun4c_irq.c      |  150 +++++++-----
 arch/sparc/kernel/sun4d_irq.c      |  472 ++++++++++++----------------------
 arch/sparc/kernel/sun4m_irq.c      |  179 +++++++------
 arch/sparc/kernel/sun4m_smp.c      |   16 +-
 14 files changed, 636 insertions(+), 935 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e560d10..a56630d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -25,6 +25,10 @@ config SPARC
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_HARDIRQS_NO_DEPRECATED
+	select GENERIC_IRQ_SHOW
+
 
 config SPARC32
 	def_bool !64BIT
@@ -50,8 +54,6 @@ config SPARC64
 	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
-	select HAVE_GENERIC_HARDIRQS
-	select GENERIC_IRQ_SHOW
 	select IRQ_PREFLOW_FASTEOI
 
 config ARCH_DEFCONFIG
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index 86666f7..482c79e 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -281,28 +281,27 @@ static inline void sun_fd_enable_dma(void)
 	pdma_areasize = pdma_size;
 }
 
-/* Our low-level entry point in arch/sparc/kernel/entry.S */
-extern int sparc_floppy_request_irq(int irq, unsigned long flags,
-				    irq_handler_t irq_handler);
+extern int sparc_floppy_request_irq(unsigned int irq,
+                                    irq_handler_t irq_handler);
 
 static int sun_fd_request_irq(void)
 {
 	static int once = 0;
-	int error;
 
-	if(!once) {
+	if (!once) {
 		once = 1;
-		error = sparc_floppy_request_irq(FLOPPY_IRQ,
-						 IRQF_DISABLED,
-						 floppy_interrupt);
-		return ((error = 0) ? 0 : -1);
-	} else return 0;
+		return sparc_floppy_request_irq(FLOPPY_IRQ, floppy_interrupt);
+	} else {
+		return 0;
+	}
 }
 
 static struct linux_prom_registers fd_regs[2];
 
 static int sun_floppy_init(void)
 {
+	struct platform_device *op;
+	struct device_node *dp;
 	char state[128];
 	phandle tnode, fd_node;
 	int num_regs;
@@ -310,7 +309,6 @@ static int sun_floppy_init(void)
 
 	use_virtual_dma = 1;
 
-	FLOPPY_IRQ = 11;
 	/* Forget it if we aren't on a machine that could possibly
 	 * ever have a floppy drive.
 	 */
@@ -349,6 +347,26 @@ static int sun_floppy_init(void)
 	sun_fdc = (struct sun_flpy_controller *)
 	    of_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");
 
+	/* Look up irq in platform_device.
+	 * We try "SUNW,fdtwo" and "fd"
+	 */
+	for_each_node_by_name(dp, "SUNW,fdtwo") {
+		op = of_find_device_by_node(dp);
+		if (op)
+			break;
+	}
+	if (!op) {
+		for_each_node_by_name(dp, "fd") {
+			op = of_find_device_by_node(dp);
+			if (op)
+				break;
+		}
+	}
+	if (!op)
+		goto no_sun_fdc;
+
+	FLOPPY_IRQ = op->archdata.irqs[0];
+
 	/* Last minute sanity check... */
 	if(sun_fdc->status_82072 = 0xff) {
 		sun_fdc = NULL;
diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_32.h
index eced3e3..2ae3aca 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -6,7 +6,11 @@
 #ifndef _SPARC_IRQ_H
 #define _SPARC_IRQ_H
 
-#define NR_IRQS    16
+/* Allocated number of logical irq numbers.
+ * sun4d boxes (ss2000e) should be OK with ~32.
+ * Be on the safe side and make room for 64
+ */
+#define NR_IRQS    64
 
 #include <linux/interrupt.h>
 
diff --git a/arch/sparc/include/asm/system_32.h b/arch/sparc/include/asm/system_32.h
index 890036b..47a7e86 100644
--- a/arch/sparc/include/asm/system_32.h
+++ b/arch/sparc/include/asm/system_32.h
@@ -15,11 +15,6 @@
 
 #include <linux/irqflags.h>
 
-static inline unsigned int probe_irq_mask(unsigned long val)
-{
-	return 0;
-}
-
 /*
  * Sparc (general) CPU types
  */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 99aa4db..9cff270 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -71,10 +71,6 @@ obj-$(CONFIG_SPARC64)	+= pcr.o
 obj-$(CONFIG_SPARC64)	+= nmi.o
 obj-$(CONFIG_SPARC64_SMP) += cpumap.o
 
-# sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implementation
-obj-$(CONFIG_SPARC32)     += devres.o
-devres-y                  := ../../../kernel/irq/devres.o
-
 obj-y                     += dma.o
 
 obj-$(CONFIG_SPARC32_PCI) += pcic.o
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 008453b..a189c27 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -2,6 +2,23 @@
 
 #include <asm/btfixup.h>
 
+struct irq_bucket {
+        struct irq_bucket *next;
+        unsigned int real_irq;
+        unsigned int irq;
+        unsigned int pil;
+};
+
+#define SUN4D_MAX_BOARD 10
+#define SUN4D_MAX_IRQ ((SUN4D_MAX_BOARD + 2) << 5)
+
+/* Map between the irq identifier used in hw to the
+ * irq_bucket. The map is sufficient large to hold
+ * the sun4d hw identifiers.
+ */
+extern struct irq_bucket *irq_map[SUN4D_MAX_IRQ];
+
+
 /* sun4m specific type definitions */
 
 /* This maps direct to CPU specific interrupt registers */
@@ -35,6 +52,10 @@ struct sparc_irq_config {
 };
 extern struct sparc_irq_config sparc_irq_config;
 
+unsigned int irq_alloc(unsigned int real_irq, unsigned int pil);
+void irq_link(unsigned int irq);
+void irq_unlink(unsigned int irq);
+void handler_irq(unsigned int pil, struct pt_regs *regs);
 
 /* Dave Redman (djhr@tadpole.co.uk)
  * changed these to function pointers.. it saves cycles and will allow
@@ -44,33 +65,9 @@ extern struct sparc_irq_config sparc_irq_config;
  * Changed these to btfixup entities... It saves cycles :)
  */
 
-BTFIXUPDEF_CALL(void, disable_irq, unsigned int)
-BTFIXUPDEF_CALL(void, enable_irq, unsigned int)
-BTFIXUPDEF_CALL(void, disable_pil_irq, unsigned int)
-BTFIXUPDEF_CALL(void, enable_pil_irq, unsigned int)
 BTFIXUPDEF_CALL(void, clear_clock_irq, void)
 BTFIXUPDEF_CALL(void, load_profile_irq, int, unsigned int)
 
-static inline void __disable_irq(unsigned int irq)
-{
-	BTFIXUP_CALL(disable_irq)(irq);
-}
-
-static inline void __enable_irq(unsigned int irq)
-{
-	BTFIXUP_CALL(enable_irq)(irq);
-}
-
-static inline void disable_pil_irq(unsigned int irq)
-{
-	BTFIXUP_CALL(disable_pil_irq)(irq);
-}
-
-static inline void enable_pil_irq(unsigned int irq)
-{
-	BTFIXUP_CALL(enable_pil_irq)(irq);
-}
-
 static inline void clear_clock_irq(void)
 {
 	BTFIXUP_CALL(clear_clock_irq)();
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index b2dbb4b..197e1ba 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cpudata.h>
 #include <asm/pcic.h>
 #include <asm/leon.h>
 
@@ -101,284 +102,163 @@ EXPORT_SYMBOL(arch_local_irq_restore);
  * directed CPU interrupts using the existing enable/disable irq code
  * with tweaks.
  *
+ * Sun4d complicates things even further.  IRQ numbers are arbitrary
+ * 32-bit values in that case.  Since this is similar to sparc64,
+ * we adopt a virtual IRQ numbering scheme as is done there.
+ * Virutal interrupt numbers are allocated by build_irq().  So NR_IRQS
+ * just becomes a limit of how many interrupt sources we can handle in
+ * a single system.  Even fully loaded SS2000 machines top off at
+ * about 32 interrupt sources or so, therefore a NR_IRQS value of 64
+ * is more than enough.
+  *
+ * We keep a map of per-PIL enable interrupts.  These get wired
+ * up via the irq_chip->startup() method which gets invoked by
+ * the generic IRQ layer during request_irq().
  */
 
 
+/* Table of allocated irqs. Unused entries has irq = 0 */
+static struct irq_bucket irq_table[NR_IRQS];
+/* Protect access to irq_table */
+static DEFINE_SPINLOCK(irq_table_lock);
 
-/*
- * Dave Redman (djhr@tadpole.co.uk)
- *
- * There used to be extern calls and hard coded values here.. very sucky!
- * instead, because some of the devices attach very early, I do something
- * equally sucky but at least we'll never try to free statically allocated
- * space or call kmalloc before kmalloc_init :(.
- *
- * In fact it's the timer10 that attaches first.. then timer14
- * then kmalloc_init is called.. then the tty interrupts attach.
- * hmmm....
- *
- */
-#define MAX_STATIC_ALLOC	4
-struct irqaction static_irqaction[MAX_STATIC_ALLOC];
-int static_irq_count;
-
-static struct {
-	struct irqaction *action;
-	int flags;
-} sparc_irq[NR_IRQS];
-#define SPARC_IRQ_INPROGRESS 1
-
-/* Used to protect the IRQ action lists */
-DEFINE_SPINLOCK(irq_action_lock);
+/* Map between the irq identifier used in hw to the irq_bucket. */
+struct irq_bucket *irq_map[SUN4D_MAX_IRQ];
+/* Protect access to irq_map */
+static DEFINE_SPINLOCK(irq_map_lock);
 
-int show_interrupts(struct seq_file *p, void *v)
+/* Allocate a new irq from the irq_table */
+unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
 {
-	int i = *(loff_t *)v;
-	struct irqaction *action;
 	unsigned long flags;
-#ifdef CONFIG_SMP
-	int j;
-#endif
+	unsigned int i;
+
+	spin_lock_irqsave(&irq_table_lock, flags);
+	for (i = 1; i < NR_IRQS; i++) {
+		if (irq_table[i].real_irq = real_irq && irq_table[i].pil = pil)
+			goto found;
+	}
 
-	if (sparc_cpu_model = sun4d)
-		return show_sun4d_interrupts(p, v);
+	for (i = 1; i < NR_IRQS; i++) {
+		if (!irq_table[i].irq)
+			break;
+	}
 
-	spin_lock_irqsave(&irq_action_lock, flags);
 	if (i < NR_IRQS) {
-		action = sparc_irq[i].action;
-		if (!action)
-			goto out_unlock;
-		seq_printf(p, "%3d: ", i);
-#ifndef CONFIG_SMP
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#else
-		for_each_online_cpu(j) {
-			seq_printf(p, "%10u ",
-				    kstat_cpu(j).irqs[i]);
-		}
-#endif
-		seq_printf(p, " %c %s",
-			(action->flags & IRQF_DISABLED) ? '+' : ' ',
-			action->name);
-		for (action = action->next; action; action = action->next) {
-			seq_printf(p, ",%s %s",
-				(action->flags & IRQF_DISABLED) ? " +" : "",
-				action->name);
-		}
-		seq_putc(p, '\n');
+		irq_table[i].real_irq = real_irq;
+		irq_table[i].irq = i;
+		irq_table[i].pil = pil;
+	} else {
+		printk(KERN_ERR "IRQ: Out of virtual IRQs.\n");
+		i = 0;
 	}
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-	return 0;
+found:
+	spin_unlock_irqrestore(&irq_table_lock, flags);
+
+	return i;
 }
 
-void free_irq(unsigned int irq, void *dev_id)
+/* Based on a single pil handler_irq may need to call several
+ * interrupt handlers. Use irq_map as entry to irq_table,
+ * and let each entry in irq_table point to the next entry.
+ */
+void irq_link(unsigned int irq)
 {
-	struct irqaction *action;
-	struct irqaction **actionp;
+	struct irq_bucket *p;
 	unsigned long flags;
-	unsigned int cpu_irq;
+	unsigned int pil;
 
-	if (sparc_cpu_model = sun4d) {
-		sun4d_free_irq(irq, dev_id);
-		return;
-	}
-	cpu_irq = irq & (NR_IRQS - 1);
-	if (cpu_irq > 14) {  /* 14 irq levels on the sparc */
-		printk(KERN_ERR "Trying to free bogus IRQ %d\n", irq);
-		return;
-	}
+	BUG_ON(irq >= NR_IRQS);
 
-	spin_lock_irqsave(&irq_action_lock, flags);
+	spin_lock_irqsave(&irq_map_lock, flags);
 
-	actionp = &sparc_irq[cpu_irq].action;
-	action = *actionp;
+	p = &irq_table[irq];
+	pil = p->pil;
+	BUG_ON(pil > SUN4D_MAX_IRQ);
+	p->next = irq_map[pil];
+	irq_map[pil] = p;
 
-	if (!action->handler) {
-		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
-		goto out_unlock;
-	}
-	if (dev_id) {
-		for (; action; action = action->next) {
-			if (action->dev_id = dev_id)
-				break;
-			actionp = &action->next;
-		}
-		if (!action) {
-			printk(KERN_ERR "Trying to free free shared IRQ%d\n",
-			       irq);
-			goto out_unlock;
-		}
-	} else if (action->flags & IRQF_SHARED) {
-		printk(KERN_ERR "Trying to free shared IRQ%d with NULL device ID\n",
-		       irq);
-		goto out_unlock;
-	}
-	if (action->flags & SA_STATIC_ALLOC) {
-		/*
-		 * This interrupt is marked as specially allocated
-		 * so it is a bad idea to free it.
-		 */
-		printk(KERN_ERR "Attempt to free statically allocated IRQ%d (%s)\n",
-		       irq, action->name);
-		goto out_unlock;
-	}
-
-	*actionp = action->next;
-
-	spin_unlock_irqrestore(&irq_action_lock, flags);
+	spin_unlock_irqrestore(&irq_map_lock, flags);
+}
 
-	synchronize_irq(irq);
+void irq_unlink(unsigned int irq)
+{
+	struct irq_bucket *p, **pnext;
+	unsigned long flags;
 
-	spin_lock_irqsave(&irq_action_lock, flags);
+	BUG_ON(irq >= NR_IRQS);
 
-	kfree(action);
+	spin_lock_irqsave(&irq_map_lock, flags);
 
-	if (!sparc_irq[cpu_irq].action)
-		__disable_irq(irq);
+	p = &irq_table[irq];
+	BUG_ON(p->pil > SUN4D_MAX_IRQ);
+	pnext = &irq_map[p->pil];
+	while (*pnext != p)
+		pnext = &(*pnext)->next;
+	*pnext = p->next;
 
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
+	spin_unlock_irqrestore(&irq_map_lock, flags);
 }
-EXPORT_SYMBOL(free_irq);
 
-/*
- * This is called when we want to synchronize with
- * interrupts. We may for example tell a device to
- * stop sending interrupts: but to make sure there
- * are no interrupts that are executing on another
- * CPU we need to call this function.
- */
-#ifdef CONFIG_SMP
-void synchronize_irq(unsigned int irq)
-{
-	unsigned int cpu_irq;
 
-	cpu_irq = irq & (NR_IRQS - 1);
-	while (sparc_irq[cpu_irq].flags & SPARC_IRQ_INPROGRESS)
-		cpu_relax();
-}
-EXPORT_SYMBOL(synchronize_irq);
-#endif /* SMP */
-
-void unexpected_irq(int irq, void *dev_id, struct pt_regs *regs)
+/* /proc/interrupts printing */
+int arch_show_interrupts(struct seq_file *p, int prec)
 {
-	int i;
-	struct irqaction *action;
-	unsigned int cpu_irq;
+	int j;
 
-	cpu_irq = irq & (NR_IRQS - 1);
-	action = sparc_irq[cpu_irq].action;
-
-	printk(KERN_ERR "IO device interrupt, irq = %d\n", irq);
-	printk(KERN_ERR "PC = %08lx NPC = %08lx FP=%08lx\n", regs->pc,
-		    regs->npc, regs->u_regs[14]);
-	if (action) {
-		printk(KERN_ERR "Expecting: ");
-		for (i = 0; i < 16; i++)
-			if (action->handler)
-				printk(KERN_CONT "[%s:%d:0x%x] ", action->name,
-				       i, (unsigned int)action->handler);
-	}
-	printk(KERN_ERR "AIEEE\n");
-	panic("bogus interrupt received");
+	seq_printf(p, "NMI: ");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", cpu_data(j).counter);
+	seq_printf(p, "     Non-maskable interrupts\n");
+	return 0;
 }
 
-void handler_irq(int pil, struct pt_regs *regs)
+void handler_irq(unsigned int pil, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	struct irqaction *action;
-	int cpu = smp_processor_id();
+	struct irq_bucket *p;
 
+	BUG_ON(pil > 15);
 	old_regs = set_irq_regs(regs);
 	irq_enter();
-	disable_pil_irq(pil);
-#ifdef CONFIG_SMP
-	/* Only rotate on lower priority IRQs (scsi, ethernet, etc.). */
-	if ((sparc_cpu_model=sun4m) && (pil < 10))
-		smp4m_irq_rotate(cpu);
-#endif
-	action = sparc_irq[pil].action;
-	sparc_irq[pil].flags |= SPARC_IRQ_INPROGRESS;
-	kstat_cpu(cpu).irqs[pil]++;
-	do {
-		if (!action || !action->handler)
-			unexpected_irq(pil, NULL, regs);
-		action->handler(pil, action->dev_id);
-		action = action->next;
-	} while (action);
-	sparc_irq[pil].flags &= ~SPARC_IRQ_INPROGRESS;
-	enable_pil_irq(pil);
+
+	p = irq_map[pil];
+	while (p) {
+		struct irq_bucket *next = p->next;
+
+		generic_handle_irq(p->irq);
+		p = next;
+	}
 	irq_exit();
 	set_irq_regs(old_regs);
 }
 
 #if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
+static unsigned int floppy_irq;
 
-/*
- * Fast IRQs on the Sparc can only have one routine attached to them,
- * thus no sharing possible.
- */
-static int request_fast_irq(unsigned int irq,
-			    void (*handler)(void),
-			    unsigned long irqflags, const char *devname)
+int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler)
 {
-	struct irqaction *action;
-	unsigned long flags;
 	unsigned int cpu_irq;
-	int ret;
+	int err;
+
 #if defined CONFIG_SMP && !defined CONFIG_SPARC_LEON
 	struct tt_entry *trap_table;
 #endif
-	cpu_irq = irq & (NR_IRQS - 1);
-	if (cpu_irq > 14) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (!handler) {
-		ret = -EINVAL;
-		goto out;
-	}
 
-	spin_lock_irqsave(&irq_action_lock, flags);
+	err = request_irq(irq, irq_handler, 0, "floppy", NULL);
+	if (err)
+		return -1;
 
-	action = sparc_irq[cpu_irq].action;
-	if (action) {
-		if (action->flags & IRQF_SHARED)
-			panic("Trying to register fast irq when already shared.\n");
-		if (irqflags & IRQF_SHARED)
-			panic("Trying to register fast irq as shared.\n");
+	/* Save for later use in floppy interrupt handler */
+	floppy_irq = irq;
 
-		/* Anyway, someone already owns it so cannot be made fast. */
-		printk(KERN_ERR "request_fast_irq: Trying to register yet already owned.\n");
-		ret = -EBUSY;
-		goto out_unlock;
-	}
-
-	/*
-	 * If this is flagged as statically allocated then we use our
-	 * private struct which is never freed.
-	 */
-	if (irqflags & SA_STATIC_ALLOC) {
-		if (static_irq_count < MAX_STATIC_ALLOC)
-			action = &static_irqaction[static_irq_count++];
-		else
-			printk(KERN_ERR "Fast IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n",
-			       irq, devname);
-	}
-
-	if (action = NULL)
-		action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-	if (!action) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
+	cpu_irq = (irq & (NR_IRQS - 1));
 
 	/* Dork with trap table if we get this far. */
 #define INSTANTIATE(table) \
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_one = SPARC_RD_PSR_L0; \
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two = \
-		SPARC_BRANCH((unsigned long) handler, \
+		SPARC_BRANCH((unsigned long) floppy_hardint, \
 			     (unsigned long) &table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two);\
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_three = SPARC_RD_WIM_L3; \
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four = SPARC_NOP;
@@ -399,22 +279,9 @@ static int request_fast_irq(unsigned int irq,
 	 * writing we have no CPU-neutral interface to fine-grained flushes.
 	 */
 	flush_cache_all();
-
-	action->flags = irqflags;
-	action->name = devname;
-	action->dev_id = NULL;
-	action->next = NULL;
-
-	sparc_irq[cpu_irq].action = action;
-
-	__enable_irq(irq);
-
-	ret = 0;
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-out:
-	return ret;
+	return 0;
 }
+EXPORT_SYMBOL(sparc_floppy_request_irq);
 
 /*
  * These variables are used to access state from the assembler
@@ -440,154 +307,23 @@ EXPORT_SYMBOL(pdma_base);
 unsigned long pdma_areasize;
 EXPORT_SYMBOL(pdma_areasize);
 
-static irq_handler_t floppy_irq_handler;
-
+/* Use the generic irq support to call floppy_interrupt
+ * which was setup using request_irq() in sparc_floppy_request_irq().
+ * We only have one floppy interrupt so we do not need to check
+ * for additional handlers being wired up by irq_link()
+ */
 void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	int cpu = smp_processor_id();
 
 	old_regs = set_irq_regs(regs);
-	disable_pil_irq(irq);
 	irq_enter();
-	kstat_cpu(cpu).irqs[irq]++;
-	floppy_irq_handler(irq, dev_id);
+	generic_handle_irq(floppy_irq);
 	irq_exit();
-	enable_pil_irq(irq);
 	set_irq_regs(old_regs);
-	/*
-	 * XXX Eek, it's totally changed with preempt_count() and such
-	 * if (softirq_pending(cpu))
-	 *	do_softirq();
-	 */
 }
-
-int sparc_floppy_request_irq(int irq, unsigned long flags,
-			     irq_handler_t irq_handler)
-{
-	floppy_irq_handler = irq_handler;
-	return request_fast_irq(irq, floppy_hardint, flags, "floppy");
-}
-EXPORT_SYMBOL(sparc_floppy_request_irq);
-
 #endif
 
-int request_irq(unsigned int irq,
-		irq_handler_t handler,
-		unsigned long irqflags, const char *devname, void *dev_id)
-{
-	struct irqaction *action, **actionp;
-	unsigned long flags;
-	unsigned int cpu_irq;
-	int ret;
-
-	if (sparc_cpu_model = sun4d)
-		return sun4d_request_irq(irq, handler, irqflags, devname, dev_id);
-
-	cpu_irq = irq & (NR_IRQS - 1);
-	if (cpu_irq > 14) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (!handler) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	actionp = &sparc_irq[cpu_irq].action;
-	action = *actionp;
-	if (action) {
-		if (!(action->flags & IRQF_SHARED) || !(irqflags & IRQF_SHARED)) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
-		if ((action->flags & IRQF_DISABLED) != (irqflags & IRQF_DISABLED)) {
-			printk(KERN_ERR "Attempt to mix fast and slow interrupts on IRQ%d denied\n",
-			       irq);
-			ret = -EBUSY;
-			goto out_unlock;
-		}
-		for ( ; action; action = *actionp)
-			actionp = &action->next;
-	}
-
-	/* If this is flagged as statically allocated then we use our
-	 * private struct which is never freed.
-	 */
-	if (irqflags & SA_STATIC_ALLOC) {
-		if (static_irq_count < MAX_STATIC_ALLOC)
-			action = &static_irqaction[static_irq_count++];
-		else
-			printk(KERN_ERR "Request for IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n",
-			       irq, devname);
-	}
-	if (action = NULL)
-		action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-	if (!action) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
-	action->handler = handler;
-	action->flags = irqflags;
-	action->name = devname;
-	action->next = NULL;
-	action->dev_id = dev_id;
-
-	*actionp = action;
-
-	__enable_irq(irq);
-
-	ret = 0;
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-out:
-	return ret;
-}
-EXPORT_SYMBOL(request_irq);
-
-void disable_irq_nosync(unsigned int irq)
-{
-	__disable_irq(irq);
-}
-EXPORT_SYMBOL(disable_irq_nosync);
-
-void disable_irq(unsigned int irq)
-{
-	__disable_irq(irq);
-}
-EXPORT_SYMBOL(disable_irq);
-
-void enable_irq(unsigned int irq)
-{
-	__enable_irq(irq);
-}
-EXPORT_SYMBOL(enable_irq);
-
-/*
- * We really don't need these at all on the Sparc.  We only have
- * stubs here because they are exported to modules.
- */
-unsigned long probe_irq_on(void)
-{
-	return 0;
-}
-EXPORT_SYMBOL(probe_irq_on);
-
-int probe_irq_off(unsigned long mask)
-{
-	return 0;
-}
-EXPORT_SYMBOL(probe_irq_off);
-
-static unsigned int build_device_irq(struct platform_device *op,
-                                     unsigned int real_irq)
-{
-	return real_irq;
-}
-
 /* djhr
  * This could probably be made indirect too and assigned in the CPU
  * bits of the code. That would be much nicer I think and would also
@@ -598,8 +334,6 @@ static unsigned int build_device_irq(struct platform_device *op,
 
 void __init init_IRQ(void)
 {
-	sparc_irq_config.build_device_irq = build_device_irq;
-
 	switch (sparc_cpu_model) {
 	case sun4c:
 	case sun4:
@@ -629,9 +363,3 @@ void __init init_IRQ(void)
 	btfixup();
 }
 
-#ifdef CONFIG_PROC_FS
-void init_irq_proc(void)
-{
-	/* For now, nothing... */
-}
-#endif /* CONFIG_PROC_FS */
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 24ad449..487d67a 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -37,6 +37,7 @@ extern void sun4c_init_IRQ(void);
 extern unsigned int lvl14_resolution;
 
 extern void sun4m_init_IRQ(void);
+extern void sun4m_unmask_profile_irq(void);
 extern void sun4m_clear_profile_irq(int cpu);
 
 /* sun4d_irq.c */
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 2969f77..8591cf1 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -83,20 +83,22 @@ static inline unsigned long get_irqmask(unsigned int irq)
 	return mask;
 }
 
-static void leon_enable_irq(unsigned int irq_nr)
+static void leon_unmask_irq(struct irq_data *data)
 {
 	unsigned long mask, flags;
-	mask = get_irqmask(irq_nr);
+
+	mask = (unsigned long)data->chip_data;
 	local_irq_save(flags);
 	LEON3_BYPASS_STORE_PA(LEON_IMASK,
 			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) | (mask)));
 	local_irq_restore(flags);
 }
 
-static void leon_disable_irq(unsigned int irq_nr)
+static void leon_mask_irq(struct irq_data *data)
 {
 	unsigned long mask, flags;
-	mask = get_irqmask(irq_nr);
+
+	mask = (unsigned long)data->chip_data;
 	local_irq_save(flags);
 	LEON3_BYPASS_STORE_PA(LEON_IMASK,
 			      (LEON3_BYPASS_LOAD_PA(LEON_IMASK) & ~(mask)));
@@ -104,6 +106,50 @@ static void leon_disable_irq(unsigned int irq_nr)
 
 }
 
+static unsigned int leon_startup_irq(struct irq_data *data)
+{
+	irq_link(data->irq);
+	leon_unmask_irq(data);
+	return 0;
+}
+
+static void leon_shutdown_irq(struct irq_data *data)
+{
+	leon_mask_irq(data);
+	irq_unlink(data->irq);
+}
+
+static struct irq_chip leon_irq = {
+	.name		= "leon",
+	.irq_startup	= leon_startup_irq,
+	.irq_shutdown	= leon_shutdown_irq,
+	.irq_mask	= leon_mask_irq,
+	.irq_unmask	= leon_unmask_irq,
+};
+
+static unsigned int leon_build_device_irq(struct platform_device *op,
+                                          unsigned int real_irq)
+{
+	unsigned int irq;
+	unsigned long mask;
+
+	irq = 0;
+	mask = get_irqmask(real_irq);
+	if (mask = 0)
+		goto out;
+
+	irq = irq_alloc(real_irq, real_irq);
+	if (irq = 0)
+		goto out;
+
+	irq_set_chip_and_handler_name(irq, &leon_irq,
+				      handle_simple_irq, "edge");
+	irq_set_chip_data(irq, (void *)mask);
+
+out:
+	return irq;
+}
+
 void __init leon_init_timers(irq_handler_t counter_fn)
 {
 	int irq;
@@ -112,6 +158,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	int len;
 	int cpu, icsel;
 	int ampopts;
+	int err;
 
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
@@ -219,11 +266,10 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		goto bad;
 	}
 
-	irq = request_irq(leon3_gptimer_irq+leon3_gptimer_idx,
-			  counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+	irq = leon_build_device_irq(NULL, leon3_gptimer_irq + leon3_gptimer_idx);
+	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 
-	if (irq) {
+	if (err) {
 		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
 		       LEON_INTERRUPT_TIMER1);
 		prom_halt();
@@ -347,12 +393,8 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu)
 
 void __init leon_init_IRQ(void)
 {
-	sparc_irq_config.init_timers = leon_init_timers;
-
-	BTFIXUPSET_CALL(enable_irq, leon_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, leon_disable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(enable_pil_irq, leon_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_pil_irq, leon_disable_irq, BTFIXUPCALL_NORM);
+	sparc_irq_config.init_timers      = leon_init_timers;
+	sparc_irq_config.build_device_irq = leon_build_device_irq;
 
 	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq,
 			BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 2cdc131..948601a 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -164,6 +164,9 @@ void __iomem *pcic_regs;
 volatile int pcic_speculative;
 volatile int pcic_trapped;
 
+/* forward */
+unsigned int pcic_build_device_irq(struct platform_device *op,
+                                   unsigned int real_irq);
 
 #define CONFIG_CMD(bus, device_fn, where) (0x80000000 | (((unsigned int)bus) << 16) | (((unsigned int)device_fn) << 8) | (where & ~3))
 
@@ -523,6 +526,7 @@ static void
 pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 {
 	struct pcic_ca2irq *p;
+	unsigned int real_irq;
 	int i, ivec;
 	char namebuf[64];
 
@@ -551,26 +555,25 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 	i = p->pin;
 	if (i >= 0 && i < 4) {
 		ivec = readw(pcic->pcic_regs+PCI_INT_SELECT_LO);
-		dev->irq = ivec >> (i << 2) & 0xF;
+		real_irq = ivec >> (i << 2) & 0xF;
 	} else if (i >= 4 && i < 8) {
 		ivec = readw(pcic->pcic_regs+PCI_INT_SELECT_HI);
-		dev->irq = ivec >> ((i-4) << 2) & 0xF;
+		real_irq = ivec >> ((i-4) << 2) & 0xF;
 	} else {					/* Corrupted map */
 		printk("PCIC: BAD PIN %d\n", i); for (;;) {}
 	}
 /* P3 */ /* printk("PCIC: device %s pin %d ivec 0x%x irq %x\n", namebuf, i, ivec, dev->irq); */
 
-	/*
-	 * dev->irq=0 means PROM did not bother to program the upper
+	/* real_irq means PROM did not bother to program the upper
 	 * half of PCIC. This happens on JS-E with PROM 3.11, for instance.
 	 */
-	if (dev->irq = 0 || p->force) {
+	if (real_irq = 0 || p->force) {
 		if (p->irq = 0 || p->irq >= 15) {	/* Corrupted map */
 			printk("PCIC: BAD IRQ %d\n", p->irq); for (;;) {}
 		}
 		printk("PCIC: setting irq %d at pin %d for device %02x:%02x\n",
 		    p->irq, p->pin, dev->bus->number, dev->devfn);
-		dev->irq = p->irq;
+		real_irq = p->irq;
 
 		i = p->pin;
 		if (i >= 4) {
@@ -584,7 +587,8 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 			ivec |= p->irq << (i << 2);
 			writew(ivec, pcic->pcic_regs+PCI_INT_SELECT_LO);
 		}
- 	}
+	}
+	dev->irq = pcic_build_device_irq(NULL, real_irq);
 }
 
 /*
@@ -729,6 +733,7 @@ void __init pci_time_init(void)
 	struct linux_pcic *pcic = &pcic0;
 	unsigned long v;
 	int timer_irq, irq;
+	int err;
 
 	do_arch_gettimeoffset = pci_gettimeoffset;
 
@@ -740,9 +745,10 @@ void __init pci_time_init(void)
 	timer_irq = PCI_COUNTER_IRQ_SYS(v);
 	writel (PCI_COUNTER_IRQ_SET(timer_irq, 0),
 		pcic->pcic_regs+PCI_COUNTER_IRQ);
-	irq = request_irq(timer_irq, pcic_timer_handler,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
-	if (irq) {
+	irq = pcic_build_device_irq(NULL, timer_irq);
+	err = request_irq(irq, pcic_timer_handler,
+			  IRQF_TIMER, "timer", NULL);
+	if (err) {
 		prom_printf("time_init: unable to attach IRQ%d\n", timer_irq);
 		prom_halt();
 	}
@@ -803,50 +809,73 @@ static inline unsigned long get_irqmask(int irq_nr)
 	return 1 << irq_nr;
 }
 
-static void pcic_disable_irq(unsigned int irq_nr)
+static void pcic_mask_irq(struct irq_data *data)
 {
 	unsigned long mask, flags;
 
-	mask = get_irqmask(irq_nr);
+	mask = (unsigned long)data->chip_data;
 	local_irq_save(flags);
 	writel(mask, pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_SET);
 	local_irq_restore(flags);
 }
 
-static void pcic_enable_irq(unsigned int irq_nr)
+static void pcic_unmask_irq(struct irq_data *data)
 {
 	unsigned long mask, flags;
 
-	mask = get_irqmask(irq_nr);
+	mask = (unsigned long)data->chip_data;
 	local_irq_save(flags);
 	writel(mask, pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_CLEAR);
 	local_irq_restore(flags);
 }
 
-static void pcic_load_profile_irq(int cpu, unsigned int limit)
+static unsigned int pcic_startup_irq(struct irq_data *data)
 {
-	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
+	irq_link(data->irq);
+	pcic_unmask_irq(data);
+	return 0;
 }
 
-/* We assume the caller has disabled local interrupts when these are called,
- * or else very bizarre behavior will result.
- */
-static void pcic_disable_pil_irq(unsigned int pil)
+static struct irq_chip pcic_irq = {
+	.name		= "pcic",
+	.irq_startup	= pcic_startup_irq,
+	.irq_mask	= pcic_mask_irq,
+	.irq_unmask	= pcic_unmask_irq,
+};
+
+unsigned int pcic_build_device_irq(struct platform_device *op,
+                                   unsigned int real_irq)
 {
-	writel(get_irqmask(pil), pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_SET);
+	unsigned int irq;
+	unsigned long mask;
+
+	irq = 0;
+	mask = get_irqmask(real_irq);
+	if (mask = 0)
+		goto out;
+
+	irq = irq_alloc(real_irq, real_irq);
+	if (irq = 0)
+		goto out;
+
+	irq_set_chip_and_handler_name(irq, &pcic_irq,
+	                              handle_level_irq, "PCIC");
+	irq_set_chip_data(irq, (void *)mask);
+
+out:
+	return irq;
 }
 
-static void pcic_enable_pil_irq(unsigned int pil)
+
+static void pcic_load_profile_irq(int cpu, unsigned int limit)
 {
-	writel(get_irqmask(pil), pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_CLEAR);
+	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
 }
 
 void __init sun4m_pci_init_IRQ(void)
 {
-	BTFIXUPSET_CALL(enable_irq, pcic_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, pcic_disable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(enable_pil_irq, pcic_enable_pil_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_pil_irq, pcic_disable_pil_irq, BTFIXUPCALL_NORM);
+	sparc_irq_config.build_device_irq = pcic_build_device_irq;
+
 	BTFIXUPSET_CALL(clear_clock_irq, pcic_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, pcic_load_profile_irq, BTFIXUPCALL_NORM);
 }
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 90eea38..f6bf25a 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -65,62 +65,94 @@
  */
 unsigned char __iomem *interrupt_enable;
 
-static void sun4c_disable_irq(unsigned int irq_nr)
+static void sun4c_mask_irq(struct irq_data *data)
 {
-	unsigned long flags;
-	unsigned char current_mask, new_mask;
-
-	local_irq_save(flags);
-	irq_nr &= (NR_IRQS - 1);
-	current_mask = sbus_readb(interrupt_enable);
-	switch (irq_nr) {
-	case 1:
-		new_mask = ((current_mask) & (~(SUN4C_INT_E1)));
-		break;
-	case 8:
-		new_mask = ((current_mask) & (~(SUN4C_INT_E8)));
-		break;
-	case 10:
-		new_mask = ((current_mask) & (~(SUN4C_INT_E10)));
-		break;
-	case 14:
-		new_mask = ((current_mask) & (~(SUN4C_INT_E14)));
-		break;
-	default:
+	unsigned long mask = (unsigned long)data->chip_data;
+
+	if (mask) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		mask = sbus_readb(interrupt_enable) & ~mask;
+		sbus_writeb(mask, interrupt_enable);
 		local_irq_restore(flags);
-		return;
 	}
-	sbus_writeb(new_mask, interrupt_enable);
-	local_irq_restore(flags);
 }
 
-static void sun4c_enable_irq(unsigned int irq_nr)
+static void sun4c_unmask_irq(struct irq_data *data)
 {
-	unsigned long flags;
-	unsigned char current_mask, new_mask;
-
-	local_irq_save(flags);
-	irq_nr &= (NR_IRQS - 1);
-	current_mask = sbus_readb(interrupt_enable);
-	switch (irq_nr) {
-	case 1:
-		new_mask = ((current_mask) | SUN4C_INT_E1);
-		break;
-	case 8:
-		new_mask = ((current_mask) | SUN4C_INT_E8);
-		break;
-	case 10:
-		new_mask = ((current_mask) | SUN4C_INT_E10);
-		break;
-	case 14:
-		new_mask = ((current_mask) | SUN4C_INT_E14);
-		break;
-	default:
+	unsigned long mask = (unsigned long)data->chip_data;
+
+	if (mask) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		mask = sbus_readb(interrupt_enable) | mask;
+		sbus_writeb(mask, interrupt_enable);
 		local_irq_restore(flags);
-		return;
 	}
-	sbus_writeb(new_mask, interrupt_enable);
-	local_irq_restore(flags);
+}
+
+static unsigned int sun4c_startup_irq(struct irq_data *data)
+{
+	irq_link(data->irq);
+	sun4c_unmask_irq(data);
+
+	return 0;
+}
+
+static void sun4c_shutdown_irq(struct irq_data *data)
+{
+	sun4c_mask_irq(data);
+	irq_unlink(data->irq);
+}
+
+static struct irq_chip sun4c_irq = {
+	.name		= "sun4c",
+	.irq_startup	= sun4c_startup_irq,
+	.irq_shutdown	= sun4c_shutdown_irq,
+	.irq_mask	= sun4c_mask_irq,
+	.irq_unmask	= sun4c_unmask_irq,
+};
+
+static unsigned int sun4c_build_device_irq(struct platform_device *op,
+					   unsigned int real_irq)
+{
+	 unsigned int irq;
+
+	if (real_irq >= 16) {
+		prom_printf("Bogus sun4c IRQ %u\n", real_irq);
+		prom_halt();
+	}
+
+	irq = irq_alloc(real_irq, real_irq);
+	if (irq) {
+		unsigned long mask = 0UL;
+
+		switch (real_irq) {
+		case 1:
+			mask = SUN4C_INT_E1;
+			break;
+		case 8:
+			mask = SUN4C_INT_E8;
+			break;
+		case 10:
+			mask = SUN4C_INT_E10;
+			break;
+		case 14:
+			mask = SUN4C_INT_E14;
+			break;
+		default:
+			/* All the rest are either always enabled,
+			 * or are for signalling software interrupts.
+			 */
+			break;
+		}
+		irq_set_chip_and_handler_name(irq, &sun4c_irq,
+		                              handle_level_irq, "level");
+		irq_set_chip_data(irq, (void *)mask);
+	}
+	return irq;
 }
 
 struct sun4c_timer_info {
@@ -144,8 +176,9 @@ static void sun4c_load_profile_irq(int cpu, unsigned int limit)
 
 static void __init sun4c_init_timers(irq_handler_t counter_fn)
 {
-	const struct linux_prom_irqs *irq;
+	const struct linux_prom_irqs *prom_irqs;
 	struct device_node *dp;
+	unsigned int irq;
 	const u32 *addr;
 	int err;
 
@@ -163,9 +196,9 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 
 	sun4c_timers = (void __iomem *) (unsigned long) addr[0];
 
-	irq = of_get_property(dp, "intr", NULL);
+	prom_irqs = of_get_property(dp, "intr", NULL);
 	of_node_put(dp);
-	if (!irq) {
+	if (!prom_irqs) {
 		prom_printf("sun4c_init_timers: No intr property\n");
 		prom_halt();
 	}
@@ -178,15 +211,15 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 
 	master_l10_counter = &sun4c_timers->l10_count;
 
-	err = request_irq(irq[0].pri, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC),
-			  "timer", NULL);
+	irq = sun4c_build_device_irq(NULL, prom_irqs[0].pri);
+	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
 	}
 
-	sun4c_disable_irq(irq[1].pri);
+	/* disable timer interrupt */
+	sun4c_mask_irq(irq_get_irq_data(irq));
 }
 
 #ifdef CONFIG_SMP
@@ -215,14 +248,11 @@ void __init sun4c_init_IRQ(void)
 
 	interrupt_enable = (void __iomem *) (unsigned long) addr[0];
 
-	BTFIXUPSET_CALL(enable_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(enable_pil_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_pil_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4c_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4c_load_profile_irq, BTFIXUPCALL_NOP);
 
-	sparc_irq_config.init_timers = sun4c_init_timers;
+	sparc_irq_config.init_timers      = sun4c_init_timers;
+	sparc_irq_config.build_device_irq = sun4c_build_device_irq;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index ee35c45..14a0435 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -22,22 +22,20 @@
  * cpu local.  CPU local interrupts cover the timer interrupts
  * and whatnot, and we encode those as normal PILs between
  * 0 and 15.
- *
- * SBUS interrupts are encoded integers including the board number
- * (plus one), the SBUS level, and the SBUS slot number.  Sun4D
- * IRQ dispatch is done by:
- *
- * 1) Reading the BW local interrupt table in order to get the bus
- *    interrupt mask.
- *
- *    This table is indexed by SBUS interrupt level which can be
- *    derived from the PIL we got interrupted on.
- *
- * 2) For each bus showing interrupt pending from #1, read the
- *    SBI interrupt state register.  This will indicate which slots
- *    have interrupts pending for that SBUS interrupt level.
+ * SBUS interrupts are encodes as a combination of board, level and slot.
  */
 
+struct sun4d_handler_data {
+	unsigned int cpuid;    /* target cpu */
+	unsigned int real_irq; /* interrupt level */
+};
+
+
+static unsigned int sun4d_encode_irq(int board, int lvl, int slot)
+{
+	return (board + 1) << 5 | (lvl << 2) | slot;
+}
+
 struct sun4d_timer_regs {
 	u32	l10_timer_limit;
 	u32	l10_cur_countx;
@@ -48,22 +46,13 @@ struct sun4d_timer_regs {
 
 static struct sun4d_timer_regs __iomem *sun4d_timers;
 
-#define TIMER_IRQ	10
-
-#define MAX_STATIC_ALLOC	4
+#define SUN4D_TIMER_IRQ        10
 
 /* Specify which cpu handle interrupts from which board.
  * Index is board - value is cpu.
  */
 static unsigned char board_to_cpu[32];
 
-static struct irqaction *irq_action[NR_IRQS];
-
-static struct sbus_action {
-	struct irqaction *action;
-	/* For SMP this needs to be extended */
-} *sbus_actions;
-
 static int pil_to_sbus[] = {
 	0,
 	0,
@@ -83,152 +72,81 @@ static int pil_to_sbus[] = {
 	0,
 };
 
-static int sbus_to_pil[] = {
-	0,
-	2,
-	3,
-	5,
-	7,
-	9,
-	11,
-	13,
-};
-
-static int nsbi;
-
 /* Exported for sun4d_smp.c */
 DEFINE_SPINLOCK(sun4d_imsk_lock);
 
-int show_sun4d_interrupts(struct seq_file *p, void *v)
+/* SBUS interrupts are encoded integers including the board number
+ * (plus one), the SBUS level, and the SBUS slot number.  Sun4D
+ * IRQ dispatch is done by:
+ *
+ * 1) Reading the BW local interrupt table in order to get the bus
+ *    interrupt mask.
+ *
+ *    This table is indexed by SBUS interrupt level which can be
+ *    derived from the PIL we got interrupted on.
+ *
+ * 2) For each bus showing interrupt pending from #1, read the
+ *    SBI interrupt state register.  This will indicate which slots
+ *    have interrupts pending for that SBUS interrupt level.
+ *
+ * 3) Call the genreric IRQ support.
+ */
+static void sun4d_sbus_handler_irq(int sbusl)
 {
-	int i = *(loff_t *) v, j = 0, k = 0, sbusl;
-	struct irqaction *action;
-	unsigned long flags;
-#ifdef CONFIG_SMP
-	int x;
-#endif
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-	if (i < NR_IRQS) {
-		sbusl = pil_to_sbus[i];
-		if (!sbusl) {
-			action = *(i + irq_action);
-			if (!action)
-				goto out_unlock;
-		} else {
-			for (j = 0; j < nsbi; j++) {
-				for (k = 0; k < 4; k++)
-					action = sbus_actions[(j << 5) + (sbusl << 2) + k].action;
-					if (action)
-						goto found_it;
-			}
-			goto out_unlock;
-		}
-found_it:	seq_printf(p, "%3d: ", i);
-#ifndef CONFIG_SMP
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#else
-		for_each_online_cpu(x)
-			seq_printf(p, "%10u ",
-			       kstat_cpu(cpu_logical_map(x)).irqs[i]);
-#endif
-		seq_printf(p, "%c %s",
-			(action->flags & IRQF_DISABLED) ? '+' : ' ',
-			action->name);
-		action = action->next;
-		for (;;) {
-			for (; action; action = action->next) {
-				seq_printf(p, ",%s %s",
-					(action->flags & IRQF_DISABLED) ? " +" : "",
-					action->name);
-			}
-			if (!sbusl)
-				break;
-			k++;
-			if (k < 4) {
-				action = sbus_actions[(j << 5) + (sbusl << 2) + k].action;
-			} else {
-				j++;
-				if (j = nsbi)
-					break;
-				k = 0;
-				action = sbus_actions[(j << 5) + (sbusl << 2)].action;
+	unsigned int bus_mask;
+	unsigned int sbino, slot;
+	unsigned int sbil;
+
+	bus_mask = bw_get_intr_mask(sbusl) & 0x3ffff;
+	bw_clear_intr_mask(sbusl, bus_mask);
+
+	sbil = (sbusl << 2);
+	/* Loop for each pending SBI */
+	for (sbino = 0; bus_mask; sbino++) {
+		unsigned int idx, mask;
+
+		bus_mask >>= 1;
+		if (!(bus_mask & 1))
+			continue;
+		/* XXX This seems to ACK the irq twice.  acquire_sbi()
+		 * XXX uses swap, therefore this writes 0xf << sbil,
+		 * XXX then later release_sbi() will write the individual
+		 * XXX bits which were set again.
+		 */
+		mask = acquire_sbi(SBI2DEVID(sbino), 0xf << sbil);
+		mask &= (0xf << sbil);
+
+		/* Loop for each pending SBI slot */
+		idx = 0;
+		slot = (1 << sbil);
+		while (mask != 0) {
+			unsigned int pil;
+			struct irq_bucket *p;
+
+			idx++;
+			slot <<= 1;
+			if (!(mask & slot))
+				continue;
+
+			mask &= ~slot;
+			pil = sun4d_encode_irq(sbino, sbil, idx);
+
+			p = irq_map[pil];
+			while (p) {
+				struct irq_bucket *next;
+
+				next = p->next;
+				generic_handle_irq(p->irq);
+				p = next;
 			}
+			release_sbi(SBI2DEVID(sbino), slot);
 		}
-		seq_putc(p, '\n');
-	}
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-	return 0;
-}
-
-void sun4d_free_irq(unsigned int irq, void *dev_id)
-{
-	struct irqaction *action, **actionp;
-	struct irqaction *tmp = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-	if (irq < 15)
-		actionp = irq + irq_action;
-	else
-		actionp = &(sbus_actions[irq - (1 << 5)].action);
-	action = *actionp;
-	if (!action) {
-		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
-		goto out_unlock;
-	}
-	if (dev_id) {
-		for (; action; action = action->next) {
-			if (action->dev_id = dev_id)
-				break;
-			tmp = action;
-		}
-		if (!action) {
-			printk(KERN_ERR "Trying to free free shared IRQ%d\n",
-			       irq);
-			goto out_unlock;
-		}
-	} else if (action->flags & IRQF_SHARED) {
-		printk(KERN_ERR "Trying to free shared IRQ%d with NULL device ID\n",
-		       irq);
-		goto out_unlock;
-	}
-	if (action->flags & SA_STATIC_ALLOC) {
-		/*
-		 * This interrupt is marked as specially allocated
-		 * so it is a bad idea to free it.
-		 */
-		printk(KERN_ERR "Attempt to free statically allocated IRQ%d (%s)\n",
-		       irq, action->name);
-		goto out_unlock;
 	}
-
-	if (tmp)
-		tmp->next = action->next;
-	else
-		*actionp = action->next;
-
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-
-	synchronize_irq(irq);
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	kfree(action);
-
-	if (!(*actionp))
-		__disable_irq(irq);
-
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
 }
 
 void sun4d_handler_irq(int pil, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	struct irqaction *action;
-	int cpu = smp_processor_id();
 	/* SBUS IRQ level (1 - 7) */
 	int sbusl = pil_to_sbus[pil];
 
@@ -239,158 +157,85 @@ void sun4d_handler_irq(int pil, struct pt_regs *regs)
 
 	old_regs = set_irq_regs(regs);
 	irq_enter();
-	kstat_cpu(cpu).irqs[pil]++;
-	if (!sbusl) {
-		action = *(pil + irq_action);
-		if (!action)
-			unexpected_irq(pil, NULL, regs);
-		do {
-			action->handler(pil, action->dev_id);
-			action = action->next;
-		} while (action);
+	if (sbusl = 0) {
+		/* cpu interrupt */
+		struct irq_bucket *p;
+
+		p = irq_map[pil];
+		while (p) {
+			struct irq_bucket *next;
+
+			next = p->next;
+			generic_handle_irq(p->irq);
+			p = next;
+		}
 	} else {
-		int bus_mask = bw_get_intr_mask(sbusl) & 0x3ffff;
-		int sbino;
-		struct sbus_action *actionp;
-		unsigned mask, slot;
-		int sbil = (sbusl << 2);
-
-		bw_clear_intr_mask(sbusl, bus_mask);
-
-		/* Loop for each pending SBI */
-		for (sbino = 0; bus_mask; sbino++, bus_mask >>= 1)
-			if (bus_mask & 1) {
-				mask = acquire_sbi(SBI2DEVID(sbino), 0xf << sbil);
-				mask &= (0xf << sbil);
-				actionp = sbus_actions + (sbino << 5) + (sbil);
-				/* Loop for each pending SBI slot */
-				for (slot = (1 << sbil); mask; slot <<= 1, actionp++)
-					if (mask & slot) {
-						mask &= ~slot;
-						action = actionp->action;
-
-						if (!action)
-							unexpected_irq(pil, NULL, regs);
-						do {
-							action->handler(pil, action->dev_id);
-							action = action->next;
-						} while (action);
-						release_sbi(SBI2DEVID(sbino), slot);
-					}
-			}
+		/* SBUS interrupt */
+		sun4d_sbus_handler_irq(sbusl);
 	}
 	irq_exit();
 	set_irq_regs(old_regs);
 }
 
-int sun4d_request_irq(unsigned int irq,
-		irq_handler_t handler,
-		unsigned long irqflags, const char *devname, void *dev_id)
+
+static void sun4d_mask_irq(struct irq_data *data)
 {
-	struct irqaction *action, *tmp = NULL, **actionp;
+	struct sun4d_handler_data *handler_data = data->handler_data;
+	unsigned int real_irq;
+#ifdef CONFIG_SMP
+	int cpuid = handler_data->cpuid;
 	unsigned long flags;
-	int ret;
-
-	if (irq > 14 && irq < (1 << 5)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (!handler) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	if (irq >= (1 << 5))
-		actionp = &(sbus_actions[irq - (1 << 5)].action);
-	else
-		actionp = irq + irq_action;
-	action = *actionp;
-
-	if (action) {
-		if ((action->flags & IRQF_SHARED) && (irqflags & IRQF_SHARED)) {
-			for (tmp = action; tmp->next; tmp = tmp->next)
-				/* find last entry - tmp used below */;
-		} else {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
-		if ((action->flags & IRQF_DISABLED) ^ (irqflags & IRQF_DISABLED)) {
-			printk(KERN_ERR "Attempt to mix fast and slow interrupts on IRQ%d denied\n",
-			       irq);
-			ret = -EBUSY;
-			goto out_unlock;
-		}
-		action = NULL;		/* Or else! */
-	}
-
-	/* If this is flagged as statically allocated then we use our
-	 * private struct which is never freed.
-	 */
-	if (irqflags & SA_STATIC_ALLOC) {
-		if (static_irq_count < MAX_STATIC_ALLOC)
-			action = &static_irqaction[static_irq_count++];
-		else
-			printk(KERN_ERR "Request for IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n",
-			       irq, devname);
-	}
-
-	if (action = NULL)
-		action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-
-	if (!action) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
-	action->handler = handler;
-	action->flags = irqflags;
-	action->name = devname;
-	action->next = NULL;
-	action->dev_id = dev_id;
-
-	if (tmp)
-		tmp->next = action;
-	else
-		*actionp = action;
-
-	__enable_irq(irq);
-
-	ret = 0;
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-out:
-	return ret;
+#endif
+	real_irq = handler_data->real_irq;
+#ifdef CONFIG_SMP
+	spin_lock_irqsave(&sun4d_imsk_lock, flags);
+	cc_set_imsk_other(cpuid, cc_get_imsk_other(cpuid) | (1 << real_irq));
+	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+#else
+	cc_set_imsk(cc_get_imsk() | (1 << real_irq));
+#endif
 }
 
-static void sun4d_disable_irq(unsigned int irq)
+static void sun4d_unmask_irq(struct irq_data *data)
 {
-	int tid = board_to_cpu[(irq >> 5) - 1];
+	struct sun4d_handler_data *handler_data = data->handler_data;
+	unsigned int real_irq;
+#ifdef CONFIG_SMP
+	int cpuid = handler_data->cpuid;
 	unsigned long flags;
+#endif
+	real_irq = handler_data->real_irq;
 
-	if (irq < NR_IRQS)
-		return;
-
+#ifdef CONFIG_SMP
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
-	cc_set_imsk_other(tid, cc_get_imsk_other(tid) | (1 << sbus_to_pil[(irq >> 2) & 7]));
+	cc_set_imsk_other(cpuid, cc_get_imsk_other(cpuid) | ~(1 << real_irq));
 	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+#else
+	cc_set_imsk(cc_get_imsk() | ~(1 << real_irq));
+#endif
 }
 
-static void sun4d_enable_irq(unsigned int irq)
+static unsigned int sun4d_startup_irq(struct irq_data *data)
 {
-	int tid = board_to_cpu[(irq >> 5) - 1];
-	unsigned long flags;
-
-	if (irq < NR_IRQS)
-		return;
+	irq_link(data->irq);
+	sun4d_unmask_irq(data);
+	return 0;
+}
 
-	spin_lock_irqsave(&sun4d_imsk_lock, flags);
-	cc_set_imsk_other(tid, cc_get_imsk_other(tid) & ~(1 << sbus_to_pil[(irq >> 2) & 7]));
-	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+static void sun4d_shutdown_irq(struct irq_data *data)
+{
+	sun4d_mask_irq(data);
+	irq_unlink(data->irq);
 }
 
+struct irq_chip sun4d_irq = {
+	.name		= "sun4d",
+	.irq_startup	= sun4d_startup_irq,
+	.irq_shutdown	= sun4d_shutdown_irq,
+	.irq_unmask	= sun4d_unmask_irq,
+	.irq_mask	= sun4d_mask_irq,
+};
+
 #ifdef CONFIG_SMP
 static void sun4d_set_cpu_int(int cpu, int level)
 {
@@ -447,15 +292,16 @@ static void __init sun4d_load_profile_irqs(void)
 unsigned int sun4d_build_device_irq(struct platform_device *op,
                                     unsigned int real_irq)
 {
-	static int pil_to_sbus[] = {
-		0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
-	};
 	struct device_node *dp = op->dev.of_node;
 	struct device_node *io_unit, *sbi = dp->parent;
 	const struct linux_prom_registers *regs;
+	struct sun4d_handler_data *handler_data;
+	unsigned int pil;
+	unsigned int irq;
 	int board, slot;
 	int sbusl;
 
+	irq = 0;
 	while (sbi) {
 		if (!strcmp(sbi->name, "sbi"))
 			break;
@@ -488,7 +334,28 @@ unsigned int sun4d_build_device_irq(struct platform_device *op,
 
 	sbusl = pil_to_sbus[real_irq];
 	if (sbusl)
-		return (((board + 1) << 5) + (sbusl << 2) + slot);
+		pil = sun4d_encode_irq(board, sbusl, slot);
+	else
+		pil = real_irq;
+
+	irq = irq_alloc(real_irq, pil);
+	if (irq = 0)
+		goto err_out;
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
 
 err_out:
 	return real_irq;
@@ -522,6 +389,7 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 {
 	struct device_node *dp;
 	struct resource res;
+	unsigned int irq;
 	const u32 *reg;
 	int err;
 
@@ -556,9 +424,8 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 
 	master_l10_counter = &sun4d_timers->l10_cur_count;
 
-	err = request_irq(TIMER_IRQ, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC),
-			  "timer", NULL);
+	irq = sun4d_build_device_irq(NULL, SUN4D_TIMER_IRQ);
+	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
 		             err);
@@ -576,15 +443,6 @@ void __init sun4d_init_sbi_irq(void)
 #ifdef CONFIG_SMP
 	target_cpu = boot_cpu_id;
 #endif
-
-	nsbi = 0;
-	for_each_node_by_name(dp, "sbi")
-		nsbi++;
-	sbus_actions = kzalloc(nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
-	if (!sbus_actions) {
-		prom_printf("SUN4D: Cannot allocate sbus_actions, halting.\n");
-		prom_halt();
-	}
 	for_each_node_by_name(dp, "sbi") {
 		int devid = of_getintprop_default(dp, "device-id", 0);
 		int board = of_getintprop_default(dp, "board#", 0);
@@ -607,12 +465,10 @@ void __init sun4d_init_IRQ(void)
 {
 	local_irq_disable();
 
-	BTFIXUPSET_CALL(enable_irq, sun4d_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, sun4d_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NORM);
 
-	sparc_irq_config.init_timers = sun4d_init_timers;
+	sparc_irq_config.init_timers      = sun4d_init_timers;
 	sparc_irq_config.build_device_irq = sun4d_build_device_irq;
 
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 69df625..422c16d 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -100,6 +100,11 @@
 struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 struct sun4m_irq_global __iomem *sun4m_irq_global;
 
+struct sun4m_handler_data {
+	bool    percpu;
+	long    mask;
+};
+
 /* Dave Redman (djhr@tadpole.co.uk)
  * The sun4m interrupt registers.
  */
@@ -142,9 +147,9 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 #define	OBP_INT_LEVEL_VME	0x40
 
 #define SUN4M_TIMER_IRQ         (OBP_INT_LEVEL_ONBOARD | 10)
-#define SUM4M_PROFILE_IRQ       (OBP_INT_LEVEL_ONBOARD | 14)
+#define SUN4M_PROFILE_IRQ       (OBP_INT_LEVEL_ONBOARD | 14)
 
-static unsigned long irq_mask[0x50] = {
+static unsigned long sun4m_imask[0x50] = {
 	/* 0x00 - SMP */
 	0,  SUN4M_SOFT_INT(1),
 	SUN4M_SOFT_INT(2),  SUN4M_SOFT_INT(3),
@@ -169,7 +174,7 @@ static unsigned long irq_mask[0x50] = {
 	SUN4M_INT_VIDEO, SUN4M_INT_MODULE,
 	SUN4M_INT_REALTIME, SUN4M_INT_FLOPPY,
 	(SUN4M_INT_SERIAL | SUN4M_INT_KBDMS),
-	SUN4M_INT_AUDIO, 0, SUN4M_INT_MODULE_ERR,
+	SUN4M_INT_AUDIO, SUN4M_INT_E14, SUN4M_INT_MODULE_ERR,
 	/* 0x30 - sbus */
 	0, 0, SUN4M_INT_SBUS(0), SUN4M_INT_SBUS(1),
 	0, SUN4M_INT_SBUS(2), 0, SUN4M_INT_SBUS(3),
@@ -182,105 +187,110 @@ static unsigned long irq_mask[0x50] = {
 	0, SUN4M_INT_VME(6), 0, 0
 };
 
-static unsigned long sun4m_get_irqmask(unsigned int irq)
+static void sun4m_mask_irq(struct irq_data *data)
 {
-	unsigned long mask;
-
-	if (irq < 0x50)
-		mask = irq_mask[irq];
-	else
-		mask = 0;
+	struct sun4m_handler_data *handler_data = data->handler_data;
+	int cpu = smp_processor_id();
 
-	if (!mask)
-		printk(KERN_ERR "sun4m_get_irqmask: IRQ%d has no valid mask!\n",
-		       irq);
+	if (handler_data->mask) {
+		unsigned long flags;
 
-	return mask;
+		local_irq_save(flags);
+		if (handler_data->percpu) {
+			sbus_writel(handler_data->mask, &sun4m_irq_percpu[cpu]->set);
+		} else {
+			sbus_writel(handler_data->mask, &sun4m_irq_global->mask_set);
+		}
+		local_irq_restore(flags);
+	}
 }
 
-static void sun4m_disable_irq(unsigned int irq_nr)
+static void sun4m_unmask_irq(struct irq_data *data)
 {
-	unsigned long mask, flags;
+	struct sun4m_handler_data *handler_data = data->handler_data;
 	int cpu = smp_processor_id();
 
-	mask = sun4m_get_irqmask(irq_nr);
-	local_irq_save(flags);
-	if (irq_nr > 15)
-		sbus_writel(mask, &sun4m_irq_global->mask_set);
-	else
-		sbus_writel(mask, &sun4m_irq_percpu[cpu]->set);
-	local_irq_restore(flags);
-}
-
-static void sun4m_enable_irq(unsigned int irq_nr)
-{
-	unsigned long mask, flags;
-	int cpu = smp_processor_id();
+	if (handler_data->mask) {
+		unsigned long flags;
 
-	/* Dreadful floppy hack. When we use 0x2b instead of
-	 * 0x0b the system blows (it starts to whistle!).
-	 * So we continue to use 0x0b. Fixme ASAP. --P3
-	 */
-	if (irq_nr != 0x0b) {
-		mask = sun4m_get_irqmask(irq_nr);
-		local_irq_save(flags);
-		if (irq_nr > 15)
-			sbus_writel(mask, &sun4m_irq_global->mask_clear);
-		else
-			sbus_writel(mask, &sun4m_irq_percpu[cpu]->clear);
-		local_irq_restore(flags);
-	} else {
 		local_irq_save(flags);
-		sbus_writel(SUN4M_INT_FLOPPY, &sun4m_irq_global->mask_clear);
+		if (handler_data->percpu) {
+			sbus_writel(handler_data->mask, &sun4m_irq_percpu[cpu]->clear);
+		} else {
+			sbus_writel(handler_data->mask, &sun4m_irq_global->mask_clear);
+		}
 		local_irq_restore(flags);
 	}
 }
 
-static unsigned long cpu_pil_to_imask[16] = {
-/*0*/	0x00000000,
-/*1*/	0x00000000,
-/*2*/	SUN4M_INT_SBUS(0) | SUN4M_INT_VME(0),
-/*3*/	SUN4M_INT_SBUS(1) | SUN4M_INT_VME(1),
-/*4*/	SUN4M_INT_SCSI,
-/*5*/	SUN4M_INT_SBUS(2) | SUN4M_INT_VME(2),
-/*6*/	SUN4M_INT_ETHERNET,
-/*7*/	SUN4M_INT_SBUS(3) | SUN4M_INT_VME(3),
-/*8*/	SUN4M_INT_VIDEO,
-/*9*/	SUN4M_INT_SBUS(4) | SUN4M_INT_VME(4) | SUN4M_INT_MODULE_ERR,
-/*10*/	SUN4M_INT_REALTIME,
-/*11*/	SUN4M_INT_SBUS(5) | SUN4M_INT_VME(5) | SUN4M_INT_FLOPPY,
-/*12*/	SUN4M_INT_SERIAL  | SUN4M_INT_KBDMS,
-/*13*/	SUN4M_INT_SBUS(6) | SUN4M_INT_VME(6) | SUN4M_INT_AUDIO,
-/*14*/	SUN4M_INT_E14,
-/*15*/	SUN4M_INT_ERROR,
-};
+static unsigned int sun4m_startup_irq(struct irq_data *data)
+{
+	irq_link(data->irq);
+	sun4m_unmask_irq(data);
+	return 0;
+}
 
-/* We assume the caller has disabled local interrupts when these are called,
- * or else very bizarre behavior will result.
- */
-static void sun4m_disable_pil_irq(unsigned int pil)
+static void sun4m_shutdown_irq(struct irq_data *data)
 {
-	sbus_writel(cpu_pil_to_imask[pil], &sun4m_irq_global->mask_set);
+	sun4m_mask_irq(data);
+	irq_unlink(data->irq);
 }
 
-static void sun4m_enable_pil_irq(unsigned int pil)
+static struct irq_chip sun4m_irq = {
+	.name		= "sun4m",
+	.irq_startup	= sun4m_startup_irq,
+	.irq_shutdown	= sun4m_shutdown_irq,
+	.irq_mask	= sun4m_mask_irq,
+	.irq_unmask	= sun4m_unmask_irq,
+};
+
+
+static unsigned int sun4m_build_device_irq(struct platform_device *op,
+					   unsigned int real_irq)
 {
-	sbus_writel(cpu_pil_to_imask[pil], &sun4m_irq_global->mask_clear);
+	struct sun4m_handler_data *handler_data;
+	unsigned int irq;
+	unsigned int pil;
+
+	if (real_irq >= OBP_INT_LEVEL_VME) {
+		prom_printf("Bogus sun4m IRQ %u\n", real_irq);
+		prom_halt();
+	}
+	pil = (real_irq & 0xf);
+	irq = irq_alloc(real_irq, pil);
+
+	if (irq = 0)
+		goto out;
+
+	handler_data = irq_get_handler_data(irq);
+	if (unlikely(handler_data))
+		goto out;
+
+	handler_data = kzalloc(sizeof(struct sun4m_handler_data), GFP_ATOMIC);
+	if (unlikely(!handler_data)) {
+		prom_printf("IRQ: kzalloc(sun4m_handler_data) failed.\n");
+		prom_halt();
+	}
+
+	handler_data->mask = sun4m_imask[real_irq];
+	handler_data->percpu = real_irq < OBP_INT_LEVEL_ONBOARD;
+	irq_set_chip_and_handler_name(irq, &sun4m_irq,
+	                              handle_level_irq, "level");
+	irq_set_handler_data(irq, handler_data);
+
+out:
+	return irq;
 }
 
 #ifdef CONFIG_SMP
 static void sun4m_send_ipi(int cpu, int level)
 {
-	unsigned long mask = sun4m_get_irqmask(level);
-
-	sbus_writel(mask, &sun4m_irq_percpu[cpu]->set);
+	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->set);
 }
 
 static void sun4m_clear_ipi(int cpu, int level)
 {
-	unsigned long mask = sun4m_get_irqmask(level);
-
-	sbus_writel(mask, &sun4m_irq_percpu[cpu]->clear);
+	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->clear);
 }
 
 static void sun4m_set_udt(int cpu)
@@ -343,7 +353,15 @@ void sun4m_nmi(struct pt_regs *regs)
 	prom_halt();
 }
 
-/* Exported for sun4m_smp.c */
+void sun4m_unmask_profile_irq(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	sbus_writel(sun4m_imask[SUN4M_PROFILE_IRQ], &sun4m_irq_global->mask_clear);
+	local_irq_restore(flags);
+}
+
 void sun4m_clear_profile_irq(int cpu)
 {
 	sbus_readl(&timers_percpu[cpu]->l14_limit);
@@ -358,6 +376,7 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 {
 	struct device_node *dp = of_find_node_by_name(NULL, "counter");
 	int i, err, len, num_cpu_timers;
+	unsigned int irq;
 	const u32 *addr;
 
 	if (!dp) {
@@ -384,8 +403,9 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 
 	master_l10_counter = &timers_global->l10_count;
 
-	err = request_irq(SUN4M_TIMER_IRQ, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+	irq = sun4m_build_device_irq(NULL, SUN4M_TIMER_IRQ);
+
+	err = request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
 			err);
@@ -452,14 +472,11 @@ void __init sun4m_init_IRQ(void)
 	if (num_cpu_iregs = 4)
 		sbus_writel(0, &sun4m_irq_global->interrupt_target);
 
-	BTFIXUPSET_CALL(enable_irq, sun4m_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, sun4m_disable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(enable_pil_irq, sun4m_enable_pil_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_pil_irq, sun4m_disable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4m_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4m_load_profile_irq, BTFIXUPCALL_NORM);
 
 	sparc_irq_config.init_timers = sun4m_init_timers;
+	sparc_irq_config.build_device_irq = sun4m_build_device_irq;
 
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 5cc7dc5..58b8d84 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -150,20 +150,6 @@ void __init smp4m_smp_done(void)
 	/* Ok, they are spinning and ready to go. */
 }
 
-/* At each hardware IRQ, we get this called to forward IRQ reception
- * to the next processor.  The caller must disable the IRQ level being
- * serviced globally so that there are no double interrupts received.
- *
- * XXX See sparc64 irq.c.
- */
-void smp4m_irq_rotate(int cpu)
-{
-	int next = cpu_data(cpu).next;
-
-	if (next != cpu)
-		set_irq_udt(next);
-}
-
 static struct smp_funcall {
 	smpfunc_t func;
 	unsigned long arg1;
@@ -277,7 +263,7 @@ static void __cpuinit smp_setup_percpu_timer(void)
 	load_profile_irq(cpu, lvl14_resolution);
 
 	if (cpu = boot_cpu_id)
-		enable_pil_irq(14);
+		sun4m_unmask_profile_irq();
 }
 
 static void __init smp4m_blackbox_id(unsigned *addr)
-- 
1.6.0.6

