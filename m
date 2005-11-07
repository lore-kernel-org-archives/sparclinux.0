From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 19:39:56 +0000
Subject: [PATCH] envctrl: implement ->unlocked_ioctl and ->compat_ioctl
Message-Id: <20051107193956.GB32019@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

all the ioctls in the driver are 32bit compat clean and don't need BKL,
so we can switch it to ->unlocked_ioctl and ->compat_ioctl trivially.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:55:16.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:55:17.000000000 +0100
@@ -121,16 +121,6 @@
 /* Little v, the video4linux ioctls */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
-COMPATIBLE_IOCTL(ENVCTRL_RD_WARNING_TEMPERATURE)
-COMPATIBLE_IOCTL(ENVCTRL_RD_SHUTDOWN_TEMPERATURE)
-COMPATIBLE_IOCTL(ENVCTRL_RD_CPU_TEMPERATURE)
-COMPATIBLE_IOCTL(ENVCTRL_RD_FAN_STATUS)
-COMPATIBLE_IOCTL(ENVCTRL_RD_VOLTAGE_STATUS)
-COMPATIBLE_IOCTL(ENVCTRL_RD_SCSI_TEMPERATURE)
-COMPATIBLE_IOCTL(ENVCTRL_RD_ETHERNET_TEMPERATURE)
-COMPATIBLE_IOCTL(ENVCTRL_RD_MTHRBD_TEMPERATURE)
-COMPATIBLE_IOCTL(ENVCTRL_RD_CPU_VOLTAGE)
-COMPATIBLE_IOCTL(ENVCTRL_RD_GLOBALADDRESS)
 /* COMPATIBLE_IOCTL(D7SIOCRD) same value as ENVCTRL_RD_VOLTAGE_STATUS */
 COMPATIBLE_IOCTL(D7SIOCWR)
 COMPATIBLE_IOCTL(D7SIOCTM)
Index: linux-2.6/drivers/sbus/char/envctrl.c
=================================--- linux-2.6.orig/drivers/sbus/char/envctrl.c	2005-11-07 11:55:10.000000000 +0100
+++ linux-2.6/drivers/sbus/char/envctrl.c	2005-11-07 11:55:17.000000000 +0100
@@ -654,9 +654,8 @@
 /* Function Description: Command what to read.  Mapped to user ioctl().
  * Return: Gives 0 for implemented commands, -EINVAL otherwise.
  */
-static int
-envctrl_ioctl(struct inode *inode, struct file *file,
-	      unsigned int cmd, unsigned long arg)
+static long
+envctrl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	char __user *infobuf;
 
@@ -715,11 +714,14 @@
 }
 
 static struct file_operations envctrl_fops = {
-	.owner =	THIS_MODULE,
-	.read =		envctrl_read,
-	.ioctl =	envctrl_ioctl,
-	.open =		envctrl_open,
-	.release =	envctrl_release,
+	.owner =		THIS_MODULE,
+	.read =			envctrl_read,
+	.unlocked_ioctl =	envctrl_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =		envctrl_ioctl,
+#endif
+	.open =			envctrl_open,
+	.release =		envctrl_release,
 };	
 
 static struct miscdevice envctrl_dev = {
