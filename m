From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 31 Oct 2004 21:45:13 +0000
Subject: Re: [PATCH] sunsu.c
Message-Id: <20041031134513.1831afe6.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4175D5D4.3090702@starhub.net.sg>
In-Reply-To: <4175D5D4.3090702@starhub.net.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Thanks again for your report and patch.

The up->irq value was just duplicating up->port.irq so
I've fixed this by deleting the former entirely.

=== drivers/serial/sunsu.c 1.45 vs edited ==--- 1.45/drivers/serial/sunsu.c	2004-09-20 13:46:03 -07:00
+++ edited/drivers/serial/sunsu.c	2004-10-31 13:30:54 -08:00
@@ -95,7 +95,6 @@
 	enum su_type		su_type;
 	unsigned int		type_probed;	/* XXX Stupid */
 	int			port_node;
-	unsigned int		irq;
 
 #ifdef CONFIG_SERIO
 	struct serio		*serio;
@@ -684,14 +683,14 @@
 	}
 
 	if (up->su_type != SU_PORT_PORT) {
-		retval = request_irq(up->irq, sunsu_kbd_ms_interrupt,
+		retval = request_irq(up->port.irq, sunsu_kbd_ms_interrupt,
 				     SA_SHIRQ, su_typev[up->su_type], up);
 	} else {
-		retval = request_irq(up->irq, sunsu_serial_interrupt,
+		retval = request_irq(up->port.irq, sunsu_serial_interrupt,
 				     SA_SHIRQ, su_typev[up->su_type], up);
 	}
 	if (retval) {
-		printk("su: Cannot register IRQ %d\n", up->irq);
+		printk("su: Cannot register IRQ %d\n", up->port.irq);
 		return retval;
 	}
 
@@ -779,7 +778,7 @@
 	 */
 	(void) serial_in(up, UART_RX);
 
-	free_irq(up->irq, up);
+	free_irq(up->port.irq, up);
 }
 
 static void
@@ -1078,7 +1077,7 @@
 				 * This is correct on both architectures.
 				 */
 				up->port.mapbase = dev->resource[0].start;
-				up->irq = dev->irqs[0];
+				up->port.irq = dev->irqs[0];
 				goto ebus_done;
 			}
 		}
@@ -1091,7 +1090,7 @@
 				/* Same on sparc64. Cool architecure... */
 				up->port.membase = (char *) isa_dev->resource.start;
 				up->port.mapbase = isa_dev->resource.start;
-				up->irq = isa_dev->irq;
+				up->port.irq = isa_dev->irq;
 				goto ebus_done;
 			}
 		}
@@ -1133,7 +1132,7 @@
 	/*
 	 * There is no intr property on MrCoffee, so hardwire it.
 	 */
-	up->irq = IRQ_4M(13);
+	up->port.irq = IRQ_4M(13);
 #endif
 
 ebus_done:
@@ -1303,7 +1302,7 @@
 
 	printk(KERN_INFO "su%d at 0x%p (irq = %s) is a %s\n",
 	       channel,
-	       up->port.membase, __irq_itoa(up->irq),
+	       up->port.membase, __irq_itoa(up->port.irq),
 	       sunsu_type(&up->port));
 
 #ifdef CONFIG_SERIO
