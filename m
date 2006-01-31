From: Ferris McCormick <fmccor@gentoo.org>
Date: Tue, 31 Jan 2006 17:24:07 +0000
Subject: kenvctrld  (bbc.ko) very CPU intensive with kernel-2.6.15 on SB1000
Message-Id: <1138728247.8209.6.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-oScsdnR0R/NSmDioGFaQ"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-oScsdnR0R/NSmDioGFaQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I notice that with kernel-2.6.15, kenvctrld (module bbc.ko) uses about
40% of CPU0 on SB1000-SMP; with 2.6.13 series, it is pretty unobtrusive.
Unfortunately, this has an unpleasant side effect:  If other CPU
intensive work is going on at the same time, system response (e.g.,
mouse movement in X) becomes very sluggish.

Is this an intended change?  Unfortunately, with bbc.ko unloaded, the
fans in the SB1000 run at full speed, and the system is extremely noisy.

Regards,
Ferris
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-oScsdnR0R/NSmDioGFaQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD3502Qa6M3+I///cRAsWGAKDoF6/Sx55Ep3jUvwyFxuS6/RX9CQCgxyZJ
G6Y1LwATkug3xiz9XY0p9NU=
=MjVv
-----END PGP SIGNATURE-----

--=-oScsdnR0R/NSmDioGFaQ--

