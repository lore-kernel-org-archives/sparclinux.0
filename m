From: Olliver Schinagl <oliver@schinagl.nl>
Date: Wed, 29 Mar 2017 18:44:31 +0000
Subject: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <20170329184431.6226-1-oliver@schinagl.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>

It seems that at some point, someone made the assumption that the UART
Interrupt ID Register was a bitfield and started to check if certain
bits where set.

Actually however the register contains interrupt ID's where only the MSB
seems to be used singular and the rest share at least one bit. Thus
doing bitfield operations is wrong.

This patch cleans up the serial_reg include file by ordering it and
replacing the UART_IIR_ID 'mask' with a proper mask for the register.
The OMAP uart appears to have used the two commonly 'reserved' bits 4
and 5 and thus get an UART_IIR_EXT_MASK for these two bits.

This patch then goes over all UART_IIR_* users and changes the code from
bitfield checking, to ID checking instead.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---

Note, that I do not have all this hardware and used the fact that UART_IIR_*
yields ID's rather then bitfields and thus mentioned as above, cannot be
bit-checked. Please carefully look at the changes, as they do make sense to me
a slip up is quickly made. Additionally, note the old code worked probably 100%
of the time, but was written wrong I think.

If I was wrong, I do apologize for the noise.

 drivers/tty/serial/8250/8250_core.c |  8 +++++---
 drivers/tty/serial/8250/8250_dw.c   |  5 +++--
 drivers/tty/serial/8250/8250_fsl.c  |  3 ++-
 drivers/tty/serial/8250/8250_omap.c |  4 ++--
 drivers/tty/serial/8250/8250_port.c | 11 ++++++-----
 drivers/tty/serial/omap-serial.c    | 12 ++++++------
 drivers/tty/serial/pxa.c            |  2 +-
 drivers/tty/serial/serial-tegra.c   |  3 ++-
 drivers/tty/serial/sunsu.c          |  2 +-
 drivers/tty/serial/vr41xx_siu.c     |  2 +-
 include/uapi/linux/serial_reg.h     |  8 ++++----
 11 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 76e03a7de9cc..11b4e3fb0c1d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -288,6 +288,7 @@ static void serial8250_backup_timeout(unsigned long data)
 	}
 
 	iir = serial_in(up, UART_IIR);
+	iir &= UART_IIR_MASK;
 
 	/*
 	 * This should be a safe test for anyone who doesn't trust the
@@ -297,14 +298,15 @@ static void serial8250_backup_timeout(unsigned long data)
 	 */
 	lsr = serial_in(up, UART_LSR);
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
+	if ((iir = UART_IIR_NO_INT) &&
+	    (up->ier & UART_IER_THRI) &&
 	    (!uart_circ_empty(&up->port.state->xmit) || up->port.x_char) &&
 	    (lsr & UART_LSR_THRE)) {
-		iir &= ~(UART_IIR_ID | UART_IIR_NO_INT);
+		iir &= ~(UART_IIR_MASK);
 		iir |= UART_IIR_THRI;
 	}
 
-	if (!(iir & UART_IIR_NO_INT))
+	if (iir != UART_IIR_NO_INT)
 		serial8250_tx_chars(up);
 
 	if (up->port.irq)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 56aded887771..90cf0e6b4c5b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -218,7 +218,8 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * This problem has only been observed so far when not in DMA mode
 	 * so we limit the workaround only to non-DMA mode.
 	 */
-	if (!up->dma && ((iir & 0x3f) = UART_IIR_RX_TIMEOUT)) {
+	iir &= UART_IIR_MASK;
+	if (!up->dma && (iir = UART_IIR_RX_TIMEOUT)) {
 		spin_lock_irqsave(&p->lock, flags);
 		status = p->serial_in(p, UART_LSR);
 
@@ -231,7 +232,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	if (serial8250_handle_irq(p, iir))
 		return 1;
 
-	if ((iir & UART_IIR_BUSY) = UART_IIR_BUSY) {
+	if (iir = UART_IIR_BUSY) {
 		/* Clear the USR */
 		(void)p->serial_in(p, d->usr_reg);
 
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 910bfee5a88b..b866343bb485 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -33,7 +33,8 @@ int fsl8250_handle_irq(struct uart_port *port)
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	iir = port->serial_in(port, UART_IIR);
-	if (iir & UART_IIR_NO_INT) {
+	iir &= UART_IIR_MASK;
+	if (iir = UART_IIR_NO_INT) {
 		spin_unlock_irqrestore(&up->port.lock, flags);
 		return 0;
 	}
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index e7e64913a748..ab7c2327d410 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -996,7 +996,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 
 static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 {
-	switch (iir & 0x3f) {
+	switch (iir & (UART_IIR_MASK | UART_IIR_EXT_MASK)) {
 	case UART_IIR_RLSI:
 	case UART_IIR_RX_TIMEOUT:
 	case UART_IIR_RDI:
@@ -1021,7 +1021,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 	serial8250_rpm_get(up);
 
 	iir = serial_port_in(port, UART_IIR);
-	if (iir & UART_IIR_NO_INT) {
+	if ((iir & UART_IIR_MASK) = UART_IIR_NO_INT) {
 		serial8250_rpm_put(up);
 		return 0;
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6119516ef5fc..8ee3204d63ba 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1806,7 +1806,7 @@ EXPORT_SYMBOL_GPL(serial8250_modem_status);
 
 static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 {
-	switch (iir & 0x3f) {
+	switch (iir & UART_IIR_MASK) {
 	case UART_IIR_RX_TIMEOUT:
 		serial8250_rx_dma_flush(up);
 		/* fall-through */
@@ -1825,7 +1825,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
 
-	if (iir & UART_IIR_NO_INT)
+	if ((iir & UART_IIR_MASK) = UART_IIR_NO_INT)
 		return 0;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -1896,7 +1896,7 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 	unsigned int iir = serial_port_in(port, UART_IIR);
 
 	/* TX Threshold IRQ triggered so load up FIFO */
-	if ((iir & UART_IIR_ID) = UART_IIR_THRI) {
+	if ((iir & UART_IIR_MASK) = UART_IIR_THRI) {
 		struct uart_8250_port *up = up_to_u8250p(port);
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -2262,7 +2262,8 @@ int serial8250_do_startup(struct uart_port *port)
 		 * don't trust the iir, setup a timer to kick the UART
 		 * on a regular basis.
 		 */
-		if ((!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) ||
+		if ((((iir1 & UART_IIR_MASK) != UART_IIR_NO_INT) &&
+		     ((iir & UART_IIR_MASK) = UART_IIR_NO_INT)) ||
 		    up->port.flags & UPF_BUG_THRE) {
 			up->bugs |= UART_BUG_THRE;
 		}
@@ -2313,7 +2314,7 @@ int serial8250_do_startup(struct uart_port *port)
 	iir = serial_port_in(port, UART_IIR);
 	serial_port_out(port, UART_IER, 0);
 
-	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
+	if (lsr & UART_LSR_TEMT && ((iir & UART_IIR_MASK) = UART_IIR_NO_INT)) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
 			up->bugs |= UART_BUG_TXEN;
 			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6c6f82ad8d5c..4e7269b8bf1b 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -569,7 +569,6 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 {
 	struct uart_omap_port *up = dev_id;
 	unsigned int iir, lsr;
-	unsigned int type;
 	irqreturn_t ret = IRQ_NONE;
 	int max_count = 256;
 
@@ -578,16 +577,15 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 
 	do {
 		iir = serial_in(up, UART_IIR);
-		if (iir & UART_IIR_NO_INT)
+		iir &= (UART_IIR_MASK | UART_IIR_EXT_MASK);
+		if (iir = UART_IIR_NO_INT)
 			break;
 
 		ret = IRQ_HANDLED;
 		lsr = serial_in(up, UART_LSR);
 
 		/* extract IRQ type from IIR register */
-		type = iir & 0x3e;
-
-		switch (type) {
+		switch (iir) {
 		case UART_IIR_MSI:
 			check_modem_status(up);
 			break;
@@ -607,10 +605,12 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 			break;
 		case UART_IIR_XOFF:
 			/* FALLTHROUGH */
+		case UART_IIR_BUSY:
+			/* FALLTHROUGH */
 		default:
 			break;
 		}
-	} while (!(iir & UART_IIR_NO_INT) && max_count--);
+	} while ((iir != UART_IIR_NO_INT) && max_count--);
 
 	spin_unlock(&up->port.lock);
 
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 905631df1f8b..37cb17a11b34 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -253,7 +253,7 @@ static inline irqreturn_t serial_pxa_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 
 	iir = serial_in(up, UART_IIR);
-	if (iir & UART_IIR_NO_INT)
+	if ((iir & UART_IIR_MASK) = UART_IIR_NO_INT)
 		return IRQ_NONE;
 	spin_lock(&up->port.lock);
 	lsr = serial_in(up, UART_LSR);
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d92a150c8733..4a084161d1d2 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -691,7 +691,8 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 	spin_lock_irqsave(&u->lock, flags);
 	while (1) {
 		iir = tegra_uart_read(tup, UART_IIR);
-		if (iir & UART_IIR_NO_INT) {
+		iir &= UART_IIR_MASK;
+		if (iir = UART_IIR_NO_INT) {
 			if (is_rx_int) {
 				tegra_uart_handle_rx_dma(tup);
 				if (tup->rx_in_progress) {
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 72df2e1b88af..74e195d4d17e 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -475,7 +475,7 @@ static irqreturn_t sunsu_serial_interrupt(int irq, void *dev_id)
 
 		spin_lock_irqsave(&up->port.lock, flags);
 
-	} while (!(serial_in(up, UART_IIR) & UART_IIR_NO_INT));
+	} while ((serial_in(up, UART_IIR) & UART_IIR_MASK) != UART_IIR_NO_INT);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 439057e8107a..fc3b9bd920e9 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -429,7 +429,7 @@ static irqreturn_t siu_interrupt(int irq, void *dev_id)
 	port = (struct uart_port *)dev_id;
 
 	iir = siu_read(port, UART_IIR);
-	if (iir & UART_IIR_NO_INT)
+	if ((iir & UART_IIR_MASK) = UART_IIR_NO_INT)
 		return IRQ_NONE;
 
 	lsr = siu_read(port, UART_LSR);
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 5db76880b4ad..489522389a10 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -31,18 +31,18 @@
 #define UART_IERX_SLEEP		0x10 /* Enable sleep mode */
 
 #define UART_IIR	2	/* In:  Interrupt ID Register */
-#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
-#define UART_IIR_ID		0x0e /* Mask for the interrupt ID */
 #define UART_IIR_MSI		0x00 /* Modem status interrupt */
+#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
 #define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
 #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
 #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
-
 #define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */
+#define UART_IIR_RX_TIMEOUT	0x0c /* DesignWare RX Timeout interrupt */
+#define UART_IIR_MASK		0x0f /* DesignWare IIR mask */
 
-#define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
 #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
 #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
+#define UART_IIR_EXT_MASK	0x30 /* OMAP extended IIR mask */
 
 #define UART_FCR	2	/* Out: FIFO Control Register */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
-- 
2.11.0

