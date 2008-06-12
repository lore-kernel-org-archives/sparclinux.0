From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 12 Jun 2008 22:10:42 +0000
Subject: [patch] sparc: merge ipcbuf_32.h into ipcbuf.h
Message-Id: <20080612221042.GG17231@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc/ipcbuf.h    |   31 ++++++++++++++++++++++++++++++-
 include/asm-sparc/ipcbuf_32.h |   31 -------------------------------
 2 files changed, 30 insertions(+), 32 deletions(-)

d49bf5891c038852046ccb6de430102c3fd6b34e diff --git a/include/asm-sparc/ipcbuf.h b/include/asm-sparc/ipcbuf.h
index d5257da..52cf883 100644
--- a/include/asm-sparc/ipcbuf.h
+++ b/include/asm-sparc/ipcbuf.h
@@ -1,8 +1,37 @@
 #ifndef _ASM_SPARC_IPCBUF_H
 #define _ASM_SPARC_IPCBUF_H
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm-sparc/ipcbuf_64.h>
 #else
-#include <asm-sparc/ipcbuf_32.h>
+
+/* 
+ * The ipc64_perm structure for sparc architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32-bit mode
+ * - 32-bit seq
+ * - 2 miscellaneous 64-bit values (so that this structure matches
+ *				    sparc64 ipc64_perm)
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+	unsigned short		__pad1;
+	__kernel_mode_t		mode;
+	unsigned short		__pad2;
+	unsigned short		seq;
+	unsigned long long	__unused1;
+	unsigned long long	__unused2;
+};
+
 #endif
+
 #endif
diff --git a/include/asm-sparc/ipcbuf_32.h b/include/asm-sparc/ipcbuf_32.h
deleted file mode 100644
index 9bef02d..0000000
--- a/include/asm-sparc/ipcbuf_32.h
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

