From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:33 +0000
Subject: [PATCH 4/7]: serial: suncore: Add 'ignore_line' argument to
Message-Id: <20091124.142133.234821425.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This tells the logic to ignore the line match when deciding whether the
device is the OpenFirmware specified console device or not.

This is going to be used in the SU driver for rsc-console detection.

There is probably a better way to handle this, but this is the least
intrusive solution for now which we can validate won't break any other
cases.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/suncore.c  |   19 ++++++++++---------
 drivers/serial/suncore.h  |    2 +-
 drivers/serial/sunsab.c   |    6 ++++--
 drivers/serial/sunsu.c    |    3 ++-
 drivers/serial/sunzilog.c |    6 ++++--
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/serial/suncore.c b/drivers/serial/suncore.c
index a2d4a19..50d3b5e 100644
--- a/drivers/serial/suncore.c
+++ b/drivers/serial/suncore.c
@@ -53,20 +53,21 @@ void sunserial_unregister_minors(struct uart_driver *drv, int count)
 EXPORT_SYMBOL(sunserial_unregister_minors);
 
 int sunserial_console_match(struct console *con, struct device_node *dp,
-			    struct uart_driver *drv, int line)
+			    struct uart_driver *drv, int line, bool ignore_line)
 {
-	int off;
-
 	if (!con || of_console_device != dp)
 		return 0;
 
-	off = 0;
-	if (of_console_options &&
-	    *of_console_options = 'b')
-		off = 1;
+	if (!ignore_line) {
+		int off = 0;
 
-	if ((line & 1) != off)
-		return 0;
+		if (of_console_options &&
+		    *of_console_options = 'b')
+			off = 1;
+
+		if ((line & 1) != off)
+			return 0;
+	}
 
 	con->index = line;
 	drv->cons = con;
diff --git a/drivers/serial/suncore.h b/drivers/serial/suncore.h
index 042668a..cab95b3 100644
--- a/drivers/serial/suncore.h
+++ b/drivers/serial/suncore.h
@@ -26,7 +26,7 @@ extern int sunserial_register_minors(struct uart_driver *, int);
 extern void sunserial_unregister_minors(struct uart_driver *, int);
 
 extern int sunserial_console_match(struct console *, struct device_node *,
-				   struct uart_driver *, int);
+				   struct uart_driver *, int, bool);
 extern void sunserial_console_termios(struct console *);
 
 #endif /* !(_SERIAL_SUN_H) */
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index 8755de8..e7215c2 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -1027,10 +1027,12 @@ static int __devinit sab_probe(struct of_device *op, const struct of_device_id *
 		goto out1;
 
 	sunserial_console_match(SUNSAB_CONSOLE(), op->node,
-				&sunsab_reg, up[0].port.line);
+				&sunsab_reg, up[0].port.line,
+				false);
 
 	sunserial_console_match(SUNSAB_CONSOLE(), op->node,
-				&sunsab_reg, up[1].port.line);
+				&sunsab_reg, up[1].port.line,
+				false);
 
 	err = uart_add_one_port(&sunsab_reg, &up[0].port);
 	if (err)
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index f6511a4..4868b31 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1468,7 +1468,8 @@ static int __devinit su_probe(struct of_device *op, const struct of_device_id *m
 	up->port.ops = &sunsu_pops;
 
 	sunserial_console_match(SUNSU_CONSOLE(), dp,
-				&sunsu_reg, up->port.line);
+				&sunsu_reg, up->port.line,
+				false);
 	err = uart_add_one_port(&sunsu_reg, &up->port);
 	if (err)
 		goto out_unmap;
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index ef693ae..3242688 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1416,7 +1416,8 @@ static int __devinit zs_probe(struct of_device *op, const struct of_device_id *m
 
 	if (!keyboard_mouse) {
 		if (sunserial_console_match(SUNZILOG_CONSOLE(), op->node,
-					    &sunzilog_reg, up[0].port.line))
+					    &sunzilog_reg, up[0].port.line,
+					    false))
 			up->flags |= SUNZILOG_FLAG_IS_CONS;
 		err = uart_add_one_port(&sunzilog_reg, &up[0].port);
 		if (err) {
@@ -1425,7 +1426,8 @@ static int __devinit zs_probe(struct of_device *op, const struct of_device_id *m
 			return err;
 		}
 		if (sunserial_console_match(SUNZILOG_CONSOLE(), op->node,
-					    &sunzilog_reg, up[1].port.line))
+					    &sunzilog_reg, up[1].port.line,
+					    false))
 			up->flags |= SUNZILOG_FLAG_IS_CONS;
 		err = uart_add_one_port(&sunzilog_reg, &up[1].port);
 		if (err) {
-- 
1.6.5.3

