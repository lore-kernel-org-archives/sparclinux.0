From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 13:48:32 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090105134832.GA14460@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105132916.GA10545@uranus.ravnborg.org> <20090105133819.GE6014@elte.hu>
In-Reply-To: <20090105133819.GE6014@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Yinghai Lu <yinghai@kernel.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Jan 05, 2009 at 02:38:19PM +0100, Ingo Molnar wrote:
> 
> * Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > I hit the following build error on sparc:
> > 
> > drivers/gpio/gpiolib.c: In function `gpiolib_dbg_show':
> > drivers/gpio/gpiolib.c:1146: error: implicit declaration of function `irq_to_desc'
> > drivers/gpio/gpiolib.c:1146: warning: initialization makes pointer from integer without a cast
> > 
> > 
> > This is with an allmodconfig where I did:
> > 
> > make ARCH=sparc vmlinux
> > 
> > sparc do _not_ have GENERIC_HARDIRQS set to 'y'.
> >
> > I did a simple:
> > #include <linux/irqnr.h> but that did not help.
> 
> yeah. Does the patch below do the trick?

Needed a small fix - see below.

> 
> btw., i'm curious, does the unification of the sparc architectures mean 
> that sparc32 will be using genirq too some time in the future?

Dave has mentioned this but we are not working actively on it yet.

> 
> 	Ingo
> 
> ---------------->
> From 08522e214542b4afc6c2401bb02900cfca76f600 Mon Sep 17 00:00:00 2001
> From: Ingo Molnar <mingo@elte.hu>
> Date: Mon, 5 Jan 2009 14:34:42 +0100
> Subject: [PATCH] genirq: provide irq_to_desc() to non-genirq architectures too
> 
> Impact: build fix on non-genirq architectures
> 
> Sam Ravnborg reported this build failure on sparc32 allmodconfig,
> the GPIO drivers assume the presence of irq_to_desc():
> 
>  drivers/gpio/gpiolib.c: In function `gpiolib_dbg_show':
>  drivers/gpio/gpiolib.c:1146: error: implicit declaration of function 'irq_to_desc'
> 
> Add it in the !genirq case too.
> 
> Reported-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  include/linux/irqnr.h |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
> index 5504a5c..6b719fa 100644
> --- a/include/linux/irqnr.h
> +++ b/include/linux/irqnr.h
> @@ -8,7 +8,12 @@
>  
>  #ifndef CONFIG_GENERIC_HARDIRQS
>  #include <asm/irq.h>
> -# define nr_irqs		NR_IRQS
> +
> +/*
> + * Wrappers for non-genirq architectures:
> + */
> +#define nr_irqs			NR_IRQS
> +#define irq_to_desc(irq)	irq_desc[irq]

irq_to_desc(irq) return a pointer to a struct irq_desc
so we need to take the address.

> +#define irq_to_desc(irq)	&irq_desc[irq]
                                ^
With this small fix the build continues.

Thanks,
	Sam
