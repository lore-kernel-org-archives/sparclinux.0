From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:20 +0000
Subject: [PATCH 08/21] sparc: Merge asm-sparc{,64}/fcntl.h
Message-Id: <1212786033-4227-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The definition of O_NDELAY differed - the rest was equal

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/fcntl.h   |    4 ++++
 include/asm-sparc64/fcntl.h |   36 +-----------------------------------
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/include/asm-sparc/fcntl.h b/include/asm-sparc/fcntl.h
index 07bd2d8..d4d9c9d 100644
--- a/include/asm-sparc/fcntl.h
+++ b/include/asm-sparc/fcntl.h
@@ -10,7 +10,11 @@
 #define O_EXCL		0x0800	/* not fcntl */
 #define O_SYNC		0x2000
 #define O_NONBLOCK	0x4000
+#if defined(__sparc__) && defined(__arch64__)
+#define O_NDELAY	0x0004
+#else
 #define O_NDELAY	(0x0004 | O_NONBLOCK)
+#endif
 #define O_NOCTTY	0x8000	/* not fcntl */
 #define O_LARGEFILE	0x40000
 #define O_DIRECT        0x100000 /* direct disk access hint */
diff --git a/include/asm-sparc64/fcntl.h b/include/asm-sparc64/fcntl.h
index 8a09ca7..8b1beae 100644
--- a/include/asm-sparc64/fcntl.h
+++ b/include/asm-sparc64/fcntl.h
@@ -1,35 +1 @@
-#ifndef _SPARC64_FCNTL_H
-#define _SPARC64_FCNTL_H
-
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_NDELAY	0x0004
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_SYNC		0x2000
-#define O_NONBLOCK	0x4000
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
-
-#define F_GETOWN	5	/*  for sockets. */
-#define F_SETOWN	6	/*  for sockets. */
-#define F_GETLK		7
-#define F_SETLK		8
-#define F_SETLKW	9
-
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		1
-#define F_WRLCK		2
-#define F_UNLCK		3
-
-#define __ARCH_FLOCK_PAD	short __unused;
-
-#include <asm-generic/fcntl.h>
-
-#endif /* !(_SPARC64_FCNTL_H) */
+#include <asm-sparc/fcntl.h>
-- 
1.5.4.1.143.ge7e51

