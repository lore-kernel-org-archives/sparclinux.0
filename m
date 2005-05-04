From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Wed, 04 May 2005 10:53:33 +0000
Subject: Re: [PATCH] 2.6.x SMP UltraSPARC instability
Message-Id: <1115204014.32454.75.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-2iJ76gkhxAnbrb5PugwB"
List-Id: <sparclinux.vger.kernel.org>
References: <20050503170509.5fa93b26.davem@davemloft.net>
In-Reply-To: <20050503170509.5fa93b26.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--=-2iJ76gkhxAnbrb5PugwB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-03 at 21:18 -0700, Jeremy Huddleston wrote:
> On Tue, 2005-05-03 at 17:05 -0700, David S. Miller wrote:
> > Can folks seeing problems on SMP sparc64 boxes with 2.6.x
> > give this patch a try?
>=20
> Both cases compiled with gcc-3_3-branch dated 20040623 (post 3.3.4)
>=20
> 2.6.11 without patch:
> crashes after about 2 minutes of uptime
>=20
> 2.6.12-rc3 with patch:
> so far it's been up for about 10 minutes with no problems so far... I'm
> going to leave it doing some high load tasks while I head out to go see
> a movie... hopefully it'll still be up when I get back.
>=20
> --Jeremy
>=20
> system is an ultra2

Looking good still after almost 7 hours...  also looks like I'm not
affected by the SCSI bugs others have hit as I've been doing a ton of
disk i/o with no problems... =3D)

$ uname -a                                                            =20
Linux yuffie 2.6.12-rc3-gentoo #1 SMP Tue May 3 20:21:05 PDT 2005
sparc64 sun4u=20
TI UltraSparc II  (BlackBird)
GNU/Linux                                        =20
                                                                           =
    =20
$ uptime                                                              =20
 03:51:23 up  6:43,  2 users,  load average: 3.00, 3.00,
2.75                  =20


--=-2iJ76gkhxAnbrb5PugwB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCeKmtOpjtAl+gMRURAgunAKDOyxjb/8rQn2Z6tzexMaMY13qyoACgtFQ0
ubSB7rlXx4u9NZhEMWzPyOE=
=nkvT
-----END PGP SIGNATURE-----

--=-2iJ76gkhxAnbrb5PugwB--

