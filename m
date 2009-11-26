From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Nov 2009 03:59:34 +0000
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
Message-Id: <1259207974.16367.226.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081827.6216.1896.stgit@angua>
In-Reply-To: <20091124081827.6216.1896.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, 2009-11-24 at 01:18 -0700, Grant Likely wrote:
> A cell is firmly established as a u32.  No need to do an ugly typedef
> to redefine it to cell_t.  Eliminate the unnecessary typedef so that
> it doesn't have to be added to the of_fdt header file
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

I'm not sure about that one. Yes, we do use u32 a lot and cell_t rarely,
so it would seem logical to switch.... On the other hand, we have that
pesky endianness issue we have never fully solved. So we need accessors
to sort that out, which means directly tapping things as u32 * is not a
good idea if we're going to enforce the use of such accessors.

I believe we should probably just enforce that properties are big endian
for flat device-trees. In which case we could just use __be32 or on of
thoes sparse-friendly types. I know x86 people won't like that much and
to be honest I don't know what 1295 specifies for real OFs but there
aren't enough real OFs around on LE machines for us to care much about
it, is there ?

The reason I prefer a fixed endianness is that allowing "LE" trees
becomes really nasty when a number is expressed using multiple cells.
That brings the question as to whether the two cells need to be flipped
as well or only the bytes within each cell. And that's the easy bit
(probably flip the whole thing). What about something like a PCI "reg"
property which is made of 3 cells, two of them forming a 64-bit address
and one containing additional data & attributes ? What is flipped and
where ?

So yes, cell_t might not be the right approach and by far to generic a
name, but u32 isn't the answer neither.

Cheers,
Ben. 

>  arch/microblaze/kernel/prom.c |   10 ++++------
>  arch/powerpc/kernel/prom.c    |   14 ++++++--------
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index e0f4c34..7760186 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -42,8 +42,6 @@
>  #include <asm/sections.h>
>  #include <asm/pci-bridge.h>
>  
> -typedef u32 cell_t;
> -
>  /* export that to outside world */
>  struct device_node *of_chosen;
>  
> @@ -159,7 +157,7 @@ static int __init early_init_dt_scan_memory(unsigned long node,
>  				const char *uname, int depth, void *data)
>  {
>  	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> -	cell_t *reg, *endp;
> +	u32 *reg, *endp;
>  	unsigned long l;
>  
>  	/* Look for the ibm,dynamic-reconfiguration-memory node */
> @@ -178,13 +176,13 @@ static int __init early_init_dt_scan_memory(unsigned long node,
>  	} else if (strcmp(type, "memory") != 0)
>  		return 0;
>  
> -	reg = (cell_t *)of_get_flat_dt_prop(node, "linux,usable-memory", &l);
> +	reg = (u32 *)of_get_flat_dt_prop(node, "linux,usable-memory", &l);
>  	if (reg = NULL)
> -		reg = (cell_t *)of_get_flat_dt_prop(node, "reg", &l);
> +		reg = (u32 *)of_get_flat_dt_prop(node, "reg", &l);
>  	if (reg = NULL)
>  		return 0;
>  
> -	endp = reg + (l / sizeof(cell_t));
> +	endp = reg + (l / sizeof(u32));
>  
>  	pr_debug("memory scan node %s, reg size %ld, data: %x %x %x %x,\n",
>  		uname, l, reg[0], reg[1], reg[2], reg[3]);
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 048e3a3..43cdba2 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -67,8 +67,6 @@ int __initdata iommu_force_on;
>  unsigned long tce_alloc_start, tce_alloc_end;
>  #endif
>  
> -typedef u32 cell_t;
> -
>  extern rwlock_t devtree_lock;	/* temporary while merging */
>  
>  /* export that to outside world */
> @@ -441,22 +439,22 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
>   */
>  static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  {
> -	cell_t *dm, *ls, *usm;
> +	u32 *dm, *ls, *usm;
>  	unsigned long l, n, flags;
>  	u64 base, size, lmb_size;
>  	unsigned int is_kexec_kdump = 0, rngs;
>  
>  	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
> -	if (ls = NULL || l < dt_root_size_cells * sizeof(cell_t))
> +	if (ls = NULL || l < dt_root_size_cells * sizeof(u32))
>  		return 0;
>  	lmb_size = dt_mem_next_cell(dt_root_size_cells, &ls);
>  
>  	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
> -	if (dm = NULL || l < sizeof(cell_t))
> +	if (dm = NULL || l < sizeof(u32))
>  		return 0;
>  
>  	n = *dm++;	/* number of entries */
> -	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(cell_t))
> +	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(u32))
>  		return 0;
>  
>  	/* check if this is a kexec/kdump kernel. */
> @@ -515,7 +513,7 @@ static int __init early_init_dt_scan_memory(unsigned long node,
>  					    const char *uname, int depth, void *data)
>  {
>  	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> -	cell_t *reg, *endp;
> +	u32 *reg, *endp;
>  	unsigned long l;
>  
>  	/* Look for the ibm,dynamic-reconfiguration-memory node */
> @@ -540,7 +538,7 @@ static int __init early_init_dt_scan_memory(unsigned long node,
>  	if (reg = NULL)
>  		return 0;
>  
> -	endp = reg + (l / sizeof(cell_t));
> +	endp = reg + (l / sizeof(u32));
>  
>  	DBG("memory scan node %s, reg size %ld, data: %x %x %x %x,\n",
>  	    uname, l, reg[0], reg[1], reg[2], reg[3]);


