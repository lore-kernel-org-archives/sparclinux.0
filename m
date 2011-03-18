From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Mar 2011 22:48:10 +0000
Subject: Re: [PATCH] sparc: Provide NO_IRQ definition.
Message-Id: <20110318224809.GA16225@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110318.150435.241941372.davem@davemloft.net>
In-Reply-To: <20110318.150435.241941372.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Mar 18, 2011 at 03:04:35PM -0700, David Miller wrote:
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/irq_32.h |    3 +++
>  arch/sparc/include/asm/irq_64.h |    2 ++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_32.h
> index cbf4801..eced3e3 100644
> --- a/arch/sparc/include/asm/irq_32.h
> +++ b/arch/sparc/include/asm/irq_32.h
> @@ -13,4 +13,7 @@
>  #define irq_canonicalize(irq)	(irq)
>  
>  extern void __init init_IRQ(void);
> +
> +#define NO_IRQ		0xffffffff
> +
>  #endif
> diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
> index 4f09666f..16dcae6d 100644
> --- a/arch/sparc/include/asm/irq_64.h
> +++ b/arch/sparc/include/asm/irq_64.h
> @@ -97,4 +97,6 @@ extern void *softirq_stack[NR_CPUS];
>  #define __ARCH_HAS_DO_SOFTIRQ
>  #define ARCH_HAS_NMI_WATCHDOG
>  
> +#define NO_IRQ		0xffffffff
> +
>  #endif

Why -1 (0xffffffff)?

drivers/of/irq.c default to 0 - like this:
/* For archs that don't support NO_IRQ (such as x86), provide a dummy value */
#ifndef NO_IRQ
#define NO_IRQ 0
#endif

I can see that the actual value differs from arch to arch.

I recalled a discussion about this topic some years ago.
Do not ask how I managed to do so?!?

Anyway the input from Linus was to use 0 for NO_IRQ because
as he said:

==
But the point is that most drivers will do something like

	if (!dev->irq)
		return;
(whatever, made up). And that having NO_IRQ be anything but 0 is thus 
fundamentally broken.
==

See the full mail here:

    http://lkml.org/lkml/2005/11/21/211


I do not know of any places that would break - I just
wanted to bring this to your attention.

	Sam
