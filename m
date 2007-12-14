From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 14 Dec 2007 14:37:15 +0000
Subject: [PATCH] Silence sparc32 warnings on missing syscalls
Message-Id: <20071214143715.GA1434@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Silence sparc32 warnings on missing syscalls, these won't be added.
This patch is based on this mail:
http://www.mail-archive.com/linux-arch@vger.kernel.org/msg02571.html

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: 2.6/include/asm-sparc/unistd.h
=================================--- 2.6.orig/include/asm-sparc/unistd.h	2007-12-13 18:09:39.000000000 +0000
+++ 2.6/include/asm-sparc/unistd.h	2007-12-13 18:12:09.000000000 +0000
@@ -333,6 +333,15 @@
 
 #define NR_SYSCALLS		315
 
+/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
+ * it never had the plain ones and there is no value to adding those
+ * old versions into the syscall table.
+ */
+#define __IGNORE_setresuid
+#define __IGNORE_getresuid
+#define __IGNORE_setresgid
+#define __IGNORE_getresgid
+
 #ifdef __KERNEL__
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
