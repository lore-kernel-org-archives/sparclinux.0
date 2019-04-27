From: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 27 Apr 2019 13:32:15 +0000
Subject: Re: [PATCH 10/41] drivers: tty: serial: sb1250-duart: fix missing parentheses
Message-Id: <20190427133215.GD11368@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-11-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-11-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-ia64@vger.kernel.org, lorenzo.pieralisi@arm.com, linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, khilman@baylibre.com, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Sat, Apr 27, 2019 at 02:51:51PM +0200, Enrico Weigelt, metux IT consult wrote:
> Fix checkpatch warning:
> 
>     ERROR: Macros with complex values should be enclosed in parentheses
>     #911: FILE: drivers/tty/serial/sb1250-duart.c:911:
>     +#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/tty/serial/sb1250-duart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
> index 1184226..ec74f09 100644
> --- a/drivers/tty/serial/sb1250-duart.c
> +++ b/drivers/tty/serial/sb1250-duart.c
> @@ -908,7 +908,7 @@ static int __init sbd_serial_console_init(void)
>  
>  console_initcall(sbd_serial_console_init);
>  
> -#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
> +#define SERIAL_SB1250_DUART_CONSOLE	(&sbd_console)

No, that's foolish.

checkpatch is a hint, it's not always right.

Also, checkpatch cleanups for really old drivers is not generally a good
idea, especially if you do not have the hardware for them.  Please don't
cause unneeded churn for this type of thing in this subsystem, unless
you have the hardware.

thanks,

greg k-h
