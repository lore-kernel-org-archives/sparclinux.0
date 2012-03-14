From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Mar 2012 00:58:51 +0000
Subject: Re: New build failures in sparc.
Message-Id: <20120314115851.445b68161ae51a02c1965617@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__14_Mar_2012_11_58_51_+1100_Zz6TNQghwCHMqE6z"
List-Id: <sparclinux.vger.kernel.org>
References: <CAP=VYLpfM0AFWQp7Q=xYHnCd_6vEXKKL1EL5daGcO9gsJZH=7Q@mail.gmail.com>
	<20120313.154848.265971549311147422.davem@davemloft.net>
	<20120314102830.aa7b1139bff158d30ac57505@canb.auug.org.au>
	<20120313.173741.18086192847996966.davem@davemloft.net>
In-Reply-To: <20120313.173741.18086192847996966.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-next@vger.kernel.org, tony@bakeyournoodle.com

--Signature=_Wed__14_Mar_2012_11_58_51_+1100_Zz6TNQghwCHMqE6z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 13 Mar 2012 17:37:41 -0700 (PDT) David Miller <davem@davemloft.net>=
 wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 14 Mar 2012 10:28:30 +1100
>=20
> > Yeah, we updated our sparc64 toolchain yesterday ... Tony says he
> > will try applying the patch(es) from the bugzilla.
>=20
> Meanwhile I'll add a workaround to the sparc makefiles, and
> push that to Linus.  This way it will work no matter what
> combination of tools someone has.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__14_Mar_2012_11_58_51_+1100_Zz6TNQghwCHMqE6z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPX+1LAAoJEECxmPOUX5FENAsP/ijmHCzEi3/KOeUIvrWCiFQx
+9/1aSxvJNxxtH01a3a6fJQimjGN/iOswAEsNienIwjsDhJF27do2cholASOhFnl
yGhi9DWHhuPEIgi2+/jOCpwKj3oCHx7FGoAu44dtT5hCnIdIwpc5M+T0FIPNMhPV
18/++B//YfzlHyNA4HoxBIZ5gSg8muY+qNXd5petq33vt50LR4LB+JOYMx9avA7H
DBQAKenWSC3fEvgDiTycbWzfbHDEhp+15Bfh3uH1pu+mN5jiWW4u+KlyazOGsVik
xgJZZpW+E97vU9Sp3Q38IXBZwqcgiuruB2zOBUOaTC9LuwIxcoF0cep/5BPOif4w
mvNakRvCf03SzdKgYwLQzvocP0CqXk1wWO87GNdAEOfIE2cHcBzOoxCPgATlRm+p
Z+x2LkrYIBEJj9iKP/c3mrTe/dsuwbXhjIcjGLC2p+HqWP8InJvdX2Xy1tek5ZiM
lS67Q0aNMuFE031RYNUstrSpjmxEsL8f/BbY+F0oxbsB0JezOZcsvozzHSIzZtdI
gd6Dyun3K+NDZ5zHvufek1myFBpmKuVVaPudPyG66l35sX+5UlMn6+7ZKnInJJji
AaXSSYhGP1SOEYr/ilYGlBXLlLgDk6AVnMqarMcbkotbPabseNDiT7zlgDh7X9B+
5XCtyfB4qb9ZDT5OdwWt
=h3P/
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Mar_2012_11_58_51_+1100_Zz6TNQghwCHMqE6z--
