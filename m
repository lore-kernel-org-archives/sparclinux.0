From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Sun, 07 Jun 2020 07:34:05 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <4725976.BPSWWyVmpD@daneel.sf-tec.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4158771.nXM9zAifOn"
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
To: sparclinux@vger.kernel.org

--nextPart4158771.nXM9zAifOn
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

Thanks to the work of the fish maintainer this now looks like it is a bug i=
n=20
either gcc or posix_spawn() or something like that:

https://github.com/fish-shell/fish-shell/issues/6878#issuecomment-640128661

A minimal testcase is here:

https://gist.github.com/ridiculousfish/1b28af43ae2a3a871a5f4aa43a3811f2

This is not limited to sparc32 userspace, but also affects sparc64.

Eike
--nextPart4158771.nXM9zAifOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCXtyYbQAKCRBcpIk+abn8
TnWKAJ4ywJXAx+2BksEARNWYGRjUX4MQEQCcDEvBKq3GTdNVfIB0wHwEFzeRlsc=
=E+m/
-----END PGP SIGNATURE-----

--nextPart4158771.nXM9zAifOn--
