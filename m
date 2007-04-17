From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2007 19:37:40 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070417.123740.106773062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 17 Apr 2007 21:29:24 +0200

> David Miller a =E9crit :
> > From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> > Date: Tue, 17 Apr 2007 17:28:24 +0200
> >=20
> >> 	Some news about this new driver on sparc32.
> >> Test configuration : SS20 with dual SM71, 448 MB, VSIMM, internal raid=
1,=20
> >>   ESP100A and HME-ESP (UW). All esp patches are applied against=20
> >> 2.6.21-rc7 (thus with new IOMMU Sbus support).
> >=20
> > THe IOMMU sbus support patch only effects sparc32, so applying
> > that patch for sparc32 testing will have no effect.
>=20
> 	I suppose that I have to read 'only effect sparc64', isn't it ?

Right, that was a thinko :-)

> > Does the existing ESP driver work fine on this machine?
>=20
> 	The old one works fine.

Ok, thank you.
