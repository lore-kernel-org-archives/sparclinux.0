From: David Miller <davem@davemloft.net>
Date: Fri, 10 Apr 2015 19:27:44 +0000
Subject: Re: [PATCH v4] sparc64: sunvdc: Complete I/O request if vdisk server error
Message-Id: <20150410.122744.470993642383869955.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <55281166.vYe5n4+08wPx4lmA%chris.hyser@oracle.com>
In-Reply-To: <55281166.vYe5n4+08wPx4lmA%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris.hyser@oracle.com
Date: Fri, 10 Apr 2015 14:07:34 -0400

> @@ -308,7 +308,12 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
>  
>  	rqe->req = NULL;
>  
> -	__blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
> +	if (desc->status) {
> +		if (printk_ratelimit())
> +			pr_err(PFX "VIO I/O Error %d\n", desc->status);

Please use pr_err_ratelimited().
