From: Ferris McCormick <fmccor@gentoo.org>
Date: Wed, 15 Feb 2006 13:09:15 +0000
Subject: kernel-2.6.15-r4 (in)stability on U2-SMP, etc.
Message-Id: <1140008955.4844.42.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-5YUX2T/6wOQZx2g6PLcL"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-5YUX2T/6wOQZx2g6PLcL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

A few days ago, I indicated that I was testing subject kernel on various
systems (U2-SMP, U60-SMP, SB1000-MP) for stability.  U60/SB1000 appear
to be stable.

However, U2-SMP(2x450) is not.  As is the case with ALL 2.6.xx kernels,
2.6.15-r4 cannot handle the sort of disk activity which portage requires
of it on a daily basis (although the daily slocate cron task no linger
kills it).  Symptom is as with all kernels in the 2.6.xx series ---
silent death with system completely non-responsive to anything.

Regards,
Ferris=20
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-5YUX2T/6wOQZx2g6PLcL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8yf7Qa6M3+I///cRAvKLAKC5/SjLCjwczOQdL6nhsOdTZ0xQGwCgl/8u
X9bqzpfHtA+57PJN3U0vbcM=
=LWpr
-----END PGP SIGNATURE-----

--=-5YUX2T/6wOQZx2g6PLcL--

