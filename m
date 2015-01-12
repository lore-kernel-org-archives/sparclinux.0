From: Mark Kettenis <mark.kettenis@xs4all.nl>
Date: Mon, 12 Jan 2015 21:48:59 +0000
Subject: Re: Adding support for Fujitsu SPARC64 machines?
Message-Id: <201501122148.t0CLmxp3016705@glazunov.sibelius.xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1501080029010.18104@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1501080029010.18104@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Data: Mon, 12 Jan 2015 20:53:30

> From: Meelis Roos <mroos@linux.ee>
> Date: Thu, 8 Jan 2015 00:55:08 +0200 (EET)
>
> > * PCI I/O - Solaris tells there is pcicmu0 at root: SAFARI 0x8 0x4000 
> > and px1 at root: SAFARI 0x1 0x700000 in the M4000. Am I correct if I
> > think support for this bridge needs to be implemented? There are some 
> > references to Safari in linux/arch/sparc/kernel code but Illumos seems 
> > to have more complex code.
> 
> There are two different kinds of PCI controllers in the machine.
> 
> One PCI controller has a vendor ID of Fujitsu so it looks like it's
> their own ASIC.  You therefore might need to write a PCI controller
> driver for it.

"pci10cf,138f" and "pci10cf,1390" are actually variants of good old
Psycho, so in OpenBSD it is handled by the psycho(4) driver.  There's
no IOMMU, but there are no devices behind it that need do DMA anyway.

> The other is a Sun chip with device ID 80f8, it might be compatible
> with the arch/sparc/kernel/pci_fire.c driver so simply adding an
> entry like:
> 
> {
> 	.name = "pci",
> 	      .compatible = "pciex108e,80f8",
> },
> 
> to fire_match[] might work.

There are some subtle differences between "Oberon" and "Fire", the
most prominent one being how the target CPU is encoded in the
interrupt mapping registers,  Handled by pyro(4) in OpenBSD.

>> * OpenBSD guys had a problem with some specific invalid hardware access 
>> causing fault in xscf firmware that needed to be cleared by service 
>> engineer, assuming there is a service contract. My Fujitsus are in my 
>> museum so there is no service contract. Has anyone heard if the current 
>> firmwares are more reliable? I'm running the latest on M4000 and 
>> whatever came with the PrimePowers.

The problems seemed to be caused by trying to push the serial port too
hard.  Pretending the serial chip had no FIFO, pushing the characters
one at a time made the problem disappear.  Seems like the firmware on
the machine was detecting some sort of overflow and overreacted a bit
by faulting the entire chassis ;).

I know that there are newer firmware versions for the M3000 that allow
customers to clear these faults themselves.  You might want to check
whether the M4000 firmware allows this as well before starting to hack
on it.

I never encountered problems like that on the PrimePower machines.

Cheers,

Mark
