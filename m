From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 07:00:25 +0000
Subject: Re: [4/3] fix initrd memcpy
Message-Id: <20041221070025.GG771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221045627.GC771@holomorphy.com>
In-Reply-To: <20041221045627.GC771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 20, 2004 at 10:39:01PM -0800, William Lee Irwin III wrote:
> This looks tremendously cleaner. I'll look for an ack to see if there
> are actively participating users lingering about with toolchains that
> do something unintelligible out of paranoia and then send an analogue
> of this upstream.

tentative sparc32 analogue (not booted it yet):

Acked-by: William Irwin  <wli@holomorphy.com>
Signed-off-by: Dave Miller  <davem@davemloft.net>
Signed-off-by: Jurij Smakov <jurij@wooyd.org>

Index: sparc32-2.6.10-rc3/include/asm-sparc/string.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/string.h	2004-06-15 22:18:38.000000000 -0700
+++ sparc32-2.6.10-rc3/include/asm-sparc/string.h	2004-12-20 22:50:52.891373098 -0800
@@ -16,7 +16,7 @@
 #ifdef __KERNEL__
 
 extern void __memmove(void *,const void *,__kernel_size_t);
-extern __kernel_size_t __memcpy(void *,const void *,__kernel_size_t);
+void *memcpy(void *,const void *,__kernel_size_t);
 extern __kernel_size_t __memset(void *,int,__kernel_size_t);
 
 #ifndef EXPORT_SYMTAB_STROPS
@@ -33,38 +33,6 @@
 })
 
 #define __HAVE_ARCH_MEMCPY
-
-static inline void *__constant_memcpy(void *to, const void *from, __kernel_size_t n)
-{
-	extern void __copy_1page(void *, const void *);
-
-	if(n <= 32) {
-		__builtin_memcpy(to, from, n);
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
-
 #define __HAVE_ARCH_MEMSET
 
 static inline void *__constant_c_and_count_memset(void *s, char c, __kernel_size_t count)
Index: sparc32-2.6.10-rc3/arch/sparc/lib/checksum.S
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/lib/checksum.S	2004-06-15 22:19:36.000000000 -0700
+++ sparc32-2.6.10-rc3/arch/sparc/lib/checksum.S	2004-12-20 22:40:19.814615394 -0800
@@ -560,7 +560,7 @@
 	 mov	%i0, %o1
 	mov	%i1, %o0
 5:
-	call	__memcpy
+	call	memcpy
 	 mov	%i2, %o2
 	tst	%o0
 	bne,a	2f
Index: sparc32-2.6.10-rc3/arch/sparc/kernel/sparc_ksyms.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/kernel/sparc_ksyms.c	2004-11-17 02:25:41.000000000 -0800
+++ sparc32-2.6.10-rc3/arch/sparc/kernel/sparc_ksyms.c	2004-12-20 22:44:37.788397418 -0800
@@ -280,7 +280,6 @@
 
 /* Special internal versions of library functions. */
 EXPORT_SYMBOL(__copy_1page);
-EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(bzero_1page);
 EXPORT_SYMBOL(__bzero);
Index: sparc32-2.6.10-rc3/arch/sparc/lib/memcpy.S
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/lib/memcpy.S	2004-10-07 04:01:27.000000000 -0700
+++ sparc32-2.6.10-rc3/arch/sparc/lib/memcpy.S	2004-12-20 22:40:46.813510938 -0800
@@ -550,9 +550,6 @@
 	b		3f
 	 add		%o0, 2, %o0
 
-#ifdef __KERNEL__
-FUNC(__memcpy)
-#endif
 FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 
 	sub		%o0, %o1, %o4
