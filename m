From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 12 Jun 2008 22:11:38 +0000
Subject: [patch] sparc: merge posix_types_64.h into posix_types.h
Message-Id: <20080612221138.GQ17231@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc/posix_types.h    |   20 +++++++++++++++++++-
 include/asm-sparc/posix_types_64.h |   22 ----------------------
 2 files changed, 19 insertions(+), 23 deletions(-)


0d1bc28badda9504a3e07481bc1f7cfe847d0734 diff --git a/include/asm-sparc/posix_types.h b/include/asm-sparc/posix_types.h
index 4636c5d..2aca832 100644
--- a/include/asm-sparc/posix_types.h
+++ b/include/asm-sparc/posix_types.h
@@ -104,7 +104,25 @@ static inline void __FD_ZERO(__kernel_fd_set *p)
 
 
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm-sparc/posix_types_64.h>
+
+typedef unsigned long          __kernel_size_t;
+typedef long                   __kernel_ssize_t;
+typedef int                    __kernel_ipc_pid_t;
+typedef unsigned int           __kernel_uid_t;
+typedef unsigned int           __kernel_gid_t;
+typedef unsigned int           __kernel_mode_t;
+typedef unsigned short         __kernel_umode_t;
+typedef unsigned int           __kernel_nlink_t;
+typedef int                    __kernel_daddr_t;
+
+typedef __kernel_uid_t	       __kernel_uid32_t;
+typedef __kernel_gid_t	       __kernel_gid32_t;
+
+typedef unsigned int	       __kernel_old_dev_t;
+
+/* Note this piece of asymmetry from the v9 ABI.  */
+typedef int		       __kernel_suseconds_t;
+
 #else
 
 typedef unsigned int           __kernel_size_t;
diff --git a/include/asm-sparc/posix_types_64.h b/include/asm-sparc/posix_types_64.h
deleted file mode 100644
index 5b51039..0000000
--- a/include/asm-sparc/posix_types_64.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef __ARCH_SPARC64_POSIX_TYPES_H
-#define __ARCH_SPARC64_POSIX_TYPES_H
-
-typedef unsigned long          __kernel_size_t;
-typedef long                   __kernel_ssize_t;
-typedef int                    __kernel_ipc_pid_t;
-typedef unsigned int           __kernel_uid_t;
-typedef unsigned int           __kernel_gid_t;
-typedef unsigned int           __kernel_mode_t;
-typedef unsigned short         __kernel_umode_t;
-typedef unsigned int           __kernel_nlink_t;
-typedef int                    __kernel_daddr_t;
-
-typedef __kernel_uid_t	       __kernel_uid32_t;
-typedef __kernel_gid_t	       __kernel_gid32_t;
-
-typedef unsigned int	       __kernel_old_dev_t;
-
-/* Note this piece of asymmetry from the v9 ABI.  */
-typedef int		       __kernel_suseconds_t;
-
-#endif /* !(__ARCH_SPARC64_POSIX_TYPES_H) */

