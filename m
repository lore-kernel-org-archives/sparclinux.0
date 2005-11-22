From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 22 Nov 2005 15:17:04 +0000
Subject: CG3 frame buffer is broaken (2.6.12 onwards) again [PATCH]
Message-Id: <Pine.LNX.4.10.10511221501160.30262-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net, wli@holomorphy.com, zippel@linux-m68k.org
Cc: linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org, kbuild-devel@lists.sourceforge.net

Hi all,

A cut and past error regarding the CG3 frame buffer needs to be fixed. It
also affects Creator/Creator3D/Elite3D.

The fix for linux-2.6.14.2 is to patch drivers/video/Kconfig:
######################################################################
#
# Linux 2.6.14 CG3 Fix from mark@mtfhpc.demon.co.uk
#
######################################################################
diff -ruNp linux-2.6.14.2/drivers/video/Kconfig linux-2.6.14.2-p01/drivers/video/Kconfig
--- linux-2.6.14.2/drivers/video/Kconfig	2005-11-14 12:53:33.000000000 +0000
+++ linux-2.6.14.2-p01/drivers/video/Kconfig	2005-11-15 18:13:29.000000000 +0000
@@ -577,6 +577,12 @@ config FB_SUN3
 	bool "Sun3 framebuffer support"
 	depends on (FB = y) && (SUN3 || SUN3X) && BROKEN
 
+config FB_SBUS
+	bool "SBUS and UPA framebuffers"
+	depends on (FB = y) && (SPARC32 || SPARC64)
+	help
+	  Say Y if you want support for SBUS or UPA based frame buffer device.
+
 config FB_BW2
 	bool "BWtwo support"
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
@@ -590,6 +596,7 @@ config FB_BW2
 config FB_CG3
 	bool "CGthree support"
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
@@ -1288,15 +1295,10 @@ config FB_AU1100
 
 source "drivers/video/geode/Kconfig"
 
-config FB_SBUS
-	bool "SBUS and UPA framebuffers"
-	depends on (FB = y) && (SPARC32 || SPARC64)
-	help
-	  Say Y if you want support for SBUS or UPA based frame buffer device.
-
 config FB_FFB
 	bool "Creator/Creator3D/Elite3D support"
 	depends on FB_SBUS && SPARC64
+	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR

---------------------------------------------------------------------
The patch should also work for 2.6.12 and 2.6.13 kernels but might need
tweeking.
 
Regards
	Mark Fortescue.


