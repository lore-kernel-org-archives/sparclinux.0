From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 19:42:32 +0000
Subject: [PATCH] display7seg: implement ->unlocked_ioctl and ->compat_ioctl
Message-Id: <20051107194232.GD32019@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

all ioctls are 32bit compat clean, so the driver can use ->compat_ioctl
and ->unlocked_ioctl easily.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:55:40.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:56:00.000000000 +0100
@@ -121,9 +121,6 @@
 /* Little v, the video4linux ioctls */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
-/* COMPATIBLE_IOCTL(D7SIOCRD) same value as ENVCTRL_RD_VOLTAGE_STATUS */
-COMPATIBLE_IOCTL(D7SIOCWR)
-COMPATIBLE_IOCTL(D7SIOCTM)
 COMPATIBLE_IOCTL(WIOCSTART)
 COMPATIBLE_IOCTL(WIOCSTOP)
 COMPATIBLE_IOCTL(WIOCGSTAT)
Index: linux-2.6/drivers/sbus/char/display7seg.c
=================================--- linux-2.6.orig/drivers/sbus/char/display7seg.c	2005-11-07 11:53:44.000000000 +0100
+++ linux-2.6/drivers/sbus/char/display7seg.c	2005-11-07 11:55:48.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/ioport.h>		/* request_region */
+#include <linux/smp_lock.h>
 #include <asm/atomic.h>
 #include <asm/ebus.h>			/* EBus device					*/
 #include <asm/oplib.h>			/* OpenProm Library 			*/
@@ -114,22 +115,25 @@
 	return 0;
 }
 
-static int d7s_ioctl(struct inode *inode, struct file *f, 
-		     unsigned int cmd, unsigned long arg)
+static long d7s_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	__u8 regs = readb(d7s_regs);
 	__u8 ireg = 0;
+	int error = 0
 
-	if (D7S_MINOR != iminor(inode))
+	if (D7S_MINOR != iminor(file->f_dentry->d_inode))
 		return -ENODEV;
 
+	lock_kernel();
 	switch (cmd) {
 	case D7SIOCWR:
 		/* assign device register values
 		 * we mask-out D7S_FLIP if in sol_compat mode
 		 */
-		if (get_user(ireg, (int __user *) arg))
-			return -EFAULT;
+		if (get_user(ireg, (int __user *) arg)) {
+			error = -EFAULT;
+			break;
+		}
 		if (0 != sol_compat) {
 			(regs & D7S_FLIP) ? 
 				(ireg |= D7S_FLIP) : (ireg &= ~D7S_FLIP);
@@ -144,8 +148,10 @@
 		 * This driver will not misinform you about the state
 		 * of your hardware while in sol_compat mode
 		 */
-		if (put_user(regs, (int __user *) arg))
-			return -EFAULT;
+		if (put_user(regs, (int __user *) arg)) {
+			error = -EFAULT;
+			break;
+		}
 		break;
 
 	case D7SIOCTM:
@@ -155,15 +161,17 @@
 		writeb(regs, d7s_regs);
 		break;
 	};
+	lock_kernel();
 
-	return 0;
+	return error;
 }
 
 static struct file_operations d7s_fops = {
-	.owner =	THIS_MODULE,
-	.ioctl =	d7s_ioctl,
-	.open =		d7s_open,
-	.release =	d7s_release,
+	.owner =		THIS_MODULE,
+	.unlocked_ioctl =	d7s_ioctl,
+	.compat_ioctl =		d7s_ioctl,
+	.open =			d7s_open,
+	.release =		d7s_release,
 };
 
 static struct miscdevice d7s_miscdev = { D7S_MINOR, D7S_DEVNAME, &d7s_fops };
