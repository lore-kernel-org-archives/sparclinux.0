From: joshk@triplehelix.org (Joshua Kwan)
Date: Mon, 02 Aug 2004 17:30:47 +0000
Subject: [PATCH 2.4] [RESEND] esp.c is GPL
Message-Id: <20040802173047.GG1914@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wxDdMuZNg1r63Hyj"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Sent you a smaller version of this patch before. This 'backports' the
setting of MODULE_LICENSE("GPL") for the following files, from all the
way back to 2.6.1, to 2.4.26 (should apply on latest BK too):

 fc4/fc.c            |    2 ++
 sbus/char/bpp.c     |    2 ++
 sbus/char/vfc_dev.c |    2 +-
 scsi/esp.c          |    2 +-
 scsi/fcal.c         |    2 +-
 scsi/pluto.c        |    2 +-
 scsi/qlogicpti.c    |    2 +-
 7 files changed, 9 insertions(+), 5 deletions(-)

It also removes EXPORT_NO_SYMBOLS from those files based on the advice
=66rom Jan-Benedict Glaw.

This patch is necessary so these drivers if built as modules (especially
esp and bpp) don't taint the kernel erroneously. I might have mislicensed
some files though, if they have changed or have been rewritten since 2.4
days.

Please apply if all is well.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="module_licenses.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.4.26/drivers/fc4/fc.c~	2004-08-02 10:09:54.000000000 -0=
700
+++ kernel-source-2.4.26/drivers/fc4/fc.c	2004-08-02 10:10:09.000000000 -07=
00
@@ -1155,3 +1155,5 @@
 	kfree(p);
 	return status;
 }
+
+MODULE_LICENSE("GPL");
--- kernel-source-2.4.26/drivers/sbus/char/bpp.c~	2004-08-02 10:08:31.00000=
0000 -0700
+++ kernel-source-2.4.26/drivers/sbus/char/bpp.c	2004-08-02 10:10:33.000000=
000 -0700
@@ -1073,3 +1073,5 @@
=20
 module_init(bpp_init);
 module_exit(bpp_cleanup);
+
+MODULE_LICENSE("GPL");
--- kernel-source-2.4.26/drivers/sbus/char/vfc_dev.c~	2004-08-02 10:08:39.0=
00000000 -0700
+++ kernel-source-2.4.26/drivers/sbus/char/vfc_dev.c	2004-08-02 10:10:48.00=
0000000 -0700
@@ -743,4 +743,4 @@
 }
 #endif
=20
-
+MODULE_LICENSE("GPL");
--- kernel-source-2.4.26/drivers/scsi/esp.c~	2004-08-02 10:04:30.000000000 =
-0700
+++ kernel-source-2.4.26/drivers/scsi/esp.c	2004-08-02 10:06:45.000000000 -=
0700
@@ -4368,4 +4368,4 @@
=20
 #include "scsi_module.c"
=20
-EXPORT_NO_SYMBOLS;
+MODULE_LICENSE("GPL");
--- kernel-source-2.4.26/drivers/scsi/fcal.c~	2004-08-02 10:08:51.000000000=
 -0700
+++ kernel-source-2.4.26/drivers/scsi/fcal.c	2004-08-02 10:11:13.000000000 =
-0700
@@ -300,4 +300,4 @@
=20
 #include "scsi_module.c"
=20
-EXPORT_NO_SYMBOLS;
+MODULE_LICENSE("GPL");
--- kernel-source-2.4.26/drivers/scsi/pluto.c~	2004-08-02 10:09:25.00000000=
0 -0700
+++ kernel-source-2.4.26/drivers/scsi/pluto.c	2004-08-02 10:11:33.000000000=
 -0700
@@ -339,4 +339,4 @@
=20
 #include "scsi_module.c"
=20
-EXPORT_NO_SYMBOLS;
+MODULE_LICENSE("GPL");
--- kernel-source-2.4.26/drivers/scsi/qlogicpti.c~	2004-08-02 10:09:30.0000=
00000 -0700
+++ kernel-source-2.4.26/drivers/scsi/qlogicpti.c	2004-08-02 10:11:53.00000=
0000 -0700
@@ -1533,4 +1533,4 @@
=20
 #include "scsi_module.c"
=20
-EXPORT_NO_SYMBOLS;
+MODULE_LICENSE("GPL");

--4SFOXa2GPu3tIq4H--

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQQ56RaOILr94RG8mAQKZXBAAyXIzqSXC4+y07CFGJTGeRiACqRkVxqn+
PO01a/9I5A9ayhVdlQ8uWwz0GumkxGfhWAnHUAnIGdxmQDaxdrTOSQcIfuAN5ZTJ
qBZexIsfYmcsRM6voNR83k5rvYJi6R9eRcQjrOu3q192sxtXznY63RNWT2bugKUf
8qkMn8e3Pf7CzM6Tf0QVlVZvLH3f5k807g2SQy39W02D2vYjPYvqYII377z8v+4X
rLDVxiV+8d74aJMEulcFi5iQdVY5U26VX89pRerVTm1bsE9hOeF2auFBLysDkdyZ
oBLrU/dfwYrDD2MakJHTDwuuvAuNKsCUnoozZ6prR22wY75O3NuN4MW+bZ3Q8Y2L
SLp6IQOhoAB8dKcLtncms5uBZORELl/Na9fuVHmFmTvmcKKRbSxdo19WYMDcM0hJ
RIbH+geQHV/gI0M/Qd5FaGyzeb1/f7VQBypkwL6ga0d+SonUF24aWCUU/L6JTY3C
iMFtie+wutrV+dfQPfYqM6G0ngNgumE0nhFNp6iYlYdl3M2nRp6GtlEgmqgEQKmc
a67H/Zxw1Ag7YygWozeJlfwqgGGsJvq2HN8e/eOZjUpbBYHj63nuFiwHEHSKGkd9
HwdsSvjie/s3DnMubtoMl9j9k6cdiBINyHlTbOJRRMuwwGT8wFsej/n0e9h1DO65
KLBRCozlcxs=
=ufz5
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
