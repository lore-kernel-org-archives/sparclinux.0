Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028B3A6F15;
	Fri, 17 Apr 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421475; cv=none; b=EsgC7JmTZ2+G3WT7oNAT1ZyYdqAnsvkyQODdFQKUBu8fwmNegstLHh4zQZzWtzmSToDqe9M3WaobuGJ+IPJ01dGpElszoWK+e7RuIMXfEQCpk6onLX/bnxsh0tXvEe4ISq3gCUmTSThc1h2ZGcIi87cesVYU4JgVf14Jep7L6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421475; c=relaxed/simple;
	bh=pizWJrvuQ48cGLUkst8VVI51daUIasrR1V7+pSa+3gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G63c3GQt0gmi4mRBDaNgrZsaNCksRyy9bXnPlnHmmjEIGvjaTzIwiDHiL93yl5esu2AaFjuocZmP6x+UblESU2EBVur3HOoY9WfLM5pnWKVLVQ2IZWGE9SNJ21HROFHuCGK5J+v3XUSQ6rc4g5Z6FG/4EWEUhICCyYUtqePjl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1gqdm1+K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLWGHfzh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gqdm1+K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLWGHfzh"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776421464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMrkWwsRJJM8nf2vHkNwRnlQxiLbrNpUSyN/P1PXVuU=;
	b=1gqdm1+KQYmc0lEaKrij2m/6iN7QFvYv3SdOnrNnO3SQ1wiZPG7keCQDQS/EHzu7rYSJjx
	oJYIZYC7rWtTseO47NUH2BarudQdV3LxY/ouu2PE7mvadxv7BbskGH0GtJmDBgcQAELXRi
	HFIpXvcs+6U8+PB2JDCmJdgwf+vws3F84XiquOpqtoNZETiE2qZw87Acz6gOQtIDhxucuJ
	exTPPcqTcj9C8X2f1qI9P8rhoNnfCtu8i3OEose6YbeUN81e9u0xCAD4ncMqUDF31UIkJ8
	bHZ9sdkkeNVnWaMdQ0GBHltkPl17ml2MK76xbsc2OckN1+qgjvTzclWhDJnuXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776421464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMrkWwsRJJM8nf2vHkNwRnlQxiLbrNpUSyN/P1PXVuU=;
	b=fLWGHfzhqiorZuAalaeL38ZW4UB8KT8DPAXlcCpsSmhp/s5uf+e10bZ3MXAqW5jtletG/x
	EYf5LmNSdHizcLDQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH tty v3 2/6] serial: Replace driver usage of UPF_CONS_FLOW
Date: Fri, 17 Apr 2026 12:30:15 +0206
Message-ID: <20260417102423.40984-3-john.ogness@linutronix.de>
In-Reply-To: <20260417102423.40984-1-john.ogness@linutronix.de>
References: <20260417102423.40984-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using the UPF_CONS_FLOW bit of uart_port.flags to track
the user configuration of console flow control, use the newly added
uart_port.cons_flow (via its get/set functions).

A coccinelle script was used to perform the search/replace.

Note1: The sh-sci driver is blindly copying platform data
       configuration flags to uart_port.flags. Thus UPF_CONS_FLOW
       could get set. A follow-up commit will address this.

Note2: Aside from sh-sci, the samsung_tty driver is also using
       UPF_CONS_FLOW as a platform data configuration flag.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 drivers/tty/serial/bcm63xx_uart.c   | 2 +-
 drivers/tty/serial/omap-serial.c    | 2 +-
 drivers/tty/serial/pch_uart.c       | 2 +-
 drivers/tty/serial/pxa.c            | 2 +-
 drivers/tty/serial/samsung_tty.c    | 8 ++++----
 drivers/tty/serial/serial_txx9.c    | 4 ++--
 drivers/tty/serial/sunsu.c          | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index af78cc02f38e7..c91b0fa7111a7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1988,7 +1988,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 	wait_for_lsr(up, bits);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
+	if (uart_get_cons_flow(&up->port)) {
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
@@ -3351,7 +3351,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		 * it regardless of the CTS state. Therefore, only use fifo
 		 * if we don't use control flow.
 		 */
-		!(up->port.flags & UPF_CONS_FLOW);
+		!uart_get_cons_flow(&up->port);
 
 	if (likely(use_fifo))
 		serial8250_console_fifo_write(up, s, count);
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 51df9d2d8bfc5..be6777dfdc532 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -675,7 +675,7 @@ static void wait_for_xmitr(struct uart_port *port)
 	}
 
 	/* Wait up to 1s for flow control if necessary */
-	if (port->flags & UPF_CONS_FLOW) {
+	if (uart_get_cons_flow(port)) {
 		tmout = 1000000;
 		while (--tmout) {
 			unsigned int val;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0b85f47ff19e0..a9879bc655745 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1092,7 +1092,7 @@ static void __maybe_unused wait_for_xmitr(struct uart_omap_port *up)
 	} while (!uart_lsr_tx_empty(status));
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
+	if (uart_get_cons_flow(&up->port)) {
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6729d8e83c3c5..08cb9ff30506f 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1444,7 +1444,7 @@ static void wait_for_xmitr(struct eg20t_port *up, int bits)
 	}
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
+	if (uart_get_cons_flow(&up->port)) {
 		unsigned int tmout;
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = ioread8(up->membase + UART_MSR);
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index fea0255067ccd..80afa47f09880 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -573,7 +573,7 @@ static void wait_for_xmitr(struct uart_pxa_port *up)
 	} while (!uart_lsr_tx_empty(status));
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
+	if (uart_get_cons_flow(&up->port)) {
 		tmout = 1000000;
 		while (--tmout &&
 		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e27806bf2cf3e..f9b0dbded1f43 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -319,7 +319,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	ourport->tx_enabled = 0;
 	ourport->tx_in_progress = 0;
 
-	if (port->flags & UPF_CONS_FLOW)
+	if (uart_get_cons_flow(port))
 		s3c24xx_serial_rx_enable(port);
 
 	ourport->tx_mode = 0;
@@ -493,7 +493,7 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 
 	if (!ourport->tx_enabled) {
-		if (port->flags & UPF_CONS_FLOW)
+		if (uart_get_cons_flow(port))
 			s3c24xx_serial_rx_disable(port);
 
 		ourport->tx_enabled = 1;
@@ -781,7 +781,7 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 		uerstat = rd_regl(port, S3C2410_UERSTAT);
 		ch = rd_reg(port, S3C2410_URXH);
 
-		if (port->flags & UPF_CONS_FLOW) {
+		if (uart_get_cons_flow(port)) {
 			bool txe = s3c24xx_serial_txempty_nofifo(port);
 
 			if (ourport->rx_enabled) {
@@ -1830,7 +1830,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	if (cfg->uart_flags & UPF_CONS_FLOW) {
 		dev_dbg(port->dev, "enabling flow control\n");
-		port->flags |= UPF_CONS_FLOW;
+		uart_set_cons_flow(port, true);
 	}
 
 	/* sort our the physical and virtual addresses for each UART */
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 436a559234dfe..103f03c1fe748 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -422,7 +422,7 @@ static void wait_for_xmitr(struct uart_port *up)
 		udelay(1);
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->flags & UPF_CONS_FLOW) {
+	if (uart_get_cons_flow(up)) {
 		tmout = 1000000;
 		while (--tmout &&
 		       (sio_in(up, TXX9_SICISR) & TXX9_SICISR_CTSS))
@@ -857,7 +857,7 @@ serial_txx9_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Disable flow-control if enabled (and unnecessary)
 	 */
 	flcr = sio_in(up, TXX9_SIFLCR);
-	if (!(up->flags & UPF_CONS_FLOW) && (flcr & TXX9_SIFLCR_TES))
+	if (!uart_get_cons_flow(up) && (flcr & TXX9_SIFLCR_TES))
 		sio_out(up, TXX9_SIFLCR, flcr & ~TXX9_SIFLCR_TES);
 
 	uart_console_write(up, s, count, serial_txx9_console_putchar);
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6505a1930da9a..97019b5ec49e2 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1245,7 +1245,7 @@ static void wait_for_xmitr(struct uart_sunsu_port *up)
 	} while (!uart_lsr_tx_empty(status));
 
 	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
+	if (uart_get_cons_flow(&up->port)) {
 		tmout = 1000000;
 		while (--tmout &&
 		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
-- 
2.47.3

