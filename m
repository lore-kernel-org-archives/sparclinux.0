From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 16:02:08 +0000
Subject: Re: [PATCH 03/12] Consolidate of_device_is_compatible
Message-Id: <20070720020208.89603f63.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__20_Jul_2007_02_02_08_+1000_G2H3UcHu26W3/MkK"
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011012.4eca281d.sfr@canb.auug.org.au>
	<20070719155207.GA28617@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070719155207.GA28617@ld0162-tx32.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

--Signature=_Fri__20_Jul_2007_02_02_08_+1000_G2H3UcHu26W3/MkK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Thu, 19 Jul 2007 10:52:07 -0500 Scott Wood <scottwood@freescale.com> wro=
te:
>
> On Fri, Jul 20, 2007 at 01:10:12AM +1000, Stephen Rothwell wrote:
> > The only difference here is that Sparc uses strncmp to match compatibil=
ity
> > names while PowerPC uses strncasecmp.
>=20
> Could we put a comment in saying that both should really just use
> strcmp(), and that this mechanism should go away once any compatibility
> issues are found and addressed?

That issue was discussed earlier and is high on the list of things to do
after this lot goes in.  The priority here is to get the consolidation
started along with no (or few) visible changes.

> The PowerPC one will need to drop the 'n' soon, as well, but that should
> be a separate patch.

Yes, certainly.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__20_Jul_2007_02_02_08_+1000_G2H3UcHu26W3/MkK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGn4sFTgG2atn1QN8RAj9YAJ9ckEzA/D/90PLXELt5MG3QMF1CjgCgjlSp
Z3YXoFnkTsxtJla6tyNuKRY=
=wRWa
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Jul_2007_02_02_08_+1000_G2H3UcHu26W3/MkK--
