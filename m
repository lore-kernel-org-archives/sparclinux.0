From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 15 Dec 2008 22:57:28 +0000
Subject: Re: [RFC PATCH] use sparc64 version of of_device.c
Message-Id: <646765f40812151457q5850d1afj7bf27ee9bea958a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4945AE56.2040503@earthlink.net>
In-Reply-To: <4945AE56.2040503@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

My comments are probably irrelevant as I assume the object of this
work is to merge the files without overly changing the binaries,
however, for the record and to repeat what David said:

On Mon, Dec 15, 2008 at 12:09, Robert Reif <reif@earthlink.net> wrote:
> index 0f616ae..625d605 100644
> --- a/arch/sparc/kernel/of_device_64.c
> +++ b/arch/sparc/kernel/of_device.c
> @@ -192,12 +194,15 @@ static unsigned long of_bus_default_get_flags(const
> u32 *addr, unsigned long fla
>
>  static int of_bus_pci_match(struct device_node *np)
>  {
> +#ifdef CONFIG_SPARC32
> +       if (!strcmp(np->type, "pci") || !strcmp(np->type, "pciex")) {
> +#else
>        if (!strcmp(np->name, "pci")) {
>                const char *model = of_get_property(np, "model", NULL);
>
>                if (model && !strcmp(model, "SUNW,simba"))
>                        return 0;
> -
> +#endif

Is there really any functional difference here? - I.e. is sparc32 ever
going to have a "simba" device and is sparc64 ever going to have a
pciex type device node?

> @@ -213,6 +218,7 @@ static int of_bus_pci_match(struct device_node *np)
>        return 0;
>  }
>
> +#ifdef CONFIG_SPARC64
>  static int of_bus_simba_match(struct device_node *np)
>  {
>        const char *model = of_get_property(np, "model", NULL);
> @@ -236,6 +242,7 @@ static int of_bus_simba_map(u32 *addr, const u32 *range,
>  {
>        return 0;
>  }
> +#endif

Is it harmful for sparc32 to have this function defined?

> @@ -314,6 +321,22 @@ static void of_bus_sbus_count_cells(struct device_node
> *child,
>                *sizec = 1;
>  }
>
> +#ifdef CONFIG_SPARC32
> +static int of_bus_sbus_map(u32 *addr, const u32 *range, int na, int ns, int
> pna)
> +{
> +       return of_bus_default_map(addr, range, na, ns, pna);
> +}
> +
> +static unsigned long of_bus_sbus_get_flags(const u32 *addr, unsigned long
> flags)
> +{
> +       return IORESOURCE_MEM;
> +}
> +#else
> +#define of_bus_sbus_map of_bus_default_map
> +#define of_bus_sbus_get_flags of_bus_default_get_flags
> +#endif

Aren't the two branches of this ifdef essentially identical for
of_bus_sbus_map()?

> +#ifdef CONFIG_SPARC64
>  /*
>  * FHC/Central bus specific translator.
>  *
> @@ -330,6 +353,7 @@ static int of_bus_fhc_match(struct device_node *np)
>  }
>
>  #define of_bus_fhc_count_cells of_bus_sbus_count_cells
> +#endif

Again, is it harmful for sparc32 to have this defined?

> @@ -345,6 +369,7 @@ static struct of_bus of_busses[] = {
>                .map = of_bus_pci_map,
>                .get_flags = of_bus_pci_get_flags,
>        },
> +#ifdef CONFIG_SPARC64
>        /* SIMBA */
>        {
>                .name = "simba",
> @@ -354,15 +379,17 @@ static struct of_bus of_busses[] = {
>                .map = of_bus_simba_map,
>                .get_flags = of_bus_pci_get_flags,
>        },
> +#endif

Is there any harm in having this code included in sparc32?

> +#ifdef CONFIG_SPARC64
>        /* FHC */
>        {
>                .name = "fhc",
> @@ -372,6 +399,7 @@ static struct of_bus of_busses[] = {
>                .map = of_bus_default_map,
>                .get_flags = of_bus_default_get_flags,
>        },
> +#endif

Ditto.

> +#ifdef CONFIG_SPARC64
>  static struct device_node * __init
>  apply_interrupt_map(struct device_node *dp, struct device_node *pp,
>                    const u32 *imap, int imlen, const u32 *imask,
> @@ -785,12 +822,17 @@ out:
>
>        return irq;
>  }
> +#endif

Is it harmful to have this defined for sparc32?

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
