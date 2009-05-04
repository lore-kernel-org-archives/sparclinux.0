From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 20:40:55 +0000
Subject: ffb: use standard fields for framebuffer physical address and
Message-Id: <20090504224055.f4292314.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, sparclinux <sparclinux@vger.kernel.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
for physical address and length of framebuffer.

This also fixes output of the 'fbset -i' command - address and length=20
of the framebuffer are displayed correctly.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/ffb.c linux-2.6.30/drivers/video/ffb.c
--- linux-orig/drivers/video/ffb.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/ffb.c	2009-05-04 01:02:36.000000000 +0200
@@ -365,9 +365,6 @@ struct ffb_par {
=20
 	int			fifo_cache;
=20
-	unsigned long		physbase;
-	unsigned long		fbsize;
-
 	int			board_type;
=20
 	u32			pseudo_palette[16];
@@ -854,16 +851,14 @@ static int ffb_mmap(struct fb_info *info
 	struct ffb_par *par =3D (struct ffb_par *)info->par;
=20
 	return sbusfb_mmap_helper(ffb_mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  0, vma);
 }
=20
 static int ffb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long=
 arg)
 {
-	struct ffb_par *par =3D (struct ffb_par *)info->par;
-
 	return sbusfb_ioctl_helper(cmd, arg, info,
-				   FBTYPE_CREATOR, 24, par->fbsize);
+				   FBTYPE_CREATOR, 24, info->fix.smem_len);
 }
=20
 /*
@@ -925,7 +920,7 @@ static int __devinit ffb_probe(struct of
 		goto out_unmap_fbc;
=20
 	par->rop_cache =3D FFB_ROP_NEW;
-	par->physbase =3D op->resource[0].start;
+	info->fix.smem_start =3D op->resource[0].start;
=20
 	/* Don't mention copyarea, so SCROLL_REDRAW is always
 	 * used.  It is the fastest on this chip.
@@ -937,11 +932,11 @@ static int __devinit ffb_probe(struct of
=20
 	info->fbops =3D &ffb_ops;
=20
-	info->screen_base =3D (char *) par->physbase + FFB_DFB24_POFF;
+	info->screen_base =3D (char *) info->fix.smem_start + FFB_DFB24_POFF;
 	info->pseudo_palette =3D par->pseudo_palette;
=20
 	sbusfb_fill_var(&info->var, dp, 32);
-	par->fbsize =3D PAGE_ALIGN(info->var.xres * info->var.yres * 4);
+	info->fix.smem_len =3D PAGE_ALIGN(info->var.xres * info->var.yres * 4);
 	ffb_fixup_var_rgb(&info->var);
=20
 	info->var.accel_flags =3D FB_ACCELF_TEXT;
@@ -1003,7 +998,7 @@ static int __devinit ffb_probe(struct of
 	       "DAC pnum[%x] rev[%d] manuf_rev[%d]\n",
 	       dp->full_name,
 	       ((par->flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
-	       par->physbase, par->board_type,
+	       info->fix.smem_start, par->board_type,
 	       dac_pnum, dac_rev, dac_mrev);
=20
 	return 0;

----------------------------------------------------------------------
Szukasz pracy? Sprawd=BC nasze oferty!
http://link.interia.pl/f2142

