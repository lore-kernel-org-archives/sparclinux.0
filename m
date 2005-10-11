From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Oct 2005 01:33:01 +0000
Subject: [PATCH]: Serial OOPS fix
Message-Id: <20051010.183301.110676579.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Sven, please give this patch a try.

These wakeup calls were not only wrong, they were never possibly
necessary.  Because:

1) If the UART was stopped, any necessary wakups were done by
   the UART layer.

2) If the circular buffer was emptied, we did the proper wakeup
   when we emptied the buffer.

And this bogus uart_write_wakeup() call is how we can end up
dereferencing a NULL tty pointer via uart_tasklet_action()
which is scheduled by uart_write_wakeup().

It seems both the sunsab and sunzilog drivers have this problem.
sunsu does the right thing, which is not surprising since it's
mostly a duplicate of the 8250 driver which tends to be well
tested :-)

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index e971156..ba9381f 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -274,7 +274,6 @@ static void transmit_chars(struct uart_s
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
 		up->interrupt_mask1 |= SAB82532_IMR1_XPR;
 		writeb(up->interrupt_mask1, &up->regs->w.imr1);
-		uart_write_wakeup(&up->port);
 		return;
 	}
 
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index d754457..7653d6c 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -517,10 +517,9 @@ static void sunzilog_transmit_chars(stru
 	if (up->port.info = NULL)
 		goto ack_tx_int;
 	xmit = &up->port.info->xmit;
-	if (uart_circ_empty(xmit)) {
-		uart_write_wakeup(&up->port);
+	if (uart_circ_empty(xmit))
 		goto ack_tx_int;
-	}
+
 	if (uart_tx_stopped(&up->port))
 		goto ack_tx_int;
 
