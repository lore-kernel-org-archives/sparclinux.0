From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 26 Dec 2011 22:29:16 +0000
Subject: [PATCH 1/2] sparc32: drop unused atomic24 support
Message-Id: <20111226222916.GA20839@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From b3c4924ae2b3bc1a63a297e30822bdd7667986f9 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 26 Dec 2011 20:57:22 +0100
Subject: [PATCH 1/2] sparc32: drop unused atomic24 support

atomic24 support was used to semaphores in the past - but is no longer used.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/atomic_32.h |  100 ------------------------------------
 arch/sparc/lib/atomic_32.S         |   55 --------------------
 arch/sparc/lib/ksyms.c             |    6 --
 3 files changed, 0 insertions(+), 161 deletions(-)

diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 5c3c8b6..534832f 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -52,106 +52,6 @@ extern void atomic_set(atomic_t *, int);
 #define atomic_dec_and_test(v) (atomic_dec_return(v) = 0)
 #define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) = 0)
 
-
-/* This is the old 24-bit implementation.  It's still used internally
- * by some sparc-specific code, notably the semaphore implementation.
- */
-typedef struct { volatile int counter; } atomic24_t;
-
-#ifndef CONFIG_SMP
-
-#define ATOMIC24_INIT(i)  { (i) }
-#define atomic24_read(v)          ((v)->counter)
-#define atomic24_set(v, i)        (((v)->counter) = i)
-
-#else
-/* We do the bulk of the actual work out of line in two common
- * routines in assembler, see arch/sparc/lib/atomic.S for the
- * "fun" details.
- *
- * For SMP the trick is you embed the spin lock byte within
- * the word, use the low byte so signedness is easily retained
- * via a quick arithmetic shift.  It looks like this:
- *
- *	----------------------------------------
- *	| signed 24-bit counter value |  lock  |  atomic_t
- *	----------------------------------------
- *	 31                          8 7      0
- */
-
-#define ATOMIC24_INIT(i)	{ ((i) << 8) }
-
-static inline int atomic24_read(const atomic24_t *v)
-{
-	int ret = v->counter;
-
-	while(ret & 0xff)
-		ret = v->counter;
-
-	return ret >> 8;
-}
-
-#define atomic24_set(v, i)	(((v)->counter) = ((i) << 8))
-#endif
-
-static inline int __atomic24_add(int i, atomic24_t *v)
-{
-	register volatile int *ptr asm("g1");
-	register int increment asm("g2");
-	register int tmp1 asm("g3");
-	register int tmp2 asm("g4");
-	register int tmp3 asm("g7");
-
-	ptr = &v->counter;
-	increment = i;
-
-	__asm__ __volatile__(
-	"mov	%%o7, %%g4\n\t"
-	"call	___atomic24_add\n\t"
-	" add	%%o7, 8, %%o7\n"
-	: "=&r" (increment), "=r" (tmp1), "=r" (tmp2), "=r" (tmp3)
-	: "0" (increment), "r" (ptr)
-	: "memory", "cc");
-
-	return increment;
-}
-
-static inline int __atomic24_sub(int i, atomic24_t *v)
-{
-	register volatile int *ptr asm("g1");
-	register int increment asm("g2");
-	register int tmp1 asm("g3");
-	register int tmp2 asm("g4");
-	register int tmp3 asm("g7");
-
-	ptr = &v->counter;
-	increment = i;
-
-	__asm__ __volatile__(
-	"mov	%%o7, %%g4\n\t"
-	"call	___atomic24_sub\n\t"
-	" add	%%o7, 8, %%o7\n"
-	: "=&r" (increment), "=r" (tmp1), "=r" (tmp2), "=r" (tmp3)
-	: "0" (increment), "r" (ptr)
-	: "memory", "cc");
-
-	return increment;
-}
-
-#define atomic24_add(i, v) ((void)__atomic24_add((i), (v)))
-#define atomic24_sub(i, v) ((void)__atomic24_sub((i), (v)))
-
-#define atomic24_dec_return(v) __atomic24_sub(1, (v))
-#define atomic24_inc_return(v) __atomic24_add(1, (v))
-
-#define atomic24_sub_and_test(i, v) (__atomic24_sub((i), (v)) = 0)
-#define atomic24_dec_and_test(v) (__atomic24_sub(1, (v)) = 0)
-
-#define atomic24_inc(v) ((void)__atomic24_add(1, (v)))
-#define atomic24_dec(v) ((void)__atomic24_sub(1, (v)))
-
-#define atomic24_add_negative(i, v) (__atomic24_add((i), (v)) < 0)
-
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
diff --git a/arch/sparc/lib/atomic_32.S b/arch/sparc/lib/atomic_32.S
index 178cbb8..eb6c735 100644
--- a/arch/sparc/lib/atomic_32.S
+++ b/arch/sparc/lib/atomic_32.S
@@ -40,60 +40,5 @@ ___xchg32_sun4md:
 	 mov	%g4, %o7
 #endif
 
-	/* Read asm-sparc/atomic.h carefully to understand how this works for SMP.
-	 * Really, some things here for SMP are overly clever, go read the header.
-	 */
-	.globl	___atomic24_add
-___atomic24_add:
-	rd	%psr, %g3		! Keep the code small, old way was stupid
-	nop; nop; nop;			! Let the bits set
-	or	%g3, PSR_PIL, %g7	! Disable interrupts
-	wr	%g7, 0x0, %psr		! Set %psr
-	nop; nop; nop;			! Let the bits set
-#ifdef CONFIG_SMP
-1:	ldstub	[%g1 + 3], %g7		! Spin on the byte lock for SMP.
-	orcc	%g7, 0x0, %g0		! Did we get it?
-	bne	1b			! Nope...
-	 ld	[%g1], %g7		! Load locked atomic24_t
-	sra	%g7, 8, %g7		! Get signed 24-bit integer
-	add	%g7, %g2, %g2		! Add in argument
-	sll	%g2, 8, %g7		! Transpose back to atomic24_t
-	st	%g7, [%g1]		! Clever: This releases the lock as well.
-#else
-	ld	[%g1], %g7		! Load locked atomic24_t
-	add	%g7, %g2, %g2		! Add in argument
-	st	%g2, [%g1]		! Store it back
-#endif
-	wr	%g3, 0x0, %psr		! Restore original PSR_PIL
-	nop; nop; nop;			! Let the bits set
-	jmpl	%o7, %g0		! NOTE: not + 8, see callers in atomic.h
-	 mov	%g4, %o7		! Restore %o7
-
-	.globl	___atomic24_sub
-___atomic24_sub:
-	rd	%psr, %g3		! Keep the code small, old way was stupid
-	nop; nop; nop;			! Let the bits set
-	or	%g3, PSR_PIL, %g7	! Disable interrupts
-	wr	%g7, 0x0, %psr		! Set %psr
-	nop; nop; nop;			! Let the bits set
-#ifdef CONFIG_SMP
-1:	ldstub	[%g1 + 3], %g7		! Spin on the byte lock for SMP.
-	orcc	%g7, 0x0, %g0		! Did we get it?
-	bne	1b			! Nope...
-	 ld	[%g1], %g7		! Load locked atomic24_t
-	sra	%g7, 8, %g7		! Get signed 24-bit integer
-	sub	%g7, %g2, %g2		! Subtract argument
-	sll	%g2, 8, %g7		! Transpose back to atomic24_t
-	st	%g7, [%g1]		! Clever: This releases the lock as well
-#else
-	ld	[%g1], %g7		! Load locked atomic24_t
-	sub	%g7, %g2, %g2		! Subtract argument
-	st	%g2, [%g1]		! Store it back
-#endif
-	wr	%g3, 0x0, %psr		! Restore original PSR_PIL
-	nop; nop; nop;			! Let the bits set
-	jmpl	%o7, %g0		! NOTE: not + 8, see callers in atomic.h
-	 mov	%g4, %o7		! Restore %o7
-
 	.globl  __atomic_end
 __atomic_end:
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index 1b30bb3..f73c224 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -62,8 +62,6 @@ extern void ___rw_read_enter(void);
 extern void ___rw_read_try(void);
 extern void ___rw_read_exit(void);
 extern void ___rw_write_enter(void);
-extern void ___atomic24_add(void);
-extern void ___atomic24_sub(void);
 
 /* Alias functions whose names begin with "." and export the aliases.
  * The module references will be fixed up by module_frob_arch_sections.
@@ -97,10 +95,6 @@ EXPORT_SYMBOL(___rw_read_exit);
 EXPORT_SYMBOL(___rw_write_enter);
 #endif
 
-/* Atomic operations. */
-EXPORT_SYMBOL(___atomic24_add);
-EXPORT_SYMBOL(___atomic24_sub);
-
 EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__lshrdi3);
-- 
1.6.0.6

