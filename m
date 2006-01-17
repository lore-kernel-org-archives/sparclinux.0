From: Jeffrey Forman <jforman@gentoo.org>
Date: Tue, 17 Jan 2006 00:19:43 +0000
Subject: qla2200 borkage on 2.6.15.x ?
Message-Id: <1137457183.9960.130.camel@sixthstreet.jeffreyforman.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-dGSj7qTuFg5MtspEA8YG"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-dGSj7qTuFg5MtspEA8YG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey guys,

I've got a sun blade 1000, 2x750, with one FCAL drive in there:

  Vendor: SEAGATE   Model: ST336605FSUN36G   Rev: 0438
  Type:   Direct-Access                      ANSI SCSI revision: 03

was just trying to get the machine up on 2.6.15 and I got some lovely
kernel panic output.

Vanilla 2.6.15.1:
http://dev.gentoo.org/~jforman/blade1000-2.6.15.1.qla2200output

Gentoo Sources 2.6.15-gentoo-r1:
http://dev.gentoo.org/~jforman/blade1000-gentoo-2.6.15-gentoo-r1.output

Hopefully that provides some help as to whats going on.

Regards,
Jeffrey
--=20

-----------------------
Jeffrey Forman
Gentoo Infrastructure
Gentoo Release Engineering
Bugs.Gentoo.org Administrator
jforman@gentoo.org
-----------------------

--=-dGSj7qTuFg5MtspEA8YG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDzDgf/VRN5BlQ3dQRAqEcAJ4hBlgJyFsSJTaEt9EkHWp3pt2XKQCfTlzQ
R+kdBcjUTWdynZFNJjouhso=
=rmGE
-----END PGP SIGNATURE-----

--=-dGSj7qTuFg5MtspEA8YG--

