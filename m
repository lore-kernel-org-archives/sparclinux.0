From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 21 Dec 2004 06:28:38 +0000
Subject: Re: [4/3] fix initrd memcpy
Message-Id: <20041220222838.2fb3639a.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221045627.GC771@holomorphy.com>
In-Reply-To: <20041221045627.GC771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 20 Dec 2004 20:56:27 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> The latter hunk of the forwarded patch has already been applied, so
> please apply the patch as it appears in the un-forwarded part. I've
> taken some liberties in adding the Acked/Signed-off lines in what I
> hope is an agreeable way.

For this one it may be advisable to kill this silly attempt
to optimize constant count memcpy()'s.  GCC knows very well
when to do a __builtin_memcpy() expansion vs. a real memcpy
call.

All the memcpy --> __memcpy is doing is making it so that the
memcpy assembler doesn't need to retain and return the original
destination pointer argument.

Sparc64 was doing silly stuff like this too, and it simplified
things a lot to just kill all of these macroized optimizations.
I did that as follows:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/27 12:55:12-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: Kill all this silly inline memcpy handling.
#   
#   GCC does this well enough.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# include/asm-sparc64/string.h
#   2004/07/27 12:54:49-07:00 davem@nuts.davemloft.net +1 -25
#   [SPARC64]: Kill all this silly inline memcpy handling.
#   
#   GCC does this well enough.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# include/asm-sparc64/page.h
#   2004/07/27 12:54:49-07:00 davem@nuts.davemloft.net +1 -1
#   [SPARC64]: Kill all this silly inline memcpy handling.
#   
#   GCC does this well enough.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# arch/sparc64/lib/VIScopy.S
#   2004/07/27 12:54:49-07:00 davem@nuts.davemloft.net +0 -4
#   [SPARC64]: Kill all this silly inline memcpy handling.
#   
#   GCC does this well enough.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# arch/sparc64/kernel/sparc64_ksyms.c
#   2004/07/27 12:54:49-07:00 davem@nuts.davemloft.net +0 -1
#   [SPARC64]: Kill all this silly inline memcpy handling.
#   
#   GCC does this well enough.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
diff -Nru a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
--- a/arch/sparc64/kernel/sparc64_ksyms.c	2004-12-20 22:06:27 -08:00
+++ b/arch/sparc64/kernel/sparc64_ksyms.c	2004-12-20 22:06:27 -08:00
@@ -334,7 +334,6 @@
 #endif
 
 /* Special internal versions of library functions. */
-EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(_clear_page);
 EXPORT_SYMBOL(clear_user_page);
diff -Nru a/arch/sparc64/lib/VIScopy.S b/arch/sparc64/lib/VIScopy.S
--- a/arch/sparc64/lib/VIScopy.S	2004-12-20 22:06:27 -08:00
+++ b/arch/sparc64/lib/VIScopy.S	2004-12-20 22:06:27 -08:00
@@ -306,11 +306,7 @@
 		.globl			__memcpy_begin
 __memcpy_begin:
 
-		.globl			__memcpy
-		.type			__memcpy,@function
-
 memcpy_private:
-__memcpy:
 memcpy:		mov		ASI_P, asi_src			! IEU0	Group
 		brnz,pt		%o2, __memcpy_entry		! CTI
 		 mov		ASI_P, asi_dest			! IEU1
diff -Nru a/include/asm-sparc64/page.h b/include/asm-sparc64/page.h
--- a/include/asm-sparc64/page.h	2004-12-20 22:06:27 -08:00
+++ b/include/asm-sparc64/page.h	2004-12-20 22:06:27 -08:00
@@ -18,7 +18,7 @@
 #define clear_page(X)	_clear_page((void *)(X))
 struct page;
 extern void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
-#define copy_page(X,Y)	__memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
+#define copy_page(X,Y)	memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
 extern void copy_user_page(void *to, void *from, unsigned long vaddr, struct page *topage);
 
 /* GROSS, defining this makes gcc pass these types as aggregates,
diff -Nru a/include/asm-sparc64/string.h b/include/asm-sparc64/string.h
--- a/include/asm-sparc64/string.h	2004-12-20 22:06:27 -08:00
+++ b/include/asm-sparc64/string.h	2004-12-20 22:06:27 -08:00
@@ -16,9 +16,7 @@
 #include <asm/asi.h>
 
 extern void __memmove(void *,const void *,__kernel_size_t);
-extern __kernel_size_t __memcpy(void *,const void *,__kernel_size_t);
 extern void *__memset(void *,int,__kernel_size_t);
-extern void *__builtin_memcpy(void *,const void *,__kernel_size_t);
 extern void *__builtin_memset(void *,int,__kernel_size_t);
 
 #ifndef EXPORT_SYMTAB_STROPS
@@ -37,29 +35,7 @@
 
 #define __HAVE_ARCH_MEMCPY
 
-static inline void *__constant_memcpy(void *to, const void *from, __kernel_size_t n)
-{
-	if(n) {
-		if(n <= 32) {
-			__builtin_memcpy(to, from, n);
-		} else {
-			__memcpy(to, from, n);
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
+extern void * memcpy(void *,const void *,__kernel_size_t);
 
 #define __HAVE_ARCH_MEMSET
 
