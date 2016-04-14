From: David Miller <davem@davemloft.net>
Date: Thu, 14 Apr 2016 01:52:58 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160413.215258.706543387484948942.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 01:22:37 +0200

> From 3515ad550f7b1db467664acc9bf0ed3d2aec9fdd Mon Sep 17 00:00:00 2001
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Thu, 14 Apr 2016 01:19:40 +0200
> Subject: [PATCH 2/2] sparc/kernel/vio.c: implement vio_hotplug and add it to
>  vio_bus_type
> 
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  arch/sparc/kernel/vio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index 5a9bb9d..59f4b7c 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -45,6 +45,13 @@ static const struct vio_device_id *vio_match_device(
>  	return NULL;
>  }
>  
> +static int vio_hotplug(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	const struct vio_dev *vio_dev = to_vio_dev(dev);
> +	add_uevent_var(env, "MODALIAS=vio:T%sS%s", vio_dev->type, vio_dev->compat);
> +	 return 0;

Extra space before "return 0" after the TAB.

Need an empty line after the local variable declarations.

