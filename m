From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2006 03:51:21 +0000
Subject: Re: sparc32 git tree
Message-Id: <20060717.205121.98864363.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Mon, 17 Jul 2006 21:07:17 -0500

> I was debugging with a serial console, so maybe that caused it to fail
> easier.  It triggered an interrupt before initializing the 2nd chip and
> ZILOG_CHANNEL_FROM_PORT() was getting a NULL pointer in the interrupt
> routine when it looped to the 2nd chip.

That makes sense.  Ok, let's try the following.  What this
patch does is defer the IRQ registration until after all
the device structures have been setup fully.

It works here on my sparc64 sbus machine.

Let me know how it goes.

diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index a1456d9..496810c 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1336,12 +1336,11 @@ static int __devinit zs_get_instance(str
 
 static int zilog_irq = -1;
 
-static int __devinit zs_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit zs_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct of_device *op = to_of_device(&dev->dev);
 	struct uart_sunzilog_port *up;
 	struct zilog_layout __iomem *rp;
-	int inst = zs_get_instance(dev->node);
+	int inst = zs_get_instance(op->node);
 	int err;
 
 	sunzilog_chip_regs[inst] = of_ioremap(&op->resource[0], 0,
@@ -1413,7 +1412,7 @@ static int __devinit zs_probe(struct of_
 		}
 	}
 
-	dev_set_drvdata(&dev->dev, &up[0]);
+	dev_set_drvdata(&op->dev, &up[0]);
 
 	return 0;
 }
@@ -1462,18 +1461,19 @@ static struct of_platform_driver zs_driv
 static int __init sunzilog_init(void)
 {
 	struct device_node *dp;
-	int err;
+	int err, uart_count;
 
 	NUM_SUNZILOG = 0;
 	for_each_node_by_name(dp, "zs")
 		NUM_SUNZILOG++;
 
+	uart_count = 0;
 	if (NUM_SUNZILOG) {
 		int uart_count;
 
 		err = sunzilog_alloc_tables();
 		if (err)
-			return err;
+			goto out;
 
 		/* Subtract 1 for keyboard, 1 for mouse.  */
 		uart_count = (NUM_SUNZILOG * 2) - 2;
@@ -1481,17 +1481,41 @@ static int __init sunzilog_init(void)
 		sunzilog_reg.nr = uart_count;
 		sunzilog_reg.minor = sunserial_current_minor;
 		err = uart_register_driver(&sunzilog_reg);
-		if (err) {
-			sunzilog_free_tables();
-			return err;
-		}
+		if (err)
+			goto out_free_tables;
+
 		sunzilog_reg.tty_driver->name_base = sunzilog_reg.minor - 64;
 		sunzilog_reg.cons = SUNZILOG_CONSOLE();
 
 		sunserial_current_minor += uart_count;
 	}
 
-	return of_register_driver(&zs_driver, &of_bus_type);
+	err = of_register_driver(&zs_driver, &of_bus_type);
+	if (err)
+		goto out_unregister_uart;
+
+	if (zilog_irq != -1) {
+		err = request_irq(zilog_irq, sunzilog_interrupt, IRQF_SHARED,
+				  "zs", sunzilog_irq_chain);
+		if (err)
+			goto out_unregister_driver;
+	}
+
+out:
+	return err;
+
+out_unregister_driver:
+	of_unregister_driver(&zs_driver);
+
+out_unregister_uart:
+	if (NUM_SUNZILOG) {
+		uart_unregister_driver(&sunzilog_reg);
+		sunzilog_reg.cons = NULL;
+	}
+
+out_free_tables:
+	sunzilog_free_tables();
+	goto out;
 }
 
 static void __exit sunzilog_exit(void)
