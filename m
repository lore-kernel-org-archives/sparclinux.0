From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 22 Apr 2005 05:08:34 +0000
Subject: Re: Weird Mouse Behaviour with 2.6
Message-Id: <20050421220834.6bb61f44.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Ok, let's kill this bug already :-)

We were neglecting to invoke sunsu_change_speed() when first
setting up the keyboard and mouse ports.  That's why things
were not working.

This should fix it and I'll push this upsteam.

[SPARC64]: In sunsu driver, make sure to fully init chip for kbd/ms

We were forgetting to call sunsu_change_speed().  The reason
that replugging in the mouse cable "fixes things" is that
causes a BREAK interrupt which in turn caused a call to
sunsu_change_speed() which would get the chip setup properly.

Signed-off-by: David S. Miller <davem@davemloft.net>

--- a/drivers/serial/sunsu.c	2005-04-20 10:17:40.000000000 -0700
+++ b/drivers/serial/sunsu.c	2005-04-21 22:01:41.000000000 -0700
@@ -1285,6 +1285,7 @@
 
 static int __init sunsu_kbd_ms_init(struct uart_sunsu_port *up, int channel)
 {
+	int quot, baud;
 #ifdef CONFIG_SERIO
 	struct serio *serio;
 #endif
@@ -1293,10 +1294,14 @@
 	up->port.type = PORT_UNKNOWN;
 	up->port.uartclk = (SU_BASE_BAUD * 16);
 
-	if (up->su_type = SU_PORT_KBD)
+	if (up->su_type = SU_PORT_KBD) {
 		up->cflag = B1200 | CS8 | CLOCAL | CREAD;
-	else
+		baud = 1200;
+	} else {
 		up->cflag = B4800 | CS8 | CLOCAL | CREAD;
+		baud = 4800;
+	}
+	quot = up->port.uartclk / (16 * baud);
 
 	sunsu_autoconfig(up);
 	if (up->port.type = PORT_UNKNOWN)
@@ -1337,6 +1342,8 @@
 	}
 #endif
 
+	sunsu_change_speed(&up->port, up->cflag, 0, quot);
+
 	sunsu_startup(&up->port);
 	return 0;
 }
