From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Jan 2011 08:08:24 +0000
Subject: [PATCH 8/8] sparc32: irq_32.c cleanup
Message-Id: <1296288504-15933-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

- drop filename in file header
- drop unused includes
- add KERN_* to printk
- fix spaces =3D> tabs
- add spaces after reserved words
- drop all externs, they are now in header files

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq_32.c |  229 ++++++++++++++++++----------------------=
----
 1 files changed, 92 insertions(+), 137 deletions(-)

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 85db35d..974dab0 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -1,8 +1,8 @@
 /*
- *  arch/sparc/kernel/irq.c:  Interrupt request handling routines. On the
- *                            Sparc the IRQs are basically 'cast in stone'
- *                            and you are supposed to probe the prom's dev=
ice
- *                            node trees to find out who's got which IRQ.
+ * Interrupt request handling routines. On the
+ * Sparc the IRQs are basically 'cast in stone'
+ * and you are supposed to probe the prom's device
+ * node trees to find out who's got which IRQ.
  *
  *  Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
  *  Copyright (C) 1995 Miguel de Icaza (miguel@nuclecu.unam.mx)
@@ -11,40 +11,10 @@
  *  Copyright (C) 1998-2000 Anton Blanchard (anton@samba.org)
  */
=20
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/linkage.h>
 #include <linux/kernel_stat.h>
-#include <linux/signal.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/delay.h>
-#include <linux/threads.h>
-#include <linux/spinlock.h>
 #include <linux/seq_file.h>
=20
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/psr.h>
-#include <asm/smp.h>
-#include <asm/vaddrs.h>
-#include <asm/timer.h>
-#include <asm/openprom.h>
-#include <asm/oplib.h>
-#include <asm/traps.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <asm/pgalloc.h>
-#include <asm/pgtable.h>
 #include <asm/pcic.h>
-#include <asm/cacheflush.h>
-#include <asm/irq_regs.h>
 #include <asm/leon.h>
=20
 #include "kernel.h"
@@ -57,6 +27,7 @@
 #define SMP_NOP2
 #define SMP_NOP3
 #endif /* SMP */
+
 unsigned long arch_local_irq_save(void)
 {
 	unsigned long retval;
@@ -135,8 +106,7 @@ static void irq_panic(void)
 	prom_halt();
 }
=20
-void (*sparc_init_timers)(irq_handler_t ) -    (void (*)(irq_handler_t )) =
irq_panic;
+void (*sparc_init_timers)(irq_handler_t) =3D (void (*)(irq_handler_t))irq_=
panic;
=20
 /*
  * Dave Redman (djhr@tadpole.co.uk)
@@ -145,7 +115,7 @@ void (*sparc_init_timers)(irq_handler_t )   * instead, =
because some of the devices attach very early, I do something
  * equally sucky but at least we'll never try to free statically allocated
  * space or call kmalloc before kmalloc_init :(.
- *=20
+ *
  * In fact it's the timer10 that attaches first.. then timer14
  * then kmalloc_init is called.. then the tty interrupts attach.
  * hmmm....
@@ -166,22 +136,20 @@ DEFINE_SPINLOCK(irq_action_lock);
=20
 int show_interrupts(struct seq_file *p, void *v)
 {
-	int i =3D *(loff_t *) v;
-	struct irqaction * action;
+	int i =3D *(loff_t *)v;
+	struct irqaction *action;
 	unsigned long flags;
 #ifdef CONFIG_SMP
 	int j;
 #endif
=20
-	if (sparc_cpu_model =3D sun4d) {
-		extern int show_sun4d_interrupts(struct seq_file *, void *);
-	=09
+	if (sparc_cpu_model =3D sun4d)
 		return show_sun4d_interrupts(p, v);
-	}
+
 	spin_lock_irqsave(&irq_action_lock, flags);
 	if (i < NR_IRQS) {
 		action =3D sparc_irq[i].action;
-		if (!action)=20
+		if (!action)
 			goto out_unlock;
 		seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
@@ -195,7 +163,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_printf(p, " %c %s",
 			(action->flags & IRQF_DISABLED) ? '+' : ' ',
 			action->name);
-		for (action=ACtion->next; action; action =3D action->next) {
+		for (action =3D action->next; action; action =3D action->next) {
 			seq_printf(p, ",%s %s",
 				(action->flags & IRQF_DISABLED) ? " +" : "",
 				action->name);
@@ -209,22 +177,20 @@ out_unlock:
=20
 void free_irq(unsigned int irq, void *dev_id)
 {
-	struct irqaction * action;
+	struct irqaction *action;
 	struct irqaction **actionp;
-        unsigned long flags;
+	unsigned long flags;
 	unsigned int cpu_irq;
-=09
+
 	if (sparc_cpu_model =3D sun4d) {
-		extern void sun4d_free_irq(unsigned int, void *);
-	=09
 		sun4d_free_irq(irq, dev_id);
 		return;
 	}
 	cpu_irq =3D irq & (NR_IRQS - 1);
-        if (cpu_irq > 14) {  /* 14 irq levels on the sparc */
-                printk("Trying to free bogus IRQ %d\n", irq);
-                return;
-        }
+	if (cpu_irq > 14) {  /* 14 irq levels on the sparc */
+		printk(KERN_ERR "Trying to free bogus IRQ %d\n", irq);
+		return;
+	}
=20
 	spin_lock_irqsave(&irq_action_lock, flags);
=20
@@ -232,7 +198,7 @@ void free_irq(unsigned int irq, void *dev_id)
 	action =3D *actionp;
=20
 	if (!action->handler) {
-		printk("Trying to free free IRQ%d\n",irq);
+		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
 		goto out_unlock;
 	}
 	if (dev_id) {
@@ -242,19 +208,21 @@ void free_irq(unsigned int irq, void *dev_id)
 			actionp =3D &action->next;
 		}
 		if (!action) {
-			printk("Trying to free free shared IRQ%d\n",irq);
+			printk(KERN_ERR "Trying to free free shared IRQ%d\n",
+			       irq);
 			goto out_unlock;
 		}
 	} else if (action->flags & IRQF_SHARED) {
-		printk("Trying to free shared IRQ%d with NULL device ID\n", irq);
+		printk(KERN_ERR "Trying to free shared IRQ%d with NULL device ID\n",
+		       irq);
 		goto out_unlock;
 	}
-	if (action->flags & SA_STATIC_ALLOC)
-	{
-		/* This interrupt is marked as specially allocated
+	if (action->flags & SA_STATIC_ALLOC) {
+		/*
+		 * This interrupt is marked as specially allocated
 		 * so it is a bad idea to free it.
 		 */
-		printk("Attempt to free statically allocated IRQ%d (%s)\n",
+		printk(KERN_ERR "Attempt to free statically allocated IRQ%d (%s)\n",
 		       irq, action->name);
 		goto out_unlock;
 	}
@@ -275,7 +243,6 @@ void free_irq(unsigned int irq, void *dev_id)
 out_unlock:
 	spin_unlock_irqrestore(&irq_action_lock, flags);
 }
-
 EXPORT_SYMBOL(free_irq);
=20
 /*
@@ -297,44 +264,41 @@ void synchronize_irq(unsigned int irq)
 EXPORT_SYMBOL(synchronize_irq);
 #endif /* SMP */
=20
-void unexpected_irq(int irq, void *dev_id, struct pt_regs * regs)
+void unexpected_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-        int i;
-	struct irqaction * action;
+	int i;
+	struct irqaction *action;
 	unsigned int cpu_irq;
-=09
+
 	cpu_irq =3D irq & (NR_IRQS - 1);
 	action =3D sparc_irq[cpu_irq].action;
=20
-        printk("IO device interrupt, irq =3D %d\n", irq);
-        printk("PC =3D %08lx NPC =3D %08lx FP=3D%08lx\n", regs->pc,=20
+	printk(KERN_ERR "IO device interrupt, irq =3D %d\n", irq);
+	printk(KERN_ERR "PC =3D %08lx NPC =3D %08lx FP=3D%08lx\n", regs->pc,
 		    regs->npc, regs->u_regs[14]);
 	if (action) {
-		printk("Expecting: ");
-        	for (i =3D 0; i < 16; i++)
-                	if (action->handler)
-                        	printk("[%s:%d:0x%x] ", action->name,
-				       (int) i, (unsigned int) action->handler);
+		printk(KERN_ERR "Expecting: ");
+		for (i =3D 0; i < 16; i++)
+			if (action->handler)
+				printk(KERN_CONT "[%s:%d:0x%x] ", action->name,
+				       i, (unsigned int)action->handler);
 	}
-        printk("AIEEE\n");
+	printk(KERN_ERR "AIEEE\n");
 	panic("bogus interrupt received");
 }
=20
-void handler_irq(int pil, struct pt_regs * regs)
+void handler_irq(int pil, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	struct irqaction * action;
+	struct irqaction *action;
 	int cpu =3D smp_processor_id();
-#ifdef CONFIG_SMP
-	extern void smp4m_irq_rotate(int cpu);
-#endif
=20
 	old_regs =3D set_irq_regs(regs);
 	irq_enter();
 	disable_pil_irq(pil);
 #ifdef CONFIG_SMP
 	/* Only rotate on lower priority IRQs (scsi, ethernet, etc.). */
-	if((sparc_cpu_model=3Dsun4m) && (pil < 10))
+	if ((sparc_cpu_model=3Dsun4m) && (pil < 10))
 		smp4m_irq_rotate(cpu);
 #endif
 	action =3D sparc_irq[pil].action;
@@ -354,7 +318,8 @@ void handler_irq(int pil, struct pt_regs * regs)
=20
 #if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
=20
-/* Fast IRQs on the Sparc can only have one routine attached to them,
+/*
+ * Fast IRQs on the Sparc can only have one routine attached to them,
  * thus no sharing possible.
  */
 static int request_fast_irq(unsigned int irq,
@@ -367,15 +332,13 @@ static int request_fast_irq(unsigned int irq,
 	int ret;
 #if defined CONFIG_SMP && !defined CONFIG_SPARC_LEON
 	struct tt_entry *trap_table;
-	extern struct tt_entry trapbase_cpu1, trapbase_cpu2, trapbase_cpu3;
 #endif
-=09
 	cpu_irq =3D irq & (NR_IRQS - 1);
-	if(cpu_irq > 14) {
+	if (cpu_irq > 14) {
 		ret =3D -EINVAL;
 		goto out;
 	}
-	if(!handler) {
+	if (!handler) {
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -383,34 +346,33 @@ static int request_fast_irq(unsigned int irq,
 	spin_lock_irqsave(&irq_action_lock, flags);
=20
 	action =3D sparc_irq[cpu_irq].action;
-	if(action) {
-		if(action->flags & IRQF_SHARED)
+	if (action) {
+		if (action->flags & IRQF_SHARED)
 			panic("Trying to register fast irq when already shared.\n");
-		if(irqflags & IRQF_SHARED)
+		if (irqflags & IRQF_SHARED)
 			panic("Trying to register fast irq as shared.\n");
=20
 		/* Anyway, someone already owns it so cannot be made fast. */
-		printk("request_fast_irq: Trying to register yet already owned.\n");
+		printk(KERN_ERR "request_fast_irq: Trying to register yet already owned.=
\n");
 		ret =3D -EBUSY;
 		goto out_unlock;
 	}
=20
-	/* If this is flagged as statically allocated then we use our
+	/*
+	 * If this is flagged as statically allocated then we use our
 	 * private struct which is never freed.
 	 */
 	if (irqflags & SA_STATIC_ALLOC) {
-	    if (static_irq_count < MAX_STATIC_ALLOC)
-		action =3D &static_irqaction[static_irq_count++];
-	    else
-		printk("Fast IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n",
-		       irq, devname);
+		if (static_irq_count < MAX_STATIC_ALLOC)
+			action =3D &static_irqaction[static_irq_count++];
+		else
+			printk(KERN_ERR "Fast IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n=
",
+			       irq, devname);
 	}
-=09
+
 	if (action =3D NULL)
-	    action =3D kmalloc(sizeof(struct irqaction),
-						 GFP_ATOMIC);
-=09
-	if (!action) {=20
+		action =3D kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
+	if (!action) {
 		ret =3D -ENOMEM;
 		goto out_unlock;
 	}
@@ -426,9 +388,12 @@ static int request_fast_irq(unsigned int irq,
=20
 	INSTANTIATE(sparc_ttable)
 #if defined CONFIG_SMP && !defined CONFIG_SPARC_LEON
-	trap_table =3D &trapbase_cpu1; INSTANTIATE(trap_table)
-	trap_table =3D &trapbase_cpu2; INSTANTIATE(trap_table)
-	trap_table =3D &trapbase_cpu3; INSTANTIATE(trap_table)
+	trap_table =3D &trapbase_cpu1;
+	INSTANTIATE(trap_table)
+	trap_table =3D &trapbase_cpu2;
+	INSTANTIATE(trap_table)
+	trap_table =3D &trapbase_cpu3;
+	INSTANTIATE(trap_table)
 #endif
 #undef INSTANTIATE
 	/*
@@ -454,7 +419,8 @@ out:
 	return ret;
 }
=20
-/* These variables are used to access state from the assembler
+/*
+ * These variables are used to access state from the assembler
  * interrupt handler, floppy_hardint, so we cannot put these in
  * the floppy driver image because that would not work in the
  * modular case.
@@ -477,8 +443,6 @@ EXPORT_SYMBOL(pdma_base);
 unsigned long pdma_areasize;
 EXPORT_SYMBOL(pdma_areasize);
=20
-extern void floppy_hardint(void);
-
 static irq_handler_t floppy_irq_handler;
=20
 void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs)
@@ -494,9 +458,11 @@ void sparc_floppy_irq(int irq, void *dev_id, struct pt=
_regs *regs)
 	irq_exit();
 	enable_pil_irq(irq);
 	set_irq_regs(old_regs);
-	// XXX Eek, it's totally changed with preempt_count() and such
-	// if (softirq_pending(cpu))
-	//	do_softirq();
+	/*
+	 * XXX Eek, it's totally changed with preempt_count() and such
+	 * if (softirq_pending(cpu))
+	 *	do_softirq();
+	 */
 }
=20
 int sparc_floppy_request_irq(int irq, unsigned long flags,
@@ -511,21 +477,18 @@ EXPORT_SYMBOL(sparc_floppy_request_irq);
=20
 int request_irq(unsigned int irq,
 		irq_handler_t handler,
-		unsigned long irqflags, const char * devname, void *dev_id)
+		unsigned long irqflags, const char *devname, void *dev_id)
 {
-	struct irqaction * action, **actionp;
+	struct irqaction *action, **actionp;
 	unsigned long flags;
 	unsigned int cpu_irq;
 	int ret;
-=09
-	if (sparc_cpu_model =3D sun4d) {
-		extern int sun4d_request_irq(unsigned int,=20
-					     irq_handler_t ,
-					     unsigned long, const char *, void *);
+
+	if (sparc_cpu_model =3D sun4d)
 		return sun4d_request_irq(irq, handler, irqflags, devname, dev_id);
-	}
+
 	cpu_irq =3D irq & (NR_IRQS - 1);
-	if(cpu_irq > 14) {
+	if (cpu_irq > 14) {
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -533,7 +496,7 @@ int request_irq(unsigned int irq,
 		ret =3D -EINVAL;
 		goto out;
 	}
-	   =20
+
 	spin_lock_irqsave(&irq_action_lock, flags);
=20
 	actionp =3D &sparc_irq[cpu_irq].action;
@@ -544,7 +507,8 @@ int request_irq(unsigned int irq,
 			goto out_unlock;
 		}
 		if ((action->flags & IRQF_DISABLED) !=3D (irqflags & IRQF_DISABLED)) {
-			printk("Attempt to mix fast and slow interrupts on IRQ%d denied\n", irq=
);
+			printk(KERN_ERR "Attempt to mix fast and slow interrupts on IRQ%d denie=
d\n",
+			       irq);
 			ret =3D -EBUSY;
 			goto out_unlock;
 		}
@@ -559,14 +523,12 @@ int request_irq(unsigned int irq,
 		if (static_irq_count < MAX_STATIC_ALLOC)
 			action =3D &static_irqaction[static_irq_count++];
 		else
-			printk("Request for IRQ%d (%s) SA_STATIC_ALLOC failed using kmalloc\n",=
 irq, devname);
+			printk(KERN_ERR "Request for IRQ%d (%s) SA_STATIC_ALLOC failed using km=
alloc\n",
+			       irq, devname);
 	}
-=09
 	if (action =3D NULL)
-		action =3D kmalloc(sizeof(struct irqaction),
-						     GFP_ATOMIC);
-=09
-	if (!action) {=20
+		action =3D kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
+	if (!action) {
 		ret =3D -ENOMEM;
 		goto out_unlock;
 	}
@@ -587,7 +549,6 @@ out_unlock:
 out:
 	return ret;
 }
-
 EXPORT_SYMBOL(request_irq);
=20
 void disable_irq_nosync(unsigned int irq)
@@ -606,24 +567,22 @@ void enable_irq(unsigned int irq)
 {
 	__enable_irq(irq);
 }
-
 EXPORT_SYMBOL(enable_irq);
=20
-/* We really don't need these at all on the Sparc.  We only have
+/*
+ * We really don't need these at all on the Sparc.  We only have
  * stubs here because they are exported to modules.
  */
 unsigned long probe_irq_on(void)
 {
 	return 0;
 }
-
 EXPORT_SYMBOL(probe_irq_on);
=20
 int probe_irq_off(unsigned long mask)
 {
 	return 0;
 }
-
 EXPORT_SYMBOL(probe_irq_off);
=20
 /* djhr
@@ -636,11 +595,7 @@ EXPORT_SYMBOL(probe_irq_off);
=20
 void __init init_IRQ(void)
 {
-	extern void sun4c_init_IRQ( void );
-	extern void sun4m_init_IRQ( void );
-	extern void sun4d_init_IRQ( void );
-
-	switch(sparc_cpu_model) {
+	switch (sparc_cpu_model) {
 	case sun4c:
 	case sun4:
 		sun4c_init_IRQ();
@@ -656,7 +611,7 @@ void __init init_IRQ(void)
 #endif
 		sun4m_init_IRQ();
 		break;
-	=09
+
 	case sun4d:
 		sun4d_init_IRQ();
 		break;
--=20
1.6.0.6

