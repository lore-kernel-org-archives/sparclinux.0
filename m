From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 19:29:52 +0000
Subject: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213192952.GD25069@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

The actual genirq conversion.

Please ignore sun4c + sun4d stuff for now.

	Sam
---
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
diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_3=
2.h
index cbf4801..915560a 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -6,7 +6,13 @@
 #ifndef _SPARC_IRQ_H
 #define _SPARC_IRQ_H
=20
-#define NR_IRQS    16
+/*
+ * Allocated number of logical irq numbers.
+ * sun4d boxes (ss2000e) should be OK with ~32.
+ * Be on the safe side and make room for 64
+ */
+
+#define NR_IRQS    64
=20
 #include <linux/interrupt.h>
=20
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
index 2c2ce9b..98b1491 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -30,10 +30,15 @@ extern struct sun4m_irq_global __iomem *sun4m_irq_globa=
l;
  */
 struct sparc_irq_config {
 	void (*init_timers)(irq_handler_t);
-	int (*build_device_irq)(struct platform_device *op, int interrupt);
+	unsigned int (*build_device_irq)(struct platform_device *op,
+	                                 unsigned int interrupt);
+	unsigned int profile_irq;
 };
 extern struct sparc_irq_config sparc_irq_config;
=20
+unsigned int irq_alloc(unsigned int real_irq, unsigned int pil);
+void irq_link(unsigned int irq);
+void handler_irq(unsigned int pil, struct pt_regs *regs);
=20
 /* Dave Redman (djhr@tadpole.co.uk)
  * changed these to function pointers.. it saves cycles and will allow
@@ -43,33 +48,9 @@ extern struct sparc_irq_config sparc_irq_config;
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
index 8f31959..f92cd34 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -14,6 +14,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/seq_file.h>
=20
+#include <asm/cpudata.h>
 #include <asm/pcic.h>
 #include <asm/leon.h>
=20
@@ -106,278 +107,154 @@ static void irq_panic(irq_handler_t handler)
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
+ * We keep a table of per-PIL enable interrupts.  These get wired
+ * up via the irq_chip->startup() method which gets invoked by
+ * the generic IRQ layer during request_irq().
  */
=20
+struct irq_bucket {
+	struct irq_bucket *next;
+	unsigned int irq;
+	unsigned int pil;
+};
=20
+static struct irq_bucket irq_table[NR_IRQS];
+static struct irq_bucket *pil_buckets[16];
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
+unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
+{
+	unsigned int i;
=20
-static struct {
-	struct irqaction *action;
-	int flags;
-} sparc_irq[NR_IRQS];
-#define SPARC_IRQ_INPROGRESS 1
+	for (i =3D 1; i < NR_IRQS; i++) {
+		if (irq_table[i].irq =3D real_irq && irq_table[i].irq =3D pil)
+			return i;
+	}
+
+	for (i =3D 1; i < NR_IRQS; i++) {
+		if (!irq_table[i].irq)
+			break;
+	}
+
+	if (i >=3D NR_IRQS) {
+		printk(KERN_ERR "IRQ: Out of virtual IRQs.\n");
+		return 0;
+	}
+	irq_table[i].irq =3D i;
+	irq_table[i].pil =3D pil;
+
+	return i;
+}
=20
-/* Used to protect the IRQ action lists */
-DEFINE_SPINLOCK(irq_action_lock);
+void irq_link(unsigned int irq)
+{
+	struct irq_bucket *p;
+	unsigned int pil;
+
+	BUG_ON(irq >=3D NR_IRQS);
+
+	p =3D &irq_table[irq];
+	pil =3D p->pil;
+	BUG_ON(pil > 15);
+	p->next =3D pil_buckets[pil];
+	pil_buckets[pil] =3D p;
+}
=20
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i =3D *(loff_t *)v;
+	int i =3D *(loff_t *) v, j;
 	struct irqaction *action;
 	unsigned long flags;
-#ifdef CONFIG_SMP
-	int j;
-#endif
=20
-	if (sparc_cpu_model =3D sun4d)
-		return show_sun4d_interrupts(p, v);
+	if (i =3D 0) {
+		seq_printf(p, "           ");
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
+		seq_putc(p, '\n');
+	}
=20
-	spin_lock_irqsave(&irq_action_lock, flags);
 	if (i < NR_IRQS) {
-		action =3D sparc_irq[i].action;
+		raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
+		action =3D irq_desc[i].action;
 		if (!action)
-			goto out_unlock;
-		seq_printf(p, "%3d: ", i);
+			goto skip;
+		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for_each_online_cpu(j) {
-			seq_printf(p, "%10u ",
-				    kstat_cpu(j).irqs[i]);
-		}
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
 #endif
-		seq_printf(p, " %c %s",
-			(action->flags & IRQF_DISABLED) ? '+' : ' ',
-			action->name);
-		for (action =3D action->next; action; action =3D action->next) {
-			seq_printf(p, ",%s %s",
-				(action->flags & IRQF_DISABLED) ? " +" : "",
-				action->name);
-		}
+		seq_printf(p, " %9s", irq_desc[i].irq_data.chip->name);
+		seq_printf(p, "  %s", action->name);
+
+		for (action=ACtion->next; action; action =3D action->next)
+			seq_printf(p, ", %s", action->name);
+
 		seq_putc(p, '\n');
+skip:
+		raw_spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+	} else if (i =3D NR_IRQS) {
+		seq_printf(p, "NMI: ");
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", cpu_data(j).counter);
+		seq_printf(p, "     Non-maskable interrupts\n");
 	}
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
 	return 0;
 }
=20
-void free_irq(unsigned int irq, void *dev_id)
+void handler_irq(unsigned int pil, struct pt_regs *regs)
 {
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
-	}
-
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
-	*actionp =3D action->next;
-
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-
-	synchronize_irq(irq);
-
-	spin_lock_irqsave(&irq_action_lock, flags);
-
-	kfree(action);
+	struct pt_regs *old_regs;
+	struct irq_bucket *p;
=20
-	if (!sparc_irq[cpu_irq].action)
-		__disable_irq(irq);
+	BUG_ON(pil > 15);
+	old_regs =3D set_irq_regs(regs);
+	irq_enter();
=20
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-}
-EXPORT_SYMBOL(free_irq);
+	p =3D pil_buckets[pil];
+	while (p) {
+		struct irq_bucket *next =3D p->next;
+		struct irq_desc *desc;
+		unsigned int irq;
=20
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
+		irq =3D p->irq;
+		desc =3D irq_to_desc(irq);
=20
-	cpu_irq =3D irq & (NR_IRQS - 1);
-	while (sparc_irq[cpu_irq].flags & SPARC_IRQ_INPROGRESS)
-		cpu_relax();
-}
-EXPORT_SYMBOL(synchronize_irq);
-#endif /* SMP */
+		if (!(desc->status & IRQ_DISABLED))
+			desc->handle_irq(irq, desc);
=20
-void unexpected_irq(int irq, void *dev_id, struct pt_regs *regs)
-{
-	int i;
-	struct irqaction *action;
-	unsigned int cpu_irq;
-
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
+		p =3D next;
 	}
-	printk(KERN_ERR "AIEEE\n");
-	panic("bogus interrupt received");
-}
-
-void handler_irq(int pil, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs;
-	struct irqaction *action;
-	int cpu =3D smp_processor_id();
-
-	old_regs =3D set_irq_regs(regs);
-	irq_enter();
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
 	irq_exit();
 	set_irq_regs(old_regs);
 }
=20
 #if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
=20
-/*
- * Fast IRQs on the Sparc can only have one routine attached to them,
- * thus no sharing possible.
- */
-static int request_fast_irq(unsigned int irq,
-			    void (*handler)(void),
-			    unsigned long irqflags, const char *devname)
+static int request_floppy_irq(unsigned int irq,
+			      irq_handler_t handler,
+			      unsigned long irqflags, const char *devname)
 {
-	struct irqaction *action;
-	unsigned long flags;
-	unsigned int cpu_irq;
-	int ret;
-#if defined CONFIG_SMP && !defined CONFIG_SPARC_LEON
-	struct tt_entry *trap_table;
-#endif
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
+	unsigned int cpu_irq =3D (irq & (NR_IRQS - 1));
+	int err;
=20
-	action =3D sparc_irq[cpu_irq].action;
-	if (action) {
-		if (action->flags & IRQF_SHARED)
-			panic("Trying to register fast irq when already shared.\n");
-		if (irqflags & IRQF_SHARED)
-			panic("Trying to register fast irq as shared.\n");
-
-		/* Anyway, someone already owns it so cannot be made fast. */
-		printk(KERN_ERR "request_fast_irq: Trying to register yet already owned.=
\n");
-		ret =3D -EBUSY;
-		goto out_unlock;
-	}
-
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
+	err =3D request_irq(irq, floppy_interrupt, irqflags, devname, NULL);
+	if (err)
+		return err;
=20
-	if (action =3D NULL)
-		action =3D kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-	if (!action) {
-		ret =3D -ENOMEM;
-		goto out_unlock;
-	}
+	floppy_irq_num =3D irq;
=20
 	/* Dork with trap table if we get this far. */
 #define INSTANTIATE(table) \
@@ -404,22 +281,16 @@ static int request_fast_irq(unsigned int irq,
 	 * writing we have no CPU-neutral interface to fine-grained flushes.
 	 */
 	flush_cache_all();
+	return 0;
+}
=20
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
+int sparc_floppy_request_irq(int irq, unsigned long flags,
+			     irq_handler_t irq_handler)
+{
+	floppy_irq_handler =3D irq_handler;
+	return request_floppy_irq(irq, floppy_hardint, flags, "floppy");
 }
+EXPORT_SYMBOL(sparc_floppy_request_irq);
=20
 /*
  * These variables are used to access state from the assembler
@@ -467,127 +338,11 @@ void sparc_floppy_irq(int irq, void *dev_id, struct =
pt_regs *regs)
 	 */
 }
=20
-int sparc_floppy_request_irq(int irq, unsigned long flags,
-			     irq_handler_t irq_handler)
-{
-	floppy_irq_handler =3D irq_handler;
-	return request_fast_irq(irq, floppy_hardint, flags, "floppy");
-}
-EXPORT_SYMBOL(sparc_floppy_request_irq);
=20
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
+static unsigned int build_device_irq(struct platform_device *op,
+				     unsigned int interrupt)
 {
 	return interrupt;
 }
@@ -604,6 +359,7 @@ void __init init_IRQ(void)
 {
 	sparc_irq_config.init_timers =3D irq_panic;
 	sparc_irq_config.build_device_irq =3D build_device_irq;
+	sparc_irq_config.profile_irq =3D 14;
=20
 	switch (sparc_cpu_model) {
 	case sun4c:
@@ -637,9 +393,3 @@ void __init init_IRQ(void)
 	btfixup();
 }
=20
-#ifdef CONFIG_PROC_FS
-void init_irq_proc(void)
-{
-	/* For now, nothing... */
-}
-#endif /* CONFIG_PROC_FS */
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
index 5122e70..2bacb21 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -65,62 +65,88 @@
  */
 unsigned char __iomem *interrupt_enable;
=20
-static void sun4c_disable_irq(unsigned int irq_nr)
+static void sun4c_disable_irq(struct irq_data *data)
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
+static void sun4c_enable_irq(struct irq_data *data)
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
+	sun4c_enable_irq(data);
+
+	return 0;
+}
+
+static struct irq_chip sun4c_irq =3D {
+	.name		=3D "sun4c",
+	.irq_startup	=3D sun4c_startup_irq,
+	.irq_enable	=3D sun4c_enable_irq,
+	.irq_disable	=3D sun4c_disable_irq,
+	.irq_ack	=3D sun4c_disable_irq,
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
+		set_irq_chip(irq, &sun4c_irq);
+		set_irq_chip_data(irq, (void *)mask);
+	}
+	return irq;
 }
=20
 struct sun4c_timer_info {
@@ -146,6 +172,7 @@ static void __init sun4c_init_timers(irq_handler_t coun=
ter_fn)
 {
 	const struct linux_prom_irqs *irq;
 	struct device_node *dp;
+	unsigned long mask;
 	const u32 *addr;
 	int err;
=20
@@ -179,14 +206,15 @@ static void __init sun4c_init_timers(irq_handler_t co=
unter_fn)
 	master_l10_counter =3D &sun4c_timers->l10_count;
=20
 	err =3D request_irq(irq[0].pri, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC),
-			  "timer", NULL);
+			  IRQF_DISABLED, "timer", NULL);
 	if (err) {
 		prom_printf("sun4c_init_timers: request_irq() fails with %d\n", err);
 		prom_halt();
 	}
=20
-	sun4c_disable_irq(irq[1].pri);
+	/* disable timer interrupt */
+	mask =3D sbus_readb(interrupt_enable) & ~SUN4C_INT_E10;
+	sbus_writeb(mask, interrupt_enable);
 }
=20
 #ifdef CONFIG_SMP
@@ -215,13 +243,12 @@ void __init sun4c_init_IRQ(void)
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
+
 	sparc_irq_config.init_timers =3D sun4c_init_timers;
+	sparc_irq_config.build_device_irq =3D sun4c_build_device_irq;
+
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(clear_cpu_int, sun4c_nop, BTFIXUPCALL_NOP);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 6388087..ddd1305 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -38,6 +38,33 @@
  *    have interrupts pending for that SBUS interrupt level.
  */
=20
+struct sun4d_sbus_handler_data {
+	unsigned int tid; /* thread ID? */
+	unsigned int pil;
+	bool cpu_local;   /* true for local intrrupts */
+};
+
+
+static unsigned int sun4d_encode_real_irq(int board, int lvl, int slot)
+{
+	return (board + 1) << 5 | (lvl << 2) | slot;
+}
+/*
+static unsigned int sun4d_irq_board(unsigned int real_irq)
+{
+	return (real_irq >> 5) - 1;
+}
+
+static unsigned int sun4d_irq_level(unsigned int real_irq)
+{
+	return (real_irq >> 2) & 0x7;
+}
+
+static unsigned int sun4d_irq_slot(unsigned int real_irq)
+{
+	return (real_irq >> 0) & 0x3;
+}
+*/
 struct sun4d_timer_regs {
 	u32	l10_timer_limit;
 	u32	l10_cur_countx;
@@ -50,16 +77,8 @@ static struct sun4d_timer_regs __iomem *sun4d_timers;
=20
 #define TIMER_IRQ	10
=20
-#define MAX_STATIC_ALLOC	4
 static unsigned char sbus_tid[32];
=20
-static struct irqaction *irq_action[NR_IRQS];
-
-static struct sbus_action {
-	struct irqaction *action;
-	/* For SMP this needs to be extended */
-} *sbus_actions;
-
 static int pil_to_sbus[] =3D {
 	0,
 	0,
@@ -78,7 +97,7 @@ static int pil_to_sbus[] =3D {
 	0,
 	0,
 };
-
+/*
 static int sbus_to_pil[] =3D {
 	0,
 	2,
@@ -89,142 +108,50 @@ static int sbus_to_pil[] =3D {
 	11,
 	13,
 };
-
-static int nsbi;
-
+*/
 /* Exported for sun4d_smp.c */
 DEFINE_SPINLOCK(sun4d_imsk_lock);
=20
-int show_sun4d_interrupts(struct seq_file *p, void *v)
+static void __sun4d_sbus_irq(int sbusl)
 {
-	int i =3D *(loff_t *) v, j =3D 0, k =3D 0, sbusl;
-	struct irqaction *action;
-	unsigned long flags;
-#ifdef CONFIG_SMP
-	int x;
-#endif
+	unsigned int bus_mask =3D bw_get_intr_mask(sbusl) & 0x3ffff;
+	unsigned int sbino, slot;
+	unsigned int sbil =3D (sbusl << 2);
+
+	bw_clear_intr_mask(sbusl, bus_mask);
+	/* Loop for each pending SBI */
+	for (sbino =3D 0; bus_mask; sbino++, bus_mask >>=3D 1) {
+		unsigned int idx, mask;
+
+		if (!(bus_mask & 1))
+			continue;
+		/* XXX This seems to ACK the irq twice.  acquire_sbi()
+		 * XXX uses swap, therefore this writes 0xf << sbil,
+		 * XXX then later release_sbi() will write the individual
+		 * XXX bits which were set again.
+		 */
+		mask =3D acquire_sbi(SBI2DEVID(sbino), 0xf << sbil);
+		mask &=3D (0xf << sbil);
=20
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
-			}
-		}
-		seq_putc(p, '\n');
-	}
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-	return 0;
-}
+		/* Loop for each pending SBI slot */
+		idx =3D 0;
+		for (slot =3D (1 << sbil); mask; slot <<=3D 1, idx++) {
+			unsigned int real_irq;
=20
-void sun4d_free_irq(unsigned int irq, void *dev_id)
-{
-	struct irqaction *action, **actionp;
-	struct irqaction *tmp =3D NULL;
-	unsigned long flags;
+			if (!(mask & slot))
+				continue;
=20
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
+			mask &=3D ~slot;
+			real_irq =3D sun4d_encode_real_irq(sbino, sbil, idx);
+			/* TODO__do_IRQ(real_irq); */
+			release_sbi(SBI2DEVID(sbino), slot);
 		}
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
@@ -235,157 +162,79 @@ void sun4d_handler_irq(int pil, struct pt_regs *regs)
=20
 	old_regs =3D set_irq_regs(regs);
 	irq_enter();
-	kstat_cpu(cpu).irqs[pil]++;
 	if (!sbusl) {
-		action =3D *(pil + irq_action);
-		if (!action)
-			unexpected_irq(pil, NULL, regs);
-		do {
-			action->handler(pil, action->dev_id);
-			action =3D action->next;
-		} while (action);
+		/* TODO__do_IRQ(pil); */
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
+		__sun4d_sbus_irq(sbusl);
 	}
 	irq_exit();
 	set_irq_regs(old_regs);
 }
=20
-int sun4d_request_irq(unsigned int irq,
-		irq_handler_t handler,
-		unsigned long irqflags, const char *devname, void *dev_id)
+static void sun4d_sbus_disable_irq(struct irq_data *data)
 {
-	struct irqaction *action, *tmp =3D NULL, **actionp;
+	struct sun4d_sbus_handler_data *handler_data =3D data->handler_data;
+	unsigned int pil;
+#ifdef CONFIG_SMP
+	int tid =3D handler_data->tid;
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
+	pil =3D handler_data->pil;
=20
-	ret =3D 0;
-out_unlock:
-	spin_unlock_irqrestore(&irq_action_lock, flags);
-out:
-	return ret;
+#ifdef CONFIG_SMP
+	spin_lock_irqsave(&sun4d_imsk_lock, flags);
+	cc_set_imsk_other(tid, cc_get_imsk_other(tid) | (1 << pil));
+	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+#else
+	cc_set_imsk(cc_get_imsk() | (1 << pil));
+#endif
 }
=20
-static void sun4d_disable_irq(unsigned int irq)
+static void sun4d_sbus_enable_irq(struct irq_data *data)
 {
-	int tid =3D sbus_tid[(irq >> 5) - 1];
+	struct sun4d_sbus_handler_data *handler_data =3D data->handler_data;
+	unsigned int pil;
+#ifdef CONFIG_SMP
+	int tid =3D handler_data->tid;
 	unsigned long flags;
+#endif
=20
-	if (irq < NR_IRQS)
-		return;
+	pil =3D handler_data->pil;
=20
+#ifdef CONFIG_SMP
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
-	cc_set_imsk_other(tid, cc_get_imsk_other(tid) | (1 << sbus_to_pil[(irq >>=
 2) & 7]));
+	cc_set_imsk_other(tid, cc_get_imsk_other(tid) | ~(1 << pil));
 	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
+#else
+	cc_set_imsk(cc_get_imsk() | ~(1 << pil));
+#endif
 }
=20
-static void sun4d_enable_irq(unsigned int irq)
+/*
+ * XXX need shutdown too and virt_irq_unlock() plus appropriate
+ * XXX smp locking
+ */
+static unsigned int sun4d_sbus_startup_irq(struct irq_data *data)
 {
-	int tid =3D sbus_tid[(irq >> 5) - 1];
-	unsigned long flags;
+	irq_link(data->irq);
+	sun4d_sbus_enable_irq(data);
+	return 0;
+}
+
+struct irq_chip sun4d_sbus_irq =3D {
+	.name		=3D "sun4di-sbus",
+	.irq_startup	=3D sun4d_sbus_startup_irq,
+	.irq_enable	=3D sun4d_sbus_enable_irq,
+	.irq_disable	=3D sun4d_sbus_disable_irq,
+	.irq_ack	=3D sun4d_sbus_disable_irq,
+};
+
+struct irq_chip sun4d_cpu_irq =3D {
+	.name	=3D "sun4d-cpu",
+};
=20
-	if (irq < NR_IRQS)
-		return;
=20
-	spin_lock_irqsave(&sun4d_imsk_lock, flags);
-	cc_set_imsk_other(tid, cc_get_imsk_other(tid) & ~(1 << sbus_to_pil[(irq >=
> 2) & 7]));
-	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
-}
=20
 #ifdef CONFIG_SMP
 static void sun4d_set_cpu_int(int cpu, int level)
@@ -503,8 +352,7 @@ static void __init sun4d_init_timers(irq_handler_t coun=
ter_fn)
 	master_l10_counter =3D &sun4d_timers->l10_cur_count;
=20
 	err =3D request_irq(TIMER_IRQ, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC),
-			  "timer", NULL);
+			  IRQF_DISABLED, "timer", NULL);
 	if (err) {
 		prom_printf("sun4d_init_timers: request_irq() failed with %d\n",
 		             err);
@@ -522,15 +370,6 @@ void __init sun4d_init_sbi_irq(void)
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
@@ -549,11 +388,31 @@ void __init sun4d_init_sbi_irq(void)
 	}
 }
=20
-int sun4d_build_device_irq(struct platform_device *op, int interrupt)
+/* XXX This isn't going to work properly for of_devices, must fix... */
+/*
+unsigned int sun4d_build_irq(struct sbus_dev *sdev, unsigned int irq)
+{
+	unsigned int virt_irq, real_irq;
+	int sbusl =3D pil_to_sbus[irq];
+
+	if (sbusl)
+		real_irq =3D sun4d_encode_real_irq(sdev->bus->board,
+		                               sbusl, sdev->slot);
+	else
+		real_irq =3D irq & 0xf;
+	virt_irq =3D virt_irq_alloc(real_irq, irq & 0xf);
+	if (virt_irq) {
+		unsigned long val =3D real_irq;
+
+		set_irq_chip(virt_irq, &sun4d_irq);
+		set_irq_chip_data(virt_irq, (void *) val);
+	}
+	return irq;
+}
+*/
+unsigned int sun4d_build_device_irq(struct platform_device *op,
+				    unsigned int interrupt)
 {
-	static int pil_to_sbus[] =3D {
-		0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
-	};
 	struct device_node *dp =3D op->dev.of_node;
 	struct device_node *io_unit, *sbi =3D dp->parent;
 	const struct linux_prom_registers *regs;
@@ -592,7 +451,7 @@ int sun4d_build_device_irq(struct platform_device *op, =
int interrupt)
=20
 	sbusl =3D pil_to_sbus[interrupt];
 	if (sbusl)
-		return (((board + 1) << 5) + (sbusl << 2) + slot);
+		return sun4d_encode_real_irq(board, sbusl, slot);
=20
 err_out:
 	return interrupt;
@@ -602,8 +461,6 @@ void __init sun4d_init_IRQ(void)
 {
 	local_irq_disable();
=20
-	BTFIXUPSET_CALL(enable_irq, sun4d_enable_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(disable_irq, sun4d_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NOR=
M);
=20
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 69df625..3537eab 100644
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
@@ -144,7 +149,7 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 #define SUN4M_TIMER_IRQ         (OBP_INT_LEVEL_ONBOARD | 10)
 #define SUM4M_PROFILE_IRQ       (OBP_INT_LEVEL_ONBOARD | 14)
=20
-static unsigned long irq_mask[0x50] =3D {
+static unsigned long sun4m_imask[0x50] =3D {
 	/* 0x00 - SMP */
 	0,  SUN4M_SOFT_INT(1),
 	SUN4M_SOFT_INT(2),  SUN4M_SOFT_INT(3),
@@ -182,105 +187,103 @@ static unsigned long irq_mask[0x50] =3D {
 	0, SUN4M_INT_VME(6), 0, 0
 };
=20
-static unsigned long sun4m_get_irqmask(unsigned int irq)
+static void sun4m_disable_irq(struct irq_data *data)
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
+static void sun4m_enable_irq(struct irq_data *data)
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
+	sun4m_enable_irq(data);
+	return 0;
 }
=20
-static void sun4m_enable_pil_irq(unsigned int pil)
+static struct irq_chip sun4m_irq =3D {
+	.name		=3D "sun4m",
+	.irq_startup	=3D sun4m_startup_irq,
+	.irq_enable	=3D sun4m_enable_irq,
+	.irq_disable	=3D sun4m_disable_irq,
+	.irq_ack	=3D sun4m_disable_irq,
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
+	handler_data->percpu =3D irq < OBP_INT_LEVEL_ONBOARD;
+	set_irq_chip(irq, &sun4m_irq);
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
@@ -358,6 +361,7 @@ static void __init sun4m_init_timers(irq_handler_t coun=
ter_fn)
 {
 	struct device_node *dp =3D of_find_node_by_name(NULL, "counter");
 	int i, err, len, num_cpu_timers;
+	unsigned int irq;
 	const u32 *addr;
=20
 	if (!dp) {
@@ -384,8 +388,9 @@ static void __init sun4m_init_timers(irq_handler_t coun=
ter_fn)
=20
 	master_l10_counter =3D &timers_global->l10_count;
=20
-	err =3D request_irq(SUN4M_TIMER_IRQ, counter_fn,
-			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
+	irq =3D sun4m_build_device_irq(NULL, SUN4M_TIMER_IRQ);
+
+	err =3D request_irq(irq, counter_fn, IRQF_DISABLED, "timer", NULL);
 	if (err) {
 		printk(KERN_ERR "sun4m_init_timers: Register IRQ error %d.\n",
 			err);
@@ -452,14 +457,12 @@ void __init sun4m_init_IRQ(void)
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
+	sparc_irq_config.profile_irq =3D SUM4M_PROFILE_IRQ;
=20
 #ifdef CONFIG_SMP
 	BTFIXUPSET_CALL(set_cpu_int, sun4m_send_ipi, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 5cc7dc5..9f0bfc4 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -277,7 +277,7 @@ static void __cpuinit smp_setup_percpu_timer(void)
 	load_profile_irq(cpu, lvl14_resolution);
=20
 	if (cpu =3D boot_cpu_id)
-		enable_pil_irq(14);
+		enable_irq(sparc_irq_config.profile_irq);
 }
=20
 static void __init smp4m_blackbox_id(unsigned *addr)
