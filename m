From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 14 Feb 2010 06:14:57 +0000
Subject: Re: [PATCH 9/9] of: remove undefined request_OF_resource &
Message-Id: <1266128097.16346.67.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160314.4767.93924.stgit@angua>
In-Reply-To: <20100213160314.4767.93924.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Sat, 2010-02-13 at 09:03 -0700, Grant Likely wrote:
> Neither request_OF_resource or release_OF_resource are defined
> anywhere.  Remove the declarations.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>  arch/microblaze/include/asm/prom.h |    4 ----
>  arch/powerpc/include/asm/prom.h    |    5 -----
>  2 files changed, 0 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
> index aa1a437..03f45a9 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -31,10 +31,6 @@
>  /* Other Prototypes */
>  extern int early_uartlite_console(void);
>  
> -extern struct resource *request_OF_resource(struct device_node *node,
> -				int index, const char *name_postfix);
> -extern int release_OF_resource(struct device_node *node, int index);
> -
>  /*
>   * OF address retreival & translation
>   */
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f9a50a..ddd408a 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -39,11 +39,6 @@ extern struct device_node* pci_device_to_OF_node(struct pci_dev *);
>  extern void pci_create_OF_bus_map(void);
>  #endif
>  
> -extern struct resource *request_OF_resource(struct device_node* node,
> -				int index, const char* name_postfix);
> -extern int release_OF_resource(struct device_node* node, int index);
> -
> -
>  /*
>   * OF address retreival & translation
>   */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


