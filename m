From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 20 May 2015 14:48:39 +0000
Subject: Re: [Patch v2 06/14] genirq: Move field 'handler_data' from struct irq_data into struct irq_common_d
Message-Id: <alpine.DEB.2.11.1505201628400.4225@nanos>
List-Id: <sparclinux.vger.kernel.org>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com> <1432114845-24304-7-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-7-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, bob picco <bpicco@meloft.net>, Jason Cooper <jason@lakedaemon.net>, Kevin Cernekee <cernekee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, sparclinux@vger.kernel.orgl

On Wed, 20 May 2015, Jiang Liu wrote:

> Handler data (handler_data) is per-irq instead of per irqchip, so move
> it into struct irq_common_data.

For review and debugging sake, please do the same split as you did
with node. Convert first and then move. 5 patches this time:

Sparc: 
>  arch/sparc/kernel/irq_64.c    |   15 +++++++++------
>  arch/sparc/kernel/sun4d_irq.c |    4 ++--
>  arch/sparc/kernel/sun4m_irq.c |    6 ++++--

x86:
>  arch/x86/kernel/apic/msi.c    |    2 +-
>  arch/x86/kernel/hpet.c        |    4 ++--

gpio:
>  drivers/gpio/gpio-davinci.c   |    2 +-

sh:
>  drivers/sh/intc/virq.c        |    4 ++--

Move:
>  include/linux/irq.h           |    8 ++++----
>  include/linux/irqdesc.h       |    2 +-
>  kernel/irq/chip.c             |    2 +-
>  kernel/irq/irqdesc.c          |    3 ++-

> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index c5e05c82d67c..477d5b8616ab 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -396,7 +396,7 @@ static int gpio_irq_type_unbanked(struct irq_data *data, unsigned trigger)
>  	struct davinci_gpio_regs __iomem *g;
>  	u32 mask;
>  
> -	d = (struct davinci_gpio_controller *)data->handler_data;
> +	d = (struct davinci_gpio_controller *)irq_data_get_irq_handler_data(data);

This type cast is silly, handler_data is (void *)

>  	g = (struct davinci_gpio_regs __iomem *)d->regs;
>  	mask = __gpio_mask(data->irq - d->gpio_irq);
>  
> diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
> index f30ac9354ff2..3dbc21696924 100644
> --- a/drivers/sh/intc/virq.c
> +++ b/drivers/sh/intc/virq.c
> @@ -87,8 +87,8 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
>  	struct irq_data *data = irq_get_irq_data(irq);
>  
>  	/* scan for duplicates */
> -	last = (struct intc_virq_list **)&data->handler_data;
> -	for_each_virq(entry, data->handler_data) {
> +	last = (struct intc_virq_list **)&data->common->handler_data;

That does not make sense. You convert the one below, but not that one
to the accessor function.

handler_data is a pointer to a struct intc_virq_list. So 

	struct intc_virq_list **last, *entry, *head; 

	head = irq_data_get_irq_handler_data(data);
	last = &head;
	
	for_each_virq(entry, head) {
		....
	}

Would be clean code and lets you convert all usage sites of
data->handler_data before actually doing the move to common data.

Thanks,

	tglx
