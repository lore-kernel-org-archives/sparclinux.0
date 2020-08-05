From: Baoquan He <bhe@redhat.com>
Date: Wed, 05 Aug 2020 04:20:24 +0000
Subject: Re: [PATCH v2 13/17] x86/setup: simplify initrd relocation and reservation
Message-Id: <20200805042024.GT10792@MiWiFi-R3L-srv>
List-Id: <sparclinux.vger.kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-14-rppt@kernel.org>
In-Reply-To: <20200802163601.8189-14-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, ucli

On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently, initrd image is reserved very early during setup and then it
> might be relocated and re-reserved after the initial physical memory
> mapping is created. The "late" reservation of memblock verifies that mapped
> memory size exceeds the size of initrd, the checks whether the relocation
                                          ~ then?
> required and, if yes, relocates inirtd to a new memory allocated from
> memblock and frees the old location.
> 
> The check for memory size is excessive as memblock allocation will anyway
> fail if there is not enough memory. Besides, there is no point to allocate
> memory from memblock using memblock_find_in_range() + memblock_reserve()
> when there exists memblock_phys_alloc_range() with required functionality.
> 
> Remove the redundant check and simplify memblock allocation.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a3767e74c758..d8de4053c5e8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -262,16 +262,12 @@ static void __init relocate_initrd(void)
>  	u64 area_size     = PAGE_ALIGN(ramdisk_size);
>  
>  	/* We need to move the initrd down into directly mapped mem */
> -	relocated_ramdisk = memblock_find_in_range(0, PFN_PHYS(max_pfn_mapped),
> -						   area_size, PAGE_SIZE);
> -
> +	relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
> +						      PFN_PHYS(max_pfn_mapped));
>  	if (!relocated_ramdisk)
>  		panic("Cannot find place for new RAMDISK of size %lld\n",
>  		      ramdisk_size);
>  
> -	/* Note: this includes all the mem currently occupied by
> -	   the initrd, we rely on that fact to keep the data intact. */
> -	memblock_reserve(relocated_ramdisk, area_size);
>  	initrd_start = relocated_ramdisk + PAGE_OFFSET;
>  	initrd_end   = initrd_start + ramdisk_size;
>  	printk(KERN_INFO "Allocated new RAMDISK: [mem %#010llx-%#010llx]\n",
> @@ -298,13 +294,13 @@ static void __init early_reserve_initrd(void)
>  
>  	memblock_reserve(ramdisk_image, ramdisk_end - ramdisk_image);
>  }
> +
>  static void __init reserve_initrd(void)
>  {
>  	/* Assume only end is not page aligned */
>  	u64 ramdisk_image = get_ramdisk_image();
>  	u64 ramdisk_size  = get_ramdisk_size();
>  	u64 ramdisk_end   = PAGE_ALIGN(ramdisk_image + ramdisk_size);
> -	u64 mapped_size;
>  
>  	if (!boot_params.hdr.type_of_loader ||
>  	    !ramdisk_image || !ramdisk_size)
> @@ -312,12 +308,6 @@ static void __init reserve_initrd(void)
>  
>  	initrd_start = 0;
>  
> -	mapped_size = memblock_mem_size(max_pfn_mapped);
> -	if (ramdisk_size >= (mapped_size>>1))
> -		panic("initrd too large to handle, "
> -		       "disabling initrd (%lld needed, %lld available)\n",
> -		       ramdisk_size, mapped_size>>1);

Reviewed-by: Baoquan He <bhe@redhat.com>

> -
>  	printk(KERN_INFO "RAMDISK: [mem %#010llx-%#010llx]\n", ramdisk_image,
>  			ramdisk_end - 1);
>  
> -- 
> 2.26.2
> 
