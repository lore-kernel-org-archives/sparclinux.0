From: Dennis Gilmore <dennis@ausil.us>
Date: Sat, 26 Feb 2011 02:48:33 +0000
Subject: Re: [PATCH] Don't build any of the sparc arch bits with -Werror
Message-Id: <201102252048.38914.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2106633.ET1WnqrJWd"
List-Id: <sparclinux.vger.kernel.org>
References: <1298678235-29164-1-git-send-email-dennis@ausil.us>
In-Reply-To: <1298678235-29164-1-git-send-email-dennis@ausil.us>
To: sparclinux@vger.kernel.org

--nextPart2106633.ET1WnqrJWd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday, February 25, 2011 08:17:51 PM Dennis Gilmore wrote:
> On Friday, February 25, 2011 08:10:01 PM David Miller wrote:
> > From: Dennis Gilmore <dennis@ausil.us>
> > Date: Fri, 25 Feb 2011 18:06:00 -0600
> >=20
> > > This is due to gcc-4.6 it throws warnings for defined but unused
> > > variables. without this we cant build the kernel at all.  i have buil
> > > tested but not tried to run yet
> >=20
> > Then fix the warnings since they are likely legitimate.
> >=20
> > We've had -Werror there for _years_, don't just knee jerk remove
> > it because some new compiler notices new problems.
> > --
> > To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>  a build with this patch results in the following

a shorter followup

grep Wunused-but-set-variable build.log |wc -l
1257

in pretty much every section of the kernel.  so yes while it will need fixi=
ng=20
its not something i have the time to do right now.

Perhaps i should just carry the patch in the fedora kernel until we can ful=
ly=20
resolve the issues.  x86_64 and i686 dont use -Werror so i doubt ill get mu=
ch=20
help there.

dennis

--nextPart2106633.ET1WnqrJWd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk1oagYACgkQkSxm47BaWfenoQCeLmK6nfBwwXw2k49OoJtW4vMA
7sYAnRj/+iSa0a5u0ys29zRw4k010cQ7
=JuAx
-----END PGP SIGNATURE-----

--nextPart2106633.ET1WnqrJWd--
