From: David Ahern <david.ahern@oracle.com>
Date: Mon, 30 Mar 2015 16:56:29 +0000
Subject: Re: [PATCH v3] sunvdc: Complete I/O request if vdisk server error
Message-Id: <5519803D.3070708@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <55197CB6.2020903@oracle.com>
In-Reply-To: <55197CB6.2020903@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/30/15 10:41 AM, chris hyser wrote:
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index 4b911ed..dad85fe 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -308,7 +308,11 @@ static void vdc_end_one(struct vdc_port *port,
> struct vio_dring_state *dr,
>
>       rqe->req = NULL;
>
> -    __blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
> +    if (desc->status) {
> +        pr_err(PFX "VIO I/O Error %d\n", desc->status);

printk_ratelimit()? i.e., any chance these can come out in a flood?


> +        __blk_end_request_all(req, -EIO);
> +    } else
> +        __blk_end_request(req, 0, desc->size);
>

