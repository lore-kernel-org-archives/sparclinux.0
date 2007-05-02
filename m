From: David Miller <davem@davemloft.net>
Date: Wed, 02 May 2007 10:32:24 +0000
Subject: Re: ICE with GCC 4.1
Message-Id: <20070502.033224.74362160.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87odl4qt19.fsf@chbouib.org>
In-Reply-To: <87odl4qt19.fsf@chbouib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Wed, 2 May 2007 12:20:25 +0200 (MEST)

>=20
> On May 1 2007 20:48, Ludovic Court=E8s wrote:
> >
> >Hi,
> >
> >Does anyone get the following ICE when compiling the latest kernel (from
> >David Miller's Git tree) on sparc32:
>=20
> Does it always error out at the same point? You might want to use a memory
> tester.

It's more likely to be a cache or TLB coherency bug in the sparc32
kernel than a real hardware memory problem, actually.
