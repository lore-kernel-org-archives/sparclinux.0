From: Bob Breuer <breuerr@mc.net>
Date: Mon, 17 Jul 2006 15:45:16 +0000
Subject: Re: sparc32 git tree
Message-Id: <44BBB08C.3090004@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000107090909000706020704"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000107090909000706020704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ray,

I think I've found the core problem with the prom properties, and a
potential problem with the zilog initialization.  Could you try the
attached patch and let me know if it works for you?

Thanks,
Bob

--------------000107090909000706020704
Content-Type: text/plain;
 name="sparc32-fix_prom_probing.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32-fix_prom_probing.txt"

diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index 4b06dcb..4ca9e5f 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -444,6 +444,7 @@ static struct property * __init build_on
 	static struct property *tmp = NULL;
 	struct property *p;
 	int len;
+	const char *name;
 
 	if (tmp) {
 		p = tmp;
@@ -456,19 +457,21 @@ static struct property * __init build_on
 
 	p->name = (char *) (p + 1);
 	if (special_name) {
+		strcpy(p->name, special_name);
 		p->length = special_len;
 		p->value = prom_early_alloc(special_len);
 		memcpy(p->value, special_val, special_len);
 	} else {
 		if (prev == NULL) {
-			prom_firstprop(node, p->name);
+			name = prom_firstprop(node, NULL);
 		} else {
-			prom_nextprop(node, prev, p->name);
+			name = prom_nextprop(node, prev, NULL);
 		}
-		if (strlen(p->name) == 0) {
+		if (strlen(name) == 0) {
 			tmp = p;
 			return NULL;
 		}
+		strcpy(p->name, name);
 		p->length = prom_getproplen(node, p->name);
 		if (p->length <= 0) {
 			p->length = 0;
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index a1456d9..b88f7de 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -524,7 +524,6 @@ static irqreturn_t sunzilog_interrupt(in
 {
 	struct uart_sunzilog_port *up = dev_id;
 
-	while (up) {
 		struct zilog_channel __iomem *channel
 			= ZILOG_CHANNEL_FROM_PORT(&up->port);
 		struct tty_struct *tty;
@@ -575,9 +574,6 @@ static irqreturn_t sunzilog_interrupt(in
 		if (tty)
 			tty_flip_buffer_push(tty);
 
-		up = up->next;
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -1352,18 +1348,17 @@ static int __devinit zs_probe(struct of_
 
 	rp = sunzilog_chip_regs[inst];
 
-	if (zilog_irq == -1) {
+	up = &sunzilog_port_table[inst * 2];
+	//if (zilog_irq == -1) {
 		zilog_irq = op->irqs[0];
 		err = request_irq(zilog_irq, sunzilog_interrupt, IRQF_SHARED,
-				  "zs", sunzilog_irq_chain);
+				  "zs", up);
 		if (err) {
 			of_iounmap(rp, sizeof(struct zilog_layout));
 
 			return err;
 		}
-	}
-
-	up = &sunzilog_port_table[inst * 2];
+	//}
 
 	/* Channel A */
 	up[0].port.mapbase = op->resource[0].start + 0x00;

--------------000107090909000706020704--
