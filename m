From: Aleksa Sarai <asarai@suse.de>
Date: Sat, 03 Jun 2017 14:15:14 +0000
Subject: [PATCH v4 1/2] tty: add compat_ioctl callbacks
Message-Id: <20170603141515.9529-2-asarai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170603141515.9529-1-asarai@suse.de>
In-Reply-To: <20170603141515.9529-1-asarai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>, Aleksa Sarai <asarai@suse.de>

In order to avoid future diversions between fs/compat_ioctl.c and
drivers/tty/pty.c, define .compat_ioctl callbacks for the relevant
tty_operations structs. Since both pty_unix98_ioctl() and
pty_bsd_ioctl() are compatible between 32-bit and 64-bit userspace no
special translation is required.

Signed-off-by: Aleksa Sarai <asarai@suse.de>
---
 drivers/tty/pty.c | 22 ++++++++++++++++++++++
 fs/compat_ioctl.c |  6 ------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 65799575c666..2a6bd9ae3f8b 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -481,6 +481,16 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
+static long pty_bsd_compat_ioctl(struct tty_struct *tty,
+				 unsigned int cmd, unsigned long arg)
+{
+	/*
+	 * PTY ioctls don't require any special translation between 32-bit and
+	 * 64-bit userspace, they are already compatible.
+	 */
+	return pty_bsd_ioctl(tty, cmd, arg);
+}
+
 static int legacy_count = CONFIG_LEGACY_PTY_COUNT;
 /*
  * not really modular, but the easiest way to keep compat with existing
@@ -502,6 +512,7 @@ static const struct tty_operations master_pty_ops_bsd = {
 	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
 	.ioctl = pty_bsd_ioctl,
+	.compat_ioctl = pty_bsd_compat_ioctl,
 	.cleanup = pty_cleanup,
 	.resize = pty_resize,
 	.remove = pty_remove
@@ -609,6 +620,16 @@ static int pty_unix98_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
+static long pty_unix98_compat_ioctl(struct tty_struct *tty,
+				 unsigned int cmd, unsigned long arg)
+{
+	/*
+	 * PTY ioctls don't require any special translation between 32-bit and
+	 * 64-bit userspace, they are already compatible.
+	 */
+	return pty_unix98_ioctl(tty, cmd, arg);
+}
+
 /**
  *	ptm_unix98_lookup	-	find a pty master
  *	@driver: ptm driver
@@ -681,6 +702,7 @@ static const struct tty_operations ptm_unix98_ops = {
 	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
 	.ioctl = pty_unix98_ioctl,
+	.compat_ioctl = pty_unix98_compat_ioctl,
 	.resize = pty_resize,
 	.cleanup = pty_cleanup
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 6116d5275a3e..112b3e1e20e3 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -866,8 +866,6 @@ COMPATIBLE_IOCTL(TIOCGDEV)
 COMPATIBLE_IOCTL(TIOCCBRK)
 COMPATIBLE_IOCTL(TIOCGSID)
 COMPATIBLE_IOCTL(TIOCGICOUNT)
-COMPATIBLE_IOCTL(TIOCGPKT)
-COMPATIBLE_IOCTL(TIOCGPTLCK)
 COMPATIBLE_IOCTL(TIOCGEXCL)
 /* Little t */
 COMPATIBLE_IOCTL(TIOCGETD)
@@ -883,16 +881,12 @@ COMPATIBLE_IOCTL(TIOCMGET)
 COMPATIBLE_IOCTL(TIOCMBIC)
 COMPATIBLE_IOCTL(TIOCMBIS)
 COMPATIBLE_IOCTL(TIOCMSET)
-COMPATIBLE_IOCTL(TIOCPKT)
 COMPATIBLE_IOCTL(TIOCNOTTY)
 COMPATIBLE_IOCTL(TIOCSTI)
 COMPATIBLE_IOCTL(TIOCOUTQ)
 COMPATIBLE_IOCTL(TIOCSPGRP)
 COMPATIBLE_IOCTL(TIOCGPGRP)
-COMPATIBLE_IOCTL(TIOCGPTN)
-COMPATIBLE_IOCTL(TIOCSPTLCK)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
-COMPATIBLE_IOCTL(TIOCSIG)
 #ifdef TIOCSRS485
 COMPATIBLE_IOCTL(TIOCSRS485)
 #endif
-- 
2.13.0

