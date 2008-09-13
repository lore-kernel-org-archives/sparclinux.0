From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 02:31:30 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913023130.GA6708@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 12, 2008 at 06:42:48PM -0700, David Miller wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Fri, 12 Sep 2008 20:36:40 +0200
> 
> > Unloading the module also didn't work the same way... so I figured it might
> > be another unclean upgrade issue, so I rebooted it to see what happens when
> > I start from scratch - and then a much more serious problem arose: at the
> > point during the boot sequence when udev detected and loaded the modules,
> > the machine reproducibly crashes (tried it twice in a row).
> 
> Does this make things better?
> 
>  struct uart_port {
>  	spinlock_t		lock;			/* port lock */
> -	unsigned int		iobase;			/* in/out[bwl] */
> +	unsigned long		iobase;			/* in/out[bwl] */

Yay, that made it not crash, and more :)

Serial: 8250/16550 driver4 ports, IRQ sharing disabled
PCI: Enabling device: (0001:00:02.0), cmd 81
0001:00:02.0: ttyS0 at I/O 0x1000940 (irq = 19) is a 16550A
0001:00:02.0: ttyS1 at I/O 0x1000948 (irq = 19) is a 16550A

Thanks a bunch :) minicom isn't giving me anything useful, but that might
well be a cable issue :)

-- 
     2. That which causes joy or happiness.
