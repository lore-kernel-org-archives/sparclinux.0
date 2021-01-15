From: Jiri Slaby <jirislaby@kernel.org>
Date: Fri, 15 Jan 2021 08:19:55 +0000
Subject: Re: [PATCH 1/3] tty: hvcs: Drop unnecessary if block
Message-Id: <1afca17b-f148-4412-c80f-6168e79fd2ac@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
 <20210114175718.137483-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210114175718.137483-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On 14. 01. 21, 18:57, Uwe Kleine-König wrote:
> If hvcs_probe() succeeded dev_set_drvdata() is called with a non-NULL
> value, and if hvcs_probe() failed hvcs_remove() isn't called.
> 
> So there is no way dev_get_drvdata() can return NULL in hvcs_remove() and
> the check can just go away.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/hvc/hvcs.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 509d1042825a..3e0461285c34 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -825,9 +825,6 @@ static int hvcs_remove(struct vio_dev *dev)
>   	unsigned long flags;
>   	struct tty_struct *tty;
>   
> -	if (!hvcsd)
> -		return -ENODEV;
> -
>   	/* By this time the vty-server won't be getting any more interrupts */
>   
>   	spin_lock_irqsave(&hvcsd->lock, flags);
> 


-- 
js
