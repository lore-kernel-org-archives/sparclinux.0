From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 04 May 2009 16:59:56 +0000
Subject: [PATCH] igafb: use framebuffer_alloc() to allocate fb_info struct
Message-Id: <20090504185956.82408911.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, sparclinux <sparclinux@vger.kernel.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the framebuffer_alloc() function to allocate the fb_info
structure so the structure is correctly initialized after allocation.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/igafb.c linux-2.6.30/drivers/video/igafb=
.c
--- linux-orig/drivers/video/igafb.c	2008-08-09 05:09:03.000000000 +0200
+++ linux-2.6.30/drivers/video/igafb.c	2009-05-04 00:14:28.000000000 +0200
@@ -395,17 +395,16 @@ int __init igafb_init(void)
 	/* We leak a reference here but as it cannot be unloaded this is
 	   fine. If you write unload code remember to free it in unload */
 =09
-	size =3D sizeof(struct fb_info) + sizeof(struct iga_par) + sizeof(u32)*16;
+	size =3D sizeof(struct iga_par) + sizeof(u32)*16;
=20
-        info =3D kzalloc(size, GFP_ATOMIC);
+	info =3D framebuffer_alloc(size, &pdev->dev);
         if (!info) {
                 printk("igafb_init: can't alloc fb_info\n");
 		 pci_dev_put(pdev);
                 return -ENOMEM;
         }
=20
-	par =3D (struct iga_par *) (info + 1);
-=09
+	par =3D info->par;
=20
 	if ((addr =3D pdev->resource[0].start) =3D 0) {
                 printk("igafb_init: no memory start\n");
@@ -526,7 +525,6 @@ int __init igafb_init(void)
 	info->var =3D default_var;
 	info->fix =3D igafb_fix;
 	info->pseudo_palette =3D (void *)(par + 1);
-	info->device =3D &pdev->dev;
=20
 	if (!iga_init(info, par)) {
 		iounmap((void *)par->io_base);

----------------------------------------------------------------------
Szukasz pracy? Sprawd=BC nasze oferty!
http://link.interia.pl/f2142

