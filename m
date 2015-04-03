From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 03 Apr 2015 15:45:26 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <20150403154526.GB10892@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
 <20150327.145016.86183910134380870.davem@davemloft.net>
 <CABhMZUVqgsYdT4wn2H8hsrh4f=6hT0G+sg=wwYSt33+jtvBS9A@mail.gmail.com>
 <20150329.113250.2136683943336875789.davem@davemloft.net>
In-Reply-To: <20150329.113250.2136683943336875789.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: bjorn@helgaas.com, bjorn.helgaas@gmail.com, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, yinghai@kernel.org, david.ahern@oracle.com, linux-kernel@vger.kernel.org

On Sun, Mar 29, 2015 at 11:32:50AM -0700, David Miller wrote:
> From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
> Date: Sun, 29 Mar 2015 08:30:40 -0500
> 
> > Help me understand the sparc64 situation: are you saying that BAR
> > addresses, i.e., MMIO transactions from a CPU or a peer-to-peer DMA can be
> > 64 bits, but a DMA to main memory can only be 32 bits?
> > 
> > I assume this would work if we made dma_addr_t 64 bits on sparc64.  What
> > would be the cost of doing that?
> 
> The cost is 4 extra bytes in every datastructure, kernel wide, that
> stores DMA addresses.

That much is fairly obvious.  What I don't know is how much difference this
makes in the end.

> Don't use DMA addresses for PCI addresses.  They are absolutely not
> the same, especially when an IOMMU is always present because in that
> case all DMA addresses are virtual and exist in a different realm
> and set of constraints/restrictions.

I'm still trying to figure out a clear description of how a DMA address is
different from a PCI address.  If you capture a transaction with a PCI
analyzer, I don't think you can tell a DMA address from a PCI address
unless you know how bridge windows are programmed.  Even then, I'm not sure
you can tell a CPU-generated PCI address from a DMA address in a
device-generated peer-to-peer transaction.

Bjorn
