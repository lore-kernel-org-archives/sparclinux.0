From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 20 Nov 2007 02:10:15 +0000
Subject: [RFC] Minor cleanups of the sparc serial drivers
Message-Id: <20071120021014.GA15879@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch against 2.6.23 sparc-2.6.git contains a number of minor cleanups
of the sparc serial drivers.
Initially I fixed this build warning:

WARNING: vmlinux.o(.text+0x107a2c): Section mismatch: reference to .init.text:add_preferred_console (between 'sunserial_console_match' and 'sunserial_console_termios')

which is done by declaring sunserial_console_match() as __init.
This resulted in build warnings on sunserial_current_minor.
To resolve these the variable was changed so it is no longer global,
and to hide operations on it inside 2 new functions. These functions
handle the UART minor handling code that is common to all sparc serial
drivers.

These changes allowed to clean up the uart counters in all the sparc serial
drivers, and the administration of minor device numbers.

Lastly, sunserial_console_termios() does not need to be exported
since it is only called from non-modular code.

Sadly, the following build warning still exists:

WARNING: vmlinux.o(__ksymtab+0x2910): Section mismatch: reference to .init.text:sunserial_console_match (between '__ksymtab_sunserial_console_match' and '__ksymtab_sunserial_unregister_minors')

This could be resolved by not exporting sunserial_console_match(),
but this is not possible at the moment because it is being called
from modular code. On the other hand, this is a bogus warning since
it comes from a ksymtab section.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: 2.6/drivers/serial/suncore.c
=================================--- 2.6.orig/drivers/serial/suncore.c	2007-11-17 21:13:07.000000000 +0000
+++ 2.6/drivers/serial/suncore.c	2007-11-19 20:58:17.000000000 +0000
@@ -23,11 +23,36 @@
 
 #include "suncore.h"
 
-int sunserial_current_minor = 64;
+static int sunserial_current_minor = 64;
 
-EXPORT_SYMBOL(sunserial_current_minor);
+int sunserial_register_minors(struct uart_driver *drv, int count)
+{
+	int err = 0;
 
-int sunserial_console_match(struct console *con, struct device_node *dp,
+	drv->minor = sunserial_current_minor;
+	drv->nr += count;
+	/* Register the driver on the first call */
+	if (drv->nr = count)
+		err = uart_register_driver(drv);
+	if (err = 0) {
+		sunserial_current_minor += count;
+		drv->tty_driver->name_base = drv->minor - 64;
+	}
+	return err;
+}
+EXPORT_SYMBOL(sunserial_register_minors);
+
+void sunserial_unregister_minors(struct uart_driver *drv, int count)
+{
+	drv->nr -= count;
+	sunserial_current_minor -= count;
+
+	if (drv->nr = 0)
+		uart_unregister_driver(drv);
+}
+EXPORT_SYMBOL(sunserial_unregister_minors);
+
+int __init sunserial_console_match(struct console *con, struct device_node *dp,
 			    struct uart_driver *drv, int line)
 {
 	int off;
@@ -133,8 +158,6 @@
 	con->cflag = cflag;
 }
 
-EXPORT_SYMBOL(sunserial_console_termios);
-
 /* Sun serial MOUSE auto baud rate detection.  */
 static struct mouse_baud_cflag {
 	int baud;
Index: 2.6/drivers/serial/suncore.h
=================================--- 2.6.orig/drivers/serial/suncore.h	2007-11-17 21:40:16.000000000 +0000
+++ 2.6/drivers/serial/suncore.h	2007-11-17 23:43:16.000000000 +0000
@@ -22,7 +22,8 @@
 extern unsigned int suncore_mouse_baud_cflag_next(unsigned int, int *);
 extern int suncore_mouse_baud_detection(unsigned char, int);
 
-extern int sunserial_current_minor;
+extern int sunserial_register_minors(struct uart_driver *, int);
+extern void sunserial_unregister_minors(struct uart_driver *, int);
 
 extern int sunserial_console_match(struct console *, struct device_node *,
 				   struct uart_driver *, int);
Index: 2.6/drivers/serial/sunhv.c
=================================--- 2.6.orig/drivers/serial/sunhv.c	2007-11-17 23:10:34.000000000 +0000
+++ 2.6/drivers/serial/sunhv.c	2007-11-18 00:24:34.000000000 +0000
@@ -562,16 +562,10 @@
 
 	port->dev = &op->dev;
 
-	sunhv_reg.minor = sunserial_current_minor;
-	sunhv_reg.nr = 1;
-
-	err = uart_register_driver(&sunhv_reg);
+	err = sunserial_register_minors(&sunhv_reg, 1);
 	if (err)
 		goto out_free_con_read_page;
 
-	sunhv_reg.tty_driver->name_base = sunhv_reg.minor - 64;
-	sunserial_current_minor += 1;
-
 	sunserial_console_match(&sunhv_console, op->node,
 				&sunhv_reg, port->line);
 
@@ -591,8 +585,7 @@
 	uart_remove_one_port(&sunhv_reg, port);
 
 out_unregister_driver:
-	sunserial_current_minor -= 1;
-	uart_unregister_driver(&sunhv_reg);
+	sunserial_unregister_minors(&sunhv_reg, 1);
 
 out_free_con_read_page:
 	kfree(con_read_page);
@@ -614,8 +607,7 @@
 
 	uart_remove_one_port(&sunhv_reg, port);
 
-	sunserial_current_minor -= 1;
-	uart_unregister_driver(&sunhv_reg);
+	sunserial_unregister_minors(&sunhv_reg, 1);
 
 	kfree(port);
 	sunhv_port = NULL;
Index: 2.6/drivers/serial/sunsab.c
=================================--- 2.6.orig/drivers/serial/sunsab.c	2007-11-17 23:15:41.000000000 +0000
+++ 2.6/drivers/serial/sunsab.c	2007-11-18 18:42:56.000000000 +0000
@@ -832,7 +832,6 @@
 };
 
 static struct uart_sunsab_port *sunsab_ports;
-static int num_channels;
 
 #ifdef CONFIG_SERIAL_SUNSAB_CONSOLE
 
@@ -1102,8 +1101,8 @@
 {
 	struct device_node *dp;
 	int err;
+	int num_channels = 0;
 
-	num_channels = 0;
 	for_each_node_by_name(dp, "se")
 		num_channels += 2;
 	for_each_node_by_name(dp, "serial") {
@@ -1117,20 +1116,14 @@
 		if (!sunsab_ports)
 			return -ENOMEM;
 
-		sunsab_reg.minor = sunserial_current_minor;
-		sunsab_reg.nr = num_channels;
 		sunsab_reg.cons = SUNSAB_CONSOLE();
-
-		err = uart_register_driver(&sunsab_reg);
+		err = sunserial_register_minors(&sunsab_reg, num_channels);
 		if (err) {
 			kfree(sunsab_ports);
 			sunsab_ports = NULL;
 
 			return err;
 		}
-
-		sunsab_reg.tty_driver->name_base = sunsab_reg.minor - 64;
-		sunserial_current_minor += num_channels;
 	}
 
 	return of_register_driver(&sab_driver, &of_bus_type);
@@ -1139,9 +1132,8 @@
 static void __exit sunsab_exit(void)
 {
 	of_unregister_driver(&sab_driver);
-	if (num_channels) {
-		sunserial_current_minor -= num_channels;
-		uart_unregister_driver(&sunsab_reg);
+	if (sunsab_reg.nr) {
+		sunserial_unregister_minors(&sunsab_reg, sunsab_reg.nr);
 	}
 
 	kfree(sunsab_ports);
Index: 2.6/drivers/serial/sunsu.c
=================================--- 2.6.orig/drivers/serial/sunsu.c	2007-11-17 23:16:56.000000000 +0000
+++ 2.6/drivers/serial/sunsu.c	2007-11-18 16:04:14.000000000 +0000
@@ -1528,14 +1528,12 @@
 	.remove		= __devexit_p(su_remove),
 };
 
-static int num_uart;
-
 static int __init sunsu_init(void)
 {
 	struct device_node *dp;
 	int err;
+	int num_uart = 0;
 
-	num_uart = 0;
 	for_each_node_by_name(dp, "su") {
 		if (su_get_type(dp) = SU_PORT_PORT)
 			num_uart++;
@@ -1552,26 +1550,22 @@
 	}
 
 	if (num_uart) {
-		sunsu_reg.minor = sunserial_current_minor;
-		sunsu_reg.nr = num_uart;
-		err = uart_register_driver(&sunsu_reg);
+		err = sunserial_register_minors(&sunsu_reg, num_uart);
 		if (err)
 			return err;
-		sunsu_reg.tty_driver->name_base = sunsu_reg.minor - 64;
-		sunserial_current_minor += num_uart;
 	}
 
 	err = of_register_driver(&su_driver, &of_bus_type);
 	if (err && num_uart)
-		uart_unregister_driver(&sunsu_reg);
+		sunserial_unregister_minors(&sunsu_reg, num_uart);
 
 	return err;
 }
 
 static void __exit sunsu_exit(void)
 {
-	if (num_uart)
-		uart_unregister_driver(&sunsu_reg);
+	if (sunsu_reg.nr)
+		sunserial_unregister_minors(&sunsu_reg, sunsu_reg.nr);
 }
 
 module_init(sunsu_init);
Index: 2.6/drivers/serial/sunzilog.c
=================================--- 2.6.orig/drivers/serial/sunzilog.c	2007-11-17 21:41:05.000000000 +0000
+++ 2.6/drivers/serial/sunzilog.c	2007-11-18 00:24:51.000000000 +0000
@@ -63,10 +63,6 @@
 	readb(&((__channel)->control))
 #endif
 
-static int num_sunzilog;
-#define NUM_SUNZILOG	num_sunzilog
-#define NUM_CHANNELS	(NUM_SUNZILOG * 2)
-
 #define ZS_CLOCK		4915200 /* Zilog input clock rate. */
 #define ZS_CLOCK_DIVISOR	16      /* Divisor this driver uses. */
 
@@ -1036,18 +1032,19 @@
 	.major		=	TTY_MAJOR,
 };
 
-static int __init sunzilog_alloc_tables(void)
+static int __init sunzilog_alloc_tables(int num_sunzilog)
 {
 	struct uart_sunzilog_port *up;
 	unsigned long size;
+	int num_channels = num_sunzilog * 2;
 	int i;
 
-	size = NUM_CHANNELS * sizeof(struct uart_sunzilog_port);
+	size = num_channels * sizeof(struct uart_sunzilog_port);
 	sunzilog_port_table = kzalloc(size, GFP_KERNEL);
 	if (!sunzilog_port_table)
 		return -ENOMEM;
 
-	for (i = 0; i < NUM_CHANNELS; i++) {
+	for (i = 0; i < num_channels; i++) {
 		up = &sunzilog_port_table[i];
 
 		spin_lock_init(&up->port.lock);
@@ -1055,13 +1052,13 @@
 		if (i = 0)
 			sunzilog_irq_chain = up;
 
-		if (i < NUM_CHANNELS - 1)
+		if (i < num_channels - 1)
 			up->next = up + 1;
 		else
 			up->next = NULL;
 	}
 
-	size = NUM_SUNZILOG * sizeof(struct zilog_layout __iomem *);
+	size = num_sunzilog * sizeof(struct zilog_layout __iomem *);
 	sunzilog_chip_regs = kzalloc(size, GFP_KERNEL);
 	if (!sunzilog_chip_regs) {
 		kfree(sunzilog_port_table);
@@ -1501,34 +1498,28 @@
 	struct device_node *dp;
 	int err, uart_count;
 	int num_keybms;
+	int num_sunzilog = 0;
 
-	NUM_SUNZILOG = 0;
 	num_keybms = 0;
 	for_each_node_by_name(dp, "zs") {
-		NUM_SUNZILOG++;
+		num_sunzilog++;
 		if (of_find_property(dp, "keyboard", NULL))
 			num_keybms++;
 	}
 
 	uart_count = 0;
-	if (NUM_SUNZILOG) {
+	if (num_sunzilog) {
 		int uart_count;
 
-		err = sunzilog_alloc_tables();
+		err = sunzilog_alloc_tables(num_sunzilog);
 		if (err)
 			goto out;
 
-		uart_count = (NUM_SUNZILOG * 2) - (2 * num_keybms);
+		uart_count = (num_sunzilog * 2) - (2 * num_keybms);
 
-		sunzilog_reg.nr = uart_count;
-		sunzilog_reg.minor = sunserial_current_minor;
-		err = uart_register_driver(&sunzilog_reg);
+		err = sunserial_register_minors(&sunzilog_reg, uart_count);
 		if (err)
 			goto out_free_tables;
-
-		sunzilog_reg.tty_driver->name_base = sunzilog_reg.minor - 64;
-
-		sunserial_current_minor += uart_count;
 	}
 
 	err = of_register_driver(&zs_driver, &of_bus_type);
@@ -1562,8 +1553,8 @@
 	of_unregister_driver(&zs_driver);
 
 out_unregister_uart:
-	if (NUM_SUNZILOG) {
-		uart_unregister_driver(&sunzilog_reg);
+	if (num_sunzilog) {
+		sunserial_unregister_minors(&sunzilog_reg, num_sunzilog);
 		sunzilog_reg.cons = NULL;
 	}
 
@@ -1595,8 +1586,8 @@
 		zilog_irq = -1;
 	}
 
-	if (NUM_SUNZILOG) {
-		uart_unregister_driver(&sunzilog_reg);
+	if (sunzilog_reg.nr) {
+		sunserial_unregister_minors(&sunzilog_reg, sunzilog_reg.nr);
 		sunzilog_free_tables();
 	}
 }
