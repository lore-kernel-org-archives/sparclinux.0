From: David Miller <davem@davemloft.net>
Date: Thu, 14 Apr 2016 01:53:34 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160413.215334.1103572430212775156.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 01:22:37 +0200

> From 8d95bce6a35dc037d1e419896af19e12b3cda910 Mon Sep 17 00:00:00 2001
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Thu, 14 Apr 2016 01:16:14 +0200
> Subject: [PATCH 1/2] sparc/kernel/vio.c: implement modalias_show()
> 
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  arch/sparc/kernel/vio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
> index cb5789c..5a9bb9d 100644
> --- a/arch/sparc/kernel/vio.c
> +++ b/arch/sparc/kernel/vio.c
> @@ -105,6 +105,13 @@ static ssize_t type_show(struct device *dev,
>  	return sprintf(buf, "%s\n", vdev->type);
>  }
>  
> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> +                             char *buf)
> +{
> +	const struct vio_dev *vdev = to_vio_dev(dev);
> +	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
> +}
> +

You're not hooking this function up at all into the operations.  Looks like
you are mixing this patch up with other local changes.

And again, please, empty line after local variable declarations.

Thanks.
