From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 23 Feb 2013 13:02:54 +0000
Subject: Panic at sunsu driver
Message-Id: <254051361624574@web1h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

I played with sparc64 kernel on QEMU. It creates
single sunsu port and cmdline "console=ttyS1" leads
to kernel panic.

Unable to handle kernel NULL pointer dereference
TPC: <sunsu_console_setup+0x78/0xe0>
RPC: <sunsu_console_setup+0x74/0xe0>
I7: <register_console+0x378/0x3e0>
Call Trace:
 [0000000000453a38] register_console+0x378/0x3e0
 [0000000000576fa0] uart_add_one_port+0x2e0/0x340
 [000000000057af40] su_probe+0x160/0x2e0
 [00000000005b8a4c] platform_drv_probe+0xc/0x20
 [00000000005b6c2c] driver_probe_device+0x12c/0x220
 [00000000005b6da8] __driver_attach+0x88/0xa0
 [00000000005b4df4] bus_for_each_dev+0x54/0xa0
 [00000000005b5a54] bus_add_driver+0x154/0x260
 [00000000005b7190] driver_register+0x50/0x180
 [00000000006d250c] sunsu_init+0x18c/0x1e0
 [00000000006c2668] do_one_initcall+0xe8/0x160
 [00000000006c282c] kernel_init_freeable+0x12c/0x1e0
 [0000000000603764] kernel_init+0x4/0x100
 [0000000000405f64] ret_from_syscall+0x1c/0x2c
 [0000000000000000]           (null)

I fixed sunsu driver a little bit to prevet this.
1)Is real hardware able to have less than 4 ports?
2)If a machine has 4 ports we'll still skip "console=ttyS1"
because it's not registered at the time of the first
call of sunsu_console_setup(the first call is with
index=1), right?

Kirill
---
 drivers/tty/serial/sunsu.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index e343d66..451687c 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -968,6 +968,7 @@ static struct uart_ops sunsu_pops = {
 #define UART_NR	4
 
 static struct uart_sunsu_port sunsu_ports[UART_NR];
+static int nr_inst; /* Number of already registered ports */
 
 #ifdef CONFIG_SERIO
 
@@ -1337,13 +1338,8 @@ static int __init sunsu_console_setup(struct console *co, char *options)
 	printk("Console: ttyS%d (SU)\n",
 	       (sunsu_reg.minor - 64) + co->index);
 
-	/*
-	 * Check whether an invalid uart number has been specified, and
-	 * if so, search for the first available port that does have
-	 * console support.
-	 */
-	if (co->index >= UART_NR)
-		co->index = 0;
+	if (co->index > nr_inst)
+		return -ENODEV;
 	port = &sunsu_ports[co->index].port;
 
 	/*
@@ -1408,7 +1404,6 @@ static enum su_type su_get_type(struct device_node *dp)
 
 static int su_probe(struct platform_device *op)
 {
-	static int inst;
 	struct device_node *dp = op->dev.of_node;
 	struct uart_sunsu_port *up;
 	struct resource *rp;
@@ -1418,16 +1413,16 @@ static int su_probe(struct platform_device *op)
 
 	type = su_get_type(dp);
 	if (type = SU_PORT_PORT) {
-		if (inst >= UART_NR)
+		if (nr_inst >= UART_NR)
 			return -EINVAL;
-		up = &sunsu_ports[inst];
+		up = &sunsu_ports[nr_inst];
 	} else {
 		up = kzalloc(sizeof(*up), GFP_KERNEL);
 		if (!up)
 			return -ENOMEM;
 	}
 
-	up->port.line = inst;
+	up->port.line = nr_inst;
 
 	spin_lock_init(&up->port.lock);
 
@@ -1461,6 +1456,8 @@ static int su_probe(struct platform_device *op)
 		}
 		dev_set_drvdata(&op->dev, up);
 
+		nr_inst++;
+
 		return 0;
 	}
 
@@ -1488,7 +1485,7 @@ static int su_probe(struct platform_device *op)
 
 	dev_set_drvdata(&op->dev, up);
 
-	inst++;
+	nr_inst++;
 
 	return 0;
 
