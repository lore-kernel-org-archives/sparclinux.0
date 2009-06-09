From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 09 Jun 2009 20:13:50 +0000
Subject: Re: [PATCH 5/7] Added support for AMBA bus
Message-Id: <20090609201350.GI7181@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45E6.1050506@gaisler.com>
In-Reply-To: <4A2E45E6.1050506@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 09, 2009 at 01:22:14PM +0200, Konrad Eisele wrote:
> From 1c076b182a3bc3e6c332df7c4f4436d69e7fa3b6 Mon Sep 17 00:00:00 2001
> From: Konrad Eisele <konrad@gaisler.com>
> Date: Tue, 9 Jun 2009 13:03:50 +0200
> Subject: [PATCH 5/7] Added support for AMBA bus. The device is a AMBA bus if
> it is a child of prom node "ambapp" (AMBA plug and play).
> Two functions leon_trans_init() and leon_node_init()
> (defined in sparc/kernel/leon.c) are called in the
> prom_build_tree() path if CONFIG_LEON is defined.
> leon_node_init() will build up the device tree using
> AMBA plug and play.
> 
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
> ---
>  arch/sparc/kernel/of_device_32.c |   50 
>  +++++++++++++++++++++++++++++++++++++-
>  arch/sparc/kernel/prom_32.c      |   42 ++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/prom_common.c  |   20 ++++++++++++++-
>  3 files changed, 109 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/of_device_32.c 
> b/arch/sparc/kernel/of_device_32.c
> index 0a83bd7..1d1e75a 100644
> --- a/arch/sparc/kernel/of_device_32.c
> +++ b/arch/sparc/kernel/of_device_32.c
> @@ -8,6 +8,9 @@ #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> +#if defined(CONFIG_LEON)
> +#include <asm/leon.h>
> +#endif

We use unconditional includes. The protection needs to be in the .h file
as needed.

> 
>  static int node_match(struct device *dev, void *data)
>  {
> @@ -125,7 +128,10 @@ static int of_out_of_range(const u32 *ad
>  	return 0;
>  }
> 
> -static int of_bus_default_map(u32 *addr, const u32 *range,
> +#if !defined(CONFIG_LEON)
> +static
> +#endif
> +int of_bus_default_map(u32 *addr, const u32 *range,
>  			      int na, int ns, int pna)
>  {
This is just too ugly.
Please rework so we can use the same prototype with and without leon.


> +
> +struct amba_prom_registers {
> +	unsigned int phys_addr;	/* The physical address of this register */
> +	unsigned int reg_size;	/* How many bytes does this register take 
> up? */
> +};
We had this in leon.h too?

> +
> +/* "name@irq,addrlo" */
> +static void __init ambapp_path_component(struct device_node *dp, char 
> *tmp_buf)
> +{
> +	struct amba_prom_registers *regs; unsigned int *intr;
> +	unsigned int *device, *vendor;
> +	struct property *prop;
> +
> +	prop = of_find_property(dp, "reg", NULL);
> +	if (!prop)
> +		return;
> +	regs = prop->value;
> +	prop = of_find_property(dp, "interrupts", NULL);
> +	if (!prop)
> +		return;
> +	intr = prop->value;
> +	prop = of_find_property(dp, "vendor", NULL);
> +	if (!prop)
> +		return;
> +	vendor = prop->value;
> +	prop = of_find_property(dp, "device", NULL);
> +	if (!prop)
> +		return;
> +	device = prop->value;
> +
> +	sprintf(tmp_buf, "%s:%d:%d@%x,%x",
> +		dp->name, *vendor, *device,
> +		*intr, regs->phys_addr);
> +}
> +
> +#endif
> +
>  static void __init __build_path_component(struct device_node *dp, char 
>  *tmp_buf)
>  {
>  	struct device_node *parent = dp->parent;
> @@ -143,6 +181,10 @@ static void __init __build_path_componen
>  			return sbus_path_component(dp, tmp_buf);
>  		if (!strcmp(parent->type, "ebus"))
>  			return ebus_path_component(dp, tmp_buf);
> +#if defined(CONFIG_LEON)
> +		if (!strcmp(parent->type, "ambapp"))
> +			return ambapp_path_component(dp, tmp_buf);
> +#endif
> 
>  		/* "isa" is handled with platform naming */
>  	}
> diff --git a/arch/sparc/kernel/prom_common.c 
> b/arch/sparc/kernel/prom_common.c
> index 0fb5789..d865b65 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c
> @@ -22,6 +22,11 @@ #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <asm/prom.h>
>  #include <asm/oplib.h>
> +#if defined(CONFIG_LEON)
> +extern void __init leon_trans_init(struct device_node *dp);
> +extern void __init leon_node_init(struct device_node *dp,
> +				  struct device_node ***nextp);
> +#endif
> 
>  #include "prom.h"
> 
> @@ -161,7 +166,7 @@ static struct property * __init build_on
>  			name = prom_nextprop(node, prev, p->name);
>  		}
> 
> -		if (strlen(name) = 0) {
> +		if (!name || strlen(name) = 0) {
>  			tmp = p;
>  			return NULL;
>  		}
> @@ -237,12 +242,19 @@ static struct device_node * __init prom_
> 
>  	dp->properties = build_prop_list(node);
> 
> +#if defined(CONFIG_LEON)
> +	leon_trans_init(dp);
> +#endif
>  	irq_trans_init(dp);

Why we cannot share the function?

> 
>  	return dp;
>  }
> 
> -static char * __init build_full_name(struct device_node *dp)
> +#if !defined(CONFIG_LEON)
> +static
> +#else
> +char * __init build_full_name(struct device_node *dp)
> +#endif
>  {
NO - find a way to do this better.


>  	int len, ourlen, plen;
>  	char *n;
> @@ -289,6 +301,10 @@ static struct device_node * __init prom_
> 
>  		dp->child = prom_build_tree(dp, prom_getchild(node), nextp);
> 
> +#if defined(CONFIG_LEON)
> +		leon_node_init(dp, nextp);
> +#endif
> +
>  		node = prom_getsibling(node);
>  	}
> 

This file give me the impression that more effort could have been
put into consolidating more of this code.
David & Robert already did a gret effort for 32 + 64 bit sparc here.
So please do not ruin it.

In these code path you need to justify each and every single
use of ifdef/endif. What we have here is not good enough..

I know this is hard words but this stuff needs to be maintainable
also in three years from now.

	Sam
