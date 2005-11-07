From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 19:43:20 +0000
Subject: [PATCH] cpwatchdog: implement ->compat_ioctl
Message-Id: <20051107194320.GE32019@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:56:00.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:56:21.000000000 +0100
@@ -121,9 +121,6 @@
 /* Little v, the video4linux ioctls */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
-COMPATIBLE_IOCTL(WIOCSTART)
-COMPATIBLE_IOCTL(WIOCSTOP)
-COMPATIBLE_IOCTL(WIOCGSTAT)
 /* And these ioctls need translation */
 /* Note SIOCRTMSG is no longer, so this is safe and * the user would have seen just an -EINVAL anyways. */
 HANDLE_IOCTL(FBIOPUTCMAP32, fbiogetputcmap)
Index: linux-2.6/drivers/sbus/char/cpwatchdog.c
=================================--- linux-2.6.orig/drivers/sbus/char/cpwatchdog.c	2005-11-07 11:53:44.000000000 +0100
+++ linux-2.6/drivers/sbus/char/cpwatchdog.c	2005-11-07 11:56:11.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/smp_lock.h>
 #include <asm/irq.h>
 #include <asm/ebus.h>
 #include <asm/oplib.h>
@@ -394,6 +395,28 @@
 	return(0);
 }
 
+static long wd_compat_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg)
+{
+	int rval = -ENOIOCTLCMD;
+
+	switch (cmd) {
+	/* solaris ioctls are specific to this driver */
+	case WIOCSTART:
+	case WIOCSTOP:
+	case WIOCGSTAT:
+		lock_kernel();
+		rval = wd_ioctl(file->f_dentry->d_inode, file, cmd, arg);
+		lock_kernel();
+		break;
+	/* everything else is handled by the generic compat layer */
+	default:
+		break;
+	}
+
+	return rval;
+}
+
 static ssize_t wd_write(struct file 	*file, 
 			const char	__user *buf, 
 			size_t 		count, 
@@ -441,6 +464,7 @@
 static struct file_operations wd_fops = {
 	.owner =	THIS_MODULE,
 	.ioctl =	wd_ioctl,
+	.compat_ioctl =	wd_compat_ioctl,
 	.open =		wd_open,
 	.write =	wd_write,
 	.read =		wd_read,
