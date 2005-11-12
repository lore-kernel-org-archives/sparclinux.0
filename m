From: Ferris McCormick <fmccor@gentoo.org>
Date: Sat, 12 Nov 2005 18:24:54 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <1131819894.27307.16.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-h3/sIhr4ogpQyGwWumHi"
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-h3/sIhr4ogpQyGwWumHi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-11-12 at 15:22 +0000, Ferris McCormick wrote:

> On Fri, 11 Nov 2005, David S. Miller wrote:
>=20
> >  From: Ferris McCormick <fmccor@gentoo.org>
> >  Date: Fri, 11 Nov 2005 21:35:48 +0000
> >=20
> > >  I'm running it on U2(2x400) currently with 2.6.14-U2-2x400-g393b0725=
.
> > >  So far, it's doing fine, and this is on a system which has never bee=
n
> > >  stable with a 2.6 kernel.  With this kernel + IRQ patch, though, it'=
s
> > >  stayed up through a lot of stress tests which I would have expected
> > >  would have killed it.
> > >  (But uptime is only 6 hours so far).
> >
> >  It would be interesting to know if that exact kernel,
> >  but without the IRQ stacks patch, works just as well.
> >
> >  It's nice that it's stable, but we should find out exactly
> >  why :-)
> >=20
> If the system is still up Monday and if no one else has reported on the U=
2
> (and U1) stability, I'll try to make a test using Josh Grebe's (squash's)
> crashme script against that kernel with the IRQ patch removed.  I can't
> give a good estimate of when the test will be possible because Monday
> morning the U2 will be helping with a fairly lengthy upgrade unrelated to
> the kernel.
>=20
> Regards,
> Ferris

OK, I lied.  I did the tests today.  Here are the results:
1.  2.6.14-U2-2x400-g393b0725 (git kernel as identified, with IRQ stack
patch):  Still looks stable.

2.  2.6.14-U2-2x400-noIRQpatch-g393b0725 (same kernel w/o IRQ stack
patch):  very unstable (Josh's crashme script crashes it in the untar
test during first pass).

And just for fun,

3.  2.6.14.2-U2-2x400 (2.6.14.2 as available at
http://www.kernel.org/pub/linux/kernel/v2.6/) + IRQ stack patch:
extremely unstable (apparently, more unstable than -2- above).
I have no explanation; just results.  (The g393... kernel seems to be
dated November 11, and 2.14.2 also seems to be November 11: in .git/ for
g393...,
4 drwxr-xr-x  260  536  536    4096 Nov 11 05:39 objects/

I've told you more than I know, but at least a stable 2.6.14-xxx on U2
is possible.

--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-h3/sIhr4ogpQyGwWumHi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdjN2Qa6M3+I///cRAo1AAKDCu3gCo+cq7nlsCoKmwFgHONXbEwCeMnDG
QJxN39aDySK78R/ogfXFipk=
=aHfy
-----END PGP SIGNATURE-----

--=-h3/sIhr4ogpQyGwWumHi--

