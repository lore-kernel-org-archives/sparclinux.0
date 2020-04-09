From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Thu, 09 Apr 2020 18:50:30 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <7975934.7CMqr95tqx@daneel.sf-tec.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1827298.CxYgaetDCC"
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
To: sparclinux@vger.kernel.org

--nextPart1827298.CxYgaetDCC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 9. April 2020, 10:11:18 CEST schrieb Rolf Eike Beer:
> Am Montag, 30. M=E4rz 2020, 10:41:09 CEST schrieb Rolf Eike Beer:
> > I run a 32 bit Gentoo userspace on my T5120 with a 64 bit kernel (5.5.7=
 at
> > the moment). This is nothing really new, I see this for a while, but it
> > seems to got a bit worse lately.
> >=20
> > My observations are:
> > -the testsuite of the fish shell often hangs. A subprocess goes zombie,
> > but
> > the parent never cleans this up
>=20
> This also happens on sparc64.

Given that is only calls select() here over and over again I think it's an=
=20
application bug, files here:

https://github.com/fish-shell/fish-shell/issues/6878

Eike
--nextPart1827298.CxYgaetDCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCXo9udgAKCRBcpIk+abn8
Tj50AKCg2/dMBAupLTdzkEdaoEHrG4uuEwCffGJEy2IN02XLTilDoW2pNzSPvvg=
=OQu2
-----END PGP SIGNATURE-----

--nextPart1827298.CxYgaetDCC--
