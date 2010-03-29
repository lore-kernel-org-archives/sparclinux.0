From: David Miller <davem@davemloft.net>
Date: Mon, 29 Mar 2010 02:06:53 +0000
Subject: Re: question about drivers/serial/sunsu.c
Message-Id: <20100328.190653.225555759.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1003281737590.29824@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003281737590.29824@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Sun, 28 Mar 2010 17:40:23 +0200 (CEST)

> The function su_probe in the file drivers/serial/sunsu.c contains the 
> code:
> 
> 	if (up->su_type = SU_PORT_KBD || up->su_type = SU_PORT_MS) {
> 		err = sunsu_kbd_ms_init(up);
> 	        if (err) {
>                         kfree(up);
>                         goto out_unmap;
> 		}
>                 dev_set_drvdata(&op->dev, up);
> 
> 		return 0;
> 	}
> 
> And then the label out_unmap contains:
> 
> out_unmap:
> 	of_iounmap(&op->resource[0], up->port.membase, up->reg_size);
> 	return err;
> 
> which represents a potential use of up after the free.  There are however 
> other gotos to out_unmap that don't seem to want to free up.  Should the 
> of_iounmap just be copied up before the kfree(up)?

This is a bug, but the fix is tricky.

Ports which are not keyboard or mice ports are statically
allocated from the sunsu_ports[] array, so we can't
unconditionally free 'up' at the out_unmap label.

So yes copying the of_iounmap() statement up to the keyboard/mouse
failure case and doing a straight return from there seems the
best way to handle this.
