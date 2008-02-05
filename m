From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 05 Feb 2008 00:19:49 +0000
Subject: Re: [PATCH 2/4] Create and hook up of_platform_device_shutdown
Message-Id: <1202170789.7079.26.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1201240265.git.michael@ellerman.id.au>
	<bf48a30aa9f58fa6e153f679eb0eb6a4864ebdc3.1201240265.git.michael@ellerman.id.au>
In-Reply-To: <bf48a30aa9f58fa6e153f679eb0eb6a4864ebdc3.1201240265.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <michael@ellerman.id.au>
Cc: tnt@246tNt.com, davem@davemloft.net, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, cbe-oss-dev@ozlabs.org, m8@semihalf.com


On Fri, 2008-01-25 at 16:59 +1100, Michael Ellerman wrote:
> Although of_platform_device's can have a shutdown routine, at the moment
> the bus code doesn't actually call it. So add the required glue to
> hook the shutdown routine.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/of/platform.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> 
> CC various folks who've written/touched of_platform_drivers which already
> have shutdown routines. These routines have never been called so they're
> about to get their first testing.
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b47bb2d..ca09a63 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -85,6 +85,15 @@ static int of_platform_device_resume(struct device * dev)
>  	return error;
>  }
>  
> +static void of_platform_device_shutdown(struct device *dev)
> +{
> +	struct of_device *of_dev = to_of_device(dev);
> +	struct of_platform_driver *drv = to_of_platform_driver(dev->driver);
> +
> +	if (dev->driver && drv->shutdown)
> +		drv->shutdown(of_dev);
> +}
> +
>  int of_bus_type_init(struct bus_type *bus, const char *name)
>  {
>  	bus->name = name;
> @@ -93,6 +102,7 @@ int of_bus_type_init(struct bus_type *bus, const char *name)
>  	bus->remove = of_platform_device_remove;
>  	bus->suspend = of_platform_device_suspend;
>  	bus->resume = of_platform_device_resume;
> +	bus->shutdown = of_platform_device_shutdown;
>  	return bus_register(bus);
>  }
>  

