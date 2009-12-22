From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 22 Dec 2009 00:19:37 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <200912211819.48529.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1500857.3ovqrAtsDU"
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
To: sparclinux@vger.kernel.org

--nextPart1500857.3ovqrAtsDU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 21 December 2009 06:06:26 pm Jan Engelhardt wrote:
> Hi,
>=20
>=20
> RPM offers the targets sparcv9v/sparc64v (which is, simply put,
> cflags +=3D -mtune=3Dniagara).
>=20
> On a sun4v, it would make sense to prefer v9v/64v packages over v9/64
> packages =E2=80=94 and the reverse on sun4u =E2=80=94 when a package mana=
ger
> considers potential candidate files for installation of a wanted
> package.
>=20
> But how would the package manager (apt-get/yum/zypper) decide whether
> they are on sun4v or not, without resorting to testing for
> SPARC-specific hardware itself? That is to say, I think the kernel
> should hand out this information in some way perhaps. Solaris's uname(2)
> syscall would directly return sun4[cduv], while Linux just outputs
> sparc/sparc64.
>=20
yum does this by checking /proc/cpuinfo look at /usr/lib/python2.6/site-
packages/rpmUtils/arch.py on a F-12 box  and search for sun4v  rpm has a=20
similar check based on the same information. both will refuse to install a=
=20
sparcv9v package on hardware that is not capable of running it.

Dennis

--nextPart1500857.3ovqrAtsDU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEABECAAYFAkswEKQACgkQkSxm47BaWfeMWwCgnh707to54jhBWALR/nEOvI+P
vEcAoL62ZUn6+qrjcn6/Lrp02RTU7arr
=a0+E
-----END PGP SIGNATURE-----

--nextPart1500857.3ovqrAtsDU--
