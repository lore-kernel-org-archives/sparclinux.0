From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 04:31:52 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913.213152.41376145.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 19:49:45 +0200

> PCI: Enabling device: (0001:00:03.0), cmd 81
> 0001:00:03.0: ttyS2 at I/O 0x10009a0 (irq = 20) is a 16550A
> 0001:00:03.0: ttyS3 at I/O 0x10009a8 (irq = 20) is a 16550A
> PCI: Enabling device: (0001:00:02.0), cmd 3
> 0001:00:02.0: ttyS0 at I/O 0x1000930 (irq = 19) is a 16C950/954
> 0001:00:02.0: ttyS1 at I/O 0x1000938 (irq = 19) is a 16C950/954

I see what's happening, uart_report_port() assumes a direct
relationship between port->line and the ttyXXX device indexes.
But that isn't true in situations where the device major's
minor number space is shared between differnt drivers.

The reporting is just wrong, these devices are using ttyS2,
ttyS3, ttyS4, and ttyS5.

This patch should fix most cases.

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index dac80fd..7c35354 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -57,6 +57,13 @@ static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 
 static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
 
+static struct uart_driver serial8250_reg;
+
+static int serial_index(struct uart_port *port)
+{
+	return (serial8250_reg.minor - 64) + port->line;
+}
+
 /*
  * Debugging.
  */
@@ -997,7 +1004,7 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 		return;
 
 	DEBUG_AUTOCONF("ttyS%d: autoconf (0x%04x, 0x%p): ",
-			up->port.line, up->port.iobase, up->port.membase);
+		       serial_index(&up->port), up->port.iobase, up->port.membase);
 
 	/*
 	 * We really do need global IRQs disabled here - we're going to
@@ -1132,8 +1139,8 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	if (up->capabilities != uart_config[up->port.type].flags) {
 		printk(KERN_WARNING
 		       "ttyS%d: detected caps %08x should be %08x\n",
-			up->port.line, up->capabilities,
-			uart_config[up->port.type].flags);
+		       serial_index(&up->port), up->capabilities,
+		       uart_config[up->port.type].flags);
 	}
 
 	up->port.fifosize = uart_config[up->port.type].fifo_size;
@@ -1858,7 +1865,8 @@ static int serial8250_startup(struct uart_port *port)
 	 */
 	if (!(up->port.flags & UPF_BUGGY_UART) &&
 	    (serial_inp(up, UART_LSR) = 0xff)) {
-		printk("ttyS%d: LSR safety check engaged!\n", up->port.line);
+		printk("ttyS%d: LSR safety check engaged!\n",
+		       serial_index(&up->port));
 		return -ENODEV;
 	}
 
@@ -1912,7 +1920,8 @@ static int serial8250_startup(struct uart_port *port)
 		 * kick the UART on a regular basis.
 		 */
 		if (!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) {
-			pr_debug("ttyS%d - using backup timer\n", port->line);
+			pr_debug("ttyS%d - using backup timer\n",
+				 serial_index(port));
 			up->timer.function = serial8250_backup_timeout;
 			up->timer.data = (unsigned long)up;
 			mod_timer(&up->timer, jiffies +
@@ -1965,7 +1974,7 @@ static int serial8250_startup(struct uart_port *port)
 		if (!(up->bugs & UART_BUG_TXEN)) {
 			up->bugs |= UART_BUG_TXEN;
 			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
-				 port->line);
+				 serial_index(port));
 		}
 	} else {
 		up->bugs &= ~UART_BUG_TXEN;
@@ -2626,7 +2635,6 @@ static int serial8250_console_early_setup(void)
 	return serial8250_find_port_for_earlycon();
 }
 
-static struct uart_driver serial8250_reg;
 static struct console serial8250_console = {
 	.name		= "ttyS",
 	.write		= serial8250_console_write,
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index f977c98..760a0ec 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2051,7 +2051,8 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *port)
 					"transmitter\n",
 			       port->dev ? port->dev->bus_id : "",
 			       port->dev ? ": " : "",
-			       drv->dev_name, port->line);
+			       drv->dev_name,
+			       drv->tty_driver->name_base + port->line);
 
 		ops->shutdown(port);
 	}
@@ -2177,7 +2178,9 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 	printk(KERN_INFO "%s%s%s%d at %s (irq = %d) is a %s\n",
 	       port->dev ? port->dev->bus_id : "",
 	       port->dev ? ": " : "",
-	       drv->dev_name, port->line, address, port->irq, uart_type(port));
+	       drv->dev_name,
+	       drv->tty_driver->name_base + port->line,
+	       address, port->irq, uart_type(port));
 }
 
 static void


