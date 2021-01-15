From: Jiri Slaby <jirislaby@kernel.org>
Date: Fri, 15 Jan 2021 08:20:24 +0000
Subject: Re: [PATCH 2/3] tty: vcc: Drop unnecessary if block
Message-Id: <9a1c68fc-f3bf-79e7-e2ae-238059241e2f@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
 <20210114175718.137483-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210114175718.137483-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On 14. 01. 21, 18:57, Uwe Kleine-König wrote:
> If vcc_probe() succeeded dev_set_drvdata() is called with a non-NULL
> value, and if vcc_probe() failed vcc_remove() isn't called.
> 
> So there is no way dev_get_drvdata() can return NULL in vcc_remove() and
> the check can just go away.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vcc.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index 9ffd42e333b8..d9b0dc6deae9 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -681,9 +681,6 @@ static int vcc_remove(struct vio_dev *vdev)
>   {
>   	struct vcc_port *port = dev_get_drvdata(&vdev->dev);
>   
> -	if (!port)
> -		return -ENODEV;
> -
>   	del_timer_sync(&port->rx_timer);
>   	del_timer_sync(&port->tx_timer);
>   
> 


-- 
js
