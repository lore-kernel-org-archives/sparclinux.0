From: "stoyboyker@gmail.com" <stoyboyker@gmail.com>
Date: Mon, 14 Jul 2008 09:34:43 +0000
Subject: [Patch] Change arch/sparc/kernel/apc.c to unlocked_ioctl
Message-Id: <112178.52388242-sendEmail@stoydesk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-98566.9322117282
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

This changes arch/sparc/kernel/apc.c to use unlocked_ioctl

Signed-off-by: Stoyan Gaydarov <stoyboyker@gmail.com>

diff -uprN linux-2.6.26/arch/sparc/kernel/apc.c devel/arch/sparc/kernel/apc.c
--- linux-2.6.26/arch/sparc/kernel/apc.c	2008-07-13 16:51:29.000000000 -0500
+++ devel/arch/sparc/kernel/apc.c	2008-07-14 04:24:40.000000000 -0500
@@ -83,54 +83,70 @@ static int apc_release(struct inode *ino
 	return 0;
 }
 
-static int apc_ioctl(struct inode *inode, struct file *f, 
-		     unsigned int cmd, unsigned long __arg)
+static long apc_ioctl(struct file *f, unsigned int cmd, unsigned long __arg)
 {
 	__u8 inarg, __user *arg;
 
 	arg = (__u8 __user *) __arg;
+
+	lock_kernel();
+
 	switch (cmd) {
 	case APCIOCGFANCTL:
-		if (put_user(apc_readb(APC_FANCTL_REG) & APC_REGMASK, arg))
-				return -EFAULT;
+		if (put_user(apc_readb(APC_FANCTL_REG) & APC_REGMASK, arg)) {
+			unlock_kernel();
+			return -EFAULT;
+		}
 		break;
 
 	case APCIOCGCPWR:
-		if (put_user(apc_readb(APC_CPOWER_REG) & APC_REGMASK, arg))
+		if (put_user(apc_readb(APC_CPOWER_REG) & APC_REGMASK, arg)) {
+			unlock_kernel();
 			return -EFAULT;
+		}
 		break;
 
 	case APCIOCGBPORT:
-		if (put_user(apc_readb(APC_BPORT_REG) & APC_BPMASK, arg))
+		if (put_user(apc_readb(APC_BPORT_REG) & APC_BPMASK, arg)) {
+			unlock_kernel();
 			return -EFAULT;
+		}
 		break;
 
 	case APCIOCSFANCTL:
-		if (get_user(inarg, arg))
+		if (get_user(inarg, arg)) {
+			unlock_kernel();
 			return -EFAULT;
+		}
 		apc_writeb(inarg & APC_REGMASK, APC_FANCTL_REG);
 		break;
 	case APCIOCSCPWR:
-		if (get_user(inarg, arg))
+		if (get_user(inarg, arg)) {
+			unlock_kernel();
 			return -EFAULT;
+		}
 		apc_writeb(inarg & APC_REGMASK, APC_CPOWER_REG);
 		break;
 	case APCIOCSBPORT:
-		if (get_user(inarg, arg))
+		if (get_user(inarg, arg)) {
+			unlock_kernel();
 			return -EFAULT;
+		}
 		apc_writeb(inarg & APC_BPMASK, APC_BPORT_REG);
 		break;
 	default:
+		unlock_kernel();
 		return -EINVAL;
 	};
 
+	unlock_kernel();
 	return 0;
 }
 
 static const struct file_operations apc_fops = {
-	.ioctl =	apc_ioctl,
-	.open =		apc_open,
-	.release =	apc_release,
+	.unlocked_ioctl =	apc_ioctl,
+	.open =			apc_open,
+	.release =		apc_release,
 };
 
 static struct miscdevice apc_miscdev = { APC_MINOR, APC_DEVNAME, &apc_fops };

------MIME delimiter for sendEmail-98566.9322117282--

