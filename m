From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sun, 12 Aug 2007 08:21:30 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <f43fc5580708120121t1b8aaee5x24c48049e4033d2a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/12/07, David Miller <davem@davemloft.net> wrote:
> > Specifically, how are the interrupts routed, which interrupts (ZS,
> > ESP, Lance, timers, floppy, cgthree) go through the interrupt
> > controller?
>
> There is no interrupt controller, the individual devices and
> SBUS slot interrupt sources are wired up directly to the cpu.

Then what device is poked by arch/sparc/kernel/sun4c_irq.c, I thought
this was the controller?

Thanks for the other information. Implementing the MMU is going to be difficult.
