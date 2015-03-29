From: David Miller <davem@davemloft.net>
Date: Sun, 29 Mar 2015 18:32:50 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <20150329.113250.2136683943336875789.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<20150327.145016.86183910134380870.davem@davemloft.net>
	<CABhMZUVqgsYdT4wn2H8hsrh4f=6hT0G+sg=wwYSt33+jtvBS9A@mail.gmail.com>
In-Reply-To: <CABhMZUVqgsYdT4wn2H8hsrh4f=6hT0G+sg=wwYSt33+jtvBS9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bjorn@helgaas.com, bjorn.helgaas@gmail.com
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, yinghai@kernel.org, david.ahern@oracle.com, bhelgaas@google.com, linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Sun, 29 Mar 2015 08:30:40 -0500

> Help me understand the sparc64 situation: are you saying that BAR
> addresses, i.e., MMIO transactions from a CPU or a peer-to-peer DMA can be
> 64 bits, but a DMA to main memory can only be 32 bits?
> 
> I assume this would work if we made dma_addr_t 64 bits on sparc64.  What
> would be the cost of doing that?

The cost is 4 extra bytes in every datastructure, kernel wide, that
stores DMA addresses.

This choice was very intentional, and well thought out.

Don't use DMA addresses for PCI addresses.  They are absolutely not
the same, especially when an IOMMU is always present because in that
case all DMA addresses are virtual and exist in a different realm
and set of constraints/restrictions.
