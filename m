From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 07 Jun 2005 03:13:02 +0000
Subject: nuke string.h micro-optimizations from orbit
Message-Id: <20050607031302.GA2621@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I got a bit heavy-handed as suggested and just blew away the whole lot
of macro wrappers etc. I did leave around some of the asm called from
there but am plotting to nuke them as well after making sure we aren't
trying to BTFIXUP code that doesn't exist.

Anyhow, if anyone's up for trying this (I patched vs. 2.6.12-rc5-mm2
but can rediff against 2.6.12-rc6 in the unlikely event it rejects)
I suspect it may help 32B alignment problems, though in principle
we could just perform the alignment checks.

I've not gotten a chance to test this but am seriously thinking of
juryrigging a sparc away from the usual stack and running fresh
cables if the fedex same-day -shipped parts end up taking more than 5
days to arrive, esp. given the recent arch/sparc/ activity. At any
rate it would also help for someone who can actually reproduce the
issue this was meant to resolve could test it.


Index: mm2-2.6.12-rc5/include/asm-sparc/string.h
=================================--- mm2-2.6.12-rc5.orig/include/asm-sparc/string.h	2005-03-01 23:37:30.000000000 -0800
+++ mm2-2.6.12-rc5/include/asm-sparc/string.h	2005-06-06 13:56:53.000000000 -0700
@@ -15,190 +15,20 @@
 
 #ifdef __KERNEL__
 
-extern void __memmove(void *,const void *,__kernel_size_t);
-extern __kernel_size_t __memcpy(void *,const void *,__kernel_size_t);
-extern __kernel_size_t __memset(void *,int,__kernel_size_t);
-
-#ifndef EXPORT_SYMTAB_STROPS
-
-/* First the mem*() things. */
-#define __HAVE_ARCH_MEMMOVE
-#undef memmove
-#define memmove(_to, _from, _n) \
-({ \
-	void *_t = (_to); \
-	__memmove(_t, (_from), (_n)); \
-	_t; \
-})
-
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
-
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
-
+#define __HAVE_ARCH_MEMMOVE
 #define __HAVE_ARCH_MEMSCAN
-
-#undef memscan
-#define memscan(__arg0, __char, __arg2)						\
-({										\
-	extern void *__memscan_zero(void *, size_t);				\
-	extern void *__memscan_generic(void *, int, size_t);			\
-	void *__retval, *__addr = (__arg0);					\
-	size_t __size = (__arg2);						\
-										\
-	if(__builtin_constant_p(__char) && !(__char))				\
-		__retval = __memscan_zero(__addr, __size);			\
-	else									\
-		__retval = __memscan_generic(__addr, (__char), __size);		\
-										\
-	__retval;								\
-})
-
 #define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *,const void *,__kernel_size_t);
-
-/* Now the str*() stuff... */
 #define __HAVE_ARCH_STRLEN
-extern __kernel_size_t strlen(const char *);
-
 #define __HAVE_ARCH_STRNCMP
-
-extern int __strncmp(const char *, const char *, __kernel_size_t);
-
-static inline int __constant_strncmp(const char *src, const char *dest, __kernel_size_t count)
-{
-	register int retval;
-	switch(count) {
-	case 0: return 0;
-	case 1: return (src[0] - dest[0]);
-	case 2: retval = (src[0] - dest[0]);
-		if(!retval && src[0])
-		  retval = (src[1] - dest[1]);
-		return retval;
-	case 3: retval = (src[0] - dest[0]);
-		if(!retval && src[0]) {
-		  retval = (src[1] - dest[1]);
-		  if(!retval && src[1])
-		    retval = (src[2] - dest[2]);
-		}
-		return retval;
-	case 4: retval = (src[0] - dest[0]);
-		if(!retval && src[0]) {
-		  retval = (src[1] - dest[1]);
-		  if(!retval && src[1]) {
-		    retval = (src[2] - dest[2]);
-		    if (!retval && src[2])
-		      retval = (src[3] - dest[3]);
-		  }
-		}
-		return retval;
-	case 5: retval = (src[0] - dest[0]);
-		if(!retval && src[0]) {
-		  retval = (src[1] - dest[1]);
-		  if(!retval && src[1]) {
-		    retval = (src[2] - dest[2]);
-		    if (!retval && src[2]) {
-		      retval = (src[3] - dest[3]);
-		      if (!retval && src[3])
-		        retval = (src[4] - dest[4]);
-		    }
-		  }
-		}
-		return retval;
-	default:
-		retval = (src[0] - dest[0]);
-		if(!retval && src[0]) {
-		  retval = (src[1] - dest[1]);
-		  if(!retval && src[1]) {
-		    retval = (src[2] - dest[2]);
-		    if(!retval && src[2])
-		      retval = __strncmp(src+3,dest+3,count-3);
-		  }
-		}
-		return retval;
-	}
-}
-
-#undef strncmp
-#define strncmp(__arg0, __arg1, __arg2)	\
-(__builtin_constant_p(__arg2) ?	\
- __constant_strncmp(__arg0, __arg1, __arg2) : \
- __strncmp(__arg0, __arg1, __arg2))
- 
-#endif /* !EXPORT_SYMTAB_STROPS */
+void *memcpy(void *, const void *, size_t);
+void *memset(void *, int, size_t);
+void *memmove(void *, const void *, size_t);
+void *memscan(const void *, int, size_t);
+int memcmp(const void *, const void *, size_t);
+size_t strlen(const char *);
+int strncmp(const char *, const char *, size_t);
 
 #endif /* __KERNEL__ */
 
Index: mm2-2.6.12-rc5/arch/sparc/lib/memcmp.S
=================================--- mm2-2.6.12-rc5.orig/arch/sparc/lib/memcmp.S	2005-03-01 23:38:17.000000000 -0800
+++ mm2-2.6.12-rc5/arch/sparc/lib/memcmp.S	2005-06-06 13:57:34.000000000 -0700
@@ -1,7 +1,6 @@
 	.text
 	.align 4
-	.global __memcmp, memcmp
-__memcmp:
+	.global memcmp
 memcmp:
 #if 1
 	cmp	%o2, 0
Index: mm2-2.6.12-rc5/arch/sparc/lib/memcpy.S
=================================--- mm2-2.6.12-rc5.orig/arch/sparc/lib/memcpy.S	2005-03-01 23:38:33.000000000 -0800
+++ mm2-2.6.12-rc5/arch/sparc/lib/memcpy.S	2005-06-06 16:00:09.195879567 -0700
@@ -192,10 +192,6 @@
 	retl
 	 nop		! Only bcopy returns here and it retuns void...
 
-#ifdef __KERNEL__
-FUNC(amemmove)
-FUNC(__memmove)
-#endif
 FUNC(memmove)
 	cmp		%o0, %o1
 	SETUP_RETL
@@ -543,9 +539,7 @@
 	b		3f
 	 add		%o0, 2, %o0
 
-#ifdef __KERNEL__
 FUNC(__memcpy)
-#endif
 FUNC(memcpy)	/* %o0=dst %o1=src %o2=len */
 
 	sub		%o0, %o1, %o4
Index: mm2-2.6.12-rc5/arch/sparc/lib/memset.S
=================================--- mm2-2.6.12-rc5.orig/arch/sparc/lib/memset.S	2005-03-01 23:37:49.000000000 -0800
+++ mm2-2.6.12-rc5/arch/sparc/lib/memset.S	2005-06-06 15:53:02.831696775 -0700
@@ -60,11 +60,9 @@
         .globl  __bzero_begin
 __bzero_begin:
 
-	.globl	__bzero, __memset, 
-	.globl	memset
+	.globl	memset, __bzero
 	.globl	__memset_start, __memset_end
 __memset_start:
-__memset:
 memset:
 	and	%o1, 0xff, %g3
 	sll	%g3, 8, %g2
Index: mm2-2.6.12-rc5/arch/sparc/lib/strncmp.S
=================================--- mm2-2.6.12-rc5.orig/arch/sparc/lib/strncmp.S	2005-03-01 23:37:49.000000000 -0800
+++ mm2-2.6.12-rc5/arch/sparc/lib/strncmp.S	2005-06-06 13:59:17.000000000 -0700
@@ -5,8 +5,7 @@
 
 	.text
 	.align 4
-	.global __strncmp, strncmp
-__strncmp:
+	.global strncmp
 strncmp:
 	mov	%o0, %g3
 	mov	0, %o3
Index: mm2-2.6.12-rc5/arch/sparc/kernel/sparc_ksyms.c
=================================--- mm2-2.6.12-rc5.orig/arch/sparc/kernel/sparc_ksyms.c	2005-06-01 08:11:43.000000000 -0700
+++ mm2-2.6.12-rc5/arch/sparc/kernel/sparc_ksyms.c	2005-06-06 16:02:12.224176423 -0700
@@ -5,8 +5,6 @@
  * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
  */
 
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
 #define PROMLIB_INTERNAL
 
 #include <linux/config.h>
@@ -67,14 +65,6 @@
 extern int svr4_getcontext (svr4_ucontext_t *, struct pt_regs *);
 extern int svr4_setcontext (svr4_ucontext_t *, struct pt_regs *);
 void _sigpause_common (unsigned int set, struct pt_regs *);
-extern void (*__copy_1page)(void *, const void *);
-extern void __memmove(void *, const void *, __kernel_size_t);
-extern void (*bzero_1page)(void *);
-extern void *__bzero(void *, size_t);
-extern void *__memscan_zero(void *, size_t);
-extern void *__memscan_generic(void *, int, size_t);
-extern int __memcmp(const void *, const void *, __kernel_size_t);
-extern int __strncmp(const char *, const char *, __kernel_size_t);
 
 extern int __ashrdi3(int, int);
 extern int __ashldi3(int, int);
@@ -293,18 +283,14 @@
 EXPORT_SYMBOL(page_kernel);
 
 /* Special internal versions of library functions. */
-EXPORT_SYMBOL(__copy_1page);
-EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(bzero_1page);
-EXPORT_SYMBOL(__bzero);
-EXPORT_SYMBOL(__memscan_zero);
-EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(__memcmp);
-EXPORT_SYMBOL(__strncmp);
-EXPORT_SYMBOL(__memmove);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memmove);
 
 /* Moving data to/from userspace. */
+void *__bzero(void *, size_t);
+EXPORT_SYMBOL(__bzero);		/* kill me */
 EXPORT_SYMBOL(__copy_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 
@@ -320,10 +306,6 @@
 
 EXPORT_SYMBOL(__ret_efault);
 
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__lshrdi3);
