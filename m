From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 11:41:18 +0000
Subject: [sparc32] [3/4] sunsu.c serio #ifdef crud
Message-Id: <20041221114118.GN771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The variable serio is only used in code conditional on CONFIG_SERIO.

Index: sparc32-2.6.10-rc3/drivers/serial/sunsu.c
=================================--- sparc32-2.6.10-rc3.orig/drivers/serial/sunsu.c	2004-12-16 06:19:49.000000000 -0800
+++ sparc32-2.6.10-rc3/drivers/serial/sunsu.c	2004-12-21 03:24:30.676490386 -0800
@@ -1285,7 +1285,9 @@
 
 static int __init sunsu_kbd_ms_init(struct uart_sunsu_port *up, int channel)
 {
+#ifdef CONFIG_SERIO
 	struct serio *serio;
+#endif
 
 	up->port.line = channel;
 	up->port.type = PORT_UNKNOWN;
