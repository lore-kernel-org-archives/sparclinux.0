From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 12 Jun 2008 22:11:17 +0000
Subject: [patch] sparc: merge the common parts of posix_types.h
Message-Id: <20080612221117.GL17231@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc/posix_types.h    |  104 +++++++++++++++++++++++++++++
 include/asm-sparc/posix_types_32.h |  100 ---------------------------
 include/asm-sparc/posix_types_64.h |  100 ---------------------------
 3 files changed, 104 insertions(+), 200 deletions(-)

360b3fbb8c26d6a431f1580791007f8367a9ce8e diff --git a/include/asm-sparc/posix_types.h b/include/asm-sparc/posix_types.h
index 024095e..7d1f324 100644
--- a/include/asm-sparc/posix_types.h
+++ b/include/asm-sparc/posix_types.h
@@ -1,8 +1,112 @@
 #ifndef _ASM_SPARC_POSIX_TYPES_H
 #define _ASM_SPARC_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.  Also, we cannot
+ * assume GCC is being used.
+ */
+
+typedef long                   __kernel_ptrdiff_t;
+typedef long                   __kernel_time_t;
+typedef long                   __kernel_clock_t;
+typedef int                    __kernel_pid_t;
+typedef unsigned long          __kernel_ino_t;
+typedef long                   __kernel_off_t;
+typedef char *                 __kernel_caddr_t;
+typedef unsigned short	       __kernel_uid16_t;
+typedef unsigned short	       __kernel_gid16_t;
+typedef unsigned short	       __kernel_old_uid_t;
+typedef unsigned short	       __kernel_old_gid_t;
+typedef int                    __kernel_clockid_t;
+typedef int                    __kernel_timer_t;
+
+#ifdef __GNUC__
+typedef long long              __kernel_loff_t;
+#endif
+
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+
+#if defined(__KERNEL__)
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
+#endif /* defined(__KERNEL__) */
+
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm-sparc/posix_types_64.h>
 #else
 #include <asm-sparc/posix_types_32.h>
 #endif
+
 #endif
diff --git a/include/asm-sparc/posix_types_32.h b/include/asm-sparc/posix_types_32.h
index dcc07eb..771572c 100644
--- a/include/asm-sparc/posix_types_32.h
+++ b/include/asm-sparc/posix_types_32.h
@@ -1,118 +1,18 @@
 #ifndef __ARCH_SPARC_POSIX_TYPES_H
 #define __ARCH_SPARC_POSIX_TYPES_H
 
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- */
-
 typedef unsigned int           __kernel_size_t;
 typedef int                    __kernel_ssize_t;
-typedef long int               __kernel_ptrdiff_t;
-typedef long                   __kernel_time_t;
 typedef long		       __kernel_suseconds_t;
-typedef long                   __kernel_clock_t;
-typedef int                    __kernel_pid_t;
 typedef unsigned short         __kernel_ipc_pid_t;
 typedef unsigned short         __kernel_uid_t;
 typedef unsigned short         __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
 typedef unsigned short         __kernel_mode_t;
 typedef unsigned short         __kernel_umode_t;
 typedef short                  __kernel_nlink_t;
 typedef long                   __kernel_daddr_t;
-typedef long                   __kernel_off_t;
-typedef char *                 __kernel_caddr_t;
-typedef unsigned short	       __kernel_uid16_t;
-typedef unsigned short	       __kernel_gid16_t;
 typedef unsigned int	       __kernel_uid32_t;
 typedef unsigned int	       __kernel_gid32_t;
-typedef unsigned short	       __kernel_old_uid_t;
-typedef unsigned short	       __kernel_old_gid_t;
 typedef unsigned short	       __kernel_old_dev_t;
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
 
 #endif /* !(__ARCH_SPARC_POSIX_TYPES_H) */
diff --git a/include/asm-sparc/posix_types_64.h b/include/asm-sparc/posix_types_64.h
index 4eaaa01..5b51039 100644
--- a/include/asm-sparc/posix_types_64.h
+++ b/include/asm-sparc/posix_types_64.h
@@ -1,35 +1,16 @@
 #ifndef __ARCH_SPARC64_POSIX_TYPES_H
 #define __ARCH_SPARC64_POSIX_TYPES_H
 
-/*
- * This file is generally used by user-level software, so you need to
- * be a little careful about namespace pollution etc.  Also, we cannot
- * assume GCC is being used.
- */
-
 typedef unsigned long          __kernel_size_t;
 typedef long                   __kernel_ssize_t;
-typedef long                   __kernel_ptrdiff_t;
-typedef long                   __kernel_time_t;
-typedef long                   __kernel_clock_t;
-typedef int                    __kernel_pid_t;
 typedef int                    __kernel_ipc_pid_t;
 typedef unsigned int           __kernel_uid_t;
 typedef unsigned int           __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
 typedef unsigned int           __kernel_mode_t;
 typedef unsigned short         __kernel_umode_t;
 typedef unsigned int           __kernel_nlink_t;
 typedef int                    __kernel_daddr_t;
-typedef long                   __kernel_off_t;
-typedef char *                 __kernel_caddr_t;
-typedef unsigned short	       __kernel_uid16_t;
-typedef unsigned short	       __kernel_gid16_t;
-typedef int                    __kernel_clockid_t;
-typedef int                    __kernel_timer_t;
 
-typedef unsigned short 	       __kernel_old_uid_t;
-typedef unsigned short         __kernel_old_gid_t;
 typedef __kernel_uid_t	       __kernel_uid32_t;
 typedef __kernel_gid_t	       __kernel_gid32_t;
 
@@ -38,85 +19,4 @@ typedef unsigned int	       __kernel_old_dev_t;
 /* Note this piece of asymmetry from the v9 ABI.  */
 typedef int		       __kernel_suseconds_t;
 
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
 #endif /* !(__ARCH_SPARC64_POSIX_TYPES_H) */

