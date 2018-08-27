From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 27 Aug 2018 19:15:18 +0000
Subject: Re: new SBus related DMA warnings in 4.18+git
Message-Id: <20180827191518.GA26665@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
In-Reply-To: <20180827154716.GA30492-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

Hi Christoph.

On Mon, Aug 27, 2018 at 05:47:16PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 26, 2018 at 10:48:44AM +0300, Meelis Roos wrote:
> > Tried yesterdays git 4.18.0-12789-gaa5b105 on a Sun Ultra 1 with SBus 
> > and several SBus connected devicess give DMA mapping related warnings:
> 
> This should have been around since the warning was added.
> 
> The patch below should fix it:
> 
> ---
> >From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 27 Aug 2018 17:23:24 +0200
> Subject: driver core: initialize a default DMA mask for platform device
> 
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_object so that we can initialize
> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default.  Architectures can still override this in
> arch_setup_pdev_archdata if needed.
> 
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.
I know the patch did not work out as intended - saw another thread.
But this looks like the patch just paper over the fact that
the drivers are missing to set the DMA mask.

Why not fix the drivers rather than papering over the fact
that they are missing the DMA mask?

We are in the lucky situation the Meelis can test any patches.

	Sam
