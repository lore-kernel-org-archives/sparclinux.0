From: David Miller <davem@davemloft.net>
Date: Thu, 12 Oct 2006 09:37:06 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <20061012.023706.115910793.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 11 Oct 2006 17:54:46 +0300 (EEST)

> >>>> Linux version 2.6.18-rc3 (mroos@mandariin) (gcc version 4.1.2 20060715 (prerelease) (Debian 4.1.1-9)) #137 Mon Jul 31 15:09:20o6
> >>>
> >>> Retry with gcc-4.0.x please.
> >>
> >> Same hang exactly.
> >
> > Thanks for testing, I'll look into it.
> 
> I have narrowed it down to a specific config option - 
> CONFIG_DEBUG_SPINLOCK. When I enable it, the hang occurs, and when I 
> disable it, everything works fine. Currently at 2.6.19-rc1 + git as of 
> yesterday.

I wonder if there is some problem with the spinlock debug
spin timeout.

Let's say that triggers while outputting a console message
over the serial console, that will just recurse into the
serial layer and deadlock.

We do take locks during console output in the sunsab console
implementation, and I'm pretty sure sunsab is which serial
line your console would be using on an ultra5 as the SU
ports are used for keyboard and mouse.

Actually, thinking about it some more I bet it's not a
spin lock debugging timeout.  What instead might trigger
a problem is spin_lock_init() being invoked a second time
on the UART port->lock while it is already held.

There is some tricky logic in the serial layer that tries
to deal with the fact that console setup can occur before
a UART port is registered.  It is trying to make sure
spin_lock_init(&port->lock) occurs before it could ever
be used.

In order to do that it explicitly initializes the lock in the console
setup (indirectly via uart_set_options). Actually, sunsab doesn't use
that helper function so sunsab's console setup function does the
spin_lock_init() explicitly.

Anyways, at UART port add time, the core serial layer does this:

	/*
	 * If this port is a console, then the spinlock is already
	 * initialised.
	 */
	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED))) {
		spin_lock_init(&port->lock);
		lockdep_set_class(&port->lock, &port_lock_key);
	}

in order to avoid initializing the spinlock twice.

But actually what will happen currently is the following:

1) sunsab will register the sunsab driver, fine
2) uart_add_one_port() will get called, since the console
   didn't get registered yet, CON_ENABLED bit won't bet
   set so uart_add_one_port() will initialize the spinlock
   with the spin_lock_init() call quoted above
3) later in uart_add_one_port() it will do this:
	if (port->type != PORT_UNKNOWN &&
	    port->cons && !(port->cons->flags & CON_ENABLED))
		register_console(port->cons);
   which will invoke sunsab_console_setup()
4) sunsab_console_setup() will initialize the port spinlock
   again

I wonder if that is what causes the problems.  Just for a test
can you retry with DEBUG_SPINLOCK enabled and the following
patch?  I'm not very optimistic actually, because this double
init should be harmless.

Thanks.

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index 08a7cd6..f21b187 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -916,11 +916,6 @@ static int sunsab_console_setup(struct c
 	};
 
 	/*
-	 * Temporary fix.
-	 */
-	spin_lock_init(&up->port.lock);
-
-	/*
 	 * Initialize the hardware
 	 */
 	sunsab_startup(&up->port);
