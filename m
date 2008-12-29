From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:58:03 +0000
Subject: [PATCH 04/11] sparc32: drop __old_kernel_stat
Message-Id: <1230595090-23982-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc32 do not define __ARCH_WANT_OLD_STAT so
we do not use this structure neither do we support it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/stat_32.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/stat_32.h b/arch/sparc/include/asm/stat_32.h
index 2299e1d..643d572 100644
--- a/arch/sparc/include/asm/stat_32.h
+++ b/arch/sparc/include/asm/stat_32.h
@@ -3,20 +3,6 @@
 
 #include <linux/types.h>
 
-struct __old_kernel_stat {
-	unsigned short st_dev;
-	unsigned short st_ino;
-	unsigned short st_mode;
-	unsigned short st_nlink;
-	unsigned short st_uid;
-	unsigned short st_gid;
-	unsigned short st_rdev;
-	unsigned long  st_size;
-	unsigned long  st_atime;
-	unsigned long  st_mtime;
-	unsigned long  st_ctime;
-};
-
 struct stat {
 	unsigned short	st_dev;
 	unsigned long	st_ino;
-- 
1.6.0.2.GIT

