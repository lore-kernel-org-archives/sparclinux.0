From: David Miller <davem@davemloft.net>
Date: Sun, 12 Aug 2007 07:51:50 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <20070812.005150.90531371.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sun, 12 Aug 2007 10:42:33 +0300

> Specifically, how are the interrupts routed, which interrupts (ZS,
> ESP, Lance, timers, floppy, cgthree) go through the interrupt
> controller?

There is no interrupt controller, the individual devices and
SBUS slot interrupt sources are wired up directly to the cpu.

> How do the controller bits map to each interrupt source
> and PIL?

All, except 1 or 2, sun4c interrupt sources are non-maskable.
There really isn't an interrupt controller at all.

> Any docs for the controller, what is the device chip ID?

There are no public docs for this hardware.

> I guess the MMU is similar in operation to Sun4u/v I/D TLB, is that
> correct? Any CPU docs would be helpful.

Not similar to sun4u at all, and and no public docs.

> There is no IOMMU, so the DMA is limited to lowest 16 megs, right?

All DMA is translated by the cpu's MMU as if it were a memory
reference made by the cpu itself.  Any missed DMA translation watchdog
resets the cpu.
