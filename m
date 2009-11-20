From: David Miller <davem@davemloft.net>
Date: Fri, 20 Nov 2009 19:15:15 +0000
Subject: Re: [experimental patch] sungem: force serdes dection on buildin
Message-Id: <20091120.111515.51717434.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 20 Nov 2009 15:28:03 +0100

> Works on the SunFire 880 with internel fibre serdes and on a SunFire 480
> with a PCI Card with fibre serdes here.
> 
> On the PCI card interrestingly there were initially type phy_mii_mdio1 
> or phy_mii_mdio0 detected and only after failing to read the phy_mii 
> fall back to type phy_serdes. The 'shared-pins' property would be
> available for testing for a serdes on that card, too.

Yes, it seems we could sample that shared-pins property for
all PHY types, not just for handling the serdes case.

> But anyways, all interfaces are working. Thanks.

Thanks for testing.

> BTW, are there any new ideas about getting post 2.6.26 kernels booting
> on that class of sparc machines ? My last try with 2.6.31.6 still
> hangs at the usual point. Anything I could/should try ?
> 
> The offer of remote debugging on the SunFire 480 still stands,
> if you could find a few spare minutes...

Sorry for not getting to this, I'll make a special effort to
do so soon.
