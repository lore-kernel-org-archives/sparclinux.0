From: David Miller <davem@davemloft.net>
Date: Wed, 23 Jan 2008 06:23:20 +0000
Subject: Re: [Bug 9106] Sun Fire v100 dmfe driver bug
Message-Id: <20080122.222320.128159352.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080121.232756.107909847.davem@davemloft.net>
In-Reply-To: <20080121.232756.107909847.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Grant Grundler <grundler@parisc-linux.org>
Date: Tue, 22 Jan 2008 23:19:50 -0700

> On Mon, Jan 21, 2008 at 11:27:56PM -0800, David Miller wrote:
> > BTW, I noticed this while reading the DMFE code:
> > 
> > 	db->buf_pool_ptr = pci_alloc_consistent(pdev, TX_BUF_ALLOC *
> > 			TX_DESC_CNT + 4, &db->buf_pool_dma_ptr);
> > 
> > That size looks strange, is this supposed to be:
> > 
> > 	(TX_BUF_ALLOC * TX_DESC_CNT) + 4
> > 
> > or:
> > 
> > 	TX_BUF_ALLOC * (TX_DESC_CNT + 4)
> > 
> > I think the latter is the intention, but the former is what
> > is actually happening.
> 
> Note the same thing is happening in the pci_free_consistent call.
> 
> After looking the code a bit, my guess would be the former was intended.
> I suspect this driver once suffered from alignment issues:
>         /* pointer for memory physical address */
>         dma_addr_t buf_pool_dma_ptr;    /* Tx buffer pool memory */
>         dma_addr_t buf_pool_dma_start;  /* Tx buffer pool align dword */
> ...
> 
> and I'm going a bit out on a limb here by guessing this line:
> 	db->buf_pool_dma_start = db->buf_pool_dma_ptr;
> 
> might used to read something like:
> 	db->buf_pool_dma_start = db->buf_pool_dma_ptr & ~3ULL;
> 
> or two lines:
>         db->buf_pool_dma_start = db->buf_pool_dma_ptr;
>         db->buf_pool_dma_ptr &= ~3ULL;
> 
> to guarantee the DMA pool had a 4-byte alignment. So I think the +4 can
> just be dropped.

Great, since we are guarenteed at least PAGE_SIZE alignment
from these allocations.

> Maybe time to orphan the driver or find a new maintainer?

It's a simple enough driver that if I had some cards
I would be willing to keep an eye on it.

> > Anyways, here is a fix for the above regression, if that DMA
> > sizing error above is a real one that will need a fix too:
> > 
> > [TULIP] DMFE: Fix SROM parsing regression.
> > 
> > Changeset 16b110c3fd760620b4a787db6ed512fe531ab1b5 (dmfe warning fix)
> > bothed up the offsets read from the SROM so that it doesn't read the
> > same datums it used to.
> 
> In case it matters, looks good to me.

Thanks for reviewing.
