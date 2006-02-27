From: Jason Wever <weeve@gentoo.org>
Date: Mon, 27 Feb 2006 00:56:29 +0000
Subject: Re: U1/U2 failures with kernel 2.6.<anything> --- maybe a clue?
Message-Id: <20060226175629.0c931497@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_9131PfylRDemYRXmg3a.yYw"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0602260312230.17700@terciopelo.krait.us>
In-Reply-To: <Pine.LNX.4.64.0602260312230.17700@terciopelo.krait.us>
To: sparclinux@vger.kernel.org

--Sig_9131PfylRDemYRXmg3a.yYw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Feb 2006 03:14:58 +0000 (UTC)
Ferris McCormick <fmccor@gentoo.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> OK, I've been thinking about this, and here is what we have.
> (1) Some U1/U2 systems do very well on these kernels;
> (2) Some are unusable:  I have one which on 2.6.xx, has mean time
> between (very hard lock) failure of about a day, on kernel-2.4.32,
> it's never (literally).
> (3) Weeve and (I believe) squash are as in point 2.

Yes, I have an Ultra 2 (2x300, 2GB RAM) and an Ultra 1 (143MHz, 448MB
RAM) that can readily be locked up with what appears to be the I/O
issue.  In both cases, neither running the systems with a serial
console or graphical console reveals anything when they lock up
(even with the syslog daemon turned off).

For both systems, I've tried kernels built with gcc-3.4.5 and gcc-3.3.6
and the only possible difference is that it *seems* to take longer to
crash on the gcc-3.4.5 built kernels (but let me generate some data to
back that up).

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_9131PfylRDemYRXmg3a.yYw
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAk49dKvgdVioq28RAmIfAJkBgT8ffzHSlJTxTnmCn/rhtCo7egCcCPhr
ZQIXe22dZtXHMa91GuOPdfA=
=V9HD
-----END PGP SIGNATURE-----

--Sig_9131PfylRDemYRXmg3a.yYw--
