From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 04:05:10 +0000
Subject: Re: [PATCH 07/11] of: merge machine_is_compatible()
Message-Id: <1259208310.16367.231.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	 <20091124081906.6216.67035.stgit@angua>
In-Reply-To: <20091124081906.6216.67035.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze

I don't like moving this one to common code without the of_ prefix. I
think you should move it with the of_ prefix, and then add a alias in
powerpc and microblaze without of_ in a header until we fix all call
sites (which you can put on your to-do list :-)

Cheers,
Ben.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/microblaze/kernel/prom.c |   18 ------------------
>  arch/powerpc/kernel/prom.c    |   18 ------------------
>  drivers/of/base.c             |   18 ++++++++++++++++++
>  3 files changed, 18 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 543465a..c97192d 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -281,24 +281,6 @@ void __init early_init_devtree_arch(void)
>  	/* No Microblaze specific code here */
>  }
>  
> -/**
> - * Indicates whether the root node has a given value in its
> - * compatible property.
> - */
> -int machine_is_compatible(const char *compat)
> -{
> -	struct device_node *root;
> -	int rc = 0;
> -
> -	root = of_find_node_by_path("/");
> -	if (root) {
> -		rc = of_device_is_compatible(root, compat);
> -		of_node_put(root);
> -	}
> -	return rc;
> -}
> -EXPORT_SYMBOL(machine_is_compatible);
> -
>  /*******
>   *
>   * New implementation of the OF "find" APIs, return a refcounted
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index a5b3b9d..65de093 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -677,24 +677,6 @@ void __init early_init_devtree_arch(void)
>  	lmb_enforce_memory_limit(limit);
>  }
>  
> -/**
> - * Indicates whether the root node has a given value in its
> - * compatible property.
> - */
> -int machine_is_compatible(const char *compat)
> -{
> -	struct device_node *root;
> -	int rc = 0;
> -
> -	root = of_find_node_by_path("/");
> -	if (root) {
> -		rc = of_device_is_compatible(root, compat);
> -		of_node_put(root);
> -	}
> -	return rc;
> -}
> -EXPORT_SYMBOL(machine_is_compatible);
> -
>  /*******
>   *
>   * New implementation of the OF "find" APIs, return a refcounted
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ec56739..e81558f 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -144,6 +144,24 @@ int of_device_is_compatible(const struct device_node *device,
>  EXPORT_SYMBOL(of_device_is_compatible);
>  
>  /**
> + * Indicates whether the root node has a given value in its
> + * compatible property.
> + */
> +int machine_is_compatible(const char *compat)
> +{
> +	struct device_node *root;
> +	int rc = 0;
> +
> +	root = of_find_node_by_path("/");
> +	if (root) {
> +		rc = of_device_is_compatible(root, compat);
> +		of_node_put(root);
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL(machine_is_compatible);
> +
> +/**
>   *  of_device_is_available - check if a device is available for use
>   *
>   *  @device: Node to check for availability


