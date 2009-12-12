From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:37 +0000
Subject: [PATCH 4/10]: sparc: Use __builtin_object_size() to validate the
Message-Id: <20091211.225537.189724151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This mirrors x86 commit 9f0cf4adb6aa0bfccf675c938124e68f7f06349d
(x86: Use __builtin_object_size() to validate the buffer size for copy_from_user())

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig.debug            |   14 ++++++++++++++
 arch/sparc/include/asm/uaccess_32.h |   15 +++++++++++++++
 arch/sparc/include/asm/uaccess_64.h |   23 +++++++++++++++++++----
 arch/sparc/lib/Makefile             |    1 +
 arch/sparc/lib/usercopy.c           |    8 ++++++++
 5 files changed, 57 insertions(+), 4 deletions(-)
 create mode 100644 arch/sparc/lib/usercopy.c

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 90d5fe2..9d3c889 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -33,4 +33,18 @@ config FRAME_POINTER
 	depends on MCOUNT
 	default y
 
+config DEBUG_STRICT_USER_COPY_CHECKS
+	bool "Strict copy size checks"
+	depends on DEBUG_KERNEL && !TRACE_BRANCH_PROFILING
+	---help---
+	  Enabling this option turns a certain set of sanity checks for user
+	  copy operations into compile time failures.
+
+	  The copy_from_user() etc checks are there to help test if there
+	  are sufficient security checks on the length argument of
+	  the copy operation, by having gcc prove that the argument is
+	  within bounds.
+
+	  If unsure, or if you run an older (pre 4.4) gcc, say N.
+
 endmenu
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index 8303ac4..489d2ba 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -260,8 +260,23 @@ static inline unsigned long __copy_to_user(void __user *to, const void *from, un
 	return __copy_user(to, (__force void __user *) from, n);
 }
 
+extern void copy_from_user_overflow(void)
+#ifdef CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
+	__compiletime_error("copy_from_user() buffer size is not provably correct")
+#else
+	__compiletime_warning("copy_from_user() buffer size is not provably correct")
+#endif
+;
+
 static inline unsigned long copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	int sz = __compiletime_object_size(to);
+
+	if (unlikely(sz != -1 && sz < n)) {
+		copy_from_user_overflow();
+		return -EFAULT;
+	}
+
 	if (n && __access_ok((unsigned long) from, n))
 		return __copy_user((__force void __user *) to, from, n);
 	else
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 9ea271e..dbc1416 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -6,6 +6,7 @@
  */
 
 #ifdef __KERNEL__
+#include <linux/errno.h>
 #include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/thread_info.h>
@@ -204,6 +205,14 @@ __asm__ __volatile__(							\
 
 extern int __get_user_bad(void);
 
+extern void copy_from_user_overflow(void)
+#ifdef CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
+	__compiletime_error("copy_from_user() buffer size is not provably correct")
+#else
+	__compiletime_warning("copy_from_user() buffer size is not provably correct")
+#endif
+;
+
 extern unsigned long __must_check ___copy_from_user(void *to,
 						    const void __user *from,
 						    unsigned long size);
@@ -212,10 +221,16 @@ extern unsigned long copy_from_user_fixup(void *to, const void __user *from,
 static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long size)
 {
-	unsigned long ret = ___copy_from_user(to, from, size);
-
-	if (unlikely(ret))
-		ret = copy_from_user_fixup(to, from, size);
+	unsigned long ret = (unsigned long) -EFAULT;
+	int sz = __compiletime_object_size(to);
+
+	if (likely(sz = -1 || sz >= size)) {
+		ret = ___copy_from_user(to, from, size);
+		if (unlikely(ret))
+			ret = copy_from_user_fixup(to, from, size);
+	} else {
+		copy_from_user_overflow();
+	}
 	return ret;
 }
 #define __copy_from_user copy_from_user
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index e75faf0..c4b5e03 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -44,3 +44,4 @@ obj-y                 += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o
 obj-y                 += ksyms.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
+obj-y                 += usercopy.o
diff --git a/arch/sparc/lib/usercopy.c b/arch/sparc/lib/usercopy.c
new file mode 100644
index 0000000..14b363f
--- /dev/null
+++ b/arch/sparc/lib/usercopy.c
@@ -0,0 +1,8 @@
+#include <linux/module.h>
+#include <linux/bug.h>
+
+void copy_from_user_overflow(void)
+{
+	WARN(1, "Buffer overflow detected!\n");
+}
+EXPORT_SYMBOL(copy_from_user_overflow);
-- 
1.6.5

