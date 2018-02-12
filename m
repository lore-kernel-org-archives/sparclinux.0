From: James Hogan <jhogan@kernel.org>
Date: Mon, 12 Feb 2018 12:54:22 +0000
Subject: Re: Build regressions/improvements in v4.16-rc1
Message-Id: <20180212125421.GA4290@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
List-Id: <sparclinux.vger.kernel.org>
References: <1518430656-21669-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdW5qRH93CMyRL-gbWgiA_rnizErbjNtSMT5b3d58N3ZTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW5qRH93CMyRL-gbWgiA_rnizErbjNtSMT5b3d58N3ZTQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Michael Bringmann <mwb@linux.vnet.ibm.com>, Rob Gardner <rob.gardner@oracle.com>, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 11:28:32AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2018 at 11:17 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.16-rc1[1] compared to v4.15[2].
> >
> > Summarized:
> >   - build errors: +13/-5
> >   - build warnings: +1653/-1537
> >
> > Note that there may be false regressions, as some logs are incomplete.
> > Still, they're build errors/warnings.
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/head/7928b2cbe55b2a410a0f5c1f15=
4610059c57b1b2/ (all 273 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/d8a5b80568a9cb66810e75b182=
018e9edb68e8ff/ (271 out of 273 configs)
> >
> >
> > *** ERRORS ***
=2E..
> >   + /home/kisskb/slave/src/drivers/net/ethernet/intel/i40e/i40e_ethtool=
=2Ec: error: implicit declaration of function 'cmpxchg64' [-Werror=3Dimplic=
it-function-declaration]:  =3D> 4443:6, 4443:2
>=20
> mips{,el}-allmodconfig

FYI I reported this here:
https://lkml.kernel.org/r/20180207150907.GB5092@saruman

but I haven't seen any action on it yet.

Cheers
James

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqBjncACgkQbAtpk944
dnrzRA/8C7zFp+hDGfaEMTJvchN1s/KPNhINmM6xqiQkuWMAkYrRx/kGiscsIdtc
8CGG+u0oFl+yuTI/MY/FQi5MZQ78M2WyXMPTJsvaAHjvtFG3DYGFeDVXRVfGrB6Q
UvcoERC20bv9ihLy9tI9tR3Mf5OvTsUvjOvN9Cp2tPiOlfTjqWSuqm9UDU9fQ3Y+
rUkIoUOWOBZKNNdnmYopFEXyH831NM2VzZrLVYT+rkskOptk40chwbMuRt4dN8Rw
lvYzl+b1Guj6F4tY/fbGQ/VRXOLz1/hWI4mCg/0RIZwBQHuel1sTi2Mjp/PoQsBD
H7pAQVAkVVR+uu2K0B9dIxj1Dvp98RA3BEU4OHDIYs540BDpI4vd8h29urXhjMNq
g6BiathgvxPH+fhK8VLDtUwa6CN+tf9h19NHgTFakyj5VJuSl86bcciueq4L7dYv
fBzxlCfZqfMT6qwV0ifqG8Z+fP6T8+cXBV2bzNnHq0fXLVGvsch0pA/AcoL0PgvD
MuNpC3fuaZLs9L1z2PM7dSuqU5nUoQBVzUDRNCkMUqGS8tlMgI1Au73zR2SQnvFR
GsALvr8+eF/EHr1Ona6l9gpn1IDZOnVYi6eUu3kXpRv/+sel19+avnxC9JCMRm6q
MOvtWqDkU1IY1XnLAAN/8q96FKYTn+ZzfeQu5i/D8r73SjGp1Vo=
=8KE3
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
