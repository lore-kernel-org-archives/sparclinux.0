From: Vignesh R <vigneshr@ti.com>
Date: Thu, 30 Mar 2017 06:27:29 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <6be65e8b-eea4-08ed-0b30-5c0608764a83@ti.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170329184431.6226-1-oliver@schinagl.nl>
In-Reply-To: <20170329184431.6226-1-oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: "dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org" <dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org>, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel

Hi,

On Thursday 30 March 2017 12:14 AM, Olliver Schinagl wrote:
> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> index 5db76880b4ad..489522389a10 100644
> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h
> @@ -31,18 +31,18 @@
>  #define UART_IERX_SLEEP		0x10 /* Enable sleep mode */
>  
>  #define UART_IIR	2	/* In:  Interrupt ID Register */
> -#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
> -#define UART_IIR_ID		0x0e /* Mask for the interrupt ID */
>  #define UART_IIR_MSI		0x00 /* Modem status interrupt */
> +#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
>  #define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
>  #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
>  #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
> -
>  #define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */
> +#define UART_IIR_RX_TIMEOUT	0x0c /* DesignWare RX Timeout interrupt */
> +#define UART_IIR_MASK		0x0f /* DesignWare IIR mask */
>  
> -#define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */

You are removing UART_IIR_RX_TIMEOUT? Is this intended?

>  #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
>  #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
> +#define UART_IIR_EXT_MASK	0x30 /* OMAP extended IIR mask */

-- 
Regards
Vignesh
