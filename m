From: "David S. Miller" <davem@redhat.com>
Date: Fri, 27 Aug 2004 23:24:49 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <20040827162449.1b25a6e5.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Delete that SunSAB hack fix, and try this, it is the real bug.

The clue was when Ralph mentioned that 2.6.7-rc1 to rc2 broke
things, and that is when I moved HZ to be 1000 instead of 100
on sparc64.

This mucked up udelay() handling for slower cpu speeds.

Please, when you test this, make absolutely sure you undid the
sunsab.c fixes.  Specifically the first line of the function
sunsab_tec_wait() should read:

	int timeout = up->tec_timeout;

Let me know how it goes.

=== arch/sparc64/kernel/sparc64_ksyms.c 1.80 vs edited ==--- 1.80/arch/sparc64/kernel/sparc64_ksyms.c	2004-08-23 14:36:04 -07:00
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	2004-08-27 15:41:51 -07:00
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
=== arch/sparc64/lib/Makefile 1.19 vs edited ==--- 1.19/arch/sparc64/lib/Makefile	2004-08-23 14:33:04 -07:00
+++ edited/arch/sparc64/lib/Makefile	2004-08-27 15:25:45 -07:00
@@ -12,7 +12,7 @@
 	 U1memcpy.o U1copy_from_user.o U1copy_to_user.o \
 	 U3memcpy.o U3copy_from_user.o U3copy_to_user.o U3patch.o \
 	 copy_in_user.o user_fixup.o memmove.o \
-	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o
+	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o delay.o
 
 lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
=== include/asm-sparc64/delay.h 1.8 vs edited ==--- 1.8/include/asm-sparc64/delay.h	2003-09-12 20:59:46 -07:00
+++ edited/include/asm-sparc64/delay.h	2004-08-27 15:43:12 -07:00
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
 
