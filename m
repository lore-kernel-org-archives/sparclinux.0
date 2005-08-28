From: Jason Wever <weeve@gentoo.org>
Date: Sun, 28 Aug 2005 03:14:53 +0000
Subject: kenvctrld using excessive CPU
Message-Id: <20050827211453.14abe4ba@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Sat__27_Aug_2005_21_14_53_-0600_mLrXQK7khImlPGtM"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature_Sat__27_Aug_2005_21_14_53_-0600_mLrXQK7khImlPGtM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

In both linux-2.6.13-rc6-git10 and 2.6.13-rc7 on a Blade 1000, kenvctrld
is using excessive amounts of CPU (at some points just shy of 100%).=20
The amount of CPU used fluxuates greatly and dramatically impacts system
performance.

Has anyone else experienced anything like this?

Thanks,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Sat__27_Aug_2005_21_14_53_-0600_mLrXQK7khImlPGtM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDESwvdKvgdVioq28RAny9AKChrS67NqPHa+8xr9wQg940AD807QCgsXpP
5U+t5mRA/3/TORvAJ0FmWiQ=
=TrtM
-----END PGP SIGNATURE-----

--Signature_Sat__27_Aug_2005_21_14_53_-0600_mLrXQK7khImlPGtM--
