From: Christoph Hellwig <hch@lst.de>
Date: Sun, 15 Jan 2006 20:55:54 +0000
Subject: [PATCH] fix up sbuslib for new fb_comapt_ioctl prototype
Message-Id: <20060115205554.GA19609@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After ages my fb ioctl prototype cleanup finally got in.  Unfortunately
the patch are so old that the sbus compat_ioctl helper didn't exist back
then, so it's not covered.  This patch should fix that issue.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/video/sbuslib.c
=================================--- linux-2.6.orig/drivers/video/sbuslib.c	2005-12-27 18:30:31.000000000 +0100
+++ linux-2.6/drivers/video/sbuslib.c	2006-01-15 21:55:26.000000000 +0100
@@ -216,10 +216,10 @@
 	ret |= put_user(compat_ptr(addr), &p->blue);
 	if (ret)
 		return -EFAULT;
-	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
+	return info->fbops->fb_ioctl(info,
 			(cmd = FBIOPUTCMAP32) ?
 			FBIOPUTCMAP_SPARC : FBIOGETCMAP_SPARC,
-			(unsigned long)p, info);
+			(unsigned long)p);
 }
 
 struct fbcursor32 {
@@ -260,12 +260,11 @@
 	ret |= put_user(compat_ptr(addr), &p->image);
 	if (ret)
 		return -EFAULT;
-	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
-			FBIOSCURSOR, (unsigned long)p, info);
+	return info->fbops->fb_ioctl(info, FBIOSCURSOR, (unsigned long)p);
 }
 
-long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg, struct fb_info *info)
+long sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd,
+		unsigned long arg)
 {
 	switch (cmd) {
 	case FBIOGTYPE:
@@ -278,14 +277,13 @@
 	case FBIOSCURPOS:
 	case FBIOGCURPOS:
 	case FBIOGCURMAX:
-		return info->fbops->fb_ioctl(file->f_dentry->d_inode,
-				file, cmd, arg, info);
+		return info->fbops->fb_ioctl(info, cmd, arg);
 	case FBIOPUTCMAP32:
-		return fbiogetputcmap(file, info, cmd, arg);
+		return fbiogetputcmap(info, cmd, arg);
 	case FBIOGETCMAP32:
-		return fbiogetputcmap(file, info, cmd, arg);
+		return fbiogetputcmap(info, cmd, arg);
 	case FBIOSCURSOR32:
-		return fbiogscursor(file, info, arg);
+		return fbiogscursor(info, arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
Index: linux-2.6/drivers/video/sbuslib.h
=================================--- linux-2.6.orig/drivers/video/sbuslib.h	2005-12-27 18:30:31.000000000 +0100
+++ linux-2.6/drivers/video/sbuslib.h	2006-01-15 21:51:45.000000000 +0100
@@ -20,7 +20,7 @@
 int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 			struct fb_info *info,
 			int type, int fb_depth, unsigned long fb_size);
-long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg, struct fb_info *info);
+long sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd,
+		unsigned long arg);
 
 #endif /* _SBUSLIB_H */
