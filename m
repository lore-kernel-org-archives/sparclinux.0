From: David Miller <davem@davemloft.net>
Date: Fri, 03 Apr 2015 16:48:55 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <20150403.124855.96516097693494126.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CABhMZUVqgsYdT4wn2H8hsrh4f=6hT0G+sg=wwYSt33+jtvBS9A@mail.gmail.com>
	<20150329.113250.2136683943336875789.davem@davemloft.net>
	<20150403154526.GB10892@google.com>
In-Reply-To: <20150403154526.GB10892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bhelgaas@google.com
Cc: bjorn@helgaas.com, bjorn.helgaas@gmail.com, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, yinghai@kernel.org, david.ahern@oracle.com, linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 3 Apr 2015 10:45:26 -0500

> On Sun, Mar 29, 2015 at 11:32:50AM -0700, David Miller wrote:
>> From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
>> Date: Sun, 29 Mar 2015 08:30:40 -0500
>> 
>> > Help me understand the sparc64 situation: are you saying that BAR
>> > addresses, i.e., MMIO transactions from a CPU or a peer-to-peer DMA can be
>> > 64 bits, but a DMA to main memory can only be 32 bits?
>> > 
>> > I assume this would work if we made dma_addr_t 64 bits on sparc64.  What
>> > would be the cost of doing that?
>> 
>> The cost is 4 extra bytes in every datastructure, kernel wide, that
>> stores DMA addresses.
> 
> That much is fairly obvious.  What I don't know is how much difference this
> makes in the end.

Networking drivers, and perhaps block drivers too, have a data
structure for each entry in the send/receive rings for the device and
these can be huge.  And each ring entry stores one or more DMA
addresses.

Larger types mean more memory, but also more capacity cache misses in
critical code paths.

I'm really sorry if this isn't painfully obvious to you.
