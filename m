From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 20:45:20 +0000
Subject: [PATCH] tcx: use standard fields for framebuffer physical address
Message-Id: <20090504224520.791f559d.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux <sparclinux@vger.kernel.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
for physical address and length of framebuffer.

This also fixes output of the 'fbset -i' command - address and length=20
of the framebuffer are displayed correctly.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/tcx.c linux-2.6.30/drivers/video/tcx.c
--- linux-orig/drivers/video/tcx.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/tcx.c	2009-05-04 00:59:47.000000000 +0200
@@ -116,17 +116,16 @@ struct tcx_par {
 	u32			flags;
 #define TCX_FLAG_BLANKED	0x00000001
=20
-	unsigned long		physbase;
 	unsigned long		which_io;
-	unsigned long		fbsize;
=20
 	struct sbus_mmap_map	mmap_map[TCX_MMAP_ENTRIES];
 	int			lowdepth;
 };
=20
 /* Reset control plane so that WID is 8-bit plane. */
-static void __tcx_set_control_plane(struct tcx_par *par)
+static void __tcx_set_control_plane(struct fb_info *info)
 {
+	struct tcx_par *par =3D info->par;
 	u32 __iomem *p, *pend;
=20
 	if (par->lowdepth)
@@ -135,7 +134,7 @@ static void __tcx_set_control_plane(stru
 	p =3D par->cplane;
 	if (p =3D NULL)
 		return;
-	for (pend =3D p + par->fbsize; p < pend; p++) {
+	for (pend =3D p + info->fix.smem_len; p < pend; p++) {
 		u32 tmp =3D sbus_readl(p);
=20
 		tmp &=3D 0xffffff;
@@ -149,7 +148,7 @@ static void tcx_reset(struct fb_info *in
 	unsigned long flags;
=20
 	spin_lock_irqsave(&par->lock, flags);
-	__tcx_set_control_plane(par);
+	__tcx_set_control_plane(info);
 	spin_unlock_irqrestore(&par->lock, flags);
 }
=20
@@ -304,7 +303,7 @@ static int tcx_mmap(struct fb_info *info
 	struct tcx_par *par =3D (struct tcx_par *)info->par;
=20
 	return sbusfb_mmap_helper(par->mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->which_io, vma);
 }
=20
@@ -316,7 +315,7 @@ static int tcx_ioctl(struct fb_info *inf
 	return sbusfb_ioctl_helper(cmd, arg, info,
 				   FBTYPE_TCXCOLOR,
 				   (par->lowdepth ? 8 : 24),
-				   par->fbsize);
+				   info->fix.smem_len);
 }
=20
 /*
@@ -358,10 +357,10 @@ static void tcx_unmap_regs(struct of_dev
 			   par->bt, sizeof(struct bt_regs));
 	if (par->cplane)
 		of_iounmap(&op->resource[4],
-			   par->cplane, par->fbsize * sizeof(u32));
+			   par->cplane, info->fix.smem_len * sizeof(u32));
 	if (info->screen_base)
 		of_iounmap(&op->resource[0],
-			   info->screen_base, par->fbsize);
+			   info->screen_base, info->fix.smem_len);
 }
=20
 static int __devinit tcx_probe(struct of_device *op,
@@ -391,7 +390,7 @@ static int __devinit tcx_probe(struct of
=20
 	linebytes =3D of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
-	par->fbsize =3D PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len =3D PAGE_ALIGN(linebytes * info->var.yres);
=20
 	par->tec =3D of_ioremap(&op->resource[7], 0,
 				  sizeof(struct tcx_tec), "tcx tec");
@@ -400,7 +399,7 @@ static int __devinit tcx_probe(struct of
 	par->bt =3D of_ioremap(&op->resource[8], 0,
 				 sizeof(struct bt_regs), "tcx dac");
 	info->screen_base =3D of_ioremap(&op->resource[0], 0,
-					   par->fbsize, "tcx ram");
+					   info->fix.smem_len, "tcx ram");
 	if (!par->tec || !par->thc ||
 	    !par->bt || !info->screen_base)
 		goto out_unmap_regs;
@@ -408,7 +407,7 @@ static int __devinit tcx_probe(struct of
 	memcpy(&par->mmap_map, &__tcx_mmap_map, sizeof(par->mmap_map));
 	if (!par->lowdepth) {
 		par->cplane =3D of_ioremap(&op->resource[4], 0,
-					     par->fbsize * sizeof(u32),
+					     info->fix.smem_len * sizeof(u32),
 					     "tcx cplane");
 		if (!par->cplane)
 			goto out_unmap_regs;
@@ -419,7 +418,7 @@ static int __devinit tcx_probe(struct of
 		par->mmap_map[6].size =3D SBUS_MMAP_EMPTY;
 	}
=20
-	par->physbase =3D op->resource[0].start;
+	info->fix.smem_start =3D op->resource[0].start;
 	par->which_io =3D op->resource[0].flags & IORESOURCE_BITS;
=20
 	for (i =3D 0; i < TCX_MMAP_ENTRIES; i++) {
@@ -473,7 +472,7 @@ static int __devinit tcx_probe(struct of
 	printk(KERN_INFO "%s: TCX at %lx:%lx, %s\n",
 	       dp->full_name,
 	       par->which_io,
-	       par->physbase,
+	       info->fix.smem_start,
 	       par->lowdepth ? "8-bit only" : "24-bit depth");
=20
 	return 0;

----------------------------------------------------------------------
Szukasz pracy? Sprawd=BC nasze oferty!
http://link.interia.pl/f2142

