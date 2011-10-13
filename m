From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 13 Oct 2011 07:00:02 +0000
Subject: [PATCH 1/4] apbuart: add polling callbacks to apbuart driver
Message-Id: <1318489205-315-2-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1317381744-24862-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317381744-24862-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add the 2 callbacks poll_get_char and poll_put_char so
that the driver can be used as an interface with KGDB.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 drivers/tty/serial/apbuart.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 19a9436..153e065 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -39,6 +39,10 @@
 #define UART_DUMMY_RSR_RX	0x8000	/* for ignore all read */
 
 static void apbuart_tx_chars(struct uart_port *port);
+#ifdef CONFIG_CONSOLE_POLL
+static int apbuart_poll_get_char(struct uart_port *port);
+static void apbuart_poll_put_char(struct uart_port *port, unsigned char ch);
+#endif
 
 static void apbuart_stop_tx(struct uart_port *port)
 {
@@ -345,6 +349,10 @@ static struct uart_ops grlib_apbuart_ops = {
 	.request_port = apbuart_request_port,
 	.config_port = apbuart_config_port,
 	.verify_port = apbuart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= apbuart_poll_get_char,
+	.poll_put_char	= apbuart_poll_put_char,
+#endif
 };
 
 static struct uart_port grlib_apbuart_ports[UART_NR];
@@ -420,7 +428,7 @@ static void apbuart_flush_fifo(struct uart_port *port)
 /* Console driver, if enabled                                               */
 /* ==================================== */
 
-#ifdef CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE
+#if defined(CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 
 static void apbuart_console_putchar(struct uart_port *port, int ch)
 {
@@ -431,6 +439,29 @@ static void apbuart_console_putchar(struct uart_port *port, int ch)
 	UART_PUT_CHAR(port, ch);
 }
 
+#endif
+
+#ifdef CONFIG_CONSOLE_POLL
+
+static int apbuart_poll_get_char(struct uart_port *port)
+{
+	int c = NO_POLL_CHAR;
+	unsigned int status = UART_GET_STATUS(port);
+	if (status & UART_STATUS_DR) {
+		c = UART_GET_CHAR(port);
+	}
+	return c;
+}
+
+static void apbuart_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	apbuart_console_putchar(port, ch);
+}
+
+#endif
+
+#ifdef CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE
+
 static void
 apbuart_console_write(struct console *co, const char *s, unsigned int count)
 {
-- 
1.6.4.1

