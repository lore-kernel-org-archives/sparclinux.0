From: David Miller <davem@davemloft.net>
Date: Sun, 12 Aug 2007 09:09:23 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <20070812.020923.52115133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sun, 12 Aug 2007 11:21:30 +0300

> On 8/12/07, David Miller <davem@davemloft.net> wrote:
> > > Specifically, how are the interrupts routed, which interrupts (ZS,
> > > ESP, Lance, timers, floppy, cgthree) go through the interrupt
> > > controller?
> >
> > There is no interrupt controller, the individual devices and
> > SBUS slot interrupt sources are wired up directly to the cpu.
> 
> Then what device is poked by arch/sparc/kernel/sun4c_irq.c, I thought
> this was the controller?

It's similar to an interrupt controller, and it can mask certain
interrupts.
