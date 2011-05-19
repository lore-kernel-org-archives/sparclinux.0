From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 19 May 2011 13:13:14 +0000
Subject: Re: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <4DD5176A.2000500@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB68838.1020304@gaisler.com>
In-Reply-To: <4DB68838.1020304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Tue, 26 Apr 2011 10:54:16 +0200
>
>  
>
>>There is no BIOS or bootloader initializing PCI for use in comparison
>>to the PCIC-SPARC32 code. LEON rely on the Linux generic resource &
>>    
>>

I mean that by looking at the pcic.c code I came to the conclusion that:
 * the "interrupt line" register  is not set by Linux
 * BAR / Bridge-Window resources are not set by Linux 
(pci_assign_unassigned_resources not called)

>Well since the kernel doesn't support Leon/PCI yet you still have
>an opportunity to "fix" this.
>  
>
Setting up this in the bootloader, means a lot of work. I need to come 
up with a PCI Library, that not only scans the PCI bus but also 
configures and sizes all resources, which is a huge job. I hope that 
Linux could do this since many other platforms rely on the generic Linux 
code in drivers/pci to set this up (drivers/pci/Makefile):

#
# Some architectures use the generic PCI setup functions
#
obj-$(CONFIG_X86) += setup-bus.o
obj-$(CONFIG_ALPHA) += setup-bus.o setup-irq.o
obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
obj-$(CONFIG_UNICORE32) += setup-bus.o setup-irq.o
obj-$(CONFIG_PARISC) += setup-bus.o
obj-$(CONFIG_SUPERH) += setup-bus.o setup-irq.o
obj-$(CONFIG_PPC) += setup-bus.o
obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
obj-$(CONFIG_X86_VISWS) += setup-irq.o
obj-$(CONFIG_MN10300) += setup-bus.o
obj-$(CONFIG_MICROBLAZE) += setup-bus.o
obj-$(CONFIG_TILE) += setup-bus.o setup-irq.o
+obj-$(CONFIG_SPARC_LEON) += setup-bus.o setup-irq.o


The PowerPC for example assign resources 
(arch/powerpc/kernel/pci-common.c), and PowerPC may also have a OpenBoot 
loader:

    /* Now, if the platform didn't decide to blindly trust the firmware,
     * we proceed to assigning things that were left unassigned
     */
    if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
        pr_debug("PCI: Assigning unassigned resources...\n");
        pci_assign_unassigned_resources();
    }

>This is going to create an enormous huge inconsistency between
>Leon and other SPARC PCI implementations, so please avoid this
>special case.
>
>Create the device tree nodes, via whatever means possible, and that
>way you won't have to implement anything special in the kernel.
>  
>
I'm not sure that I understand exactly what consequences there are, or 
what the "PCI device tree" can provide for us. I can see some drivers 
use it as a source of "additional" device properties, which we want to 
support in the long run of course.

The pcic seems falls back to no device node when the PROM node is not 
found, should I implement similar code?
        node = pdev_to_pnode(&pcic->pbm, dev);
        if(node = 0)
            node = -1;
        ...
        pcp->prom_node = of_find_node_by_phandle(node);

As many platforms use the Linux generic ways to setup IRQ and other 
resources in a clean way and LEON do it without affecting PCIC code, we 
can add PROM device nodes on the user's demand but not for all PCI 
devices (PCI scanning not required), and the huge amount of work to 
implement PCI device scanning/setup in the PROM besides we need 
multi-bus PCI achitecture as well... I kindly ask you to reconsider this.

Either way, I need to update the patches due to a build error for a 
specific config that Jan Andersson discovered.


Also, in pcic.c I wonder if the PROM loader writes the interrupt routing 
in the IRQ Line as the PCI standard suggests, the below comment does not 
say the writer checked that... that could perhaps be the solution for 
the complicated system specific interrupt routing initialization done in 
pcic... but that is another story.

 From pcic.c:
/*
 * I studied different documents and many live PROMs both from 2.30
 * family and 3.xx versions. I came to the amazing conclusion: there is
 * absolutely no way to route interrupts in IIep systems relying on
 * information which PROM presents. We must hardcode interrupt routing
 * schematics. And this actually sucks.   -- zaitcev 1999/05/12
 *
 * ...

Best Regards,
Daniel
