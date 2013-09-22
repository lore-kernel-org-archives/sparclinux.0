From: Rob Herring <robherring2@gmail.com>
Date: Sun, 22 Sep 2013 21:14:43 +0000
Subject: Re: [PATCH v2 04/10] irqdomain: Return errors from irq_create_of_mapping()
Message-Id: <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-5-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-5-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Instead of returning 0 for all errors, allow the precise error code to
> be propagated. This will be used in subsequent patches to allow further
> propagation of error codes.
>
> The interrupt number corresponding to the new mapping is returned in an
> output parameter so that the return value is reserved to signal success
> (= 0) or failure (< 0).
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

One comment below, otherwise:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 905a24b..ae71b14 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -230,6 +230,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  {
>         struct of_irq oirq;
>         unsigned int virq;
> +       int ret;
>
>         pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
>
> @@ -266,8 +267,10 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>                          oirq.size, oirq.specifier[0], oirq.specifier[1],
>                          of_node_full_name(oirq.controller));
>
> -               virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
> -                                            oirq.size);
> +               ret = irq_create_of_mapping(oirq.controller, oirq.specifier,
> +                                           oirq.size, &virq);
> +               if (ret)
> +                       virq = NO_IRQ;
>         }
>         if(virq = NO_IRQ) {
>                 pr_debug(" Failed to map !\n");

Can you get rid of NO_IRQ usage here instead of adding to it.

Rob
