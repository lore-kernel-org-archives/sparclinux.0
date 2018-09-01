From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 01 Sep 2018 18:13:08 +0000
Subject: Re: [PATCH v3] sparc: set a default 32-bit dma mask for OF devices
Message-Id: <423e567c-3b61-15d9-d614-710d1b41b433@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180901134911.22616-1-hch@lst.de>
In-Reply-To: <20180901134911.22616-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, mroos-Y27EyoLml9s@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

On 09/01/2018 06:49 AM, Christoph Hellwig wrote:
> This keeps the historic default behavior for devices without a DMA mask,
> but removes the warning about a lacking DMA mask for doing DMA without
> a mask.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Had to redo this because the platform_device patch that the previous
> version dependend on had to be dropped.
> 
>   arch/sparc/kernel/of_device_32.c | 4 ++++
>   arch/sparc/kernel/of_device_64.c | 3 +++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
> index 3641a294ed54..e4abe9b8f97a 100644
> --- a/arch/sparc/kernel/of_device_32.c
> +++ b/arch/sparc/kernel/of_device_32.c
> @@ -9,6 +9,7 @@
>   #include <linux/irq.h>
>   #include <linux/of_device.h>
>   #include <linux/of_platform.h>
> +#include <linux/dma-mapping.h>
>   #include <asm/leon.h>
>   #include <asm/leon_amba.h>
>   
> @@ -381,6 +382,9 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
>   	else
>   		dev_set_name(&op->dev, "%08x", dp->phandle);
>   
> +	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	op->dev.dma_mask = &op->dev.coherent_dma_mask;
> +
>   	if (of_device_register(op)) {
>   		printk("%s: Could not register of device.\n",
>   		       dp->full_name);
> diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
> index 44e4d4435bed..6df6086968c6 100644
> --- a/arch/sparc/kernel/of_device_64.c
> +++ b/arch/sparc/kernel/of_device_64.c
> @@ -2,6 +2,7 @@
>   #include <linux/string.h>
>   #include <linux/kernel.h>
>   #include <linux/of.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/init.h>
>   #include <linux/export.h>
>   #include <linux/mod_devicetable.h>
> @@ -675,6 +676,8 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
>   		dev_set_name(&op->dev, "root");
>   	else
>   		dev_set_name(&op->dev, "%08x", dp->phandle);
> +	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	op->dev.dma_mask = &op->dev.coherent_dma_mask;
>   
>   	if (of_device_register(op)) {
>   		printk("%s: Could not register of device.\n",
> 
