From: Aleksa Sarai <asarai@suse.de>
Date: Thu, 01 Jun 2017 17:38:03 +0000
Subject: [PATCH] tty: add TIOCGPTPEER ioctl
Message-Id: <20170601173803.8698-1-asarai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Aleksa Sarai <asarai@suse.de>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>

When opening the slave end of a PTY, it is not possible for userspace to
safely ensure that /dev/pts/$num is actually a slave (in cases where the
mount namespace in which devpts was mounted is controlled by an
untrusted process). In addition, there are several unresolvable
race conditions if userspace were to attempt to detect attacks through
stat(2) and other similar methods [in addition it is not clear how
userspace could detect attacks involving FUSE].

Resolve this by providing an interface for userpace to safely open the
"peer" end of a PTY file descriptor by using the dentry cached by
devpts. Since it is not possible to have an open master PTY without
having its slave exposed in /dev/pts this interface is safe. This
interface currently does not provide a way to get the master pty (since
it is not clear whether such an interface is safe or even useful).

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Valentin Rothberg <vrothberg@suse.com>
Signed-off-by: Aleksa Sarai <asarai@suse.de>
---
 arch/alpha/include/uapi/asm/ioctls.h   |  1 +
 arch/mips/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/ioctls.h  |  1 +
 arch/powerpc/include/uapi/asm/ioctls.h |  1 +
 arch/sh/include/uapi/asm/ioctls.h      |  1 +
 arch/sparc/include/uapi/asm/ioctls.h   |  3 +-
 arch/xtensa/include/uapi/asm/ioctls.h  |  1 +
 drivers/tty/pty.c                      | 71 ++++++++++++++++++++++++++++++++--
 include/uapi/asm-generic/ioctls.h      |  1 +
 9 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index f30c94ae1bdb..f6ec120fdccd 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -94,6 +94,7 @@
 #define TIOCSRS485	_IOWR('T', 0x2F, struct serial_rs485)
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
 #define TIOCVHANGUP	0x5437
diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index 740219c2c894..6a44a4d82a6f 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -85,6 +85,7 @@
 #define TIOCSRS485	_IOWR('T', 0x2F, struct serial_rs485)
 #define TIOCGPTN	_IOR('T', 0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T', 0x31, int)  /* Lock/unlock Pty */
+#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
 #define TIOCGDEV	_IOR('T', 0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T', 0x36, int)  /* Generate signal on Pty slave */
 #define TIOCVHANGUP	0x5437
diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index b6572f051b67..b89a7029a83f 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -54,6 +54,7 @@
 #define TIOCSRS485	_IOWR('T', 0x2F, struct serial_rs485)
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
 #define TIOCGDEV	_IOR('T',0x32, int)  /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
 #define TIOCVHANGUP	0x5437
diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index 49a25796a61a..28ccc176e403 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -94,6 +94,7 @@
 #define TIOCSRS485	0x542f
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
 #define TIOCVHANGUP	0x5437
diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm/ioctls.h
index c9903e56ccf4..c155812f75db 100644
--- a/arch/sh/include/uapi/asm/ioctls.h
+++ b/arch/sh/include/uapi/asm/ioctls.h
@@ -87,6 +87,7 @@
 #define TIOCSRS485	_IOWR('T', 47, struct serial_rs485)
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
 #define TIOCVHANGUP	_IO('T', 0x37)
diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 06b3f6c3bb9a..6d27398632ea 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -27,7 +27,7 @@
 #define TIOCGRS485	_IOR('T', 0x41, struct serial_rs485)
 #define TIOCSRS485	_IOWR('T', 0x42, struct serial_rs485)
 
-/* Note that all the ioctls that are not available in Linux have a 
+/* Note that all the ioctls that are not available in Linux have a
  * double underscore on the front to: a) avoid some programs to
  * think we support some ioctls under Linux (autoconfiguration stuff)
  */
@@ -88,6 +88,7 @@
 #define TIOCGPTN	_IOR('t', 134, unsigned int) /* Get Pty Number */
 #define TIOCSPTLCK	_IOW('t', 135, int) /* Lock/unlock PTY */
 #define TIOCSIG		_IOW('t', 136, int) /* Generate signal on Pty slave */
+#define TIOCGPTPEER	_IOR('t', 137, int) /* Safely open the slave */
 
 /* Little f */
 #define FIOCLEX		_IO('f', 1)
diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/uapi/asm/ioctls.h
index 518954e74e6d..71f0a979647e 100644
--- a/arch/xtensa/include/uapi/asm/ioctls.h
+++ b/arch/xtensa/include/uapi/asm/ioctls.h
@@ -99,6 +99,7 @@
 #define TIOCSRS485	_IOWR('T', 47, struct serial_rs485)
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
 #define TIOCVHANGUP	_IO('T', 0x37)
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 65799575c666..19c134ca47bb 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -24,6 +24,9 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
+#include <linux/mount.h>
+#include <linux/file.h>
+#include <linux/ioctl.h>
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
@@ -66,8 +69,13 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 #ifdef CONFIG_UNIX98_PTYS
 		if (tty->driver = ptm_driver) {
 			mutex_lock(&devpts_mutex);
-			if (tty->link->driver_data)
-				devpts_pty_kill(tty->link->driver_data);
+			if (tty->link->driver_data) {
+				struct path *path = tty->link->driver_data;
+
+				devpts_pty_kill(path->dentry);
+				path_put(path);
+				kfree(path);
+			}
 			mutex_unlock(&devpts_mutex);
 		}
 #endif
@@ -440,6 +448,48 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 	return retval;
 }
 
+/**
+ *	pty_open_peer - open the peer of a pty
+ *	@tty: the peer of the pty being opened
+ *
+ *	Open the cached dentry in tty->link, providing a safe way for userspace
+ *	to get the slave end of a pty (where they have the master fd and cannot
+ *	access or trust the mount namespace /dev/pts was mounted inside).
+ */
+static struct file *pty_open_peer(struct tty_struct *tty, int flags)
+{
+	if (tty->driver->subtype != PTY_TYPE_MASTER)
+		return ERR_PTR(-EIO);
+	return dentry_open(tty->link->driver_data, flags, current_cred());
+}
+
+static int pty_get_peer(struct tty_struct *tty, int flags)
+{
+	int fd = -1;
+	struct file *filp = NULL;
+	int retval = -EINVAL;
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0) {
+		retval = fd;
+		goto err;
+	}
+
+	filp = pty_open_peer(tty, flags);
+	if (IS_ERR(filp)) {
+		retval = PTR_ERR(filp);
+		goto err_put;
+	}
+
+	fd_install(fd, filp);
+	return fd;
+
+err_put:
+	put_unused_fd(fd);
+err:
+	return retval;
+}
+
 static void pty_cleanup(struct tty_struct *tty)
 {
 	tty_port_put(tty->port);
@@ -602,6 +652,8 @@ static int pty_unix98_ioctl(struct tty_struct *tty,
 		return pty_get_pktmode(tty, (int __user *)arg);
 	case TIOCGPTN: /* Get PT Number */
 		return put_user(tty->index, (unsigned int __user *)arg);
+	case TIOCGPTPEER: /* Open the other end */
+		return pty_get_peer(tty, (int) arg);
 	case TIOCSIG:    /* Send signal to other side of pty */
 		return pty_signal(tty, (int) arg);
 	}
@@ -718,6 +770,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 {
 	struct pts_fs_info *fsi;
 	struct tty_struct *tty;
+	struct path *pts_path;
 	struct dentry *dentry;
 	int retval;
 	int index;
@@ -771,16 +824,26 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 		retval = PTR_ERR(dentry);
 		goto err_release;
 	}
-	tty->link->driver_data = dentry;
+	/* We need to cache a fake path for TIOCGPTPEER. */
+	pts_path = kmalloc(sizeof(struct path), GFP_KERNEL);
+	if (!pts_path)
+		goto err_release;
+	pts_path->mnt = filp->f_path.mnt;
+	pts_path->dentry = dentry;
+	path_get(pts_path);
+	tty->link->driver_data = pts_path;
 
 	retval = ptm_driver->ops->open(tty, filp);
 	if (retval)
-		goto err_release;
+		goto err_path_put;
 
 	tty_debug_hangup(tty, "opening (count=%d)\n", tty->count);
 
 	tty_unlock(tty);
 	return 0;
+err_path_put:
+	path_put(pts_path);
+	kfree(pts_path);
 err_release:
 	tty_unlock(tty);
 	// This will also put-ref the fsi
diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
index 143dacbb7d9a..e836dc677612 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -67,6 +67,7 @@
 #endif
 #define TIOCGPTN	_IOR('T', 0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T', 0x31, int)  /* Lock/unlock Pty */
+#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
 #define TIOCGDEV	_IOR('T', 0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TCGETX		0x5432 /* SYS5 TCGETX compatibility */
 #define TCSETX		0x5433
-- 
2.13.0

