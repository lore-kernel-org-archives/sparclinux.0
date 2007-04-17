From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2007 19:02:56 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070417.120256.71554585.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 17 Apr 2007 17:28:24 +0200

> 	Some news about this new driver on sparc32.
> Test configuration : SS20 with dual SM71, 448 MB, VSIMM, internal raid1, =

>   ESP100A and HME-ESP (UW). All esp patches are applied against=20
> 2.6.21-rc7 (thus with new IOMMU Sbus support).

THe IOMMU sbus support patch only effects sparc32, so applying
that patch for sparc32 testing will have no effect.

> 	The obtained kernel can boot with init=3D/bin/bash, but is unable to boo=
t=20
> with init=3D2. All ESP interfaces are shown and initialized, all disks=20
> (two internal ID1 and 3 and CDROM ID6). When kernel starts init, I can=20
> see on console :
>=20
> 	esp: esp0: reconnect, tag type changed 22 --> 00
>=20
> followed by a lot of insaned messages :-(

Nevertheless I'll try to look into this.

Does the existing ESP driver work fine on this machine?
If not, I'm not going to look into this bug as it's obviously
a sparc32 platform specific issue and I have no means to debug
or fix those kinds of problems these days.
