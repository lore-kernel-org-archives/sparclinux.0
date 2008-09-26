From: Robert Reif <reif@earthlink.net>
Date: Fri, 26 Sep 2008 11:47:57 +0000
Subject: PATCH sun4m interrupt mask cleanup
Message-Id: <48DCCBED.3080408@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050405000909000502080705"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405000909000502080705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here is an updated version of a patch I wrote 6 years ago
http://marc.info/?l=linux-sparc&m=103939103607617&w=2
that simplifies interrupt mask lookup.  It's main purpose
is to add VME bus support but it's really a cleanup of the mask code.

Signed-off-by: Robert Reif <reif@earthlink.net>



--------------050405000909000502080705
Content-Type: text/plain;
 name="vmeirq.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmeirq.diff.txt"

diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index ec66d4a..f103171 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -71,8 +71,9 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 
 #define	SUN4M_INT_MASKALL	0x80000000	  /* mask all interrupts */
 #define	SUN4M_INT_MODULE_ERR	0x40000000	  /* module error */
-#define	SUN4M_INT_M2S_WRITE	0x20000000	  /* write buffer error */
-#define	SUN4M_INT_ECC		0x10000000	  /* ecc memory error */
+#define	SUN4M_INT_M2S_WRITE_ERR	0x20000000	  /* write buffer error */
+#define	SUN4M_INT_ECC_ERR	0x10000000	  /* ecc memory error */
+#define	SUN4M_INT_VME_ERR	0x08000000	  /* vme async error */
 #define	SUN4M_INT_FLOPPY	0x00400000	  /* floppy disk */
 #define	SUN4M_INT_MODULE	0x00200000	  /* module interrupt */
 #define	SUN4M_INT_VIDEO		0x00100000	  /* onboard video */
@@ -83,10 +84,22 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 #define	SUN4M_INT_SERIAL	0x00008000	  /* serial ports */
 #define	SUN4M_INT_KBDMS		0x00004000	  /* keyboard/mouse */
 #define	SUN4M_INT_SBUSBITS	0x00003F80	  /* sbus int bits */
+#define	SUN4M_INT_VMEBITS	0x0000007F	  /* vme int bits */
+
+#define	SUN4M_INT_ERROR		(SUN4M_INT_MODULE_ERR |    \
+				 SUN4M_INT_M2S_WRITE_ERR | \
+				 SUN4M_INT_ECC_ERR |       \
+				 SUN4M_INT_VME_ERR)
 
 #define SUN4M_INT_SBUS(x)	(1 << (x+7))
 #define SUN4M_INT_VME(x)	(1 << (x))
 
+/* Interrupt levels used by OBP */
+#define	OBP_INT_LEVEL_SOFT	0x10
+#define	OBP_INT_LEVEL_ONBOARD	0x20
+#define	OBP_INT_LEVEL_SBUS	0x30
+#define	OBP_INT_LEVEL_VME	0x40
+
 /* Interrupt level assignment on sun4m:
  *
  *	level		source
@@ -140,59 +153,57 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
  * power:	0x22	onboard power device (XXX unknown mask bit XXX)
  */
 
-/* These tables only apply for interrupts greater than 15..
- * 
- * any intr value below 0x10 is considered to be a soft-int
- * this may be useful or it may not.. but that's how I've done it.
- * and it won't clash with what OBP is telling us about devices.
- *
- * take an encoded intr value and lookup if it's valid
- * then get the mask bits that match from irq_mask
- *
- * P3: Translation from irq 0x0d to mask 0x2000 is for MrCoffee.
- */
-static unsigned char irq_xlate[32] = {
-    /*  0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  a,  b,  c,  d,  e,  f */
-	0,  0,  0,  0,  1,  0,  2,  0,  3,  0,  4,  5,  6, 14,  0,  7,
-	0,  0,  8,  9,  0, 10,  0, 11,  0, 12,  0, 13,  0, 14,  0,  0
-};
-
-static unsigned long irq_mask[] = {
-	0,						  /* illegal index */
-	SUN4M_INT_SCSI,				  	  /*  1 irq 4 */
-	SUN4M_INT_ETHERNET,				  /*  2 irq 6 */
-	SUN4M_INT_VIDEO,				  /*  3 irq 8 */
-	SUN4M_INT_REALTIME,				  /*  4 irq 10 */
-	SUN4M_INT_FLOPPY,				  /*  5 irq 11 */
-	(SUN4M_INT_SERIAL | SUN4M_INT_KBDMS),	  	  /*  6 irq 12 */
-	SUN4M_INT_MODULE_ERR,			  	  /*  7 irq 15 */
-	SUN4M_INT_SBUS(0),				  /*  8 irq 2 */
-	SUN4M_INT_SBUS(1),				  /*  9 irq 3 */
-	SUN4M_INT_SBUS(2),				  /* 10 irq 5 */
-	SUN4M_INT_SBUS(3),				  /* 11 irq 7 */
-	SUN4M_INT_SBUS(4),				  /* 12 irq 9 */
-	SUN4M_INT_SBUS(5),				  /* 13 irq 11 */
-	SUN4M_INT_SBUS(6)				  /* 14 irq 13 */
+static unsigned long irq_mask[0x50] = {
+	/* SMP */
+	0,  SUN4M_SOFT_INT(1),
+	SUN4M_SOFT_INT(2),  SUN4M_SOFT_INT(3),
+	SUN4M_SOFT_INT(4),  SUN4M_SOFT_INT(5),
+	SUN4M_SOFT_INT(6),  SUN4M_SOFT_INT(7),
+	SUN4M_SOFT_INT(8),  SUN4M_SOFT_INT(9),
+	SUN4M_SOFT_INT(10), SUN4M_SOFT_INT(11),
+	SUN4M_SOFT_INT(12), SUN4M_SOFT_INT(13),
+	SUN4M_SOFT_INT(14), SUN4M_SOFT_INT(15),
+	/* soft */
+	0,  SUN4M_SOFT_INT(1),
+	SUN4M_SOFT_INT(2),  SUN4M_SOFT_INT(3),
+	SUN4M_SOFT_INT(4),  SUN4M_SOFT_INT(5),
+	SUN4M_SOFT_INT(6),  SUN4M_SOFT_INT(7),
+	SUN4M_SOFT_INT(8),  SUN4M_SOFT_INT(9),
+	SUN4M_SOFT_INT(10), SUN4M_SOFT_INT(11),
+	SUN4M_SOFT_INT(12), SUN4M_SOFT_INT(13),
+	SUN4M_SOFT_INT(14), SUN4M_SOFT_INT(15),
+	/* onboard */
+	0, 0, 0, 0,
+	SUN4M_INT_SCSI,  0, SUN4M_INT_ETHERNET, 0,
+	SUN4M_INT_VIDEO, SUN4M_INT_MODULE,
+	SUN4M_INT_REALTIME, SUN4M_INT_FLOPPY,
+	(SUN4M_INT_SERIAL | SUN4M_INT_KBDMS),
+	SUN4M_INT_AUDIO, 0, SUN4M_INT_MODULE_ERR,
+	/* sbus */
+	0, 0, SUN4M_INT_SBUS(0), SUN4M_INT_SBUS(1),
+	0, SUN4M_INT_SBUS(2), 0, SUN4M_INT_SBUS(3),
+	0, SUN4M_INT_SBUS(4), 0, SUN4M_INT_SBUS(5),
+	0, SUN4M_INT_SBUS(6), 0, 0,
+	/* vme */
+	0, 0, SUN4M_INT_VME(0), SUN4M_INT_VME(1),
+	0, SUN4M_INT_VME(2), 0, SUN4M_INT_VME(3),
+	0, SUN4M_INT_VME(4), 0, SUN4M_INT_VME(5),
+	0, SUN4M_INT_VME(6), 0, 0
 };
 
 static unsigned long sun4m_get_irqmask(unsigned int irq)
 {
 	unsigned long mask;
     
-	if (irq > 0x20) {
-		/* OBIO/SBUS interrupts */
-		irq &= 0x1f;
-		mask = irq_mask[irq_xlate[irq]];
-		if (!mask)
-			printk("sun4m_get_irqmask: IRQ%d has no valid mask!\n",irq);
-	} else {
-		/* Soft Interrupts will come here.
-		 * Currently there is no way to trigger them but I'm sure
-		 * something could be cooked up.
-		 */
-		irq &= 0xf;
-		mask = SUN4M_SOFT_INT(irq);
-	}
+	if (irq < 0x50)
+		mask = irq_mask[irq];
+	else
+		mask = 0;
+
+	if (!mask)
+		printk(KERN_ERR "sun4m_get_irqmask: IRQ%d has no valid mask!\n",
+		       irq);
+
 	return mask;
 }
 
@@ -247,10 +258,10 @@ static unsigned long cpu_pil_to_imask[16] = {
 /*9*/	SUN4M_INT_SBUS(4) | SUN4M_INT_VME(4) | SUN4M_INT_MODULE_ERR,
 /*10*/	SUN4M_INT_REALTIME,
 /*11*/	SUN4M_INT_SBUS(5) | SUN4M_INT_VME(5) | SUN4M_INT_FLOPPY,
-/*12*/	SUN4M_INT_SERIAL | SUN4M_INT_KBDMS,
-/*13*/	SUN4M_INT_AUDIO,
+/*12*/	SUN4M_INT_SERIAL  | SUN4M_INT_KBDMS,
+/*13*/	SUN4M_INT_SBUS(6) | SUN4M_INT_VME(6) | SUN4M_INT_AUDIO,
 /*14*/	SUN4M_INT_E14,
-/*15*/	0x00000000
+/*15*/	SUN4M_INT_ERROR
 };
 
 /* We assume the caller has disabled local interrupts when these are called,
@@ -304,8 +315,7 @@ struct sun4m_timer_global {
 
 static struct sun4m_timer_global __iomem *timers_global;
 
-#define OBIO_INTR	0x20
-#define TIMER_IRQ  	(OBIO_INTR | 10)
+#define TIMER_IRQ  	(OBP_INT_LEVEL_ONBOARD | 10)
 
 unsigned int lvl14_resolution = (((1000000/HZ) + 1) << 10);
 
@@ -314,6 +324,33 @@ static void sun4m_clear_clock_irq(void)
 	sbus_readl(&timers_global->l10_limit);
 }
 
+void sun4m_nmi(struct pt_regs *regs)
+{
+	unsigned long afsr, afar, si;
+
+	printk(KERN_ERR "Aieee: sun4m NMI received!\n");
+	/* XXX HyperSparc hack XXX */
+	__asm__ __volatile__("mov 0x500, %%g1\n\t"
+			     "lda [%%g1] 0x4, %0\n\t"
+			     "mov 0x600, %%g1\n\t"
+			     "lda [%%g1] 0x4, %1\n\t" :
+			     "=r" (afsr), "=r" (afar));
+	printk(KERN_ERR "afsr=%08lx afar=%08lx\n", afsr, afar);
+	si = sbus_readl(&sun4m_irq_global->pending);
+	printk(KERN_ERR "si=%08lx\n", si);
+	if (si & SUN4M_INT_MODULE_ERR)
+		printk(KERN_ERR "Module async error\n");
+	if (si & SUN4M_INT_M2S_WRITE_ERR)
+		printk(KERN_ERR "MBus/SBus async error\n");
+	if (si & SUN4M_INT_ECC_ERR)
+		printk(KERN_ERR "ECC memory error\n");
+	if (si & SUN4M_INT_VME_ERR)
+		printk(KERN_ERR "VME async error\n");
+	printk(KERN_ERR "you lose buddy boy...\n");
+	show_regs(regs);
+	prom_halt();
+}
+
 /* Exported for sun4m_smp.c */
 void sun4m_clear_profile_irq(int cpu)
 {
diff --git a/arch/sparc/kernel/traps.c b/arch/sparc/kernel/traps.c
index 5d45d5f..2b7d506 100644
--- a/arch/sparc/kernel/traps.c
+++ b/arch/sparc/kernel/traps.c
@@ -43,23 +43,6 @@ void syscall_trace_exit(struct pt_regs *regs)
 {
 }
 
-void sun4m_nmi(struct pt_regs *regs)
-{
-	unsigned long afsr, afar;
-
-	printk("Aieee: sun4m NMI received!\n");
-	/* XXX HyperSparc hack XXX */
-	__asm__ __volatile__("mov 0x500, %%g1\n\t"
-			     "lda [%%g1] 0x4, %0\n\t"
-			     "mov 0x600, %%g1\n\t"
-			     "lda [%%g1] 0x4, %1\n\t" :
-			     "=r" (afsr), "=r" (afar));
-	printk("afsr=%08lx afar=%08lx\n", afsr, afar);
-	printk("you lose buddy boy...\n");
-	show_regs(regs);
-	prom_halt();
-}
-
 void sun4d_nmi(struct pt_regs *regs)
 {
 	printk("Aieee: sun4d NMI received!\n");

--------------050405000909000502080705--
