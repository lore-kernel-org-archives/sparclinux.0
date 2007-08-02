From: David Miller <davem@davemloft.net>
Date: Thu, 02 Aug 2007 07:18:37 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <20070802.001837.40833421.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 30 Jul 2007 21:05:09 +1000

> On 7/30/07, David Miller <davem@davemloft.net> wrote:
> > From: "Julian Calaby" <julian.calaby@gmail.com>
> > Date: Mon, 30 Jul 2007 10:09:33 +1000
> >
> > > Stupid question, but: Why is it possible to select it to compile as a
> > > module when it cannot?
> >
> > There isn't an easy way to describe this in the Kconfig language
> > at this time.
> 
> Forgive my utter ignorance, but surely setting it to be a bool would
> be sufficient until the underlying problem can be fixed.
> 
> Possibly something like the following patch: (make menuconfig tested only)
> 
> (note that this is not a serious patch, yet, and probably has it's
> tabs and line endings messed up due to being pasted into gMail)

Thanks for the suggestion, it would work but penalize SPARC64
which does not have the modular floppy driver problems.

And it's so ugly a thing to do just for sparc32.

Since the issue is being forced, I made another attempt to make
modular floppy work on sparc32.  If people could test this patch I'd
apprecaite it.

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index eac3838..88d2cef 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1,7 +1,6 @@
-/* $Id: entry.S,v 1.170 2001/11/13 00:57:05 davem Exp $
- * arch/sparc/kernel/entry.S:  Sparc trap low-level entry points.
+/* arch/sparc/kernel/entry.S:  Sparc trap low-level entry points.
  *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1995, 2007 David S. Miller (davem@davemloft.net)
  * Copyright (C) 1996 Eddie C. Dost   (ecd@skynet.be)
  * Copyright (C) 1996 Miguel de Icaza (miguel@nuclecu.unam.mx)
  * Copyright (C) 1996-1999 Jakub Jelinek   (jj@sunsite.mff.cuni.cz)
@@ -129,7 +128,7 @@ trap_low:
 	RESTORE_ALL
 #endif
 
-#ifdef CONFIG_BLK_DEV_FD
+#if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
 	.text
 	.align	4
 	.globl	floppy_hardint
diff --git a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
index 75b2240..b76dc03 100644
--- a/arch/sparc/kernel/irq.c
+++ b/arch/sparc/kernel/irq.c
@@ -351,34 +351,14 @@ void handler_irq(int irq, struct pt_regs * regs)
 	set_irq_regs(old_regs);
 }
 
-#ifdef CONFIG_BLK_DEV_FD
-extern void floppy_interrupt(int irq, void *dev_id);
-
-void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs;
-	int cpu = smp_processor_id();
-
-	old_regs = set_irq_regs(regs);
-	disable_pil_irq(irq);
-	irq_enter();
-	kstat_cpu(cpu).irqs[irq]++;
-	floppy_interrupt(irq, dev_id);
-	irq_exit();
-	enable_pil_irq(irq);
-	set_irq_regs(old_regs);
-	// XXX Eek, it's totally changed with preempt_count() and such
-	// if (softirq_pending(cpu))
-	//	do_softirq();
-}
-#endif
+#if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_FD_MODULE)
 
 /* Fast IRQs on the Sparc can only have one routine attached to them,
  * thus no sharing possible.
  */
-int request_fast_irq(unsigned int irq,
-		     irq_handler_t handler,
-		     unsigned long irqflags, const char *devname)
+static int request_fast_irq(unsigned int irq,
+			    void (*handler)(void),
+			    unsigned long irqflags, const char *devname)
 {
 	struct irqaction *action;
 	unsigned long flags;
@@ -457,7 +437,6 @@ int request_fast_irq(unsigned int irq,
 	 */
 	flush_cache_all();
 
-	action->handler = handler;
 	action->flags = irqflags;
 	cpus_clear(action->mask);
 	action->name = devname;
@@ -475,6 +454,61 @@ out:
 	return ret;
 }
 
+/* These variables are used to access state from the assembler
+ * interrupt handler, floppy_hardint, so we cannot put these in
+ * the floppy driver image because that would not work in the
+ * modular case.
+ */
+volatile unsigned char *fdc_status;
+EXPORT_SYMBOL(fdc_status);
+
+char *pdma_vaddr;
+EXPORT_SYMBOL(pdma_vaddr);
+
+unsigned long pdma_size;
+EXPORT_SYMBOL(pdma_size);
+
+volatile int doing_pdma;
+EXPORT_SYMBOL(doing_pdma);
+
+char *pdma_base;
+EXPORT_SYMBOL(pdma_base);
+
+unsigned long pdma_areasize;
+EXPORT_SYMBOL(pdma_areasize);
+
+extern void floppy_hardint(void);
+
+static irqreturn_t (*floppy_irq_handler)(int irq, void *dev_id);
+
+void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	int cpu = smp_processor_id();
+
+	old_regs = set_irq_regs(regs);
+	disable_pil_irq(irq);
+	irq_enter();
+	kstat_cpu(cpu).irqs[irq]++;
+	floppy_irq_handler(irq, dev_id);
+	irq_exit();
+	enable_pil_irq(irq);
+	set_irq_regs(old_regs);
+	// XXX Eek, it's totally changed with preempt_count() and such
+	// if (softirq_pending(cpu))
+	//	do_softirq();
+}
+
+int sparc_floppy_request_irq(int irq, unsigned long flags,
+			     irqreturn_t (*irq_handler)(int irq, void *))
+{
+	floppy_irq_handler = irq_handler;
+	return request_fast_irq(irq, floppy_hardint, flags, "floppy");
+}
+EXPORT_SYMBOL(sparc_floppy_request_irq);
+
+#endif
+
 int request_irq(unsigned int irq,
 		irq_handler_t handler,
 		unsigned long irqflags, const char * devname, void *dev_id)
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 7b4abde..ef647ac 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -143,7 +143,6 @@ EXPORT_SYMBOL(mstk48t02_regs);
 EXPORT_SYMBOL(set_auxio);
 EXPORT_SYMBOL(get_auxio);
 #endif
-EXPORT_SYMBOL(request_fast_irq);
 EXPORT_SYMBOL(io_remap_pfn_range);
   /* P3: iounit_xxx may be needed, sun4d users */
 /* EXPORT_SYMBOL(iounit_map_dma_init); */
diff --git a/include/asm-sparc/floppy.h b/include/asm-sparc/floppy.h
index 28ce2b9..acd06d8 100644
--- a/include/asm-sparc/floppy.h
+++ b/include/asm-sparc/floppy.h
@@ -48,7 +48,7 @@ struct sun_flpy_controller {
 
 /* You'll only ever find one controller on a SparcStation anyways. */
 static struct sun_flpy_controller *sun_fdc = NULL;
-volatile unsigned char *fdc_status;
+extern volatile unsigned char *fdc_status;
 
 struct sun_floppy_ops {
 	unsigned char (*fd_inb)(int port);
@@ -225,13 +225,13 @@ static void sun_82077_fd_outb(unsigned char value, int port)
  * underruns.  If non-zero, doing_pdma encodes the direction of
  * the transfer for debugging.  1=read 2=write
  */
-char *pdma_vaddr;
-unsigned long pdma_size;
-volatile int doing_pdma = 0;
+extern char *pdma_vaddr;
+extern unsigned long pdma_size;
+extern volatile int doing_pdma;
 
 /* This is software state */
-char *pdma_base = NULL;
-unsigned long pdma_areasize;
+extern char *pdma_base;
+extern unsigned long pdma_areasize;
 
 /* Common routines to all controller types on the Sparc. */
 static __inline__ void virtual_dma_init(void)
@@ -281,7 +281,8 @@ static __inline__ void sun_fd_enable_dma(void)
 }
 
 /* Our low-level entry point in arch/sparc/kernel/entry.S */
-irqreturn_t floppy_hardint(int irq, void *unused);
+extern int sparc_floppy_request_irq(int irq, unsigned long flags,
+				    irqreturn_t (*irq_handler)(int irq, void *));
 
 static int sun_fd_request_irq(void)
 {
@@ -290,8 +291,9 @@ static int sun_fd_request_irq(void)
 
 	if(!once) {
 		once = 1;
-		error = request_fast_irq(FLOPPY_IRQ, floppy_hardint,
-					 IRQF_DISABLED, "floppy");
+		error = sparc_floppy_request_irq(FLOPPY_IRQ,
+						 IRQF_DISABLED,
+						 floppy_interrupt);
 		return ((error = 0) ? 0 : -1);
 	} else return 0;
 }
diff --git a/include/asm-sparc/irq.h b/include/asm-sparc/irq.h
index 61fb996..fe205cc 100644
--- a/include/asm-sparc/irq.h
+++ b/include/asm-sparc/irq.h
@@ -1,7 +1,6 @@
-/* $Id: irq.h,v 1.32 2000/08/26 02:42:28 anton Exp $
- * irq.h: IRQ registers on the Sparc.
+/* irq.h: IRQ registers on the Sparc.
  *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1995, 2007 David S. Miller (davem@davemloft.net)
  */
 
 #ifndef _SPARC_IRQ_H
@@ -13,6 +12,4 @@
 
 #define irq_canonicalize(irq)	(irq)
 
-extern int request_fast_irq(unsigned int irq, irq_handler_t handler, unsigned long flags, __const__ char *devname);
-
 #endif
