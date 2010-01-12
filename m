From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 12 Jan 2010 10:35:59 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area
Message-Id: <4B4C508F.1090609@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

David Miller wrote:
> 
> Looking at this code, I can't see how virt_to_page() works right
> now at all :-)
> 
> mem_map[] is offset by pfn_base
> 
> This is why __va() and __pa() account for it.
> 
> Can you see if your machine boots with the patch at the end of this
> email applied?  Others can feel free to test this too :-)
> 
> Really, if pfn_base/phys_base are non-zero, it's quite amazing how a
> sparc32 machine could sucessfully boot with the code as-is.
> 
> Looking more deeply, I guess it could work if you use CONFIG_SLUB.
> 
> Or, you use CONFIG_SLAB and SLABs are never destroyed and SLAB
> growing never fails (kmem_freepages() uses virt_to_page()).
> 

I was using CONFIG_SLAB without noticing any problems.

But I'm a bit confused. Doesn't this patch generate the exact same code?
Now __pa will add in phys_base but pfn_to_page(__pa()>>PAGE_SHIFT)
will remove it by subtracting ARCH_PFN_OFFSET.


> And I'm guessing that's why using virt_to_page() in the DMA mapping
> implementation failed for you Kristoffer, it would be the only common
> path it would be used on sparc32.
> 

For me it still fails if I'm not adding phys_base in page_to_phys.


Thanks,
Kristoffer
