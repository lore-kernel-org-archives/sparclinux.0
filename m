From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Thu, 09 Apr 2020 08:11:18 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <5121018.IRn6nV2ZPn@daneel.sf-tec.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart3940060.4HlUvDv14c"
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
To: sparclinux@vger.kernel.org

--nextPart3940060.4HlUvDv14c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 30. M=E4rz 2020, 10:41:09 CEST schrieb Rolf Eike Beer:
> I run a 32 bit Gentoo userspace on my T5120 with a 64 bit kernel (5.5.7 at
> the moment). This is nothing really new, I see this for a while, but it
> seems to got a bit worse lately.
>=20
> My observations are:
> -the testsuite of the fish shell often hangs. A subprocess goes zombie, b=
ut
> the parent never cleans this up

This also happens on sparc64.

Eike
--nextPart3940060.4HlUvDv14c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCXo7YpgAKCRBcpIk+abn8
TgpGAJ90O55i68WPNuWj3pjQ71sxwBYoRwCgibeZmu0fjCXphc3Lj5PsqNTLV00=
=pdaS
-----END PGP SIGNATURE-----

--nextPart3940060.4HlUvDv14c--
