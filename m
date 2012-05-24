From: David Miller <davem@davemloft.net>
Date: Thu, 24 May 2012 20:26:13 +0000
Subject: [PATCH 1/3 v2] sparc: Increase portability of strncpy_from_user() implementation.
Message-Id: <20120524.162613.256050233513717246.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: sparclinux@vger.kernel.org


Hide details of maximum user address calculation in a new
asm/uaccess.h interface named user_addr_max().

Provide little-endian implementation in find_zero(), which should work
but can probably be improved.

Abstrace alignment check behind IS_UNALIGNED() macro.

Kill double-semicolon, noticed by David Howells.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess.h |    3 +++
 arch/sparc/lib/usercopy.c        |   32 +++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess.h b/arch/sparc/include/asm/uaccess.h
index 42a28cf..20c2acb 100644
--- a/arch/sparc/include/asm/uaccess.h
+++ b/arch/sparc/include/asm/uaccess.h
@@ -6,6 +6,9 @@
 #include <asm/uaccess_32.h>
 #endif
 
+#define user_addr_max() \
+	(segment_eq(get_fs(), USER_DS) ? STACK_TOP : ~0UL)
+
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 #endif
diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
index 87f9645..f61ed82 100644
--- a/arch/sparc/lib/usercopy.c
+++ b/arch/sparc/lib/usercopy.c
@@ -3,6 +3,8 @@
 #include <linux/errno.h>
 #include <linux/bug.h>
 
+#include <asm/byteorder.h>
+
 void copy_from_user_overflow(void)
 {
 	WARN(1, "Buffer overflow detected!\n");
@@ -14,6 +16,8 @@ EXPORT_SYMBOL(copy_from_user_overflow);
 static inline long find_zero(unsigned long mask)
 {
 	long byte = 0;
+
+#ifdef __BIG_ENDIAN
 #ifdef CONFIG_64BIT
 	if (mask >> 32)
 		mask >>= 32;
@@ -25,8 +29,28 @@ static inline long find_zero(unsigned long mask)
 	else
 		byte += 2;
 	return (mask >> 8) ? byte : byte + 1;
+#else
+#ifdef CONFIG_64BIT
+	if (!((unsigned int) mask)) {
+		mask >>= 32;
+		byte = 4;
+	}
+#endif
+	if (!(mask & 0xffff)) {
+		mask >>= 16;
+		byte += 2;
+	}
+	return (mask & 0xff) ? byte : byte + 1;
+#endif
 }
 
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#define IS_UNALIGNED(src, dst)	0
+#else
+#define IS_UNALIGNED(src, dst)	\
+	(((long) dst | (long) src) & (sizeof(long) - 1))
+#endif
+
 /*
  * Do a strncpy, return length of string without final '\0'.
  * 'count' is the user-supplied count (return 'count' if we
@@ -46,7 +70,7 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
 	if (max > count)
 		max = count;
 
-	if (((long) dst | (long) src) & (sizeof(long) - 1))
+	if (IS_UNALIGNED(src, dst))
 		goto byte_at_a_time;
 
 	while (max >= sizeof(unsigned long)) {
@@ -59,7 +83,7 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
 		v = (c + high_bits) & ~rhs;
 		*(unsigned long *)(dst+res) = c;
 		if (v) {
-			v = (c & low_bits) + low_bits;;
+			v = (c & low_bits) + low_bits;
 			v = ~(v | rhs);
 			return res + find_zero(v);
 		}
@@ -119,9 +143,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
-	max_addr = ~0UL;
-	if (likely(segment_eq(get_fs(), USER_DS)))
-		max_addr = STACK_TOP;
+	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
-- 
1.7.10

