From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 18 Oct 2007 01:27:23 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <1192670843.6681.10.camel@concordia>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-6AftRWopW2GkOeR1ArBI"
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017230449.GZ4891@austin.ibm.com>
In-Reply-To: <20071017230449.GZ4891@austin.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org


--=-6AftRWopW2GkOeR1ArBI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-17 at 18:04 -0500, Linas Vepstas wrote:
> On Wed, Oct 17, 2007 at 05:12:27PM +1000, Michael Ellerman wrote:
>=20
> > +struct device_node *of_get_pci_dev_node(struct pci_dev *pdev)
> > +{
> > +       return of_node_get(pci_device_to_OF_node(pdev));
> > +}
>=20
> [...]
>=20
> > -	dn =3D of_node_get(pci_device_to_OF_node(dev));
> > +	dn =3D of_get_pci_dev_node(dev);
>=20
> Is this really useful or wise?

Yes, and yes.

> As a matter of personal taste, I find stuff like this clutters
> and confuses my mind. I go to read new code, and I run across some
> routine I haven't heard of before ... e.g. of_get_pci_dev_node(),
> so now I have to look it up to see what it does.  A few minutes later,=20
> I realize that its just a pair of old freinds (of_node_get and=20
> pci_device_to_OF_node) and so now I have to make mental room for it. =20
>=20
> Tommorrow, or 3 days later, I'm again looking at of_get_pci_dev_node()
> and I'm thinking "gee what did that thing do again??"

It does what pci_device_to_OF_node() does, but in the right way.=20

The plan is to remove pci_device_to_OF_node() once all the callers have
been converted to properly handle the refcounting. When that happens you
can use the mental room it consumed for something else :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6AftRWopW2GkOeR1ArBI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFrZ7dSjSd0sB4dIRApXVAKCtejhHEA4X51bMr+PVDDGA3mz1iACeIM7M
MAhMDy8V7ykCqMEhvlfA9SU=
=bTbR
-----END PGP SIGNATURE-----

--=-6AftRWopW2GkOeR1ArBI--

