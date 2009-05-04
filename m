From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 20:36:50 +0000
Subject: [PATCH] cg14: use standard fields for framebuffer physical address
Message-Id: <20090504223650.27f50a51.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux <sparclinux@vger.kernel.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
for physical address and length of framebuffer.

This also fixes output of the 'fbset -i' command - address and length 
of the framebuffer is displayed correctly.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/cg14.c linux-2.6.30/drivers/video/cg14.c
--- linux-orig/drivers/video/cg14.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/cg14.c	2009-05-04 00:47:24.000000000 +0200
@@ -196,9 +196,7 @@ struct cg14_par {
 	u32			flags;
 #define CG14_FLAG_BLANKED	0x00000001
 
-	unsigned long		physbase;
 	unsigned long		iospace;
-	unsigned long		fbsize;
 
 	struct sbus_mmap_map	mmap_map[CG14_MMAP_ENTRIES];
 
@@ -271,7 +269,7 @@ static int cg14_mmap(struct fb_info *inf
 	struct cg14_par *par = (struct cg14_par *) info->par;
 
 	return sbusfb_mmap_helper(par->mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->iospace, vma);
 }
 
@@ -343,7 +341,8 @@ static int cg14_ioctl(struct fb_info *in
 
 	default:
 		ret = sbusfb_ioctl_helper(cmd, arg, info,
-					  FBTYPE_MDICOLOR, 8, par->fbsize);
+					  FBTYPE_MDICOLOR, 8,
+					  info->fix.smem_len);
 		break;
 	};
 
@@ -462,7 +461,7 @@ static void cg14_unmap_regs(struct of_de
 			   par->cursor, sizeof(struct cg14_cursor));
 	if (info->screen_base)
 		of_iounmap(&op->resource[1],
-			   info->screen_base, par->fbsize);
+			   info->screen_base, info->fix.smem_len);
 }
 
 static int __devinit cg14_probe(struct of_device *op, const struct of_device_id *match)
@@ -488,14 +487,14 @@ static int __devinit cg14_probe(struct o
 
 	linebytes = of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
-	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
 	if (!strcmp(dp->parent->name, "sbus") ||
 	    !strcmp(dp->parent->name, "sbi")) {
-		par->physbase = op->resource[0].start;
+		info->fix.smem_start = op->resource[0].start;
 		par->iospace = op->resource[0].flags & IORESOURCE_BITS;
 	} else {
-		par->physbase = op->resource[1].start;
+		info->fix.smem_start = op->resource[1].start;
 		par->iospace = op->resource[0].flags & IORESOURCE_BITS;
 	}
 
@@ -507,7 +506,7 @@ static int __devinit cg14_probe(struct o
 				 sizeof(struct cg14_cursor), "cg14 cursor");
 
 	info->screen_base = of_ioremap(&op->resource[1], 0,
-				       par->fbsize, "cg14 ram");
+				       info->fix.smem_len, "cg14 ram");
 
 	if (!par->regs || !par->clut || !par->cursor || !info->screen_base)
 		goto out_unmap_regs;
@@ -557,7 +556,7 @@ static int __devinit cg14_probe(struct o
 
 	printk(KERN_INFO "%s: cgfourteen at %lx:%lx, %dMB\n",
 	       dp->full_name,
-	       par->iospace, par->physbase,
+	       par->iospace, info->fix.smem_start,
 	       par->ramsize >> 20);
 
 	return 0;

----------------------------------------------------------------------
Wygraj wycieczke do Eurodisneylandu!
Sprawdz >> http://link.interia.pl/f2153

