From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:42 +0000
Subject: [PATCH 5/10]: sparc: Stop trying to be so fancy and use
Message-Id: <20091211.225542.112620427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This mirrors commit ff60fab71bb3b4fdbf8caf57ff3739ffd0887396
(x86: Use __builtin_memset and __builtin_memcpy for memset/memcpy)

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/string_32.h |   78 +-----------------------------------
 arch/sparc/include/asm/string_64.h |   25 +-----------
 arch/sparc/lib/bzero.S             |    5 --
 arch/sparc/lib/checksum_32.S       |    2 +-
 arch/sparc/lib/ksyms.c             |    2 -
 arch/sparc/lib/memcpy.S            |    3 -
 arch/sparc/lib/memset.S            |    3 +-
 7 files changed, 6 insertions(+), 112 deletions(-)

diff --git a/arch/sparc/include/asm/string_32.h b/arch/sparc/include/asm/string_32.h
index 6c5fddb..edf196e 100644
--- a/arch/sparc/include/asm/string_32.h
+++ b/arch/sparc/include/asm/string_32.h
@@ -16,8 +16,6 @@
 #ifdef __KERNEL__
 
 extern void __memmove(void *,const void *,__kernel_size_t);
-extern __kernel_size_t __memcpy(void *,const void *,__kernel_size_t);
-extern __kernel_size_t __memset(void *,int,__kernel_size_t);
 
 #ifndef EXPORT_SYMTAB_STROPS
 
@@ -32,82 +30,10 @@ extern __kernel_size_t __memset(void *,int,__kernel_size_t);
 })
 
 #define __HAVE_ARCH_MEMCPY
-
-static inline void *__constant_memcpy(void *to, const void *from, __kernel_size_t n)
-{
-	extern void __copy_1page(void *, const void *);
-
-	if(n <= 32) {
-		__builtin_memcpy(to, from, n);
-	} else if (((unsigned int) to & 7) != 0) {
-		/* Destination is not aligned on the double-word boundary */
-		__memcpy(to, from, n);
-	} else {
-		switch(n) {
-		case PAGE_SIZE:
-			__copy_1page(to, from);
-			break;
-		default:
-			__memcpy(to, from, n);
-			break;
-		}
-	}
-	return to;
-}
-
-static inline void *__nonconstant_memcpy(void *to, const void *from, __kernel_size_t n)
-{
-	__memcpy(to, from, n);
-	return to;
-}
-
-#undef memcpy
-#define memcpy(t, f, n) \
-(__builtin_constant_p(n) ? \
- __constant_memcpy((t),(f),(n)) : \
- __nonconstant_memcpy((t),(f),(n)))
+#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
 
 #define __HAVE_ARCH_MEMSET
-
-static inline void *__constant_c_and_count_memset(void *s, char c, __kernel_size_t count)
-{
-	extern void bzero_1page(void *);
-	extern __kernel_size_t __bzero(void *, __kernel_size_t);
-
-	if(!c) {
-		if(count = PAGE_SIZE)
-			bzero_1page(s);
-		else
-			__bzero(s, count);
-	} else {
-		__memset(s, c, count);
-	}
-	return s;
-}
-
-static inline void *__constant_c_memset(void *s, char c, __kernel_size_t count)
-{
-	extern __kernel_size_t __bzero(void *, __kernel_size_t);
-
-	if(!c)
-		__bzero(s, count);
-	else
-		__memset(s, c, count);
-	return s;
-}
-
-static inline void *__nonconstant_memset(void *s, char c, __kernel_size_t count)
-{
-	__memset(s, c, count);
-	return s;
-}
-
-#undef memset
-#define memset(s, c, count) \
-(__builtin_constant_p(c) ? (__builtin_constant_p(count) ? \
-                            __constant_c_and_count_memset((s), (c), (count)) : \
-                            __constant_c_memset((s), (c), (count))) \
-                          : __nonconstant_memset((s), (c), (count)))
+#define memset(s, c, count) __builtin_memset(s, c, count)
 
 #define __HAVE_ARCH_MEMSCAN
 
diff --git a/arch/sparc/include/asm/string_64.h b/arch/sparc/include/asm/string_64.h
index 43161f2..9623bc2 100644
--- a/arch/sparc/include/asm/string_64.h
+++ b/arch/sparc/include/asm/string_64.h
@@ -15,8 +15,6 @@
 
 #include <asm/asi.h>
 
-extern void *__memset(void *,int,__kernel_size_t);
-
 #ifndef EXPORT_SYMTAB_STROPS
 
 /* First the mem*() things. */
@@ -24,29 +22,10 @@ extern void *__memset(void *,int,__kernel_size_t);
 extern void *memmove(void *, const void *, __kernel_size_t);
 
 #define __HAVE_ARCH_MEMCPY
-extern void *memcpy(void *, const void *, __kernel_size_t);
+#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
 
 #define __HAVE_ARCH_MEMSET
-extern void *__builtin_memset(void *,int,__kernel_size_t);
-
-static inline void *__constant_memset(void *s, int c, __kernel_size_t count)
-{
-	extern __kernel_size_t __bzero(void *, __kernel_size_t);
-
-	if (!c) {
-		__bzero(s, count);
-		return s;
-	} else
-		return __memset(s, c, count);
-}
-
-#undef memset
-#define memset(s, c, count) \
-((__builtin_constant_p(count) && (count) <= 32) ? \
- __builtin_memset((s), (c), (count)) : \
- (__builtin_constant_p(c) ? \
-  __constant_memset((s), (c), (count)) : \
-  __memset((s), (c), (count))))
+#define memset(s, c, count) __builtin_memset(s, c, count)
 
 #define __HAVE_ARCH_MEMSCAN
 
diff --git a/arch/sparc/lib/bzero.S b/arch/sparc/lib/bzero.S
index b655729..615f401 100644
--- a/arch/sparc/lib/bzero.S
+++ b/arch/sparc/lib/bzero.S
@@ -6,10 +6,6 @@
 
 	.text
 
-	.globl	__memset
-	.type	__memset, #function
-__memset:		/* %o0=buf, %o1=pat, %o2=len */
-
 	.globl	memset
 	.type	memset, #function
 memset:			/* %o0=buf, %o1=pat, %o2=len */
@@ -83,7 +79,6 @@ __bzero_done:
 	retl
 	 mov		%o3, %o0
 	.size		__bzero, .-__bzero
-	.size		__memset, .-__memset
 	.size		memset, .-memset
 
 #define EX_ST(x,y)		\
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 77f2285..3632cb3 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -560,7 +560,7 @@ __csum_partial_copy_end:
 	 mov	%i0, %o1
 	mov	%i1, %o0
 5:
-	call	__memcpy
+	call	memcpy
 	 mov	%i2, %o2
 	tst	%o0
 	bne,a	2f
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index 704b126..1b30bb3 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -30,7 +30,6 @@ EXPORT_SYMBOL(__memscan_generic);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__bzero);
 
@@ -81,7 +80,6 @@ EXPORT_SYMBOL(__csum_partial_copy_sparc_generic);
 
 /* Special internal versions of library functions. */
 EXPORT_SYMBOL(__copy_1page);
-EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
 EXPORT_SYMBOL(bzero_1page);
 
diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index ce10bc8..34fe657 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -543,9 +543,6 @@ FUNC(memmove)
 	b		3f
 	 add		%o0, 2, %o0
 
-#ifdef __KERNEL__
-FUNC(__memcpy)
-#endif
 FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 
 	sub		%o0, %o1, %o4
diff --git a/arch/sparc/lib/memset.S b/arch/sparc/lib/memset.S
index 1c37ea8..99c017b 100644
--- a/arch/sparc/lib/memset.S
+++ b/arch/sparc/lib/memset.S
@@ -60,11 +60,10 @@
         .globl  __bzero_begin
 __bzero_begin:
 
-	.globl	__bzero, __memset, 
+	.globl	__bzero
 	.globl	memset
 	.globl	__memset_start, __memset_end
 __memset_start:
-__memset:
 memset:
 	and	%o1, 0xff, %g3
 	sll	%g3, 8, %g2
-- 
1.6.5

