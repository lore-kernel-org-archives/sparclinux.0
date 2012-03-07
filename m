From: Guan Xuetao <gxt@mprc.pku.edu.cn>
Date: Wed, 07 Mar 2012 06:52:43 +0000
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Message-Id: <1331103163.2048.33.camel@epip-laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
	<1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1331080238-1524-2-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>

On Tue, 2012-03-06 at 17:30 -0700, Stephen Warren wrote:
> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> if their arch Kconfig allows it, and they desire.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> The next patch enables this new CONFIG_ALLOW_ option for ARM. I assume
> that some other architectures will also be able to enable it, but I'm
> not familiar enough with any to know which.
> 
>  init/Kconfig         |   15 +++++++++++++++
>  scripts/Makefile.lib |   15 ++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 6cfd71d..2035562 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -203,6 +203,21 @@ config KERNEL_LZO
>  
>  endchoice
>  
> +config ALLOW_UIMAGE_KERNEL_NOLOAD
> +	bool
> +
> +config UIMAGE_KERNEL_NOLOAD
> +	bool "Use mkimage's -T kernel_noload instead of -T kernel"
> +	depends on ALLOW_UIMAGE_KERNEL_NOLOAD
> +	help
> +	  uImage files of type "kernel" embed an absolute load and entry point
> +	  address. If the uImage is loaded to a different address, then the
> +	  image must be copied the uImage file to the specified load address.
> +	  This copy is a waste of time if the uImage is in fact completely
> +	  relocatable. If your kernel and bootloader support it, you can build
> +	  a "kernel_noload" uImage rather than a "kernel" uImage, which
> +	  prevents any such copying. If unsure say N.
> +
>  config DEFAULT_HOSTNAME
>  	string "Default hostname"
>  	default "(none)"
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 7b0be18..d9c1c87 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -314,9 +314,18 @@ MKIMAGE := $(srctree)/scripts/mkuboot.sh
>  UIMAGE_ARCH = $(SRCARCH)
>  UIMAGE_COMPRESSION = $(if $(2),$(2),none)
>  UIMAGE_OPTS-y > -UIMAGE_TYPE = kernel
> -UIMAGE_LOADADDR=arch_must_set_this
> -UIMAGE_ENTRYADDR=$(UIMAGE_LOADADDR)
> +ifeq ($(CONFIG_UIMAGE_KERNEL_NOLOAD),y)
> +  UIMAGE_TYPE = kernel_noload
> +  # Unused by bootloader:
> +  UIMAGE_LOADADDR=0
> +  # Entry point relative to actual load address:
> +  UIMAGE_ENTRYADDR=0
> +else
> +  UIMAGE_TYPE = kernel
> +  # Absolute addresses:
> +  UIMAGE_LOADADDR=arch_must_set_this
> +  UIMAGE_ENTRYADDR=$(UIMAGE_LOADADDR)
> +endif
>  UIMAGE_NAME = 'Linux-$(KERNELRELEASE)'
>  UIMAGE_IN = $<
>  UIMAGE_OUT = $@
Hi, Stephen,
It seems that UIMAGE_ARCH and UIMAGE_LOADADDR can't be modified from
arch-Makefiles.

Regards,

Guan Xuetao

