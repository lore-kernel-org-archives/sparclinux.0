From: David Miller <davem@davemloft.net>
Date: Mon, 16 Nov 2009 11:03:02 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091116.030302.254129821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 16 Nov 2009 10:45:40 +0100

> I finally had the time to look at this again and I'm not sure
> how I would do this cleanly using only the SBUS stuff. They
> use the IOMMU routines (mm/iommu.c or mm/io-unit.c) and since
> we don't currently have an IOMMU I don't want to mess with that.
> 
> On LEON system that are not snooping DMA accesses I want to flush
> the dcache when unmapping or syncing the buffer. That's it.
> 
> I have a suggestion for a patch. It uses sbus_alloc_coherent and
> sbus_free_coherent with some added ifdefs and then the PCI
> routines for the rest (I've added unmap_page and patched map_page).
> At least the code duplication is quite minimal ...
> 
> In the somewhat limited testing I have done it works fine.

It looks good from a code sharing perspective, but the
virt_to_phys() change has to be undone as per feedback I
gave to the patch #2 posting.

> If you explain what you think is very messy with the PCI routines
> maybe I can clean them up further. On LEON we use both the generic
> DMA-API and the PCI-API.

Bad coding style, "#if 0" sections, it does things like:

	n = (n + PAGE_SIZE-1) & PAGE_MASK;

when a simple PAGE_ALIGN() would do, etc.

Also, tests like this:

			BUG_ON(page_address(sg_page(sg)) = NULL);

Don't make any sense, because highmem pages are legal to DMA
from/to, and such pages would return NULL here.

