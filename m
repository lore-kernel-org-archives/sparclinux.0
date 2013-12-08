From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 08 Dec 2013 12:31:23 +0000
Subject: Re: [PATCH 10/10] tilo: allocate kernel memory dynamically on sun4u
Message-Id: <20131208123123.GM30823@blackmetal.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <1386458819-6590-11-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1386458819-6590-11-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Sun, Dec 08, 2013 at 01:26:59AM +0200, Aaro Koskinen wrote:
> Allocate memory for kernel image dynamically on sun4u. This allows to
> boot bigger modern day kernels.
> 
> External root image is not yet supported, but this can be workarounded
> by embedding the rootfs into the kernel with CONFIG_INITRAMFS_SOURCE.

It seems it's possible to pass the ramdisk straight from TILO image with:

	image_table[kernel_number].root_start = (unsigned)orig_code +
		image_table[ROOT_IMAGE].packed_start + 0x400000;

There are also some other minor issues in the patches, I'll post an
updated series maybe after next week.

A.

> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  tilo/tilo.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 106 insertions(+), 11 deletions(-)
> 
> diff --git a/tilo/tilo.c b/tilo/tilo.c
> index d2fcd97b525f..75772b77ca49 100644
> --- a/tilo/tilo.c
> +++ b/tilo/tilo.c
> @@ -171,6 +171,69 @@ extern struct ImageInfo image_table[4];	/* Sun4 kernel, Sun4c/d/m kernel, Sun4u
>  
>  #define HDRS_TAG	(('H'<<24) | ('d'<<16) | ('r'<<8) | 'S')
>  
> +static char *sun4u_memory_find (unsigned int len)
> +{
> +	int n, node, i;
> +	struct p1275_mem {
> +		unsigned long long phys;
> +		unsigned long long size;
> +	} *p = (struct p1275_mem *)0;
> +	unsigned int virt = 0x40000000;
> +	unsigned long long phys = 0, phys_base;
> +
> +	p = (struct p1275_mem *)malloc(2048);
> +
> +	node = prom_finddevice("/memory");
> +
> +	n = prom_getproplen(node, "available");
> +
> +	if (!n || n = -1 ||
> +	    prom_getproperty(node, "available", (char *)p, 2048) = -1) {
> +		free (p);
> +		printf("Could not get available property\n");
> +		return (char *)0;
> +	}
> +
> +	phys = 0;
> +	n /= sizeof(*p);
> +
> +	phys_base = ~(unsigned long long)0;
> +	for (i = 0; i < n; i++) {
> +		if (p[i].phys < phys_base)
> +			phys_base = p[i].phys;
> +	}
> +
> +	for (i = 0; i < n; i++) {
> +		/* Do not mess with first 16 Megs of memory */
> +		if (p[i].phys = phys_base) {
> +			if (p[i].size <= 0x1000000)
> +				continue;
> +			p[i].phys += 0x1000000;
> +			p[i].size -= 0x1000000;
> +		}
> +
> +		if (p[i].size >= len) {
> +			phys = p[i].phys;
> +			break;
> +		}
> +	}
> +
> +	free (p);
> +
> +	if (!phys) {
> +		printf("Could not find any available memory\n");
> +		return (char *)0;
> +	}
> +
> +	if (prom_map(PROM_MAP_DEFAULT, (unsigned long long)len, virt, phys) =
> +	    -1) {
> +		printf("Could not map memory\n");
> +		return (char *)0;
> +	}
> +
> +	return (char *)virt + 0x4000;
> +}
> +
>  void parse_executable(char *base, int image_len)
>  {
>  	union {
> @@ -275,7 +338,7 @@ void parse_executable(char *base, int image_len)
>  
>  char *my_main (struct linux_romvec *promvec, void *cifh, void *cifs)
>  {
> -char *orig_code,*moved_code,*moved_ramdisk,*moved_kernel,*kernel_base;
> +char *orig_code,*moved_code,*moved_ramdisk = NULL,*moved_kernel,*kernel_base;
>  unsigned *p,*q = NULL;
>  int kernel_number;
>  char *kernel_end, *kernel_limit;
> @@ -307,21 +370,53 @@ char *kernel_end, *kernel_limit;
>  	}
>  	    				
>      orig_code = (char*) 0x4000;
> -    moved_code = (char*) MOVED_BASE;
> -    moved_ramdisk = (char*)((long)(moved_code - image_table[ROOT_IMAGE].packed_len) & ~0xfff);
> -    moved_kernel = (char*)((long)(moved_ramdisk - image_table[kernel_number].packed_len) & ~0xfff);
> +
> +    /*
> +     * On sun4u we can allocate more memory and relocate the kernel.
> +     */
> +    if (kernel_number = SUN4U_KERNEL) {
> +        unsigned int size;
> +
> +	for (size = 64 * 1024 * 1024; size >= 4 * 1024 * 1024;
> +	     size -= 4 * 1024 * 1024) {
> +		kernel_base = sun4u_memory_find(size);
> +		if (kernel_base)
> +			break;
> +	}
> +	if (!kernel_base)
> +		goto no_mem;
> +	kernel_limit = kernel_base + size;
> +	gzminp = (unsigned char *)orig_code +
> +		 image_table[kernel_number].packed_start;
> +	if (image_table[ROOT_IMAGE].packed_len ||
> +	    image_table[kernel_number].root_start) {
> +		printf("External root image not yet supported - disabling.\n");
> +		image_table[kernel_number].root_start = 0;
> +		image_table[ROOT_IMAGE].packed_len = 0;
> +	}
> +    } else {
> +no_mem:
> +	moved_code = (char*)MOVED_BASE;
> +	moved_ramdisk = (char*)((long)(moved_code -
> +				image_table[ROOT_IMAGE].packed_len) & ~0xfff);
> +	moved_kernel = (char*)((long)(moved_ramdisk -
> +			       image_table[kernel_number].packed_len) & ~0xfff);
>  #ifdef TILO_DEBUG
> -    printf("Locations: moved_code=%x  moved_ramdisk=%x moved_kernel=%x\n",
> -	   moved_code, moved_ramdisk, moved_kernel);
> +	printf("Locations: moved_code=%x  moved_ramdisk=%x moved_kernel=%x\n",
> +	       moved_code, moved_ramdisk, moved_kernel);
>  #endif
> -    memmove (moved_ramdisk, orig_code + image_table[ROOT_IMAGE].packed_start, image_table[ROOT_IMAGE].packed_len);
> -    memmove (moved_kernel, orig_code + image_table[kernel_number].packed_start, image_table[kernel_number].packed_len);
> +	memmove(moved_ramdisk, orig_code + image_table[ROOT_IMAGE].packed_start,
> +		image_table[ROOT_IMAGE].packed_len);
> +	memmove(moved_kernel,
> +		orig_code + image_table[kernel_number].packed_start,
> +		image_table[kernel_number].packed_len);
> +
> +	kernel_base = (char*) 0x4000;
> +	kernel_limit = moved_kernel;
> +    }
>  
> -    gzminp = (unsigned char *)moved_kernel;		/* decompress kernel */
> -    kernel_base = (char*) 0x4000;
>      kernel_end = kernel_base +
>  		 ((image_table[kernel_number].unpacked_len + 0xfff) & ~0xfff);
> -    kernel_limit = moved_kernel;
>  
>      if (kernel_end > kernel_limit) {
>  	printf("No space to decompress the kernel.\n");
> -- 
> 1.8.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
