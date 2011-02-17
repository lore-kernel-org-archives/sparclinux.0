From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 17 Feb 2011 21:47:31 +0000
Subject: Re: How do we allocate virtual floppy irq on sparc64
Message-Id: <20110217214731.GA25097@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110217205747.GA25027@merkur.ravnborg.org>
In-Reply-To: <20110217205747.GA25027@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Feb 17, 2011 at 01:05:03PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 17 Feb 2011 21:57:48 +0100
> 
> > I'm trying to understand how we deal with floppy irq on sparc64.
> > 
> > In arch/sparc/include/asm/floppy_64.h we have:
> > 
> >                error = request_irq(FLOPPY_IRQ, sparc_floppy_irq,
> >                                     IRQF_DISABLED, "floppy", NULL);
> > 
> > FLOPPY_IRQ is set equal op->archdata.irqs[0] in sun_floppy_init().
> > So FLOPPY_IRQ is the platform irq - and not a virtual irq.
> 
> The archdata IRQ is actually the computed virtual IRQ.
> 
> This is the same as how we fetch the IRQ to use in other "OF" platform
> drivers.
> 
> Look at drivers/net/sunhme.c's OF platform driver probing, it uses
> of->archdata.irqs[0] as the IRQ.

Obvious - now that you spell it out for me.
For sparc32 I already in my tree call build_device_irq in
of_device_32.c:__init scan_one_device().
So I just have to look up the platform_device for floppy
in floppy_32.h and pick irq from that.

If I look for "SUNW,fdtwo" it should work on my box at least.
And I checked a few of the prtconfs you have in your git
repositry - several boxes uses this.

ss2 however name it "fd" - so I need to check for that too.
Same for ipx.

So I will look up "SUNW,fdtwo" + "fd" to find the platform_device
for floppy.
And in that platform_device I can find the already allocated irq.

	Sam
