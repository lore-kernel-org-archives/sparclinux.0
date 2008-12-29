From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:58:04 +0000
Subject: [PATCH 05/11] sparc32: use proper types in struct stat
Message-Id: <1230595090-23982-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

like sparc64 use proper types in struct stat

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/stat_32.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/stat_32.h b/arch/sparc/include/asm/stat_32.h
index 643d572..45b3ee4 100644
--- a/arch/sparc/include/asm/stat_32.h
+++ b/arch/sparc/include/asm/stat_32.h
@@ -5,21 +5,21 @@
 
 struct stat {
 	unsigned short	st_dev;
-	unsigned long	st_ino;
-	unsigned short	st_mode;
+	ino_t		st_ino;
+	mode_t		st_mode;
 	short		st_nlink;
-	unsigned short	st_uid;
-	unsigned short	st_gid;
+	uid_t		st_uid;
+	gid_t		st_gid;
 	unsigned short	st_rdev;
-	long		st_size;
-	long		st_atime;
+	off_t		st_size;
+	time_t		st_atime;
 	unsigned long	st_atime_nsec;
-	long		st_mtime;
+	time_t		st_mtime;
 	unsigned long	st_mtime_nsec;
-	long		st_ctime;
+	time_t		st_ctime;
 	unsigned long	st_ctime_nsec;
-	long		st_blksize;
-	long		st_blocks;
+	off_t		st_blksize;
+	off_t		st_blocks;
 	unsigned long	__unused4[2];
 };
 
-- 
1.6.0.2.GIT

