From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 15 Dec 2008 18:52:41 +0000
Subject: Re: [RFC PATCH] use sparc64 version of of_device.c
Message-Id: <20081215185241.GB12938@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4945AE56.2040503@earthlink.net>
In-Reply-To: <4945AE56.2040503@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 14, 2008 at 08:09:42PM -0500, Robert Reif wrote:
> This patch creates a combined kernel/of_device.c by starting with the
> sparc64 version and adding #ifdefs and sparc32 code.
> 
> The only sparc64 difference is a %llx printk change.
> 
> The sparc32 changes are:
>    change int rlen to unsigned int rlen in build_one_resource
>    keep the sparc64 op->resources[] array size check
> 
> I know #ifdefs are ugly but the files were so similar.
> Is this acceptable?

Hi Robert.

Sorry to be negative here. But this hurt readability too much.
I will try to give some specific comments below.

That said I really like to see these two files merged.
When merged the iffedery really show the minimal differences that
is actually present.

Consider doing this as two steps.
First steps prepare of_device_64.c for the unification - which in some
cases may add otherwise pointless changes (such as moving a function
or a variable definition.

And the second step where you do the unification.

	Sam


> +#ifdef CONFIG_SPARC64
>  void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name)
>  {
>  	unsigned long ret = res->start + offset;
> @@ -34,6 +35,7 @@ void of_iounmap(struct resource *res, void __iomem *base, unsigned long size)
>  		release_region((unsigned long) base, size);
>  }
>  EXPORT_SYMBOL(of_iounmap);
> +#endif

For sparc32 we have these in ioport.c.
So the better alternative would maybe have been to move them
to a ioport_64 file?
That may seem counter productive but it uis best to keep similar
things in similar named files.


>  static int node_match(struct device *dev, void *data)
>  {
> @@ -192,12 +194,15 @@ static unsigned long of_bus_default_get_flags(const u32 *addr, unsigned long fla
>  
>  static int of_bus_pci_match(struct device_node *np)
>  {
> +#ifdef CONFIG_SPARC32
> +	if (!strcmp(np->type, "pci") || !strcmp(np->type, "pciex")) {
> +#else
>  	if (!strcmp(np->name, "pci")) {
>  		const char *model = of_get_property(np, "model", NULL);
>  
>  		if (model && !strcmp(model, "SUNW,simba"))
>  			return 0;
> -
> +#endif
>  		/* Do not do PCI specific frobbing if the
>  		 * PCI bridge lacks a ranges property.  We
>  		 * want to pass it through up to the next
> @@ -213,6 +218,7 @@ static int of_bus_pci_match(struct device_node *np)
>  	return 0;
>  }

Ifdeffing only the 'if' part makes the code almost unreadable.
In this case having two node_match functions would be more readable.
And then you could reuse the ifdef block you have below.


>  
>  static void of_bus_pci_count_cells(struct device_node *np,
>  				   int *addrc, int *sizec)
> @@ -314,6 +321,22 @@ static void of_bus_sbus_count_cells(struct device_node *child,
>  		*sizec = 1;
>  }
>  
> +#ifdef CONFIG_SPARC32
> +static int of_bus_sbus_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> +{
> +	return of_bus_default_map(addr, range, na, ns, pna);
> +}
> +
> +static unsigned long of_bus_sbus_get_flags(const u32 *addr, unsigned long flags)
> +{
> +	return IORESOURCE_MEM;
> +}
> +#else
> +#define of_bus_sbus_map of_bus_default_map
> +#define of_bus_sbus_get_flags of_bus_default_get_flags
> +#endif

This renaming could be dropped?
of_bus_sbus_map is equal to of_bus_default_map.
And of_bus_sbus_get_flags is almost equal to of_bus_default_get_flags.
Maybe we can use the latter for sparc32 too (I did not check the use of the flags parameter).



> +
> +#ifdef CONFIG_SPARC64
>  /*
>   * FHC/Central bus specific translator.
>   *
> @@ -330,6 +353,7 @@ static int of_bus_fhc_match(struct device_node *np)
>  }
>  
>  #define of_bus_fhc_count_cells of_bus_sbus_count_cells
> +#endif
The rename above is not needed as only SPARC64 code reference of_bus_fhc_count_cells

>  
>  /*
>   * Array of bus specific translators
> @@ -345,6 +369,7 @@ static struct of_bus of_busses[] = {
>  		.map = of_bus_pci_map,
>  		.get_flags = of_bus_pci_get_flags,
>  	},
> +#ifdef CONFIG_SPARC64
>  	/* SIMBA */
>  	{
>  		.name = "simba",
> @@ -354,15 +379,17 @@ static struct of_bus of_busses[] = {
>  		.map = of_bus_simba_map,
>  		.get_flags = of_bus_pci_get_flags,
>  	},
> +#endif
>  	/* SBUS */
>  	{
>  		.name = "sbus",
>  		.addr_prop_name = "reg",
>  		.match = of_bus_sbus_match,
>  		.count_cells = of_bus_sbus_count_cells,
> -		.map = of_bus_default_map,
> -		.get_flags = of_bus_default_get_flags,
> +		.map = of_bus_sbus_map,
> +		.get_flags = of_bus_sbus_get_flags,
>  	},
> +#ifdef CONFIG_SPARC64
>  	/* FHC */
>  	{
>  		.name = "fhc",
> @@ -372,6 +399,7 @@ static struct of_bus of_busses[] = {
>  		.map = of_bus_default_map,
>  		.get_flags = of_bus_default_get_flags,
>  	},
> +#endif

If the order is not important then combine the two SPARC64 specific entries.

>  	/* Default */
>  	{
>  		.name = "default",
> @@ -425,13 +453,14 @@ static int __init build_one_resource(struct device_node *parent,
>  			return 0;
>  	}
>  
> +#ifdef CONFIG_SPARC64
>  	/* When we miss an I/O space match on PCI, just pass it up
>  	 * to the next PCI bridge and/or controller.
>  	 */
>  	if (!strcmp(bus->name, "pci") &&
>  	    (addr[0] & 0x03000000) = 0x01000000)
>  		return 0;
> -
> +#endif
>  	return 1;
>  }
>  
> @@ -456,13 +485,14 @@ static int __init use_1to1_mapping(struct device_node *pp)
>  	    !strcmp(pp->name, "lebuffer"))
>  		return 0;
>  
> +#ifdef _CONFIG_SPARC64
          ^
>  	/* Similarly for all PCI bridges, if we get this far
>  	 * it lacks a ranges property, and this will include
>  	 * cases like Simba.
>  	 */
>  	if (!strcmp(pp->name, "pci"))
>  		return 0;
> -
> +#endif
Here an underscore slipped in.

>  	return 1;
>  }
>  
> @@ -554,22 +584,29 @@ static void __init build_device_resources(struct of_device *op,
>  		memset(r, 0, sizeof(*r));
>  
>  		if (of_resource_verbose)
> -			printk("%s reg[%d] -> %lx\n",
> +			printk("%s reg[%d] -> %llx\n",
>  			       op->node->full_name, index,
> -			       result);
> +			       (unsigned long long)result);
>  
>  		if (result != OF_BAD_ADDR) {
> +#ifdef CONFIG_SPARC32
> +			r->start = result & 0xffffffff;
> +			r->end = result + size - 1;
> +			r->flags = flags | ((result >> 32ULL) & 0xffUL);
> +#else
>  			if (tlb_type = hypervisor)
>  				result &= 0x0fffffffffffffffUL;
>  
>  			r->start = result;
>  			r->end = result + size - 1;
>  			r->flags = flags;
> +#endif

Rearrange this so it is obvious which two lines are not equal.
The order os the assignmnet I expect does not matter.

>  		}
>  		r->name = op->node->name;
>  	}
>  }
>  
> +#ifdef CONFIG_SPARC64
>  static struct device_node * __init
>  apply_interrupt_map(struct device_node *dp, struct device_node *pp,
>  		    const u32 *imap, int imlen, const u32 *imask,
> @@ -785,12 +822,17 @@ out:
>  
>  	return irq;
>  }
> +#endif
>  
>  static struct of_device * __init scan_one_device(struct device_node *dp,
>  						 struct device *parent)
>  {
>  	struct of_device *op = kzalloc(sizeof(*op), GFP_KERNEL);
> +#ifdef CONFIG_SPARC32
> +	const struct linux_prom_irqs *intr;
> +#else
>  	const unsigned int *irq;
> +#endif
>  	struct dev_archdata *sd;
>  	int len, i;
>  
> @@ -809,6 +851,79 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
>  	if (op->portid = -1)
>  		op->portid = of_getintprop_default(dp, "portid", -1);
>  
> +#ifdef CONFIG_SPARC32
> +	intr = of_get_property(dp, "intr", &len);
> +	if (intr) {
> +		op->num_irqs = len / sizeof(struct linux_prom_irqs);
> +		for (i = 0; i < op->num_irqs; i++)
> +			op->irqs[i] = intr[i].pri;
> +	} else {
> +		const unsigned int *irq > +			of_get_property(dp, "interrupts", &len);
> +
> +		if (irq) {
> +			op->num_irqs = len / sizeof(unsigned int);
> +			for (i = 0; i < op->num_irqs; i++)
> +				op->irqs[i] = irq[i];
> +		} else {
> +			op->num_irqs = 0;
> +		}
> +	}
> +	if (sparc_cpu_model = sun4d) {
> +		static int pil_to_sbus[] = {
> +			0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
> +		};
> +		struct device_node *io_unit, *sbi = dp->parent;
> +		const struct linux_prom_registers *regs;
> +		int board, slot;
> +
> +		while (sbi) {
> +			if (!strcmp(sbi->name, "sbi"))
> +				break;
> +
> +			sbi = sbi->parent;
> +		}
> +		if (!sbi)
> +			goto build_resources;
> +
> +		regs = of_get_property(dp, "reg", NULL);
> +		if (!regs)
> +			goto build_resources;
> +
> +		slot = regs->which_io;
> +
> +		/* If SBI's parent is not io-unit or the io-unit lacks
> +		 * a "board#" property, something is very wrong.
> +		 */
> +		if (!sbi->parent || strcmp(sbi->parent->name, "io-unit")) {
> +			printk("%s: Error, parent is not io-unit.\n",
> +			       sbi->full_name);
> +			goto build_resources;
> +		}
> +		io_unit = sbi->parent;
> +		board = of_getintprop_default(io_unit, "board#", -1);
> +		if (board = -1) {
> +			printk("%s: Error, lacks board# property.\n",
> +			       io_unit->full_name);
> +			goto build_resources;
> +		}
> +
> +		for (i = 0; i < op->num_irqs; i++) {
> +			int this_irq = op->irqs[i];
> +			int sbusl = pil_to_sbus[this_irq];
> +
> +			if (sbusl)
> +				this_irq = (((board + 1) << 5) +
> +					    (sbusl << 2) +
> +					    slot);
> +
> +			op->irqs[i] = this_irq;
> +		}
> +	}
> +
> +build_resources:
> +	build_device_resources(op, parent);
> +#else
>  	irq = of_get_property(dp, "interrupts", &len);
>  	if (irq) {
>  		memcpy(op->irqs, irq, len);
> @@ -826,8 +941,10 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
>  	}
>  
>  	build_device_resources(op, parent);
> +
>  	for (i = 0; i < op->num_irqs; i++)
>  		op->irqs[i] = build_one_device_irq(op, parent, op->irqs[i]);
> +#endif

It would be better to move the relevant pices to two separate functions here.


>  
>  	op->dev.parent = parent;
>  	op->dev.bus = &of_platform_bus_type;
> @@ -890,8 +1007,10 @@ static int __init of_debug(char *str)
>  	get_option(&str, &val);
>  	if (val & 1)
>  		of_resource_verbose = 1;
> +#ifdef CONFIG_SPARC64
>  	if (val & 2)
>  		of_irq_verbose = 1;
> +#endif
>  	return 1;
>  }

Define this variable for SPARC32 and get rid of the above ifdef.

	Sam
