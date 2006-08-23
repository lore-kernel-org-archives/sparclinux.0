From: David Miller <davem@davemloft.net>
Date: Wed, 23 Aug 2006 22:48:42 +0000
Subject: Re: [PATCH] Fix E250 console with RSC
Message-Id: <20060823.154842.21595072.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
In-Reply-To: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marc Zyngier <maz@misterjones.org>
Date: Sat, 05 Aug 2006 10:59:12 +0200

> Dave, please consider applying.
> 
> 	M.
> 
> This patch fixes yet another sunsab problem, when console is set to
> anything but the first port. The console framework calls
> sunsab_console_setup for each port, and we end up setting up a console
> on a not yet discovered port, which leads to an Oops. Instead, defer
> console setup until the requested port is properly initialized. Tested
> on an E250 through an RSC console.
> 
> Reported by Daniel Smolik <marvin@mydatex.cz>
> 
> Signed-off-by: Marc Zyngier <maz@misterjones.org>

Thanks for figuring this out Marc.  I'll apply your patch,
and write a similar one for sunzilog which has the same
problem potentially.

This all comes from the fact that the UART layer assosciates
consoles with the driver instead of the individual ports.
In fact, the first thing serial_core.c does when you register
a port is go:

	port->cons = drv->cons;

which just makes this assosciation even more obviously illogical.

If, instead, the driver could set port->cons itself before the
uart_add_one_port() call, we could deal with this cleanly.

You will note that the 8250.c driver and others do similar
checks in their console setup method to work around this:

	if (!port->iobase && !port->membase)
		return -ENODEV;

Anyways, thanks again Marc.
