From: Ferris McCormick <fmccor@gentoo.org>
Date: Wed, 21 Mar 2007 11:38:48 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <1174477128.7499.77.camel@liasis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-O/c7gcJZNztJunuGhyay"
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
To: sparclinux@vger.kernel.org


--=-O/c7gcJZNztJunuGhyay
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 10:53 +0100, bertrand wrote:
> Ferris McCormick a =C3=A9crit :
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >=20

--- snip ---

> >>
> >> 	JKB
> >=20
> > This is a problem with U2+kernel-2.6.x generally.  Unfortunately, I
> > have no suggestions nor do I have a solution. I just grit my teeth and
> > stay with the kernel-2.4.x series, which are completely stable on U2,
> > so far as I can tell.
>=20
> 	What is your U2 configuration ? I have only one U2 and I cannot test on=20
> this station because it's a mail server :-( In fact, I think it should=20
> be interesting to know if this trouble come from SMP, ESP or Sbus=20
> support. It is impossible to build a kernel with debug information (it=20
> does not boot due to a address not aligned...), but I have tested the=20
> same kernel on a U1E (with the same ESP chip and two additional=20
> HappyMeal Ethernet cards on Sbus slots). It perfectly works. Can you try=20
> a 2.6 on U2 without SMP support ?
>=20
> 	Regards,
>=20
> 	JKB

I have 2 U2's; U2(2x300), U2(2x400).  The SMP doesn't matter, though; U2
with 2.6.x will freeze eventually even if a uniprocessor.  SMP just lets
it fail more quickly.  Problem is believed to be SCSI or Sbus, I think,
but I don't know that anyone is sure.  The kernel people have known
about this for well over a year, but no fix.

For more current information, you might ask squash@gentoo.org or
weeve@gentoo.org --- I haven't tried 2.6 on U2 for a while because no
one has claimed to have a fix for this problem.  (Gentoo spent a lot of
time on this freeze a few months ago, but no satisfaction.  I am sure,
though, that we ruled out SMP as the problem.)

> -
Regards,

--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Devrel, Sparc)


--=-O/c7gcJZNztJunuGhyay
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGARlIQa6M3+I///cRAnVQAJ4rcqwl/39CeA2X4a+ufOXj8DnJrQCdFyeA
yYHrnkoJ4kjcIn5u89jIRaM=
=VyHb
-----END PGP SIGNATURE-----

--=-O/c7gcJZNztJunuGhyay--

