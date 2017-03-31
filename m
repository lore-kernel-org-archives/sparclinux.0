From: Olliver Schinagl <o.schinagl@ultimaker.com>
Date: Fri, 31 Mar 2017 11:28:00 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <03bb0be7-3534-0f26-9f79-061282331186@schinagl.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20170329184431.6226-1-oliver@schinagl.nl>
 <6be65e8b-eea4-08ed-0b30-5c0608764a83@ti.com>
 <D694FA74-1F31-4B57-8858-2DBE8DE57D45@schinagl.nl>
 <20170330141153.mvxa6iqj72hnhlu3@thunk.org>
In-Reply-To: <20170330141153.mvxa6iqj72hnhlu3@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Theodore Ts'o <tytso@mit.edu>, Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "David S . Miller" <davem@davemloft.net>, "dev@linux-sunxi.org" <dev@linux-sunxi.org>, Ed Blake <ed.blake@imgtec.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Yegor Yefremov <yegorslists@googlemail.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, Jason Uy <jason.uy@broadcom.com>, Douglas Anderson <dianders@chromium.org>, Peter Hurley <peter@hurleysoftware.com>, Tony Lindgren <tony@atomide.com>, Thor Thayer <tthayer@opensource.altera.com>, David Lechner <david@lechnology.com>, Jan Kiszka <jan.kiszka@siemens.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>

Hey Ted,

On 30-03-17 16:11, Theodore Ts'o wrote:
> While you're fixing this, there's a bug in samples/vfio-mdev/mtty.c:
>
> 		u8 ier = mdev_state->s[index].uart_reg[UART_IER];
> 		*buf = 0;
>
> 		mutex_lock(&mdev_state->rxtx_lock);
> 		/* Interrupt priority 1: Parity, overrun, framing or break */
> 		if ((ier & UART_IER_RLSI) && mdev_state->s[index].overrun)
> 			*buf |= UART_IIR_RLSI;
>
> 		/* Interrupt priority 2: Fifo trigger level reached */
> 		if ((ier & UART_IER_RDI) &&
> 		    (mdev_state->s[index].rxtx.count =
> 		      mdev_state->s[index].intr_trigger_level))
> 			*buf |= UART_IIR_RDI;
>
> 		/* Interrupt priotiry 3: transmitter holding register empty */
> 		if ((ier & UART_IER_THRI) &&
> 		    (mdev_state->s[index].rxtx.head =
> 				mdev_state->s[index].rxtx.tail))
> 			*buf |= UART_IIR_THRI;
>
> 		/* Interrupt priotiry 4: Modem status: CTS, DSR, RI or DCD  */
> 		if ((ier & UART_IER_MSI) &&
> 		    (mdev_state->s[index].uart_reg[UART_MCR] &
> 				 (UART_MCR_RTS | UART_MCR_DTR)))
> 			*buf |= UART_IIR_MSI;
>
> 		/* bit0: 0=> interrupt pending, 1=> no interrupt is pending */
> 		if (*buf = 0)
> 			*buf = UART_IIR_NO_INT;
>
> It's treating the UART_IIR_* fields as a bitmask which is bad enough,
> but in the "Interrupt priority 4" case, UART_IIR_MSI is zero, so
> "*buf |= UART_IIR_MSI" is a no-op.   And in the case where the modem
> status interrupt is the only thing set, *buf will be 0, and UART_IIR_NO_INT
> gets set erroneously.
>
> So this is another example of the bug of trying to treat the
> UART_IIR_* fields as a bitmask....
>
> Yes, it's only sample code, but best fix it now before it gets copied
> elsewhere and metastisizes.   :-)

Yeah, I notice that a lot of the code I modified in this patch was 
either copy pasted or 'inspired by'. So having bad examples around is 
really bad as you state!

Additionally the friendly build bot reminded me there are other 
subsystems that do this as well, so I'll update the patch to get those 
too and this one too.

Olliver

>
> 							- Ted
> 							
>
