From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:10 +0000
Subject: [PATCH] sparc: Merge asm-sparc{,64}/msgbuf.h
Message-Id: <1213387042-9711-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Padding from 32 bit sparc kept using preprocessor magic
$ diff -u include/asm-sparc/msgbuf.h include/asm-sparc64/msgbuf.h
-- include/asm-sparc/msgbuf.h	2008-06-13 06:42:07.000000000 +0200
++ include/asm-sparc64/msgbuf.h	2008-06-13 06:42:07.000000000 +0200
@@ -7,17 +7,13 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * - 2 miscellaneous 64-bit values
  */

 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	unsigned int   __pad1;
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int   __pad2;
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int   __pad3;
 	__kernel_time_t msg_ctime;	/* last change time */
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/msgbuf.h   |   23 +++++++++++++++--------
 include/asm-sparc64/msgbuf.h |   28 +---------------------------
 2 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/include/asm-sparc/msgbuf.h b/include/asm-sparc/msgbuf.h
index 8cec9ad..efc7cbe 100644
--- a/include/asm-sparc/msgbuf.h
+++ b/include/asm-sparc/msgbuf.h
@@ -1,7 +1,7 @@
-#ifndef _SPARC64_MSGBUF_H
-#define _SPARC64_MSGBUF_H
+#ifndef _SPARC_MSGBUF_H
+#define _SPARC_MSGBUF_H
 
-/* 
+/*
  * The msqid64_ds structure for sparc64 architecture.
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
@@ -11,13 +11,20 @@
  * - 2 miscellaneous 32-bit values
  */
 
+#if defined(__sparc__) && defined(__arch64__)
+# define PADDING(x)
+#else
+# define PADDING(x) unsigned int x;
+#endif
+
+
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	unsigned int   __pad1;
+	PADDING(__pad1)
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int   __pad2;
+	PADDING(__pad2)
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int   __pad3;
+	PADDING(__pad3)
 	__kernel_time_t msg_ctime;	/* last change time */
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
@@ -27,5 +34,5 @@ struct msqid64_ds {
 	unsigned long  __unused1;
 	unsigned long  __unused2;
 };
-
-#endif /* _SPARC64_MSGBUF_H */
+#undef PADDING
+#endif /* _SPARC_MSGBUF_H */
diff --git a/include/asm-sparc64/msgbuf.h b/include/asm-sparc64/msgbuf.h
index 55c101b..5b33cc9 100644
--- a/include/asm-sparc64/msgbuf.h
+++ b/include/asm-sparc64/msgbuf.h
@@ -1,27 +1 @@
-#ifndef _SPARC64_MSGBUF_H
-#define _SPARC64_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for sparc64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused1;
-	unsigned long  __unused2;
-};
-
-#endif /* _SPARC64_MSGBUF_H */
+#include <asm-sparc/msgbuf.h>
-- 
1.5.4.1.143.ge7e51

