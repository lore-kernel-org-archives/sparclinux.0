From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 06 Jan 2015 21:39:59 +0000
Subject: [PATCH] sparc64: minor coding style tweaks
Message-Id: <1420580314-15107-1-git-send-email-mst@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Sam Ravnborg suggested packing single-line cases
in nocheck switch statements makes for easier to
read code.

This is on top of arch/sparc: uaccess_64 macro whitespace fixes
that I sent earlier.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sparc/include/asm/uaccess_64.h | 100 +++++++++++++-----------------------
 1 file changed, 37 insertions(+), 63 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 12d9594..a35194b 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -106,26 +106,16 @@ void __retl_efault(void);
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) ((struct __large_struct *)(x))
 
-#define __put_user_nocheck(data, addr, size) ({ \
-	register int __pu_ret; \
-	switch (size) { \
-	case 1: \
-		__put_user_asm(data, b, addr, __pu_ret); \
-		break; \
-	case 2: \
-		__put_user_asm(data, h, addr, __pu_ret); \
-		break; \
-	case 4: \
-		__put_user_asm(data, w, addr, __pu_ret); \
-		break; \
-	case 8: \
-		__put_user_asm(data, x, addr, __pu_ret); \
-		break; \
-	default: \
-		__pu_ret = __put_user_bad(); \
-		break; \
-	} \
-	__pu_ret; \
+#define __put_user_nocheck(data, addr, size) ({			\
+	register int __pu_ret;					\
+	switch (size) {						\
+	case 1: __put_user_asm(data, b, addr, __pu_ret); break;	\
+	case 2: __put_user_asm(data, h, addr, __pu_ret); break;	\
+	case 4: __put_user_asm(data, w, addr, __pu_ret); break;	\
+	case 8: __put_user_asm(data, x, addr, __pu_ret); break;	\
+	default: __pu_ret = __put_user_bad(); break;		\
+	}							\
+	__pu_ret;						\
 })
 
 #define __put_user_asm(x, size, addr, ret)				\
@@ -150,51 +140,35 @@ __asm__ __volatile__(							\
 
 int __put_user_bad(void);
 
-#define __get_user_nocheck(data, addr, size, type) ({ \
-	register int __gu_ret; \
-	register unsigned long __gu_val; \
-	switch (size) { \
-		case 1: \
-			__get_user_asm(__gu_val, ub, addr, __gu_ret); \
-			break; \
-		case 2: \
-			__get_user_asm(__gu_val, uh, addr, __gu_ret); \
-			break; \
-		case 4: \
-			__get_user_asm(__gu_val, uw, addr, __gu_ret); \
-			break; \
-		case 8: \
-			__get_user_asm(__gu_val, x, addr, __gu_ret); \
-			break; \
-		default: \
-			__gu_val = 0; \
-			__gu_ret = __get_user_bad(); \
-			break; \
-	} \
-	data = (__force type) __gu_val; \
-	 __gu_ret; \
+#define __get_user_nocheck(data, addr, size, type) ({			     \
+	register int __gu_ret;						     \
+	register unsigned long __gu_val;				     \
+	switch (size) {							     \
+		case 1: __get_user_asm(__gu_val, ub, addr, __gu_ret); break; \
+		case 2: __get_user_asm(__gu_val, uh, addr, __gu_ret); break; \
+		case 4: __get_user_asm(__gu_val, uw, addr, __gu_ret); break; \
+		case 8: __get_user_asm(__gu_val, x, addr, __gu_ret); break;  \
+		default:						     \
+			__gu_val = 0;					     \
+			__gu_ret = __get_user_bad();			     \
+			break;						     \
+	} 								     \
+	data = (__force type) __gu_val;					     \
+	 __gu_ret;							     \
 })
 
-#define __get_user_nocheck_ret(data, addr, size, type, retval) ({ \
-	register unsigned long __gu_val __asm__ ("l1"); \
-	switch (size) { \
-	case 1: \
-		__get_user_asm_ret(__gu_val, ub, addr, retval); \
-		break; \
-	case 2: \
-		__get_user_asm_ret(__gu_val, uh, addr, retval); \
-		break; \
-	case 4: \
-		__get_user_asm_ret(__gu_val, uw, addr, retval); \
-		break; \
-	case 8: \
-		__get_user_asm_ret(__gu_val, x, addr, retval); \
-		break; \
-	default: \
-		if (__get_user_bad()) \
-			return retval; \
-	} \
-	data = (__force type) __gu_val; \
+#define __get_user_nocheck_ret(data, addr, size, type, retval) ({	\
+	register unsigned long __gu_val __asm__ ("l1");			\
+	switch (size) {							\
+	case 1: __get_user_asm_ret(__gu_val, ub, addr, retval); break;	\
+	case 2: __get_user_asm_ret(__gu_val, uh, addr, retval); break;	\
+	case 4: __get_user_asm_ret(__gu_val, uw, addr, retval); break;	\
+	case 8: __get_user_asm_ret(__gu_val, x, addr, retval); break;	\
+	default:							\
+		if (__get_user_bad())					\
+			return retval;					\
+	}								\
+	data = (__force type) __gu_val;					\
 })
 
 #define __get_user_asm(x, size, addr, ret)				\
-- 
MST
