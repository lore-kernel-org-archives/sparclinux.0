From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 12 Jun 2008 22:10:46 +0000
Subject: [patch] sparc: merge ipcbuf_64.h into ipcbuf.h
Message-Id: <20080612221046.GH17231@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc/ipcbuf.h    |   26 +++++++++++++++++++++++++-
 include/asm-sparc/ipcbuf_64.h |   28 ----------------------------
 2 files changed, 25 insertions(+), 29 deletions(-)

c228758f9050f4622520872565175825f3f783bc diff --git a/include/asm-sparc/ipcbuf.h b/include/asm-sparc/ipcbuf.h
index 52cf883..492bae2 100644
--- a/include/asm-sparc/ipcbuf.h
+++ b/include/asm-sparc/ipcbuf.h
@@ -2,7 +2,31 @@
 #define _ASM_SPARC_IPCBUF_H
 
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm-sparc/ipcbuf_64.h>
+
+/* 
+ * The ipc64_perm structure for sparc64 architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
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
+	__kernel_mode_t	mode; 
+	unsigned short	__pad1;
+	unsigned short	seq;
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+};
+
 #else
 
 /* 
diff --git a/include/asm-sparc/ipcbuf_64.h b/include/asm-sparc/ipcbuf_64.h
deleted file mode 100644
index 9c5bf1b..0000000
--- a/include/asm-sparc/ipcbuf_64.h
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

