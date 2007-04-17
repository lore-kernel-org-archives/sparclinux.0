From: Ferris McCormick <fmccor@gentoo.org>
Date: Tue, 17 Apr 2007 14:05:59 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <1176818759.9623.27.camel@liasis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-zpolgBWQiWyZk3RokeX0"
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
To: sparclinux@vger.kernel.org


--=-zpolgBWQiWyZk3RokeX0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-11 at 21:55 -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 10 Apr 2007 14:04:58 -0700 (PDT)
>=20
> > From: BERTRAND Jo=C3=ABl <joel.bertrand@systella.fr>
> > Date: Tue, 20 Mar 2007 21:53:26 +0100
> >=20
> > > 	I have tried the last 2.6.21-rc4. Same bug.
> >=20
> > The good news is that I can reproduce this problem now on my
> > Ultra2, I'll try to figure out what's wrong.
> >=20
> > Running "dbench 32" a few time is enough to trigger it.
>=20
> Ok, I think I might have killed at least the bug I was able to hit.
>=20
> I make no promises that this will fix the issues everyone else was
> seeing, but let's cross our fingers :-)))
>
> Please give the following patch some testing if you can.  And please
> be careful, messing with the DMA mapping code can do things like eat
> your disk :-)
>=20
> If all goes well I'll push this bug fix around, and I have a secret
> treat for your poor sparc64 SBUS users once we get past this.
>=20
> Thanks!
>=20

It's impossible to tell when a bug like this is fixed, of course,
but I've been running U2(2x400)+kernel-2.6.20-r5+<this patch> since 26th
June, and I have not seen a failure.  Now, I have not subjected the
system to any particular stress tests, but before, the daily
updatedb/makewhatis/update-eix cycle plus the daily (gentoo) --sync
operations were enough to kill this system pretty quickly.

So right now, at least, I think you've probably killed the bug.

Regards,
Ferris
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Devrel, Sparc)


--=-zpolgBWQiWyZk3RokeX0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGJNRHQa6M3+I///cRAqJqAJ9SoeU91vyaNYw7Do/GRjgW3lb2WACgqqeg
lpDSwBp/N9pVgLdXJK6BgOs=
=Gjbn
-----END PGP SIGNATURE-----

--=-zpolgBWQiWyZk3RokeX0--

