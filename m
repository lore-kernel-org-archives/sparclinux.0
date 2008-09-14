From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 18:24:41 +0000
Subject: Re: 16550 serial support
Message-Id: <20080914.112441.189846742.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 14 Sep 2008 13:12:40 +0200

> On Sat, Sep 13, 2008 at 09:31:52PM -0700, David Miller wrote:
> > @@ -2177,7 +2178,9 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
> >  	printk(KERN_INFO "%s%s%s%d at %s (irq = %d) is a %s\n",
> >  	       port->dev ? port->dev->bus_id : "",
> >  	       port->dev ? ": " : "",
> > -	       drv->dev_name, port->line, address, port->irq, uart_type(port));
> > +	       drv->dev_name,
> > +	       drv->tty_driver->name_base + port->line,
> > +	       address, port->irq, uart_type(port));
> >  }
> >  
> >  static void
> 
> BTW, while we're at it - since the data type of uart_port->iobase is larger
> now, the two snprintf()'s which print it out started complaining:
> 
> drivers/serial/serial_core.c: In function 'uart_report_port':
> drivers/serial/serial_core.c:2159: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
> drivers/serial/serial_core.c:2159: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
> drivers/serial/serial_core.c:2163: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
> drivers/serial/serial_core.c:2163: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
> 
> After the following trivial patch it goes quiet:

I already have that patch in my tree, but thanks anyways :)
