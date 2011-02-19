From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 Feb 2011 15:47:04 +0000
Subject: [PATCH 4/4] sparc32: genirq support
Message-Id: <1298130424-6934-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

generic
   Introduce use of GENERIC_HARDIRQS
   Allocate 64 IRQs - which is enough even for SS2000
   Use a table of irq_bucket to maintain uses IRQs
      irq_bucket is also used to chain several irq's that
      must be called when the same intrrupt is asserted
   Use irq_link to link a interrupt source to the irq
   All plafforms must now supply their own build_device_irq method
   Use show_interrupts from sparc64
   handler_irq rewriten to use generic irq support

floppy
   Read FLOPPY_IRQ from plat_From device
   Use generic request_irq to register the floppy interrupt
   Rewrote sparc_floppy_irq to use the generic irq support

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

   MISSING:
      There is no replacement for smp_rotate that always scheduled
      next CPU as interrupt target upon an interrupt

sun4d:
   Introduce irq_chip
   Introduce dedicated mask/unmask methods
   Introduce sun4d_handler_data that allow easy access to
   necessary data in mask/unmask fuctions
   Rename sbus_tid to board_to_cpu
   Rewrote sun4d_handler_irq to use generic irq support

   MISSING:
      The original implmentation of enable/disable had:

          if (irq < NR_IRQS)
               return;

      The new implmentation does not distingush between SBUS and cpu
      interrupts.
      I am no sure what is right here. I assume we need to do
      something for the cpu interrupts.

      I have (not yet at least) sun4d hardware available,
      and my understanding of this platfrom is limited.
      So I would be a bit suprised if this works.
      Some extra eyes on the codes would be great!

leon:
   Not converted yet - I hope the Gaisler team will look into this!

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig                 |    5 +-
 arch/sparc/include/asm/floppy_32.h |   41 ++-
 arch/sparc/include/asm/irq_32.h    |    8 +-
 arch/sparc/include/asm/system_32.h |    5 -
 arch/sparc/kernel/Makefile         |    4 -
 arch/sparc/kernel/irq.h            |   47 ++--
 arch/sparc/kernel/irq_32.c         |  506 +++++++-----------------------
 arch/sparc/kernel/kernel.h         |    7 +-
 arch/sparc/kernel/pcic.c           |   42 ---
 arch/sparc/kernel/sun4c_irq.c      |  144 +++++----
 arch/sparc/kernel/sun4d_irq.c      |  597 ++++++++++++++------------------=
----
 arch/sparc/kernel/sun4m_irq.c      |  174 ++++++-----
 arch/sparc/kernel/sun4m_smp.c      |   16 +-
 13 files changed, 594 insertions(+), 1002 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e48f471..8a44dfa 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -25,6 +25,9 @@ config SPARC
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_HARDIRQS_NO_DEPRECATED
+
=20
 config SPARC32
 	def_bool !64BIT
@@ -50,8 +53,6 @@ config SPARC64
 	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
-	select HAVE_GENERIC_HARDIRQS
-	select GENERIC_HARDIRQS_NO_DEPRECATED
=20
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/fl=
oppy_32.h
index 86666f7..77bb638 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -281,28 +281,27 @@ static inline void sun_fd_enable_dma(void)
 	pdma_areasize =3D pdma_size;
 }
=20
-/* Our low-level entry point in arch/sparc/kernel/entry.S */
-extern int sparc_floppy_request_irq(int irq, unsigned long flags,
-				    irq_handler_t irq_handler);
+extern int sparc_floppy_request_irq(unsigned int irq,
+                                    irq_handler_t irq_handler);
=20
 static int sun_fd_request_irq(void)
 {
 	static int once =3D 0;
-	int error;
=20
-	if(!once) {
+	if (!once) {
 		once =3D 1;
-		error =3D sparc_floppy_request_irq(FLOPPY_IRQ,
-						 IRQF_DISABLED,
-						 floppy_interrupt);
-		return ((error =3D 0) ? 0 : -1);
-	} else return 0;
+		return sparc_floppy_request_irq(FLOPPY_IRQ, floppy_interrupt);
+	} else {
+		return 0;
+	}
 }
=20
 static struct linux_prom_registers fd_regs[2];
=20
 static int sun_floppy_init(void)
 {
+	struct platform_device *op;
+	struct device_node *dp;
 	char state[128];
 	phandle tnode, fd_node;
 	int num_regs;
@@ -310,7 +309,6 @@ static int sun_floppy_init(void)
=20
 	use_virtual_dma =3D 1;
=20
-	FLOPPY_IRQ =3D 11;
 	/* Forget it if we aren't on a machine that could possibly
 	 * ever have a floppy drive.
 	 */
@@ -349,6 +347,27 @@ static int sun_floppy_init(void)
 	sun_fdc =3D (struct sun_flpy_controller *)
 	    of_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");
=20
+	/*
+	 * Look up irq in platform_device.
+	 * We try "SUNW,fdtwo" and "fd"
+	 */
+	for_each_node_by_name(dp, "SUNW,fdtwo") {
+		op =3D of_find_device_by_node(dp);
+		if (op)
+			break;
+	}
+	if (!op) {
+		for_each_node_by_name(dp, "fd") {
+			op =3D of_find_device_by_node(dp);
+			if (op)
+				break;
+		}
+	}
+	if (!op)
+		goto no_sun_fdc;
+
+	FLOPPY_IRQ =3D op->archdata.irqs[0];
+
 	/* Last minute sanity check... */
 	if(sun_fdc->status_82072 =3D 0xff) {
 		sun_fdc =3D NULL;
diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_3=
2.h
index cbf4801..1618889 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -6,11 +6,17 @@
 #ifndef _SPARC_IRQ_H
 #define _SPARC_IRQ_H
=20
-#define NR_IRQS    16
+/*
+ * Allocated number of logical irq numbers.
+ * sun4d boxes (ss2000e) should be OK with ~32.
+ * Be on the safe side and make room for 64
+ */
+#define NR_IRQS    64
=20
 #include <linux/interrupt.h>
=20
 #define irq_canonicalize(irq)	(irq)
=20
 extern void __init init_IRQ(void);
+
 #endif
diff --git a/arch/sparc/include/asm/system_32.h b/arch/sparc/include/asm/sy=
stem_32.h
index 890036b..47a7e86 100644
--- a/arch/sparc/include/asm/system_32.h
+++ b/arch/sparc/include/asm/system_32.h
@@ -15,11 +15,6 @@
=20
 #include <linux/irqflags.h>
=20
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
@@ -71,10 +71,6 @@ obj-$(CONFIG_SPARC64)	+=3D pcr.o
 obj-$(CONFIG_SPARC64)	+=3D nmi.o
 obj-$(CONFIG_SPARC64_SMP) +=3D cpumap.o
=20
-# sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implemen=
tation
-obj-$(CONFIG_SPARC32)     +=3D devres.o
-devres-y                  :=3D ../../../kernel/irq/devres.o
-
 obj-y                     +=3D dma.o
=20
 obj-$(CONFIG_SPARC32_PCI) +=3D pcic.o
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 2c2ce9b..68bb10c 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -2,6 +2,23 @@
=20
 #include <asm/btfixup.h>
=20
+struct irq_bucket {
+        struct irq_bucket *next;
+        unsigned int real_irq;
+        unsigned int irq;
+        unsigned int pil;
+};
+
+#define SUN4D_MAX_BOARD 10
+#define SUN4D_MAX_IRQ ((SUN4D_MAX_BOARD + 2) << 5)
+/*
+ * Map between the irq identifier used in hw to the
+ * irq_bucket. The map is sufficient large to hold
+ * the sun4d hw identifiers.
+ */
+extern struct irq_bucket *irq_map[SUN4D_MAX_IRQ];
+
+
 /* sun4m specific type definitions */
=20
 /* This maps direct to CPU specific interrupt registers */
@@ -30,10 +47,14 @@ extern struct sun4m_irq_global __iomem *sun4m_irq_globa=
l;
  */
 struct sparc_irq_config {
 	void (*init_timers)(irq_handler_t);
-	int (*build_device_irq)(struct platform_device *op, int interrupt);
+	unsigned int (*build_device_irq)(struct platform_device *op,
+	                                 unsigned int interrupt);
 };
 extern struct sparc_irq_config sparc_irq_config;
=20
+unsigned int irq_alloc(unsigned int real_irq, unsigned int pil);
+void irq_link(unsigned int irq);
+void handler_irq(unsigned int pil, struct pt_regs *regs);
=20
 /* Dave Redman (djhr@tadpole.co.uk)
  * changed these to function pointers.. it saves cycles and will allow
@@ -43,33 +64,9 @@ extern struct sparc_irq_config sparc_irq_config;
  * Changed these to btfixup entities... It saves cycles :)
  */
=20
-BTFIXUPDEF_CALL(void, disable_irq, unsigned int)
-BTFIXUPDEF_CALL(void, enable_irq, unsigned int)
-BTFIXUPDEF_CALL(void, disable_pil_irq, unsigned int)
-BTFIXUPDEF_CALL(void, enable_pil_irq, unsigned int)
 BTFIXUPDEF_CALL(void, clear_clock_irq, void)
 BTFIXUPDEF_CALL(void, load_profile_irq, int, unsigned int)
=20
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
index 46453a7..cbccb08 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -14,6 +14,9 @@
 #include <linux/kernel_stat.h>
 #include <linux/seq_file.h>
=20
+#include <asm/cacheflush.h>
+#include <asm/cpudata.h>
+#include <asm/traps.h>
 #include <asm/pcic.h>
 #include <asm/leon.h>
=20
@@ -100,284 +103,163 @@ EXPORT_SYMBOL(arch_local_irq_restore);
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
=20
=20
+/* Table of allocated irqs. Unused entries has irq =3D 0 */
+static struct irq_bucket irq_table[NR_IRQS];
+
+/* Map between the irq identifier used in hw to theirq_bucket. */
+struct irq_bucket *irq_map[SUN4D_MAX_IRQ];
=20
 /*
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
+ * Allocate a new irq from the irq_table
  */
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
-
-int show_interrupts(struct seq_file *p, void *v)
+unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
 {
-	int i =3D *(loff_t *)v;
-	struct irqaction *action;
-	unsigned long flags;
-#ifdef CONFIG_SMP
-	int j;
-#endif
-
-	if (sparc_cpu_model =3D sun4d)
-		return show_sun4d_interrupts(p, v);
+	unsigned int i;
=20
-	spin_lock_irqsave(&irq_action_lock, flags);
-	if (i < NR_IRQS) {
-		action =3D sparc_irq[i].action;
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
-		for (action =3D action->next; action; action =3D action->next) {
-			seq_printf(p, ",%s %s",
-				(action->flags & IRQF_DISABLED) ? " +" : "",
-				action->name);
-		}
-		seq_putc(p, '\n');
+	for (i =3D 1; i < NR_IRQS; i++) {
+		if (irq_table[i].real_irq =3D real_irq && irq_table[i].pil =3D pil)
+			return i;
 	}
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-	return 0;
-}
=20
-void free_irq(unsigned int irq, void *dev_id)
-{
-	struct irqaction *action;
-	struct irqaction **actionp;
-	unsigned long flags;
-	unsigned int cpu_irq;
-
-	if (sparc_cpu_model =3D sun4d) {
-		sun4d_free_irq(irq, dev_id);
-		return;
-	}
-	cpu_irq =3D irq & (NR_IRQS - 1);
-	if (cpu_irq > 14) {  /* 14 irq levels on the sparc */
-		printk(KERN_ERR "Trying to free bogus IRQ %d\n", irq);
-		return;
+	for (i =3D 1; i < NR_IRQS; i++) {
+		if (!irq_table[i].irq)
+			break;
 	}
=20
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	actionp =3D &sparc_irq[cpu_irq].action;
-	action =3D *actionp;
-
-	if (!action->handler) {
-		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
-		goto out_unlock;
-	}
-	if (dev_id) {
-		for (; action; action =3D action->next) {
-			if (action->dev_id =3D dev_id)
-				break;
-			actionp =3D &action->next;
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
+	if (i >=3D NR_IRQS) {
+		printk(KERN_ERR "IRQ: Out of virtual IRQs.\n");
+		return 0;
 	}
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
-	*actionp =3D action->next;
-
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-
-	synchronize_irq(irq);
-
-	spin_lock_irqsave(&irq_action_lock, flags);
+	irq_table[i].real_irq =3D real_irq;
+	irq_table[i].irq =3D i;
+	irq_table[i].pil =3D pil;
=20
-	kfree(action);
-
-	if (!sparc_irq[cpu_irq].action)
-		__disable_irq(irq);
-
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
+	return i;
 }
-EXPORT_SYMBOL(free_irq);
=20
 /*
- * This is called when we want to synchronize with
- * interrupts. We may for example tell a device to
- * stop sending interrupts: but to make sure there
- * are no interrupts that are executing on another
- * CPU we need to call this function.
+ * Based on a single pil handler_irq may need to call several
+ * interrupt handlers. Use irq_map as entry to irq_table,
+ * and let each entry in irq_table point to the next entry.
  */
-#ifdef CONFIG_SMP
-void synchronize_irq(unsigned int irq)
+void irq_link(unsigned int irq)
 {
-	unsigned int cpu_irq;
+	struct irq_bucket *p;
+	unsigned int pil;
+
+	BUG_ON(irq >=3D NR_IRQS);
=20
-	cpu_irq =3D irq & (NR_IRQS - 1);
-	while (sparc_irq[cpu_irq].flags & SPARC_IRQ_INPROGRESS)
-		cpu_relax();
+	p =3D &irq_table[irq];
+	pil =3D p->pil;
+	BUG_ON(pil > SUN4D_MAX_IRQ);
+	p->next =3D irq_map[pil];
+	irq_map[pil] =3D p;
 }
-EXPORT_SYMBOL(synchronize_irq);
-#endif /* SMP */
=20
-void unexpected_irq(int irq, void *dev_id, struct pt_regs *regs)
+int show_interrupts(struct seq_file *p, void *v)
 {
-	int i;
+	int i =3D *(loff_t *) v, j;
 	struct irqaction *action;
-	unsigned int cpu_irq;
+	unsigned long flags;
=20
-	cpu_irq =3D irq & (NR_IRQS - 1);
-	action =3D sparc_irq[cpu_irq].action;
-
-	printk(KERN_ERR "IO device interrupt, irq =3D %d\n", irq);
-	printk(KERN_ERR "PC =3D %08lx NPC =3D %08lx FP=3D%08lx\n", regs->pc,
-		    regs->npc, regs->u_regs[14]);
-	if (action) {
-		printk(KERN_ERR "Expecting: ");
-		for (i =3D 0; i < 16; i++)
-			if (action->handler)
-				printk(KERN_CONT "[%s:%d:0x%x] ", action->name,
-				       i, (unsigned int)action->handler);
+	if (i =3D 0) {
+		seq_printf(p, "           ");
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
+		seq_putc(p, '\n');
 	}
-	printk(KERN_ERR "AIEEE\n");
-	panic("bogus interrupt received");
+
+	if (i < NR_IRQS) {
+		raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
+		action =3D irq_desc[i].action;
+		if (!action)
+			goto skip;
+		seq_printf(p, "%3d: ",i);
+#ifndef CONFIG_SMP
+		seq_printf(p, "%10u ", kstat_irqs(i));
+#else
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
+#endif
+		seq_printf(p, " %9s", irq_desc[i].irq_data.chip->name);
+		seq_printf(p, "  %s", action->name);
+
+		for (action=ACtion->next; action; action =3D action->next)
+			seq_printf(p, ", %s", action->name);
+
+		seq_putc(p, '\n');
+skip:
+		raw_spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+	} else if (i =3D NR_IRQS) {
+		seq_printf(p, "NMI: ");
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", cpu_data(j).counter);
+		seq_printf(p, "     Non-maskable interrupts\n");
+	}
+	return 0;
 }
=20
-void handler_irq(int pil, struct pt_regs *regs)
+void handler_irq(unsigned int pil, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	struct irqaction *action;
-	int cpu =3D smp_processor_id();
+	struct irq_bucket *p;
=20
+	BUG_ON(pil > 15);
 	old_regs =3D set_irq_regs(regs);
 	irq_enter();
-	disable_pil_irq(pil);
-#ifdef CONFIG_SMP
-	/* Only rotate on lower priority IRQs (scsi, ethernet, etc.). */
-	if ((sparc_cpu_model=3Dsun4m) && (pil < 10))
-		smp4m_irq_rotate(cpu);
-#endif
-	action =3D sparc_irq[pil].action;
-	sparc_irq[pil].flags |=3D SPARC_IRQ_INPROGRESS;
-	kstat_cpu(cpu).irqs[pil]++;
-	do {
-		if (!action || !action->handler)
-			unexpected_irq(pil, NULL, regs);
-		action->handler(pil, action->dev_id);
-		action =3D action->next;
-	} while (action);
-	sparc_irq[pil].flags &=3D ~SPARC_IRQ_INPROGRESS;
-	enable_pil_irq(pil);
+
+	p =3D irq_map[pil];
+	while (p) {
+		struct irq_bucket *next =3D p->next;
+
+		generic_handle_irq(p->irq);
+		p =3D next;
+	}
 	irq_exit();
 	set_irq_regs(old_regs);
 }
=20
 #if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
+static unsigned int floppy_irq;
=20
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
-	cpu_irq =3D irq & (NR_IRQS - 1);
-	if (cpu_irq > 14) {
-		ret =3D -EINVAL;
-		goto out;
-	}
-	if (!handler) {
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	action =3D sparc_irq[cpu_irq].action;
-	if (action) {
-		if (action->flags & IRQF_SHARED)
-			panic("Trying to register fast irq when already shared.\n");
-		if (irqflags & IRQF_SHARED)
-			panic("Trying to register fast irq as shared.\n");
=20
-		/* Anyway, someone already owns it so cannot be made fast. */
-		printk(KERN_ERR "request_fast_irq: Trying to register yet already owned.=
\n");
-		ret =3D -EBUSY;
-		goto out_unlock;
-	}
+	err =3D request_irq(irq, irq_handler, 0, "floppy", NULL);
+	if (err)
+		return -1;
=20
-	/*
-	 * If this is flagged as statically allocated then we use our
-	 * private struct which is never freed.
-	 */
-	if (irqflags & SA_STATIC_ALLOC) {
-		if (static_irq_count < MAX_STATIC_ALLOC)
-			action =3D &static_irqaction[static_irq_count++];
-		else
-			printk(KERN_ERR "Fast IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n=
",
-			       irq, devname);
-	}
+	/* Save for later use in floppy interrupt handler */
+	floppy_irq =3D irq;
=20
-	if (action =3D NULL)
-		action =3D kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-	if (!action) {
-		ret =3D -ENOMEM;
-		goto out_unlock;
-	}
+	cpu_irq =3D (irq & (NR_IRQS - 1));
=20
 	/* Dork with trap table if we get this far. */
 #define INSTANTIATE(table) \
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_one =3D SPARC_RD_PSR_L0; \
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two =3D \
-		SPARC_BRANCH((unsigned long) handler, \
+		SPARC_BRANCH((unsigned long) floppy_hardint, \
 			     (unsigned long) &table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two);\
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_three =3D SPARC_RD_WIM_L3; \
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four =3D SPARC_NOP;
@@ -398,22 +280,9 @@ static int request_fast_irq(unsigned int irq,
 	 * writing we have no CPU-neutral interface to fine-grained flushes.
 	 */
 	flush_cache_all();
-
-	action->flags =3D irqflags;
-	action->name =3D devname;
-	action->dev_id =3D NULL;
-	action->next =3D NULL;
-
-	sparc_irq[cpu_irq].action =3D action;
-
-	__enable_irq(irq);
-
-	ret =3D 0;
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-out:
-	return ret;
+	return 0;
 }
+EXPORT_SYMBOL(sparc_floppy_request_irq);
=20
 /*
  * These variables are used to access state from the assembler
@@ -439,153 +308,26 @@ EXPORT_SYMBOL(pdma_base);
 unsigned long pdma_areasize;
 EXPORT_SYMBOL(pdma_areasize);
=20
-static irq_handler_t floppy_irq_handler;
-
+/*
+ * Use the generic irq support to call floppy_interrupt
+ * which was setup using request_irq() in sparc_floppy_request_irq().
+ * We only have one floppy interrupt so we do not need to check
+ * for additional handlers being wired up by irq_link()
+ */
 void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	int cpu =3D smp_processor_id();
+	struct irq_desc *desc;
=20
 	old_regs =3D set_irq_regs(regs);
-	disable_pil_irq(irq);
 	irq_enter();
-	kstat_cpu(cpu).irqs[irq]++;
-	floppy_irq_handler(irq, dev_id);
-	irq_exit();
-	enable_pil_irq(irq);
-	set_irq_regs(old_regs);
-	/*
-	 * XXX Eek, it's totally changed with preempt_count() and such
-	 * if (softirq_pending(cpu))
-	 *	do_softirq();
-	 */
-}
=20
-int sparc_floppy_request_irq(int irq, unsigned long flags,
-			     irq_handler_t irq_handler)
-{
-	floppy_irq_handler =3D irq_handler;
-	return request_fast_irq(irq, floppy_hardint, flags, "floppy");
+	desc =3D irq_to_desc(floppy_irq);
+	desc->handle_irq(irq, desc);
+	irq_exit();
 }
-EXPORT_SYMBOL(sparc_floppy_request_irq);
-
 #endif
=20
-int request_irq(unsigned int irq,
-		irq_handler_t handler,
-		unsigned long irqflags, const char *devname, void *dev_id)
-{
-	struct irqaction *action, **actionp;
-	unsigned long flags;
-	unsigned int cpu_irq;
-	int ret;
-
-	if (sparc_cpu_model =3D sun4d)
-		return sun4d_request_irq(irq, handler, irqflags, devname, dev_id);
-
-	cpu_irq =3D irq & (NR_IRQS - 1);
-	if (cpu_irq > 14) {
-		ret =3D -EINVAL;
-		goto out;
-	}
-	if (!handler) {
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	actionp =3D &sparc_irq[cpu_irq].action;
-	action =3D *actionp;
-	if (action) {
-		if (!(action->flags & IRQF_SHARED) || !(irqflags & IRQF_SHARED)) {
-			ret =3D -EBUSY;
-			goto out_unlock;
-		}
-		if ((action->flags & IRQF_DISABLED) !=3D (irqflags & IRQF_DISABLED)) {
-			printk(KERN_ERR "Attempt to mix fast and slow interrupts on IRQ%d denie=
d\n",
-			       irq);
-			ret =3D -EBUSY;
-			goto out_unlock;
-		}
-		for ( ; action; action =3D *actionp)
-			actionp =3D &action->next;
-	}
-
-	/* If this is flagged as statically allocated then we use our
-	 * private struct which is never freed.
-	 */
-	if (irqflags & SA_STATIC_ALLOC) {
-		if (static_irq_count < MAX_STATIC_ALLOC)
-			action =3D &static_irqaction[static_irq_count++];
-		else
-			printk(KERN_ERR "Request for IRQ%d (%s) SA_STATIC_ALLOC failed using km=
alloc\n",
-			       irq, devname);
-	}
-	if (action =3D NULL)
-		action =3D kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-	if (!action) {
-		ret =3D -ENOMEM;
-		goto out_unlock;
-	}
-
-	action->handler =3D handler;
-	action->flags =3D irqflags;
-	action->name =3D devname;
-	action->next =3D NULL;
-	action->dev_id =3D dev_id;
-
-	*actionp =3D action;
-
-	__enable_irq(irq);
-
-	ret =3D 0;
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
-static int build_device_irq(struct platform_device *op, int interrupt)
-{
-	return interrupt;
-}
-
 /* djhr
  * This could probably be made indirect too and assigned in the CPU
  * bits of the code. That would be much nicer I think and would also
@@ -596,8 +338,6 @@ static int build_device_irq(struct platform_device *op,=
 int interrupt)
=20
 void __init init_IRQ(void)
 {
-	sparc_irq_config.build_device_irq =3D build_device_irq;
-
 	switch (sparc_cpu_model) {
 	case sun4c:
 	case sun4:
@@ -630,9 +370,3 @@ void __init init_IRQ(void)
 	btfixup();
 }
=20
-#ifdef CONFIG_PROC_FS
-void init_irq_proc(void)
-{
-	/* For now, nothing... */
-}
-#endif /* CONFIG_PROC_FS */
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 7eb7363..efe43a9 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -35,6 +35,7 @@ extern void sun4c_init_IRQ(void);
 extern unsigned int lvl14_resolution;
=20
 extern void sun4m_init_IRQ(void);
+extern void sun4m_unmask_profile_irq(void);
 extern void sun4m_clear_profile_irq(int cpu);
=20
 /* sun4d_irq.c */
@@ -54,9 +55,9 @@ extern unsigned int t_nmi[];
 extern unsigned int linux_trap_ipi15_sun4d[];
 extern unsigned int linux_trap_ipi15_sun4m[];
=20
-extern unsigned long trapbase_cpu1[];
-extern unsigned long trapbase_cpu2[];
-extern unsigned long trapbase_cpu3[];
+extern struct tt_entry trapbase_cpu1;
+extern struct tt_entry trapbase_cpu2;
+extern struct tt_entry trapbase_cpu3;
=20
 extern char cputypval[];
=20
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index aeaa09a..7183c24 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -800,55 +800,13 @@ void pcic_nmi(unsigned int pend, struct pt_regs *regs)
 	regs->npc +=3D 4;
 }
=20
-static inline unsigned long get_irqmask(int irq_nr)
-{
-	return 1 << irq_nr;
-}
-
-static void pcic_disable_irq(unsigned int irq_nr)
-{
-	unsigned long mask, flags;
-
-	mask =3D get_irqmask(irq_nr);
-	local_irq_save(flags);
-	writel(mask, pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_SET);
-	local_irq_restore(flags);
-}
-
-static void pcic_enable_irq(unsigned int irq_nr)
-{
-	unsigned long mask, flags;
-
-	mask =3D get_irqmask(irq_nr);
-	local_irq_save(flags);
-	writel(mask, pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_CLEAR);
-	local_irq_restore(flags);
-}
-
 static void pcic_load_profile_irq(int cpu, unsigned int limit)
 {
 	printk("PCIC: unimplemented code: FILE=3D%s LINE=3D%d", __FILE__, __LINE_=
_);
 }
=20
-/* We assume the caller has disabled local interrupts when these are calle=
d,
- * or else very bizarre behavior will result.
- */
-static void pcic_disable_pil_irq(unsigned int pil)
-{
-	writel(get_irqmask(pil), pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_SET);
-}
-
-static void pcic_enable_pil_irq(unsigned int pil)
-{
-	writel(get_irqmask(pil), pcic0.pcic_regs+PCI_SYS_INT_TARGET_MASK_CLEAR);
-}
-
 void __init sun4m_pci_init_IRQ(void)
 {
-	BTFIXUPSET_CALL(enable_irq, pcic_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, pcic_disable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(enable_pil_irq, pcic_enable_pil_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_pil_irq, pcic_disable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, pcic_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, pcic_load_profile_irq, BTFIXUPCALL_NORM=
);
 }
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 90eea38..e9b47d4 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -65,62 +65,88 @@
  */
 unsigned char __iomem *interrupt_enable;
=20
-static void sun4c_disable_irq(unsigned int irq_nr)
+static void sun4c_mask_irq(struct irq_data *data)
 {
-	unsigned long flags;
-	unsigned char current_mask, new_mask;
-
-	local_irq_save(flags);
-	irq_nr &=3D (NR_IRQS - 1);
-	current_mask =3D sbus_readb(interrupt_enable);
-	switch (irq_nr) {
-	case 1:
-		new_mask =3D ((current_mask) & (~(SUN4C_INT_E1)));
-		break;
-	case 8:
-		new_mask =3D ((current_mask) & (~(SUN4C_INT_E8)));
-		break;
-	case 10:
-		new_mask =3D ((current_mask) & (~(SUN4C_INT_E10)));
-		break;
-	case 14:
-		new_mask =3D ((current_mask) & (~(SUN4C_INT_E14)));
-		break;
-	default:
+	unsigned long mask =3D (unsigned long)data->chip_data;
+
+	if (mask) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		mask =3D sbus_readb(interrupt_enable) & ~mask;
+		sbus_writeb(mask, interrupt_enable);
 		local_irq_restore(flags);
-		return;
 	}
-	sbus_writeb(new_mask, interrupt_enable);
-	local_irq_restore(flags);
 }
=20
-static void sun4c_enable_irq(unsigned int irq_nr)
+static void sun4c_unmask_irq(struct irq_data *data)
 {
-	unsigned long flags;
-	unsigned char current_mask, new_mask;
-
-	local_irq_save(flags);
-	irq_nr &=3D (NR_IRQS - 1);
-	current_mask =3D sbus_readb(interrupt_enable);
-	switch (irq_nr) {
-	case 1:
-		new_mask =3D ((current_mask) | SUN4C_INT_E1);
-		break;
-	case 8:
-		new_mask =3D ((current_mask) | SUN4C_INT_E8);
-		break;
-	case 10:
-		new_mask =3D ((current_mask) | SUN4C_INT_E10);
-		break;
-	case 14:
-		new_mask =3D ((current_mask) | SUN4C_INT_E14);
-		break;
-	default:
+	unsigned long mask =3D (unsigned long)data->chip_data;
+
+	if (mask) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		mask =3D sbus_readb(interrupt_enable) | mask;
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
+static struct irq_chip sun4c_irq =3D {
+	.name		=3D "sun4c",
+	.irq_startup	=3D sun4c_startup_irq,
+	.irq_mask	=3D sun4c_mask_irq,
+	.irq_unmask	=3D sun4c_unmask_irq,
+};
+
+static unsigned int sun4c_build_device_irq(struct platform_device *op,
+					   unsigned int real_irq)
+{
+	 unsigned int irq;
+
+	if (real_irq >=3D 16) {
+		prom_printf("Bogus sun4c IRQ %u\n", real_irq);
+		prom_halt();
+	}
+
+	irq =3D irq_alloc(real_irq, real_irq);
+	if (irq) {
+		unsigned long mask =3D 0UL;
+
+		switch (real_irq) {
+		case 1:
+			mask =3D SUN4C_INT_E1;
+			break;
+		case 8:
+			mask =3D SUN4C_INT_E8;
+			break;
+		case 10:
+			mask =3D SUN4C_INT_E10;
+			break;
+		case 14:
+			mask =3D SUN4C_INT_E14;
+			break;
+		default:
+			/*
+			 * All the rest are either always enabled,
+			 * or are for signalling software interrupts.
+			 */
+			break;
+		}
+		set_irq_chip_and_handler_name(irq, &sun4c_irq,
+		                              handle_level_irq, "SUN4C");
+		set_irq_chip_data(irq, (void *)mask);
+	}
+	return irq;
 }
=20
 struct sun4c_timer_info {
@@ -144,8 +170,9 @@ static void sun4c_load_profile_irq(int cpu, unsigned in=
t limit)
=20
 static void __init sun4c_init_timers(irq_handler_t counter_fn)
 {
-	const struct linux_prom_irqs *irq;
+	const struct linux_prom_irqs *prom_irqs;
 	struct device_node *dp;
+	unsigned int irq;
 	const u32 *addr;
 	int err;
=20
@@ -163,9 +190,9 @@ static void __init sun4c_init_timers(irq_handler_t coun=
ter_fn)
=20
 	sun4c_timers =3D (void __iomem *) (unsigned long) addr[0];
=20
-	irq =3D of_get_property(dp, "intr", NULL);
+	prom_irqs =3D of_get_property(dp, "intr", NULL);
 	of_node_put(dp);
-	if (!irq) {
+	if (!prom_irqs) {
 		prom_printf("sun4c_init_timers: No intr property\n");
 		prom_halt();
 	}
@@ -178,15 +205,15 @@ static void __init sun4c_init_timers(irq_handler_t co=
unter_fn)
=20
 	master_l10_counter =3D &sun4c_timers->l10_count;
=20
-	err =3D request_irq(irq[0].pri, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC),
-			  "timer", NULL);
+	irq =3D sun4c_build_device_irq(NULL, prom_irqs[0].pri);
+	err =3D request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
 	}
=20
-	sun4c_disable_irq(irq[1].pri);
+	/* disable timer interrupt */
+	sun4c_mask_irq(irq_get_irq_data(irq));
 }
=20
 #ifdef CONFIG_SMP
@@ -215,14 +242,11 @@ void __init sun4c_init_IRQ(void)
=20
 	interrupt_enable =3D (void __iomem *) (unsigned long) addr[0];
=20
-	BTFIXUPSET_CALL(enable_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(enable_pil_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_pil_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4c_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4c_load_profile_irq, BTFIXUPCALL_NOP=
);
=20
-	sparc_irq_config.init_timers =3D sun4c_init_timers;
+	sparc_irq_config.init_timers      =3D sun4c_init_timers;
+	sparc_irq_config.build_device_irq =3D sun4c_build_device_irq;
=20
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 6388087..67f1cf9 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -18,26 +18,25 @@
 #include "kernel.h"
 #include "irq.h"
=20
-/* Sun4d interrupts fall roughly into two categories.  SBUS and
+/*
+ * Sun4d interrupts fall roughly into two categories.  SBUS and
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
=20
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
@@ -48,17 +47,13 @@ struct sun4d_timer_regs {
=20
 static struct sun4d_timer_regs __iomem *sun4d_timers;
=20
-#define TIMER_IRQ	10
-
-#define MAX_STATIC_ALLOC	4
-static unsigned char sbus_tid[32];
-
-static struct irqaction *irq_action[NR_IRQS];
+#define SUN4D_TIMER_IRQ	10
=20
-static struct sbus_action {
-	struct irqaction *action;
-	/* For SMP this needs to be extended */
-} *sbus_actions;
+/*
+ * Specify which cpu handle interrupts from which board.
+ * Index is board, value is cpu.
+ */
+static unsigned char board_to_cpu[32];
=20
 static int pil_to_sbus[] =3D {
 	0,
@@ -79,152 +74,82 @@ static int pil_to_sbus[] =3D {
 	0,
 };
=20
-static int sbus_to_pil[] =3D {
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
=20
-int show_sun4d_interrupts(struct seq_file *p, void *v)
+/*
+ * SBUS interrupts are encoded integers including the board number
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
-	int i =3D *(loff_t *) v, j =3D 0, k =3D 0, sbusl;
-	struct irqaction *action;
-	unsigned long flags;
-#ifdef CONFIG_SMP
-	int x;
-#endif
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-	if (i < NR_IRQS) {
-		sbusl =3D pil_to_sbus[i];
-		if (!sbusl) {
-			action =3D *(i + irq_action);
-			if (!action)
-				goto out_unlock;
-		} else {
-			for (j =3D 0; j < nsbi; j++) {
-				for (k =3D 0; k < 4; k++)
-					action =3D sbus_actions[(j << 5) + (sbusl << 2) + k].action;
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
-		action =3D action->next;
-		for (;;) {
-			for (; action; action =3D action->next) {
-				seq_printf(p, ",%s %s",
-					(action->flags & IRQF_DISABLED) ? " +" : "",
-					action->name);
-			}
-			if (!sbusl)
-				break;
-			k++;
-			if (k < 4) {
-				action =3D sbus_actions[(j << 5) + (sbusl << 2) + k].action;
-			} else {
-				j++;
-				if (j =3D nsbi)
-					break;
-				k =3D 0;
-				action =3D sbus_actions[(j << 5) + (sbusl << 2)].action;
+	unsigned int bus_mask;
+	unsigned int sbino, slot;
+	unsigned int sbil;
+
+	bus_mask =3D bw_get_intr_mask(sbusl) & 0x3ffff;
+	bw_clear_intr_mask(sbusl, bus_mask);
+
+	sbil =3D (sbusl << 2);
+	/* Loop for each pending SBI */
+	for (sbino =3D 0; bus_mask; sbino++) {
+		unsigned int idx, mask;
+
+		bus_mask >>=3D 1;
+		if (!(bus_mask & 1))
+			continue;
+		/* XXX This seems to ACK the irq twice.  acquire_sbi()
+		 * XXX uses swap, therefore this writes 0xf << sbil,
+		 * XXX then later release_sbi() will write the individual
+		 * XXX bits which were set again.
+		 */
+		mask =3D acquire_sbi(SBI2DEVID(sbino), 0xf << sbil);
+		mask &=3D (0xf << sbil);
+
+		/* Loop for each pending SBI slot */
+		idx =3D 0;
+		slot =3D (1 << sbil);
+		while (mask !=3D 0) {
+			unsigned int pil;
+			struct irq_bucket *p;
+
+			idx++;
+			slot <<=3D 1;
+			if (!(mask & slot))
+				continue;
+
+			mask &=3D ~slot;
+			pil =3D sun4d_encode_irq(sbino, sbil, idx);
+
+			p =3D irq_map[pil];
+			while (p) {
+				struct irq_bucket *next;
+
+				next =3D p->next;
+				generic_handle_irq(p->irq);
+				p =3D next;
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
-	struct irqaction *tmp =3D NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-	if (irq < 15)
-		actionp =3D irq + irq_action;
-	else
-		actionp =3D &(sbus_actions[irq - (1 << 5)].action);
-	action =3D *actionp;
-	if (!action) {
-		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
-		goto out_unlock;
-	}
-	if (dev_id) {
-		for (; action; action =3D action->next) {
-			if (action->dev_id =3D dev_id)
-				break;
-			tmp =3D action;
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
-		tmp->next =3D action->next;
-	else
-		*actionp =3D action->next;
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
=20
 void sun4d_handler_irq(int pil, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	struct irqaction *action;
-	int cpu =3D smp_processor_id();
 	/* SBUS IRQ level (1 - 7) */
 	int sbusl =3D pil_to_sbus[pil];
=20
@@ -235,158 +160,84 @@ void sun4d_handler_irq(int pil, struct pt_regs *regs)
=20
 	old_regs =3D set_irq_regs(regs);
 	irq_enter();
-	kstat_cpu(cpu).irqs[pil]++;
-	if (!sbusl) {
-		action =3D *(pil + irq_action);
-		if (!action)
-			unexpected_irq(pil, NULL, regs);
-		do {
-			action->handler(pil, action->dev_id);
-			action =3D action->next;
-		} while (action);
+	if (sbusl =3D 0) {
+		/* cpu interrupt */
+		struct irq_bucket *p;
+
+		p =3D irq_map[pil];
+		while (p) {
+			struct irq_bucket *next;
+
+			next =3D p->next;
+			generic_handle_irq(p->irq);
+			p =3D next;
+		}
 	} else {
-		int bus_mask =3D bw_get_intr_mask(sbusl) & 0x3ffff;
-		int sbino;
-		struct sbus_action *actionp;
-		unsigned mask, slot;
-		int sbil =3D (sbusl << 2);
-
-		bw_clear_intr_mask(sbusl, bus_mask);
-
-		/* Loop for each pending SBI */
-		for (sbino =3D 0; bus_mask; sbino++, bus_mask >>=3D 1)
-			if (bus_mask & 1) {
-				mask =3D acquire_sbi(SBI2DEVID(sbino), 0xf << sbil);
-				mask &=3D (0xf << sbil);
-				actionp =3D sbus_actions + (sbino << 5) + (sbil);
-				/* Loop for each pending SBI slot */
-				for (slot =3D (1 << sbil); mask; slot <<=3D 1, actionp++)
-					if (mask & slot) {
-						mask &=3D ~slot;
-						action =3D actionp->action;
-
-						if (!action)
-							unexpected_irq(pil, NULL, regs);
-						do {
-							action->handler(pil, action->dev_id);
-							action =3D action->next;
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
=20
-int sun4d_request_irq(unsigned int irq,
-		irq_handler_t handler,
-		unsigned long irqflags, const char *devname, void *dev_id)
+static void sun4d_mask_irq(struct irq_data *data)
 {
-	struct irqaction *action, *tmp =3D NULL, **actionp;
+	struct sun4d_handler_data *handler_data =3D data->handler_data;
+	unsigned int real_irq;
+#ifdef CONFIG_SMP
+	int cpuid =3D handler_data->cpuid;
 	unsigned long flags;
-	int ret;
-
-	if (irq > 14 && irq < (1 << 5)) {
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	if (!handler) {
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	if (irq >=3D (1 << 5))
-		actionp =3D &(sbus_actions[irq - (1 << 5)].action);
-	else
-		actionp =3D irq + irq_action;
-	action =3D *actionp;
-
-	if (action) {
-		if ((action->flags & IRQF_SHARED) && (irqflags & IRQF_SHARED)) {
-			for (tmp =3D action; tmp->next; tmp =3D tmp->next)
-				/* find last entry - tmp used below */;
-		} else {
-			ret =3D -EBUSY;
-			goto out_unlock;
-		}
-		if ((action->flags & IRQF_DISABLED) ^ (irqflags & IRQF_DISABLED)) {
-			printk(KERN_ERR "Attempt to mix fast and slow interrupts on IRQ%d denie=
d\n",
-			       irq);
-			ret =3D -EBUSY;
-			goto out_unlock;
-		}
-		action =3D NULL;		/* Or else! */
-	}
-
-	/* If this is flagged as statically allocated then we use our
-	 * private struct which is never freed.
-	 */
-	if (irqflags & SA_STATIC_ALLOC) {
-		if (static_irq_count < MAX_STATIC_ALLOC)
-			action =3D &static_irqaction[static_irq_count++];
-		else
-			printk(KERN_ERR "Request for IRQ%d (%s) SA_STATIC_ALLOC failed using km=
alloc\n",
-			       irq, devname);
-	}
-
-	if (action =3D NULL)
-		action =3D kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-
-	if (!action) {
-		ret =3D -ENOMEM;
-		goto out_unlock;
-	}
-
-	action->handler =3D handler;
-	action->flags =3D irqflags;
-	action->name =3D devname;
-	action->next =3D NULL;
-	action->dev_id =3D dev_id;
-
-	if (tmp)
-		tmp->next =3D action;
-	else
-		*actionp =3D action;
+#endif
=20
-	__enable_irq(irq);
+	real_irq =3D handler_data->real_irq;
=20
-	ret =3D 0;
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-out:
-	return ret;
+#ifdef CONFIG_SMP
+	spin_lock_irqsave(&sun4d_imsk_lock, flags);
+	cc_set_imsk_other(cpuid, cc_get_imsk_other(cpuid) | (1 << real_irq));
+	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+#else
+	cc_set_imsk(cc_get_imsk() | (1 << real_irq));
+#endif
 }
=20
-static void sun4d_disable_irq(unsigned int irq)
+static void sun4d_unmask_irq(struct irq_data *data)
 {
-	int tid =3D sbus_tid[(irq >> 5) - 1];
+	struct sun4d_handler_data *handler_data =3D data->handler_data;
+	unsigned int real_irq;
+#ifdef CONFIG_SMP
+	int cpuid =3D handler_data->cpuid;
 	unsigned long flags;
+#endif
=20
-	if (irq < NR_IRQS)
-		return;
+	real_irq =3D handler_data->real_irq;
=20
+#ifdef CONFIG_SMP
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
-	cc_set_imsk_other(tid, cc_get_imsk_other(tid) | (1 << sbus_to_pil[(irq >>=
 2) & 7]));
+	cc_set_imsk_other(cpuid, cc_get_imsk_other(cpuid) | ~(1 << real_irq));
 	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+#else
+	cc_set_imsk(cc_get_imsk() | ~(1 << real_irq));
+#endif
 }
=20
-static void sun4d_enable_irq(unsigned int irq)
+/*
+ * XXX need shutdown too and virt_irq_unlock() plus appropriate
+ * XXX smp locking
+ */
+static unsigned int sun4d_startup_irq(struct irq_data *data)
 {
-	int tid =3D sbus_tid[(irq >> 5) - 1];
-	unsigned long flags;
-
-	if (irq < NR_IRQS)
-		return;
-
-	spin_lock_irqsave(&sun4d_imsk_lock, flags);
-	cc_set_imsk_other(tid, cc_get_imsk_other(tid) & ~(1 << sbus_to_pil[(irq >=
> 2) & 7]));
-	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+	irq_link(data->irq);
+	sun4d_unmask_irq(data);
+	return 0;
 }
=20
+struct irq_chip sun4d_irq =3D {
+	.name		=3D "sun4d",
+	.irq_startup	=3D sun4d_startup_irq,
+	.irq_unmask	=3D sun4d_unmask_irq,
+	.irq_mask	=3D sun4d_mask_irq,
+};
+
 #ifdef CONFIG_SMP
 static void sun4d_set_cpu_int(int cpu, int level)
 {
@@ -413,7 +264,7 @@ void __init sun4d_distribute_irqs(void)
 	for_each_node_by_name(dp, "sbi") {
 		int devid =3D of_getintprop_default(dp, "device-id", 0);
 		int board =3D of_getintprop_default(dp, "board#", 0);
-		sbus_tid[board] =3D cpuid;
+		board_to_cpu[board] =3D cpuid;
 		set_sbi_tid(devid, cpuid << 3);
 	}
 	printk(KERN_ERR "All sbus IRQs directed to CPU%d\n", cpuid);
@@ -464,56 +315,6 @@ static void __init sun4d_fixup_trap_table(void)
 #endif
 }
=20
-static void __init sun4d_init_timers(irq_handler_t counter_fn)
-{
-	struct device_node *dp;
-	struct resource res;
-	const u32 *reg;
-	int err;
-
-	dp =3D of_find_node_by_name(NULL, "cpu-unit");
-	if (!dp) {
-		prom_printf("sun4d_init_timers: Unable to find cpu-unit\n");
-		prom_halt();
-	}
-
-	/* Which cpu-unit we use is arbitrary, we can view the bootbus timer
-	 * registers via any cpu's mapping.  The first 'reg' property is the
-	 * bootbus.
-	 */
-	reg =3D of_get_property(dp, "reg", NULL);
-	of_node_put(dp);
-	if (!reg) {
-		prom_printf("sun4d_init_timers: No reg property\n");
-		prom_halt();
-	}
-
-	res.start =3D reg[1];
-	res.end =3D reg[2] - 1;
-	res.flags =3D reg[0] & 0xff;
-	sun4d_timers =3D of_ioremap(&res, BW_TIMER_LIMIT,
-				  sizeof(struct sun4d_timer_regs), "user timer");
-	if (!sun4d_timers) {
-		prom_printf("sun4d_init_timers: Can't map timer regs\n");
-		prom_halt();
-	}
-
-	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
-
-	master_l10_counter =3D &sun4d_timers->l10_cur_count;
-
-	err =3D request_irq(TIMER_IRQ, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC),
-			  "timer", NULL);
-	if (err) {
-		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
-		             err);
-		prom_halt();
-	}
-	sun4d_load_profile_irqs();
-	sun4d_fixup_trap_table();
-}
-
 void __init sun4d_init_sbi_irq(void)
 {
 	struct device_node *dp;
@@ -522,22 +323,13 @@ void __init sun4d_init_sbi_irq(void)
 #ifdef CONFIG_SMP
 	target_cpu =3D boot_cpu_id;
 #endif
-
-	nsbi =3D 0;
-	for_each_node_by_name(dp, "sbi")
-		nsbi++;
-	sbus_actions =3D kzalloc(nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_A=
TOMIC);
-	if (!sbus_actions) {
-		prom_printf("SUN4D: Cannot allocate sbus_actions, halting.\n");
-		prom_halt();
-	}
 	for_each_node_by_name(dp, "sbi") {
 		int devid =3D of_getintprop_default(dp, "device-id", 0);
 		int board =3D of_getintprop_default(dp, "board#", 0);
 		unsigned int mask;
=20
 		set_sbi_tid(devid, target_cpu << 3);
-		sbus_tid[board] =3D target_cpu;
+		board_to_cpu[board] =3D target_cpu;
=20
 		/* Get rid of pending irqs from PROM */
 		mask =3D acquire_sbi(devid, 0xffffffff);
@@ -549,17 +341,19 @@ void __init sun4d_init_sbi_irq(void)
 	}
 }
=20
-int sun4d_build_device_irq(struct platform_device *op, int interrupt)
+unsigned int sun4d_build_device_irq(struct platform_device *op,
+				    unsigned int real_irq)
 {
-	static int pil_to_sbus[] =3D {
-		0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
-	};
 	struct device_node *dp =3D op->dev.of_node;
 	struct device_node *io_unit, *sbi =3D dp->parent;
 	const struct linux_prom_registers *regs;
+	struct sun4d_handler_data *handler_data;
+	unsigned int pil;
+	unsigned int irq;
 	int board, slot;
 	int sbusl;
=20
+	irq =3D 0;
 	while (sbi) {
 		if (!strcmp(sbi->name, "sbi"))
 			break;
@@ -567,11 +361,11 @@ int sun4d_build_device_irq(struct platform_device *op=
, int interrupt)
 		sbi =3D sbi->parent;
 	}
 	if (!sbi)
-		goto err_out;
+		goto out;
=20
 	regs =3D of_get_property(dp, "reg", NULL);
 	if (!regs)
-		goto err_out;
+		goto out;
=20
 	slot =3D regs->which_io;
=20
@@ -580,34 +374,105 @@ int sun4d_build_device_irq(struct platform_device *o=
p, int interrupt)
 	 * a "board#" property, something is very wrong.
 	 */
 	if (!sbi->parent || strcmp(sbi->parent->name, "io-unit")) {
-		printk("%s: Error, parent is not io-unit.\n", sbi->full_name);
-		goto err_out;
+		printk("IRQ %s parents is not io-unit.\n", sbi->full_name);
+		goto out;
 	}
 	io_unit =3D sbi->parent;
 	board =3D of_getintprop_default(io_unit, "board#", -1);
 	if (board =3D -1) {
-		printk("%s: Error, lacks board# property.\n", io_unit->full_name);
-		goto err_out;
+		printk("IRQ: %s lacks board# property.\n", io_unit->full_name);
+		goto out;
 	}
=20
-	sbusl =3D pil_to_sbus[interrupt];
+	sbusl =3D pil_to_sbus[real_irq];
 	if (sbusl)
-		return (((board + 1) << 5) + (sbusl << 2) + slot);
+		pil =3D sun4d_encode_irq(board, sbusl, slot);
+	else
+		pil =3D real_irq;
+
+	irq =3D irq_alloc(real_irq, pil);
+
+	if (irq =3D 0)
+		goto out;
+
+	handler_data =3D get_irq_data(irq);
+	if (unlikely(handler_data))
+		goto out;
+
+	handler_data =3D kzalloc(sizeof(struct sun4d_handler_data), GFP_ATOMIC);
+	if (unlikely(!handler_data)) {
+		prom_printf("IRQ: kzalloc(sun4d_handler_data) failed.\n");
+		prom_halt();
+	}
+	handler_data->cpuid    =3D board_to_cpu[board];
+	handler_data->real_irq =3D real_irq;
+	set_irq_chip_and_handler_name(irq, &sun4d_irq,
+	                              handle_level_irq, "SUN4D");
+        set_irq_data(irq, handler_data);
+
+out:
+	return irq;
+}
+
+static void __init sun4d_init_timers(irq_handler_t counter_fn)
+{
+	struct device_node *dp;
+	struct resource res;
+	unsigned int irq;
+	const u32 *reg;
+	int err;
+
+	dp =3D of_find_node_by_name(NULL, "cpu-unit");
+	if (!dp) {
+		prom_printf("sun4d_init_timers: Unable to find cpu-unit\n");
+		prom_halt();
+	}
+
+	/* Which cpu-unit we use is arbitrary, we can view the bootbus timer
+	 * registers via any cpu's mapping.  The first 'reg' property is the
+	 * bootbus.
+	 */
+	reg =3D of_get_property(dp, "reg", NULL);
+	of_node_put(dp);
+	if (!reg) {
+		prom_printf("sun4d_init_timers: No reg property\n");
+		prom_halt();
+	}
+
+	res.start =3D reg[1];
+	res.end =3D reg[2] - 1;
+	res.flags =3D reg[0] & 0xff;
+	sun4d_timers =3D of_ioremap(&res, BW_TIMER_LIMIT,
+				  sizeof(struct sun4d_timer_regs), "user timer");
+	if (!sun4d_timers) {
+		prom_printf("sun4d_init_timers: Can't map timer regs\n");
+		prom_halt();
+	}
+
+	sbus_writel((((1000000/HZ) + 1) << 10), &sun4d_timers->l10_timer_limit);
+
+	master_l10_counter =3D &sun4d_timers->l10_cur_count;
=20
-err_out:
-	return interrupt;
+	irq =3D sun4d_build_device_irq(NULL, SUN4D_TIMER_IRQ);
+	err =3D request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
+	if (err) {
+		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
+		             err);
+		prom_halt();
+	}
+	sun4d_load_profile_irqs();
+	sun4d_fixup_trap_table();
 }
=20
+
 void __init sun4d_init_IRQ(void)
 {
 	local_irq_disable();
=20
-	BTFIXUPSET_CALL(enable_irq, sun4d_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, sun4d_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NOR=
M);
=20
-	sparc_irq_config.init_timers =3D sun4d_init_timers;
+	sparc_irq_config.init_timers      =3D sun4d_init_timers;
 	sparc_irq_config.build_device_irq =3D sun4d_build_device_irq;
=20
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 69df625..eda5685 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -100,6 +100,11 @@
 struct sun4m_irq_percpu __iomem *sun4m_irq_percpu[SUN4M_NCPUS];
 struct sun4m_irq_global __iomem *sun4m_irq_global;
=20
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
=20
 #define SUN4M_TIMER_IRQ         (OBP_INT_LEVEL_ONBOARD | 10)
-#define SUM4M_PROFILE_IRQ       (OBP_INT_LEVEL_ONBOARD | 14)
+#define SUN4M_PROFILE_IRQ       (OBP_INT_LEVEL_ONBOARD | 14)
=20
-static unsigned long irq_mask[0x50] =3D {
+static unsigned long sun4m_imask[0x50] =3D {
 	/* 0x00 - SMP */
 	0,  SUN4M_SOFT_INT(1),
 	SUN4M_SOFT_INT(2),  SUN4M_SOFT_INT(3),
@@ -169,7 +174,7 @@ static unsigned long irq_mask[0x50] =3D {
 	SUN4M_INT_VIDEO, SUN4M_INT_MODULE,
 	SUN4M_INT_REALTIME, SUN4M_INT_FLOPPY,
 	(SUN4M_INT_SERIAL | SUN4M_INT_KBDMS),
-	SUN4M_INT_AUDIO, 0, SUN4M_INT_MODULE_ERR,
+	SUN4M_INT_AUDIO, SUN4M_INT_E14, SUN4M_INT_MODULE_ERR,
 	/* 0x30 - sbus */
 	0, 0, SUN4M_INT_SBUS(0), SUN4M_INT_SBUS(1),
 	0, SUN4M_INT_SBUS(2), 0, SUN4M_INT_SBUS(3),
@@ -182,105 +187,103 @@ static unsigned long irq_mask[0x50] =3D {
 	0, SUN4M_INT_VME(6), 0, 0
 };
=20
-static unsigned long sun4m_get_irqmask(unsigned int irq)
+static void sun4m_mask_irq(struct irq_data *data)
 {
-	unsigned long mask;
-
-	if (irq < 0x50)
-		mask =3D irq_mask[irq];
-	else
-		mask =3D 0;
+	struct sun4m_handler_data *handler_data =3D data->handler_data;
+	int cpu =3D smp_processor_id();
=20
-	if (!mask)
-		printk(KERN_ERR "sun4m_get_irqmask: IRQ%d has no valid mask!\n",
-		       irq);
+	if (handler_data->mask) {
+		unsigned long flags;
=20
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
=20
-static void sun4m_disable_irq(unsigned int irq_nr)
+static void sun4m_unmask_irq(struct irq_data *data)
 {
-	unsigned long mask, flags;
+	struct sun4m_handler_data *handler_data =3D data->handler_data;
 	int cpu =3D smp_processor_id();
=20
-	mask =3D sun4m_get_irqmask(irq_nr);
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
-	int cpu =3D smp_processor_id();
+	if (handler_data->mask) {
+		unsigned long flags;
=20
-	/* Dreadful floppy hack. When we use 0x2b instead of
-	 * 0x0b the system blows (it starts to whistle!).
-	 * So we continue to use 0x0b. Fixme ASAP. --P3
-	 */
-	if (irq_nr !=3D 0x0b) {
-		mask =3D sun4m_get_irqmask(irq_nr);
 		local_irq_save(flags);
-		if (irq_nr > 15)
-			sbus_writel(mask, &sun4m_irq_global->mask_clear);
-		else
-			sbus_writel(mask, &sun4m_irq_percpu[cpu]->clear);
-		local_irq_restore(flags);
-	} else {
-		local_irq_save(flags);
-		sbus_writel(SUN4M_INT_FLOPPY, &sun4m_irq_global->mask_clear);
+		if (handler_data->percpu) {
+			sbus_writel(handler_data->mask, &sun4m_irq_percpu[cpu]->clear);
+		} else {
+			sbus_writel(handler_data->mask, &sun4m_irq_global->mask_clear);
+		}
 		local_irq_restore(flags);
 	}
 }
=20
-static unsigned long cpu_pil_to_imask[16] =3D {
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
-
-/* We assume the caller has disabled local interrupts when these are calle=
d,
- * or else very bizarre behavior will result.
- */
-static void sun4m_disable_pil_irq(unsigned int pil)
+static unsigned int sun4m_startup_irq(struct irq_data *data)
 {
-	sbus_writel(cpu_pil_to_imask[pil], &sun4m_irq_global->mask_set);
+	irq_link(data->irq);
+	sun4m_unmask_irq(data);
+	return 0;
 }
=20
-static void sun4m_enable_pil_irq(unsigned int pil)
+static struct irq_chip sun4m_irq =3D {
+	.name		=3D "sun4m",
+	.irq_startup	=3D sun4m_startup_irq,
+	.irq_mask	=3D sun4m_mask_irq,
+	.irq_unmask	=3D sun4m_unmask_irq,
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
+	if (real_irq >=3D OBP_INT_LEVEL_VME) {
+		prom_printf("Bogus sun4m IRQ %u\n", real_irq);
+		prom_halt();
+	}
+	pil =3D (real_irq & 0xf);
+	irq =3D irq_alloc(real_irq, pil);
+
+	if (irq =3D 0)
+		goto out;
+
+	handler_data =3D get_irq_data(irq);
+	if (unlikely(handler_data))
+		goto out;
+
+	handler_data =3D kzalloc(sizeof(struct sun4m_handler_data), GFP_ATOMIC);
+	if (unlikely(!handler_data)) {
+		prom_printf("IRQ: kzalloc(sun4m_handler_data) failed.\n");
+		prom_halt();
+	}
+
+	handler_data->mask =3D sun4m_imask[real_irq];
+	handler_data->percpu =3D real_irq < OBP_INT_LEVEL_ONBOARD;
+	set_irq_chip_and_handler_name(irq, &sun4m_irq,
+	                              handle_level_irq, "SUN4M");
+	set_irq_data(irq, handler_data);
+
+out:
+	return irq;
 }
=20
 #ifdef CONFIG_SMP
 static void sun4m_send_ipi(int cpu, int level)
 {
-	unsigned long mask =3D sun4m_get_irqmask(level);
-
-	sbus_writel(mask, &sun4m_irq_percpu[cpu]->set);
+	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->set);
 }
=20
 static void sun4m_clear_ipi(int cpu, int level)
 {
-	unsigned long mask =3D sun4m_get_irqmask(level);
-
-	sbus_writel(mask, &sun4m_irq_percpu[cpu]->clear);
+	sbus_writel(SUN4M_SOFT_INT(level), &sun4m_irq_percpu[cpu]->clear);
 }
=20
 static void sun4m_set_udt(int cpu)
@@ -343,7 +346,15 @@ void sun4m_nmi(struct pt_regs *regs)
 	prom_halt();
 }
=20
-/* Exported for sun4m_smp.c */
+void sun4m_unmask_profile_irq(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	sbus_writel(sun4m_imask[SUN4M_PROFILE_IRQ], &sun4m_irq_global->mask_clear=
);
+	local_irq_restore(flags);
+}
+
 void sun4m_clear_profile_irq(int cpu)
 {
 	sbus_readl(&timers_percpu[cpu]->l14_limit);
@@ -358,6 +369,7 @@ static void __init sun4m_init_timers(irq_handler_t coun=
ter_fn)
 {
 	struct device_node *dp =3D of_find_node_by_name(NULL, "counter");
 	int i, err, len, num_cpu_timers;
+	unsigned int irq;
 	const u32 *addr;
=20
 	if (!dp) {
@@ -384,8 +396,9 @@ static void __init sun4m_init_timers(irq_handler_t coun=
ter_fn)
=20
 	master_l10_counter =3D &timers_global->l10_count;
=20
-	err =3D request_irq(SUN4M_TIMER_IRQ, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+	irq =3D sun4m_build_device_irq(NULL, SUN4M_TIMER_IRQ);
+
+	err =3D request_irq(irq, counter_fn, IRQF_TIMER, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
 			err);
@@ -452,14 +465,11 @@ void __init sun4m_init_IRQ(void)
 	if (num_cpu_iregs =3D 4)
 		sbus_writel(0, &sun4m_irq_global->interrupt_target);
=20
-	BTFIXUPSET_CALL(enable_irq, sun4m_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, sun4m_disable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(enable_pil_irq, sun4m_enable_pil_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_pil_irq, sun4m_disable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4m_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4m_load_profile_irq, BTFIXUPCALL_NOR=
M);
=20
 	sparc_irq_config.init_timers =3D sun4m_init_timers;
+	sparc_irq_config.build_device_irq =3D sun4m_build_device_irq;
=20
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 5cc7dc5..58b8d84 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -150,20 +150,6 @@ void __init smp4m_smp_done(void)
 	/* Ok, they are spinning and ready to go. */
 }
=20
-/* At each hardware IRQ, we get this called to forward IRQ reception
- * to the next processor.  The caller must disable the IRQ level being
- * serviced globally so that there are no double interrupts received.
- *
- * XXX See sparc64 irq.c.
- */
-void smp4m_irq_rotate(int cpu)
-{
-	int next =3D cpu_data(cpu).next;
-
-	if (next !=3D cpu)
-		set_irq_udt(next);
-}
-
 static struct smp_funcall {
 	smpfunc_t func;
 	unsigned long arg1;
@@ -277,7 +263,7 @@ static void __cpuinit smp_setup_percpu_timer(void)
 	load_profile_irq(cpu, lvl14_resolution);
=20
 	if (cpu =3D boot_cpu_id)
-		enable_pil_irq(14);
+		sun4m_unmask_profile_irq();
 }
=20
 static void __init smp4m_blackbox_id(unsigned *addr)
--=20
1.6.0.6

