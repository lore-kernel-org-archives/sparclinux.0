From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:36 +0000
Subject: [PATCH 5/7]: serial: suncore: Fix RSC/LOM handling in
Message-Id: <20091124.142136.140215776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


RSC and LOM devices have fixed speed settings.

We already had some code to match and handle "rsc" named devices on
E250 systems, but we also have to handle 'rsc-console', 'rsc-control',
and 'lom-console'.

Also, in order to get this right regardless of what 'output-device'
happens to be, explicitly pass the UART device node pointer to this
routine.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/suncore.c  |   18 ++++++++++--------
 drivers/serial/suncore.h  |    3 ++-
 drivers/serial/sunhv.c    |    2 +-
 drivers/serial/sunsab.c   |    2 +-
 drivers/serial/sunzilog.c |    2 +-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/suncore.c b/drivers/serial/suncore.c
index 50d3b5e..ed7d958 100644
--- a/drivers/serial/suncore.c
+++ b/drivers/serial/suncore.c
@@ -77,23 +77,24 @@ int sunserial_console_match(struct console *con, struct device_node *dp,
 }
 EXPORT_SYMBOL(sunserial_console_match);
 
-void
-sunserial_console_termios(struct console *con)
+void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 {
-	struct device_node *dp;
-	const char *od, *mode, *s;
+	const char *mode, *s;
 	char mode_prop[] = "ttyX-mode";
 	int baud, bits, stop, cflag;
 	char parity;
 
-	dp = of_find_node_by_path("/options");
-	od = of_get_property(dp, "output-device", NULL);
-	if (!strcmp(od, "rsc")) {
-		mode = of_get_property(of_console_device,
+	if (!strcmp(uart_dp->name, "rsc") ||
+	    !strcmp(uart_dp->name, "rsc-console") ||
+	    !strcmp(uart_dp->name, "rsc-control")) {
+		mode = of_get_property(uart_dp,
 				       "ssp-console-modes", NULL);
 		if (!mode)
 			mode = "115200,8,n,1,-";
+	} else if (!strcmp(uart_dp->name, "lom-console")) {
+		mode = "9600,8,n,1,-";
 	} else {
+		struct device_node *dp;
 		char c;
 
 		c = 'a';
@@ -102,6 +103,7 @@ sunserial_console_termios(struct console *con)
 
 		mode_prop[3] = c;
 
+		dp = of_find_node_by_path("/options");
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
diff --git a/drivers/serial/suncore.h b/drivers/serial/suncore.h
index cab95b3..db20579 100644
--- a/drivers/serial/suncore.h
+++ b/drivers/serial/suncore.h
@@ -27,6 +27,7 @@ extern void sunserial_unregister_minors(struct uart_driver *, int);
 
 extern int sunserial_console_match(struct console *, struct device_node *,
 				   struct uart_driver *, int, bool);
-extern void sunserial_console_termios(struct console *);
+extern void sunserial_console_termios(struct console *,
+				      struct device_node *);
 
 #endif /* !(_SERIAL_SUN_H) */
diff --git a/drivers/serial/sunhv.c b/drivers/serial/sunhv.c
index d548652..d14cca7 100644
--- a/drivers/serial/sunhv.c
+++ b/drivers/serial/sunhv.c
@@ -566,7 +566,7 @@ static int __devinit hv_probe(struct of_device *op, const struct of_device_id *m
 		goto out_free_con_read_page;
 
 	sunserial_console_match(&sunhv_console, op->node,
-				&sunhv_reg, port->line);
+				&sunhv_reg, port->line, false);
 
 	err = uart_add_one_port(&sunhv_reg, port);
 	if (err)
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index e7215c2..d514e28 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -883,7 +883,7 @@ static int sunsab_console_setup(struct console *con, char *options)
 	printk("Console: ttyS%d (SAB82532)\n",
 	       (sunsab_reg.minor - 64) + con->index);
 
-	sunserial_console_termios(con);
+	sunserial_console_termios(con, to_of_device(up->port.dev)->node);
 
 	switch (con->cflag & CBAUD) {
 	case B150: baud = 150; break;
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index 3242688..2c7a66a 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1180,7 +1180,7 @@ static int __init sunzilog_console_setup(struct console *con, char *options)
 	       (sunzilog_reg.minor - 64) + con->index, con->index);
 
 	/* Get firmware console settings.  */
-	sunserial_console_termios(con);
+	sunserial_console_termios(con, to_of_device(up->port.dev)->node);
 
 	/* Firmware console speed is limited to 150-->38400 baud so
 	 * this hackish cflag thing is OK.
-- 
1.6.5.3

