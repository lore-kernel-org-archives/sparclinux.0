From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 04 Sep 2018 04:53:24 +0000
Subject: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
Message-Id: <1536036087-15260-2-git-send-email-firoz.khan@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org

All the  __IGNORE* entries are resides in the uapi header
file and it is not used by any user space applications.

One of the patch in this patch series will generate the
uapi header file and system call table file. So if we move
all the __IGNORE* entries to non uapi header, it will simplify
the uapi header and system call table file generation script.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 25 +++++++++++++++++++++++++
 arch/sparc/include/uapi/asm/unistd.h | 25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a95..f120b6b 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -17,6 +17,12 @@
 
 #include <uapi/asm/unistd.h>
 
+#ifndef __32bit_syscall_numbers__
+#ifndef __arch64__
+#define __32bit_syscall_numbers__
+#endif
+#endif
+
 #ifdef __32bit_syscall_numbers__
 #else
 #define __NR_time		231 /* Linux sparc32                               */
@@ -45,4 +51,23 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
+/* Bitmask values returned from kern_features system call.  */
+#define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
+
+#ifdef __32bit_syscall_numbers__
+/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
+ * it never had the plain ones and there is no value to adding those
+ * old versions into the syscall table.
+ */
+#define __IGNORE_setresuid
+#define __IGNORE_getresuid
+#define __IGNORE_setresgid
+#define __IGNORE_getresgid
+#endif
+
+/* Sparc doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 09acf0d..ccf4bea 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -15,12 +15,6 @@
 #ifndef _UAPI_SPARC_UNISTD_H
 #define _UAPI_SPARC_UNISTD_H
 
-#ifndef __32bit_syscall_numbers__
-#ifndef __arch64__
-#define __32bit_syscall_numbers__
-#endif
-#endif
-
 #define __NR_restart_syscall      0 /* Linux Specific				   */
 #define __NR_exit                 1 /* Common                                      */
 #define __NR_fork                 2 /* Common                                      */
@@ -430,23 +424,4 @@
 
 #define NR_syscalls		361
 
-/* Bitmask values returned from kern_features system call.  */
-#define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
-
-#ifdef __32bit_syscall_numbers__
-/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
- * it never had the plain ones and there is no value to adding those
- * old versions into the syscall table.
- */
-#define __IGNORE_setresuid
-#define __IGNORE_getresuid
-#define __IGNORE_setresgid
-#define __IGNORE_getresgid
-#endif
-
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_SPARC_UNISTD_H */
-- 
1.9.1
