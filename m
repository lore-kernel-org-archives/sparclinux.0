From: Nate Karstens <nate.karstens@garmin.com>
Date: Mon, 20 Apr 2020 07:15:45 +0000
Subject: [PATCH 1/4] fs: Implement close-on-fork
Message-Id: <20200420071548.62112-2-nate.karstens@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
In-Reply-To: <20200420071548.62112-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>, Nate Karstens <nate.karstens@garmin.com>

The close-on-fork flag causes the file descriptor to be closed
atomically in the child process before the child process returns
from fork(). Implement this feature and provide a method to
get/set the close-on-fork flag using fcntl(2).

This functionality was approved by the Austin Common Standards
Revision Group for inclusion in the next revision of the POSIX
standard (see issue 1318 in the Austin Group Defect Tracker).

Co-developed-by: Changli Gao <xiaosuo@gmail.com>
Signed-off-by: Changli Gao <xiaosuo@gmail.com>
Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
---
 fs/fcntl.c                             |  2 ++
 fs/file.c                              | 50 +++++++++++++++++++++++++-
 include/linux/fdtable.h                |  7 ++++
 include/linux/file.h                   |  2 ++
 include/uapi/asm-generic/fcntl.h       |  5 +--
 tools/include/uapi/asm-generic/fcntl.h |  5 +--
 6 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..23964abf4a1a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -335,10 +335,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_GETFD:
 		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
+		err |= get_close_on_fork(fd) ? FD_CLOFORK : 0;
 		break;
 	case F_SETFD:
 		err = 0;
 		set_close_on_exec(fd, arg & FD_CLOEXEC);
+		set_close_on_fork(fd, arg & FD_CLOFORK);
 		break;
 	case F_GETFL:
 		err = filp->f_flags;
diff --git a/fs/file.c b/fs/file.c
index c8a4e4c86e55..de7260ba718d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -57,6 +57,8 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
 	memset((char *)nfdt->open_fds + cpy, 0, set);
 	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
 	memset((char *)nfdt->close_on_exec + cpy, 0, set);
+	memcpy(nfdt->close_on_fork, ofdt->close_on_fork, cpy);
+	memset((char *)nfdt->close_on_fork + cpy, 0, set);
 
 	cpy = BITBIT_SIZE(count);
 	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
@@ -118,7 +120,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	fdt->fd = data;
 
 	data = kvmalloc(max_t(size_t,
-				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
+				 3 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
 				 GFP_KERNEL_ACCOUNT);
 	if (!data)
 		goto out_arr;
@@ -126,6 +128,8 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	data += nr / BITS_PER_BYTE;
 	fdt->close_on_exec = data;
 	data += nr / BITS_PER_BYTE;
+	fdt->close_on_fork = data;
+	data += nr / BITS_PER_BYTE;
 	fdt->full_fds_bits = data;
 
 	return fdt;
@@ -236,6 +240,17 @@ static inline void __clear_close_on_exec(unsigned int fd, struct fdtable *fdt)
 		__clear_bit(fd, fdt->close_on_exec);
 }
 
+static inline void __set_close_on_fork(unsigned int fd, struct fdtable *fdt)
+{
+	__set_bit(fd, fdt->close_on_fork);
+}
+
+static inline void __clear_close_on_fork(unsigned int fd, struct fdtable *fdt)
+{
+	if (test_bit(fd, fdt->close_on_fork))
+		__clear_bit(fd, fdt->close_on_fork);
+}
+
 static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
 {
 	__set_bit(fd, fdt->open_fds);
@@ -290,6 +305,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 	new_fdt = &newf->fdtab;
 	new_fdt->max_fds = NR_OPEN_DEFAULT;
 	new_fdt->close_on_exec = newf->close_on_exec_init;
+	new_fdt->close_on_fork = newf->close_on_fork_init;
 	new_fdt->open_fds = newf->open_fds_init;
 	new_fdt->full_fds_bits = newf->full_fds_bits_init;
 	new_fdt->fd = &newf->fd_array[0];
@@ -337,6 +353,12 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 
 	for (i = open_files; i != 0; i--) {
 		struct file *f = *old_fds++;
+
+		if (test_bit(open_files - i, new_fdt->close_on_fork)) {
+			__clear_bit(open_files - i, new_fdt->open_fds);
+			f = NULL;
+		}
+
 		if (f) {
 			get_file(f);
 		} else {
@@ -453,6 +475,7 @@ struct files_struct init_files = {
 		.max_fds	= NR_OPEN_DEFAULT,
 		.fd		= &init_files.fd_array[0],
 		.close_on_exec	= init_files.close_on_exec_init,
+		.close_on_fork	= init_files.close_on_fork_init,
 		.open_fds	= init_files.open_fds_init,
 		.full_fds_bits	= init_files.full_fds_bits_init,
 	},
@@ -865,6 +888,31 @@ bool get_close_on_exec(unsigned int fd)
 	return res;
 }
 
+void set_close_on_fork(unsigned int fd, int flag)
+{
+	struct files_struct *files = current->files;
+	struct fdtable *fdt;
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	if (flag)
+		__set_close_on_fork(fd, fdt);
+	else
+		__clear_close_on_fork(fd, fdt);
+	spin_unlock(&files->file_lock);
+}
+
+bool get_close_on_fork(unsigned int fd)
+{
+	struct files_struct *files = current->files;
+	struct fdtable *fdt;
+	bool res;
+	rcu_read_lock();
+	fdt = files_fdtable(files);
+	res = close_on_fork(fd, fdt);
+	rcu_read_unlock();
+	return res;
+}
+
 static int do_dup2(struct files_struct *files,
 	struct file *file, unsigned fd, unsigned flags)
 __releases(&files->file_lock)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index f07c55ea0c22..61c551947fa3 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -27,6 +27,7 @@ struct fdtable {
 	unsigned int max_fds;
 	struct file __rcu **fd;      /* current fd array */
 	unsigned long *close_on_exec;
+	unsigned long *close_on_fork;
 	unsigned long *open_fds;
 	unsigned long *full_fds_bits;
 	struct rcu_head rcu;
@@ -37,6 +38,11 @@ static inline bool close_on_exec(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->close_on_exec);
 }
 
+static inline bool close_on_fork(unsigned int fd, const struct fdtable *fdt)
+{
+	return test_bit(fd, fdt->close_on_fork);
+}
+
 static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 {
 	return test_bit(fd, fdt->open_fds);
@@ -61,6 +67,7 @@ struct files_struct {
 	spinlock_t file_lock ____cacheline_aligned_in_smp;
 	unsigned int next_fd;
 	unsigned long close_on_exec_init[1];
+	unsigned long close_on_fork_init[1];
 	unsigned long open_fds_init[1];
 	unsigned long full_fds_bits_init[1];
 	struct file __rcu * fd_array[NR_OPEN_DEFAULT];
diff --git a/include/linux/file.h b/include/linux/file.h
index 142d102f285e..86fbb36b438b 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -85,6 +85,8 @@ extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
 extern bool get_close_on_exec(unsigned int fd);
+extern void set_close_on_fork(unsigned int fd, int flag);
+extern bool get_close_on_fork(unsigned int fd);
 extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..0cb7199a7743 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -98,8 +98,8 @@
 #endif
 
 #define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
+#define F_GETFD		1	/* get close_on_exec & close_on_fork */
+#define F_SETFD		2	/* set/clear close_on_exec & close_on_fork */
 #define F_GETFL		3	/* get file->f_flags */
 #define F_SETFL		4	/* set file->f_flags */
 #ifndef F_GETLK
@@ -160,6 +160,7 @@ struct f_owner_ex {
 
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+#define FD_CLOFORK	2
 
 /* for posix fcntl() and lockf() */
 #ifndef F_RDLCK
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index ac190958c981..e04a00fecb4a 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -97,8 +97,8 @@
 #endif
 
 #define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get close_on_exec */
-#define F_SETFD		2	/* set/clear close_on_exec */
+#define F_GETFD		1	/* get close_on_exec & close_on_fork */
+#define F_SETFD		2	/* set/clear close_on_exec & close_on_fork */
 #define F_GETFL		3	/* get file->f_flags */
 #define F_SETFL		4	/* set file->f_flags */
 #ifndef F_GETLK
@@ -159,6 +159,7 @@ struct f_owner_ex {
 
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
+#define FD_CLOFORK	2
 
 /* for posix fcntl() and lockf() */
 #ifndef F_RDLCK
-- 
2.26.1
