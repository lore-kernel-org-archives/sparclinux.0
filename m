From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 20:35:36 +0000
Subject: bw2: use standard fields for framebuffer physical address and
Message-Id: <20090504223536.fa9ee920.krzysztof.h1@poczta.fm>
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

diff -urp linux-orig/drivers/video/bw2.c linux-2.6.30/drivers/video/bw2.c
--- linux-orig/drivers/video/bw2.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/bw2.c	2009-05-04 00:59:04.000000000 +0200
@@ -111,9 +111,7 @@ struct bw2_par {
 	u32			flags;
 #define BW2_FLAG_BLANKED	0x00000001
 
-	unsigned long		physbase;
 	unsigned long		which_io;
-	unsigned long		fbsize;
 };
 
 /**
@@ -167,17 +165,15 @@ static int bw2_mmap(struct fb_info *info
 	struct bw2_par *par = (struct bw2_par *)info->par;
 
 	return sbusfb_mmap_helper(bw2_mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->which_io,
 				  vma);
 }
 
 static int bw2_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
-	struct bw2_par *par = (struct bw2_par *) info->par;
-
 	return sbusfb_ioctl_helper(cmd, arg, info,
-				   FBTYPE_SUN2BW, 1, par->fbsize);
+				   FBTYPE_SUN2BW, 1, info->fix.smem_len);
 }
 
 /*
@@ -294,7 +290,7 @@ static int __devinit bw2_probe(struct of
 
 	spin_lock_init(&par->lock);
 
-	par->physbase = op->resource[0].start;
+	info->fix.smem_start = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
 	sbusfb_fill_var(&info->var, dp, 1);
@@ -317,13 +313,13 @@ static int __devinit bw2_probe(struct of
 			goto out_unmap_regs;
 	}
 
-	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
 	info->flags = FBINFO_DEFAULT;
 	info->fbops = &bw2_ops;
 
 	info->screen_base = of_ioremap(&op->resource[0], 0,
-				       par->fbsize, "bw2 ram");
+				       info->fix.smem_len, "bw2 ram");
 	if (!info->screen_base)
 		goto out_unmap_regs;
 
@@ -338,12 +334,12 @@ static int __devinit bw2_probe(struct of
 	dev_set_drvdata(&op->dev, info);
 
 	printk(KERN_INFO "%s: bwtwo at %lx:%lx\n",
-	       dp->full_name, par->which_io, par->physbase);
+	       dp->full_name, par->which_io, info->fix.smem_start);
 
 	return 0;
 
 out_unmap_screen:
-	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
+	of_iounmap(&op->resource[0], info->screen_base, info->fix.smem_len);
 
 out_unmap_regs:
 	of_iounmap(&op->resource[0], par->regs, sizeof(struct bw2_regs));
@@ -363,7 +359,7 @@ static int __devexit bw2_remove(struct o
 	unregister_framebuffer(info);
 
 	of_iounmap(&op->resource[0], par->regs, sizeof(struct bw2_regs));
-	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
+	of_iounmap(&op->resource[0], info->screen_base, info->fix.smem_len);
 
 	framebuffer_release(info);
 

----------------------------------------------------------------------
Gotowka na koncie. Otworz konto direct i wez podwojny limit. 	 
http://link.interia.pl/f2145

