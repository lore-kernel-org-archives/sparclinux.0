From: Christoph Hellwig <hch@lst.de>
Date: Mon, 07 Nov 2005 19:41:24 +0000
Subject: [PATCH] openprom: implement ->compat_ioctl
Message-Id: <20051107194123.GC32019@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

implement a compat_ioctl handle in the driver instead of having table
entries in sparc64 ioctl32.c (I plan to get rid of the arch ioctl32.c
file eventually)


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/sbus/char/openprom.c
=================================--- linux-2.6.orig/drivers/sbus/char/openprom.c	2005-11-07 11:53:45.000000000 +0100
+++ linux-2.6/drivers/sbus/char/openprom.c	2005-11-07 11:55:24.000000000 +0100
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/miscdevice.h>
+#include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <asm/oplib.h>
@@ -565,6 +566,38 @@
 	}
 }
 
+static long openprom_compat_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg)
+{
+	long rval = -ENOTTY;
+
+	/*
+	 * SunOS/Solaris only, the NetBSD one's have embedded pointers in
+	 * the arg which we'd need to clean up...
+	 */
+	switch (cmd) {
+	case OPROMGETOPT:
+	case OPROMSETOPT:
+	case OPROMNXTOPT:
+	case OPROMSETOPT2:
+	case OPROMNEXT:
+	case OPROMCHILD:
+	case OPROMGETPROP:
+	case OPROMNXTPROP:
+	case OPROMU2P:
+	case OPROMGETCONS:
+	case OPROMGETFBNAME:
+	case OPROMGETBOOTARGS:
+	case OPROMSETCUR:
+	case OPROMPCI2NODE:
+	case OPROMPATH2NODE:
+		lock_kernel();
+		rval = openprom_ioctl(file->f_dentry->d_inode, file, cmd, arg);
+		lock_kernel();
+		break;
+	}
+}
+
 static int openprom_open(struct inode * inode, struct file * file)
 {
 	DATA *data;
Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:55:17.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-07 11:55:40.000000000 +0100
@@ -124,24 +124,6 @@
 /* COMPATIBLE_IOCTL(D7SIOCRD) same value as ENVCTRL_RD_VOLTAGE_STATUS */
 COMPATIBLE_IOCTL(D7SIOCWR)
 COMPATIBLE_IOCTL(D7SIOCTM)
-/* OPENPROMIO, SunOS/Solaris only, the NetBSD one's have
- * embedded pointers in the arg which we'd need to clean up...
- */
-COMPATIBLE_IOCTL(OPROMGETOPT)
-COMPATIBLE_IOCTL(OPROMSETOPT)
-COMPATIBLE_IOCTL(OPROMNXTOPT)
-COMPATIBLE_IOCTL(OPROMSETOPT2)
-COMPATIBLE_IOCTL(OPROMNEXT)
-COMPATIBLE_IOCTL(OPROMCHILD)
-COMPATIBLE_IOCTL(OPROMGETPROP)
-COMPATIBLE_IOCTL(OPROMNXTPROP)
-COMPATIBLE_IOCTL(OPROMU2P)
-COMPATIBLE_IOCTL(OPROMGETCONS)
-COMPATIBLE_IOCTL(OPROMGETFBNAME)
-COMPATIBLE_IOCTL(OPROMGETBOOTARGS)
-COMPATIBLE_IOCTL(OPROMSETCUR)
-COMPATIBLE_IOCTL(OPROMPCI2NODE)
-COMPATIBLE_IOCTL(OPROMPATH2NODE)
 COMPATIBLE_IOCTL(WIOCSTART)
 COMPATIBLE_IOCTL(WIOCSTOP)
 COMPATIBLE_IOCTL(WIOCGSTAT)
