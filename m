From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jan 2015 22:07:45 +0000
Subject: Re: Adding support for Fujitsu SPARC64 machines?
Message-Id: <20150112.170745.2161294831984822769.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1501080029010.18104@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1501080029010.18104@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Kettenis <mark.kettenis@xs4all.nl>
Date: Mon, 12 Jan 2015 22:48:59 +0100 (CET)

> From: David Miller <davem@davemloft.net>
> Data: Mon, 12 Jan 2015 20:53:30
> 
>> From: Meelis Roos <mroos@linux.ee>
>> Date: Thu, 8 Jan 2015 00:55:08 +0200 (EET)
>>
>> > * PCI I/O - Solaris tells there is pcicmu0 at root: SAFARI 0x8 0x4000 
>> > and px1 at root: SAFARI 0x1 0x700000 in the M4000. Am I correct if I
>> > think support for this bridge needs to be implemented? There are some 
>> > references to Safari in linux/arch/sparc/kernel code but Illumos seems 
>> > to have more complex code.
>> 
>> There are two different kinds of PCI controllers in the machine.
>> 
>> One PCI controller has a vendor ID of Fujitsu so it looks like it's
>> their own ASIC.  You therefore might need to write a PCI controller
>> driver for it.
> 
> "pci10cf,138f" and "pci10cf,1390" are actually variants of good old
> Psycho, so in OpenBSD it is handled by the psycho(4) driver.  There's
> no IOMMU, but there are no devices behind it that need do DMA anyway.

Indeed, only the EBUS is behind this PCI controller.
