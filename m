From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 27 Nov 2009 16:43:35 +0000
Subject: ioport.c
Message-Id: <4B1001B7.8070609@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm adding LEON support for the DMA-API into ioport.c and at the
same time wanting to clean things up somewhat.

One thing that bugs me a little bit is this one:

#define mmu_inval_dma_area(p, l)/* Anton pulled it out for 2.4.0-xx */

It seems this was never implemented. I'm not sure which machines needs
to invalidate the cache after DMA but LEON needs it in some
configurations and as far as I understand the microsparc IIep needs it
as well. I'm not so familiar with where this chip is used but the
JavaStation (Krups) uses it and has the Sun HappyMeal ethernet card
doing DMA from the PCI bus.

Can anyone explain why this was never implemented and instead removed?
Is it not needed even on the IIep ?

Best regards,
Kristoffer
