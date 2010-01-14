From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Thu, 14 Jan 2010 11:05:34 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area
Message-Id: <4B4EFA7E.1090104@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> So I did research and this code is the way it is because
> of LEON (this commit is from "linux-2.6-history.git") :-)


Back then I was attending grad school and was blissfully unaware. :-)


> 
> So let's take baby steps, please confirm that you agree with me that
> the following patch is correct and that it works on your machine.


It works fine for me!


> If it works I want to reinstate the virt_to_page() change I posted
> the other day as well, simply so that we consistently use the
> asm-generic/memory-model.h interfaces instead of assuming FLATMEM
> memory model all over our headers.


Yes this change works as well.

> 
> But I am truly mystified how anything works with non-zero phys_base
> with this being wrong.  Fundamental operations like
> {srmmu,sun4c}_mk_pte() use this.
> 
> LEON uses this via SRMMU, so how does it work properly? :-)


Hmm, srmmu_mk_pte() uses page_to_pfn() which accounts for pfn_base?

The only use of page_to_phys below arch/sparc that I find is in pci32_map_page
which is where I got into trouble. :-)

Thanks for looking into this!

Best regards,
Kristoffer
