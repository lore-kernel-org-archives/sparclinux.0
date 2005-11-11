From: Ferris McCormick <fmccor@gentoo.org>
Date: Fri, 11 Nov 2005 21:35:48 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <1131744948.4652.6.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-vgQ8X+obi5s1Bfa9M0wj"
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-vgQ8X+obi5s1Bfa9M0wj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-11-10 at 21:02 -0800, David S. Miller wrote:
> Anyone feeling dangerous? :-)
>=20
> Today I put together a patch for IRQ stack support.
> This allows using single pages for the thread_struct
> plus kernel stack allocation.
>=20

I'm running it on U2(2x400) currently with 2.6.14-U2-2x400-g393b0725.
So far, it's doing fine, and this is on a system which has never been
stable with a 2.6 kernel.  With this kernel + IRQ patch, though, it's
stayed up through a lot of stress tests which I would have expected
would have killed it.
(But uptime is only 6 hours so far).

Regards,
Ferris
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-vgQ8X+obi5s1Bfa9M0wj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdQ60Qa6M3+I///cRAiGsAKDQVjEu8YtRzAytwI6fK/EZHx3ryQCeL1bD
1QXYFaRt/4ksSVvvnm3/Dc8=
=2jWd
-----END PGP SIGNATURE-----

--=-vgQ8X+obi5s1Bfa9M0wj--

