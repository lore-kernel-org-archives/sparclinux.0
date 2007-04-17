From: Ferris McCormick <fmccor@gentoo.org>
Date: Tue, 17 Apr 2007 18:52:07 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <1176835927.9623.49.camel@liasis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-GuQlt4ajCLKpRBObkhz9"
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
To: sparclinux@vger.kernel.org


--=-GuQlt4ajCLKpRBObkhz9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-17 at 11:45 -0700, David Miller wrote:
> From: Ferris McCormick <fmccor@gentoo.org>
> Date: Tue, 17 Apr 2007 14:05:59 +0000
>=20
> > It's impossible to tell when a bug like this is fixed, of course,
>=20
> Yes, that's why I hate these kinds of bugs.
>=20
> > but I've been running U2(2x400)+kernel-2.6.20-r5+<this patch> since 26t=
h
> > June, and I have not seen a failure.=20

I did a quick 'ls -l /boot' to get the date, and read it from the wrong
kernel. :(  Correct date is 12 April, 2007.

>  Now, I have not subjected the
> > system to any particular stress tests, but before, the daily
> > updatedb/makewhatis/update-eix cycle plus the daily (gentoo) --sync
> > operations were enough to kill this system pretty quickly.
> >=20
> > So right now, at least, I think you've probably killed the bug.
>=20
> Thanks for the report.
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Devrel, Sparc)


--=-GuQlt4ajCLKpRBObkhz9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGJRdXQa6M3+I///cRArZhAKDoFZ6BFoKJC8eJTx1WfDoVKtao/wCdF9Bv
jBNqYIYx6OwFXo/QxpGYWdQ=
=s27q
-----END PGP SIGNATURE-----

--=-GuQlt4ajCLKpRBObkhz9--

