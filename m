From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 20:39:45 +0000
Subject: [PATCH] cg6: use standard fields for framebuffer physical address
Message-Id: <20090504223945.88de6e37.krzysztof.h1@poczta.fm>
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
I tested this patch on a real hardware (SS20 + TGX card).

diff -urp linux-orig/drivers/video/cg6.c linux-2.6.30/drivers/video/cg6.c
--- linux-orig/drivers/video/cg6.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/cg6.c	2009-05-04 00:49:28.000000000 +0200
@@ -263,9 +263,7 @@ struct cg6_par {
 	u32			flags;
 #define CG6_FLAG_BLANKED	0x00000001
 
-	unsigned long		physbase;
 	unsigned long		which_io;
-	unsigned long		fbsize;
 };
 
 static int cg6_sync(struct fb_info *info)
@@ -596,16 +594,14 @@ static int cg6_mmap(struct fb_info *info
 	struct cg6_par *par = (struct cg6_par *)info->par;
 
 	return sbusfb_mmap_helper(cg6_mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->which_io, vma);
 }
 
 static int cg6_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
-	struct cg6_par *par = (struct cg6_par *)info->par;
-
 	return sbusfb_ioctl_helper(cmd, arg, info,
-				   FBTYPE_SUNFAST_COLOR, 8, par->fbsize);
+				   FBTYPE_SUNFAST_COLOR, 8, info->fix.smem_len);
 }
 
 /*
@@ -631,12 +627,12 @@ static void __devinit cg6_init_fix(struc
 		break;
 	};
 	if (((conf >> CG6_FHC_REV_SHIFT) & CG6_FHC_REV_MASK) >= 11) {
-		if (par->fbsize <= 0x100000)
+		if (info->fix.smem_len <= 0x100000)
 			cg6_card_name = "TGX";
 		else
 			cg6_card_name = "TGX+";
 	} else {
-		if (par->fbsize <= 0x100000)
+		if (info->fix.smem_len <= 0x100000)
 			cg6_card_name = "GX";
 		else
 			cg6_card_name = "GX+";
@@ -738,7 +734,8 @@ static void cg6_unmap_regs(struct of_dev
 		of_iounmap(&op->resource[0], par->fhc, sizeof(u32));
 
 	if (info->screen_base)
-		of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
+		of_iounmap(&op->resource[0], info->screen_base,
+			   info->fix.smem_len);
 }
 
 static int __devinit cg6_probe(struct of_device *op,
@@ -759,7 +756,7 @@ static int __devinit cg6_probe(struct of
 
 	spin_lock_init(&par->lock);
 
-	par->physbase = op->resource[0].start;
+	info->fix.smem_start = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
 	sbusfb_fill_var(&info->var, dp, 8);
@@ -769,11 +766,11 @@ static int __devinit cg6_probe(struct of
 
 	linebytes = of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
-	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
 	dblbuf = of_getintprop_default(dp, "dblbuf", 0);
 	if (dblbuf)
-		par->fbsize *= 4;
+		info->fix.smem_len *= 4;
 
 	par->fbc = of_ioremap(&op->resource[0], CG6_FBC_OFFSET,
 				4096, "cgsix fbc");
@@ -792,7 +789,7 @@ static int __devinit cg6_probe(struct of
 	info->fbops = &cg6_ops;
 
 	info->screen_base = of_ioremap(&op->resource[0], CG6_RAM_OFFSET,
-					par->fbsize, "cgsix ram");
+					info->fix.smem_len, "cgsix ram");
 	if (!par->fbc || !par->tec || !par->thc ||
 	    !par->bt || !par->fhc || !info->screen_base)
 		goto out_unmap_regs;
@@ -817,7 +814,7 @@ static int __devinit cg6_probe(struct of
 
 	printk(KERN_INFO "%s: CGsix [%s] at %lx:%lx\n",
 	       dp->full_name, info->fix.id,
-	       par->which_io, par->physbase);
+	       par->which_io, info->fix.smem_start);
 
 	return 0;
 

----------------------------------------------------------------------
Wygraj 3000 zl, wycieczke lub lot balonem!
Sprawdz >> http://link.interia.pl/f2154

