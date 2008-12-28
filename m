From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Dec 2008 20:04:18 +0000
Subject: [PATCH] sparc: unify ipcbuf.h
Message-Id: <20081228200418.GA22991@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Looking closer the two structures only differed on the
size of __kernel_umode_t.
Add a sparc32 specific padding to cover this difference.

The other types had same size on sparc32 and sparc64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild      |    2 --
 arch/sparc/include/asm/ipcbuf.h    |   36 ++++++++++++++++++++++++++++++------
 arch/sparc/include/asm/ipcbuf_32.h |   31 -------------------------------
 arch/sparc/include/asm/ipcbuf_64.h |   28 ----------------------------
 4 files changed, 30 insertions(+), 67 deletions(-)
 delete mode 100644 arch/sparc/include/asm/ipcbuf_32.h
 delete mode 100644 arch/sparc/include/asm/ipcbuf_64.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 89c260a..b938232 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,8 +1,6 @@
 # User exported sparc header files
 include include/asm-generic/Kbuild.asm
 
-header-y += ipcbuf_32.h
-header-y += ipcbuf_64.h
 header-y += posix_types_32.h
 header-y += posix_types_64.h
 header-y += ptrace_32.h
diff --git a/arch/sparc/include/asm/ipcbuf.h b/arch/sparc/include/asm/ipcbuf.h
index 17d6ef7..1e8d84f 100644
--- a/arch/sparc/include/asm/ipcbuf.h
+++ b/arch/sparc/include/asm/ipcbuf.h
@@ -1,8 +1,32 @@
-#ifndef ___ASM_SPARC_IPCBUF_H
-#define ___ASM_SPARC_IPCBUF_H
+#ifndef __SPARC_IPCBUF_H
+#define __SPARC_IPCBUF_H
+
+/*
+ * The ipc64_perm structure for sparc architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32 bit mode (only sparc32, it is 32 bit on sparc64)
+ * - 32-bit seq
+ * - 2 miscellaneous 64-bit values
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t	key;
+	__kernel_uid_t	uid;
+	__kernel_gid_t	gid;
+	__kernel_uid_t	cuid;
+	__kernel_gid_t	cgid;
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm/ipcbuf_64.h>
-#else
-#include <asm/ipcbuf_32.h>
-#endif
+	unsigned short __pad0;
 #endif
+	__kernel_mode_t	mode;
+	unsigned short	__pad1;
+	unsigned short	seq;
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+};
+
+#endif /* __SPARC_IPCBUF_H */
diff --git a/arch/sparc/include/asm/ipcbuf_32.h b/arch/sparc/include/asm/ipcbuf_32.h
deleted file mode 100644
index 6387209..0000000
--- a/arch/sparc/include/asm/ipcbuf_32.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef _SPARC_IPCBUF_H
-#define _SPARC_IPCBUF_H
-
-/*
- * The ipc64_perm structure for sparc architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 32-bit mode
- * - 32-bit seq
- * - 2 miscellaneous 64-bit values (so that this structure matches
- *				    sparc64 ipc64_perm)
- */
-
-struct ipc64_perm
-{
-	__kernel_key_t		key;
-	__kernel_uid32_t	uid;
-	__kernel_gid32_t	gid;
-	__kernel_uid32_t	cuid;
-	__kernel_gid32_t	cgid;
-	unsigned short		__pad1;
-	__kernel_mode_t		mode;
-	unsigned short		__pad2;
-	unsigned short		seq;
-	unsigned long long	__unused1;
-	unsigned long long	__unused2;
-};
-
-#endif /* _SPARC_IPCBUF_H */
diff --git a/arch/sparc/include/asm/ipcbuf_64.h b/arch/sparc/include/asm/ipcbuf_64.h
deleted file mode 100644
index a44b855..0000000
--- a/arch/sparc/include/asm/ipcbuf_64.h
+++ /dev/null
@@ -1,28 +0,0 @@
-#ifndef _SPARC64_IPCBUF_H
-#define _SPARC64_IPCBUF_H
-
-/*
- * The ipc64_perm structure for sparc64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 32-bit seq
- * - 2 miscellaneous 64-bit values
- */
-
-struct ipc64_perm
-{
-	__kernel_key_t	key;
-	__kernel_uid_t	uid;
-	__kernel_gid_t	gid;
-	__kernel_uid_t	cuid;
-	__kernel_gid_t	cgid;
-	__kernel_mode_t	mode;
-	unsigned short	__pad1;
-	unsigned short	seq;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _SPARC64_IPCBUF_H */
-- 
1.6.0.2.GIT

