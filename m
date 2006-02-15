From: Ferris McCormick <fmccor@gentoo.org>
Date: Wed, 15 Feb 2006 14:01:34 +0000
Subject: Re: [gentoo-sparc] kernel-2.6.15-r4 (in)stability on U2-SMP, etc.
Message-Id: <1140012094.4844.49.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-SyvplN8CxClruSDtaaI1"
List-Id: <sparclinux.vger.kernel.org>
References: <1140008955.4844.42.camel@polylepis.inforead.com>
In-Reply-To: <1140008955.4844.42.camel@polylepis.inforead.com>
To: sparclinux@vger.kernel.org


--=-SyvplN8CxClruSDtaaI1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-15 at 08:28 -0500, Jameel Akari wrote:
> On Wed, 15 Feb 2006, Ferris McCormick wrote:
>=20
> > However, U2-SMP(2x450) is not.  As is the case with ALL 2.6.xx kernels,
> > 2.6.15-r4 cannot handle the sort of disk activity which portage require=
s
>=20
> Just as a data point, you do realize that the 450MHz CPU was never=20
> actually supported in the Ultra-2?  While it may boot, it wasn't made to=20
> work together nor was it sold as an upgrade. You may be tripping on some=20
> marginal timing issue.
>=20
> If you have 400MHz/2MB CPUs sitting around it may be worth testing with=20
> them to isolate that as a cause.
>=20

As is too often the case, I mistyped.  The stable system is U60(2x450);
the unstable system is U2(2x400).  Thanks for catching this.

>=20
> --=20
> #!/jameel/akari
> sleep 4800;
> make clean && make breakfast
Regards,
Ferris (who sometimes expects way too much ESP support from his readers)
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-SyvplN8CxClruSDtaaI1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD8zQ+Qa6M3+I///cRAq9JAJ4ytQCEZnzYSCKWQMc80Zeff7caEACgsIEL
0vYZjfgHiHfuB3U/jPm2dT0=
=+sCm
-----END PGP SIGNATURE-----

--=-SyvplN8CxClruSDtaaI1--

