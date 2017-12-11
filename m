From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 11 Dec 2017 14:58:10 +0000
Subject: [PATCH] sparc32,leon: Use CASA when available for atomic operations
Message-Id: <1513004290-3331-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, software@gaisler.com

This probes for CASA support, that is commonly present in LEON
processors, and when available, uses the CASA instruction for atomic
operations rather than the spinlock based emulated atomic operations.

All CASA instructions are encoded using .word to be able to assemble
for v8.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---

This the followup version to the "sparc32,leon: Allow and use CAS for
atomic operations for LEON" patch series that did not do any runtime
detection.

There are a number of style warnings from checkpatch for this patch (and
even errors for space after parenthesis) and warnings about volatile
usage. However the style warnings are due to changes (like function
renames) to existing code and the volatile warnings due to using the
same function signatures for the CASA based functions as for the
emulated atomics.

The reason for adding the new arch/sparc/include/asm/cas_32.h is that it
is needed in several headers and trying to put the variable declaration
in atomic_32.h or chpxchg_32 lead to circular inclusions.

arch/sparc/include/asm/atomic_32.h  | 104 +++++++++++++++++++++++-----
 arch/sparc/include/asm/bitops_32.h  |  93 ++++++++++++++++++-------
 arch/sparc/include/asm/cas_32.h     |   7 ++
 arch/sparc/include/asm/cmpxchg_32.h |  59 ++++++++++++++--
 arch/sparc/kernel/entry.S           |   6 +-
 arch/sparc/kernel/head_32.S         |   8 +++
 arch/sparc/lib/Makefile             |   1 +
 arch/sparc/lib/atomic32.c           |  62 ++++++++++++-----
 arch/sparc/lib/atomic_cas_32.S      |  71 +++++++++++++++++++
 arch/sparc/lib/bitops_cas_32.S      | 132 ++++++++++++++++++++++++++++++++=
++++
 10 files changed, 477 insertions(+), 66 deletions(-)
 create mode 100644 arch/sparc/include/asm/cas_32.h
 create mode 100644 arch/sparc/lib/atomic_cas_32.S
 create mode 100644 arch/sparc/lib/bitops_cas_32.S

diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/at=
omic_32.h
index d13ce51..173ccfa 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -16,38 +16,106 @@
=20
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
+#include <asm/cas_32.h>
 #include <asm-generic/atomic64.h>
=20
 #define ATOMIC_INIT(i)  { (i) }
=20
-int atomic_add_return(int, atomic_t *);
-int atomic_fetch_add(int, atomic_t *);
-int atomic_fetch_and(int, atomic_t *);
-int atomic_fetch_or(int, atomic_t *);
-int atomic_fetch_xor(int, atomic_t *);
-int atomic_cmpxchg(atomic_t *, int, int);
-int atomic_xchg(atomic_t *, int);
+int emul_atomic_add_return(int, atomic_t *);
+int emul_atomic_fetch_add(int, atomic_t *);
+int emul_atomic_fetch_and(int, atomic_t *);
+int emul_atomic_fetch_or(int, atomic_t *);
+int emul_atomic_fetch_xor(int, atomic_t *);
+int emul_atomic_cmpxchg(atomic_t *, int, int);
+int emul_atomic_xchg(atomic_t *, int);
+void emul_atomic_set(atomic_t *, int);
+
 int __atomic_add_unless(atomic_t *, int, int);
-void atomic_set(atomic_t *, int);
=20
 #define atomic_set_release(v, i)	atomic_set((v), (i))
=20
 #define atomic_read(v)          READ_ONCE((v)->counter)
=20
-#define atomic_add(i, v)	((void)atomic_add_return( (int)(i), (v)))
-#define atomic_sub(i, v)	((void)atomic_add_return(-(int)(i), (v)))
-#define atomic_inc(v)		((void)atomic_add_return(        1, (v)))
-#define atomic_dec(v)		((void)atomic_add_return(       -1, (v)))
+#define emul_atomic_add(i, v)	((void)emul_atomic_add_return( (int)(i), (v)=
))
+#define emul_atomic_sub(i, v)	((void)emul_atomic_add_return(-(int)(i), (v)=
))
+
+#define emul_atomic_and(i, v)	((void)emul_atomic_fetch_and((i), (v)))
+#define emul_atomic_or(i, v)	((void)emul_atomic_fetch_or((i), (v)))
+#define emul_atomic_xor(i, v)	((void)emul_atomic_fetch_xor((i), (v)))
+
+#define emul_atomic_sub_return(i, v)	(emul_atomic_add_return(-(int)(i), (v=
)))
+#define emul_atomic_fetch_sub(i, v)	(emul_atomic_fetch_add (-(int)(i), (v)=
))
+
+static inline void atomic_set(atomic_t *v, int i)
+{
+	if (sparc32_cas_capable)
+		WRITE_ONCE(v->counter, i);
+	else
+		emul_atomic_set(v, i);
+}
+
+#define ATOMIC_VOID_FUNC(func)						\
+void cas_atomic_##func(int i, atomic_t *v);				\
+static inline void atomic_##func(int i, atomic_t *v)			\
+{									\
+	if (sparc32_cas_capable)					\
+		cas_atomic_##func(i, v);				\
+	else								\
+		emul_atomic_##func(i, v);				\
+}
+
+#define ATOMIC_INT_FUNC(func)						\
+int cas_atomic_##func(int i, atomic_t *v);				\
+static inline int atomic_##func(int i, atomic_t *v)			\
+{									\
+	if (sparc32_cas_capable)					\
+		return cas_atomic_##func(i, v);				\
+	else								\
+		return emul_atomic_##func(i, v);			\
+}
+
+ATOMIC_VOID_FUNC(add)
+ATOMIC_VOID_FUNC(sub)
+ATOMIC_VOID_FUNC(and)
+ATOMIC_VOID_FUNC(or)
+ATOMIC_VOID_FUNC(xor)
+
+ATOMIC_INT_FUNC(fetch_add)
+ATOMIC_INT_FUNC(fetch_sub)
+ATOMIC_INT_FUNC(fetch_and)
+ATOMIC_INT_FUNC(fetch_or)
+ATOMIC_INT_FUNC(fetch_xor)
+
+ATOMIC_INT_FUNC(add_return)
+ATOMIC_INT_FUNC(sub_return)
+
+#undef ATOMIC_VOID_FUNC
+#undef ATOMIC_INT_FUNC
+
+#define cas_atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
+#define cas_atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
+
+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	if (sparc32_cas_capable)
+		return cas_atomic_cmpxchg(v, old, new);
+	else
+		return emul_atomic_cmpxchg(v, old, new);
+}
=20
-#define atomic_and(i, v)	((void)atomic_fetch_and((i), (v)))
-#define atomic_or(i, v)		((void)atomic_fetch_or((i), (v)))
-#define atomic_xor(i, v)	((void)atomic_fetch_xor((i), (v)))
+static inline int atomic_xchg(atomic_t *v, int new)
+{
+	if (sparc32_cas_capable)
+		return cas_atomic_xchg(v, new);
+	else
+		return emul_atomic_xchg(v, new);
+}
=20
-#define atomic_sub_return(i, v)	(atomic_add_return(-(int)(i), (v)))
-#define atomic_fetch_sub(i, v)  (atomic_fetch_add (-(int)(i), (v)))
+#define atomic_inc(v)		(atomic_add(1, (v)))
+#define atomic_dec(v)		(atomic_sub(1, (v)))
=20
 #define atomic_inc_return(v)	(atomic_add_return(        1, (v)))
-#define atomic_dec_return(v)	(atomic_add_return(       -1, (v)))
+#define atomic_dec_return(v)	(atomic_sub_return(	   1, (v)))
=20
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
=20
diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bi=
tops_32.h
index 0ceff3b..4fcd67e 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -12,6 +12,7 @@
=20
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
+#include <asm/cas_32.h>
=20
 #ifdef __KERNEL__
=20
@@ -23,6 +24,13 @@ unsigned long ___set_bit(unsigned long *addr, unsigned l=
ong mask);
 unsigned long ___clear_bit(unsigned long *addr, unsigned long mask);
 unsigned long ___change_bit(unsigned long *addr, unsigned long mask);
=20
+int cas_test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
+int cas_set_bit(unsigned long nr, volatile unsigned long *addr);
+int cas_test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
+int cas_clear_bit(unsigned long nr, volatile unsigned long *addr);
+int cas_test_and_change_bit(unsigned long nr, volatile unsigned long *addr=
);
+int cas_change_bit(unsigned long nr, volatile unsigned long *addr);
+
 /*
  * Set bit 'nr' in 32-bit quantity at address 'addr' where bit '0'
  * is in the highest of the four bytes and bit '31' is the high bit
@@ -31,62 +39,99 @@ unsigned long ___change_bit(unsigned long *addr, unsign=
ed long mask);
  */
 static inline int test_and_set_bit(unsigned long nr, volatile unsigned lon=
g *addr)
 {
-	unsigned long *ADDR, mask;
+	int ret;
+
+	if (sparc32_cas_capable) {
+		ret =3D cas_test_and_set_bit(nr, addr);
+	} else {
+		unsigned long *ADDR, mask;
=20
-	ADDR =3D ((unsigned long *) addr) + (nr >> 5);
-	mask =3D 1 << (nr & 31);
+		ADDR =3D ((unsigned long *) addr) + (nr >> 5);
+		mask =3D 1 << (nr & 31);
=20
-	return ___set_bit(ADDR, mask) !=3D 0;
+		ret =3D ___set_bit(ADDR, mask) !=3D 0;
+	}
+
+	return ret;
 }
=20
 static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	unsigned long *ADDR, mask;
+	if (sparc32_cas_capable) {
+		cas_set_bit(nr, addr);
+	} else {
+		unsigned long *ADDR, mask;
+
+		ADDR =3D ((unsigned long *) addr) + (nr >> 5);
+		mask =3D 1 << (nr & 31);
=20
-	ADDR =3D ((unsigned long *) addr) + (nr >> 5);
-	mask =3D 1 << (nr & 31);
+		(void) ___set_bit(ADDR, mask);
+	}
=20
-	(void) ___set_bit(ADDR, mask);
 }
=20
 static inline int test_and_clear_bit(unsigned long nr, volatile unsigned l=
ong *addr)
 {
-	unsigned long *ADDR, mask;
+	int ret;
=20
-	ADDR =3D ((unsigned long *) addr) + (nr >> 5);
-	mask =3D 1 << (nr & 31);
+	if (sparc32_cas_capable) {
+		ret =3D cas_test_and_clear_bit(nr, addr);
+	} else {
+		unsigned long *ADDR, mask;
=20
-	return ___clear_bit(ADDR, mask) !=3D 0;
+		ADDR =3D ((unsigned long *) addr) + (nr >> 5);
+		mask =3D 1 << (nr & 31);
+
+		ret =3D ___clear_bit(ADDR, mask) !=3D 0;
+	}
+
+	return ret;
 }
=20
 static inline void clear_bit(unsigned long nr, volatile unsigned long *add=
r)
 {
-	unsigned long *ADDR, mask;
+	if (sparc32_cas_capable) {
+		cas_clear_bit(nr, addr);
+	} else {
+		unsigned long *ADDR, mask;
=20
-	ADDR =3D ((unsigned long *) addr) + (nr >> 5);
-	mask =3D 1 << (nr & 31);
+		ADDR =3D ((unsigned long *) addr) + (nr >> 5);
+		mask =3D 1 << (nr & 31);
=20
-	(void) ___clear_bit(ADDR, mask);
+		(void) ___clear_bit(ADDR, mask);
+	}
 }
=20
 static inline int test_and_change_bit(unsigned long nr, volatile unsigned =
long *addr)
 {
-	unsigned long *ADDR, mask;
+	int ret;
+
+	if (sparc32_cas_capable) {
+		ret =3D cas_test_and_change_bit(nr, addr);
+	} else {
+		unsigned long *ADDR, mask;
+
+		ADDR =3D ((unsigned long *) addr) + (nr >> 5);
+		mask =3D 1 << (nr & 31);
=20
-	ADDR =3D ((unsigned long *) addr) + (nr >> 5);
-	mask =3D 1 << (nr & 31);
+		ret =3D ___change_bit(ADDR, mask) !=3D 0;
+	}
=20
-	return ___change_bit(ADDR, mask) !=3D 0;
+	return ret;
 }
=20
 static inline void change_bit(unsigned long nr, volatile unsigned long *ad=
dr)
 {
-	unsigned long *ADDR, mask;
+	if (sparc32_cas_capable) {
+		cas_change_bit(nr, addr);
+	} else {
+		unsigned long *ADDR, mask;
=20
-	ADDR =3D ((unsigned long *) addr) + (nr >> 5);
-	mask =3D 1 << (nr & 31);
+		ADDR =3D ((unsigned long *) addr) + (nr >> 5);
+		mask =3D 1 << (nr & 31);
=20
-	(void) ___change_bit(ADDR, mask);
+		(void) ___change_bit(ADDR, mask);
+	}
 }
=20
 #include <asm-generic/bitops/non-atomic.h>
diff --git a/arch/sparc/include/asm/cas_32.h b/arch/sparc/include/asm/cas_3=
2.h
new file mode 100644
index 0000000..9f274d2
--- /dev/null
+++ b/arch/sparc/include/asm/cas_32.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SPARC_CAS_32_H
+#define _SPARC_CAS_32_H
+
+extern int sparc32_cas_capable;
+
+#endif /* _SPARC_CAS_32_H */
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/c=
mpxchg_32.h
index c73b5a3..8d9c192 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -12,14 +12,31 @@
 #ifndef __ARCH_SPARC_CMPXCHG__
 #define __ARCH_SPARC_CMPXCHG__
=20
-unsigned long __xchg_u32(volatile u32 *m, u32 new);
+#include <asm/cas_32.h>
+#include <asm/bug.h>
+
+/* To be used together with the cas based atomics */
+static inline unsigned long swap_xchg_u32(__volatile__ unsigned long *m,
+					  unsigned long val)
+{
+	__asm__ __volatile__("swap [%2], %0"
+			     : "=3D&r" (val)
+			     : "0" (val), "r" (m)
+			     : "memory");
+	return val;
+}
+
+unsigned long emul_xchg_u32(volatile u32 *m, u32 new);
 void __xchg_called_with_bad_pointer(void);
=20
 static inline unsigned long __xchg(unsigned long x, __volatile__ void * pt=
r, int size)
 {
 	switch (size) {
 	case 4:
-		return __xchg_u32(ptr, x);
+		if (sparc32_cas_capable)
+			return swap_xchg_u32(ptr, x);
+		else
+			return emul_xchg_u32(ptr, x);
 	}
 	__xchg_called_with_bad_pointer();
 	return x;
@@ -38,8 +55,24 @@ static inline unsigned long __xchg(unsigned long x, __vo=
latile__ void * ptr, int
=20
 /* bug catcher for when unsupported size is used - won't link */
 void __cmpxchg_called_with_bad_pointer(void);
+
 /* we only need to support cmpxchg of a u32 on sparc */
-unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
+static inline unsigned long cas_cmpxchg_u32(volatile u32 *m, u32 old, u32 =
new)
+{
+	__asm__ __volatile__("mov	%0, %%g1\n\t"
+			     "mov	%2, %%g2\n\t"
+			     "mov	%3, %%g3\n\t"
+			     /* word below is casa [%g2] 0xb, %g3, %g1 */
+			     ".word	0xc3e08163\n\t"
+			     "mov	%%g1, %0"
+			     : "=3D&r" (new)
+			     : "0" (new), "r" (m), "r" (old)
+			     : "memory", "g1", "g2", "g3");
+
+	return new;
+}
+
+unsigned long emul_cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
=20
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
@@ -47,7 +80,11 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigne=
d long new_, int size)
 {
 	switch (size) {
 	case 4:
-		return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
+		if (sparc32_cas_capable)
+			return cas_cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
+		else
+			return emul_cmpxchg_u32((u32 *)ptr, (u32)old,
+						(u32)new_);
 	default:
 		__cmpxchg_called_with_bad_pointer();
 		break;
@@ -63,8 +100,18 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsign=
ed long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
=20
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
-#define cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
+u64 emul_cmpxchg_u64(u64 *ptr, u64 old, u64 new);
+
+static inline u64 cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+{
+#ifdef CONFIG_SMP
+	/* There is no 64-bit CASA instruction on the 32-bit LEON */
+	WARN_ONCE(sparc32_cas_capable,
+		  "Emulated %s only atomic against other calls to itself",
+		  __func__);
+#endif
+	return emul_cmpxchg_u64(ptr, old, new);
+}
=20
 #include <asm-generic/cmpxchg-local.h>
=20
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 358fe4e..d57dfe6 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -439,6 +439,10 @@ bad_instruction:
 	and	%l5, %l4, %l5
 	cmp	%l5, %l7
 	be	1f
+	 sethi	%hi(leon_cas_check), %l4
+	or	%l4, %lo(leon_cas_check), %l4
+	cmp	%l1, %l4
+	be	1f
 	SAVE_ALL
=20
 	wr	%l0, PSR_ET, %psr		! re-enable traps
@@ -452,7 +456,7 @@ bad_instruction:
=20
 	RESTORE_ALL
=20
-1:	/* unimplemented flush - just skip */
+1:	/* unimplemented flush or probed CASA - just skip */
 	jmpl	%l2, %g0
 	 rett	%l2 + 4
=20
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index e55f2c0..72a57af 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -441,6 +441,14 @@ leon_init:
 		/* Update boot_cpu_id only on boot cpu */
 		stub	%g1, [%g2 + %lo(boot_cpu_id)]
=20
+		/* Check if CASA is supported */
+		set	sparc32_cas_capable, %g1
+		mov	1, %g2
+
+		.global	leon_cas_check
+leon_cas_check:
+		.word	0xc5e04160 /* casa [%g1] 0xb, %g0, %g2 */
+
 		ba continue_boot
 		 nop
=20
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 0f0f76b..f6e1fb7 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -53,4 +53,5 @@ lib-$(CONFIG_SPARC64) +=3D mcount.o ipcsum.o xor.o hweigh=
t.o ffs.o
=20
 obj-$(CONFIG_SPARC64) +=3D iomap.o
 obj-$(CONFIG_SPARC32) +=3D atomic32.o ucmpdi2.o
+obj-$(CONFIG_SPARC32) +=3D atomic_cas_32.o bitops_cas_32.o
 obj-$(CONFIG_SPARC64) +=3D PeeCeeI.o
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 465a901..901407e 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -12,6 +12,9 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
=20
+/* In .data section as it is set up before bss zeroing */
+int sparc32_cas_capable __attribute__((__section__(".data")));
+
 #ifdef CONFIG_SMP
 #define ATOMIC_HASH_SIZE	4
 #define ATOMIC_HASH(a)	(&__atomic_hash[(((unsigned long)a)>>8) & (ATOMIC_H=
ASH_SIZE-1)])
@@ -29,7 +32,7 @@ static DEFINE_SPINLOCK(dummy);
 #endif /* SMP */
=20
 #define ATOMIC_FETCH_OP(op, c_op)					\
-int atomic_fetch_##op(int i, atomic_t *v)				\
+int emul_atomic_fetch_##op(int i, atomic_t *v)				\
 {									\
 	int ret;							\
 	unsigned long flags;						\
@@ -41,10 +44,10 @@ int atomic_fetch_##op(int i, atomic_t *v)				\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
 }									\
-EXPORT_SYMBOL(atomic_fetch_##op);
+EXPORT_SYMBOL(emul_atomic_fetch_##op);
=20
 #define ATOMIC_OP_RETURN(op, c_op)					\
-int atomic_##op##_return(int i, atomic_t *v)				\
+int emul_atomic_##op##_return(int i, atomic_t *v)			\
 {									\
 	int ret;							\
 	unsigned long flags;						\
@@ -55,7 +58,7 @@ int atomic_##op##_return(int i, atomic_t *v)				\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
 }									\
-EXPORT_SYMBOL(atomic_##op##_return);
+EXPORT_SYMBOL(emul_atomic_##op##_return);
=20
 ATOMIC_OP_RETURN(add, +=3D)
=20
@@ -67,7 +70,7 @@ ATOMIC_FETCH_OP(xor, ^=3D)
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
=20
-int atomic_xchg(atomic_t *v, int new)
+int emul_atomic_xchg(atomic_t *v, int new)
 {
 	int ret;
 	unsigned long flags;
@@ -78,9 +81,9 @@ int atomic_xchg(atomic_t *v, int new)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
-EXPORT_SYMBOL(atomic_xchg);
+EXPORT_SYMBOL(emul_atomic_xchg);
=20
-int atomic_cmpxchg(atomic_t *v, int old, int new)
+int emul_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
 	unsigned long flags;
@@ -93,9 +96,26 @@ int atomic_cmpxchg(atomic_t *v, int old, int new)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
-EXPORT_SYMBOL(atomic_cmpxchg);
+EXPORT_SYMBOL(emul_atomic_cmpxchg);
=20
-int __atomic_add_unless(atomic_t *v, int a, int u)
+static int __cas_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int c, old;
+
+	c =3D atomic_read(v);
+	for (;;) {
+		if (unlikely(c =3D u))
+			break;
+		old =3D cas_atomic_cmpxchg(v, c, c + a);
+		if (likely(old =3D c))
+			break;
+		c =3D old;
+	}
+
+	return c;
+}
+
+static int __emul_atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
 	unsigned long flags;
@@ -107,10 +127,18 @@ int __atomic_add_unless(atomic_t *v, int a, int u)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
+
+int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+	if (sparc32_cas_capable)
+		return __cas_atomic_add_unless(v, a, u);
+	else
+		return __emul_atomic_add_unless(v, a, u);
+}
 EXPORT_SYMBOL(__atomic_add_unless);
=20
 /* Atomic operations are already serializing */
-void atomic_set(atomic_t *v, int i)
+void emul_atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
=20
@@ -118,7 +146,7 @@ void atomic_set(atomic_t *v, int i)
 	v->counter =3D i;
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 }
-EXPORT_SYMBOL(atomic_set);
+EXPORT_SYMBOL(emul_atomic_set);
=20
 unsigned long ___set_bit(unsigned long *addr, unsigned long mask)
 {
@@ -159,7 +187,7 @@ unsigned long ___change_bit(unsigned long *addr, unsign=
ed long mask)
 }
 EXPORT_SYMBOL(___change_bit);
=20
-unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
+unsigned long emul_cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 {
 	unsigned long flags;
 	u32 prev;
@@ -171,9 +199,9 @@ unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old,=
 u32 new)
=20
 	return (unsigned long)prev;
 }
-EXPORT_SYMBOL(__cmpxchg_u32);
+EXPORT_SYMBOL(emul_cmpxchg_u32);
=20
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+u64 emul_cmpxchg_u64(u64 *ptr, u64 old, u64 new)
 {
 	unsigned long flags;
 	u64 prev;
@@ -185,9 +213,9 @@ u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
=20
 	return prev;
 }
-EXPORT_SYMBOL(__cmpxchg_u64);
+EXPORT_SYMBOL(emul_cmpxchg_u64);
=20
-unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
+unsigned long emul_xchg_u32(volatile u32 *ptr, u32 new)
 {
 	unsigned long flags;
 	u32 prev;
@@ -199,4 +227,4 @@ unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
=20
 	return (unsigned long)prev;
 }
-EXPORT_SYMBOL(__xchg_u32);
+EXPORT_SYMBOL(emul_xchg_u32);
diff --git a/arch/sparc/lib/atomic_cas_32.S b/arch/sparc/lib/atomic_cas_32.S
new file mode 100644
index 0000000..9983979
--- /dev/null
+++ b/arch/sparc/lib/atomic_cas_32.S
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * atomic_cas_32.S
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
+ENTRY(cas_atomic_##op) /* %o0 =3D increment, %o1 =3D atomic_ptr */		\
+1:	ld	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	.word	0xcfe24161;	/* casa [%o1] 0xb, %g1, %g7 */ 		\
+	cmp	%g1, %g7;						\
+	bne	1b;							\
+	 nop;								\
+	retl;								\
+	 nop;								\
+ENDPROC(cas_atomic_##op);						\
+EXPORT_SYMBOL(cas_atomic_##op);
+
+#define ATOMIC_OP_RETURN(op)						\
+ENTRY(cas_atomic_##op##_return) /* %o0 =3D increment, %o1 =3D atomic_ptr *=
/	\
+1:	ld	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	.word	0xcfe24161;	/* casa [%o1] 0xb, %g1, %g7 */ 		\
+	cmp	%g1, %g7;						\
+	bne	1b;							\
+	 nop;								\
+	retl;								\
+	 op	%g1, %o0, %o0;						\
+ENDPROC(cas_atomic_##op##_return);					\
+EXPORT_SYMBOL(cas_atomic_##op##_return);
+
+#define ATOMIC_FETCH_OP(op)						\
+ENTRY(cas_atomic_fetch_##op) /* %o0 =3D increment, %o1 =3D atomic_ptr */	\
+1:	ld	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	.word	0xcfe24161;	/* casa [%o1] 0xb, %g1, %g7 */ 		\
+	cmp	%g1, %g7;						\
+	bne	1b;							\
+	 nop;								\
+	retl;								\
+	 mov	%g1, %o0;						\
+ENDPROC(cas_atomic_fetch_##op);						\
+EXPORT_SYMBOL(cas_atomic_fetch_##op);
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
index 0000000..6669c45
--- /dev/null
+++ b/arch/sparc/lib/bitops_cas_32.S
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * bitops_cas_32.S: Sparc32 atomic bit operations for LEON with CAS.
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
+ENTRY(cas_test_and_set_bit)	/* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	or	%g7, %o2, %g1
+	.word	0xc3e24167	/* casa	[%o1] 0xb, %g7, %g1 */
+	cmp	%g7, %g1
+	bne	1b
+	 clr	%o0
+	andcc	%g7, %o2, %g2
+	bne,a	2f
+	 mov	1, %o0
+2:	retl
+	 nop
+ENDPROC(cas_test_and_set_bit)
+EXPORT_SYMBOL(cas_test_and_set_bit)
+
+ENTRY(cas_test_and_clear_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	andn	%g7, %o2, %g1
+	.word	0xc3e24167	/* casa	[%o1] 0xb, %g7, %g1 */
+	cmp	%g7, %g1
+	bne	1b
+	 clr	%o0
+	andcc	%g7, %o2, %g2
+	bne,a	2f
+	 mov	1, %o0
+2:	retl
+	 nop
+ENDPROC(cas_test_and_clear_bit)
+EXPORT_SYMBOL(cas_test_and_clear_bit)
+
+ENTRY(cas_test_and_change_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	xor	%g7, %o2, %g1
+	.word	0xc3e24167	/* casa	[%o1] 0xb, %g7, %g1 */
+	cmp	%g7, %g1
+	bne	1b
+	 clr	%o0
+	andcc	%g7, %o2, %g2
+	bne,a	2f
+	 mov	1, %o0
+2:	retl
+	 nop
+ENDPROC(cas_test_and_change_bit)
+EXPORT_SYMBOL(cas_test_and_change_bit)
+
+ENTRY(cas_set_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	or	%g7, %o2, %g1
+	.word	0xc3e24167	/* casa	[%o1] 0xb, %g7, %g1 */
+	cmp	%g7, %g1
+	bne	1b
+	 nop
+	retl
+	 nop
+ENDPROC(cas_set_bit)
+EXPORT_SYMBOL(cas_set_bit)
+
+ENTRY(cas_clear_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	andn	%g7, %o2, %g1
+	.word	0xc3e24167	/* casa	[%o1] 0xb, %g7, %g1 */
+	cmp	%g7, %g1
+	bne	1b
+	 nop
+	retl
+	 nop
+ENDPROC(cas_clear_bit)
+EXPORT_SYMBOL(cas_clear_bit)
+
+ENTRY(cas_change_bit) /* %o0=3Dnr, %o1=ADdr */
+	srl	%o0, 5, %g1
+	mov	1, %o2
+	sll	%g1, 2, %g3
+	and	%o0, 31, %g2
+	sll	%o2, %g2, %o2
+	add	%o1, %g3, %o1
+1:	ld	[%o1], %g7
+	xor	%g7, %o2, %g1
+	.word	0xc3e24167	/* casa	[%o1] 0xb, %g7, %g1 */
+	cmp	%g7, %g1
+	bne	1b
+	 nop
+	retl
+	 nop
+ENDPROC(cas_change_bit)
+EXPORT_SYMBOL(cas_change_bit)
--=20
2.8.0

