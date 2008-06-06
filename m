From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:23 +0000
Subject: [PATCH 11/21] sparc: Merge asm-sparc{,64}/shmbuf.h
Message-Id: <1212786033-4227-11-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Padding in the shmbuf structure made conditional
as only 32 bit sparc did so.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/shmbuf.h   |   14 +++++++++++---
 include/asm-sparc64/shmbuf.h |   39 +--------------------------------------
 2 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/include/asm-sparc/shmbuf.h b/include/asm-sparc/shmbuf.h
index 1ff9da8..83a1605 100644
--- a/include/asm-sparc/shmbuf.h
+++ b/include/asm-sparc/shmbuf.h
@@ -11,13 +11,19 @@
  * - 2 miscellaneous 32-bit values
  */
 
+#if defined(__sparc__) && defined(__arch64__)
+# define PADDING(x)
+#else
+# define PADDING(x) unsigned int x;
+#endif
+
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	unsigned int		__pad1;
+	PADDING(__pad1)
 	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned int		__pad2;
+	PADDING(__pad2)
 	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned int		__pad3;
+	PADDING(__pad3)
 	__kernel_time_t		shm_ctime;	/* last change time */
 	size_t			shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
@@ -39,4 +45,6 @@ struct shminfo64 {
 	unsigned long	__unused4;
 };
 
+#undef PADDING
+
 #endif /* _SPARC_SHMBUF_H */
diff --git a/include/asm-sparc64/shmbuf.h b/include/asm-sparc64/shmbuf.h
index 61c2ef4..0c54a2d 100644
--- a/include/asm-sparc64/shmbuf.h
+++ b/include/asm-sparc64/shmbuf.h
@@ -1,38 +1 @@
-#ifndef _SPARC64_SHMBUF_H
-#define _SPARC64_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for sparc64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused1;
-	unsigned long		__unused2;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _SPARC64_SHMBUF_H */
+#include <asm-sparc/shmbuf.h>
-- 
1.5.4.1.143.ge7e51

