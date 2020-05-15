From: Nate Karstens <nate.karstens@garmin.com>
Date: Fri, 15 May 2020 15:23:18 +0000
Subject: [PATCH v2 1/4] fs: Implement close-on-fork
Message-Id: <20200515152321.9280-2-nate.karstens@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
In-Reply-To: <20200515152321.9280-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>, Nate Karstens <nate.karstens@garmin.com>

The close-on-fork flag causes the file descriptor to be closed
atomically in the child process before the child process returns
from fork(). Implement this feature and provide a method to
get/set the close-on-fork flag using fcntl(2).

This functionality was approved by the Austin Common Standards
Revision Group for inclusion in the next revision of the POSIX
standard (see issue 1318 in the Austin Group Defect Tracker).

If clone(2) is used to create a child process and the CLONE_FILES
flag is set, then both processes will share the table of file
descriptors and the state of the close-on-fork flag for any
individual file descriptor. If unshare(2) is later used to stop
sharing the file descriptor table, then any file descriptor with
the close-on-fork flag set will be closed in the process that
calls unshare(2).

execve(2) also causes the file descriptor table to be unshared,
so any file descriptor with the close-on-fork flag set will be
closed in the process that calls execve(2).

Co-developed-by: Changli Gao <xiaosuo@gmail.com>
Signed-off-by: Changli Gao <xiaosuo@gmail.com>
Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
---
 fs/fcntl.c                             |  4 +-
 fs/file.c                              | 64 ++++++++++++++++++++++++--
 include/linux/fdtable.h                |  7 +++
 include/linux/file.h                   |  2 +
 include/uapi/asm-generic/fcntl.h       |  5 +-
 tools/include/uapi/asm-generic/fcntl.h |  5 +-
 6 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..913b0cb70804 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -334,11 +334,11 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = f_dupfd(arg, filp, O_CLOEXEC);
 		break;
 	case F_GETFD:
-		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
+		err = f_getfd(fd);
 		break;
 	case F_SETFD:
 		err = 0;
-		set_close_on_exec(fd, arg & FD_CLOEXEC);
+		f_setfd(fd, arg);
 		break;
 	case F_GETFL:
 		err = filp->f_flags;
diff --git a/fs/file.c b/fs/file.c
index c8a4e4c86e55..81194349e980 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -47,7 +47,7 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
  * spinlock held for write.
  */
 static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
-			    unsigned int count)
+			    unsigned int count, bool copy_cof)
 {
 	unsigned int cpy, set;
 
@@ -58,6 +58,13 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
 	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
 	memset((char *)nfdt->close_on_exec + cpy, 0, set);
 
+	if (copy_cof) {
+		memcpy(nfdt->close_on_fork, ofdt->close_on_fork, cpy);
+		memset((char *)nfdt->close_on_fork + cpy, 0, set);
+	} else {
+		memset((char *)nfdt->close_on_fork, 0, cpy + set);
+	}
+
 	cpy = BITBIT_SIZE(count);
 	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
 	memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
@@ -79,7 +86,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds, true);
 }
 
 static struct fdtable * alloc_fdtable(unsigned int nr)
@@ -118,7 +125,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	fdt->fd = data;
 
 	data = kvmalloc(max_t(size_t,
-				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
+				 3 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
 				 GFP_KERNEL_ACCOUNT);
 	if (!data)
 		goto out_arr;
@@ -126,6 +133,8 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	data += nr / BITS_PER_BYTE;
 	fdt->close_on_exec = data;
 	data += nr / BITS_PER_BYTE;
+	fdt->close_on_fork = data;
+	data += nr / BITS_PER_BYTE;
 	fdt->full_fds_bits = data;
 
 	return fdt;
@@ -236,6 +245,17 @@ static inline void __clear_close_on_exec(unsigned int fd, struct fdtable *fdt)
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
@@ -290,6 +310,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 	new_fdt = &newf->fdtab;
 	new_fdt->max_fds = NR_OPEN_DEFAULT;
 	new_fdt->close_on_exec = newf->close_on_exec_init;
+	new_fdt->close_on_fork = newf->close_on_fork_init;
 	new_fdt->open_fds = newf->open_fds_init;
 	new_fdt->full_fds_bits = newf->full_fds_bits_init;
 	new_fdt->fd = &newf->fd_array[0];
@@ -330,13 +351,17 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 		open_files = count_open_files(old_fdt);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files, false);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
 
 	for (i = open_files; i != 0; i--) {
 		struct file *f = *old_fds++;
+
+		if (close_on_fork(open_files - i, old_fdt))
+			f = NULL;
+
 		if (f) {
 			get_file(f);
 		} else {
@@ -453,6 +478,7 @@ struct files_struct init_files = {
 		.max_fds	= NR_OPEN_DEFAULT,
 		.fd		= &init_files.fd_array[0],
 		.close_on_exec	= init_files.close_on_exec_init,
+		.close_on_fork	= init_files.close_on_fork_init,
 		.open_fds	= init_files.open_fds_init,
 		.full_fds_bits	= init_files.full_fds_bits_init,
 	},
@@ -840,6 +866,36 @@ void __f_unlock_pos(struct file *f)
  * file count (done either by fdget() or by fork()).
  */
 
+void f_setfd(unsigned int fd, int flags)
+{
+	struct files_struct *files = current->files;
+	struct fdtable *fdt;
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	if (flags & FD_CLOEXEC)
+		__set_close_on_exec(fd, fdt);
+	else
+		__clear_close_on_exec(fd, fdt);
+	if (flags & FD_CLOFORK)
+		__set_close_on_fork(fd, fdt);
+	else
+		__clear_close_on_fork(fd, fdt);
+	spin_unlock(&files->file_lock);
+}
+
+int f_getfd(unsigned int fd)
+{
+	struct files_struct *files = current->files;
+	struct fdtable *fdt;
+	int flags;
+	rcu_read_lock();
+	fdt = files_fdtable(files);
+	flags = (close_on_exec(fd, fdt) ? FD_CLOEXEC : 0) |
+	        (close_on_fork(fd, fdt) ? FD_CLOFORK : 0);
+	rcu_read_unlock();
+	return flags;
+}
+
 void set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
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
index 142d102f285e..0ee15ee24010 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -83,6 +83,8 @@ static inline void fdput_pos(struct fd f)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
+extern int f_getfd(unsigned int fd);
+extern void f_setfd(unsigned int fd, int flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
 extern bool get_close_on_exec(unsigned int fd);
 extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
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
