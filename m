From: "David S. Miller" <davem@redhat.com>
Date: Mon, 31 May 2004 02:36:04 +0000
Subject: Re: hme hang in SMP (was: 2.6.6 SMP on UE2 hangs consistently)
Message-Id: <20040530193604.752c2b88.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Actually, Meelis are you using serial console?  If so I bet this
fixes your problem:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/30 17:43:22-07:00 davem@nuts.davemloft.net 
#   [SPARC]: Do tty_flip_buffer_push outside of port lock.
# 
# drivers/serial/sunzilog.c
#   2004/05/30 17:43:04-07:00 davem@nuts.davemloft.net +16 -7
#   [SPARC]: Do tty_flip_buffer_push outside of port lock.
# 
# drivers/serial/sunsu.c
#   2004/05/30 17:43:04-07:00 davem@nuts.davemloft.net +16 -4
#   [SPARC]: Do tty_flip_buffer_push outside of port lock.
# 
# drivers/serial/sunsab.c
#   2004/05/30 17:43:04-07:00 davem@nuts.davemloft.net +19 -10
#   [SPARC]: Do tty_flip_buffer_push outside of port lock.
# 
diff -Nru a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
--- a/drivers/serial/sunsab.c	2004-05-30 19:35:14 -07:00
+++ b/drivers/serial/sunsab.c	2004-05-30 19:35:14 -07:00
@@ -97,9 +97,10 @@
 		udelay(1);
 }
 
-static void receive_chars(struct uart_sunsab_port *up,
-			  union sab82532_irq_status *stat,
-			  struct pt_regs *regs)
+static struct tty_struct *
+receive_chars(struct uart_sunsab_port *up,
+	      union sab82532_irq_status *stat,
+	      struct pt_regs *regs)
 {
 	struct tty_struct *tty = NULL;
 	unsigned char buf[32];
@@ -126,7 +127,7 @@
 	if (stat->sreg.isr0 & SAB82532_ISR0_TIME) {
 		sunsab_cec_wait(up);
 		writeb(SAB82532_CMDR_RFRD, &up->regs->w.cmdr);
-		return;
+		return tty;
 	}
 
 	if (stat->sreg.isr0 & SAB82532_ISR0_RFO)
@@ -153,7 +154,7 @@
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
 			tty->flip.work.func((void *)tty);
 			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-				return; // if TTY_DONT_FLIP is set
+				return tty; // if TTY_DONT_FLIP is set
 		}
 
 		*tty->flip.char_buf_ptr = ch;
@@ -225,11 +226,10 @@
 		}
 	}
 
-	if (tty)
-		tty_flip_buffer_push(tty);
-
 	if (saw_console_brk)
 		sun_do_break();
+
+	return tty;
 }
 
 static void sunsab_stop_tx(struct uart_port *, unsigned int);
@@ -311,6 +311,7 @@
 static irqreturn_t sunsab_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct uart_sunsab_port *up = dev_id;
+	struct tty_struct *tty;
 	union sab82532_irq_status status;
 	unsigned long flags;
 
@@ -322,10 +323,11 @@
 	if (readb(&up->regs->r.gis) & SAB82532_GIS_ISA1)
 		status.sreg.isr1 = readb(&up->regs->r.isr1);
 
+	tty = NULL;
 	if (status.stat) {
 		if (status.sreg.isr0 & (SAB82532_ISR0_TCD | SAB82532_ISR0_TIME |
 					SAB82532_ISR0_RFO | SAB82532_ISR0_RPF))
-			receive_chars(up, &status, regs);
+			tty = receive_chars(up, &status, regs);
 		if ((status.sreg.isr0 & SAB82532_ISR0_CDSC) ||
 		    (status.sreg.isr1 & SAB82532_ISR1_CSC))
 			check_status(up, &status);
@@ -335,6 +337,9 @@
 
 	spin_unlock(&up->port.lock);
 
+	if (tty)
+		tty_flip_buffer_push(tty);
+
 	up++;
 
 	spin_lock(&up->port.lock);
@@ -345,10 +350,11 @@
 	if (readb(&up->regs->r.gis) & SAB82532_GIS_ISB1)
 		status.sreg.isr1 = readb(&up->regs->r.isr1);
 
+	tty = NULL;
 	if (status.stat) {
 		if (status.sreg.isr0 & (SAB82532_ISR0_TCD | SAB82532_ISR0_TIME |
 					SAB82532_ISR0_RFO | SAB82532_ISR0_RPF))
-			receive_chars(up, &status, regs);
+			tty = receive_chars(up, &status, regs);
 		if ((status.sreg.isr0 & SAB82532_ISR0_CDSC) ||
 		    (status.sreg.isr1 & (SAB82532_ISR1_BRK | SAB82532_ISR1_CSC)))
 			check_status(up, &status);
@@ -357,6 +363,9 @@
 	}
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	if (tty)
+		tty_flip_buffer_push(tty);
 
 	return IRQ_HANDLED;
 }
diff -Nru a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
--- a/drivers/serial/sunsu.c	2004-05-30 19:35:14 -07:00
+++ b/drivers/serial/sunsu.c	2004-05-30 19:35:14 -07:00
@@ -310,7 +310,7 @@
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-static _INLINE_ void
+static _INLINE_ struct tty_struct *
 receive_chars(struct uart_sunsu_port *up, unsigned char *status, struct pt_regs *regs)
 {
 	struct tty_struct *tty = up->port.info->tty;
@@ -322,7 +322,7 @@
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
 			tty->flip.work.func((void *)tty);
 			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-				return; // if TTY_DONT_FLIP is set
+				return tty; // if TTY_DONT_FLIP is set
 		}
 		ch = serial_inp(up, UART_RX);
 		*tty->flip.char_buf_ptr = ch;
@@ -396,10 +396,11 @@
 	ignore_char:
 		*status = serial_inp(up, UART_LSR);
 	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
-	tty_flip_buffer_push(tty);
 
 	if (saw_console_brk)
 		sun_do_break();
+
+	return tty;
 }
 
 static _INLINE_ void transmit_chars(struct uart_sunsu_port *up)
@@ -464,12 +465,23 @@
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	do {
+		struct tty_struct *tty;
+
 		status = serial_inp(up, UART_LSR);
+		tty = NULL;
 		if (status & UART_LSR_DR)
-			receive_chars(up, &status, regs);
+			tty = receive_chars(up, &status, regs);
 		check_modem_status(up);
 		if (status & UART_LSR_THRE)
 			transmit_chars(up);
+
+		spin_unlock_irqrestore(&up->port.lock, flags);
+
+		if (tty)
+			tty_flip_buffer_push(tty);
+
+		spin_lock_irqsave(&up->port.lock, flags);
+
 	} while (!(serial_in(up, UART_IIR) & UART_IIR_NO_INT));
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
diff -Nru a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c	2004-05-30 19:35:14 -07:00
+++ b/drivers/serial/sunzilog.c	2004-05-30 19:35:14 -07:00
@@ -313,9 +313,10 @@
 	}
 }
 
-static void sunzilog_receive_chars(struct uart_sunzilog_port *up,
-				   struct zilog_channel *channel,
-				   struct pt_regs *regs)
+static struct tty_struct *
+sunzilog_receive_chars(struct uart_sunzilog_port *up,
+		       struct zilog_channel *channel,
+		       struct pt_regs *regs)
 {
 	struct tty_struct *tty;
 	unsigned char ch, r1;
@@ -414,8 +415,7 @@
 		}
 	}
 
-	if (tty)
-		tty_flip_buffer_push(tty);
+	return tty;
 }
 
 static void sunzilog_status_handle(struct uart_sunzilog_port *up,
@@ -550,19 +550,21 @@
 	while (up) {
 		struct zilog_channel *channel
 			= ZILOG_CHANNEL_FROM_PORT(&up->port);
+		struct tty_struct *tty;
 		unsigned char r3;
 
 		spin_lock(&up->port.lock);
 		r3 = read_zsreg(channel, R3);
 
 		/* Channel A */
+		tty = NULL;
 		if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
 			sbus_writeb(RES_H_IUS, &channel->control);
 			ZSDELAY();
 			ZS_WSYNC(channel);
 
 			if (r3 & CHARxIP)
-				sunzilog_receive_chars(up, channel, regs);
+				tty = sunzilog_receive_chars(up, channel, regs);
 			if (r3 & CHAEXT)
 				sunzilog_status_handle(up, channel, regs);
 			if (r3 & CHATxIP)
@@ -570,24 +572,31 @@
 		}
 		spin_unlock(&up->port.lock);
 
+		if (tty)
+			tty_flip_buffer_push(tty);
+
 		/* Channel B */
 		up = up->next;
 		channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 
 		spin_lock(&up->port.lock);
+		tty = NULL;
 		if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
 			sbus_writeb(RES_H_IUS, &channel->control);
 			ZSDELAY();
 			ZS_WSYNC(channel);
 
 			if (r3 & CHBRxIP)
-				sunzilog_receive_chars(up, channel, regs);
+				tty = sunzilog_receive_chars(up, channel, regs);
 			if (r3 & CHBEXT)
 				sunzilog_status_handle(up, channel, regs);
 			if (r3 & CHBTxIP)
 				sunzilog_transmit_chars(up, channel);
 		}
 		spin_unlock(&up->port.lock);
+
+		if (tty)
+			tty_flip_buffer_push(tty);
 
 		up = up->next;
 	}
