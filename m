From: Dennis Gilmore <dennis@ausil.us>
Date: Sun, 27 Feb 2011 02:08:00 +0000
Subject: Re: [PATCH] sparc64: fix unused-but-set-variable warnings
Message-Id: <201102262008.12225.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2235045.YsC1QuqzoU"
List-Id: <sparclinux.vger.kernel.org>
References: <20110226085151.GA23117@merkur.ravnborg.org>
In-Reply-To: <20110226085151.GA23117@merkur.ravnborg.org>
To: sparclinux@vger.kernel.org

--nextPart2235045.YsC1QuqzoU
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday, February 26, 2011 04:28:43 PM Sam Ravnborg wrote:
> David - please do not apply this yet.
> I need to go through it to convince myself that it is OK to ignore
> the return resut in the cases where I blindly deleted it for now.
>=20
> I will repost when I have done so.
>=20
> Dennis - I would still like to know if this fixes all
> sparc warnings so you no longer need to drop -Werror.


arch/sparc/kernel/smp_64.c: In function 'flush_dcache_page_all':
arch/sparc/kernel/smp_64.c:935:6: error: variable 'this_cpu' set but not us=
ed=20
[-Werror=3Dunused-but-set-variable]
cc1: all warnings being treated as errors
make[1]: *** [arch/sparc/kernel/smp_64.o] Error 1

it fails to build still.  thanks Sam

Dennis

--nextPart2235045.YsC1QuqzoU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk1psgwACgkQkSxm47BaWfdPrQCfdcmpHC7DMpXUDlsNPHSDK2F3
hfoAoKgIAvDICYHDs4vlkEi9aJywzkx5
=qHuK
-----END PGP SIGNATURE-----

--nextPart2235045.YsC1QuqzoU--
