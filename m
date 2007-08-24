From: Robert Reif <reif@earthlink.net>
Date: Fri, 24 Aug 2007 23:56:30 +0000
Subject: [PATCH] Add irqflags.h to sparc32 and use it from generic code.
Message-Id: <46CF702E.9050907@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030207000707010100030306"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------030207000707010100030306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added asm-sparc/irqflags.h and moved irq related code from system.h to it.
Renamed local_irq functions to raw_local_irq in irq.c.
Modified system.h to include linux/irqflags.h which includes asm/irqflags.h.
Added TRACE_IRQFLAGS_SUPPORT to Kconfig.debug.

This is the first step in adding IRQ-flags state tracing as outlined in
Documentation/irqflags-tracing.txt.  These changes should be harmless
because they just move things around and rename them.

The next step is making the lowlevel entry code modifications which
to be honest are beyond my capabilities at this point.

Boot tested on an ss20 running an SMP kernel.

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------030207000707010100030306
Content-Type: text/plain;
 name="irqflags.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irqflags.diff.txt"

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 120f6b5..87dd496 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -1,5 +1,9 @@
 menu "Kernel hacking"
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 config DEBUG_STACK_USAGE
diff --git a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
index b76dc03..722d67d 100644
--- a/arch/sparc/kernel/irq.c
+++ b/arch/sparc/kernel/irq.c
@@ -56,7 +56,7 @@
 #define SMP_NOP2
 #define SMP_NOP3
 #endif /* SMP */
-unsigned long __local_irq_save(void)
+unsigned long __raw_local_irq_save(void)
 {
 	unsigned long retval;
 	unsigned long tmp;
@@ -74,7 +74,7 @@ unsigned long __local_irq_save(void)
 	return retval;
 }
 
-void local_irq_enable(void)
+void raw_local_irq_enable(void)
 {
 	unsigned long tmp;
 
@@ -89,7 +89,7 @@ void local_irq_enable(void)
 		: "memory");
 }
 
-void local_irq_restore(unsigned long old_psr)
+void raw_local_irq_restore(unsigned long old_psr)
 {
 	unsigned long tmp;
 
@@ -105,9 +105,9 @@ void local_irq_restore(unsigned long old_psr)
 		: "memory");
 }
 
-EXPORT_SYMBOL(__local_irq_save);
-EXPORT_SYMBOL(local_irq_enable);
-EXPORT_SYMBOL(local_irq_restore);
+EXPORT_SYMBOL(__raw_local_irq_save);
+EXPORT_SYMBOL(raw_local_irq_enable);
+EXPORT_SYMBOL(raw_local_irq_restore);
 
 /*
  * Dave Redman (djhr@tadpole.co.uk)
diff --git a/include/asm-sparc/system.h b/include/asm-sparc/system.h
index d1a2572..8c259de 100644
--- a/include/asm-sparc/system.h
+++ b/include/asm-sparc/system.h
@@ -15,6 +15,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/irqflags.h>
+
 /*
  * Sparc (general) CPU types
  */
@@ -164,26 +166,6 @@ extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
 	  "o0", "o1", "o2", "o3",                   "o7");	\
 	} while(0)
 
-/*
- * Changing the IRQ level on the Sparc.
- */
-extern void local_irq_restore(unsigned long);
-extern unsigned long __local_irq_save(void);
-extern void local_irq_enable(void);
-
-static inline unsigned long getipl(void)
-{
-	unsigned long retval;
-
-	__asm__ __volatile__("rd	%%psr, %0" : "=r" (retval));
-	return retval;
-}
-
-#define local_save_flags(flags)	((flags) = getipl())
-#define local_irq_save(flags)	((flags) = __local_irq_save())
-#define local_irq_disable()	((void) __local_irq_save())
-#define irqs_disabled()		((getipl() & PSR_PIL) != 0)
-
 /* XXX Change this if we ever use a PSO mode kernel. */
 #define mb()	__asm__ __volatile__ ("" : : : "memory")
 #define rmb()	mb()
diff --git a/include/asm-sparc/irqflags.h b/include/asm-sparc/irqflags.h
new file mode 100644
index 0000000..a48109a
--- /dev/null
+++ b/include/asm-sparc/irqflags.h
@@ -0,0 +1,39 @@
+/*
+ * include/asm-sparc/irqflags.h
+ *
+ * IRQ flags handling
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() functions from the lowlevel headers.
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+#ifndef __ASSEMBLY__
+
+extern void raw_local_irq_restore(unsigned long);
+extern unsigned long __raw_local_irq_save(void);
+extern void raw_local_irq_enable(void);
+                                                                                
+static inline unsigned long getipl(void)
+{
+        unsigned long retval;
+                                                                                
+        __asm__ __volatile__("rd        %%psr, %0" : "=r" (retval));
+        return retval;
+}
+                                                                                
+#define raw_local_save_flags(flags) ((flags) = getipl())
+#define raw_local_irq_save(flags)   ((flags) = __raw_local_irq_save())
+#define raw_local_irq_disable()     ((void) __raw_local_irq_save())
+#define raw_irqs_disabled()         ((getipl() & PSR_PIL) != 0)
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+        return ((flags & PSR_PIL) != 0);
+}
+
+#endif /* (__ASSEMBLY__) */
+
+#endif /* !(_ASM_IRQFLAGS_H) */

--------------030207000707010100030306--

