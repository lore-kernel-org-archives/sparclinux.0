From: David Miller <davem@davemloft.net>
Date: Wed, 02 Dec 2009 09:25:17 +0000
Subject: Re: ioport.c
Message-Id: <20091202.012517.11240899.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 27 Nov 2009 17:43:35 +0100

> I'm adding LEON support for the DMA-API into ioport.c and at the
> same time wanting to clean things up somewhat.
> 
> One thing that bugs me a little bit is this one:
> 
> #define mmu_inval_dma_area(p, l)/* Anton pulled it out for 2.4.0-xx */
> 
> It seems this was never implemented. I'm not sure which machines needs
> to invalidate the cache after DMA but LEON needs it in some
> configurations and as far as I understand the microsparc IIep needs it
> as well. I'm not so familiar with where this chip is used but the
> JavaStation (Krups) uses it and has the Sun HappyMeal ethernet card
> doing DMA from the PCI bus.
> 
> Can anyone explain why this was never implemented and instead removed?
> Is it not needed even on the IIep ?

I don't know offhand, sorry.

But I seem to remember that Microsparc-IIep is coherent all the
way to the L1 caches with DMA so it wouldn't need flushes after
DMA at all.
