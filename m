From: Christoph Hellwig <hch@lst.de>
Date: Wed, 22 Aug 2018 05:36:13 +0000
Subject: Re: [PATCH v3] sparc: use generic dma_noncoherent_ops
Message-Id: <20180822053613.GA17836@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180731080204.22753-1-hch@lst.de> <20180803074840.GA2763@lst.de>
	<20180821.123800.1007897552850427796.davem@davemloft.net>
In-Reply-To: <20180821.123800.1007897552850427796.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org

On Tue, Aug 21, 2018 at 12:38:00PM -0700, David Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 3 Aug 2018 09:48:40 +0200
> 
> > any chance you would consider reviewing and applying this patch,
> > which already has an ACK from Sam?  It would really help me with
> > some core DMA API projects planned for the next merge window.
> 
> Applied, thanks Chrisoph.

I have some work building on top of this for 4.20, so this will now
cause some hopefully not too major conflicts.  I fear you have already
pushed out your tree, but otherwise it would be better do merge it
through the dma-mapping tree.
