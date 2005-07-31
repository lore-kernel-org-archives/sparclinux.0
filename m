From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sun, 31 Jul 2005 03:22:39 +0000
Subject: [2.6 Patch 1/3] Kconfig updates and cleanup: drivers/video/Kconfig
Message-Id: <1122780159.15363.25.camel@cloud.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-SOv2ht+DEifoy110+DNU"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-SOv2ht+DEifoy110+DNU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I sent these Kconfig patches a few months ago, but there was no
response.  I've been maintaining them for Gentoo since around 2.6.9, and
I'd rather get this stuff upstream than have to rediff every few weeks,
so please take a look at them and comment if there's something not quite
acceptable.  This first one is rather trivial...

Cleanup dependencies for sparc framebuffers and move them after the
FB_SBUS option in Kconfig.

Signed-off-by: Jeremy Huddleston <eradicator@gentoo.org>

--- linux-2.6.13-rc4-git2/drivers/video/Kconfig	2005-07-30
19:46:12.340066048 -0700
+++ linux-2.6.13-rc4-git2-gentoo/drivers/video/Kconfig	2005-07-30
19:52:17.871423379 -0700
@@ -573,39 +573,6 @@ config BUS_I2C
 	depends on (FB =3D y) && VISWS
 	default y
=20
-config FB_SUN3
-	bool "Sun3 framebuffer support"
-	depends on (FB =3D y) && (SUN3 || SUN3X) && BROKEN
-
-config FB_BW2
-	bool "BWtwo support"
-	depends on (FB =3D y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 ||
SUN3X) && FB_SUN3)
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
-	help
-	  This is the frame buffer device driver for the BWtwo frame buffer.
-
-config FB_CG3
-	bool "CGthree support"
-	depends on (FB =3D y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 ||
SUN3X) && FB_SUN3)
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
-	help
-	  This is the frame buffer device driver for the CGthree frame buffer.
-
-config FB_CG6
-	bool "CGsix (GX,TurboGX) support"
-	depends on (FB =3D y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 ||
SUN3X) && FB_SUN3)
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
-	help
-	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
-	  frame buffer.
-
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
 	depends on FB && SH_DREAMCAST
@@ -1259,15 +1226,38 @@ config FB_SBUS
 	help
 	  Say Y if you want support for SBUS or UPA based frame buffer device.
=20
-config FB_FFB
-	bool "Creator/Creator3D/Elite3D support"
-	depends on FB_SBUS && SPARC64
+config FB_SUN3
+	bool "Sun3 framebuffer support"
+	depends on (FB =3D y) && (SUN3 || SUN3X) && BROKEN
+
+config FB_BW2
+	bool "BWtwo support"
+	depends on FB_SBUS || FB_SUN3
+	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
 	help
-	  This is the frame buffer device driver for the Creator, Creator3D,
-	  and Elite3D graphics boards.
+	  This is the frame buffer device driver for the BWtwo frame buffer.
+
+config FB_CG3
+	bool "CGthree support"
+	depends on FB_SBUS || FB_SUN3
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	help
+	  This is the frame buffer device driver for the CGthree frame buffer.
+
+config FB_CG6
+	bool "CGsix (GX,TurboGX) support"
+	depends on FB_SBUS || FB_SUN3
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	help
+	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
+	  frame buffer.
=20
 config FB_TCX
 	bool "TCX (SS4/SS5 only) support"
@@ -1313,6 +1303,16 @@ config FB_LEO
 	  This is the frame buffer device driver for the SBUS-based Sun ZX
 	  (leo) frame buffer cards.
=20
+config FB_FFB
+	bool "Creator/Creator3D/Elite3D support"
+	depends on FB_SBUS && SPARC64
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	help
+	  This is the frame buffer device driver for the Creator, Creator3D,
+	  and Elite3D graphics boards.
+
 config FB_PCI
 	bool "PCI framebuffers"
 	depends on (FB =3D y) && PCI && (SPARC64 || SPARC32)


--=-SOv2ht+DEifoy110+DNU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC7EP/OpjtAl+gMRURAnOFAKDKqno2cBE8p7cCRfXGUWWLawsn+ACggqE0
ZhVZ9Hqup0LKQyi/QqMtFpw=
=bwIN
-----END PGP SIGNATURE-----

--=-SOv2ht+DEifoy110+DNU--

