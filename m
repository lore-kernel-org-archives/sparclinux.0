From: Christoph Hellwig <hch@lst.de>
Date: Sat, 12 Nov 2005 09:29:21 +0000
Subject: [PATCH, RFC] sbusfb: implement ->compat_ioctl
Message-Id: <20051112092921.GA15605@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds a new function, sbusfb_compat_ioctl() to
drivers/video/sbuslib.c and uses it as compat_ioctl in all sbus fb
drivers, aswell as in aytfb under #ifdef sparc as a special case.

This remove the last per-arch compat ioctl bits in
arch/sparc64/kernel/ioctl32.c so it would be nice if people could test
if this actually copiles and works and if yes apply it :)


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/video/sbuslib.c
=================================--- linux-2.6.orig/drivers/video/sbuslib.c	2005-11-11 23:40:40.000000000 +0100
+++ linux-2.6/drivers/video/sbuslib.c	2005-11-12 01:45:16.000000000 +0100
@@ -3,6 +3,7 @@
  * Copyright (C) 2003 David S. Miller (davem@redhat.com)
  */
 
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -182,3 +183,109 @@
 	};
 }
 EXPORT_SYMBOL(sbusfb_ioctl_helper);
+
+#ifdef CONFIG_COMPAT
+struct  fbcmap32 {
+	int             index;          /* first element (0 origin) */
+	int             count;
+	u32		red;
+	u32		green;
+	u32		blue;
+};
+
+#define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
+#define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
+
+static int fbiogetputcmap(struct file *file, struct fb_info *info,
+		unsigned int cmd, unsigned long arg)
+{
+	struct fbcmap32 __user *argp = (void __user *)arg;
+	struct fbcmap __user *p = compat_alloc_user_space(sizeof(*p));
+	u32 addr;
+	int ret;
+
+	ret = copy_in_user(p, argp, 2 * sizeof(int));
+	ret |= get_user(addr, &argp->red);
+	ret |= put_user(compat_ptr(addr), &p->red);
+	ret |= get_user(addr, &argp->green);
+	ret |= put_user(compat_ptr(addr), &p->green);
+	ret |= get_user(addr, &argp->blue);
+	ret |= put_user(compat_ptr(addr), &p->blue);
+	if (ret)
+		return -EFAULT;
+	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
+			(cmd = FBIOPUTCMAP32) ?
+			FBIOPUTCMAP_SPARC : FBIOGETCMAP_SPARC,
+			(unsigned long)p, info);
+}
+
+struct fbcursor32 {
+	short set;		/* what to set, choose from the list above */
+	short enable;		/* cursor on/off */
+	struct fbcurpos pos;	/* cursor position */
+	struct fbcurpos hot;	/* cursor hot spot */
+	struct fbcmap32 cmap;	/* color map info */
+	struct fbcurpos size;	/* cursor bit map size */
+	u32	image;		/* cursor image bits */
+	u32	mask;		/* cursor mask bits */
+};
+
+#define FBIOSCURSOR32	_IOW('F', 24, struct fbcursor32)
+#define FBIOGCURSOR32	_IOW('F', 25, struct fbcursor32)
+
+static int fbiogscursor(struct file *file, struct fb_info *info,
+		unsigned long arg)
+{
+	struct fbcursor __user *p = compat_alloc_user_space(sizeof(*p));
+	struct fbcursor32 __user *argp =  (void __user *)arg;
+	compat_uptr_t addr;
+	int ret;
+
+	ret = copy_in_user(p, argp,
+			      2 * sizeof (short) + 2 * sizeof(struct fbcurpos));
+	ret |= copy_in_user(&p->size, &argp->size, sizeof(struct fbcurpos));
+	ret |= copy_in_user(&p->cmap, &argp->cmap, 2 * sizeof(int));
+	ret |= get_user(addr, &argp->cmap.red);
+	ret |= put_user(compat_ptr(addr), &p->cmap.red);
+	ret |= get_user(addr, &argp->cmap.green);
+	ret |= put_user(compat_ptr(addr), &p->cmap.green);
+	ret |= get_user(addr, &argp->cmap.blue);
+	ret |= put_user(compat_ptr(addr), &p->cmap.blue);
+	ret |= get_user(addr, &argp->mask);
+	ret |= put_user(compat_ptr(addr), &p->mask);
+	ret |= get_user(addr, &argp->image);
+	ret |= put_user(compat_ptr(addr), &p->image);
+	if (ret)
+		return -EFAULT;
+	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
+			FBIOSCURSOR, (unsigned long)p, info);
+}
+
+long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg, struct fb_info *info)
+{
+	switch (cmd) {
+	case FBIOGTYPE:
+	case FBIOSATTR:
+	case FBIOGATTR:
+	case FBIOSVIDEO:
+	case FBIOGVIDEO:
+	case FBIOGCURSOR32:	/* This is not implemented yet.
+				   Later it should be converted... */
+	case FBIOSCURPOS:
+	case FBIOGCURPOS:
+	case FBIOGCURMAX:
+		return info->fbops->fb_ioctl(file->f_dentry->d_inode,
+				file, cmd, arg, info);
+	case FBIOPUTCMAP32:
+		return fbiogetputcmap(file, info, cmd, arg);
+	case FBIOGETCMAP32:
+		return fbiogetputcmap(file, info, cmd, arg);
+	case FBIOSCURSOR32:
+		return fbiogscursor(file, info, arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+EXPORT_SYMBOL(sbusfb_compat_ioctl);
+#endif
Index: linux-2.6/arch/sparc64/kernel/ioctl32.c
=================================--- linux-2.6.orig/arch/sparc64/kernel/ioctl32.c	2005-11-11 23:40:40.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ioctl32.c	2005-11-12 01:34:16.000000000 +0100
@@ -12,86 +12,10 @@
 #define INCLUDES
 #include "compat_ioctl.c"
 #include <linux/syscalls.h>
-#include <asm/fbio.h>
-
-/* Use this to get at 32-bit user passed pointers. 
- * See sys_sparc32.c for description about it.
- */
-#define A(__x) compat_ptr(__x)
 
 #define CODE
 #include "compat_ioctl.c"
 
-struct  fbcmap32 {
-	int             index;          /* first element (0 origin) */
-	int             count;
-	u32		red;
-	u32		green;
-	u32		blue;
-};
-
-#define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
-#define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
-
-static int fbiogetputcmap(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct fbcmap32 __user *argp = (void __user *)arg;
-	struct fbcmap __user *p = compat_alloc_user_space(sizeof(*p));
-	u32 addr;
-	int ret;
-	
-	ret = copy_in_user(p, argp, 2 * sizeof(int));
-	ret |= get_user(addr, &argp->red);
-	ret |= put_user(compat_ptr(addr), &p->red);
-	ret |= get_user(addr, &argp->green);
-	ret |= put_user(compat_ptr(addr), &p->green);
-	ret |= get_user(addr, &argp->blue);
-	ret |= put_user(compat_ptr(addr), &p->blue);
-	if (ret)
-		return -EFAULT;
-	return sys_ioctl(fd, (cmd = FBIOPUTCMAP32) ? FBIOPUTCMAP_SPARC : FBIOGETCMAP_SPARC, (unsigned long)p);
-}
-
-struct fbcursor32 {
-	short set;		/* what to set, choose from the list above */
-	short enable;		/* cursor on/off */
-	struct fbcurpos pos;	/* cursor position */
-	struct fbcurpos hot;	/* cursor hot spot */
-	struct fbcmap32 cmap;	/* color map info */
-	struct fbcurpos size;	/* cursor bit map size */
-	u32	image;		/* cursor image bits */
-	u32	mask;		/* cursor mask bits */
-};
-	
-#define FBIOSCURSOR32	_IOW('F', 24, struct fbcursor32)
-#define FBIOGCURSOR32	_IOW('F', 25, struct fbcursor32)
-
-static int fbiogscursor(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct fbcursor __user *p = compat_alloc_user_space(sizeof(*p));
-	struct fbcursor32 __user *argp =  (void __user *)arg;
-	compat_uptr_t addr;
-	int ret;
-	
-	ret = copy_in_user(p, argp,
-			      2 * sizeof (short) + 2 * sizeof(struct fbcurpos));
-	ret |= copy_in_user(&p->size, &argp->size, sizeof(struct fbcurpos));
-	ret |= copy_in_user(&p->cmap, &argp->cmap, 2 * sizeof(int));
-	ret |= get_user(addr, &argp->cmap.red);
-	ret |= put_user(compat_ptr(addr), &p->cmap.red);
-	ret |= get_user(addr, &argp->cmap.green);
-	ret |= put_user(compat_ptr(addr), &p->cmap.green);
-	ret |= get_user(addr, &argp->cmap.blue);
-	ret |= put_user(compat_ptr(addr), &p->cmap.blue);
-	ret |= get_user(addr, &argp->mask);
-	ret |= put_user(compat_ptr(addr), &p->mask);
-	ret |= get_user(addr, &argp->image);
-	ret |= put_user(compat_ptr(addr), &p->image);
-	if (ret)
-		return -EFAULT;
-	return sys_ioctl (fd, FBIOSCURSOR, (unsigned long)p);
-}
-
 #define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
 #define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl_trans_handler_t)(handler), NULL },
 #define IOCTL_TABLE_START \
@@ -103,22 +27,6 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "compat_ioctl.c"
-COMPATIBLE_IOCTL(FBIOGTYPE)
-COMPATIBLE_IOCTL(FBIOSATTR)
-COMPATIBLE_IOCTL(FBIOGATTR)
-COMPATIBLE_IOCTL(FBIOSVIDEO)
-COMPATIBLE_IOCTL(FBIOGVIDEO)
-COMPATIBLE_IOCTL(FBIOGCURSOR32)  /* This is not implemented yet. Later it should be converted... */
-COMPATIBLE_IOCTL(FBIOSCURPOS)
-COMPATIBLE_IOCTL(FBIOGCURPOS)
-COMPATIBLE_IOCTL(FBIOGCURMAX)
-/* Little k */
-/* Little v, the video4linux ioctls */
-/* And these ioctls need translation */
-/* Note SIOCRTMSG is no longer, so this is safe and * the user would have seen just an -EINVAL anyways. */
-HANDLE_IOCTL(FBIOPUTCMAP32, fbiogetputcmap)
-HANDLE_IOCTL(FBIOGETCMAP32, fbiogetputcmap)
-HANDLE_IOCTL(FBIOSCURSOR32, fbiogscursor)
 #if 0
 HANDLE_IOCTL(RTC32_IRQP_READ, do_rtc_ioctl)
 HANDLE_IOCTL(RTC32_IRQP_SET, do_rtc_ioctl)
Index: linux-2.6/drivers/video/sbuslib.h
=================================--- linux-2.6.orig/drivers/video/sbuslib.h	2005-11-11 23:40:40.000000000 +0100
+++ linux-2.6/drivers/video/sbuslib.h	2005-11-12 01:43:36.000000000 +0100
@@ -20,5 +20,7 @@
 int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 			struct fb_info *info,
 			int type, int fb_depth, unsigned long fb_size);
+long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg, struct fb_info *info);
 
 #endif /* _SBUSLIB_H */
Index: linux-2.6/drivers/video/aty/atyfb_base.c
=================================--- linux-2.6.orig/drivers/video/aty/atyfb_base.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/aty/atyfb_base.c	2005-11-12 01:39:18.000000000 +0100
@@ -81,6 +81,7 @@
 #ifdef __sparc__
 #include <asm/pbm.h>
 #include <asm/fbio.h>
+#include "../sbuslib.h"
 #endif
 
 #ifdef CONFIG_ADB_PMU
@@ -294,6 +295,9 @@
 	.fb_imageblit	= atyfb_imageblit,
 #ifdef __sparc__
 	.fb_mmap	= atyfb_mmap,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl = sbusfb_compat_ioctl,
+#endif
 #endif
 	.fb_sync	= atyfb_sync,
 };
Index: linux-2.6/drivers/video/bw2.c
=================================--- linux-2.6.orig/drivers/video/bw2.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/bw2.c	2005-11-12 01:43:03.000000000 +0100
@@ -51,6 +51,9 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= bw2_mmap,
 	.fb_ioctl		= bw2_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 /* OBio addresses for the bwtwo registers */
Index: linux-2.6/drivers/video/cg14.c
=================================--- linux-2.6.orig/drivers/video/cg14.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/cg14.c	2005-11-12 01:42:34.000000000 +0100
@@ -49,6 +49,9 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= cg14_mmap,
 	.fb_ioctl		= cg14_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 #define CG14_MCR_INTENABLE_SHIFT	7
Index: linux-2.6/drivers/video/cg3.c
=================================--- linux-2.6.orig/drivers/video/cg3.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/cg3.c	2005-11-12 01:42:39.000000000 +0100
@@ -50,6 +50,9 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= cg3_mmap,
 	.fb_ioctl		= cg3_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 
Index: linux-2.6/drivers/video/cg6.c
=================================--- linux-2.6.orig/drivers/video/cg6.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/cg6.c	2005-11-12 01:42:43.000000000 +0100
@@ -54,6 +54,9 @@
 	.fb_sync		= cg6_sync,
 	.fb_mmap		= cg6_mmap,
 	.fb_ioctl		= cg6_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 /* Offset of interesting structures in the OBIO space */
Index: linux-2.6/drivers/video/ffb.c
=================================--- linux-2.6.orig/drivers/video/ffb.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/ffb.c	2005-11-12 01:42:48.000000000 +0100
@@ -57,6 +57,9 @@
 	.fb_sync		= ffb_sync,
 	.fb_mmap		= ffb_mmap,
 	.fb_ioctl		= ffb_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 /* Register layout and definitions */
Index: linux-2.6/drivers/video/leo.c
=================================--- linux-2.6.orig/drivers/video/leo.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/leo.c	2005-11-12 01:42:52.000000000 +0100
@@ -51,6 +51,9 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= leo_mmap,
 	.fb_ioctl		= leo_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 #define LEO_OFF_LC_SS0_KRN	0x00200000UL
Index: linux-2.6/drivers/video/p9100.c
=================================--- linux-2.6.orig/drivers/video/p9100.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/p9100.c	2005-11-12 01:42:56.000000000 +0100
@@ -48,6 +48,9 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= p9100_mmap,
 	.fb_ioctl		= p9100_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 /* P9100 control registers */
Index: linux-2.6/drivers/video/tcx.c
=================================--- linux-2.6.orig/drivers/video/tcx.c	2005-11-11 23:40:53.000000000 +0100
+++ linux-2.6/drivers/video/tcx.c	2005-11-12 01:43:00.000000000 +0100
@@ -52,6 +52,9 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= tcx_mmap,
 	.fb_ioctl		= tcx_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl	= sbusfb_compat_ioctl,
+#endif
 };
 
 /* THC definitions */
