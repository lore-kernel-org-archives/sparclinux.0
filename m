From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 18 Jul 2007 14:09:41 +0000
Subject: Re: [PATCH] Mark sparc and sparc64 as not having virt_to_bus
Message-Id: <Pine.LNX.4.61.0707181458390.2120@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718144140.3b4fd82e.sfr@canb.auug.org.au>
In-Reply-To: <20070718144140.3b4fd82e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org

Hi All,

Currently, sun4c (and sun4m) do NOT support the FDC driver as a module.
I did look at it but decided there were better issues to resolve at the 
time.

A fix for this issue would either envolve a lot of work moving the low 
level assembly interrupt handler from arch/sparc/kernel/entry.S to the 
floppy driver module, or the exporting of a number of variables and 
functions used by the handler so that they can be picked up by the floppy 
driver module.

Moving the low level handeler would be better from the point of view of 
modular code.

Regards
 	Mark Fortescue.

On Wed, 18 Jul 2007, Stephen Rothwell wrote:

>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> arch/sparc/Kconfig       |    3 +++
> arch/sparc64/Kconfig     |    3 +++
> include/asm-sparc64/io.h |    5 -----
> 3 files changed, 6 insertions(+), 5 deletions(-)
>
> This is part of a rash attempt to make allmodconfig builds work for sparc
> and sparc64 :-)
>
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 73df711..603d83a 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -21,6 +21,9 @@ config GENERIC_ISA_DMA
> 	bool
> 	default y
>
> +config ARCH_NO_VIRT_TO_BUS
> +	def_bool y
> +
> source "init/Kconfig"
>
> menu "General machine setup"
> diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
> index b84b6af..df6ee71 100644
> --- a/arch/sparc64/Kconfig
> +++ b/arch/sparc64/Kconfig
> @@ -62,6 +62,9 @@ config AUDIT_ARCH
> 	bool
> 	default y
>
> +config ARCH_NO_VIRT_TO_BUS
> +	def_bool y
> +
> choice
> 	prompt "Kernel page size"
> 	default SPARC64_PAGE_SIZE_8KB
> diff --git a/include/asm-sparc64/io.h b/include/asm-sparc64/io.h
> index ad595b6..9565a89 100644
> --- a/include/asm-sparc64/io.h
> +++ b/include/asm-sparc64/io.h
> @@ -14,11 +14,6 @@
> #define __SLOW_DOWN_IO	do { } while (0)
> #define SLOW_DOWN_IO	do { } while (0)
>
> -extern unsigned long virt_to_bus_not_defined_use_pci_map(volatile void *addr);
> -#define virt_to_bus virt_to_bus_not_defined_use_pci_map
> -extern unsigned long bus_to_virt_not_defined_use_pci_map(volatile void *addr);
> -#define bus_to_virt bus_to_virt_not_defined_use_pci_map
> -
> /* BIO layer definitions. */
> extern unsigned long kern_base, kern_size;
> #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
> -- 
> 1.5.2.3
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
