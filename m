From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 04 Apr 2015 12:46:47 +0000
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
Message-Id: <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org>
 <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com>
 <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
In-Reply-To: <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 3, 2015 at 10:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Apr 3, 2015 at 1:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Sam (commented on previous versions), Russell, linux-arm-kernel, Ralf,
>> linux-mips, Ben, linuxppc-dev, x86]
>>
>> On Fri, Apr 03, 2015 at 02:32:34PM -0500, Bjorn Helgaas wrote:
>>> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
>>> > David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
>>> > to fit in upstream windows") broke booting on sparc/T5-8.
>>> >
>>> > In the boot log, there is
>>> >   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>>> >   0x110204000)
>>> > but that only could happen when dma_addr_t is 32-bit.
>>> >
>>> > According to David Miller, all DMA occurs behind an IOMMU and these
>>> > IOMMUs only support 32-bit addressing, therefore dma_addr_t is
>>> > 32-bit on sparc64.
>>> >
>>> > Let's introduce pci_bus_addr_t instead of using dma_addr_t,
>>> > and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
>>> >
>>> > Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
>>> > Fixes: commit 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
>>> > Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
>>> > Reported-by: David Ahern <david.ahern@oracle.com>
>>> > Tested-by: David Ahern <david.ahern@oracle.com>
>>> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>> > Cc: <stable@vger.kernel.org> #3.19
>>> > ---
>>> >  drivers/pci/Kconfig |  4 ++++
>>> >  drivers/pci/bus.c   | 10 +++++-----
>>> >  drivers/pci/probe.c | 12 ++++++------
>>> >  include/linux/pci.h | 12 +++++++++---
>>> >  4 files changed, 24 insertions(+), 14 deletions(-)
>>> >
>>> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> > index 7a8f1c5..6a5a269 100644
>>> > --- a/drivers/pci/Kconfig
>>> > +++ b/drivers/pci/Kconfig
>>> > @@ -1,6 +1,10 @@
>>> >  #
>>> >  # PCI configuration
>>> >  #
>>> > +config PCI_BUS_ADDR_T_64BIT
>>> > +   def_bool y if (64BIT || X86_PAE)
>>> > +   depends on PCI
>>>
>>> We're going to use pci_bus_addr_t in some places where we previously used
>>> dma_addr_t, which means pci_bus_addr_t should be at least as large as
>>> dma_addr_t.  Can you enforce that directly, e.g., with something like this?
>>>
>>>     def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT || X86_PAE)
>
> then should use
>
> def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)

OK, would you mind updating this series, incorporating the doc
updates, and reposting it?

I think there's still an unresolved question about the OF parsing code.

Bjorn
