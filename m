From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 30 Mar 2017 09:56:03 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <1490867763.708.62.camel@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170329184431.6226-1-oliver@schinagl.nl>
In-Reply-To: <20170329184431.6226-1-oliver@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olliver Schinagl <oliver@schinagl.nl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "David S . Miller" <davem@davemloft.net>
Cc: dev@linux-sunxi.org, Ed Blake <ed.blake@imgtec.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Yegor Yefremov <yegorslists@googlemail.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, Jason Uy <jason.uy@broadcom.com>, Douglas Anderson <dianders@chromium.org>, Peter Hurley <peter@hurleysoftware.com>, Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, Thor Thayer <tthayer@opensource.altera.com>, David Lechner <david@lechnology.com>, Jan Kiszka <jan.kiszka@siemens.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, 2017-03-29 at 20:44 +0200, Olliver Schinagl wrote:
> It seems that at some point, someone made the assumption that the UART
> Interrupt ID Register was a bitfield and started to check if certain
> bits where set.
> 
> Actually however the register contains interrupt ID's where only the
> MSB
> seems to be used singular and the rest share at least one bit. Thus
> doing bitfield operations is wrong.
> 
> This patch cleans up the serial_reg include file by ordering it and
> replacing the UART_IIR_ID 'mask' with a proper mask for the register.
> The OMAP uart appears to have used the two commonly 'reserved' bits 4
> and 5 and thus get an UART_IIR_EXT_MASK for these two bits.
> 
> This patch then goes over all UART_IIR_* users and changes the code
> from
> bitfield checking, to ID checking instead.


Looking to implementation I would rather go with some helper like

int serial_in_IIR(port, [additional mask])
{
 return port->serial_in(port, UART_IIR) & (_IIR_MASK [| additional
mask]);
}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
