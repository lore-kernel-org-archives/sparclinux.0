From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sun, 28 Apr 2019 15:21:03 +0000
Subject: Re: [PATCH 37/41] drivers: tty: serial: 8250: simplify io resource size computation
Message-Id: <20190428152103.GP9224@smile.fi.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-38-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-38-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Sat, Apr 27, 2019 at 02:52:18PM +0200, Enrico Weigelt, metux IT consult wrote:
> Simpily io resource size computation by setting mapsize field.
> 
> Some of the special cases handled by serial8250_port_size() can be
> simplified by putting this data to corresponding platform data
> or probe function.


> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -105,6 +105,7 @@ struct serial8250_config {
>  
>  #define SERIAL8250_PORT(_base, _irq) SERIAL8250_PORT_FLAGS(_base, _irq, 0)
>  

> +#define SERIAL_RT2880_IOSIZE	0x100

And why this is in the header file and not in corresponding C one?

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d09af4c..51d6076 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2833,11 +2833,7 @@ unsigned int serial8250_port_size(struct uart_8250_port *pt)
>  {
>  	if (pt->port.mapsize)
>  		return pt->port.mapsize;
> -	if (pt->port.iotype = UPIO_AU) {
> -		if (pt->port.type = PORT_RT2880)
> -			return 0x100;
> -		return 0x1000;
> -	}
> +
>  	if (is_omap1_8250(pt))
>  		return 0x16 << pt->port.regshift;

This is good. We definitely need to get rid of custom stuff in generic
8250_port, etc.

-- 
With Best Regards,
Andy Shevchenko
