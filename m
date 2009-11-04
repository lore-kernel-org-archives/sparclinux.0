From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 04 Nov 2009 15:50:36 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area.
Message-Id: <4AF1A2CC.10100@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
>
> This is a lot of code duplication for what you're trying to
> accomplish I think.

Yeah I know. The leon3_dma_ops are copied from the pci32_dma_ops.
I think only unmap_page was added basically. Why is there no 
pci32_unmap_page by the way? Maybe I can just add that and use
them as is.

My original thought was that it would be future proof to have separate
versions that might evolve. But I agree and will change it ...

> 
> And now that your drivers will use OpenFirmware driver interfaces
> that's yet another difference you no longer have to account for.
> I would suggest that you crib the SBUS routines and parameterize
> them cleanly for the small differences your LEON cases needs.
> 

The SBUS routines look quite different though. I will use the pci32_dma_ops.

I will modify all the patches according to yours and Julian's feedback
and resend them as soon as possible.

Thanks,
Kristoffer Glembo

