From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 05 Jan 2005 00:01:22 +0000
Subject: Re: [7/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <1104877702.17166.53.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <41DAE8CC.3010904@gaisler.com>
In-Reply-To: <41DAE8CC.3010904@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, wli@holomorphy.com

On Maw, 2005-01-04 at 19:04, Jiri Gaisler wrote:
> +            if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
> +			tty->flip.work.func((void *)tty);
> +			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
> +				printk(KERN_WARNING "TTY_DONT_FLIP set\n");
> +				return;
> +			}

This code is broken. Please copy the fixes from the other
drivers/serial/*.c files as you've copied a bug from the reference code.
There are some other small cleanups in the base code that are worth
adding too in particular removing direct (ab)use of tty->flip. because
that will be changing some time in the future (when I finish debugging
the tty layer mess)


