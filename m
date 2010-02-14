From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 14 Feb 2010 06:09:36 +0000
Subject: Re: [PATCH 1/9] of: Remove old and misplaced function declarations
Message-Id: <1266127776.16346.58.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160231.4767.23831.stgit@angua>
In-Reply-To: <20100213160231.4767.23831.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Sat, 2010-02-13 at 09:02 -0700, Grant Likely wrote:
> The following functions don't exist:
>   finish_device_tree()
>   print_properties()
>   prom_n_intr_cells()
>   prom_get_irq_senses()
> 
> The following functions are in drivers/of/base.c, so the declaration
> belongs in of.h instead of of_fdt.h
>   of_machine_is_compatible()
>   prom_add_property()
>   prom_remove_property()
>   prom_update_property()
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  include/linux/of.h     |    8 ++++++++
>  include/linux/of_fdt.h |   10 ----------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index fa5571b..5c7b6a6 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -180,6 +180,14 @@ extern int of_parse_phandles_with_args(struct device_node *np,
>  	const char *list_name, const char *cells_name, int index,
>  	struct device_node **out_node, const void **out_args);
>  
> +extern int of_machine_is_compatible(const char *compat);
> +
> +extern int prom_add_property(struct device_node* np, struct property* prop);
> +extern int prom_remove_property(struct device_node *np, struct property *prop);
> +extern int prom_update_property(struct device_node *np,
> +				struct property *newprop,
> +				struct property *oldprop);
> +
>  #if defined(CONFIG_OF_DYNAMIC)
>  /* For updating the device tree at runtime */
>  extern void of_attach_node(struct device_node *);
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 0007187..c9cb8a7 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -95,18 +95,8 @@ extern int early_init_dt_scan_root(unsigned long node, const char *uname,
>  				   int depth, void *data);
>  
>  /* Other Prototypes */
> -extern void finish_device_tree(void);
>  extern void unflatten_device_tree(void);
>  extern void early_init_devtree(void *);
> -extern int of_machine_is_compatible(const char *compat);
> -extern void print_properties(struct device_node *node);
> -extern int prom_n_intr_cells(struct device_node* np);
> -extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
> -extern int prom_add_property(struct device_node* np, struct property* prop);
> -extern int prom_remove_property(struct device_node *np, struct property *prop);
> -extern int prom_update_property(struct device_node *np,
> -				struct property *newprop,
> -				struct property *oldprop);
>  
>  #endif /* __ASSEMBLY__ */
>  #endif /* _LINUX_OF_FDT_H */


