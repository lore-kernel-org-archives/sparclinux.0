From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 19:22:28 +0000
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Message-Id: <20181210192228.GB31178@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-7-hch@lst.de>
	<20181208.205806.42785512174962944.davem@davemloft.net>
	<20181210163256.GA27331@lst.de>
	<20181210.101039.1882227517259366533.davem@davemloft.net>
In-Reply-To: <20181210.101039.1882227517259366533.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Dec 10, 2018 at 10:10:39AM -0800, David Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 10 Dec 2018 17:32:56 +0100
> 
> > Dave, can you pick the series up through the sparc tree?  I could also
> > merge it through the dma-mapping tree, but given that there is no
> > dependency on it the sparc tree seem like the better fit.
> 
> I thought that some of this is a prerequisite for the DMA mapping
> work and overall consolidation you are doing.  So I kinda assumed
> you wanted to merge it via your tree.
> 
> I anticipate no conflicts at all, even until the next merge window,
> so it could very easily go through your tree.
> 
> Let me know if you still want me to merge this.

These patches are purely cleanups I found while auditing the DMA
mapping code, at least as of now there are no dependencies.

That being said now that I looked into it a bit more they do however
depend on the ->mapping_error removal, so I'll take them through
the dma-mapping tree.
