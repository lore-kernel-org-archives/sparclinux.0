From: Ferris McCormick <fmccor@gentoo.org>
Date: Tue, 31 Jan 2006 14:23:12 +0000
Subject: Re: afbinit failure with 2.6.15 kernels (can no longer load Elite
Message-Id: <1138717392.8129.4.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-MokJ9fewDJvn5igzA0/e"
List-Id: <sparclinux.vger.kernel.org>
References: <1138649666.7197.17.camel@polylepis.inforead.com>
In-Reply-To: <1138649666.7197.17.camel@polylepis.inforead.com>
To: sparclinux@vger.kernel.org


--=-MokJ9fewDJvn5igzA0/e
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

Tested.
Patch (MAP_PRIVATE ---> MAP_SHARED) works for me (SB1000-SMP, Elite
3dm3) with kernels 2.6.13-r3, 2.6.15-r1.  Thanks.

GENTOO SPARC PEOPLE:  I will be making a revision bump (as ~sparc) to
afbinit to add this patch.  If you try it and experience any
difficulties, please let me know.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Ferris
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-MokJ9fewDJvn5igzA0/e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD33LPQa6M3+I///cRAp5uAJ9EQuzUPgendfei4l9x3OQbi3ASIQCg4+Tq
fod70u9P0WL5Fc70LwCvYtw=
=SedN
-----END PGP SIGNATURE-----

--=-MokJ9fewDJvn5igzA0/e--

