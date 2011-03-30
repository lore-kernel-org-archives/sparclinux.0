From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 30 Mar 2011 10:31:49 +0000
Subject: [PATCH 2/2 v3] sparc32,leon: Fixed APBUART frequency detection
Message-Id: <1301481109-1207-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The UARTs may be located on different APB buses, thus have
different UART clock frequency. The system frequency is not
the same (but often) as the UART frequency, rather the APB bus
frequency that the APBUART is located at has the same
frequency, so this looks at the "freq" property instead.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/tty/serial/apbuart.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 12d4e7c..19a9436 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -598,24 +598,12 @@ static struct platform_driver grlib_apbuart_of_driver = {
 
 static int grlib_apbuart_configure(void)
 {
-	struct device_node *np, *rp;
-	const u32 *prop;
-	int freq_khz, line = 0;
-
-	/* Get bus frequency */
-	rp = of_find_node_by_path("/");
-	if (!rp)
-		return -ENODEV;
-	rp = of_get_next_child(rp, NULL);
-	if (!rp)
-		return -ENODEV;
-	prop = of_get_property(rp, "clock-frequency", NULL);
-	if (!prop)
-		return -ENODEV;
-	freq_khz = *prop;
+	struct device_node *np;
+	int line = 0;
 
 	for_each_matching_node(np, apbuart_match) {
 		const int *ampopts;
+		const u32 *freq_hz;
 		const struct amba_prom_registers *regs;
 		struct uart_port *port;
 		unsigned long addr;
@@ -624,8 +612,10 @@ static int grlib_apbuart_configure(void)
 		if (ampopts && (*ampopts = 0))
 			continue; /* Ignore if used by another OS instance */
 		regs = of_get_property(np, "reg", NULL);
+		/* Frequency of APB Bus is frequency of UART */
+		freq_hz = of_get_property(np, "freq", NULL);
 
-		if (!regs)
+		if (!regs || !freq_hz || (*freq_hz = 0))
 			continue;
 
 		grlib_apbuart_nodes[line] = np;
@@ -641,7 +631,7 @@ static int grlib_apbuart_configure(void)
 		port->ops = &grlib_apbuart_ops;
 		port->flags = UPF_BOOT_AUTOCONF;
 		port->line = line;
-		port->uartclk = freq_khz * 1000;
+		port->uartclk = *freq_hz;
 		port->fifosize = apbuart_scan_fifo_size((struct uart_port *) port, line);
 		line++;
 
-- 
1.5.4

