From: Michal Simek <monstr@monstr.eu>
Date: Tue, 29 Jun 2010 09:58:04 +0000
Subject: Re: [PATCH 5/5] of: remove architecture CONFIG_OF definitions
Message-Id: <4C29C3AC.8040304@monstr.eu>
List-Id: <sparclinux.vger.kernel.org>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>	<20100629123843.5f94d477.sfr@canb.auug.org.au> <20100629124701.f879c55c.sfr@canb.auug.org.au>
In-Reply-To: <20100629124701.f879c55c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Grant Likely <grant.likely@secretlab.ca>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, devicetree-discuss@lists.ozlabs.org, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

Stephen Rothwell wrote:
> now that CONFIG_OF is defined globally
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Michal Simek <monstr@monstr.eu>

> ---
>  arch/microblaze/Kconfig |    3 ---
>  arch/powerpc/Kconfig    |    3 ---
>  arch/sparc/Kconfig      |    3 ---
>  3 files changed, 0 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 2b37820..1a8f682 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -126,9 +126,6 @@ config CMDLINE_FORCE
>  	  Set this to have arguments from the default kernel command string
>  	  override those passed by the boot loader.
>  
> -config OF
> -	bool
> -
>  config PROC_DEVICETREE
>  	bool "Support for device tree in /proc"
>  	depends on PROC_FS
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3697231..402f4c0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -174,9 +174,6 @@ config ARCH_MAY_HAVE_PC_FDC
>  config PPC_OF
>  	def_bool y
>  
> -config OF
> -	bool
> -
>  config PPC_UDBG_16550
>  	bool
>  	default n
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index d02e8ac..13a9f2f 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -149,9 +149,6 @@ config GENERIC_GPIO
>  config ARCH_NO_VIRT_TO_BUS
>  	def_bool y
>  
> -config OF
> -	bool
> -
>  config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	def_bool y if SPARC64
>  


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
