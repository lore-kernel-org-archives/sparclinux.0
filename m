From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 19 Nov 2004 03:00:07 +0000
Subject: Re: circular console list in 2.6.9-bk3+
Message-Id: <20041118190007.286f7dcc.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041118144142.GG2268@holomorphy.com>
In-Reply-To: <20041118144142.GG2268@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This should do the trick.  Just do the console init
before we add the ports.

=== drivers/serial/sunsab.c 1.35 vs edited ==--- 1.35/drivers/serial/sunsab.c	2004-08-26 15:38:22 -07:00
+++ edited/drivers/serial/sunsab.c	2004-11-18 18:49:39 -08:00
@@ -1125,13 +1125,13 @@
 
 	sunserial_current_minor += num_channels;
 	
+	sunsab_console_init();
+
 	for (i = 0; i < num_channels; i++) {
 		struct uart_sunsab_port *up = &sunsab_ports[i];
 
 		uart_add_one_port(&sunsab_reg, &up->port);
 	}
-
-	sunsab_console_init();
 
 	return 0;
 }
=== drivers/serial/sunsu.c 1.46 vs edited ==--- 1.46/drivers/serial/sunsu.c	2004-10-31 13:33:17 -08:00
+++ edited/drivers/serial/sunsu.c	2004-11-18 18:49:22 -08:00
@@ -1532,6 +1532,7 @@
 	if (ret < 0)
 		return ret;
 
+	sunsu_serial_console_init();
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_sunsu_port *up = &sunsu_ports[i];
 
@@ -1704,7 +1705,6 @@
 	 * Console must be initiated after the generic initialization.
 	 */
        	sunsu_serial_init();
-	sunsu_serial_console_init();
 
 	return 0;
 }
=== drivers/serial/sunzilog.c 1.47 vs edited ==--- 1.47/drivers/serial/sunzilog.c	2004-11-09 16:39:13 -08:00
+++ edited/drivers/serial/sunzilog.c	2004-11-18 18:49:02 -08:00
@@ -1690,6 +1690,7 @@
 
 	ret = uart_register_driver(&sunzilog_reg);
 	if (ret = 0) {
+		sunzilog_console_init();
 		for (i = 0; i < NUM_CHANNELS; i++) {
 			struct uart_sunzilog_port *up = &sunzilog_port_table[i];
 
@@ -1738,7 +1739,6 @@
 	sunzilog_alloc_tables();
 
 	sunzilog_ports_init();
-	sunzilog_console_init();
 
 	return 0;
 }
