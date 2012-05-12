From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 02:59:19 +0000
Subject: [PATCH] sparc32: Remove inline strncmp "optimization" for constant counts.
Message-Id: <20120511.225919.1282830788445310511.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Let the compiler do stuff like this.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I killed this crap a long time ago on sparc64, I should have
done it for sparc32 at the same time.

Commited to sparc-next.

 arch/sparc/include/asm/string_32.h |   63 +-----------------------------------
 arch/sparc/lib/ksyms.c             |    5 ---
 arch/sparc/lib/strncmp_32.S        |    3 +-
 3 files changed, 2 insertions(+), 69 deletions(-)

diff --git a/arch/sparc/include/asm/string_32.h b/arch/sparc/include/asm/string_32.h
index edf196e..12f6785 100644
--- a/arch/sparc/include/asm/string_32.h
+++ b/arch/sparc/include/asm/string_32.h
@@ -61,68 +61,7 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
 extern __kernel_size_t strlen(const char *);
 
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
+extern int strncmp(const char *, const char *, __kernel_size_t);
 
 #endif /* !EXPORT_SYMTAB_STROPS */
 
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index f73c224..1bc8972 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -56,8 +56,6 @@ extern int __divdi3(int, int);
 extern void (*__copy_1page)(void *, const void *);
 extern void (*bzero_1page)(void *);
 
-extern int __strncmp(const char *, const char *, __kernel_size_t);
-
 extern void ___rw_read_enter(void);
 extern void ___rw_read_try(void);
 extern void ___rw_read_exit(void);
@@ -81,9 +79,6 @@ EXPORT_SYMBOL(__copy_1page);
 EXPORT_SYMBOL(__memmove);
 EXPORT_SYMBOL(bzero_1page);
 
-/* string functions */
-EXPORT_SYMBOL(__strncmp);
-
 /* Moving data to/from/in userspace. */
 EXPORT_SYMBOL(__copy_user);
 
diff --git a/arch/sparc/lib/strncmp_32.S b/arch/sparc/lib/strncmp_32.S
index 494ec66..1476f57 100644
--- a/arch/sparc/lib/strncmp_32.S
+++ b/arch/sparc/lib/strncmp_32.S
@@ -5,8 +5,7 @@
 
 	.text
 	.align 4
-	.global __strncmp, strncmp
-__strncmp:
+	.global strncmp
 strncmp:
 	mov	%o0, %g3
 	mov	0, %o3
-- 
1.7.10

