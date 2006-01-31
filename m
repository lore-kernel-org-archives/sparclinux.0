From: Ferris McCormick <fmccor@gentoo.org>
Date: Tue, 31 Jan 2006 13:31:30 +0000
Subject: Re: afbinit failure with 2.6.15 kernels (can no longer load Elite
Message-Id: <1138714290.20416.0.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-WamIuVyTyGaCJAacppdq"
List-Id: <sparclinux.vger.kernel.org>
References: <1138649666.7197.17.camel@polylepis.inforead.com>
In-Reply-To: <1138649666.7197.17.camel@polylepis.inforead.com>
To: sparclinux@vger.kernel.org


--=-WamIuVyTyGaCJAacppdq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-01-30 at 20:05 -0800, David S. Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Mon, 30 Jan 2006 19:15:36 -0800 (PST)
>=20
> > After looking at the description of the problem, I recalled that I've s=
een=20
> > something like this reported on the debian-sparc list. It turns out tha=
t=20
> > we have a bug #346085 [0] filed exactly for this issue, and Ian Viemeis=
ter=20
> > has recently submitted a patch [1] for afbinit which reportedly fixes t=
his=20
> > problem. I don't have a possibility to test it myself.
> >=20
> > [0] http://bugs.debian.org/346085
> > [1] http://bugs.debian.org/cgi-bin/bugreport.cgi/afbinit.c.diff?bug=3D3=
46085;msg=3D10;att=3D1
>=20
> That patch looks good to me.
>=20
> Ferris can you test that out and say if it works for you
> as well?  Thanks.

Yes; will do later today.

> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-WamIuVyTyGaCJAacppdq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD32ayQa6M3+I///cRAkrtAJ9q/jsZTYlGHWZsN/8iu0KizL26eACg0Ccn
fi5HD8kHTaZX4G2AbB43em4=
=+Nog
-----END PGP SIGNATURE-----

--=-WamIuVyTyGaCJAacppdq--

