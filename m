From: Olliver Schinagl <o.schinagl@ultimaker.com>
Date: Fri, 31 Mar 2017 13:54:52 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <b962b00c-64d7-0b55-2fde-5a3ea04d8671@schinagl.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20170329184431.6226-1-oliver@schinagl.nl>
 <1490867763.708.62.camel@linux.intel.com>
In-Reply-To: <1490867763.708.62.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hey Andy,

On 30-03-17 11:56, Andy Shevchenko wrote:
> On Wed, 2017-03-29 at 20:44 +0200, Olliver Schinagl wrote:
>> It seems that at some point, someone made the assumption that the UART
>> Interrupt ID Register was a bitfield and started to check if certain
>> bits where set.
>>
>> Actually however the register contains interrupt ID's where only the
>> MSB
>> seems to be used singular and the rest share at least one bit. Thus
>> doing bitfield operations is wrong.
>>
>> This patch cleans up the serial_reg include file by ordering it and
>> replacing the UART_IIR_ID 'mask' with a proper mask for the register.
>> The OMAP uart appears to have used the two commonly 'reserved' bits 4
>> and 5 and thus get an UART_IIR_EXT_MASK for these two bits.
>>
>> This patch then goes over all UART_IIR_* users and changes the code
>> from
>> bitfield checking, to ID checking instead.
>
>
> Looking to implementation I would rather go with some helper like
>
> int serial_in_IIR(port, [additional mask])
> {
>  return port->serial_in(port, UART_IIR) & (_IIR_MASK [| additional
> mask]);
> }

As I just wrote a simply static inline helper function in serial_core.h, 
I just figured that the helper will only work for some of the calls. All 
interrupt checks in xxx_serial_in() obviously can't rely on this. So do 
you still want this helper function added for the other cases? Or have 
all implementations do the masking manually?

And then, is iir = serial_port_in(up, UART_IIR) & UART_IIR_MASK; 
preferred over splitting it over two lines, like I did?

Finally, why rename it to _IIR_MASK, I assume a typo here?

Olliver

>
