From: David Miller <davem@davemloft.net>
Date: Mon, 16 Nov 2009 11:04:35 +0000
Subject: Re: [experimental patch] sungem: force serdes dection on buildin
Message-Id: <20091116.030435.113518480.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 13 Nov 2009 13:43:50 +0100

> On a SunFire 880 the internal fibre gigabit interface (gem chip,
> an Agilent HDMP-1636A serdes on board) needs to be detected as
> a serdes and not as a seriallink.
> 
> The appended experimental patch changes this during detection and
> make the interface working (on top of the patches developed with davem for
> the Sun PCI gigabit fibre interface card).
> 
> Please comment and tell if there is a PCI sungem with seriallink and an
> ID of PCI_DEVICE_ID_SUN_GEM(2bad) out there.

Thanks a lot for this patch, I'll take a close look at it soon.
