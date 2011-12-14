From: Sergei Trofimovich <slyich@gmail.com>
Date: Wed, 14 Dec 2011 18:55:16 +0000
Subject: Re: Sparc-32 doesn't work in 3.1.
Message-Id: <20111214215516.26ffe884@sf.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/pxvGas2FXDD+YCSBuo_S=i1"
List-Id: <sparclinux.vger.kernel.org>
References: <4EE80891.70604@landley.net>
	<20111214204225.7c8ec86c@sf.home>
	<20111214.125443.973289484729064945.davem@davemloft.net>
	<20111214.131810.916491563666428853.davem@davemloft.net>
In-Reply-To: <20111214.131810.916491563666428853.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: rob@landley.net, aboriginal@lists.landley.net, linux-kernel@vger.kernel.org, tytso@mit.edu, sparclinux@vger.kernel.org, jakub@redhat.com

--Sig_/pxvGas2FXDD+YCSBuo_S=i1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

> sparc32: Be less strict in matching %lo part of relocation.
>=20
> The "(insn & 0x01800000) !=3D 0x01800000" test matches 'restore'
> but that is a legitimate place to see the %lo() part of a 32-bit
> symbol relocation, particularly in tail calls.
>=20
> Signed-off-by: David S. Miller <davem@davemloft.net>

Tested-by: Sergei Trofimovich <slyfox@gentoo.org>

Was about to send exactly the same. Thanks!

--=20

  Sergei

--Sig_/pxvGas2FXDD+YCSBuo_S=i1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk7o8RUACgkQcaHudmEf86pIlwCfdEXfeJjG2l+eMHHAvfVDIkTe
u5oAniMK9UwMuHE0CHZlwNywV/LsFTiy
=YHMg
-----END PGP SIGNATURE-----

--Sig_/pxvGas2FXDD+YCSBuo_S=i1--
