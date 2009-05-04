From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 20:37:46 +0000
Subject: [PATCH] cg3: use standard fields for framebuffer physical address
Message-Id: <20090504223746.c204fb8c.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, sparclinux <sparclinux@vger.kernel.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
for physical address and length of framebuffer.

This also fixes output of the 'fbset -i' command - address and length 
of the framebuffer is displayed correctly.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/cg3.c linux-2.6.30/drivers/video/cg3.c
--- linux-orig/drivers/video/cg3.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/cg3.c	2009-05-04 00:49:43.000000000 +0200
@@ -118,9 +118,7 @@ struct cg3_par {
 #define CG3_FLAG_BLANKED	0x00000001
 #define CG3_FLAG_RDI		0x00000002
 
-	unsigned long		physbase;
 	unsigned long		which_io;
-	unsigned long		fbsize;
 };
 
 /**
@@ -231,17 +229,15 @@ static int cg3_mmap(struct fb_info *info
 	struct cg3_par *par = (struct cg3_par *)info->par;
 
 	return sbusfb_mmap_helper(cg3_mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->which_io,
 				  vma);
 }
 
 static int cg3_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
-	struct cg3_par *par = (struct cg3_par *) info->par;
-
 	return sbusfb_ioctl_helper(cmd, arg, info,
-				   FBTYPE_SUN3COLOR, 8, par->fbsize);
+				   FBTYPE_SUN3COLOR, 8, info->fix.smem_len);
 }
 
 /*
@@ -368,7 +364,7 @@ static int __devinit cg3_probe(struct of
 
 	spin_lock_init(&par->lock);
 
-	par->physbase = op->resource[0].start;
+	info->fix.smem_start = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
 	sbusfb_fill_var(&info->var, dp, 8);
@@ -382,7 +378,7 @@ static int __devinit cg3_probe(struct of
 
 	linebytes = of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
-	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
 	par->regs = of_ioremap(&op->resource[0], CG3_REGS_OFFSET,
 			       sizeof(struct cg3_regs), "cg3 regs");
@@ -392,7 +388,7 @@ static int __devinit cg3_probe(struct of
 	info->flags = FBINFO_DEFAULT;
 	info->fbops = &cg3_ops;
 	info->screen_base = of_ioremap(&op->resource[0], CG3_RAM_OFFSET,
-				       par->fbsize, "cg3 ram");
+				       info->fix.smem_len, "cg3 ram");
 	if (!info->screen_base)
 		goto out_unmap_regs;
 
@@ -418,7 +414,7 @@ static int __devinit cg3_probe(struct of
 	dev_set_drvdata(&op->dev, info);
 
 	printk(KERN_INFO "%s: cg3 at %lx:%lx\n",
-	       dp->full_name, par->which_io, par->physbase);
+	       dp->full_name, par->which_io, info->fix.smem_start);
 
 	return 0;
 
@@ -426,7 +422,7 @@ out_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
 
 out_unmap_screen:
-	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
+	of_iounmap(&op->resource[0], info->screen_base, info->fix.smem_len);
 
 out_unmap_regs:
 	of_iounmap(&op->resource[0], par->regs, sizeof(struct cg3_regs));
@@ -447,7 +443,7 @@ static int __devexit cg3_remove(struct o
 	fb_dealloc_cmap(&info->cmap);
 
 	of_iounmap(&op->resource[0], par->regs, sizeof(struct cg3_regs));
-	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
+	of_iounmap(&op->resource[0], info->screen_base, info->fix.smem_len);
 
 	framebuffer_release(info);
 

----------------------------------------------------------------------
Wygraj wycieczke do Eurodisneylandu!
Sprawdz >> http://link.interia.pl/f2153

