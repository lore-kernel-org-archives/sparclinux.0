From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 28 Aug 2004 00:04:26 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <20040827170426.34525fc6.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 27 Aug 2004 17:01:01 -0700
Joshua Kwan <joshk@triplehelix.org> wrote:

> > -	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o
> > +	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o delay.o
> >  
> >  lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
> >  lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
> 
> You forgot delay.c.

Sorry, I'm a retard.

This patch should be better.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/27 16:12:23-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: Fix delay with HZ=1000.
#   
#   When I moved sparc64 over to HZ=1000 this added some
#   problems to the udelay() handling.  Specifically, with
#   slower cpus we could now get underflows to zero for
#   things like udelay(1) due to the order of multiplies
#   and shifts.
#   
#   Fix this, and move it out to arch/sparc64/lib/delay.c
#   so it is easier to tinker with this in the future and
#   also to optimize away one of the multiplies for the
#   constant delay case just like other platforms do.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# include/asm-sparc64/delay.h
#   2004/08/27 16:10:13-07:00 davem@nuts.davemloft.net +21 -46
#   [SPARC64]: Fix delay with HZ=1000.
# 
# arch/sparc64/lib/Makefile
#   2004/08/27 16:10:13-07:00 davem@nuts.davemloft.net +1 -1
#   [SPARC64]: Fix delay with HZ=1000.
# 
# arch/sparc64/kernel/sparc64_ksyms.c
#   2004/08/27 16:10:13-07:00 davem@nuts.davemloft.net +6 -0
#   [SPARC64]: Fix delay with HZ=1000.
# 
# arch/sparc64/lib/delay.c
#   2004/08/27 16:10:01-07:00 davem@nuts.davemloft.net +49 -0
#   [SPARC64]: Fix delay with HZ=1000.
# 
# arch/sparc64/lib/delay.c
#   2004/08/27 16:10:01-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/arch/sparc64/lib/delay.c
# 
diff -Nru a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
--- a/arch/sparc64/kernel/sparc64_ksyms.c	2004-08-27 16:48:00 -07:00
+++ b/arch/sparc64/kernel/sparc64_ksyms.c	2004-08-27 16:48:00 -07:00
@@ -372,6 +372,12 @@
 EXPORT_SYMBOL_NOVERS(memmove);
 EXPORT_SYMBOL_NOVERS(strncmp);
 
+/* Delay routines. */
+EXPORT_SYMBOL(__udelay);
+EXPORT_SYMBOL(__ndelay);
+EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__delay);
+
 void VISenter(void);
 /* RAID code needs this */
 EXPORT_SYMBOL_NOVERS(VISenter);
diff -Nru a/arch/sparc64/lib/Makefile b/arch/sparc64/lib/Makefile
--- a/arch/sparc64/lib/Makefile	2004-08-27 16:48:00 -07:00
+++ b/arch/sparc64/lib/Makefile	2004-08-27 16:48:00 -07:00
@@ -12,7 +12,7 @@
 	 U1memcpy.o U1copy_from_user.o U1copy_to_user.o \
 	 U3memcpy.o U3copy_from_user.o U3copy_to_user.o U3patch.o \
 	 copy_in_user.o user_fixup.o memmove.o \
-	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o
+	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o delay.o
 
 lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -Nru a/arch/sparc64/lib/delay.c b/arch/sparc64/lib/delay.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/sparc64/lib/delay.c	2004-08-27 16:48:00 -07:00
@@ -0,0 +1,49 @@
+/* delay.c: Delay loops for sparc64
+ *
+ * Copyright (C) 2004 David S. Miller <davem@redhat.com>
+ *
+ * Based heavily upon x86 variant which is:
+ *	Copyright (C) 1993 Linus Torvalds
+ *	Copyright (C) 1997 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+ */
+
+#include <linux/delay.h>
+
+void __delay(unsigned long loops)
+{
+	__asm__ __volatile__(
+"	b,pt	%%xcc, 1f\n"
+"	 cmp	%0, 0\n"
+"	.align	32\n"
+"1:\n"
+"	bne,pt	%%xcc, 1b\n"
+"	 subcc	%0, 1, %0\n"
+	: "=&r" (loops)
+	: "0" (loops)
+	: "cc");
+}
+
+/* We used to multiply by HZ after shifting down by 32 bits
+ * but that runs into problems for higher values of HZ and
+ * slow cpus.
+ */
+void __const_udelay(unsigned long n)
+{
+	n *= 4;
+
+	n *= (cpu_data(smp_processor_id()).udelay_val * (HZ/4));
+	n >>= 32;
+
+	__delay(n + 1);
+}
+
+void __udelay(unsigned long n)
+{
+	__const_udelay(n * 0x10c7UL);
+}
+
+
+void __ndelay(unsigned long n)
+{
+	__const_udelay(n * 0x5UL);
+}
diff -Nru a/include/asm-sparc64/delay.h b/include/asm-sparc64/delay.h
--- a/include/asm-sparc64/delay.h	2004-08-27 16:48:00 -07:00
+++ b/include/asm-sparc64/delay.h	2004-08-27 16:48:00 -07:00
@@ -1,7 +1,11 @@
-/* $Id: delay.h,v 1.13 2002/02/02 03:33:48 kanoj Exp $
- * delay.h: Linux delay routines on the V9.
+/* delay.h: Linux delay routines on sparc64.
  *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu).
+ * Copyright (C) 1996, 2004 David S. Miller (davem@davemloft.net).
+ *
+ * Based heavily upon x86 variant which is:
+ * Copyright (C) 1993 Linus Torvalds
+ *
+ * Delay routines calling functions in arch/sparc64/lib/delay.c
  */
 
 #ifndef __SPARC64_DELAY_H
@@ -13,50 +17,21 @@
 
 #ifndef __ASSEMBLY__
 
-static __inline__ void __delay(unsigned long loops)
-{
-	__asm__ __volatile__(
-"	b,pt	%%xcc, 1f\n"
-"	 cmp	%0, 0\n"
-"	.align	32\n"
-"1:\n"
-"	bne,pt	%%xcc, 1b\n"
-"	 subcc	%0, 1, %0\n"
-	: "=&r" (loops)
-	: "0" (loops)
-	: "cc");
-}
-
-static __inline__ void __udelay(unsigned long usecs, unsigned long lps)
-{
-	usecs *= 0x00000000000010c6UL;		/* 2**32 / 1000000 */
-
-	__asm__ __volatile__(
-"	mulx	%1, %2, %0\n"
-"	srlx	%0, 32, %0\n"
-	: "=r" (usecs)
-	: "r" (usecs), "r" (lps));
-
-	__delay(usecs * HZ);
-}
-
-extern __inline__ void __ndelay(unsigned long usecs, unsigned long lps)
-{
-	usecs *= 0x0000000000000005UL;		/* 2**32 / 10000 */
-
-	__asm__ __volatile__(
-"	mulx	%1, %2, %0\n"
-"	srlx	%0, 32, %0\n"
-	: "=r" (usecs)
-	: "r" (usecs), "r" (lps));
-
-	__delay(usecs * HZ);
-}
-
-#define __udelay_val cpu_data(smp_processor_id()).udelay_val
+extern void __bad_udelay(void);
+extern void __bad_ndelay(void);
 
-#define udelay(usecs) __udelay((usecs),__udelay_val)
-#define ndelay(usecs) __ndelay((usecs),__udelay_val)
+extern void __udelay(unsigned long usecs);
+extern void __ndelay(unsigned long nsecs);
+extern void __const_udelay(unsigned long usecs);
+extern void __delay(unsigned long loops);
+
+#define udelay(n) (__builtin_constant_p(n) ? \
+	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
+	__udelay(n))
+	
+#define ndelay(n) (__builtin_constant_p(n) ? \
+	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+	__ndelay(n))
 
 #endif /* !__ASSEMBLY__ */
 
