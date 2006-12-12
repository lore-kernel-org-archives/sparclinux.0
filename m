From: "Jan Andersson" <d02jan@dtek.chalmers.se>
Date: Tue, 12 Dec 2006 21:39:35 +0000
Subject: Why is sg->offset not added in pci_map_sg()?
Message-Id: <53ad742a0612121339x41997c23hd34e18ac0ceb3b19@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

in arch/sparc/kernel/ioport.c pci_map_sg() iterates over the
scatterlist and assigns:
sg->dvma_address = virt_to_phys(page_address(sg->page)).

If CONFIG_PCI is set dma_map_sg is just a wrapper around pci_map_sg()
as defined in include/asm-generic/dma-mapping.h. But I believe that
this makes the behaviour of dma_map_sg() different on sparc compared
to i386; In dma_map_sg() on i386 sg->offset is also added to
dvma_address.

I ran in to this while I was making the DMA API available to non-PCI
systems on SPARC. I created the dma_* functions by just copying the
pci_-equivalent and changing the BUG_ON(direction =..) check. But
since pci_map_sg() does not include the addition of sg->offset,
transfers to buffers which do not begin on a page boundary will not
work as expected. In my case this broke the scatterlist mappings in
usbcore.

Now I am curious as to why sg->offset isn't added to sg->dvma_address
in pci_map_sg(). Have I overlooked something or should the offset be
added?

I am not very familiar with the DMA mapping system, and quite new to
kernel programming - so please be gentle :-)

Best regards,
  Jan
