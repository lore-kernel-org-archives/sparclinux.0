From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Date: Tue, 26 Oct 2004 00:32:12 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041026003212.GG17506@ruslug.rutgers.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
To: sparclinux@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2004 at 03:38:45PM -0700, David S. Miller wrote:
> On Mon, 13 Sep 2004 18:21:02 -0400
> mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:
>=20
> > I also would like an explanation as
> > to this 2.6 MB kernel size limitation.
>=20
> It was a bootloader limitation which is fixed in current
> SILO bootloader versions.

OK -- I have silo 1.4.8 and I can't still boot into a 2.6 kernel. I've
tried many things:

a. boot into vmlinux (48MB)
	result: image too large
b. boot into vmlinuz (24MB)
	result: image too large
c. boot into image (5.1MB)
	result: it hangs on trying to boot 2.6.9

and no luck. What version of silo fixed this kernel size limitation?
Also any suggestions?

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBfZsMat1JN+IKUl4RAibcAKCguCjcflotjdZMUtKgjNh7OZ+5rgCgr7L3
TTRkm4xzccxMsnJpQhrFWKw=
=ozij
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
