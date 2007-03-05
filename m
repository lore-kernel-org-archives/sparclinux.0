From: David Miller <davem@davemloft.net>
Date: Mon, 05 Mar 2007 02:29:35 +0000
Subject: Re: [6/6] 2.6.21-rc2: known regressions
Message-Id: <20070304.182935.74729828.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305015045.GK3441@stusta.de>
	<20070304.180725.126592830.davem@davemloft.net>
	<20070305022602.GL3441@stusta.de>
In-Reply-To: <20070305022602.GL3441@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: bunk@stusta.de
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, vonbrand@inf.utfsm.cl, davem@sunset.davemloft.net, sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 5 Mar 2007 03:26:02 +0100

> On Sun, Mar 04, 2007 at 06:07:25PM -0800, David Miller wrote:
> > From: Adrian Bunk <bunk@stusta.de>
> > Date: Mon, 5 Mar 2007 02:50:45 +0100
> >=20
> > > Subject    : sparc64 compile error due to GENERIC_ISA_DMA removal
> > > References : http://bugzilla.kernel.org/show_bug.cgi?id=8097
> > > Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
> > > Caused-By  : David S. Miller <davem@sunset.davemloft.net>
> > >              commit 1b51d3a08b6c80a1e47d4c579c41abbe56cd3c44
> > > Status     : unknown
> >=20
> > Fixed in current GIT.
> >=20
> > commit 74bd7d093b8e87f35eaf3b14459b96a0e20d1d10
> > Author: David S. Miller <davem@sunset.davemloft.net>
> > Date:   Wed Feb 28 13:09:34 2007 -0800
> >=20
> >     [SPARC64]: Fix parport_pc build.
> >    =20
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> Horst's problem is with the floppy driver and=20
> claim_dma_lock/release_dma_lock in include/asm-sparc64/dma.h .

Thanks for the clarification, I was thinking of the parport
problem reported by Meelis Roos.

I'll look into this.
