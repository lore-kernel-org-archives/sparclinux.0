From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Mar 2012 23:28:30 +0000
Subject: Re: New build failures in sparc.
Message-Id: <20120314102830.aa7b1139bff158d30ac57505@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__14_Mar_2012_10_28_30_+1100_SHxWIF7NWCiwoWQp"
List-Id: <sparclinux.vger.kernel.org>
References: <CAP=VYLpfM0AFWQp7Q=xYHnCd_6vEXKKL1EL5daGcO9gsJZH=7Q@mail.gmail.com>
	<20120313.154848.265971549311147422.davem@davemloft.net>
In-Reply-To: <20120313.154848.265971549311147422.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-next@vger.kernel.org, tony@bakeyournoodle.com

--Signature=_Wed__14_Mar_2012_10_28_30_+1100_SHxWIF7NWCiwoWQp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 13 Mar 2012 15:48:48 -0700 (PDT) David Miller <davem@davemloft.net>=
 wrote:
>
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Tue, 13 Mar 2012 18:28:18 -0400
>=20
> > Just a heads up that these turned up today in linux-next:
>=20
> You must have updated your sparc binutils recently, which is now more
> strict about making sure the proper options are passed to enable v8
> instructions.
>=20
> See also:
>=20
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D50979

Yeah, we updated our sparc64 toolchain yesterday ... Tony says he will try
applying the patch(es) from the bugzilla.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__14_Mar_2012_10_28_30_+1100_SHxWIF7NWCiwoWQp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPX9geAAoJEECxmPOUX5FEAyMP/2ORkcS8QYTSwVCMW+vcVhzJ
NJ+NxKz8wKctUxESkHUibbthEwCFEMhV6zHCs8u70PnLt2OnfROgUgrMz8b5xmCq
Lf7EUBuUFh08LK/5pzcq4KhhqA11b0gpO9z0c7izMc8ltAkA+PqcqBwPvtMTbDSa
JOuKXtUs2EWj/xPRGyZOJz2GVO8mbeV5LQf8kIAMZpPSfvvqcbJDnql8Cn4JrZGf
VXj0nFyXApFcaSW20vAPrN6BXeitm1Z/poAmGiVqUryQahC/I1nRcIZq7lN69AGX
NwsCI8wD6fvUr+OY3f8Pbduo6d+TFZOLPmKttg09kANIPDjUK2Q0X10m4q2KLJd/
LVmGmPonfDZWTsVSxGrDSKlJP88p9zg9iD6Vck9XYFnAaESu2zSpFlTV9BrrPJhF
gDISaPMYCocGwDwtTor9K14eQfaj9COg4g7WKbjfgB0h8J74qWNOebI7VlSPcKld
BWKkB2xjpeAg87vNwFqQ9HxfMRyqSFKPvjookz4H5Z1dFGqbpR5DqYbySU1twTSD
KtMOSA9pYmH7Sm/7gw/8zbvlTrF73YPn7Q5zuL7XWt69QBZ8sVT6lk5cZPjD44Th
nV9mv1+q6uoWFWJZpBtkXWJ9Iau8ibqmBBDzKP1Z50oipjuGtShfYlxfgzMCJTHp
P1UDf5a2SZUgyxs/SCnA
=vP/Z
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Mar_2012_10_28_30_+1100_SHxWIF7NWCiwoWQp--
