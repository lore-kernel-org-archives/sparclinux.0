From: Christoph Hellwig <hch@lst.de>
Date: Tue, 28 Aug 2018 09:24:32 +0000
Subject: Re: new SBus related DMA warnings in 4.18+git
Message-Id: <20180828092432.GB12488@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
	<20180827191518.GA26665@ravnborg.org>
	<20180827.134136.955064444069965259.davem@davemloft.net>
In-Reply-To: <20180827.134136.955064444069965259.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mroos-Y27EyoLml9s@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

On Mon, Aug 27, 2018 at 01:41:36PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 27 Aug 2018 21:15:18 +0200
> 
> > Why not fix the drivers rather than papering over the fact
> > that they are missing the DMA mask?
> > 
> > We are in the lucky situation the Meelis can test any patches.
> 
> SBUS drivers never set the mask because they never needed to and could
> use the default, since SBUS IOMMUs were quite universal in nature.

In addition to that the historical expectation is that you can do
dma to platform_devices without setup, and for some reason sbus
devices all show up as platform_devices.

> I think it's more error prone to add the mask setting to every single
> SBUS driver than to just have the core setup the default properly.
