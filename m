From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 12 Feb 2010 00:56:03 +0000
Subject: Re: parsic/sh/sparc tracehook breakage when tracing signals
Message-Id: <201002111956.06261.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4114757.S9cX2Y7Bec"
List-Id: <sparclinux.vger.kernel.org>
References: <201002111910.50596.vapier@gentoo.org> <20100211.163950.206150918.davem@davemloft.net>
In-Reply-To: <20100211.163950.206150918.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, roland@redhat.com, linux-kernel@vger.kernel.org

--nextPart4114757.S9cX2Y7Bec
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 11 February 2010 19:39:50 David Miller wrote:
> From: Mike Frysinger <vapier@gentoo.org>
> > when i ported the Blackfin code to the tracehook framework, i copied a
> > latent bug from the sparc port.  trying to trace another process while
> > handling signals no longer worked (and subsequently broke some of the g=
db
> > tests).
>=20
> What you seem to be missing is that on Sparc TIF_SINGLESTEP will never
> be set, because it does not support hardware single step.
>=20
> This thread flag is not even defined on that platform.

my point is that these arches never call ptrace_notify(SIGTRAP) from their=
=20
signal handlers.  maybe the arch is unable to due to some port/hardware=20
limitation and this is currently the expected behavior.

dont get me wrong ... i dont particularly care if your arch has a bug in it=
=20
here.  my arch did have a bug and on the off chance that others did too, i=
=20
thought i'd drop an e-mail to people.  if your arch is in the "limited"=20
category, feel free to ignore this.
=2Dmike

--nextPart4114757.S9cX2Y7Bec
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLdKcmAAoJEEFjO5/oN/WBjKgQAOF1OJjSLt8BGQgePEJJ4RAJ
LNVK3XSi4kOKIAfa3eSz3XAxrwx7Q+D9o+tSrAlAPp/1qx06G1cq5CV33/NQEIn1
IWkSiCgVDBEGv03u5TNNy3MgEkspHzZumTxzBrJByGRpGpXXktdXadJWsqUoJEwM
vOlzyo3Ep9Hvcx53y/SQk/E/V86j4KHXiIMl86xSLFV1WtCtdEo5XzO15jbEYVWo
P/Lc90rSCG3PZEaxLwIrUNJIXjt+MNKQEO4HXTJhRhhYhcjorBrqOk9JUKzjwQx4
u1cxgM2lo1ND64QvRvHCpI2WxdB0cdl0fuAUnr7ERhRpuOCSUpeLYtQzFXPc0So+
LOq7gJbm0PixwfNLaB2e4a7jWBLoPQjJdQ8t8DA05qo8Y3DS16Ga45c3qhVG5+Cu
uR9xEHZEvkhz7An/vGRxneLaC/v48GAFE9Igwsx/Dt5mIz9v6Z194SyRP3wyxgIi
7JpKqxieoE5zKTSwZUKxwQeSroHtpIOq2PvI9viE+AsjD8iSqvOVaXzDL7Mm0MNR
dHyUJc4kbKD06IwKdGkEilB40Y0pGT+RJdLvLws2J1YriTYiOf6Q9cUPXHxAwMBG
11x2j9nTBJuvrQYetnEUVqas8gffehMdfk4v1GhtbCTUBvl40zdJukKeDfe0J/l1
HVpvdlobV13+Co98VVg3
=MqHy
-----END PGP SIGNATURE-----

--nextPart4114757.S9cX2Y7Bec--
