From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 20:41:56 +0000
Subject: [PATCH] leo:  use standard fields for framebuffer physical address
Message-Id: <20090504224156.058f65ea.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux <sparclinux@vger.kernel.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
for physical address and length of framebuffer.

This also fixes output of the 'fbset -i' command - address and length 
of the framebuffer are displayed correctly.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/leo.c linux-2.6.30/drivers/video/leo.c
--- linux-orig/drivers/video/leo.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/leo.c	2009-05-04 01:00:11.000000000 +0200
@@ -191,9 +191,7 @@ struct leo_par {
 	u32			flags;
 #define LEO_FLAG_BLANKED	0x00000001
 
-	unsigned long		physbase;
 	unsigned long		which_io;
-	unsigned long		fbsize;
 };
 
 static void leo_wait(struct leo_lx_krn __iomem *lx_krn)
@@ -420,16 +418,14 @@ static int leo_mmap(struct fb_info *info
 	struct leo_par *par = (struct leo_par *)info->par;
 
 	return sbusfb_mmap_helper(leo_mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->which_io, vma);
 }
 
 static int leo_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
-	struct leo_par *par = (struct leo_par *) info->par;
-
 	return sbusfb_ioctl_helper(cmd, arg, info,
-				   FBTYPE_SUNLEO, 32, par->fbsize);
+				   FBTYPE_SUNLEO, 32, info->fix.smem_len);
 }
 
 /*
@@ -569,7 +565,7 @@ static int __devinit leo_probe(struct of
 
 	spin_lock_init(&par->lock);
 
-	par->physbase = op->resource[0].start;
+	info->fix.smem_start = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
 	sbusfb_fill_var(&info->var, dp, 32);
@@ -577,7 +573,7 @@ static int __devinit leo_probe(struct of
 
 	linebytes = of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
-	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
 	par->lc_ss0_usr  		of_ioremap(&op->resource[0], LEO_OFF_LC_SS0_USR,
@@ -627,7 +623,7 @@ static int __devinit leo_probe(struct of
 
 	printk(KERN_INFO "%s: leo at %lx:%lx\n",
 	       dp->full_name,
-	       par->which_io, par->physbase);
+	       par->which_io, info->fix.smem_start);
 
 	return 0;
 

----------------------------------------------------------------------
Gotowka na koncie. Otworz konto direct i wez podwojny limit. 	 
http://link.interia.pl/f2145

