From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 12 Aug 2007 14:43:28 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <Pine.LNX.4.61.0708121535060.32464@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sun, 12 Aug 2007, David Miller wrote:

> From: "Blue Swirl" <blauwirbel@gmail.com>
> Date: Sun, 12 Aug 2007 11:21:30 +0300
>
>> On 8/12/07, David Miller <davem@davemloft.net> wrote:
>>>> Specifically, how are the interrupts routed, which interrupts (ZS,
>>>> ESP, Lance, timers, floppy, cgthree) go through the interrupt
>>>> controller?
>>>
>>> There is no interrupt controller, the individual devices and
>>> SBUS slot interrupt sources are wired up directly to the cpu.
>>
>> Then what device is poked by arch/sparc/kernel/sun4c_irq.c, I thought
>> this was the controller?
>
> It's similar to an interrupt controller, and it can mask certain
> interrupts.

Two key features that the Solaris kernel has specific coding for are:

1) Level 15 interrupts can't be masked so Solaris has a counter to keep 
track of how many times its level 15 interrupt has been interrupted :).

2) On some (if not all) sun4c hardware, interrupts can get through when 
the interrupt mask is being changed to a higher level. Solaris checks 
the interrupt level and if it is higher that that required for the 
interrupt, it just returns from the interrupt as the processor will get 
interrupted again, properly, as soon as the interrupt mask is lowered to a 
sufficient level to alow the interrupt to be processed properly.

The Linux interrupt handler probably does the same sort of things but as 
yet, I have not taken a sufficiently close look at it to confirm this. It 
may need tweeking.

Regards
 	Mark Fortescue.
