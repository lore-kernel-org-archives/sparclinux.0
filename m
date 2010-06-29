From: Michal Simek <monstr@monstr.eu>
Date: Tue, 29 Jun 2010 09:57:26 +0000
Subject: Re: [PATCH 1/5] microblaze: turn CONFIG_OF into a select
Message-Id: <4C29C386.7090707@monstr.eu>
List-Id: <sparclinux.vger.kernel.org>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>	<20100629123843.5f94d477.sfr@canb.auug.org.au>
	<20100629124200.20ca24b7.sfr@canb.auug.org.au>
In-Reply-To: <20100629124200.20ca24b7.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Stephen Rothwell wrote:
> so that we can make CONFIG_OF global and remove it from
> the architecture Kconfig files later.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Michal Simek <monstr@monstr.eu>

> ---
>  arch/microblaze/Kconfig |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 76818f9..2b37820 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -17,6 +17,8 @@ config MICROBLAZE
>  	select HAVE_DMA_ATTRS
>  	select HAVE_DMA_API_DEBUG
>  	select TRACING_SUPPORT
> +	select OF
> +	select OF_FLATTREE
>  
>  config SWAP
>  	def_bool n
> @@ -125,8 +127,7 @@ config CMDLINE_FORCE
>  	  override those passed by the boot loader.
>  
>  config OF
> -	def_bool y
> -	select OF_FLATTREE
> +	bool
>  
>  config PROC_DEVICETREE
>  	bool "Support for device tree in /proc"


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
