From: David Miller <davem@davemloft.net>
Date: Tue, 16 Mar 2010 07:34:10 +0000
Subject: Re: [PATCH] drivers/serial/sunsab.c: adjust the constant used to
Message-Id: <20100316.003410.232587710.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1003121816500.3043@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003121816500.3043@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia@diku.dk
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, sparclinux@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Fri, 12 Mar 2010 18:17:13 +0100 (CET)

> From: Julia Lawall <julia@diku.dk>
> 
> SAB82532_ISR0_TCD is declared in drivers/serial/subsab.h as relating to a
> status register, while SAB82532_IMR0_TCD is declared in the same file as
> relating to a mask register.  The latter seems more appropriate for the
> interrupt_mask0 field, and follows the strategy for initializing this field
> elsewhere in the same file.
> 
> Both SAB82532_ISR0_TCD and SAB82532_IMR0_TCD have the same value.
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Applied, thanks Julia.

I'll add some entries to MAINTAINERS so that you know to
CC: sparclinux for these sparc serial drivers in the future.

> 
> ---
>  drivers/serial/sunsab.c             |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
> index d514e28..d2e0321 100644
> --- a/drivers/serial/sunsab.c
> +++ b/drivers/serial/sunsab.c
> @@ -474,7 +474,7 @@ static void sunsab_stop_rx(struct uart_port *port)
>  {
>  	struct uart_sunsab_port *up = (struct uart_sunsab_port *) port;
>  
> -	up->interrupt_mask0 |= SAB82532_ISR0_TCD;
> +	up->interrupt_mask0 |= SAB82532_IMR0_TCD;
>  	writeb(up->interrupt_mask1, &up->regs->w.imr0);
>  }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
