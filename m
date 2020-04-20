From: Nate Karstens <nate.karstens@garmin.com>
Date: Mon, 20 Apr 2020 07:15:46 +0000
Subject: [PATCH 2/4] fs: Add O_CLOFORK flag for open(2) and dup3(2)
Message-Id: <20200420071548.62112-3-nate.karstens@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
In-Reply-To: <20200420071548.62112-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>, Nate Karstens <nate.karstens@garmin.com>

Add the O_CLOFORK flag to open(2) and dup3(2) to automatically
set the close-on-fork flag in the new file descriptor, saving
a separate call to fcntl(2).

Co-developed-by: Changli Gao <xiaosuo@gmail.com>
Signed-off-by: Changli Gao <xiaosuo@gmail.com>
Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
---
 arch/alpha/include/uapi/asm/fcntl.h    |  2 ++
 arch/parisc/include/uapi/asm/fcntl.h   | 39 +++++++++++++-------------
 arch/sparc/include/uapi/asm/fcntl.h    |  1 +
 fs/fcntl.c                             |  2 +-
 fs/file.c                              | 10 ++++++-
 include/linux/fcntl.h                  |  2 +-
 include/uapi/asm-generic/fcntl.h       |  4 +++
 tools/include/uapi/asm-generic/fcntl.h |  4 +++
 8 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..fbab69b15f7f 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -35,6 +35,8 @@
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
 
+#define O_CLOFORK	0200000000 /* set close_on_fork */
+
 #define F_GETLK		7
 #define F_SETLK		8
 #define F_SETLKW	9
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03ce20e5ad7d..8f5989e75b05 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -2,26 +2,27 @@
 #ifndef _PARISC_FCNTL_H
 #define _PARISC_FCNTL_H
 
-#define O_APPEND	000000010
-#define O_BLKSEEK	000000100 /* HPUX only */
-#define O_CREAT		000000400 /* not fcntl */
-#define O_EXCL		000002000 /* not fcntl */
-#define O_LARGEFILE	000004000
-#define __O_SYNC	000100000
+#define O_APPEND	0000000010
+#define O_BLKSEEK	0000000100 /* HPUX only */
+#define O_CREAT		0000000400 /* not fcntl */
+#define O_EXCL		0000002000 /* not fcntl */
+#define O_LARGEFILE	0000004000
+#define __O_SYNC	0000100000
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_NONBLOCK	000200004 /* HPUX has separate NDELAY & NONBLOCK */
-#define O_NOCTTY	000400000 /* not fcntl */
-#define O_DSYNC		001000000 /* HPUX only */
-#define O_RSYNC		002000000 /* HPUX only */
-#define O_NOATIME	004000000
-#define O_CLOEXEC	010000000 /* set close_on_exec */
-
-#define O_DIRECTORY	000010000 /* must be a directory */
-#define O_NOFOLLOW	000000200 /* don't follow links */
-#define O_INVISIBLE	004000000 /* invisible I/O, for DMAPI/XDSM */
-
-#define O_PATH		020000000
-#define __O_TMPFILE	040000000
+#define O_NONBLOCK	0000200004 /* HPUX has separate NDELAY & NONBLOCK */
+#define O_NOCTTY	0000400000 /* not fcntl */
+#define O_DSYNC		0001000000 /* HPUX only */
+#define O_RSYNC		0002000000 /* HPUX only */
+#define O_NOATIME	0004000000
+#define O_CLOEXEC	0010000000 /* set close_on_exec */
+
+#define O_DIRECTORY	0000010000 /* must be a directory */
+#define O_NOFOLLOW	0000000200 /* don't follow links */
+#define O_INVISIBLE	0004000000 /* invisible I/O, for DMAPI/XDSM */
+
+#define O_PATH		0020000000
+#define __O_TMPFILE	0040000000
+#define O_CLOFORK	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..d631ea13bac3 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define O_CLOFORK	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 23964abf4a1a..b59b27c3a338 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1035,7 +1035,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ ! 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/file.c b/fs/file.c
index de7260ba718d..95774b7962d1 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -544,6 +544,10 @@ int __alloc_fd(struct files_struct *files,
 		__set_close_on_exec(fd, fdt);
 	else
 		__clear_close_on_exec(fd, fdt);
+	if (flags & O_CLOFORK)
+		__set_close_on_fork(fd, fdt);
+	else
+		__clear_close_on_fork(fd, fdt);
 	error = fd;
 #if 1
 	/* Sanity check */
@@ -945,6 +949,10 @@ __releases(&files->file_lock)
 		__set_close_on_exec(fd, fdt);
 	else
 		__clear_close_on_exec(fd, fdt);
+	if (flags & O_CLOFORK)
+		__set_close_on_fork(fd, fdt);
+	else
+		__clear_close_on_fork(fd, fdt);
 	spin_unlock(&files->file_lock);
 
 	if (tofree)
@@ -985,7 +993,7 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 	struct file *file;
 	struct files_struct *files = current->files;
 
-	if ((flags & ~O_CLOEXEC) != 0)
+	if ((flags & ~(O_CLOEXEC | O_CLOFORK)) != 0)
 		return -EINVAL;
 
 	if (unlikely(oldfd = newfd))
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..cd4c625647db 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_CLOFORK)
 
 /* List of all valid flags for the how->upgrade_mask argument: */
 #define VALID_UPGRADE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 0cb7199a7743..165a0736a3aa 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_CLOFORK
+#define O_CLOFORK	040000000	/* set close_on_fork */
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index e04a00fecb4a..69d8a000ec65 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_CLOFORK
+#define O_CLOFORK	040000000	/* set close_on_fork */
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)
-- 
2.26.1
