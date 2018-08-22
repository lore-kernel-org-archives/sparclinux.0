From: Christoph Hellwig <hch@lst.de>
Date: Wed, 22 Aug 2018 06:03:26 +0000
Subject: Re: [PATCH v3] sparc: use generic dma_noncoherent_ops
Message-Id: <20180822060326.GA18493@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180803074840.GA2763@lst.de>
	<20180821.123800.1007897552850427796.davem@davemloft.net>
	<20180822053613.GA17836@lst.de>
	<20180821.225737.2130615341518333532.davem@davemloft.net>
In-Reply-To: <20180821.225737.2130615341518333532.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org

On Tue, Aug 21, 2018 at 10:57:37PM -0700, David Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 22 Aug 2018 07:36:13 +0200
> 
> > I fear you have already pushed out your tree, but otherwise it would
> > be better do merge it through the dma-mapping tree.
> 
> I did and asked Linus to pull as well.  Sorry :-/

Oh, if you pushed that for 4.19 that is actually perfect to prepare
for my 4.20 changes.  Never mind the interruption!
