From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:58:02 +0000
Subject: [PATCH 03/11] sparc: unify posix_types.h
Message-Id: <1230595090-23982-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The posix types differed so much in their definition
that they are kept in separate blocks.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild           |    2 -
 arch/sparc/include/asm/posix_types.h    |  157 ++++++++++++++++++++++++++++++-
 arch/sparc/include/asm/posix_types_32.h |  118 -----------------------
 arch/sparc/include/asm/posix_types_64.h |  122 ------------------------
 4 files changed, 152 insertions(+), 247 deletions(-)
 delete mode 100644 arch/sparc/include/asm/posix_types_32.h
 delete mode 100644 arch/sparc/include/asm/posix_types_64.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index b938232..71e52a8 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,8 +1,6 @@
 # User exported sparc header files
 include include/asm-generic/Kbuild.asm
 
-header-y += posix_types_32.h
-header-y += posix_types_64.h
 header-y += ptrace_32.h
 header-y += ptrace_64.h
 header-y += sigcontext_32.h
diff --git a/arch/sparc/include/asm/posix_types.h b/arch/sparc/include/asm/posix_types.h
index 03a0e09..98d6ebb 100644
--- a/arch/sparc/include/asm/posix_types.h
+++ b/arch/sparc/include/asm/posix_types.h
@@ -1,8 +1,155 @@
-#ifndef ___ASM_SPARC_POSIX_TYPES_H
-#define ___ASM_SPARC_POSIX_TYPES_H
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.  Also, we cannot
+ * assume GCC is being used.
+ */
+
+#ifndef __SPARC_POSIX_TYPES_H
+#define __SPARC_POSIX_TYPES_H
+
 #if defined(__sparc__) && defined(__arch64__)
-#include <asm/posix_types_64.h>
+/* sparc 64 bit */
+typedef unsigned long          __kernel_size_t;
+typedef long                   __kernel_ssize_t;
+typedef long                   __kernel_ptrdiff_t;
+typedef long                   __kernel_time_t;
+typedef long                   __kernel_clock_t;
+typedef int                    __kernel_pid_t;
+typedef int                    __kernel_ipc_pid_t;
+typedef unsigned int           __kernel_uid_t;
+typedef unsigned int           __kernel_gid_t;
+typedef unsigned long          __kernel_ino_t;
+typedef unsigned int           __kernel_mode_t;
+typedef unsigned short         __kernel_umode_t;
+typedef unsigned int           __kernel_nlink_t;
+typedef int                    __kernel_daddr_t;
+typedef long                   __kernel_off_t;
+typedef char *                 __kernel_caddr_t;
+typedef unsigned short	       __kernel_uid16_t;
+typedef unsigned short	       __kernel_gid16_t;
+typedef int                    __kernel_clockid_t;
+typedef int                    __kernel_timer_t;
+
+typedef unsigned short 	       __kernel_old_uid_t;
+typedef unsigned short         __kernel_old_gid_t;
+typedef __kernel_uid_t	       __kernel_uid32_t;
+typedef __kernel_gid_t	       __kernel_gid32_t;
+
+typedef unsigned int	       __kernel_old_dev_t;
+
+/* Note this piece of asymmetry from the v9 ABI.  */
+typedef int		       __kernel_suseconds_t;
+
 #else
-#include <asm/posix_types_32.h>
-#endif
+/* sparc 32 bit */
+
+typedef unsigned int           __kernel_size_t;
+typedef int                    __kernel_ssize_t;
+typedef long int               __kernel_ptrdiff_t;
+typedef long                   __kernel_time_t;
+typedef long		       __kernel_suseconds_t;
+typedef long                   __kernel_clock_t;
+typedef int                    __kernel_pid_t;
+typedef unsigned short         __kernel_ipc_pid_t;
+typedef unsigned short         __kernel_uid_t;
+typedef unsigned short         __kernel_gid_t;
+typedef unsigned long          __kernel_ino_t;
+typedef unsigned short         __kernel_mode_t;
+typedef unsigned short         __kernel_umode_t;
+typedef short                  __kernel_nlink_t;
+typedef long                   __kernel_daddr_t;
+typedef long                   __kernel_off_t;
+typedef char *                 __kernel_caddr_t;
+typedef unsigned short	       __kernel_uid16_t;
+typedef unsigned short	       __kernel_gid16_t;
+typedef unsigned int	       __kernel_uid32_t;
+typedef unsigned int	       __kernel_gid32_t;
+typedef unsigned short	       __kernel_old_uid_t;
+typedef unsigned short	       __kernel_old_gid_t;
+typedef unsigned short	       __kernel_old_dev_t;
+typedef int                    __kernel_clockid_t;
+typedef int                    __kernel_timer_t;
+
+#endif /* defined(__sparc__) && defined(__arch64__) */
+
+#ifdef __GNUC__
+typedef long long              __kernel_loff_t;
 #endif
+
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+
+#ifdef __KERNEL__
+
+#undef __FD_SET
+static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
+}
+
+#undef __FD_CLR
+static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
+}
+
+#undef __FD_ISSET
+static inline int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
+}
+
+/*
+ * This will unroll the loop for the normal constant cases (8 or 32 longs,
+ * for 256 and 1024-bit fd_sets respectively)
+ */
+#undef __FD_ZERO
+static inline void __FD_ZERO(__kernel_fd_set *p)
+{
+	unsigned long *tmp = p->fds_bits;
+	int i;
+
+	if (__builtin_constant_p(__FDSET_LONGS)) {
+		switch (__FDSET_LONGS) {
+			case 32:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
+			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
+			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
+			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
+			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
+			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
+			  return;
+			case 16:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
+			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
+			  return;
+			case 8:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
+			  return;
+			case 4:
+			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
+			  return;
+		}
+	}
+	i = __FDSET_LONGS;
+	while (i) {
+		i--;
+		*tmp = 0;
+		tmp++;
+	}
+}
+
+#endif /* __KERNEL__ */
+#endif /* __SPARC_POSIX_TYPES_H */
diff --git a/arch/sparc/include/asm/posix_types_32.h b/arch/sparc/include/asm/posix_types_32.h
deleted file mode 100644
index 6bb6eb1..0000000
--- a/arch/sparc/include/asm/posix_types_32.h
+++ /dev/null
@@ -1,118 +0,0 @@
-#ifndef __ARCH_SPARC_POSIX_TYPES_H
-#define __ARCH_SPARC_POSIX_TYPES_H
-
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- */
-
-typedef unsigned int           __kernel_size_t;
-typedef int                    __kernel_ssize_t;
-typedef long int               __kernel_ptrdiff_t;
-typedef long                   __kernel_time_t;
-typedef long		       __kernel_suseconds_t;
-typedef long                   __kernel_clock_t;
-typedef int                    __kernel_pid_t;
-typedef unsigned short         __kernel_ipc_pid_t;
-typedef unsigned short         __kernel_uid_t;
-typedef unsigned short         __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
-typedef unsigned short         __kernel_mode_t;
-typedef unsigned short         __kernel_umode_t;
-typedef short                  __kernel_nlink_t;
-typedef long                   __kernel_daddr_t;
-typedef long                   __kernel_off_t;
-typedef char *                 __kernel_caddr_t;
-typedef unsigned short	       __kernel_uid16_t;
-typedef unsigned short	       __kernel_gid16_t;
-typedef unsigned int	       __kernel_uid32_t;
-typedef unsigned int	       __kernel_gid32_t;
-typedef unsigned short	       __kernel_old_uid_t;
-typedef unsigned short	       __kernel_old_gid_t;
-typedef unsigned short	       __kernel_old_dev_t;
-typedef int                    __kernel_clockid_t;
-typedef int                    __kernel_timer_t;
-
-#ifdef __GNUC__
-typedef long long	__kernel_loff_t;
-#endif
-
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-
-#if defined(__KERNEL__)
-
-#undef __FD_SET
-static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static inline int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant cases (8 or 32 longs,
- * for 256 and 1024-bit fd_sets respectively)
- */
-#undef __FD_ZERO
-static inline void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 32:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
-			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
-			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
-			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
-			  return;
-			case 16:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  return;
-			case 8:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  return;
-			case 4:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) */
-
-#endif /* !(__ARCH_SPARC_POSIX_TYPES_H) */
diff --git a/arch/sparc/include/asm/posix_types_64.h b/arch/sparc/include/asm/posix_types_64.h
deleted file mode 100644
index ba8f932..0000000
--- a/arch/sparc/include/asm/posix_types_64.h
+++ /dev/null
@@ -1,122 +0,0 @@
-#ifndef __ARCH_SPARC64_POSIX_TYPES_H
-#define __ARCH_SPARC64_POSIX_TYPES_H
-
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- */
-
-typedef unsigned long          __kernel_size_t;
-typedef long                   __kernel_ssize_t;
-typedef long                   __kernel_ptrdiff_t;
-typedef long                   __kernel_time_t;
-typedef long                   __kernel_clock_t;
-typedef int                    __kernel_pid_t;
-typedef int                    __kernel_ipc_pid_t;
-typedef unsigned int           __kernel_uid_t;
-typedef unsigned int           __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
-typedef unsigned int           __kernel_mode_t;
-typedef unsigned short         __kernel_umode_t;
-typedef unsigned int           __kernel_nlink_t;
-typedef int                    __kernel_daddr_t;
-typedef long                   __kernel_off_t;
-typedef char *                 __kernel_caddr_t;
-typedef unsigned short	       __kernel_uid16_t;
-typedef unsigned short	       __kernel_gid16_t;
-typedef int                    __kernel_clockid_t;
-typedef int                    __kernel_timer_t;
-
-typedef unsigned short 	       __kernel_old_uid_t;
-typedef unsigned short         __kernel_old_gid_t;
-typedef __kernel_uid_t	       __kernel_uid32_t;
-typedef __kernel_gid_t	       __kernel_gid32_t;
-
-typedef unsigned int	       __kernel_old_dev_t;
-
-/* Note this piece of asymmetry from the v9 ABI.  */
-typedef int		       __kernel_suseconds_t;
-
-#ifdef __GNUC__
-typedef long long              __kernel_loff_t;
-#endif
-
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-
-#if defined(__KERNEL__)
-
-#undef __FD_SET
-static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
-}
-
-#undef __FD_CLR
-static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
-}
-
-#undef __FD_ISSET
-static inline int __FD_ISSET(unsigned long fd, __const__ __kernel_fd_set *p)
-{
-	unsigned long _tmp = fd / __NFDBITS;
-	unsigned long _rem = fd % __NFDBITS;
-	return (p->fds_bits[_tmp] & (1UL<<_rem)) != 0;
-}
-
-/*
- * This will unroll the loop for the normal constant cases (8 or 32 longs,
- * for 256 and 1024-bit fd_sets respectively)
- */
-#undef __FD_ZERO
-static inline void __FD_ZERO(__kernel_fd_set *p)
-{
-	unsigned long *tmp = p->fds_bits;
-	int i;
-
-	if (__builtin_constant_p(__FDSET_LONGS)) {
-		switch (__FDSET_LONGS) {
-			case 32:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  tmp[16] = 0; tmp[17] = 0; tmp[18] = 0; tmp[19] = 0;
-			  tmp[20] = 0; tmp[21] = 0; tmp[22] = 0; tmp[23] = 0;
-			  tmp[24] = 0; tmp[25] = 0; tmp[26] = 0; tmp[27] = 0;
-			  tmp[28] = 0; tmp[29] = 0; tmp[30] = 0; tmp[31] = 0;
-			  return;
-			case 16:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  tmp[ 8] = 0; tmp[ 9] = 0; tmp[10] = 0; tmp[11] = 0;
-			  tmp[12] = 0; tmp[13] = 0; tmp[14] = 0; tmp[15] = 0;
-			  return;
-			case 8:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  tmp[ 4] = 0; tmp[ 5] = 0; tmp[ 6] = 0; tmp[ 7] = 0;
-			  return;
-			case 4:
-			  tmp[ 0] = 0; tmp[ 1] = 0; tmp[ 2] = 0; tmp[ 3] = 0;
-			  return;
-		}
-	}
-	i = __FDSET_LONGS;
-	while (i) {
-		i--;
-		*tmp = 0;
-		tmp++;
-	}
-}
-
-#endif /* defined(__KERNEL__) */
-
-#endif /* !(__ARCH_SPARC64_POSIX_TYPES_H) */
-- 
1.6.0.2.GIT

