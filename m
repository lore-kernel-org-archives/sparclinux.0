From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 18 Jan 2011 09:15:38 +0000
Subject: Re: [PATCH 2/4 V2] sparc: Add pci32_unmap_page.
Message-Id: <4D355A3A.5030003@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1294909535-6290-3-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1294909535-6290-3-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam,

Sorry for my sluggish replies.

Sam Ravnborg wrote:
> On Thu, Jan 13, 2011 at 10:05:33AM +0100, Kristoffer Glembo wrote:
>> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
> 
> I totally miss _why_ you add this function.
> Just a small comment in the changelog would help.
> It may due to my ignorance of all the dma stuff...
> 


It is part of the DMA API and needed by our ethernet driver. I guess no PCI driver (on sparc) used it before.


> 
> How about a patch that fix it so mmu_inval_dma_area() takes a void *
> as first argument?
> In most cases I see a cast from void * => unsigned long where we call
> mmu_inval_dma_area().
> 


Ok.


/Kristoffer
