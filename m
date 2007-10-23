From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 23 Oct 2007 07:36:56 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <1193125016.20274.4.camel@concordia>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-jMD8ooY2FKH7tQqUlrGk"
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017230449.GZ4891@austin.ibm.com>
	<1192670843.6681.10.camel@concordia>
	<20071018190939.GE29903@austin.ibm.com>
In-Reply-To: <20071018190939.GE29903@austin.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


--=-jMD8ooY2FKH7tQqUlrGk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Thu, 2007-10-18 at 14:09 -0500, Linas Vepstas wrote:
> On Thu, Oct 18, 2007 at 11:27:23AM +1000, Michael Ellerman wrote:
> >=20
> > It does what pci_device_to_OF_node() does, but in the right way.=20
> >=20
> > The plan is to remove pci_device_to_OF_node() once all the callers have
> > been converted to properly handle the refcounting.=20
>=20
> Oh. Yes. well, of course, then. Excellent reason. I didn't get=20
> that from the patch commit comments. So, FWIW:
>=20
> Ack'ed-by: Linas Vepstas <linas@austin.ibm.com>

Thanks for the ACK. But on further consideration I'm going to NACK my
own patch :)

The reasoning being that a lot of the code that uses
pci_device_to_OF_node() only uses the device_node while it also holds a
reference to the pci_dev - so there's no possibility of the device_node
going away.

So Ben suggested what we really want is two routines,
of_get_pci_dev_node() and of_peek_pci_dev_node() - the former returning
a refcounted copy and the latter allowing you to "peek" at the
device_node as long as you own the pci_dev.

I'm not sure it's worth the churn really, so we should probably just
document that pci_device_to_OF_node() is contrary, and any users that
need a reference can take one explicitly.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-jMD8ooY2FKH7tQqUlrGk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHaSYdSjSd0sB4dIRAi2WAKC54SyB49fnAuKlyDGwCGT6UzuXfwCff2zA
MxMOfz3mdRnGgrQ2plWsNKc=
=zdIn
-----END PGP SIGNATURE-----

--=-jMD8ooY2FKH7tQqUlrGk--

