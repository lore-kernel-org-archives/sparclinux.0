From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Jul 2018 07:58:38 +0000
Subject: Re: [PATCH] sparc: use generic dma_noncoherent_ops
Message-Id: <20180730080247.GA10682@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180727164409.14873-1-hch@lst.de>
	<20180727164409.14873-2-hch@lst.de>
	<20180727210548.GA1476@ravnborg.org>
In-Reply-To: <20180727210548.GA1476-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Fri, Jul 27, 2018 at 11:05:48PM +0200, Sam Ravnborg wrote:
> Hi Christoph.
> 
> Some observations below - nitpick and bikeshedding only.
> 
> The parameter of phys_addr_t is sometimes renamed
> to use the same name as in the original prototype (good),
> and sometimes uses the old name (bad).
> This makes it inconsistent as the local name changes in the
> different functions, but they represents the same.

I'll change it.

> You can add my:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

I will resend it with your nitpicks addressed and your ack added.

> > +void *arch_dma_alloc(struct device *dev, size_t len, dma_addr_t *pba, gfp_t gfp,
> > +		unsigned long attrs)
> 
> This function was renamed in ee664a9252d24 and is now renamed again.
> The printk statements should be updated to use arch_dma_alloc.

I've switched the printk statements to use __func__ instead, not that
I plan for another rename any time soon.

I've also update the comments referring to this function to use the
right name.
