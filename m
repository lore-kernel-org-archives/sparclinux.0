From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Sat, 03 Jan 2004 13:31:47 +0000
Subject: [2.6.1-rc1] CONFIG_DRM_FFB=y Fix
Message-Id: <20040103133147.0182a1dc@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Sat__3_Jan_2004_13_31_47_+0000_4LsqC_LY2sIVbP8g"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature=_Sat__3_Jan_2004_13_31_47_+0000_4LsqC_LY2sIVbP8g
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__3_Jan_2004_13_31_47_+0000_jz.KcyTih9+Muxq1"


--Multipart=_Sat__3_Jan_2004_13_31_47_+0000_jz.KcyTih9+Muxq1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

2.6.1-rc1 gives compile errors with CONFIG_DRM_FFB=y:

  CC      drivers/char/drm/ffb_drv.o
drivers/char/drm/ffb_drv.c:386: error: redefinition of `ffb_options'
drivers/char/drm/drm_drv.h:153: error: `ffb_options' previously defined
here
make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1
make[2]: *** [drivers/char/drm] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

I seem to remember this being fixed in 2.4.x recently, but 2.6.1-rc1 is
still affected. The attached patch sorts it out.

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm

--Multipart=_Sat__3_Jan_2004_13_31_47_+0000_jz.KcyTih9+Muxq1
Content-Type: text/x-diff;
 name="linux-2.6-ffb-fix.patch"
Content-Disposition: attachment;
 filename="linux-2.6-ffb-fix.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.6.1-rc1/drivers/char/drm/ffb_drv.c.orig	2004-01-03 13:10:54.851000000 +0000
+++ linux-2.6.1-rc1/drivers/char/drm/ffb_drv.c	2004-01-03 13:11:45.311000000 +0000
@@ -372,25 +372,6 @@
 	return ret;
 }
 
-#ifndef MODULE
-/* DRM(options) is called by the kernel to parse command-line options
- * passed via the boot-loader (e.g., LILO).  It calls the insmod option
- * routine, drm_parse_drm.
- */
-
-/* JH- We have to hand expand the string ourselves because of the cpp.  If
- * anyone can think of a way that we can fit into the __setup macro without
- * changing it, then please send the solution my way.
- */
-static int __init ffb_options(char *str)
-{
-	DRM(parse_options)(str);
-	return 1;
-}
-
-__setup(DRIVER_NAME "=", ffb_options);
-#endif
-
 #include "drm_fops.h"
 #include "drm_init.h"
 #include "drm_ioctl.h"

--Multipart=_Sat__3_Jan_2004_13_31_47_+0000_jz.KcyTih9+Muxq1--

--Signature=_Sat__3_Jan_2004_13_31_47_+0000_4LsqC_LY2sIVbP8g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9sRL96zL6DUtXhERAmSAAJ4obqzImBjwxbDEmD6apEWTh+WAMwCg0y6U
M3gnKmTLnQLkeNlU+w4A2h0=
=6EjG
-----END PGP SIGNATURE-----

--Signature=_Sat__3_Jan_2004_13_31_47_+0000_4LsqC_LY2sIVbP8g--
