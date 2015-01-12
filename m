From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jan 2015 22:11:49 +0000
Subject: Re: Adding support for Fujitsu SPARC64 machines?
Message-Id: <20150112.171149.1098430794117980629.davem@davemloft.net>
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
>> The other is a Sun chip with device ID 80f8, it might be compatible
>> with the arch/sparc/kernel/pci_fire.c driver so simply adding an
>> entry like:
>> 
>> {
>> 	.name = "pci",
>> 	      .compatible = "pciex108e,80f8",
>> },
>> 
>> to fire_match[] might work.
> 
> There are some subtle differences between "Oberon" and "Fire", the
> most prominent one being how the target CPU is encoded in the
> interrupt mapping registers,  Handled by pyro(4) in OpenBSD.

Meelis, this is handled by sun4u_compute_tid() in arch/sparc/kernel/irq_64.c
