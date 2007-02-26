From: David Miller <davem@davemloft.net>
Date: Mon, 26 Feb 2007 17:44:50 +0000
Subject: Re: [PATCH 3/3] SPARC: Handle request_irq() failure
Message-Id: <20070226.094450.39157931.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87y7mkq4so.fsf@sw.ru>
In-Reply-To: <87y7mkq4so.fsf@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dmonakhov@openvz.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, devel@openvz.org

From: Monakhov Dmitriy <dmonakhov@openvz.org>
Date: Mon, 26 Feb 2007 19:09:27 +0300

> Signed-off-by: Monakhov Dmitriy <dmonakhov@openvz.org>
 ...
> @@ -389,7 +390,12 @@ static int __init ts102_uctrl_init(void)
>  	if(!driver->irq) 
>  		driver->irq = tmp_irq[0].pri;
>  
> -	request_irq(driver->irq, uctrl_interrupt, 0, "uctrl", driver);
> +	err = request_irq(driver->irq, uctrl_interrupt, 0, "uctrl", driver);
> +	if (err) {
> +		printk(KERN_ERR "%s: unable to request irq  %d\n",
> +				__FUNCTION__, driver->irq);
> +		return -EBUSY;
> +	}
>  

Why not return the error code that request_irq() gave us?

That's how I'll fix this bug.
