From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 04:41:17 +0000
Subject: [PATCH 2.6] TCX Framebuffer fixes
Message-Id: <1109911277.17038.44.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-mAfL3pFX6DaQtSwHCYBV"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-mAfL3pFX6DaQtSwHCYBV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Using the same logic as the other framebuffer fixes committed in 2.6.11,
this is a set of fixes to make TCX functional on the console again. Adds
the tcx_pan_display function, sets the
all->info.var.{red,green,blue}.length values to 8, and runs fb_set_cmap.
Also looks for the correct SUNW,tcx prom value.

This patch just slipped through the cracks.

Originally by: Georg Chini <georg.chini@triaton-webhosting.com>

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-mAfL3pFX6DaQtSwHCYBV
Content-Disposition: attachment; filename=linux-2.6.11-sparc-tcxfixes.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-tcxfixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/drivers/video/tcx.c.BAD	2005-03-03 23:30:15.621231203 -0500
+++ linux-2.6.11/drivers/video/tcx.c	2005-03-03 23:34:02.963669899 -0500
@@ -36,6 +36,7 @@ static int tcx_blank(int, struct fb_info
 static int tcx_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
 static int tcx_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long, struct fb_info *);
+static int tcx_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
  *  Frame buffer operations
@@ -45,6 +46,7 @@ static struct fb_ops tcx_ops = {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= tcx_setcolreg,
 	.fb_blank		= tcx_blank,
+	.fb_pan_display		= tcx_pan_display,
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
@@ -153,6 +155,12 @@ static void tcx_reset (struct fb_info *i
 	spin_unlock_irqrestore(&par->lock, flags);
 }
 
+static int tcx_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	tcx_reset(info);
+	return 0;
+}
+
 /**
  *      tcx_setcolreg - Optional function. Sets a color register.
  *      @regno: boolean, 0 copy local, 1 get_user() function
@@ -366,6 +374,9 @@ static void tcx_init_one(struct sbus_dev
 	all->par.lowdepth = prom_getbool(sdev->prom_node, "tcx-8-bit");
 
 	sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+	all->info.var.red.length = 8;
+	all->info.var.green.length = 8;
+	all->info.var.blue.length = 8;
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
 				       all->info.var.xres);
@@ -439,6 +450,7 @@ static void tcx_init_one(struct sbus_dev
 		return;
 	}
 
+	fb_set_cmap(&all->info.cmap, &all->info);
 	tcx_init_fix(&all->info, linebytes);
 
 	if (register_framebuffer(&all->info) < 0) {
@@ -466,7 +478,7 @@ int __init tcx_init(void)
 		return -ENODEV;
 
 	for_all_sbusdev(sdev, sbus) {
-		if (!strcmp(sdev->prom_name, "tcx"))
+		if (!strcmp(sdev->prom_name, "SUNW,tcx"))
 			tcx_init_one(sdev);
 	}
 

--=-mAfL3pFX6DaQtSwHCYBV--

