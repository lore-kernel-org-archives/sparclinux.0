Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130720E701;
	Thu, 20 Feb 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050210; cv=none; b=o8vetRAfgamaQvrK/WhzL9EMKLIOwZwm4tIgwSyVAF6YFWLRfvefbLCQKRjxhVQgVqrCjR1WTfRvva2j5hqXO9gUj/R1X/d7v78HOSZplzfw/WNEnsNQX1z8rB1//rgH7etfAQwcsuKScz9I0Uao0vNotQG8xmNR/ezSxhuFkoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050210; c=relaxed/simple;
	bh=xF2pboVZNt+td4+Dy01LGUHcPKXBqMj/gvCymMZ6Lbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+o0Dg1tCYrnB+6gZwMVNBN/aBaWEOJ+voAR6OdREGy4XaV/ydcgRBUn33cToq/uZx1MO96W8wuEEeEaGgHOLeCYJ1CGhmHTTub/DVpXNBQphSyk19PGOjc6ivSaN42bsfhW+IX743cwsrnFcqUDN04KIYFMnIXXQKAG3IVnvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTlIDxRQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTlIDxRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD11C4CED1;
	Thu, 20 Feb 2025 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050209;
	bh=xF2pboVZNt+td4+Dy01LGUHcPKXBqMj/gvCymMZ6Lbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTlIDxRQ+nXhqKrHK6FcyCgcZzydM2ABBx5hYQCuCdNHvUBXho3nG44lSS/PAc6O4
	 /0K355s/vcMWjbMKBoCpYfbFXJthIycSQZ9nbHv1fvgqUXkL8ekxdHq7TltjiP35JI
	 vAf55tA7SCYiN1rNkyzCkPsJmx/TKdN5fSTKCtbukqq7YSuQFns5zukn9KKTK1u1nk
	 X+37EE+akZ+4vLKHOnMpkAdHI5IVKkS/sV9aQzMQpa/56V7eKjoypCQ3cuDDBs8kZn
	 iCo0kgv71xdP/EMwYsD59NSwgUtVwbwHGguodZWf8kBDVXcd8oRqZVVUJSIuSQdFDH
	 zfpwAfXxoUwkw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: [PATCH 22/29] tty: sunsu: drop serial_{in,out}p()
Date: Thu, 20 Feb 2025 12:15:59 +0100
Message-ID: <20250220111606.138045-23-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are simple wrappers around serial_{in/out}() without actually
pausing the execution. Since ever. So drop these useless wrappers.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/tty/serial/sunsu.c | 164 +++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 87 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 7f0fef07e141..2dc68b3201a4 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -150,16 +150,6 @@ static void serial_out(struct uart_sunsu_port *up, int offset, int value)
 	}
 }
 
-/*
- * We used to support using pause I/O for certain machines.  We
- * haven't supported this for a while, but just in case it's badly
- * needed for certain old 386 machines, I've left these #define's
- * in....
- */
-#define serial_inp(up, offset)		serial_in(up, offset)
-#define serial_outp(up, offset, value)	serial_out(up, offset, value)
-
-
 /*
  * For the 16C950
  */
@@ -193,12 +183,12 @@ static int __enable_rsa(struct uart_sunsu_port *up)
 	unsigned char mode;
 	int result;
 
-	mode = serial_inp(up, UART_RSA_MSR);
+	mode = serial_in(up, UART_RSA_MSR);
 	result = mode & UART_RSA_MSR_FIFO;
 
 	if (!result) {
-		serial_outp(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
-		mode = serial_inp(up, UART_RSA_MSR);
+		serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
+		mode = serial_in(up, UART_RSA_MSR);
 		result = mode & UART_RSA_MSR_FIFO;
 	}
 
@@ -217,7 +207,7 @@ static void enable_rsa(struct uart_sunsu_port *up)
 			uart_port_unlock_irq(&up->port);
 		}
 		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
-			serial_outp(up, UART_RSA_FRR, 0);
+			serial_out(up, UART_RSA_FRR, 0);
 	}
 }
 
@@ -236,12 +226,12 @@ static void disable_rsa(struct uart_sunsu_port *up)
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
 		uart_port_lock_irq(&up->port);
 
-		mode = serial_inp(up, UART_RSA_MSR);
+		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
 
 		if (!result) {
-			serial_outp(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
-			mode = serial_inp(up, UART_RSA_MSR);
+			serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
+			mode = serial_in(up, UART_RSA_MSR);
 			result = !(mode & UART_RSA_MSR_FIFO);
 		}
 
@@ -326,7 +316,7 @@ receive_chars(struct uart_sunsu_port *up, unsigned char *status)
 	int saw_console_brk = 0;
 
 	do {
-		ch = serial_inp(up, UART_RX);
+		ch = serial_in(up, UART_RX);
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
@@ -387,7 +377,7 @@ receive_chars(struct uart_sunsu_port *up, unsigned char *status)
 			 */
 			 tty_insert_flip_char(port, 0, TTY_OVERRUN);
 	ignore_char:
-		*status = serial_inp(up, UART_LSR);
+		*status = serial_in(up, UART_LSR);
 	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
 
 	if (saw_console_brk)
@@ -401,7 +391,7 @@ static void transmit_chars(struct uart_sunsu_port *up)
 	int count;
 
 	if (up->port.x_char) {
-		serial_outp(up, UART_TX, up->port.x_char);
+		serial_out(up, UART_TX, up->port.x_char);
 		up->port.icount.tx++;
 		up->port.x_char = 0;
 		return;
@@ -460,7 +450,7 @@ static irqreturn_t sunsu_serial_interrupt(int irq, void *dev_id)
 	uart_port_lock_irqsave(&up->port, &flags);
 
 	do {
-		status = serial_inp(up, UART_LSR);
+		status = serial_in(up, UART_LSR);
 		if (status & UART_LSR_DR)
 			receive_chars(up, &status);
 		check_modem_status(up);
@@ -498,7 +488,7 @@ static void sunsu_change_mouse_baud(struct uart_sunsu_port *up)
 static void receive_kbd_ms_chars(struct uart_sunsu_port *up, int is_break)
 {
 	do {
-		unsigned char ch = serial_inp(up, UART_RX);
+		unsigned char ch = serial_in(up, UART_RX);
 
 		/* Stop-A is handled by drivers/char/keyboard.c now. */
 		if (up->su_type == SU_PORT_KBD) {
@@ -530,7 +520,7 @@ static irqreturn_t sunsu_kbd_ms_interrupt(int irq, void *dev_id)
 	struct uart_sunsu_port *up = dev_id;
 
 	if (!(serial_in(up, UART_IIR) & UART_IIR_NO_INT)) {
-		unsigned char status = serial_inp(up, UART_LSR);
+		unsigned char status = serial_in(up, UART_LSR);
 
 		if ((status & UART_LSR_DR) || (status & UART_LSR_BI))
 			receive_kbd_ms_chars(up, (status & UART_LSR_BI) != 0);
@@ -619,14 +609,14 @@ static int sunsu_startup(struct uart_port *port)
 	if (up->port.type == PORT_16C950) {
 		/* Wake up and initialize UART */
 		up->acr = 0;
-		serial_outp(up, UART_LCR, 0xBF);
-		serial_outp(up, UART_EFR, UART_EFR_ECB);
-		serial_outp(up, UART_IER, 0);
-		serial_outp(up, UART_LCR, 0);
+		serial_out(up, UART_LCR, 0xBF);
+		serial_out(up, UART_EFR, UART_EFR_ECB);
+		serial_out(up, UART_IER, 0);
+		serial_out(up, UART_LCR, 0);
 		serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
-		serial_outp(up, UART_LCR, 0xBF);
-		serial_outp(up, UART_EFR, UART_EFR_ECB);
-		serial_outp(up, UART_LCR, 0);
+		serial_out(up, UART_LCR, 0xBF);
+		serial_out(up, UART_EFR, UART_EFR_ECB);
+		serial_out(up, UART_LCR, 0);
 	}
 
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -642,19 +632,19 @@ static int sunsu_startup(struct uart_port *port)
 	 * (they will be reenabled in set_termios())
 	 */
 	if (uart_config[up->port.type].flags & UART_CLEAR_FIFO) {
-		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
-		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+		serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
 				UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
-		serial_outp(up, UART_FCR, 0);
+		serial_out(up, UART_FCR, 0);
 	}
 
 	/*
 	 * Clear the interrupt registers.
 	 */
-	(void) serial_inp(up, UART_LSR);
-	(void) serial_inp(up, UART_RX);
-	(void) serial_inp(up, UART_IIR);
-	(void) serial_inp(up, UART_MSR);
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
+	(void) serial_in(up, UART_IIR);
+	(void) serial_in(up, UART_MSR);
 
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -662,7 +652,7 @@ static int sunsu_startup(struct uart_port *port)
 	 * here.
 	 */
 	if (!(up->port.flags & UPF_BUGGY_UART) &&
-	    (serial_inp(up, UART_LSR) == 0xff)) {
+	    (serial_in(up, UART_LSR) == 0xff)) {
 		printk("ttyS%d: LSR safety check engaged!\n", up->port.line);
 		return -ENODEV;
 	}
@@ -682,7 +672,7 @@ static int sunsu_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_outp(up, UART_LCR, UART_LCR_WLEN8);
+	serial_out(up, UART_LCR, UART_LCR_WLEN8);
 
 	uart_port_lock_irqsave(&up->port, &flags);
 
@@ -697,7 +687,7 @@ static int sunsu_startup(struct uart_port *port)
 	 * anyway, so we don't enable them here.
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
-	serial_outp(up, UART_IER, up->ier);
+	serial_out(up, UART_IER, up->ier);
 
 	if (up->port.flags & UPF_FOURPORT) {
 		unsigned int icp;
@@ -712,10 +702,10 @@ static int sunsu_startup(struct uart_port *port)
 	/*
 	 * And clear the interrupt registers again for luck.
 	 */
-	(void) serial_inp(up, UART_LSR);
-	(void) serial_inp(up, UART_RX);
-	(void) serial_inp(up, UART_IIR);
-	(void) serial_inp(up, UART_MSR);
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
+	(void) serial_in(up, UART_IIR);
+	(void) serial_in(up, UART_MSR);
 
 	return 0;
 }
@@ -730,7 +720,7 @@ static void sunsu_shutdown(struct uart_port *port)
 	 * Disable interrupts from this port
 	 */
 	up->ier = 0;
-	serial_outp(up, UART_IER, 0);
+	serial_out(up, UART_IER, 0);
 
 	uart_port_lock_irqsave(&up->port, &flags);
 	if (up->port.flags & UPF_FOURPORT) {
@@ -746,11 +736,11 @@ static void sunsu_shutdown(struct uart_port *port)
 	/*
 	 * Disable break condition and FIFOs
 	 */
-	serial_out(up, UART_LCR, serial_inp(up, UART_LCR) & ~UART_LCR_SBC);
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+	serial_out(up, UART_LCR, serial_in(up, UART_LCR) & ~UART_LCR_SBC);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
 				  UART_FCR_CLEAR_RCVR |
 				  UART_FCR_CLEAR_XMIT);
-	serial_outp(up, UART_FCR, 0);
+	serial_out(up, UART_FCR, 0);
 
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
@@ -872,22 +862,22 @@ sunsu_change_speed(struct uart_port *port, unsigned int cflag,
 	serial_out(up, UART_IER, up->ier);
 
 	if (uart_config[up->port.type].flags & UART_STARTECH) {
-		serial_outp(up, UART_LCR, 0xBF);
-		serial_outp(up, UART_EFR, cflag & CRTSCTS ? UART_EFR_CTS :0);
+		serial_out(up, UART_LCR, 0xBF);
+		serial_out(up, UART_EFR, cflag & CRTSCTS ? UART_EFR_CTS :0);
 	}
-	serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
-	serial_outp(up, UART_DLL, quot & 0xff);		/* LS of divisor */
-	serial_outp(up, UART_DLM, quot >> 8);		/* MS of divisor */
+	serial_out(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+	serial_out(up, UART_DLL, quot & 0xff);		/* LS of divisor */
+	serial_out(up, UART_DLM, quot >> 8);		/* MS of divisor */
 	if (up->port.type == PORT_16750)
-		serial_outp(up, UART_FCR, fcr);		/* set fcr */
-	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
+		serial_out(up, UART_FCR, fcr);		/* set fcr */
+	serial_out(up, UART_LCR, cval);		/* reset DLAB */
 	up->lcr = cval;					/* Save LCR */
 	if (up->port.type != PORT_16750) {
 		if (fcr & UART_FCR_ENABLE_FIFO) {
 			/* emulated UARTs (Lucent Venus 167x) need two steps */
-			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+			serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 		}
-		serial_outp(up, UART_FCR, fcr);		/* set fcr */
+		serial_out(up, UART_FCR, fcr);		/* set fcr */
 	}
 
 	up->cflag = cflag;
@@ -1051,18 +1041,18 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 		 * 0x80 is a non-existent port; which should be safe since
 		 * include/asm/io.h also makes this assumption.
 		 */
-		scratch = serial_inp(up, UART_IER);
-		serial_outp(up, UART_IER, 0);
+		scratch = serial_in(up, UART_IER);
+		serial_out(up, UART_IER, 0);
 #ifdef __i386__
 		outb(0xff, 0x080);
 #endif
-		scratch2 = serial_inp(up, UART_IER);
-		serial_outp(up, UART_IER, 0x0f);
+		scratch2 = serial_in(up, UART_IER);
+		serial_out(up, UART_IER, 0x0f);
 #ifdef __i386__
 		outb(0, 0x080);
 #endif
-		scratch3 = serial_inp(up, UART_IER);
-		serial_outp(up, UART_IER, scratch);
+		scratch3 = serial_in(up, UART_IER);
+		serial_out(up, UART_IER, scratch);
 		if (scratch2 != 0 || scratch3 != 0x0F)
 			goto out;	/* We failed; there's nothing here */
 	}
@@ -1080,16 +1070,16 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 	 * that conflicts with COM 1-4 --- we hope!
 	 */
 	if (!(up->port.flags & UPF_SKIP_TEST)) {
-		serial_outp(up, UART_MCR, UART_MCR_LOOP | 0x0A);
-		status1 = serial_inp(up, UART_MSR) & 0xF0;
-		serial_outp(up, UART_MCR, save_mcr);
+		serial_out(up, UART_MCR, UART_MCR_LOOP | 0x0A);
+		status1 = serial_in(up, UART_MSR) & 0xF0;
+		serial_out(up, UART_MCR, save_mcr);
 		if (status1 != 0x90)
 			goto out;	/* We failed loopback test */
 	}
-	serial_outp(up, UART_LCR, 0xBF);	/* set up for StarTech test */
-	serial_outp(up, UART_EFR, 0);		/* EFR is the same as FCR */
-	serial_outp(up, UART_LCR, 0);
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	serial_out(up, UART_LCR, 0xBF);	/* set up for StarTech test */
+	serial_out(up, UART_EFR, 0);		/* EFR is the same as FCR */
+	serial_out(up, UART_LCR, 0);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 	scratch = serial_in(up, UART_IIR) >> 6;
 	switch (scratch) {
 		case 0:
@@ -1107,19 +1097,19 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 	}
 	if (up->port.type == PORT_16550A) {
 		/* Check for Startech UART's */
-		serial_outp(up, UART_LCR, UART_LCR_DLAB);
+		serial_out(up, UART_LCR, UART_LCR_DLAB);
 		if (serial_in(up, UART_EFR) == 0) {
 			up->port.type = PORT_16650;
 		} else {
-			serial_outp(up, UART_LCR, 0xBF);
+			serial_out(up, UART_LCR, 0xBF);
 			if (serial_in(up, UART_EFR) == 0)
 				up->port.type = PORT_16650V2;
 		}
 	}
 	if (up->port.type == PORT_16550A) {
 		/* Check for TI 16750 */
-		serial_outp(up, UART_LCR, save_lcr | UART_LCR_DLAB);
-		serial_outp(up, UART_FCR,
+		serial_out(up, UART_LCR, save_lcr | UART_LCR_DLAB);
+		serial_out(up, UART_FCR,
 			    UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
 		scratch = serial_in(up, UART_IIR) >> 5;
 		if (scratch == 7) {
@@ -1129,24 +1119,24 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 			 * mode if the UART_FCR7_64BYTE bit was set
 			 * while UART_LCR_DLAB was latched.
 			 */
- 			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
-			serial_outp(up, UART_LCR, 0);
-			serial_outp(up, UART_FCR,
+			serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+			serial_out(up, UART_LCR, 0);
+			serial_out(up, UART_FCR,
 				    UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
 			scratch = serial_in(up, UART_IIR) >> 5;
 			if (scratch == 6)
 				up->port.type = PORT_16750;
 		}
-		serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 	}
-	serial_outp(up, UART_LCR, save_lcr);
+	serial_out(up, UART_LCR, save_lcr);
 	if (up->port.type == PORT_16450) {
 		scratch = serial_in(up, UART_SCR);
-		serial_outp(up, UART_SCR, 0xa5);
+		serial_out(up, UART_SCR, 0xa5);
 		status1 = serial_in(up, UART_SCR);
-		serial_outp(up, UART_SCR, 0x5a);
+		serial_out(up, UART_SCR, 0x5a);
 		status2 = serial_in(up, UART_SCR);
-		serial_outp(up, UART_SCR, scratch);
+		serial_out(up, UART_SCR, scratch);
 
 		if ((status1 != 0xa5) || (status2 != 0x5a))
 			up->port.type = PORT_8250;
@@ -1163,15 +1153,15 @@ static void sunsu_autoconfig(struct uart_sunsu_port *up)
 	 */
 #ifdef CONFIG_SERIAL_8250_RSA
 	if (up->port.type == PORT_RSA)
-		serial_outp(up, UART_RSA_FRR, 0);
+		serial_out(up, UART_RSA_FRR, 0);
 #endif
-	serial_outp(up, UART_MCR, save_mcr);
-	serial_outp(up, UART_FCR, (UART_FCR_ENABLE_FIFO |
+	serial_out(up, UART_MCR, save_mcr);
+	serial_out(up, UART_FCR, (UART_FCR_ENABLE_FIFO |
 				     UART_FCR_CLEAR_RCVR |
 				     UART_FCR_CLEAR_XMIT));
-	serial_outp(up, UART_FCR, 0);
+	serial_out(up, UART_FCR, 0);
 	(void)serial_in(up, UART_RX);
-	serial_outp(up, UART_IER, 0);
+	serial_out(up, UART_IER, 0);
 
 out:
 	uart_port_unlock_irqrestore(&up->port, flags);
-- 
2.48.1

