From: Ben Collins <bcollins@debian.org>
Date: Fri, 23 Jan 2004 15:32:20 +0000
Subject: Re: 2.6.2-rc1 smp crash
Message-Id: <20040123153220.GL27566@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040123134628.GH27566@phunnypharm.org>
In-Reply-To: <20040123134628.GH27566@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Give the attached patch a try. Seems sunzilog was pulling down some
spinlocks that the serial_core was already doing.

I think there may be one other issue, but I know this patch is atleast
correct.

=== drivers/serial/sunzilog.c 1.39 vs edited ==--- 1.39/drivers/serial/sunzilog.c	Mon Jan  5 14:23:35 2004
+++ edited/drivers/serial/sunzilog.c	Fri Jan 23 11:37:23 2004
@@ -723,36 +723,28 @@
 	}
 }
 
-/* The port lock is not held.  */
+/* The port lock is held.  */
 static void sunzilog_stop_rx(struct uart_port *port)
 {
 	struct uart_sunzilog_port *up = UART_ZILOG(port);
 	struct zilog_channel *channel;
-	unsigned long flags;
 
 	if (ZS_IS_CONS(up))
 		return;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
 
 	/* Disable all RX interrupts.  */
 	up->curregs[R1] &= ~RxINT_MASK;
 	sunzilog_maybe_update_regs(up, channel);
-
-	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-/* The port lock is not held.  */
+/* The port lock is held.  */
 static void sunzilog_enable_ms(struct uart_port *port)
 {
 	struct uart_sunzilog_port *up = (struct uart_sunzilog_port *) port;
 	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	unsigned char new_reg;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->lock, flags);
 
 	new_reg = up->curregs[R15] | (DCDIE | SYNCIE | CTSIE);
 	if (new_reg != up->curregs[R15]) {
@@ -761,8 +753,6 @@
 		/* NOTE: Not subject to 'transmitter active' rule.  */ 
 		write_zsreg(channel, R15, up->curregs[R15]);
 	}
-
-	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 /* The port lock is not held.  */

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
