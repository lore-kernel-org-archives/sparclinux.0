From: Clemens Buchacher <drizzd@aon.at>
Date: Sun, 09 Jan 2005 09:36:18 +0000
Subject: Re: [7/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <20050109093618.GA25465@kzelldran.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <41DAE8CC.3010904@gaisler.com>
In-Reply-To: <41DAE8CC.3010904@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:04:44PM +0100, Jiri Gaisler wrote:
> +static irqreturn_t leonuart_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct uart_port *port = dev_id;
> +	unsigned int status;
> +
> +	spin_lock(port ->lock);

I think that should be

	spin_lock(&port->lock);

[...]
> +	spin_unlock(port ->lock);

and

	spin_unlock(&port->lock);

> +	return IRQ_HANDLED;
> +}

	Regards,
	Clemens
