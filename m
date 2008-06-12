From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 12 Jun 2008 22:11:35 +0000
Subject: [patch] sparc: merge posix_types_32.h into posix_types.h
Message-Id: <20080612221135.GP17231@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc/posix_types.h    |   16 +++++++++++++++-
 include/asm-sparc/posix_types_32.h |   18 ------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

c7a39e0fd792e8313de71f7e483b68ea2a45d059 diff --git a/include/asm-sparc/posix_types.h b/include/asm-sparc/posix_types.h
index 7d1f324..4636c5d 100644
--- a/include/asm-sparc/posix_types.h
+++ b/include/asm-sparc/posix_types.h
@@ -106,7 +106,21 @@ static inline void __FD_ZERO(__kernel_fd_set *p)
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm-sparc/posix_types_64.h>
 #else
-#include <asm-sparc/posix_types_32.h>
+
+typedef unsigned int           __kernel_size_t;
+typedef int                    __kernel_ssize_t;
+typedef long		       __kernel_suseconds_t;
+typedef unsigned short         __kernel_ipc_pid_t;
+typedef unsigned short         __kernel_uid_t;
+typedef unsigned short         __kernel_gid_t;
+typedef unsigned short         __kernel_mode_t;
+typedef unsigned short         __kernel_umode_t;
+typedef short                  __kernel_nlink_t;
+typedef long                   __kernel_daddr_t;
+typedef unsigned int	       __kernel_uid32_t;
+typedef unsigned int	       __kernel_gid32_t;
+typedef unsigned short	       __kernel_old_dev_t;
+
 #endif
 
 #endif
diff --git a/include/asm-sparc/posix_types_32.h b/include/asm-sparc/posix_types_32.h
deleted file mode 100644
index 771572c..0000000
--- a/include/asm-sparc/posix_types_32.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef __ARCH_SPARC_POSIX_TYPES_H
-#define __ARCH_SPARC_POSIX_TYPES_H
-
-typedef unsigned int           __kernel_size_t;
-typedef int                    __kernel_ssize_t;
-typedef long		       __kernel_suseconds_t;
-typedef unsigned short         __kernel_ipc_pid_t;
-typedef unsigned short         __kernel_uid_t;
-typedef unsigned short         __kernel_gid_t;
-typedef unsigned short         __kernel_mode_t;
-typedef unsigned short         __kernel_umode_t;
-typedef short                  __kernel_nlink_t;
-typedef long                   __kernel_daddr_t;
-typedef unsigned int	       __kernel_uid32_t;
-typedef unsigned int	       __kernel_gid32_t;
-typedef unsigned short	       __kernel_old_dev_t;
-
-#endif /* !(__ARCH_SPARC_POSIX_TYPES_H) */

