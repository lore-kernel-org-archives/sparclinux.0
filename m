From: Friedrich Oslage <bluebird@gentoo.org>
Date: Mon, 28 Jul 2008 19:57:39 +0000
Subject: Re: [BUG] 2.6.26-rc1 broke X on SPARC Ultra5
Message-Id: <1217275060.8894.7.camel@lya.porno-bullen.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-nNnmTwvInLQBDYGVN8fm"
List-Id: <sparclinux.vger.kernel.org>
References: <18500.62552.958244.633204@harpo.it.uu.se>
In-Reply-To: <18500.62552.958244.633204@harpo.it.uu.se>
To: sparclinux@vger.kernel.org


--=-nNnmTwvInLQBDYGVN8fm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Debian SID uses xorg-server 1.4.2 but to get a working you need 1.5(aka
1.4.99.*).

Cheers,
Friedrich

Am Montag, den 28.07.2008, 18:15 +0200 schrieb Daniel Smolik:
> Have anybody now working X on some multidomain PCI machine like E250 or=20
> E450 ? I have upgraded to 2.6.26 and latest SID and now is my Permedia2=20
> card detected but X crashes with :
>=20
>=20
> (++) Using config file: "/root/xorg.conf.new"
> (WW) ****INVALID MEM ALLOCATION**** b: 0x20000 e: 0x3ffff correcting
> (WW) ****INVALID MEM ALLOCATION**** b: 0x800000 e: 0xffffff correcting
> (WW) ****INVALID MEM ALLOCATION**** b: 0x1000000 e: 0x17fffff correcting
> mmap failure: Invalid argument
>=20
> Fatal server error:
> xf86MapDomainMem():  mmap() failure
>=20
> This is much better then before but still not perfect :-(
>=20
> 	Dan
>=20


--=-nNnmTwvInLQBDYGVN8fm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiOJLMACgkQknxn9PmJ76Ux5ACfbldUtlWaRS2lGyAMyg8/IyFF
YSEAn2/lrn8TgskuXCXPqg7+2xMaphQJ
=pN/l
-----END PGP SIGNATURE-----

--=-nNnmTwvInLQBDYGVN8fm--

