From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 28 Dec 2008 21:48:52 +0000
Subject: [PATCH 2/2] sparc: unify stat.h
Message-Id: <20081228214852.GA13033@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To my suprise struct stat64 was not equal on sparc 32 and sparc64,
so there was really nothing to share here.
Unify the files by adding their respective content to stat.h.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild    |    2 -
 arch/sparc/include/asm/stat.h    |  115 +++++++++++++++++++++++++++++++++++---
 arch/sparc/include/asm/stat_32.h |   62 --------------------
 arch/sparc/include/asm/stat_64.h |   47 ---------------
 4 files changed, 107 insertions(+), 119 deletions(-)
 rewrite arch/sparc/include/asm/stat.h (69%)
 delete mode 100644 arch/sparc/include/asm/stat_32.h
 delete mode 100644 arch/sparc/include/asm/stat_64.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 71e52a8..46d3704 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -9,8 +9,6 @@ header-y += siginfo_32.h
 header-y += siginfo_64.h
 header-y += signal_32.h
 header-y += signal_64.h
-header-y += stat_32.h
-header-y += stat_64.h
 
 header-y += apc.h
 header-y += asi.h
diff --git a/arch/sparc/include/asm/stat.h b/arch/sparc/include/asm/stat.h
dissimilarity index 69%
index d815301..55db5ec 100644
--- a/arch/sparc/include/asm/stat.h
+++ b/arch/sparc/include/asm/stat.h
@@ -1,8 +1,107 @@
-#ifndef ___ASM_SPARC_STAT_H
-#define ___ASM_SPARC_STAT_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/stat_64.h>
-#else
-#include <asm/stat_32.h>
-#endif
-#endif
+#ifndef __SPARC_STAT_H
+#define __SPARC_STAT_H
+
+#include <linux/types.h>
+
+#if defined(__sparc__) && defined(__arch64__)
+/* 64 bit sparc */
+struct stat {
+	unsigned   st_dev;
+	ino_t   st_ino;
+	mode_t  st_mode;
+	short   st_nlink;
+	uid_t   st_uid;
+	gid_t   st_gid;
+	unsigned   st_rdev;
+	off_t   st_size;
+	time_t  st_atime;
+	time_t  st_mtime;
+	time_t  st_ctime;
+	off_t   st_blksize;
+	off_t   st_blocks;
+	unsigned long  __unused4[2];
+};
+
+struct stat64 {
+	unsigned long	st_dev;
+	unsigned long	st_ino;
+	unsigned long	st_nlink;
+
+	unsigned int	st_mode;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+	unsigned int	__pad0;
+
+	unsigned long	st_rdev;
+	long		st_size;
+	long		st_blksize;
+	long		st_blocks;
+
+	unsigned long	st_atime;
+	unsigned long	st_atime_nsec;
+	unsigned long	st_mtime;
+	unsigned long	st_mtime_nsec;
+	unsigned long	st_ctime;
+	unsigned long	st_ctime_nsec;
+	long		__unused[3];
+};
+
+#else
+/* 32 bit sparc */
+struct stat {
+	unsigned short	st_dev;
+	ino_t		st_ino;
+	mode_t		st_mode;
+	short		st_nlink;
+	uid_t		st_uid;
+	gid_t		st_gid;
+	unsigned short	st_rdev;
+	off_t		st_size;
+	time_t		st_atime;
+	unsigned long	st_atime_nsec;
+	time_t		st_mtime;
+	unsigned long	st_mtime_nsec;
+	time_t		st_ctime;
+	unsigned long	st_ctime_nsec;
+	off_t		st_blksize;
+	off_t		st_blocks;
+	unsigned long	__unused4[2];
+};
+
+#define STAT_HAVE_NSEC 1
+
+struct stat64 {
+	unsigned long long st_dev;
+
+	unsigned long long st_ino;
+
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+
+	unsigned long long st_rdev;
+
+	unsigned char	__pad3[8];
+
+	long long	st_size;
+	unsigned int	st_blksize;
+
+	unsigned char	__pad4[8];
+	unsigned int	st_blocks;
+
+	unsigned int	st_atime;
+	unsigned int	st_atime_nsec;
+
+	unsigned int	st_mtime;
+	unsigned int	st_mtime_nsec;
+
+	unsigned int	st_ctime;
+	unsigned int	st_ctime_nsec;
+
+	unsigned int	__unused4;
+	unsigned int	__unused5;
+};
+#endif /* defined(__sparc__) && defined(__arch64__) */
+#endif /* __SPARC_STAT_H */
diff --git a/arch/sparc/include/asm/stat_32.h b/arch/sparc/include/asm/stat_32.h
deleted file mode 100644
index 45b3ee4..0000000
--- a/arch/sparc/include/asm/stat_32.h
+++ /dev/null
@@ -1,62 +0,0 @@
-#ifndef _SPARC_STAT_H
-#define _SPARC_STAT_H
-
-#include <linux/types.h>
-
-struct stat {
-	unsigned short	st_dev;
-	ino_t		st_ino;
-	mode_t		st_mode;
-	short		st_nlink;
-	uid_t		st_uid;
-	gid_t		st_gid;
-	unsigned short	st_rdev;
-	off_t		st_size;
-	time_t		st_atime;
-	unsigned long	st_atime_nsec;
-	time_t		st_mtime;
-	unsigned long	st_mtime_nsec;
-	time_t		st_ctime;
-	unsigned long	st_ctime_nsec;
-	off_t		st_blksize;
-	off_t		st_blocks;
-	unsigned long	__unused4[2];
-};
-
-#define STAT_HAVE_NSEC 1
-
-struct stat64 {
-	unsigned long long st_dev;
-
-	unsigned long long st_ino;
-
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
-
-	unsigned int	st_uid;
-	unsigned int	st_gid;
-
-	unsigned long long st_rdev;
-
-	unsigned char	__pad3[8];
-
-	long long	st_size;
-	unsigned int	st_blksize;
-
-	unsigned char	__pad4[8];
-	unsigned int	st_blocks;
-
-	unsigned int	st_atime;
-	unsigned int	st_atime_nsec;
-
-	unsigned int	st_mtime;
-	unsigned int	st_mtime_nsec;
-
-	unsigned int	st_ctime;
-	unsigned int	st_ctime_nsec;
-
-	unsigned int	__unused4;
-	unsigned int	__unused5;
-};
-
-#endif
diff --git a/arch/sparc/include/asm/stat_64.h b/arch/sparc/include/asm/stat_64.h
deleted file mode 100644
index 9650fde..0000000
--- a/arch/sparc/include/asm/stat_64.h
+++ /dev/null
@@ -1,47 +0,0 @@
-#ifndef _SPARC64_STAT_H
-#define _SPARC64_STAT_H
-
-#include <linux/types.h>
-
-struct stat {
-	unsigned   st_dev;
-	ino_t   st_ino;
-	mode_t  st_mode;
-	short   st_nlink;
-	uid_t   st_uid;
-	gid_t   st_gid;
-	unsigned   st_rdev;
-	off_t   st_size;
-	time_t  st_atime;
-	time_t  st_mtime;
-	time_t  st_ctime;
-	off_t   st_blksize;
-	off_t   st_blocks;
-	unsigned long  __unused4[2];
-};
-
-struct stat64 {
-	unsigned long	st_dev;
-	unsigned long	st_ino;
-	unsigned long	st_nlink;
-
-	unsigned int	st_mode;
-	unsigned int	st_uid;
-	unsigned int	st_gid;
-	unsigned int	__pad0;
-
-	unsigned long	st_rdev;
-	long		st_size;
-	long		st_blksize;
-	long		st_blocks;
-
-	unsigned long	st_atime;
-	unsigned long	st_atime_nsec;
-	unsigned long	st_mtime;
-	unsigned long	st_mtime_nsec;
-	unsigned long	st_ctime;
-	unsigned long	st_ctime_nsec;
-	long		__unused[3];
-};
-
-#endif
-- 
1.6.0.2.GIT

