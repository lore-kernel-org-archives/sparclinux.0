From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Date: Fri, 25 Feb 2011 18:25:22 +0000
Subject: RE: [RFC PATCH 06/15] dt: xilinx_hwicap: merge platform and of_platformdriver bindings
Message-Id: <8da12938-78ee-4a0f-b1e4-7bfac7fa16c3@VA3EHSMHS036.ehs.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6> <20110223043405.20795.19903.stgit@localhost6.localdomain6>
In-Reply-To: <20110223043405.20795.19903.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.o
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Minor nit below

Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=neuendorffer.name@lists.ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen=neuendorffer.name@lists.ozlabs.org] On Behalf Of Grant
Likely
> Sent: Tuesday, February 22, 2011 8:34 PM
> To: Benjamin Herrenschmidt; devicetree-discuss@lists.ozlabs.org;
sfr@canb.auug.org.au; linux-
> kernel@vger.kernel.org; davem@davemloft.net
> Cc: sparclinux@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: [RFC PATCH 06/15] dt: xilinx_hwicap: merge platform and
of_platformdriver bindings
> 
> of_platform_driver is getting removed, and a single platform_driver
> can now support both devicetree and non-devicetree use cases.  This
> patch merges the two driver registrations.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/char/xilinx_hwicap/xilinx_hwicap.c |  129
+++++++++++-----------------
>  1 files changed, 49 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> index 9f2272e..a55e877 100644
> --- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> @@ -714,20 +714,29 @@ static int __devexit hwicap_remove(struct device
*dev)
>  	return 0;		/* success */
>  }
> 
> -static int __devinit hwicap_drv_probe(struct platform_device *pdev)
> +#ifdef CONFIG_OF
> +static int __devinit hwicap_of_probe(struct platform_device *op)
>  {
> -	struct resource *res;
> -	const struct config_registers *regs;
> +	struct resource res;
> +	const unsigned int *id;
>  	const char *family;
> +	int rc;
> +	const struct hwicap_driver_config *config op->dev.of_match->data;
> +	const struct config_registers *regs;
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> +
> +	rc = of_address_to_resource(op->dev.of_node, 0, &res);
> +	if (rc) {
> +		dev_err(&op->dev, "invalid address\n");
> +		return rc;
> +	}
> +
> +	id = of_get_property(op->dev.of_node, "port-number", NULL);
> 
>  	/* It's most likely that we're using V4, if the family is not
>  	   specified */
>  	regs = &v4_config_registers;
> -	family = pdev->dev.platform_data;
> +	family = of_get_property(op->dev.of_node, "xlnx,family", NULL);
> 
>  	if (family) {
>  		if (!strcmp(family, "virtex2p")) {
> @@ -738,54 +747,33 @@ static int __devinit hwicap_drv_probe(struct
platform_device *pdev)
>  			regs = &v5_config_registers;
>  		}
>  	}
> -
> -	return hwicap_setup(&pdev->dev, pdev->id, res,
> -			&buffer_icap_config, regs);
> +	return hwicap_setup(&op->dev, id ? *id : -1, &res, config,
> +			regs);
>  }
> -
> -static int __devexit hwicap_drv_remove(struct platform_device *pdev)
> +#else
> +static inline int hwicap_of_probe(struct platform_device *op)
>  {
> -	return hwicap_remove(&pdev->dev);
> +	return -EINVAL;
>  }
> +#endif /* CONFIG_OF */
> 
> -static struct platform_driver hwicap_platform_driver = {
> -	.probe = hwicap_drv_probe,
> -	.remove = hwicap_drv_remove,
> -	.driver = {
> -		.owner = THIS_MODULE,
> -		.name = DRIVER_NAME,
> -	},
> -};
> -
> -/*
---------------------------------------------------------------------
> - * OF bus binding
> - */
> -
> -#if defined(CONFIG_OF)
> -static int __devinit
> -hwicap_of_probe(struct platform_device *op, const struct of_device_id
*match)
> +static int __devinit hwicap_drv_probe(struct platform_device *pdev)
>  {
> -	struct resource res;
> -	const unsigned int *id;
> -	const char *family;
> -	int rc;
> -	const struct hwicap_driver_config *config = match->data;
> +	struct resource *res;
>  	const struct config_registers *regs;
> +	const char *family;
> 
> -	dev_dbg(&op->dev, "hwicap_of_probe(%p, %p)\n", op, match);
> -
> -	rc = of_address_to_resource(op->dev.of_node, 0, &res);
> -	if (rc) {
> -		dev_err(&op->dev, "invalid address\n");
> -		return rc;
> -	}
> +	if (pdev->dev.of_match)
> +		return hwicap_of_probe(pdev);
> 
> -	id = of_get_property(op->dev.of_node, "port-number", NULL);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> 
>  	/* It's most likely that we're using V4, if the family is not
>  	   specified */
>  	regs = &v4_config_registers;
> -	family = of_get_property(op->dev.of_node, "xlnx,family", NULL);
> +	family = pdev->dev.platform_data;
> 
>  	if (family) {
>  		if (!strcmp(family, "virtex2p")) {
> @@ -796,15 +784,17 @@ hwicap_of_probe(struct platform_device *op,
const struct of_device_id *match)
>  			regs = &v5_config_registers;
>  		}
>  	}
> -	return hwicap_setup(&op->dev, id ? *id : -1, &res, config,
> -			regs);
> +
> +	return hwicap_setup(&pdev->dev, pdev->id, res,
> +			&buffer_icap_config, regs);
>  }
> 
> -static int __devexit hwicap_of_remove(struct platform_device *op)
> +static int __devexit hwicap_drv_remove(struct platform_device *pdev)
>  {
> -	return hwicap_remove(&op->dev);
> +	return hwicap_remove(&pdev->dev);
>  }
> 
> +#ifdef CONFIG_OF
>  /* Match table for of_platform binding */

Does the comment still make sense?

>  static const struct of_device_id __devinitconst hwicap_of_match[] = {
>  	{ .compatible = "xlnx,opb-hwicap-1.00.b", .data &buffer_icap_config},
> @@ -812,33 +802,23 @@ static const struct of_device_id __devinitconst
hwicap_of_match[] = {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, hwicap_of_match);
> +#else
> +#define hwicap_of_match NULL
> +#endif
> 
> -static struct of_platform_driver hwicap_of_driver = {
> -	.probe = hwicap_of_probe,
> -	.remove = __devexit_p(hwicap_of_remove),
> +static struct platform_driver hwicap_platform_driver = {
> +	.probe = hwicap_drv_probe,
> +	.remove = hwicap_drv_remove,
>  	.driver = {
> -		.name = DRIVER_NAME,
>  		.owner = THIS_MODULE,
> +		.name = DRIVER_NAME,
>  		.of_match_table = hwicap_of_match,
>  	},
>  };
> 
> -/* Registration helpers to keep the number of #ifdefs to a minimum */
> -static inline int __init hwicap_of_register(void)
> -{
> -	pr_debug("hwicap: calling of_register_platform_driver()\n");
> -	return of_register_platform_driver(&hwicap_of_driver);
> -}
> -
> -static inline void __exit hwicap_of_unregister(void)
> -{
> -	of_unregister_platform_driver(&hwicap_of_driver);
> -}
> -#else /* CONFIG_OF */
> -/* CONFIG_OF not enabled; do nothing helpers */
> -static inline int __init hwicap_of_register(void) { return 0; }
> -static inline void __exit hwicap_of_unregister(void) { }
> -#endif /* CONFIG_OF */
> +/*
---------------------------------------------------------------------
> + * OF bus binding
> + */
> 
>  static int __init hwicap_module_init(void)
>  {
> @@ -856,21 +836,12 @@ static int __init hwicap_module_init(void)
>  		return retval;
> 
>  	retval = platform_driver_register(&hwicap_platform_driver);
> -
> -	if (retval)
> -		goto failed1;
> -
> -	retval = hwicap_of_register();
> -
>  	if (retval)
> -		goto failed2;
> +		goto failed;
> 
>  	return retval;
> 
> - failed2:
> -	platform_driver_unregister(&hwicap_platform_driver);
> -
> - failed1:
> + failed:
>  	unregister_chrdev_region(devt, HWICAP_DEVICES);
> 
>  	return retval;
> @@ -884,8 +855,6 @@ static void __exit hwicap_module_cleanup(void)
> 
>  	platform_driver_unregister(&hwicap_platform_driver);
> 
> -	hwicap_of_unregister();
> -
>  	unregister_chrdev_region(devt, HWICAP_DEVICES);
>  }
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


