From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 16 Nov 2009 09:45:40 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area.
Message-Id: <4B011F44.8030604@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

David Miller wrote:
> >> The SBUS routines look quite different though. I will use the
>> pci32_dma_ops.
> 
> I suggested the SBUS ones because they inherit the OpenFirmware
> device node name into the resource.  They have also been cleaned
> up substantially, the PCI ones are very messy still.
> 

I finally had the time to look at this again and I'm not sure
how I would do this cleanly using only the SBUS stuff. They
use the IOMMU routines (mm/iommu.c or mm/io-unit.c) and since
we don't currently have an IOMMU I don't want to mess with that.

On LEON system that are not snooping DMA accesses I want to flush
the dcache when unmapping or syncing the buffer. That's it.

I have a suggestion for a patch. It uses sbus_alloc_coherent and
sbus_free_coherent with some added ifdefs and then the PCI
routines for the rest (I've added unmap_page and patched map_page).
At least the code duplication is quite minimal ...

In the somewhat limited testing I have done it works fine.

If you explain what you think is very messy with the PCI routines
maybe I can clean them up further. On LEON we use both the generic
DMA-API and the PCI-API.

I will send the patches separately.

Best regards,
Kristoffer







