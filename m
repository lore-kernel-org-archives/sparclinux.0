From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 13 Feb 2004 05:20:29 +0000
Subject: RFC: [sparc32] atomic_t is 32 bits
Message-Id: <20040213052029.GD22176@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch steals the atomic_t implementation from parisc.  I've also
left the existing implementation in as atomic24, primarily because
it's tightly woven into the semaphores.

Comments?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1634  -> 1.1635 
#	include/asm-mips/atomic.h	1.6     -> 1.7    
#	arch/sparc/kernel/sparc_ksyms.c	1.23    -> 1.24   
#	include/asm-i386/atomic.h	1.5     -> 1.6    
#	arch/sparc/kernel/smp.c	1.10    -> 1.11   
#	arch/sparc/lib/atomic.S	1.2     -> 1.3    
#	include/asm-sparc/atomic.h	1.6     -> 1.7    
#	include/asm-generic/local.h	1.1     -> 1.2    
#	arch/sparc/kernel/semaphore.c	1.5     -> 1.6    
#	include/asm-x86_64/atomic.h	1.2     -> 1.3    
#	include/asm-sparc/semaphore.h	1.5     -> 1.6    
#	include/asm-sparc/processor.h	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/12	wesolows@foobazco.org	1.1635
# atomic_t is now 32 bits
# --------------------------------------------
#
diff -Nru a/arch/sparc/kernel/semaphore.c b/arch/sparc/kernel/semaphore.c
--- a/arch/sparc/kernel/semaphore.c	Thu Feb 12 21:10:58 2004
+++ b/arch/sparc/kernel/semaphore.c	Thu Feb 12 21:10:58 2004
@@ -61,7 +61,7 @@
 		 * Add "everybody else" into it. They aren't
 		 * playing, because we own the spinlock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic24_add_negative(sleepers - 1, &sem->count)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -101,7 +101,7 @@
 		if (signal_pending(current)) {
 			retval = -EINTR;
 			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
+			atomic24_add(sleepers, &sem->count);
 			break;
 		}
 
@@ -111,7 +111,7 @@
 		 * "-1" is because we're still hoping to get
 		 * the lock.
 		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		if (!atomic24_add_negative(sleepers - 1, &sem->count)) {
 			sem->sleepers = 0;
 			break;
 		}
@@ -146,7 +146,7 @@
 	 * Add "everybody else" and us into it. They aren't
 	 * playing, because we own the spinlock.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count))
+	if (!atomic24_add_negative(sleepers, &sem->count))
 		wake_up(&sem->wait);
 
 	spin_unlock_irqrestore(&semaphore_lock, flags);
diff -Nru a/arch/sparc/kernel/smp.c b/arch/sparc/kernel/smp.c
--- a/arch/sparc/kernel/smp.c	Thu Feb 12 21:10:58 2004
+++ b/arch/sparc/kernel/smp.c	Thu Feb 12 21:10:58 2004
@@ -56,6 +56,9 @@
 volatile int __cpu_number_map[NR_CPUS];
 volatile int __cpu_logical_map[NR_CPUS];
 cycles_t cacheflush_time = 0; /* XXX */
+spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
+	[0 ... (ATOMIC_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
+};
 
 /* The only guaranteed locking primitive available on all Sparc
  * processors is 'ldstub [%reg + immediate], %dest_reg' which atomically
diff -Nru a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
--- a/arch/sparc/kernel/sparc_ksyms.c	Thu Feb 12 21:10:58 2004
+++ b/arch/sparc/kernel/sparc_ksyms.c	Thu Feb 12 21:10:58 2004
@@ -86,8 +86,8 @@
 extern void dump_thread(struct pt_regs *, struct user *);
 
 /* Private functions with odd calling conventions. */
-extern void ___atomic_add(void);
-extern void ___atomic_sub(void);
+extern void ___atomic24_add(void);
+extern void ___atomic24_sub(void);
 extern void ___set_bit(void);
 extern void ___clear_bit(void);
 extern void ___change_bit(void);
@@ -147,8 +147,8 @@
 EXPORT_SYMBOL(phys_base);
 
 /* Atomic operations. */
-EXPORT_SYMBOL(___atomic_add);
-EXPORT_SYMBOL(___atomic_sub);
+EXPORT_SYMBOL(___atomic24_add);
+EXPORT_SYMBOL(___atomic24_sub);
 
 /* Bit operations. */
 EXPORT_SYMBOL(___set_bit);
diff -Nru a/arch/sparc/lib/atomic.S b/arch/sparc/lib/atomic.S
--- a/arch/sparc/lib/atomic.S	Thu Feb 12 21:10:58 2004
+++ b/arch/sparc/lib/atomic.S	Thu Feb 12 21:10:58 2004
@@ -44,8 +44,8 @@
 	/* Read asm-sparc/atomic.h carefully to understand how this works for SMP.
 	 * Really, some things here for SMP are overly clever, go read the header.
 	 */
-	.globl	___atomic_add
-___atomic_add:
+	.globl	___atomic24_add
+___atomic24_add:
 	rd	%psr, %g3		! Keep the code small, old way was stupid
 	nop; nop; nop;			! Let the bits set
 	or	%g3, PSR_PIL, %g7	! Disable interrupts
@@ -55,13 +55,13 @@
 1:	ldstub	[%g1 + 3], %g7		! Spin on the byte lock for SMP.
 	orcc	%g7, 0x0, %g0		! Did we get it?
 	bne	1b			! Nope...
-	 ld	[%g1], %g7		! Load locked atomic_t
+	 ld	[%g1], %g7		! Load locked atomic24_t
 	sra	%g7, 8, %g7		! Get signed 24-bit integer
 	add	%g7, %g2, %g2		! Add in argument
-	sll	%g2, 8, %g7		! Transpose back to atomic_t
+	sll	%g2, 8, %g7		! Transpose back to atomic24_t
 	st	%g7, [%g1]		! Clever: This releases the lock as well.
 #else
-	ld	[%g1], %g7		! Load locked atomic_t
+	ld	[%g1], %g7		! Load locked atomic24_t
 	add	%g7, %g2, %g2		! Add in argument
 	st	%g2, [%g1]		! Store it back
 #endif
@@ -70,8 +70,8 @@
 	jmpl	%o7, %g0		! NOTE: not + 8, see callers in atomic.h
 	 mov	%g4, %o7		! Restore %o7
 
-	.globl	___atomic_sub
-___atomic_sub:
+	.globl	___atomic24_sub
+___atomic24_sub:
 	rd	%psr, %g3		! Keep the code small, old way was stupid
 	nop; nop; nop;			! Let the bits set
 	or	%g3, PSR_PIL, %g7	! Disable interrupts
@@ -81,13 +81,13 @@
 1:	ldstub	[%g1 + 3], %g7		! Spin on the byte lock for SMP.
 	orcc	%g7, 0x0, %g0		! Did we get it?
 	bne	1b			! Nope...
-	 ld	[%g1], %g7		! Load locked atomic_t
+	 ld	[%g1], %g7		! Load locked atomic24_t
 	sra	%g7, 8, %g7		! Get signed 24-bit integer
 	sub	%g7, %g2, %g2		! Subtract argument
-	sll	%g2, 8, %g7		! Transpose back to atomic_t
+	sll	%g2, 8, %g7		! Transpose back to atomic24_t
 	st	%g7, [%g1]		! Clever: This releases the lock as well
 #else
-	ld	[%g1], %g7		! Load locked atomic_t
+	ld	[%g1], %g7		! Load locked atomic24_t
 	sub	%g7, %g2, %g2		! Subtract argument
 	st	%g2, [%g1]		! Store it back
 #endif
diff -Nru a/include/asm-generic/local.h b/include/asm-generic/local.h
--- a/include/asm-generic/local.h	Thu Feb 12 21:10:58 2004
+++ b/include/asm-generic/local.h	Thu Feb 12 21:10:58 2004
@@ -9,7 +9,7 @@
 /* An unsigned long type for operations which are atomic for a single
  * CPU.  Usually used in combination with per-cpu variables. */
 
-#if BITS_PER_LONG = 32 && !defined(CONFIG_SPARC32)
+#if BITS_PER_LONG = 32
 /* Implement in terms of atomics. */
 
 /* Don't use typedef: don't want them to be mixed with atomic_t's. */
diff -Nru a/include/asm-i386/atomic.h b/include/asm-i386/atomic.h
--- a/include/asm-i386/atomic.h	Thu Feb 12 21:10:58 2004
+++ b/include/asm-i386/atomic.h	Thu Feb 12 21:10:58 2004
@@ -27,8 +27,7 @@
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
  * 
- * Atomically reads the value of @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically reads the value of @v.
  */ 
 #define atomic_read(v)		((v)->counter)
 
@@ -37,8 +36,7 @@
  * @v: pointer of type atomic_t
  * @i: required value
  * 
- * Atomically sets the value of @v to @i.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically sets the value of @v to @i.
  */ 
 #define atomic_set(v,i)		(((v)->counter) = (i))
 
@@ -47,8 +45,7 @@
  * @i: integer value to add
  * @v: pointer of type atomic_t
  * 
- * Atomically adds @i to @v.  Note that the guaranteed useful range
- * of an atomic_t is only 24 bits.
+ * Atomically adds @i to @v.
  */
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
@@ -63,8 +60,7 @@
  * @i: integer value to subtract
  * @v: pointer of type atomic_t
  * 
- * Atomically subtracts @i from @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically subtracts @i from @v.
  */
 static __inline__ void atomic_sub(int i, atomic_t *v)
 {
@@ -81,8 +77,7 @@
  * 
  * Atomically subtracts @i from @v and returns
  * true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * other cases.
  */
 static __inline__ int atomic_sub_and_test(int i, atomic_t *v)
 {
@@ -99,8 +94,7 @@
  * atomic_inc - increment atomic variable
  * @v: pointer of type atomic_t
  * 
- * Atomically increments @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically increments @v by 1.
  */ 
 static __inline__ void atomic_inc(atomic_t *v)
 {
@@ -114,8 +108,7 @@
  * atomic_dec - decrement atomic variable
  * @v: pointer of type atomic_t
  * 
- * Atomically decrements @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically decrements @v by 1.
  */ 
 static __inline__ void atomic_dec(atomic_t *v)
 {
@@ -131,8 +124,7 @@
  * 
  * Atomically decrements @v by 1 and
  * returns true if the result is 0, or false for all other
- * cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * cases.
  */ 
 static __inline__ int atomic_dec_and_test(atomic_t *v)
 {
@@ -151,8 +143,7 @@
  * 
  * Atomically increments @v by 1
  * and returns true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * other cases.
  */ 
 static __inline__ int atomic_inc_and_test(atomic_t *v)
 {
@@ -172,8 +163,7 @@
  * 
  * Atomically adds @i to @v and returns true
  * if the result is negative, or false when
- * result is greater than or equal to zero.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * result is greater than or equal to zero.
  */ 
 static __inline__ int atomic_add_negative(int i, atomic_t *v)
 {
diff -Nru a/include/asm-mips/atomic.h b/include/asm-mips/atomic.h
--- a/include/asm-mips/atomic.h	Thu Feb 12 21:10:58 2004
+++ b/include/asm-mips/atomic.h	Thu Feb 12 21:10:58 2004
@@ -29,8 +29,7 @@
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
  *
- * Atomically reads the value of @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically reads the value of @v.
  */
 #define atomic_read(v)		((v)->counter)
 
@@ -46,8 +45,7 @@
  * @v: pointer of type atomic_t
  * @i: required value
  *
- * Atomically sets the value of @v to @i.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically sets the value of @v to @i.
  */
 #define atomic_set(v,i)		((v)->counter = (i))
 
@@ -68,8 +66,7 @@
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically adds @i to @v.  Note that the guaranteed useful range
- * of an atomic_t is only 24 bits.
+ * Atomically adds @i to @v.
  */
 static __inline__ void atomic_add(int i, atomic_t * v)
 {
@@ -85,8 +82,7 @@
  * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
- * Atomically subtracts @i from @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically subtracts @i from @v.
  */
 static __inline__ void atomic_sub(int i, atomic_t * v)
 {
@@ -137,8 +133,7 @@
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically adds @i to @v.  Note that the guaranteed useful range
- * of an atomic_t is only 24 bits.
+ * Atomically adds @i to @v.
  */
 static __inline__ void atomic_add(int i, atomic_t * v)
 {
@@ -158,8 +153,7 @@
  * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
- * Atomically subtracts @i from @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically subtracts @i from @v.
  */
 static __inline__ void atomic_sub(int i, atomic_t * v)
 {
@@ -390,8 +384,7 @@
  *
  * Atomically subtracts @i from @v and returns
  * true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * other cases.
  */
 #define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) = 0)
 
@@ -412,8 +405,7 @@
  *
  * Atomically increments @v by 1
  * and returns true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * other cases.
  */
 #define atomic_inc_and_test(v) (atomic_inc_return(v) = 0)
 
@@ -433,8 +425,7 @@
  *
  * Atomically decrements @v by 1 and
  * returns true if the result is 0, or false for all other
- * cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * cases.
  */
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) = 0)
 
@@ -452,8 +443,7 @@
  * atomic_inc - increment atomic variable
  * @v: pointer of type atomic_t
  *
- * Atomically increments @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically increments @v by 1.
  */
 #define atomic_inc(v) atomic_add(1,(v))
 
@@ -469,8 +459,7 @@
  * atomic_dec - decrement and test
  * @v: pointer of type atomic_t
  *
- * Atomically decrements @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically decrements @v by 1.
  */
 #define atomic_dec(v) atomic_sub(1,(v))
 
@@ -489,8 +478,7 @@
  *
  * Atomically adds @i to @v and returns true
  * if the result is negative, or false when
- * result is greater than or equal to zero.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * result is greater than or equal to zero.
  */
 #define atomic_add_negative(i,v) (atomic_add_return(i, (v)) < 0)
 
diff -Nru a/include/asm-sparc/atomic.h b/include/asm-sparc/atomic.h
--- a/include/asm-sparc/atomic.h	Thu Feb 12 21:10:58 2004
+++ b/include/asm-sparc/atomic.h	Thu Feb 12 21:10:58 2004
@@ -2,21 +2,82 @@
  *
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  * Copyright (C) 2000 Anton Blanchard (anton@linuxcare.com.au)
+ *
+ * Additions by Keith M Wesolowski (wesolows@foobazco.org) based
+ * on asm-parisc/atomic.h Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.
  */
 
 #ifndef __ARCH_SPARC_ATOMIC__
 #define __ARCH_SPARC_ATOMIC__
 
 #include <linux/config.h>
+#include <linux/spinlock.h>
 
 typedef struct { volatile int counter; } atomic_t;
 
 #ifdef __KERNEL__
-#ifndef CONFIG_SMP
+
+#ifdef CONFIG_SMP
+
+#define ATOMIC_HASH_SIZE	4
+#define ATOMIC_HASH(a)	(&__atomic_hash[(((unsigned long)a)>>8) & (ATOMIC_HASH_SIZE-1)])
+extern spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];
+
+#else /* SMP */
+
+#define ATOMIC_HASH_SIZE	1
+#define ATOMIC_HASH(a)		0
+
+#endif /* SMP */
+
+static inline int __atomic_add_return(int i, atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);
+
+	ret = (v->counter += i);
+
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
+	return ret;
+}
+
+static inline void atomic_set(atomic_t *v, int i)
+{
+	unsigned long flags;
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);
+
+	v->counter = i;
+
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
+}
 
 #define ATOMIC_INIT(i)  { (i) }
+
 #define atomic_read(v)          ((v)->counter)
-#define atomic_set(v, i)        (((v)->counter) = i)
+
+#define atomic_add(i, v)	((void)__atomic_add_return( (int)(i), (v)))
+#define atomic_sub(i, v)	((void)__atomic_add_return(-(int)(i), (v)))
+#define atomic_inc(v)		((void)__atomic_add_return(        1, (v)))
+#define atomic_dec(v)		((void)__atomic_add_return(       -1, (v)))
+
+#define atomic_add_return(i, v)	(__atomic_add_return( (int)(i), (v)))
+#define atomic_sub_return(i, v)	(__atomic_add_return(-(int)(i), (v)))
+#define atomic_inc_return(v)	(__atomic_add_return(        1, (v)))
+#define atomic_dec_return(v)	(__atomic_add_return(       -1, (v)))
+
+#define atomic_dec_and_test(v) (atomic_dec_return(v) = 0)
+
+/* This is the old 24-bit implementation.  It's still used internally
+ * by some sparc-specific code, notably the semaphore implementation.
+ */
+typedef struct { volatile int counter; } atomic24_t;
+
+#ifndef CONFIG_SMP
+
+#define ATOMIC24_INIT(i)  { (i) }
+#define atomic24_read(v)          ((v)->counter)
+#define atomic24_set(v, i)        (((v)->counter) = i)
 
 #else
 /* We do the bulk of the actual work out of line in two common
@@ -33,9 +94,9 @@
  *	 31                          8 7      0
  */
 
-#define ATOMIC_INIT(i)	{ ((i) << 8) }
+#define ATOMIC24_INIT(i)	{ ((i) << 8) }
 
-static __inline__ int atomic_read(const atomic_t *v)
+static inline int atomic24_read(const atomic24_t *v)
 {
 	int ret = v->counter;
 
@@ -45,10 +106,10 @@
 	return ret >> 8;
 }
 
-#define atomic_set(v, i)	(((v)->counter) = ((i) << 8))
+#define atomic24_set(v, i)	(((v)->counter) = ((i) << 8))
 #endif
 
-static inline int __atomic_add(int i, atomic_t *v)
+static inline int __atomic24_add(int i, atomic24_t *v)
 {
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
@@ -61,7 +122,7 @@
 
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
-	"call	___atomic_add\n\t"
+	"call	___atomic24_add\n\t"
 	" add	%%o7, 8, %%o7\n"
 	: "=&r" (increment), "=r" (tmp1), "=r" (tmp2), "=r" (tmp3)
 	: "0" (increment), "r" (ptr)
@@ -70,7 +131,7 @@
 	return increment;
 }
 
-static inline int __atomic_sub(int i, atomic_t *v)
+static inline int __atomic24_sub(int i, atomic24_t *v)
 {
 	register volatile int *ptr asm("g1");
 	register int increment asm("g2");
@@ -83,7 +144,7 @@
 
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
-	"call	___atomic_sub\n\t"
+	"call	___atomic24_sub\n\t"
 	" add	%%o7, 8, %%o7\n"
 	: "=&r" (increment), "=r" (tmp1), "=r" (tmp2), "=r" (tmp3)
 	: "0" (increment), "r" (ptr)
@@ -92,19 +153,19 @@
 	return increment;
 }
 
-#define atomic_add(i, v) ((void)__atomic_add((i), (v)))
-#define atomic_sub(i, v) ((void)__atomic_sub((i), (v)))
+#define atomic24_add(i, v) ((void)__atomic24_add((i), (v)))
+#define atomic24_sub(i, v) ((void)__atomic24_sub((i), (v)))
 
-#define atomic_dec_return(v) __atomic_sub(1, (v))
-#define atomic_inc_return(v) __atomic_add(1, (v))
+#define atomic24_dec_return(v) __atomic24_sub(1, (v))
+#define atomic24_inc_return(v) __atomic24_add(1, (v))
 
-#define atomic_sub_and_test(i, v) (__atomic_sub((i), (v)) = 0)
-#define atomic_dec_and_test(v) (__atomic_sub(1, (v)) = 0)
+#define atomic24_sub_and_test(i, v) (__atomic24_sub((i), (v)) = 0)
+#define atomic24_dec_and_test(v) (__atomic24_sub(1, (v)) = 0)
 
-#define atomic_inc(v) ((void)__atomic_add(1, (v)))
-#define atomic_dec(v) ((void)__atomic_sub(1, (v)))
+#define atomic24_inc(v) ((void)__atomic24_add(1, (v)))
+#define atomic24_dec(v) ((void)__atomic24_sub(1, (v)))
 
-#define atomic_add_negative(i, v) (__atomic_add((i), (v)) < 0)
+#define atomic24_add_negative(i, v) (__atomic24_add((i), (v)) < 0)
 
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
diff -Nru a/include/asm-sparc/processor.h b/include/asm-sparc/processor.h
--- a/include/asm-sparc/processor.h	Thu Feb 12 21:10:58 2004
+++ b/include/asm-sparc/processor.h	Thu Feb 12 21:10:58 2004
@@ -22,7 +22,6 @@
 #include <asm/segment.h>
 #include <asm/btfixup.h>
 #include <asm/page.h>
-#include <asm/atomic.h>
 
 /*
  * Bus types
diff -Nru a/include/asm-sparc/semaphore.h b/include/asm-sparc/semaphore.h
--- a/include/asm-sparc/semaphore.h	Thu Feb 12 21:10:58 2004
+++ b/include/asm-sparc/semaphore.h	Thu Feb 12 21:10:58 2004
@@ -10,7 +10,7 @@
 #include <linux/rwsem.h>
 
 struct semaphore {
-	atomic_t count;
+	atomic24_t count;
 	int sleepers;
 	wait_queue_head_t wait;
 #if WAITQUEUE_DEBUG
@@ -40,7 +40,7 @@
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-	atomic_set(&sem->count, val);
+	atomic24_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
 #if WAITQUEUE_DEBUG
@@ -78,7 +78,7 @@
 
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
-	"call	___atomic_sub\n\t"
+	"call	___atomic24_sub\n\t"
 	" add	%%o7, 8, %%o7\n\t"
 	"tst	%%g2\n\t"
 	"bl	2f\n\t"
@@ -115,7 +115,7 @@
 
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
-	"call	___atomic_sub\n\t"
+	"call	___atomic24_sub\n\t"
 	" add	%%o7, 8, %%o7\n\t"
 	"tst	%%g2\n\t"
 	"bl	2f\n\t"
@@ -154,7 +154,7 @@
 
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
-	"call	___atomic_sub\n\t"
+	"call	___atomic24_sub\n\t"
 	" add	%%o7, 8, %%o7\n\t"
 	"tst	%%g2\n\t"
 	"bl	2f\n\t"
@@ -193,7 +193,7 @@
 
 	__asm__ __volatile__(
 	"mov	%%o7, %%g4\n\t"
-	"call	___atomic_add\n\t"
+	"call	___atomic24_add\n\t"
 	" add	%%o7, 8, %%o7\n\t"
 	"tst	%%g2\n\t"
 	"ble	2f\n\t"
diff -Nru a/include/asm-x86_64/atomic.h b/include/asm-x86_64/atomic.h
--- a/include/asm-x86_64/atomic.h	Thu Feb 12 21:10:58 2004
+++ b/include/asm-x86_64/atomic.h	Thu Feb 12 21:10:58 2004
@@ -29,8 +29,7 @@
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
  * 
- * Atomically reads the value of @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically reads the value of @v.
  */ 
 #define atomic_read(v)		((v)->counter)
 
@@ -39,8 +38,7 @@
  * @v: pointer of type atomic_t
  * @i: required value
  * 
- * Atomically sets the value of @v to @i.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically sets the value of @v to @i.
  */ 
 #define atomic_set(v,i)		(((v)->counter) = (i))
 
@@ -49,8 +47,7 @@
  * @i: integer value to add
  * @v: pointer of type atomic_t
  * 
- * Atomically adds @i to @v.  Note that the guaranteed useful range
- * of an atomic_t is only 24 bits.
+ * Atomically adds @i to @v.
  */
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
@@ -65,8 +62,7 @@
  * @i: integer value to subtract
  * @v: pointer of type atomic_t
  * 
- * Atomically subtracts @i from @v.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically subtracts @i from @v.
  */
 static __inline__ void atomic_sub(int i, atomic_t *v)
 {
@@ -83,8 +79,7 @@
  * 
  * Atomically subtracts @i from @v and returns
  * true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * other cases.
  */
 static __inline__ int atomic_sub_and_test(int i, atomic_t *v)
 {
@@ -101,8 +96,7 @@
  * atomic_inc - increment atomic variable
  * @v: pointer of type atomic_t
  * 
- * Atomically increments @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically increments @v by 1.
  */ 
 static __inline__ void atomic_inc(atomic_t *v)
 {
@@ -116,8 +110,7 @@
  * atomic_dec - decrement atomic variable
  * @v: pointer of type atomic_t
  * 
- * Atomically decrements @v by 1.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * Atomically decrements @v by 1.
  */ 
 static __inline__ void atomic_dec(atomic_t *v)
 {
@@ -133,8 +126,7 @@
  * 
  * Atomically decrements @v by 1 and
  * returns true if the result is 0, or false for all other
- * cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * cases.
  */ 
 static __inline__ int atomic_dec_and_test(atomic_t *v)
 {
@@ -153,8 +145,7 @@
  * 
  * Atomically increments @v by 1
  * and returns true if the result is zero, or false for all
- * other cases.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * other cases.
  */ 
 static __inline__ int atomic_inc_and_test(atomic_t *v)
 {
@@ -174,8 +165,7 @@
  * 
  * Atomically adds @i to @v and returns true
  * if the result is negative, or false when
- * result is greater than or equal to zero.  Note that the guaranteed
- * useful range of an atomic_t is only 24 bits.
+ * result is greater than or equal to zero.
  */ 
 static __inline__ int atomic_add_negative(int i, atomic_t *v)
 {


-- 
Keith M Wesolowski
