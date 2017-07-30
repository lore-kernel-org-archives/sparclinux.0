From: Boqun Feng <boqun.feng@gmail.com>
Date: Sun, 30 Jul 2017 13:37:47 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170730133747.anusyacw2l5hhjgx@tardis>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fq4swd667bw3cpsc"
List-Id: <sparclinux.vger.kernel.org>
References: <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
 <20170728184129.GA24364@linux.vnet.ibm.com>
 <20170728190956.GA26640@linux.vnet.ibm.com>
In-Reply-To: <20170728190956.GA26640@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org


--fq4swd667bw3cpsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 12:09:56PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2017 at 11:41:29AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:
>=20
> [ . . . ]
>=20
> > > Even though Jonathan's testing indicates that it didn't fix this
> > > particular problem:
> > >=20
> > > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >=20
> > And while we are at it:
> >=20
> > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
> Not because it it fixed the TREE01 issue -- it did not.  But as near
> as I can see, it didn't cause any additional issues.
>=20

Understood.

Still work on waketorture for a test case which could trigger this
problem in a real world. My old plan is to send this out when I could
use waketorture to show this patch actually resolves some potential
bugs, but just put it ahead here in case it may help.

Will send it out with your Tested-by and Acked-by and continue to work
on waketorture.

Regards,
Boqun

> 							Thanx, Paul
>=20

--fq4swd667bw3cpsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAll94SgACgkQSXnow7UH
+riHPQf/W+gBEetAavrwz1vbSt41MgW/TK1U22OWiL0qFGtzEy7nm6i0Bm2229So
8uMKweTt869MrEFBXrdHwZkUa1ngWuMnKNUz98z4zunFS4a9JJXc6pLsXW+X0kj/
ruup16kWt+YuKU3Ritc0BfuFQBfhDZdhxujU3whRdPalxa2f6FyhiewfNU1FVGMM
Ltj4IUuZd3YiE/1jmkkEdWseygRPO2DWpty8b60blWodCfhoA2SvY3HQ/sAYxa06
fHsYMACnvTzGqEvtGpLp63FeUZfPmcV6AZ4nVsnmcc6Jp9CA/WQPGlcieI9djGlo
gszTV6Kx1NUfOrueiaWcV5Us4UXtMw==
=Klcn
-----END PGP SIGNATURE-----

--fq4swd667bw3cpsc--
