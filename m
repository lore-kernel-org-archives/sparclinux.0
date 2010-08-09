From: David Miller <davem@davemloft.net>
Date: Mon, 09 Aug 2010 09:25:39 +0000
Subject: [PATCH] sparc: Kill user copy check code.
Message-Id: <20100809.022539.24574396.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


For whatever reason GCC isn't able to figure things out in
the control flow (in particular when min() and max() expressions
are involved) on sparc as well as it can on x86.

So lots of useless incorrect user copy warnings get spewed and the
full-on compile failure mode of the user copy checks were never usable
on sparc at all.

People can debug these kinds of problems on x86.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig.debug            |   14 --------------
 arch/sparc/include/asm/uaccess_32.h |   15 ---------------
 arch/sparc/include/asm/uaccess_64.h |   23 +++++------------------
 3 files changed, 5 insertions(+), 47 deletions(-)

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 1b4a831..d9a795e 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -30,18 +30,4 @@ config FRAME_POINTER
 	depends on MCOUNT
 	default y
 
-config DEBUG_STRICT_USER_COPY_CHECKS
-	bool "Strict copy size checks"
-	depends on DEBUG_KERNEL && !TRACE_BRANCH_PROFILING
-	---help---
-	  Enabling this option turns a certain set of sanity checks for user
-	  copy operations into compile time failures.
-
-	  The copy_from_user() etc checks are there to help test if there
-	  are sufficient security checks on the length argument of
-	  the copy operation, by having gcc prove that the argument is
-	  within bounds.
-
-	  If unsure, or if you run an older (pre 4.4) gcc, say N.
-
 endmenu
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index 25f1d10..8303ac4 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -260,23 +260,8 @@ static inline unsigned long __copy_to_user(void __user *to, const void *from, un
 	return __copy_user(to, (__force void __user *) from, n);
 }
 
-extern void copy_from_user_overflow(void)
-#ifdef CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
-	__compiletime_error("copy_from_user() buffer size is not provably correct")
-#else
-	__compiletime_warning("copy_from_user() buffer size is not provably correct")
-#endif
-;
-
 static inline unsigned long copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	int sz = __compiletime_object_size(to);
-
-	if (unlikely(sz != -1 && sz < n)) {
-		copy_from_user_overflow();
-		return n;
-	}
-
 	if (n && __access_ok((unsigned long) from, n))
 		return __copy_user((__force void __user *) to, from, n);
 	else
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 2406788..3e1449f 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -205,14 +205,6 @@ __asm__ __volatile__(							\
 
 extern int __get_user_bad(void);
 
-extern void copy_from_user_overflow(void)
-#ifdef CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
-	__compiletime_error("copy_from_user() buffer size is not provably correct")
-#else
-	__compiletime_warning("copy_from_user() buffer size is not provably correct")
-#endif
-;
-
 extern unsigned long __must_check ___copy_from_user(void *to,
 						    const void __user *from,
 						    unsigned long size);
@@ -221,16 +213,11 @@ extern unsigned long copy_from_user_fixup(void *to, const void __user *from,
 static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long size)
 {
-	int sz = __compiletime_object_size(to);
-	unsigned long ret = size;
-
-	if (likely(sz = -1 || sz >= size)) {
-		ret = ___copy_from_user(to, from, size);
-		if (unlikely(ret))
-			ret = copy_from_user_fixup(to, from, size);
-	} else {
-		copy_from_user_overflow();
-	}
+	unsigned long ret = ___copy_from_user(to, from, size);
+
+	if (unlikely(ret))
+		ret = copy_from_user_fixup(to, from, size);
+
 	return ret;
 }
 #define __copy_from_user copy_from_user
-- 
1.7.2.1

