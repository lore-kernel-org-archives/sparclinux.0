From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Tue, 06 Jan 2009 23:43:32 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090107084238.0E6D.KOSAKI.MOTOHIRO@jp.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105133819.GE6014@elte.hu> <20090105134832.GA14460@uranus.ravnborg.org>
In-Reply-To: <20090105134832.GA14460@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kosaki.motohiro@jp.fujitsu.com, Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

> >  #ifndef CONFIG_GENERIC_HARDIRQS
> >  #include <asm/irq.h>
> > -# define nr_irqs		NR_IRQS
> > +
> > +/*
> > + * Wrappers for non-genirq architectures:
> > + */
> > +#define nr_irqs			NR_IRQS
> > +#define irq_to_desc(irq)	irq_desc[irq]
> 
> irq_to_desc(irq) return a pointer to a struct irq_desc
> so we need to take the address.
> 
> > +#define irq_to_desc(irq)	&irq_desc[irq]
>                                 ^
> With this small fix the build continues.

maybe my fault.
very thanks.



