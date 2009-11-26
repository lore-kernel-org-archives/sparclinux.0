From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 03:55:01 +0000
Subject: Re: [PATCH 03/11] of/flattree: merge dt_mem_next_cell
Message-Id: <1259207701.16367.221.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	 <20091124081814.6216.97169.stgit@angua>
In-Reply-To: <20091124081814.6216.97169.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Tue, 2009-11-24 at 01:18 -0700, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/microblaze/kernel/prom.c |    8 --------
>  arch/powerpc/kernel/prom.c    |    8 --------
>  drivers/of/fdt.c              |    8 ++++++++
>  include/linux/of_fdt.h        |    1 +
>  4 files changed, 9 insertions(+), 16 deletions(-)

Same comment here, something goes from static to global... do you plan
to make things back to static in the end ?

Ben.

> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 189179a..e0f4c34 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -155,14 +155,6 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
>  	return 1;
>  }
>  
> -static u64 __init dt_mem_next_cell(int s, cell_t **cellp)
> -{
> -	cell_t *p = *cellp;
> -
> -	*cellp = p + s;
> -	return of_read_number(p, s);
> -}
> -
>  static int __init early_init_dt_scan_memory(unsigned long node,
>  				const char *uname, int depth, void *data)
>  {
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 78f65a4..048e3a3 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -432,14 +432,6 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
>  	return 1;
>  }
>  
> -static u64 __init dt_mem_next_cell(int s, cell_t **cellp)
> -{
> -	cell_t *p = *cellp;
> -
> -	*cellp = p + s;
> -	return of_read_number(p, s);
> -}
> -
>  #ifdef CONFIG_PPC_PSERIES
>  /*
>   * Interpret the ibm,dynamic-memory property in the
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index be200be..ebce509 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -432,6 +432,14 @@ int __init early_init_dt_scan_root(unsigned long node, const char *uname,
>  	return 1;
>  }
>  
> +u64 __init dt_mem_next_cell(int s, u32 **cellp)
> +{
> +	u32 *p = *cellp;
> +
> +	*cellp = p + s;
> +	return of_read_number(p, s);
> +}
> +
>  /**
>   * unflatten_device_tree - create tree of device_nodes from flat blob
>   *
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 828c3cd..d1a37e5 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -72,6 +72,7 @@ extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
>  extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
>  extern unsigned long of_get_flat_dt_root(void);
>  extern void early_init_dt_check_for_initrd(unsigned long node);
> +extern u64 dt_mem_next_cell(int s, u32 **cellp);
>  
>  /* Early flat tree scan hooks */
>  extern int early_init_dt_scan_root(unsigned long node, const char *uname,


