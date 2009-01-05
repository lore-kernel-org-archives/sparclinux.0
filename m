From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 05 Jan 2009 13:55:08 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090105135508.GB4190@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105132916.GA10545@uranus.ravnborg.org> <20090105133819.GE6014@elte.hu> <20090105134832.GA14460@uranus.ravnborg.org>
In-Reply-To: <20090105134832.GA14460@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Yinghai Lu <yinghai@kernel.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>


* Sam Ravnborg <sam@ravnborg.org> wrote:

> > > I did a simple:
> > > #include <linux/irqnr.h> but that did not help.
> > 
> > yeah. Does the patch below do the trick?
> 
> Needed a small fix - see below.
> 
> > btw., i'm curious, does the unification of the sparc architectures 
> > mean that sparc32 will be using genirq too some time in the future?
> 
> Dave has mentioned this but we are not working actively on it yet.

would be cool to do it - i think sparc32 is one of the last major physical 
architectures to not be on genirq - if we did this conversion we could do 
a good number of nice cleanups by eliminating all the genirq/non-genirq 
differences.

> > +#define nr_irqs			NR_IRQS
> > +#define irq_to_desc(irq)	irq_desc[irq]
> 
> irq_to_desc(irq) return a pointer to a struct irq_desc
> so we need to take the address.
> 
> > +#define irq_to_desc(irq)	&irq_desc[irq]
>                                 ^
> With this small fix the build continues.

oops, indeed. I fixed it, added your Tested-by and pushed it into 
tip/irq/urgent. Thanks Sam!

	Ingo
