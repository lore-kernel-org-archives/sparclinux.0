From: David Miller <davem@davemloft.net>
Date: Tue, 18 Sep 2007 01:57:01 +0000
Subject: [PATCH]: Fix for several sunsab problems.
Message-Id: <20070917.185701.13769540.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Some folks (Meelis I think you were one) reported some
issues with serial console on sunsab sometimes hanging
or similar on bootup.

Al Viro found and fixed several bugs in this driver which
could definitely cause that behavior.  I include that patch
below and have pushed this onward to Linus's tree and
will also submit it to -stable as well.

From 9c5b34806c28195e4d0f2deaa41d8158ca5874e1 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 17 Sep 2007 16:47:07 -0700
Subject: [PATCH] [SUNSAB]: Fix several bugs.

	* don't register irq until ->startup() (and release in ->shutdown()).
That avoids oopsen with the current tree when interrupt comes before we'd
set up the data structures for ttyb.
	* handle console=ttyS... even when OBP talks to screen/keyboard
	* register irq handler for each port, let kernel/irq/handle.c
call it for both if needed.  Kills code duplication in sunsab_interrupt().
BTW, there'd been bitrot in it - ttya handling had stopped calling
check_status() on BRK (correctly), ttyb copy of that code had kept the
bogus call in that case.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/sunsab.c |  107 ++++++++++++++++++----------------------------
 1 files changed, 42 insertions(+), 65 deletions(-)

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index bca57bb..e348ba6 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -58,6 +58,7 @@ struct uart_sunsab_port {
 	unsigned char			interrupt_mask1;/* ISR1 masking		*/
 	unsigned char			pvr_dtr_bit;	/* Which PVR bit is DTR */
 	unsigned char			pvr_dsr_bit;	/* Which PVR bit is DSR */
+	unsigned int			gis_shift;
 	int				type;		/* SAB82532 version	*/
 
 	/* Setting configuration bits while the transmitter is active
@@ -305,13 +306,15 @@ static irqreturn_t sunsab_interrupt(int irq, void *dev_id)
 	struct tty_struct *tty;
 	union sab82532_irq_status status;
 	unsigned long flags;
+	unsigned char gis;
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	status.stat = 0;
-	if (readb(&up->regs->r.gis) & SAB82532_GIS_ISA0)
+	gis = readb(&up->regs->r.gis) >> up->gis_shift;
+	if (gis & 1)
 		status.sreg.isr0 = readb(&up->regs->r.isr0);
-	if (readb(&up->regs->r.gis) & SAB82532_GIS_ISA1)
+	if (gis & 2)
 		status.sreg.isr1 = readb(&up->regs->r.isr1);
 
 	tty = NULL;
@@ -327,35 +330,6 @@ static irqreturn_t sunsab_interrupt(int irq, void *dev_id)
 			transmit_chars(up, &status);
 	}
 
-	spin_unlock(&up->port.lock);
-
-	if (tty)
-		tty_flip_buffer_push(tty);
-
-	up++;
-
-	spin_lock(&up->port.lock);
-
-	status.stat = 0;
-	if (readb(&up->regs->r.gis) & SAB82532_GIS_ISB0)
-		status.sreg.isr0 = readb(&up->regs->r.isr0);
-	if (readb(&up->regs->r.gis) & SAB82532_GIS_ISB1)
-		status.sreg.isr1 = readb(&up->regs->r.isr1);
-
-	tty = NULL;
-	if (status.stat) {
-		if ((status.sreg.isr0 & (SAB82532_ISR0_TCD | SAB82532_ISR0_TIME |
-					 SAB82532_ISR0_RFO | SAB82532_ISR0_RPF)) ||
-		    (status.sreg.isr1 & SAB82532_ISR1_BRK))
-
-			tty = receive_chars(up, &status);
-		if ((status.sreg.isr0 & SAB82532_ISR0_CDSC) ||
-		    (status.sreg.isr1 & (SAB82532_ISR1_BRK | SAB82532_ISR1_CSC)))
-			check_status(up, &status);
-		if (status.sreg.isr1 & (SAB82532_ISR1_ALLS | SAB82532_ISR1_XPR))
-			transmit_chars(up, &status);
-	}
-
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	if (tty)
@@ -539,6 +513,10 @@ static int sunsab_startup(struct uart_port *port)
 	struct uart_sunsab_port *up = (struct uart_sunsab_port *) port;
 	unsigned long flags;
 	unsigned char tmp;
+	int err = request_irq(up->port.irq, sunsab_interrupt,
+			      IRQF_SHARED, "sab", up);
+	if (err)
+		return err;
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
@@ -641,6 +619,7 @@ static void sunsab_shutdown(struct uart_port *port)
 #endif
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	free_irq(up->port.irq, up);
 }
 
 /*
@@ -1008,9 +987,11 @@ static int __devinit sunsab_init_one(struct uart_sunsab_port *up,
 	if ((up->port.line & 0x1) = 0) {
 		up->pvr_dsr_bit = (1 << 0);
 		up->pvr_dtr_bit = (1 << 1);
+		up->gis_shift = 2;
 	} else {
 		up->pvr_dsr_bit = (1 << 3);
 		up->pvr_dtr_bit = (1 << 2);
+		up->gis_shift = 0;
 	}
 	up->cached_pvr = (1 << 1) | (1 << 2) | (1 << 4);
 	writeb(up->cached_pvr, &up->regs->w.pvr);
@@ -1023,19 +1004,6 @@ static int __devinit sunsab_init_one(struct uart_sunsab_port *up,
 	up->tec_timeout = SAB82532_MAX_TEC_TIMEOUT;
 	up->cec_timeout = SAB82532_MAX_CEC_TIMEOUT;
 
-	if (!(up->port.line & 0x01)) {
-		int err;
-
-		err = request_irq(up->port.irq, sunsab_interrupt,
-				  IRQF_SHARED, "sab", up);
-		if (err) {
-			of_iounmap(&op->resource[0],
-				   up->port.membase,
-				   sizeof(union sab82532_async_regs));
-			return err;
-		}
-	}
-
 	return 0;
 }
 
@@ -1051,52 +1019,60 @@ static int __devinit sab_probe(struct of_device *op, const struct of_device_id *
 			      0,
 			      (inst * 2) + 0);
 	if (err)
-		return err;
+		goto out;
 
 	err = sunsab_init_one(&up[1], op,
 			      sizeof(union sab82532_async_regs),
 			      (inst * 2) + 1);
-	if (err) {
-		of_iounmap(&op->resource[0],
-			   up[0].port.membase,
-			   sizeof(union sab82532_async_regs));
-		free_irq(up[0].port.irq, &up[0]);
-		return err;
-	}
+	if (err)
+		goto out1;
 
 	sunserial_console_match(SUNSAB_CONSOLE(), op->node,
 				&sunsab_reg, up[0].port.line);
-	uart_add_one_port(&sunsab_reg, &up[0].port);
 
 	sunserial_console_match(SUNSAB_CONSOLE(), op->node,
 				&sunsab_reg, up[1].port.line);
-	uart_add_one_port(&sunsab_reg, &up[1].port);
+
+	err = uart_add_one_port(&sunsab_reg, &up[0].port);
+	if (err)
+		goto out2;
+
+	err = uart_add_one_port(&sunsab_reg, &up[1].port);
+	if (err)
+		goto out3;
 
 	dev_set_drvdata(&op->dev, &up[0]);
 
 	inst++;
 
 	return 0;
-}
-
-static void __devexit sab_remove_one(struct uart_sunsab_port *up)
-{
-	struct of_device *op = to_of_device(up->port.dev);
 
-	uart_remove_one_port(&sunsab_reg, &up->port);
-	if (!(up->port.line & 1))
-		free_irq(up->port.irq, up);
+out3:
+	uart_remove_one_port(&sunsab_reg, &up[0].port);
+out2:
 	of_iounmap(&op->resource[0],
-		   up->port.membase,
+		   up[1].port.membase,
 		   sizeof(union sab82532_async_regs));
+out1:
+	of_iounmap(&op->resource[0],
+		   up[0].port.membase,
+		   sizeof(union sab82532_async_regs));
+out:
+	return err;
 }
 
 static int __devexit sab_remove(struct of_device *op)
 {
 	struct uart_sunsab_port *up = dev_get_drvdata(&op->dev);
 
-	sab_remove_one(&up[0]);
-	sab_remove_one(&up[1]);
+	uart_remove_one_port(&sunsab_reg, &up[1].port);
+	uart_remove_one_port(&sunsab_reg, &up[0].port);
+	of_iounmap(&op->resource[0],
+		   up[1].port.membase,
+		   sizeof(union sab82532_async_regs));
+	of_iounmap(&op->resource[0],
+		   up[0].port.membase,
+		   sizeof(union sab82532_async_regs));
 
 	dev_set_drvdata(&op->dev, NULL);
 
@@ -1143,6 +1119,7 @@ static int __init sunsab_init(void)
 
 		sunsab_reg.minor = sunserial_current_minor;
 		sunsab_reg.nr = num_channels;
+		sunsab_reg.cons = SUNSAB_CONSOLE();
 
 		err = uart_register_driver(&sunsab_reg);
 		if (err) {
-- 
1.5.2.4

