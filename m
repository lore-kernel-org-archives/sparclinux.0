From: David Miller <davem@davemloft.net>
Date: Thu, 24 May 2012 20:26:31 +0000
Subject: [PATCH 3/3 v2] lib: Sparc's strncpy_from_user is generic enough, move under lib/
Message-Id: <20120524.162631.2253252012139157291.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: sparclinux@vger.kernel.org


To use this, an architecture simply needs to:

1) Provide a user_addr_max() implementation via asm/uaccess.h

2) Add "select GENERIC_STRNCPY_FROM_USER" to their arch Kcnfig

3) Remove the existing strncpy_from_user() implementation and symbol
   exports their architecture had.

Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: David Howells <dhowells@redhat.com>
---
 arch/sparc/Kconfig        |    1 +
 arch/sparc/lib/usercopy.c |  144 --------------------------------------------
 lib/Kconfig               |    3 +
 lib/Makefile              |    2 +
 lib/strncpy_from_user.c   |  146 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 144 deletions(-)
 create mode 100644 lib/strncpy_from_user.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 051af37..2247423 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -32,6 +32,7 @@ config SPARC
 	select HAVE_NMI_WATCHDOG if SPARC64
 	select HAVE_BPF_JIT
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
index 0b12e91..5c4284c 100644
--- a/arch/sparc/lib/usercopy.c
+++ b/arch/sparc/lib/usercopy.c
@@ -1,153 +1,9 @@
 #include <linux/module.h>
-#include <linux/uaccess.h>
 #include <linux/kernel.h>
-#include <linux/errno.h>
 #include <linux/bug.h>
 
-#include <asm/byteorder.h>
-
 void copy_from_user_overflow(void)
 {
 	WARN(1, "Buffer overflow detected!\n");
 }
 EXPORT_SYMBOL(copy_from_user_overflow);
-
-static inline long find_zero(unsigned long mask)
-{
-	long byte = 0;
-
-#ifdef __BIG_ENDIAN
-#ifdef CONFIG_64BIT
-	if (mask >> 32)
-		mask >>= 32;
-	else
-		byte = 4;
-#endif
-	if (mask >> 16)
-		mask >>= 16;
-	else
-		byte += 2;
-	return (mask >> 8) ? byte : byte + 1;
-#else
-#ifdef CONFIG_64BIT
-	if (!((unsigned int) mask)) {
-		mask >>= 32;
-		byte = 4;
-	}
-#endif
-	if (!(mask & 0xffff)) {
-		mask >>= 16;
-		byte += 2;
-	}
-	return (mask & 0xff) ? byte : byte + 1;
-#endif
-}
-
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-#define IS_UNALIGNED(src, dst)	0
-#else
-#define IS_UNALIGNED(src, dst)	\
-	(((long) dst | (long) src) & (sizeof(long) - 1))
-#endif
-
-/*
- * Do a strncpy, return length of string without final '\0'.
- * 'count' is the user-supplied count (return 'count' if we
- * hit it), 'max' is the address space maximum (and we return
- * -EFAULT if we hit it).
- */
-static inline long do_strncpy_from_user(char *dst, const char __user *src, long count, unsigned long max)
-{
-	const unsigned long high_bits = REPEAT_BYTE(0xfe) + 1;
-	const unsigned long low_bits = REPEAT_BYTE(0x7f);
-	long res = 0;
-
-	/*
-	 * Truncate 'max' to the user-specified limit, so that
-	 * we only have one limit we need to check in the loop
-	 */
-	if (max > count)
-		max = count;
-
-	if (IS_UNALIGNED(src, dst))
-		goto byte_at_a_time;
-
-	while (max >= sizeof(unsigned long)) {
-		unsigned long c, v, rhs;
-
-		/* Fall back to byte-at-a-time if we get a page fault */
-		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
-			break;
-		rhs = c | low_bits;
-		v = (c + high_bits) & ~rhs;
-		*(unsigned long *)(dst+res) = c;
-		if (v) {
-			v = (c & low_bits) + low_bits;
-			v = ~(v | rhs);
-			return res + find_zero(v);
-		}
-		res += sizeof(unsigned long);
-		max -= sizeof(unsigned long);
-	}
-
-byte_at_a_time:
-	while (max) {
-		char c;
-
-		if (unlikely(__get_user(c,src+res)))
-			return -EFAULT;
-		dst[res] = c;
-		if (!c)
-			return res;
-		res++;
-		max--;
-	}
-
-	/*
-	 * Uhhuh. We hit 'max'. But was that the user-specified maximum
-	 * too? If so, that's ok - we got as much as the user asked for.
-	 */
-	if (res >= count)
-		return res;
-
-	/*
-	 * Nope: we hit the address space limit, and we still had more
-	 * characters the caller would have wanted. That's an EFAULT.
-	 */
-	return -EFAULT;
-}
-
-/**
- * strncpy_from_user: - Copy a NUL terminated string from userspace.
- * @dst:   Destination address, in kernel space.  This buffer must be at
- *         least @count bytes long.
- * @src:   Source address, in user space.
- * @count: Maximum number of bytes to copy, including the trailing NUL.
- *
- * Copies a NUL-terminated string from userspace to kernel space.
- *
- * On success, returns the length of the string (not including the trailing
- * NUL).
- *
- * If access to userspace fails, returns -EFAULT (some data may have been
- * copied).
- *
- * If @count is smaller than the length of the string, copies @count bytes
- * and returns @count.
- */
-long strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	unsigned long max_addr, src_addr;
-
-	if (unlikely(count <= 0))
-		return 0;
-
-	max_addr = user_addr_max();
-	src_addr = (unsigned long)src;
-	if (likely(src_addr < max_addr)) {
-		unsigned long max = max_addr - src_addr;
-		return do_strncpy_from_user(dst, src, count, max);
-	}
-	return -EFAULT;
-}
-EXPORT_SYMBOL(strncpy_from_user);
diff --git a/lib/Kconfig b/lib/Kconfig
index 4a8aba2..49cb463 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -16,6 +16,9 @@ config BITREVERSE
 config RATIONAL
 	boolean
 
+config GENERIC_STRNCPY_FROM_USER
+	bool
+
 config GENERIC_FIND_FIRST_BIT
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 18515f0..57538b4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -123,6 +123,8 @@ obj-$(CONFIG_SIGNATURE) += digsig.o
 
 obj-$(CONFIG_CLZ_TAB) += clz_tab.o
 
+obj-$(CONFIG_GENERIC_STRNCPY_FROM_USER) += strncpy_from_user.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
new file mode 100644
index 0000000..c4c09b0
--- /dev/null
+++ b/lib/strncpy_from_user.c
@@ -0,0 +1,146 @@
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+
+#include <asm/byteorder.h>
+
+static inline long find_zero(unsigned long mask)
+{
+	long byte = 0;
+
+#ifdef __BIG_ENDIAN
+#ifdef CONFIG_64BIT
+	if (mask >> 32)
+		mask >>= 32;
+	else
+		byte = 4;
+#endif
+	if (mask >> 16)
+		mask >>= 16;
+	else
+		byte += 2;
+	return (mask >> 8) ? byte : byte + 1;
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
+}
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#define IS_UNALIGNED(src, dst)	0
+#else
+#define IS_UNALIGNED(src, dst)	\
+	(((long) dst | (long) src) & (sizeof(long) - 1))
+#endif
+
+/*
+ * Do a strncpy, return length of string without final '\0'.
+ * 'count' is the user-supplied count (return 'count' if we
+ * hit it), 'max' is the address space maximum (and we return
+ * -EFAULT if we hit it).
+ */
+static inline long do_strncpy_from_user(char *dst, const char __user *src, long count, unsigned long max)
+{
+	const unsigned long high_bits = REPEAT_BYTE(0xfe) + 1;
+	const unsigned long low_bits = REPEAT_BYTE(0x7f);
+	long res = 0;
+
+	/*
+	 * Truncate 'max' to the user-specified limit, so that
+	 * we only have one limit we need to check in the loop
+	 */
+	if (max > count)
+		max = count;
+
+	if (IS_UNALIGNED(src, dst))
+		goto byte_at_a_time;
+
+	while (max >= sizeof(unsigned long)) {
+		unsigned long c, v, rhs;
+
+		/* Fall back to byte-at-a-time if we get a page fault */
+		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
+			break;
+		rhs = c | low_bits;
+		v = (c + high_bits) & ~rhs;
+		*(unsigned long *)(dst+res) = c;
+		if (v) {
+			v = (c & low_bits) + low_bits;
+			v = ~(v | rhs);
+			return res + find_zero(v);
+		}
+		res += sizeof(unsigned long);
+		max -= sizeof(unsigned long);
+	}
+
+byte_at_a_time:
+	while (max) {
+		char c;
+
+		if (unlikely(__get_user(c,src+res)))
+			return -EFAULT;
+		dst[res] = c;
+		if (!c)
+			return res;
+		res++;
+		max--;
+	}
+
+	/*
+	 * Uhhuh. We hit 'max'. But was that the user-specified maximum
+	 * too? If so, that's ok - we got as much as the user asked for.
+	 */
+	if (res >= count)
+		return res;
+
+	/*
+	 * Nope: we hit the address space limit, and we still had more
+	 * characters the caller would have wanted. That's an EFAULT.
+	 */
+	return -EFAULT;
+}
+
+/**
+ * strncpy_from_user: - Copy a NUL terminated string from userspace.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ *
+ * Copies a NUL-terminated string from userspace to kernel space.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
+long strncpy_from_user(char *dst, const char __user *src, long count)
+{
+	unsigned long max_addr, src_addr;
+
+	if (unlikely(count <= 0))
+		return 0;
+
+	max_addr = user_addr_max();
+	src_addr = (unsigned long)src;
+	if (likely(src_addr < max_addr)) {
+		unsigned long max = max_addr - src_addr;
+		return do_strncpy_from_user(dst, src, count, max);
+	}
+	return -EFAULT;
+}
+EXPORT_SYMBOL(strncpy_from_user);
-- 
1.7.10

