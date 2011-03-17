From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 17 Mar 2011 07:06:57 +0000
Subject: [PATCH 1/2 v2] sparc32,leon: APBUART driver must use archdata to get IRQ number
Message-Id: <1300345617-24602-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

See Commit id 1636f8ac2b08410df4766449f7c86b912443cd99 (sparc/of:
Move of_device fields into struct pdev_archdata), this patch
is similar to 19e4875fb21a69fbf620e84769a74d189c69c58d (of/sparc:
fix build regression from of_device changes)

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/tty/serial/apbuart.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 095a5d5..de286d9 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -556,10 +556,9 @@ static struct uart_driver grlib_apbuart_driver = {
 static int __devinit apbuart_probe(struct platform_device *op,
 				   const struct of_device_id *match)
 {
-	int i = -1;
+	int i;
 	struct uart_port *port = NULL;
 
-	i = 0;
 	for (i = 0; i < grlib_apbuart_port_nr; i++) {
 		if (op->dev.of_node = grlib_apbuart_nodes[i])
 			break;
@@ -567,6 +566,7 @@ static int __devinit apbuart_probe(struct platform_device *op,
 
 	port = &grlib_apbuart_ports[i];
 	port->dev = &op->dev;
+	port->irq = op->archdata.irqs[0];
 
 	uart_add_one_port(&grlib_apbuart_driver, (struct uart_port *) port);
 
@@ -616,7 +616,7 @@ static int grlib_apbuart_configure(void)
 	freq_khz = *prop;
 
 	for_each_matching_node(np, apbuart_match) {
-		const int *irqs, *ampopts;
+		const int *ampopts;
 		const struct amba_prom_registers *regs;
 		struct uart_port *port;
 		unsigned long addr;
@@ -624,11 +624,9 @@ static int grlib_apbuart_configure(void)
 		ampopts = of_get_property(np, "ampopts", NULL);
 		if (ampopts && (*ampopts = 0))
 			continue; /* Ignore if used by another OS instance */
-
-		irqs = of_get_property(np, "interrupts", NULL);
 		regs = of_get_property(np, "reg", NULL);
 
-		if (!irqs || !regs)
+		if (!regs)
 			continue;
 
 		grlib_apbuart_nodes[line] = np;
@@ -639,7 +637,7 @@ static int grlib_apbuart_configure(void)
 
 		port->mapbase = addr;
 		port->membase = ioremap(addr, sizeof(struct grlib_apbuart_regs_map));
-		port->irq = *irqs;
+		port->irq = 0;
 		port->iotype = UPIO_MEM;
 		port->ops = &grlib_apbuart_ops;
 		port->flags = UPF_BOOT_AUTOCONF;
-- 
1.5.4

