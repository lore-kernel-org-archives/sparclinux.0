From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 14 Nov 2017 14:03:43 +0000
Subject: [PATCH 2/2] sparc32,leon: Add support for atomic operations with CAS
Message-Id: <1510668223-18484-3-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1510668223-18484-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1510668223-18484-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, software@gaisler.com

Adds support for doing atomic operations using CAS on LEON instead of
using the spinlock based emulated atomics. It is configurable for LEON
as not all LEON hardware supports the CASA instruction.

This does not support cmpxchg64 as no 64-bit CAS instruction exists on
LEON.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/Kconfig                  |  17 ++++-
 arch/sparc/include/asm/atomic_32.h  |  55 ++++++++++++++-
 arch/sparc/include/asm/bitops_32.h  |  13 ++++
 arch/sparc/include/asm/cmpxchg_32.h |  37 ++++++++++
 arch/sparc/lib/Makefile             |   4 +-
 arch/sparc/lib/atomic_cas_32.S      |  69 +++++++++++++++++++
 arch/sparc/lib/bitops_cas_32.S      | 130 ++++++++++++++++++++++++++++++++=
++++
 7 files changed, 318 insertions(+), 7 deletions(-)
 create mode 100644 arch/sparc/lib/atomic_cas_32.S
 create mode 100644 arch/sparc/lib/bitops_cas_32.S

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0be3828..b587579 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -228,10 +228,10 @@ config ARCH_MAY_HAVE_PC_FDC
=20
 config EMULATED_CMPXCHG
 	bool
-	default y if SPARC32
+	default y if SPARC32_NO_CAS
 	help
-	  Sparc32 does not have a CAS instruction like sparc64. cmpxchg()
-	  is emulated, and therefore it is not completely atomic.
+	  Sparc32 does not in general have a CAS instruction like sparc64.
+	  When cmpxchg() is emulated it is not completely atomic.
=20
 # Makefile helpers
 config SPARC32_SMP
@@ -427,6 +427,10 @@ config SERIAL_CONSOLE
=20
 	  If unsure, say N.
=20
+config SPARC32_NO_CAS
+       bool
+       default y if SPARC32 && !SPARC_LEON_CAS
+
 config SPARC_LEON
 	bool "Sparc Leon processor family"
 	depends on SPARC32
@@ -441,6 +445,13 @@ config SPARC_LEON
 	  toolchain at www.gaisler.com.
=20
 if SPARC_LEON
+config SPARC_LEON_CAS
+	bool "Use Compare and Swap"
+	default y
+	---help---
+	  If you say Y here the kernel will use the CASA instruction. Enable
+	  this only if the LEON processor has hardware support for it.
+
 menu "U-Boot options"
=20
 config UBOOT_LOAD_ADDR
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/at=
omic_32.h
index 7643e97..dde09cb 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -18,6 +18,57 @@
 #include <asm-generic/atomic64.h>
=20
 #define ATOMIC_INIT(i)  { (i) }
+#define atomic_read(v)          ACCESS_ONCE((v)->counter)
+#define atomic_set_release(v, i)	atomic_set((v), (i))
+
+#ifdef CONFIG_SPARC_LEON_CAS
+
+#define ATOMIC_OP(op)							\
+void atomic_##op(int, atomic_t *);
+
+#define ATOMIC_OP_RETURN(op)						\
+int atomic_##op##_return(int, atomic_t *);
+
+#define ATOMIC_FETCH_OP(op)						\
+int atomic_fetch_##op(int, atomic_t *);
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(=
op)
+
+ATOMIC_OPS(add)
+ATOMIC_OPS(sub)
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
+
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int c, old;
+	c =3D atomic_read(v);
+	for (;;) {
+		if (unlikely(c =3D (u)))
+			break;
+		old =3D atomic_cmpxchg((v), c, c + (a));
+		if (likely(old =3D c))
+			break;
+		c =3D old;
+	}
+	return c;
+}
+
+#else /* CONFIG_SPARC_LEON_CAS */
=20
 int atomic_add_return(int, atomic_t *);
 int atomic_fetch_add(int, atomic_t *);
@@ -29,9 +80,7 @@ int atomic_xchg(atomic_t *, int);
 int __atomic_add_unless(atomic_t *, int, int);
 void atomic_set(atomic_t *, int);
=20
-#define atomic_set_release(v, i)	atomic_set((v), (i))
-
-#define atomic_read(v)          ACCESS_ONCE((v)->counter)
+#endif /* CONFIG_SPARC_LEON_CAS */
=20
 #define atomic_add(i, v)	((void)atomic_add_return( (int)(i), (v)))
 #define atomic_sub(i, v)	((void)atomic_add_return(-(int)(i), (v)))
diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bi=
tops_32.h
index 600ed1d..a310e2f 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -18,6 +18,17 @@
 #error only <linux/bitops.h> can be included directly
 #endif
=20
+#ifdef CONFIG_SPARC_LEON_CAS
+
+int test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
+int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
+int test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
+void set_bit(unsigned long nr, volatile unsigned long *addr);
+void clear_bit(unsigned long nr, volatile unsigned long *addr);
+void change_bit(unsigned long nr, volatile unsigned long *addr);
+
+#else /* CONFIG_SPARC_LEON_CAS */
+
 unsigned long ___set_bit(unsigned long *addr, unsigned long mask);
 unsigned long ___clear_bit(unsigned long *addr, unsigned long mask);
 unsigned long ___change_bit(unsigned long *addr, unsigned long mask);
@@ -88,6 +99,8 @@ static inline void change_bit(unsigned long nr, volatile =
unsigned long *addr)
 	(void) ___change_bit(ADDR, mask);
 }
=20
+#endif /* CONFIG_SPARC_LEON_CAS */
+
 #include <asm-generic/bitops/non-atomic.h>
=20
 #include <asm-generic/bitops/ffz.h>
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/c=
mpxchg_32.h
index a0101a5..826510d 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -11,14 +11,34 @@
 #ifndef __ARCH_SPARC_CMPXCHG__
 #define __ARCH_SPARC_CMPXCHG__
=20
+#ifdef CONFIG_SPARC_LEON_CAS
+
+static inline unsigned long xchg_u32(__volatile__ unsigned long *m, unsign=
ed long val)
+{
+	__asm__ __volatile__("swap [%2], %0"
+			     : "=3D&r" (val)
+			     : "0" (val), "r" (m)
+			     : "memory");
+	return val;
+}
+
+#else /* CONFIG_SPARC_LEON_CAS */
+
 unsigned long __xchg_u32(volatile u32 *m, u32 new);
+
+#endif /* CONFIG_SPARC_LEON_CAS */
+
 void __xchg_called_with_bad_pointer(void);
=20
 static inline unsigned long __xchg(unsigned long x, __volatile__ void * pt=
r, int size)
 {
 	switch (size) {
 	case 4:
+#ifdef CONFIG_SPARC_LEON_CAS
+		return xchg_u32(ptr, x);
+#else
 		return __xchg_u32(ptr, x);
+#endif
 	}
 	__xchg_called_with_bad_pointer();
 	return x;
@@ -37,8 +57,23 @@ static inline unsigned long __xchg(unsigned long x, __vo=
latile__ void * ptr, int
=20
 /* bug catcher for when unsupported size is used - won't link */
 void __cmpxchg_called_with_bad_pointer(void);
+
 /* we only need to support cmpxchg of a u32 on sparc */
+#ifdef CONFIG_SPARC_LEON_CAS
+static inline unsigned long
+__cmpxchg_u32(volatile int *m, int old, int new)
+{
+	__asm__ __volatile__("casa [%2] 0xb, %3, %0"
+			     : "=3D&r" (new)
+			     : "0" (new), "r" (m), "r" (old)
+			     : "memory");
+
+	return new;
+}
+
+#else /* CONFIG_SPARC_LEON_CAS */
 unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
+#endif /* CONFIG_SPARC_LEON_CAS */
=20
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
@@ -62,8 +97,10 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigne=
d long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
=20
+#ifndef CONFIG_SPARC_LEON_CAS
 u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
 #define cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
+#endif
=20
 #include <asm-generic/cmpxchg-local.h>
=20
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index a1a2d39..1fd575a 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -48,5 +48,7 @@ lib-$(CONFIG_SPARC64) +=3D copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) +=3D mcount.o ipcsum.o xor.o hweight.o ffs.o
=20
 obj-$(CONFIG_SPARC64) +=3D iomap.o
-obj-$(CONFIG_SPARC32) +=3D atomic32.o ucmpdi2.o
+obj-$(CONFIG_SPARC32) +=3D ucmpdi2.o
+obj-$(CONFIG_SPARC32_NO_CAS) +=3D atomic32.o
+obj-$(CONFIG_SPARC_LEON_CAS) +=3D atomic_cas_32.o bitops_cas_32.o
 obj-$(CONFIG_SPARC64) +=3D PeeCeeI.o
diff --git a/arch/sparc/lib/atomic_cas_32.S b/arch/sparc/lib/atomic_cas_32.S
new file mode 100644
index 0000000..5637606
--- /dev/null
+++ b/arch/sparc/lib/atomic_cas_32.S
@@ -0,0 +1,69 @@
+/* atomic_cas_32.S
+ *
+ * Copyright (C) 1999, 2007 2012 David S. Miller (davem@davemloft.net)
+ *
+ * Adaption for LEON with CAS from atomic_64.S, by Andreas Larsson
+ * (andreas@gaisler.com).
+ */
+
+#include <linux/linkage.h>
+#include <asm/asi.h>
+#include <asm/export.h>
+
+	.text
+
+#define ATOMIC_OP(op)							\
+ENTRY(atomic_##op) /* %o0 =3D increment, %o1 =3D atomic_ptr */		\
+1:	ld	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	casa	[%o1] 0xb, %g1, %g7;					\
+	cmp	%g1, %g7;						\
+	bne	1b;							\
+	 nop;								\
+	retl;								\
+	 nop;								\
+ENDPROC(atomic_##op);							\
+EXPORT_SYMBOL(atomic_##op);
+
+#define ATOMIC_OP_RETURN(op)						\
+ENTRY(atomic_##op##_return) /* %o0 =3D increment, %o1 =3D atomic_ptr */	\
+1:	ld	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	casa	[%o1] 0xb, %g1, %g7;					\
+	cmp	%g1, %g7;						\
+	bne	1b;							\
+	 nop;								\
+	retl;								\
+	 op	%g1, %o0, %o0;						\
+ENDPROC(atomic_##op##_return);					\
+EXPORT_SYMBOL(atomic_##op##_return);
+
+#define ATOMIC_FETCH_OP(op)						\
+ENTRY(atomic_fetch_##op) /* %o0 =3D increment, %o1 =3D atomic_ptr */	\
+1:	ld	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	casa	[%o1] 0xb, %g1, %g7;					\
+	cmp	%g1, %g7;						\
+	bne	1b;							\
+	 nop;								\
+	retl;								\
+	 mov	%g1, %o0;						\
+ENDPROC(atomic_fetch_##op);						\
+EXPORT_SYMBOL(atomic_fetch_##op);
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(=
op)
+
+ATOMIC_OPS(add)
+ATOMIC_OPS(sub)
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
diff --git a/arch/sparc/lib/bitops_cas_32.S b/arch/sparc/lib/bitops_cas_32.S
new file mode 100644
index 0000000..184e212
--- /dev/null
+++ b/arch/sparc/lib/bitops_cas_32.S
@@ -0,0 +1,130 @@
+/* bitops_cas_32.S: Sparc32 atomic bit operations for LEON with CAS.
+ *
+ * Copyright (C) 2000, 2007 David S. Miller (davem@davemloft.net)
+ *
+ * Adaption for LEON with CAS from bitops.S, by Andreas Larsson
+ * (andreas@gaisler.com).
+ */
+
+#include <linux/linkage.h>
+#include <asm/asi.h>
+#include <asm/export.h>
+
+	.text
+
+ENTRY(test_and_set_bit)	/* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	or	%g7, %o2, %g1
+	casa	[%o1] 0xb, %g7, %g1
+	cmp	%g7, %g1
+	bne	1b
+	 clr	%o0
+	andcc	%g7, %o2, %g2
+	bne,a	2f
+	 mov	1, %o0
+2:	retl
+	 nop
+ENDPROC(test_and_set_bit)
+EXPORT_SYMBOL(test_and_set_bit)
+
+ENTRY(test_and_clear_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	andn	%g7, %o2, %g1
+	casa	[%o1] 0xb, %g7, %g1
+	cmp	%g7, %g1
+	bne	1b
+	 clr	%o0
+	andcc	%g7, %o2, %g2
+	bne,a	2f
+	 mov	1, %o0
+2:	retl
+	 nop
+ENDPROC(test_and_clear_bit)
+EXPORT_SYMBOL(test_and_clear_bit)
+
+ENTRY(test_and_change_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	xor	%g7, %o2, %g1
+	casa	[%o1] 0xb, %g7, %g1
+	cmp	%g7, %g1
+	bne	1b
+	 clr	%o0
+	andcc	%g7, %o2, %g2
+	bne,a	2f
+	 mov	1, %o0
+2:	retl
+	 nop
+ENDPROC(test_and_change_bit)
+EXPORT_SYMBOL(test_and_change_bit)
+
+ENTRY(set_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	or	%g7, %o2, %g1
+	casa	[%o1] 0xb, %g7, %g1
+	cmp	%g7, %g1
+	bne	1b
+	 nop
+	retl
+	 nop
+ENDPROC(set_bit)
+EXPORT_SYMBOL(set_bit)
+
+ENTRY(clear_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	andn	%g7, %o2, %g1
+	casa	[%o1] 0xb, %g7, %g1
+	cmp	%g7, %g1
+	bne	1b
+	 nop
+	retl
+	 nop
+ENDPROC(clear_bit)
+EXPORT_SYMBOL(clear_bit)
+
+ENTRY(change_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	xor	%g7, %o2, %g1
+	casa	[%o1] 0xb, %g7, %g1
+	cmp	%g7, %g1
+	bne	1b
+	 nop
+	retl
+	 nop
+ENDPROC(change_bit)
+EXPORT_SYMBOL(change_bit)
--=20
2.8.0

