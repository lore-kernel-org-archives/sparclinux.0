From: krzysztof.h1@poczta.fm
Date: Fri, 29 Aug 2008 05:52:14 +0000
Subject: Re: [RFC, SPARC64] use rtc mostek drivers instead of minirtc
Message-Id: <20080829055214.D191A45B81E@f49.poczta.interia.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20080823.234039.29618768.davem@davemloft.net>
In-Reply-To: <20080823.234039.29618768.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> From: Krzysztof Helt <krzysztof.h1@poczta.fm>
> Date: Sun, 24 Aug 2008 08:44:34 +0200
> 
> > Before using the patch below, the rtc m48t59 driver need to be
> > updated with two patches from the -mm tree:
> > 
> > rtc-m48t59-reduce-structure-m48t59_private.patch
> > rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev.patch
> 
> Actually these patches aren't needed, the first just removes an unused
> structure member and the second adds support for chips that sparc64
> systems don't even have :)
> 

I didn't know what rtc chips are available on sparc64 so I did
patches to support all types handled in the previous code.

> All Sparc64 systems have m48t59 chips, only older 32-bit sparcs have
> m48t02 and m48t08.  BTW there is a typo in the changelog for that
> second patch:
> 
> 	Add support for two compatible RTC:
> 	- M48T08 which does not have alarm part,
> 	- M48T08 which does not have alarm part and has
> 	  only 2KB of NVRAM
> 
> At least one of those lines should say M48T02 :-)
> 

Right. The one with 2KB of NVRAM is M48T02.

> Anyways, this means this code on the sparc64 side can be simplified
> even further.
> 

I suspected that after conversion to platform drivers the sparc code
can be simplified further.

> The following revised version of your patch should work.  In
> particular we don't need a fixed static resource, we can just point
> the platform device at the of_device resource object.  We also don't
> need the silly mostek reg pointers, we can deduce this from the
> resource the platform_device object has.
> 

I'll test it on Monday (I am leaving for the weekend).

> Actually, this mostek register access inteface is incomplete, the
> mostek rtc driver ioremap()'s the resource for MEM resources but
> doesn't provide the __iomem pointer to the register accessors because
> the mostek driver private structure type is not available in the
> header file, it's private to the RTC driver source.
> 

It is available in readb/writeb functions:

struct platform_device *pdev = to_platform_device(dev);
struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
void __iomem *regs = m48t59->ioaddr;

The patch can use the private ioaddr instead of just casting
resource.start if it is a better solution.

> But anyways, ioremap() does nothing but cast pointers on sparc64 so
> this happens to work :-)
> 

Ok.

Thank you for your review and tips.

Regards,
Krzysztof


---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef


