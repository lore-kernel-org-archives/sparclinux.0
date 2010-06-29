From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 08:33:40 +0000
Subject: Re: [PATCH 4/4] x86: OLPC: add OLPC device-tree support
Message-Id: <20100629183340.15e7196a.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__29_Jun_2010_18_33_40_+1000_NXMY5G/6hO6FA9aM"
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100628220058.19e8f143@debian>
	<AANLkTinUy_FGuN9DiF5KtMCsqYUbByfS6g2Mdw0ATvtQ@mail.gmail.com>
In-Reply-To: <AANLkTinUy_FGuN9DiF5KtMCsqYUbByfS6g2Mdw0ATvtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

--Signature=_Tue__29_Jun_2010_18_33_40_+1000_NXMY5G/6hO6FA9aM
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andres,

On Tue, 29 Jun 2010 01:12:36 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 71c194d..7aea004 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2071,6 +2071,11 @@ config OLPC_OPENFIRMWARE
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0that is used on the OLPC XO-1 Childre=
n's Machine.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If unsure, say N here.
> >
> > +config OF
> > + =C2=A0 =C2=A0 =C2=A0 def_bool y
> > + =C2=A0 =C2=A0 =C2=A0 depends on OLPC_OPENFIRMWARE
> > + =C2=A0 =C2=A0 =C2=A0 select OF_PROMTREE
> > +
>=20
> This hunk will need to be respun on top of Stephen's CONFIG_OF change.
>  It's currently in my test-devicetree branch on
> git://git.secretlab.ca/git/linux-2.6

Yeah, just make config OLPC_OPENFIRMWARE select OF and OF_PROMTREE and just=
 use

config OF
	bool

for now.  This will work even without my changes.  We will remove those
latter two lines later.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_Jun_2010_18_33_40_+1000_NXMY5G/6hO6FA9aM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMKa/kAAoJEDMEi1NhKgbsO5UH/j0cQXL9xd5E0HXPkfIYk66p
66fNDfs5s+0cnytCv5tu9rrDLuMaoevOPsaA/I1EcMnDiTeWMLsULNKavEs271UT
c3R/zdTeLhQn2yig4LGIhCVbx8UkxL02Qz04k8/XOt69/NBamIlruxERwpuea3jv
k9KVUCVdlkDGnImb90LUiICFerhRbPPQccFocjKbVwUcpEG0MAkMxyfwcry9/uTt
zOOFL3VVcT55j9vv5iosE/5YCG+fLtpjRUiVN7myeiORhtsnzu9h1z4J7Iw0RuZz
ltUT96xtafrWO1qh0ioKYQzKinvcQAkqw4yaAMjZR+39XNRgtAae5c0ztnPnyfU=
=OGxO
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2010_18_33_40_+1000_NXMY5G/6hO6FA9aM--
