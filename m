From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2006 05:45:28 +0000
Subject: Re: sparc32 git tree
Message-Id: <20060719.224528.112289014.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Wed, 19 Jul 2006 09:36:27 -0700 (PDT)

> zs_get_instance returns a value 0 or 1 . zs occurance greater then
> that never get structure initialized.

So stupid, sorry about that.   This logic will definitely not
work for sun4d, especially ss2000 systems.

Let's do the instance enumeration like the following patch.
It should do the right thing and it shouldn't mark some of
your sun4d zilogs as being for the keyboard/mouse :)

diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index 18df10f..0f68fbd 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -68,9 +68,6 @@ static int num_sunzilog;
 #define NUM_SUNZILOG	num_sunzilog
 #define NUM_CHANNELS	(NUM_SUNZILOG * 2)
 
-#define KEYBOARD_LINE 0x2
-#define MOUSE_LINE    0x3
-
 #define ZS_CLOCK		4915200 /* Zilog input clock rate. */
 #define ZS_CLOCK_DIVISOR	16      /* Divisor this driver uses. */
 
@@ -1225,12 +1222,10 @@ static void __init sunzilog_init_kbdms(s
 {
 	int baud, brg;
 
-	if (channel = KEYBOARD_LINE) {
-		up->flags |= SUNZILOG_FLAG_CONS_KEYB;
+	if (up->flags & SUNZILOG_FLAG_CONS_KEYB) {
 		up->cflag = B1200 | CS8 | CLOCAL | CREAD;
 		baud = 1200;
 	} else {
-		up->flags |= SUNZILOG_FLAG_CONS_MOUSE;
 		up->cflag = B4800 | CS8 | CLOCAL | CREAD;
 		baud = 4800;
 	}
@@ -1243,14 +1238,14 @@ static void __init sunzilog_init_kbdms(s
 }
 
 #ifdef CONFIG_SERIO
-static void __init sunzilog_register_serio(struct uart_sunzilog_port *up, int channel)
+static void __init sunzilog_register_serio(struct uart_sunzilog_port *up)
 {
 	struct serio *serio = &up->serio;
 
 	serio->port_data = up;
 
 	serio->id.type = SERIO_RS232;
-	if (channel = KEYBOARD_LINE) {
+	if (up->flags & SUNZILOG_FLAG_CONS_KEYB) {
 		serio->id.proto = SERIO_SUNKBD;
 		strlcpy(serio->name, "zskbd", sizeof(serio->name));
 	} else {
@@ -1259,7 +1254,8 @@ static void __init sunzilog_register_ser
 		strlcpy(serio->name, "zsms", sizeof(serio->name));
 	}
 	strlcpy(serio->phys,
-		(channel = KEYBOARD_LINE ? "zs/serio0" : "zs/serio1"),
+		((up->flags & SUNZILOG_FLAG_CONS_KEYB) ?
+		 "zs/serio0" : "zs/serio1"),
 		sizeof(serio->phys));
 
 	serio->write = sunzilog_serio_write;
@@ -1286,8 +1282,8 @@ static void __init sunzilog_init_hw(stru
 		(void) read_zsreg(channel, R0);
 	}
 
-	if (up->port.line = KEYBOARD_LINE ||
-	    up->port.line = MOUSE_LINE) {
+	if (up->flags & (SUNZILOG_FLAG_CONS_KEYB |
+			 SUNZILOG_FLAG_CONS_MOUSE)) {
 		sunzilog_init_kbdms(up, up->port.line);
 		up->curregs[R9] |= (NV | MIE);
 		write_zsreg(channel, R9, up->curregs[R9]);
@@ -1313,36 +1309,26 @@ static void __init sunzilog_init_hw(stru
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 #ifdef CONFIG_SERIO
-	if (up->port.line = KEYBOARD_LINE || up->port.line = MOUSE_LINE)
-		sunzilog_register_serio(up, up->port.line);
+	if (up->flags & (SUNZILOG_FLAG_CONS_KEYB |
+			 SUNZILOG_FLAG_CONS_MOUSE))
+		sunzilog_register_serio(up);
 #endif
 }
 
-static int __devinit zs_get_instance(struct device_node *dp)
-{
-	int ret;
-
-	ret = of_getintprop_default(dp, "slave", -1);
-	if (ret != -1)
-		return ret;
-
-	if (of_find_property(dp, "keyboard", NULL))
-		ret = 1;
-	else
-		ret = 0;
-
-	return ret;
-}
-
 static int zilog_irq = -1;
 
 static int __devinit zs_probe(struct of_device *op, const struct of_device_id *match)
 {
+	static int inst;
 	struct uart_sunzilog_port *up;
 	struct zilog_layout __iomem *rp;
-	int inst = zs_get_instance(op->node);
+	int keyboard_mouse;
 	int err;
 
+	keyboard_mouse = 0;
+	if (of_find_property(op->node, "keyboard", NULL))
+		keyboard_mouse = 1;
+
 	sunzilog_chip_regs[inst] = of_ioremap(&op->resource[0], 0,
 					      sizeof(struct zilog_layout),
 					      "zs");
@@ -1369,7 +1355,7 @@ static int __devinit zs_probe(struct of_
 	up[0].port.line = (inst * 2) + 0;
 	up[0].port.dev = &op->dev;
 	up[0].flags |= SUNZILOG_FLAG_IS_CHANNEL_A;
-	if (inst = 1)
+	if (keyboard_mouse)
 		up[0].flags |= SUNZILOG_FLAG_CONS_KEYB;
 	sunzilog_init_hw(&up[0]);
 
@@ -1386,11 +1372,11 @@ static int __devinit zs_probe(struct of_
 	up[1].port.line = (inst * 2) + 1;
 	up[1].port.dev = &op->dev;
 	up[1].flags |= 0;
-	if (inst = 1)
+	if (keyboard_mouse)
 		up[1].flags |= SUNZILOG_FLAG_CONS_MOUSE;
 	sunzilog_init_hw(&up[1]);
 
-	if (inst != 1) {
+	if (!keyboard_mouse) {
 		err = uart_add_one_port(&sunzilog_reg, &up[0].port);
 		if (err) {
 			of_iounmap(rp, sizeof(struct zilog_layout));
@@ -1406,6 +1392,8 @@ static int __devinit zs_probe(struct of_
 
 	dev_set_drvdata(&op->dev, &up[0]);
 
+	inst++;
+
 	return 0;
 }
 
@@ -1454,10 +1442,15 @@ static int __init sunzilog_init(void)
 {
 	struct device_node *dp;
 	int err, uart_count;
+	int num_keybms;
 
 	NUM_SUNZILOG = 0;
-	for_each_node_by_name(dp, "zs")
+	num_keybms = 0;
+	for_each_node_by_name(dp, "zs") {
 		NUM_SUNZILOG++;
+		if (of_find_property(dp, "keyboard", NULL))
+			num_keybms++;
+	}
 
 	uart_count = 0;
 	if (NUM_SUNZILOG) {
@@ -1467,8 +1460,7 @@ static int __init sunzilog_init(void)
 		if (err)
 			goto out;
 
-		/* Subtract 1 for keyboard, 1 for mouse.  */
-		uart_count = (NUM_SUNZILOG * 2) - 2;
+		uart_count = (NUM_SUNZILOG * 2) - (2 * num_keybms);
 
 		sunzilog_reg.nr = uart_count;
 		sunzilog_reg.minor = sunserial_current_minor;
