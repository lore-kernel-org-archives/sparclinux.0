From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:11 +0000
Subject: [PATCH] sparc: Merge asm-sparc{,64}/sembuf.h
Message-Id: <1213387042-9711-10-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Padding in the sembuf structure made conditional
as only 32 bit sparc did so.
$ diff -u include/asm-sparc/sembuf.h include/asm-sparc64/sembuf.h
-- include/asm-sparc/sembuf.h	2008-06-13 06:42:07.000000000 +0200
++ include/asm-sparc64/sembuf.h	2008-06-13 06:42:07.000000000 +0200
@@ -1,21 +1,18 @@
-#ifndef _SPARC_SEMBUF_H
-#define _SPARC_SEMBUF_H
+#ifndef _SPARC64_SEMBUF_H
+#define _SPARC64_SEMBUF_H

 /*
- * The semid64_ds structure for sparc architecture.
+ * The semid64_ds structure for sparc64 architecture.
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * - 2 miscellaneous 64-bit values
  */

 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	unsigned int	__pad1;
 	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned int	__pad2;
 	__kernel_time_t	sem_ctime;		/* last change time */
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/sembuf.h   |   12 +++++++++---
 include/asm-sparc64/sembuf.h |   23 +----------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/asm-sparc/sembuf.h b/include/asm-sparc/sembuf.h
index a79c4bb..faee1be 100644
--- a/include/asm-sparc/sembuf.h
+++ b/include/asm-sparc/sembuf.h
@@ -1,7 +1,7 @@
 #ifndef _SPARC_SEMBUF_H
 #define _SPARC_SEMBUF_H
 
-/* 
+/*
  * The semid64_ds structure for sparc architecture.
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
@@ -10,16 +10,22 @@
  * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
+#if defined(__sparc__) && defined(__arch64__)
+# define PADDING(x)
+#else
+# define PADDING(x) unsigned int x;
+#endif
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	unsigned int	__pad1;
+	PADDING(__pad1)
 	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned int	__pad2;
+	PADDING(__pad2)
 	__kernel_time_t	sem_ctime;		/* last change time */
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
+#undef PADDING
 
 #endif /* _SPARC64_SEMBUF_H */
diff --git a/include/asm-sparc64/sembuf.h b/include/asm-sparc64/sembuf.h
index 99f04e4..c55b952 100644
--- a/include/asm-sparc64/sembuf.h
+++ b/include/asm-sparc64/sembuf.h
@@ -1,22 +1 @@
-#ifndef _SPARC64_SEMBUF_H
-#define _SPARC64_SEMBUF_H
-
-/* 
- * The semid64_ds structure for sparc64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _SPARC64_SEMBUF_H */
+#include <asm-sparc/sembuf.h>
-- 
1.5.4.1.143.ge7e51

