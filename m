From: joshk@triplehelix.org (Joshua Kwan)
Date: Wed, 07 Apr 2004 20:23:46 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <20040407202346.GG12701@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Wb5NtZlyOqqy58h0"
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
To: sparclinux@vger.kernel.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2004 at 03:17:59PM -0400, Ben Collins wrote:
> > You should really be using the Sarge tftboot images.
> > http://people.debian.org/~jbailey/d-i/sparc/daily/sparc64/netboot/boot.=
img
>=20
> No, he shouldn't those images aren't tested very well. My woody images
> are.

You seem to have missed the numerous successful (or mostly so) installation
reports on both sparc and sparc64 and my hijack (to Debian Install System
Team) of your mostly broken silo-installer package and serial console fixes,
all of which contributed to successes with the new Debian installer.

In short, thanks for undermining our past few months' work.

> > Pass devfs=3Dmount on the command line and it should Just Work.
> > Note that this crude hack isn't required in the latest images.
>=20
> That shouldn't matter with the image he is using.

I thought that the images were d-i/sarge based. This was a dominant
problem until fairly recently (where the hack was to pass devfs=3Dmount on
the command line.)

I basically know nothing about boot-floppies on !i386, so I'd not have
spoken up if I had known.

--=20
Joshua Kwan

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQHRjUaOILr94RG8mAQJV9RAAl8PbMgQcAF3LTdMuaOvdnE6Gjiq77Lwx
6ZshXmuPeVj4Gghyjl1AWZYFL/NNZc0RTa+DRT7c2LcfEGe9phor/LvksrtK/Pit
DAhY83PxdaIQ3zyNtFiGq6Jab7yLqkMIT8Z3/fClM+nxbkbyYEpwKDMPp2yx9kWr
14zbGSk6Gf4UlhQHm2BdVWhHc4CJpXEQGcMDbSXCuocnBum+bot2fUunVtSjoL2S
CBcYGhf7ATa2+eqOvtaJ/gHfukD1vaYsLwGA0+DGMptr+UfTNh3u0/GRvBlctOmM
wU+Df796d5lp13402Mk+D0LEgbOewvisxTcgLcaIXic36DtVELdj24T2lGvACtsn
Jlh3SUsPGxRrVB5/tJpPcF1LAEG64VCInZrX7KBqLWljFkgAh2HTEmFx/XIBDylU
NIeFrEfxay8TKmWvxuO/YrEc1oItnWyJJzv74PRMy4gnNHNJjHtfhrLFaA4diiET
AWhPjfIZzv5uur4LjoPjElWVNjtOhADLJH1wWKLP4g5OeccB8HSI7aup3CBlc4zy
XhRIlvkGCHinvexejra79w9fmcqSOnK2qEgDuN5IGJqYzUOXRmAvbJELaSTskcBR
L9bkA3aysyzddITYgZYJj+YkQjUqg0PYDvZwToLCiV9X5B1e+KIMrKllPR9NEiol
e4kf2Sns2Hw=
=f4LU
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
