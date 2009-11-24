From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:41 +0000
Subject: [PATCH 7/7]: sunsu: Use sunserial_console_termios() in
Message-Id: <20091124.142141.83711700.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Be like the other Sun serial drivers otherwise the special handling of
OpenFirmware options and hard-coded overrides for LOM/RSC consoles
will not be handled.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/sunsu.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index 4ee4167..170d3d6 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1329,11 +1329,9 @@ static void sunsu_console_write(struct console *co, const char *s,
  */
 static int __init sunsu_console_setup(struct console *co, char *options)
 {
+	static struct ktermios dummy;
+	struct ktermios termios;
 	struct uart_port *port;
-	int baud = 9600;
-	int bits = 8;
-	int parity = 'n';
-	int flow = 'n';
 
 	printk("Console: ttyS%d (SU)\n",
 	       (sunsu_reg.minor - 64) + co->index);
@@ -1352,10 +1350,15 @@ static int __init sunsu_console_setup(struct console *co, char *options)
 	 */
 	spin_lock_init(&port->lock);
 
-	if (options)
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	/* Get firmware console settings.  */
+	sunserial_console_termios(co, to_of_device(port->dev)->node);
 
-	return uart_set_options(port, co, baud, parity, bits, flow);
+	memset(&termios, 0, sizeof(struct ktermios));
+	termios.c_cflag = co->cflag;
+	port->mctrl |= TIOCM_DTR;
+	port->ops->set_termios(port, &termios, &dummy);
+
+	return 0;
 }
 
 static struct console sunsu_console = {
-- 
1.6.5.3

