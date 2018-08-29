From: Meelis Roos <mroos@linux.ee>
Date: Wed, 29 Aug 2018 05:47:04 +0000
Subject: Re: new SBus related DMA warnings in 4.18+git
Message-Id: <alpine.LRH.2.21.1808281649580.19903@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
	<alpine.LRH.2.21.1808272203270.28446@math.ut.ee>
	<20180828092915.GC12488@lst.de>
	<alpine.LRH.2.21.1808281330270.13945@math.ut.ee>
	<20180828114358.GA14519@lst.de>
In-Reply-To: <20180828114358.GA14519-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

> Updated version including that has survived contact with a sparc cross
> compiler below.  Note that this is on top of the previous patch adding
> a dma_mask to struct platform_device, which I've included as well.

Works completely fine on both Ultra 1 and Ultra 2 - nothing DMA-relaated 
in dmesg.

-- 
Meelis Roos (mroos@linux.ee)
