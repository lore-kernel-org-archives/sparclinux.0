From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 Jan 2009 12:38:49 +0000
Subject: [PATCH] sparc: unify ipcbuf.h
Message-Id: <20090103123849.GD18259@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081228200418.GA22991@uranus.ravnborg.org>
In-Reply-To: <20081228200418.GA22991@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The ony difference is the size of the mode.
sparc has extra padding to compensate for this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Compared to v1:
- fixed size of padding as noted by davem
- corrected #ifdef so mode padding is used on sparc - not sparc64 (ups)
- simplified ifdef to use only __arch64__ as discussed in another mail

Only build tested on saprc64 as my sparc toolchain needs an update due to
stricter version checks in compiler.h

	Sam

 arch/sparc/include/asm/Kbuild                    |    3 --
 arch/sparc/include/asm/{ipcbuf_64.h => ipcbuf.h} |   16 +++++++----
 arch/sparc/include/asm/ipcbuf_32.h               |   31 ----------------------
 3 files changed, 10 insertions(+), 40 deletions(-)
 rename arch/sparc/include/asm/{ipcbuf_64.h => ipcbuf.h} (56%)
 delete mode 100644 arch/sparc/include/asm/ipcbuf_32.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 58f9b3a..aeaec45 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,9 +1,6 @@
 # User exported sparc header files
 include include/asm-generic/Kbuild.asm
 
-header-y += ipcbuf_32.h
-header-y += ipcbuf_64.h
-
 header-y += apc.h
 header-y += asi.h
 header-y += display7seg.h
diff --git a/arch/sparc/include/asm/ipcbuf_64.h b/arch/sparc/include/asm/ipcbuf.h
similarity index 56%
rename from arch/sparc/include/asm/ipcbuf_64.h
rename to arch/sparc/include/asm/ipcbuf.h
index a44b855..66013b4 100644
--- a/arch/sparc/include/asm/ipcbuf_64.h
+++ b/arch/sparc/include/asm/ipcbuf.h
@@ -1,13 +1,14 @@
-#ifndef _SPARC64_IPCBUF_H
-#define _SPARC64_IPCBUF_H
+#ifndef __SPARC_IPCBUF_H
+#define __SPARC_IPCBUF_H
 
 /*
- * The ipc64_perm structure for sparc64 architecture.
+ * The ipc64_perm structure for sparc/sparc64 architecture.
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
  * Pad space is left for:
  * - 32-bit seq
+ * - on sparc for 32 bit mode (it is 32 bit on sparc64)
  * - 2 miscellaneous 64-bit values
  */
 
@@ -18,11 +19,14 @@ struct ipc64_perm
 	__kernel_gid_t	gid;
 	__kernel_uid_t	cuid;
 	__kernel_gid_t	cgid;
+#ifndef __arch64__
+	unsigned short	__pad0;
+#endif
 	__kernel_mode_t	mode;
 	unsigned short	__pad1;
 	unsigned short	seq;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
+	unsigned long long __unused1;
+	unsigned long long __unused2;
 };
 
-#endif /* _SPARC64_IPCBUF_H */
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
-- 
1.6.0.2.GIT

