From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 08 Feb 2004 02:02:39 +0000
Subject: RFC: [sparc32] Mask PIL in local_irq_xxx
Message-Id: <20040208020239.GA24193@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's a patch to mask out CWP when doing local_irq_restore.  Since
Pete's notes indicate that Dave advised outlining local_irq_restore
after making this change, it seems only sensible to outline the other
two as well, since they are of similar size and tend to be called in
the same places (local_irq_save especially).

This removes the need to restore the flags (release locks, etc) in the
same frame as they are saved (locks taken, etc).  So it's not "Fucked
Up" any more, though it's probably slightly slower.

Comments?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1554  -> 1.1555 
#	arch/sparc/kernel/irq.c	1.26    -> 1.27   
#	arch/sparc/kernel/sparc_ksyms.c	1.23    -> 1.24   
#	arch/sparc/kernel/process.c	1.33    -> 1.34   
#	include/asm-sparc/system.h	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/07	wesolows@foobazco.org	1.1555
# Mask PIL in local_irq operations.
# 
# Outline large local_irq functions.
# --------------------------------------------
#
diff -Nru a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
--- a/arch/sparc/kernel/irq.c	Sat Feb  7 17:41:58 2004
+++ b/arch/sparc/kernel/irq.c	Sat Feb  7 17:41:58 2004
@@ -52,6 +52,66 @@
 /* Used to protect the IRQ action lists */
 spinlock_t irq_action_lock = SPIN_LOCK_UNLOCKED;
 
+#ifdef CONFIG_SMP
+#define SMP_NOP2 "nop; nop;\n\t"
+#define SMP_NOP3 "nop; nop; nop;\n\t"
+#else
+#define SMP_NOP2
+#define SMP_NOP3
+#endif /* SMP */
+unsigned long __local_irq_save(void)
+{
+	unsigned long retval;
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"rd	%%psr, %0\n\t"
+		SMP_NOP3	/* Sun4m + Cypress + SMP bug */
+		"or	%0, %2, %1\n\t"
+		"wr	%1, 0, %%psr\n\t"
+		"nop; nop; nop\n"
+		: "=&r" (retval), "=r" (tmp)
+		: "i" (PSR_PIL)
+		: "memory");
+
+	return retval;
+}
+
+void local_irq_enable(void)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"rd	%%psr, %0\n\t"
+		SMP_NOP3	/* Sun4m + Cypress + SMP bug */
+		"andn	%0, %1, %0\n\t"
+		"wr	%0, 0, %%psr\n\t"
+		"nop; nop; nop\n"
+		: "=&r" (tmp)
+		: "i" (PSR_PIL)
+		: "memory");
+}
+
+void local_irq_restore(unsigned long old_psr)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"rd	%%psr, %0\n\t"
+		"and	%2, %1, %2\n\t"
+		SMP_NOP2	/* Sun4m + Cypress + SMP bug */
+		"andn	%0, %1, %0\n\t"
+		"wr	%0, %2, %%psr\n\t"
+		"nop; nop; nop\n"
+		: "=&r" (tmp)
+		: "i" (PSR_PIL), "r" (old_psr)
+		: "memory");
+}
+
+EXPORT_SYMBOL(__local_irq_save);
+EXPORT_SYMBOL(local_irq_enable);
+EXPORT_SYMBOL(local_irq_restore);
+
 /*
  * Dave Redman (djhr@tadpole.co.uk)
  *
diff -Nru a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
--- a/arch/sparc/kernel/process.c	Sat Feb  7 17:41:58 2004
+++ b/arch/sparc/kernel/process.c	Sat Feb  7 17:41:58 2004
@@ -148,11 +148,12 @@
 
 extern void (*prom_palette)(int);
 
+/* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
 void machine_halt(void)
 {
-	sti();
+	local_irq_enable();
 	mdelay(8);
-	cli();
+	local_irq_disable();
 	if (!serial_console && prom_palette)
 		prom_palette (1);
 	prom_halt();
@@ -165,9 +166,9 @@
 {
 	char *p;
 	
-	sti();
+	local_irq_enable();
 	mdelay(8);
-	cli();
+	local_irq_disable();
 
 	p = strchr (reboot_command, '\n');
 	if (p) *p = 0;
diff -Nru a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
--- a/arch/sparc/kernel/sparc_ksyms.c	Sat Feb  7 17:41:58 2004
+++ b/arch/sparc/kernel/sparc_ksyms.c	Sat Feb  7 17:41:58 2004
@@ -159,10 +159,6 @@
 /* IRQ implementation. */
 EXPORT_SYMBOL(global_irq_holder);
 EXPORT_SYMBOL(synchronize_irq);
-EXPORT_SYMBOL(__global_cli);
-EXPORT_SYMBOL(__global_sti);
-EXPORT_SYMBOL(__global_save_flags);
-EXPORT_SYMBOL(__global_restore_flags);
 
 /* Misc SMP information */
 EXPORT_SYMBOL(__cpu_number_map);
diff -Nru a/include/asm-sparc/system.h b/include/asm-sparc/system.h
--- a/include/asm-sparc/system.h	Sat Feb  7 17:41:58 2004
+++ b/include/asm-sparc/system.h	Sat Feb  7 17:41:58 2004
@@ -171,32 +171,11 @@
 /*
  * Changing the IRQ level on the Sparc.
  */
-extern __inline__ void setipl(unsigned long __orig_psr)
-{
-	__asm__ __volatile__(
-		"wr	%0, 0x0, %%psr\n\t"
-		"nop; nop; nop\n"
-		: /* no outputs */
-		: "r" (__orig_psr)
-		: "memory", "cc");
-}
+extern void local_irq_restore(unsigned long);
+extern unsigned long __local_irq_save(void);
+extern void local_irq_enable(void);
 
-extern __inline__ void local_irq_enable(void)
-{
-	unsigned long tmp;
-
-	__asm__ __volatile__(
-		"rd	%%psr, %0\n\t"
-		"nop; nop; nop;\n\t"	/* Sun4m + Cypress + SMP bug */
-		"andn	%0, %1, %0\n\t"
-		"wr	%0, 0x0, %%psr\n\t"
-		"nop; nop; nop\n"
-		: "=r" (tmp)
-		: "i" (PSR_PIL)
-		: "memory");
-}
-
-extern __inline__ unsigned long getipl(void)
+static inline unsigned long getipl(void)
 {
 	unsigned long retval;
 
@@ -204,75 +183,10 @@
 	return retval;
 }
 
-#if 0 /* not used */
-extern __inline__ unsigned long swap_pil(unsigned long __new_psr)
-{
-	unsigned long retval;
-
-	__asm__ __volatile__(
-		"rd	%%psr, %0\n\t"
-		"nop; nop; nop;\n\t"	/* Sun4m + Cypress + SMP bug */
-		"and	%0, %2, %%g1\n\t"
-		"and	%1, %2, %%g2\n\t"
-		"xorcc	%%g1, %%g2, %%g0\n\t"
-		"be	1f\n\t"
-		" nop\n\t"
-		"wr	%0, %2, %%psr\n\t"
-		"nop; nop; nop;\n"
-		"1:\n"
-		: "=&r" (retval)
-		: "r" (__new_psr), "i" (PSR_PIL)
-		: "g1", "g2", "memory", "cc");
-
-	return retval;
-}
-#endif
-
-extern __inline__ unsigned long read_psr_and_cli(void)
-{
-	unsigned long retval;
-
-	__asm__ __volatile__(
-		"rd	%%psr, %0\n\t"
-		"nop; nop; nop;\n\t"	/* Sun4m + Cypress + SMP bug */
-		"or	%0, %1, %%g1\n\t"
-		"wr	%%g1, 0x0, %%psr\n\t"
-		"nop; nop; nop\n\t"
-		: "=r" (retval)
-		: "i" (PSR_PIL)
-		: "g1", "memory");
-
-	return retval;
-}
-
 #define local_save_flags(flags)	((flags) = getipl())
-#define local_irq_save(flags)	((flags) = read_psr_and_cli())
-#define local_irq_restore(flags)	setipl((flags))
-#define local_irq_disable()	((void) read_psr_and_cli())
-
+#define local_irq_save(flags)	((flags) = __local_irq_save())
+#define local_irq_disable()	((void) __local_irq_save())
 #define irqs_disabled()		((getipl() & PSR_PIL) != 0)
-
-#ifdef CONFIG_SMP
-
-extern unsigned char global_irq_holder;
-
-#define save_and_cli(flags)   do { save_flags(flags); cli(); } while(0)
-
-extern void __global_cli(void);
-extern void __global_sti(void);
-extern unsigned long __global_save_flags(void);
-extern void __global_restore_flags(unsigned long flags);
-#define cli()			__global_cli()
-#define sti()			__global_sti()
-#define save_flags(flags)	((flags)=__global_save_flags())
-#define restore_flags(flags)	__global_restore_flags(flags)
-
-#else
-
-#define cli() local_irq_disable()
-#define sti() local_irq_enable()
-
-#endif
 
 /* XXX Change this if we ever use a PSO mode kernel. */
 #define mb()	__asm__ __volatile__ ("" : : : "memory")


-- 
Keith M Wesolowski
