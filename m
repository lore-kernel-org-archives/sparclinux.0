From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 04:04:08 +0000
Subject: Re: [PATCH 06/11] of/flattree: merge early_init_devtree() and
Message-Id: <1259208248.16367.230.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081853.6216.68105.stgit@angua>
In-Reply-To: <20091124081853.6216.68105.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:

>  
> -static int __init early_init_dt_scan_cpus(unsigned long node,
> -					  const char *uname, int depth,
> -					  void *data)
> +int __init early_init_dt_scan_cpus(unsigned long node, const char *uname,
> +				   int depth, void *data)
>  {

So now you make this one non-static as well with little hope of making
it static ever again

>  	static int logical_cpuid;
>  	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> @@ -113,8 +112,8 @@ void __init early_init_dt_scan_chosen_arch(unsigned long node)
>  	/* No Microblaze specific code here */
>  }
>  
> -static int __init early_init_dt_scan_memory(unsigned long node,
> -				const char *uname, int depth, void *data)
> +int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
> +				     int depth, void *data)
>  {

And this one

>  	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>  	u32 *reg, *endp;
> @@ -201,7 +200,7 @@ static inline unsigned long phyp_dump_calculate_reserve_size(void)
>   * without reserving anything. The memory in case of dump being
>   * active is freed when the dump is collected (by userland tools).
>   */
> -static void __init phyp_dump_reserve_mem(void)
> +void __init phyp_dump_reserve_mem(void)
>  {

And this one...

>  /**
> + * early_init_move_devtree - move tree to an unused area, if needed.
> + *
> + * The device tree may be allocated beyond our memory limit, or inside the
> + * crash kernel region for kdump. If so, move it out of the way.
> + */
> +#if defined(CONFIG_PPC)
> +static void __init early_init_move_devtree(void)

And you still end up with an ifdef mess in the common code ...

Would it be possible instead to have one common early_init_devtree()
that calls into the "common" ones (which you can then make static again,
inside the common code) and then calls one arch_early_init_devtree()
which regroups the arch specific ones ?

Or there's too many ordering issues ?

Another option then is to call from that early_init_devtree() something
like:

	arch_early_init_dt_mem()
	arch_early_init_dt_cpu()
	arch_early_init_move_devtree()

etc... in the right spots in the common code and have the archs who
don't do anything there just have them as empty inlines.

Cheers,
Ben.

