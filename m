From: Joshua Kwan <joshk@triplehelix.org>
Date: Tue, 06 Jul 2004 08:43:02 +0000
Subject: [PATCH 2.4] drivers/scsi/esp.c is GPL'd
Message-Id: <20040706084302.GA3597@darjeeling.triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dave,

I took a look at esp.c in 2.6 and there's a MODULE_LICENSE("GPL") in
there. I modularized it experimentally for Debian and I was quite
surprised when loading it tainted my kernel :)

Assuming you had the same ideas back in 2.4, here's a patch that sets
MODULE_LICENSE("GPL") for 2.4's esp.c.

Thanks,

--=20
Joshua Kwan

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="esp_is_GPL.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.4.26/drivers/scsi/esp.c~	2004-07-06 01:34:22.000000000 =
-0700
+++ kernel-source-2.4.26/drivers/scsi/esp.c	2004-07-06 01:35:00.000000000 -=
0700
@@ -4368,4 +4368,6 @@
=20
 #include "scsi_module.c"
=20
+MODULE_LICENSE("GPL");
+
 EXPORT_NO_SYMBOLS;

--OXfL5xGRrasGEqWY--

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQOpmFqOILr94RG8mAQIBgQ//XyIl8EaJYZqpOUeuCzLYgAhFDyULB9YU
oIho0kOXqjN4924y3JT/M4kKX/N32oPqCbnDvbgIraAY47sJ8eL75ObGwyXm242l
Hue6QQPbWv6B6Kqu4+sthn0VrGFxdYmoh9l1J+K2s05cmYWYJjDkS/mVfWQSB1CJ
VHizcH/lYJiE2VYwG+iviIC3piTcW4pWlWMx/9blBBbSRSvGXaWjOUMfw+lB9NRK
7b1EGonCb6wBSubg/wyZ1Y414YAuq8zjyuZG9oj365KbTVlgLyj852lNdTqYw0dt
qwtwFLOF1MeJ+wrkyPnQNia9vO5YFckjjx+b2IN6sAgU4rifrQU2SlhvsdJyI+RB
MVXhUPifDznNG9KtSSakggeoqIfA9VpIRuRPUD8yuIzpRPK6rmj9sBKPy8FyFEx3
2wWLpqkXQw4FAaP3VLKDAEZeqSNGvBmZyoIO9ecnmIicBImzlR67ZFSdrIFgPVex
p84x35BcXqTMINBodBVVoqmx/EqlmUGHxc5Xvr6jUbql1DaOtzM9Kpvkb2thAwXY
XNhn+I5d5uHCiH2qUu1LCSaxXG3cDMCvSCHHyGpl62kbQ/54tCCN5SqctqA8Agkt
6UtON3BeiHuU8Br6IudnVdUhf9GUHT8zFGZnxG+I3R+KVCo2a/ALEzclVTB9TZQ4
4H1Et6cW2U0=
=qGXR
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
