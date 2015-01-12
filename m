From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jan 2015 20:53:30 +0000
Subject: Re: Adding support for Fujitsu SPARC64 machines?
Message-Id: <20150112.155330.109991316193417303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1501080029010.18104@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1501080029010.18104@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 8 Jan 2015 00:55:08 +0200 (EET)

> * CPU support - 
> http://www.fujitsu.com/global/products/computing/servers/unix/sparc-enterprise/downloads/documents/ 
> has a bunch of developer docs for newer SPARC64 CPUs. Seems to be 
> detailed enough for just the CPU.

The OF based cpu scanner might need some tweaking, so that it
traverses properly from "cmp" down to "core" down to "cpu" to
find cpu nodes.

of_iterate_over_cpus() seems to just look for all nodes in the
tree of type "cpu" so you might be ok with no changes.

> * PCI I/O - Solaris tells there is pcicmu0 at root: SAFARI 0x8 0x4000 
> and px1 at root: SAFARI 0x1 0x700000 in the M4000. Am I correct if I
> think support for this bridge needs to be implemented? There are some 
> references to Safari in linux/arch/sparc/kernel code but Illumos seems 
> to have more complex code.

There are two different kinds of PCI controllers in the machine.

One PCI controller has a vendor ID of Fujitsu so it looks like it's
their own ASIC.  You therefore might need to write a PCI controller
driver for it.

The other is a Sun chip with device ID 80f8, it might be compatible
with the arch/sparc/kernel/pci_fire.c driver so simply adding an
entry like:

	{
		.name = "pci",
		.compatible = "pciex108e,80f8",
	},

to fire_match[] might work.

SAFARI is the system bus.

> * Are there any other devices that need support? Console device at the 
> least, maybe something else? Storage and network seem to be normal 
> PCI.

The console should probably be over the EBUS serial which is run by
the 'su' driver.  You'll have to get PCI working for this but meanwhile
a PROM console for output will work.

> * Is there any hypervisor protocol for talking to scf firmware from 
> domains? scf management protocol is probably not too important for start 
> since it should not be needed for boot/runtime support.

I would not even be thinking about this until you have the rest of
the machine working.
