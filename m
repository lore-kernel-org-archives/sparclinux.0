From: David Miller <davem@davemloft.net>
Date: Mon, 13 Aug 2007 01:45:16 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <20070812.184516.57653237.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 12 Aug 2007 15:33:45 +0100 (BST)

> Hi David,
> 
> > All DMA is translated by the cpu's MMU as if it were a memory
> > reference made by the cpu itself.  Any missed DMA translation watchdog
> > resets the cpu.
> 
> I am getting a watchdog reset as soon as I enable interrupts after 
> rebooting the kernel from SunOS or a prom_halt. Could in-proper DMA 
> settings be the cause of this?
> After the watchdog reset or a powre-up reset, there is no problem booting 
> Linux !.

It's likely taking interrupts like crazy because of the masking
issue.  Since no devices have registered interrupt handlers
yet, the interrupt source is never ACK'd and thus the interrupt
never shuts up.

Most of the time this happens with the sunlance chip, perhaps this is
what is being left enabled by SunOS.

Build a debugging kernel with some printk()'s added to
arch/sparc/kernel/irq.c:handler_irq(), just print the IRQ number and
the trap PC or similar.  Test boot it in the case that crashes and
record the messages, you only need the first one to figure out which
IRQ is active when interrupts are enabled.

It is my recollection that at least one of the BSDs had detection for
this issue and it would print something like "crazy interrupts!"  in
the kernel log when the condition was detected.  Indeed, it's
a good grepping point :-)

davem@sunset:~/src/OpenBSD/cvs/src/sys/arch/sparc/sparc$ egrep -i "crazy interrupts" *
intr.c:			panic("crazy interrupts");
davem@sunset:~/src/OpenBSD/cvs/src/sys/arch/sparc/sparc$ 

There are some things we can do to deal with this.

Let's assume you find out for sure it's sunlance, then in that case
you can write a small mini-of_device driver whose only purpose is
to shut off the interrupts in all the sunlance devices in the machine.
You execute it right after the of_device layer initializes.

static int __init lance_irq_disable_probe(struct of_device *dev,
					  const struct of_device_id *match)
{
	void __iomem *regs;

	regs = of_ioremap(&dev->resource[0], 0, 0x04, "lance_irq");
	if (regs) {
		sbus_writew(0x0000, regs + 0x02UL); /* ADDRESS = LE_CSR0 */
		sbus_writew(0x0004, regs + 0x00UL); /* LE_C0_STOP */
		of_iounmap(&dev->resource[0], regs, 0x04);
	}
	return 0;
}

static struct of_device_id lance_irq_disable_match[] = {
	{
		.name = "le",
	},
	{},
};

static struct of_platform_driver lance_irq_disable_driver = {
	.name		= "sunlance",
	.match_table	= lance_irq_disable_match,
	.probe		= lance_irq_disable_probe,
};

	...

	if (!of_register_driver(&lance_irq_disable_driver,
				&of_platform_bus_type))
		of_unregister_driver(&lance_irq_disable_driver,
				     &of_platform_bus_type);

You can repeat this process for any other device you determine
that SunOS leaves IRQs enabled for.
