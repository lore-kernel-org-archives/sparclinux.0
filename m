From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Tue, 31 May 2016 14:19:31 +0000
Subject: [RFT PATCH 1/2] serial: Fix console setup section mismatch
Message-Id: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove __init annotation from all of console->setup implementations
because:
1. The pointer to it is stored in a struct console which is not
   marked with __initdata.
2. It is referenced by register_console() from kernel which is not
   marked with __init.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Drivers only build tested (and maybe some of them not built at all).
---
 drivers/tty/serial/21285.c           |  7 +++----
 drivers/tty/serial/altera_jtaguart.c |  2 +-
 drivers/tty/serial/altera_uart.c     |  2 +-
 drivers/tty/serial/amba-pl010.c      |  7 +++----
 drivers/tty/serial/amba-pl011.c      |  7 +++----
 drivers/tty/serial/apbuart.c         |  7 +++----
 drivers/tty/serial/atmel_serial.c    |  4 ++--
 drivers/tty/serial/bfin_sport_uart.c |  3 +--
 drivers/tty/serial/bfin_uart.c       |  8 +++-----
 drivers/tty/serial/dz.c              |  2 +-
 drivers/tty/serial/etraxfs-uart.c    |  3 +--
 drivers/tty/serial/fsl_lpuart.c      | 12 +++++-------
 drivers/tty/serial/imx.c             |  8 +++-----
 drivers/tty/serial/ip22zilog.c       |  2 +-
 drivers/tty/serial/lantiq.c          |  3 +--
 drivers/tty/serial/lpc32xx_hs.c      |  4 ++--
 drivers/tty/serial/m32r_sio.c        |  2 +-
 drivers/tty/serial/mcf.c             |  2 +-
 drivers/tty/serial/mpc52xx_uart.c    |  8 +++-----
 drivers/tty/serial/mpsc.c            |  2 +-
 drivers/tty/serial/msm_serial.c      |  2 +-
 drivers/tty/serial/mxs-auart.c       |  8 +++-----
 drivers/tty/serial/netx-serial.c     |  8 +++-----
 drivers/tty/serial/omap-serial.c     |  3 +--
 drivers/tty/serial/pch_uart.c        |  2 +-
 drivers/tty/serial/pmac_zilog.c      |  2 +-
 drivers/tty/serial/pnx8xxx_uart.c    |  3 +--
 drivers/tty/serial/pxa.c             |  3 +--
 drivers/tty/serial/sa1100.c          |  8 +++-----
 drivers/tty/serial/samsung.c         |  8 +++-----
 drivers/tty/serial/sb1250-duart.c    |  2 +-
 drivers/tty/serial/serial_ks8695.c   |  5 +++--
 drivers/tty/serial/serial_txx9.c     |  2 +-
 drivers/tty/serial/sirfsoc_uart.c    |  3 +--
 drivers/tty/serial/sprd_serial.c     |  2 +-
 drivers/tty/serial/sunsu.c           |  2 +-
 drivers/tty/serial/sunzilog.c        |  2 +-
 drivers/tty/serial/vr41xx_siu.c      |  2 +-
 drivers/tty/serial/vt8500_serial.c   |  2 +-
 drivers/tty/serial/xilinx_uartps.c   |  2 +-
 drivers/tty/serial/zs.c              |  2 +-
 41 files changed, 71 insertions(+), 97 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 9b208bd686e6..8af51a451c5e 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -381,9 +381,8 @@ serial21285_console_write(struct console *co, const char *s,
 	uart_console_write(&serial21285_port, s, count, serial21285_console_putchar);
 }
 
-static void __init
-serial21285_get_options(struct uart_port *port, int *baud,
-			int *parity, int *bits)
+static void serial21285_get_options(struct uart_port *port, int *baud,
+				    int *parity, int *bits)
 {
 	if (*CSR_UARTCON = 1) {
 		unsigned int tmp;
@@ -417,7 +416,7 @@ serial21285_get_options(struct uart_port *port, int *baud,
 	}
 }
 
-static int __init serial21285_console_setup(struct console *co, char *options)
+static int serial21285_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = &serial21285_port;
 	int baud = 9600;
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 32df2a0cb060..a13457a85043 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -348,7 +348,7 @@ static void altera_jtaguart_console_write(struct console *co, const char *s,
 	uart_console_write(port, s, count, altera_jtaguart_console_putc);
 }
 
-static int __init altera_jtaguart_console_setup(struct console *co,
+static int altera_jtaguart_console_setup(struct console *co,
 						char *options)
 {
 	struct uart_port *port;
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 61b607f2488e..64255c4878ed 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -447,7 +447,7 @@ static void altera_uart_console_write(struct console *co, const char *s,
 	uart_console_write(port, s, count, altera_uart_console_putc);
 }
 
-static int __init altera_uart_console_setup(struct console *co, char *options)
+static int altera_uart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = CONFIG_SERIAL_ALTERA_UART_BAUDRATE;
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 5d41d5b92619..6e54fb819855 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -620,9 +620,8 @@ pl010_console_write(struct console *co, const char *s, unsigned int count)
 	clk_disable(uap->clk);
 }
 
-static void __init
-pl010_console_get_options(struct uart_amba_port *uap, int *baud,
-			     int *parity, int *bits)
+static void pl010_console_get_options(struct uart_amba_port *uap, int *baud,
+				      int *parity, int *bits)
 {
 	if (readb(uap->port.membase + UART010_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, quot;
@@ -647,7 +646,7 @@ pl010_console_get_options(struct uart_amba_port *uap, int *baud,
 	}
 }
 
-static int __init pl010_console_setup(struct console *co, char *options)
+static int pl010_console_setup(struct console *co, char *options)
 {
 	struct uart_amba_port *uap;
 	int baud = 38400;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1b7331e40d79..3aee1bffbbdf 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2203,9 +2203,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	clk_disable(uap->clk);
 }
 
-static void __init
-pl011_console_get_options(struct uart_amba_port *uap, int *baud,
-			     int *parity, int *bits)
+static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
+				      int *parity, int *bits)
 {
 	if (pl011_read(uap, REG_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, ibrd, fbrd;
@@ -2238,7 +2237,7 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 	}
 }
 
-static int __init pl011_console_setup(struct console *co, char *options)
+static int pl011_console_setup(struct console *co, char *options)
 {
 	struct uart_amba_port *uap;
 	int baud = 38400;
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 75eb083b3361..77b7881a8931 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -450,9 +450,8 @@ apbuart_console_write(struct console *co, const char *s, unsigned int count)
 	UART_PUT_CTRL(port, old_cr);
 }
 
-static void __init
-apbuart_console_get_options(struct uart_port *port, int *baud,
-			    int *parity, int *bits)
+static void apbuart_console_get_options(struct uart_port *port, int *baud,
+					int *parity, int *bits)
 {
 	if (UART_GET_CTRL(port) & (UART_CTRL_RE | UART_CTRL_TE)) {
 
@@ -473,7 +472,7 @@ apbuart_console_get_options(struct uart_port *port, int *baud,
 	}
 }
 
-static int __init apbuart_console_setup(struct console *co, char *options)
+static int apbuart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 38400;
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 954941dd8124..fa71aac07a8c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2410,7 +2410,7 @@ static void atmel_console_write(struct console *co, const char *s, u_int count)
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init atmel_console_get_options(struct uart_port *port, int *baud,
+static void atmel_console_get_options(struct uart_port *port, int *baud,
 					     int *parity, int *bits)
 {
 	unsigned int mr, quot;
@@ -2444,7 +2444,7 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
 	*baud = port->uartclk / (16 * (quot - 1));
 }
 
-static int __init atmel_console_setup(struct console *co, char *options)
+static int atmel_console_setup(struct console *co, char *options)
 {
 	int ret;
 	struct uart_port *port = &atmel_ports[co->index].uart;
diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 984e1c050096..b0407c1bc31d 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -609,8 +609,7 @@ static struct sport_uart_port *bfin_sport_uart_ports[BFIN_SPORT_UART_MAX_PORTS];
 #ifdef CONFIG_SERIAL_BFIN_SPORT_CONSOLE
 #define CLASS_BFIN_SPORT_CONSOLE	"bfin-sport-console"
 
-static int __init
-sport_uart_console_setup(struct console *co, char *options)
+static int sport_uart_console_setup(struct console *co, char *options)
 {
 	struct sport_uart_port *up;
 	int baud = 57600;
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 293ecbb00684..42f2dc66adda 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -1035,9 +1035,8 @@ static struct uart_ops bfin_serial_pops = {
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
-bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
-			   int *parity, int *bits)
+static void bfin_serial_console_get_options(struct bfin_serial_port *uart,
+					    int *baud, int *parity, int *bits)
 {
 	unsigned int status;
 
@@ -1100,8 +1099,7 @@ bfin_serial_console_write(struct console *co, const char *s, unsigned int count)
 
 }
 
-static int __init
-bfin_serial_console_setup(struct console *co, char *options)
+static int bfin_serial_console_setup(struct console *co, char *options)
 {
 	struct bfin_serial_port *uart;
 	int baud = 57600;
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index c121f16a973f..5d8e67b137ed 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -860,7 +860,7 @@ static void dz_console_print(struct console *co,
 	uart_console_write(&dport->port, str, count, dz_console_putchar);
 }
 
-static int __init dz_console_setup(struct console *co, char *options)
+static int dz_console_setup(struct console *co, char *options)
 {
 	struct dz_port *dport = &dz_mux.dport[co->index];
 	struct uart_port *uport = &dport->port;
diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etraxfs-uart.c
index 2f80bc7e44fb..a7eefb3c0a88 100644
--- a/drivers/tty/serial/etraxfs-uart.c
+++ b/drivers/tty/serial/etraxfs-uart.c
@@ -86,8 +86,7 @@ cris_console_write(struct console *co, const char *s, unsigned int count)
 		REG_WR(ser, up->regi_ser, rw_tr_dma_en, old);
 }
 
-static int __init
-cris_console_setup(struct console *co, char *options)
+static int cris_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 115200;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3d790033744e..ce6030dca617 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1597,9 +1597,8 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
  * if the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
-lpuart_console_get_options(struct lpuart_port *sport, int *baud,
-			   int *parity, int *bits)
+static void lpuart_console_get_options(struct lpuart_port *sport, int *baud,
+				       int *parity, int *bits)
 {
 	unsigned char cr, bdh, bdl, brfa;
 	unsigned int sbr, uartclk, baud_raw;
@@ -1646,9 +1645,8 @@ lpuart_console_get_options(struct lpuart_port *sport, int *baud,
 				"from %d to %d\n", baud_raw, *baud);
 }
 
-static void __init
-lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
-			   int *parity, int *bits)
+static void lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
+					 int *parity, int *bits)
 {
 	unsigned long cr, bd;
 	unsigned int sbr, uartclk, baud_raw;
@@ -1689,7 +1687,7 @@ lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 				"from %d to %d\n", baud_raw, *baud);
 }
 
-static int __init lpuart_console_setup(struct console *co, char *options)
+static int lpuart_console_setup(struct console *co, char *options)
 {
 	struct lpuart_port *sport;
 	int baud = 115200;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0df2b1c091ae..0734330ff9c5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1791,9 +1791,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
-imx_console_get_options(struct imx_port *sport, int *baud,
-			   int *parity, int *bits)
+static void imx_console_get_options(struct imx_port *sport, int *baud,
+				    int *parity, int *bits)
 {
 
 	if (readl(sport->port.membase + UCR1) & UCR1_UARTEN) {
@@ -1850,8 +1849,7 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 	}
 }
 
-static int __init
-imx_console_setup(struct console *co, char *options)
+static int imx_console_setup(struct console *co, char *options)
 {
 	struct imx_port *sport;
 	int baud = 9600;
diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 991e6dce916e..f57c09e9569d 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -1027,7 +1027,7 @@ ip22zilog_console_write(struct console *con, const char *s, unsigned int count)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-static int __init ip22zilog_console_setup(struct console *con, char *options)
+static int ip22zilog_console_setup(struct console *con, char *options)
 {
 	struct uart_ip22zilog_port *up = &ip22zilog_port_table[con->index];
 	unsigned long flags;
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index b88832e8ee82..2a73fca6a767 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -612,8 +612,7 @@ lqasc_console_write(struct console *co, const char *s, u_int count)
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 }
 
-static int __init
-lqasc_console_setup(struct console *co, char *options)
+static int lqasc_console_setup(struct console *co, char *options)
 {
 	struct ltq_uart_port *ltq_port;
 	struct uart_port *port;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 7eb04ae71cc8..eea59136b92d 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -160,8 +160,8 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static int __init lpc32xx_hsuart_console_setup(struct console *co,
-					       char *options)
+static int lpc32xx_hsuart_console_setup(struct console *co,
+					char *options)
 {
 	struct uart_port *port;
 	int baud = 115200;
diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 68765f7c2645..600fbfaf9c18 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -981,7 +981,7 @@ static void m32r_sio_console_write(struct console *co, const char *s,
 	sio_out(up, SIOTRCR, ier);
 }
 
-static int __init m32r_sio_console_setup(struct console *co, char *options)
+static int m32r_sio_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 02eb32217685..cf28c2ff6d1a 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -546,7 +546,7 @@ static void mcf_console_write(struct console *co, const char *s, unsigned int co
 
 /****************************************************************************/
 
-static int __init mcf_console_setup(struct console *co, char *options)
+static int mcf_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = CONFIG_SERIAL_MCF_BAUDRATE;
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3970d6a9aaca..9ebdb7ab1786 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1537,9 +1537,8 @@ mpc52xx_uart_int(int irq, void *dev_id)
 
 #ifdef CONFIG_SERIAL_MPC52xx_CONSOLE
 
-static void __init
-mpc52xx_console_get_options(struct uart_port *port,
-			    int *baud, int *parity, int *bits, int *flow)
+static void mpc52xx_console_get_options(struct uart_port *port, int *baud,
+					int *parity, int *bits, int *flow)
 {
 	unsigned char mr1;
 
@@ -1607,8 +1606,7 @@ mpc52xx_console_write(struct console *co, const char *s, unsigned int count)
 }
 
 
-static int __init
-mpc52xx_console_setup(struct console *co, char *options)
+static int mpc52xx_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
 	struct device_node *np = mpc52xx_uart_nodes[co->index];
diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 4a3021bcc859..09de17f50dbd 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -1762,7 +1762,7 @@ static void mpsc_console_write(struct console *co, const char *s, uint count)
 	spin_unlock_irqrestore(&pi->tx_lock, iflags);
 }
 
-static int __init mpsc_console_setup(struct console *co, char *options)
+static int mpsc_console_setup(struct console *co, char *options)
 {
 	struct mpsc_port_info *pi;
 	int baud, bits, parity, flow;
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b7d80bd57db9..cb93e43e1537 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1468,7 +1468,7 @@ static void msm_console_write(struct console *co, const char *s,
 	__msm_console_write(port, s, count, msm_port->is_uartdm);
 }
 
-static int __init msm_console_setup(struct console *co, char *options)
+static int msm_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 115200;
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index eb54e5c77ead..ec9a52c32f47 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1400,9 +1400,8 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
 	clk_disable(s->clk);
 }
 
-static void __init
-auart_console_get_options(struct mxs_auart_port *s, int *baud,
-			  int *parity, int *bits)
+static void auart_console_get_options(struct mxs_auart_port *s, int *baud,
+				      int *parity, int *bits)
 {
 	struct uart_port *port = &s->port;
 	unsigned int lcr_h, quot;
@@ -1435,8 +1434,7 @@ auart_console_get_options(struct mxs_auart_port *s, int *baud,
 	*baud = (port->uartclk << 2) / quot;
 }
 
-static int __init
-auart_console_setup(struct console *co, char *options)
+static int auart_console_setup(struct console *co, char *options)
 {
 	struct mxs_auart_port *s;
 	int baud = 9600;
diff --git a/drivers/tty/serial/netx-serial.c b/drivers/tty/serial/netx-serial.c
index 207a0a032ed1..78ded531ce75 100644
--- a/drivers/tty/serial/netx-serial.c
+++ b/drivers/tty/serial/netx-serial.c
@@ -547,9 +547,8 @@ netx_console_write(struct console *co, const char *s, unsigned int count)
 	writel(cr_save, port->membase + UART_CR);
 }
 
-static void __init
-netx_console_get_options(struct uart_port *port, int *baud,
-			int *parity, int *bits, int *flow)
+static void netx_console_get_options(struct uart_port *port, int *baud,
+				     int *parity, int *bits, int *flow)
 {
 	unsigned char line_cr;
 
@@ -589,8 +588,7 @@ netx_console_get_options(struct uart_port *port, int *baud,
 		*flow = 'r';
 }
 
-static int __init
-netx_console_setup(struct console *co, char *options)
+static int netx_console_setup(struct console *co, char *options)
 {
 	struct netx_port *sport;
 	int baud = 9600;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a2a529994ba5..4aea63b20780 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1296,8 +1296,7 @@ serial_omap_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static int __init
-serial_omap_console_setup(struct console *co, char *options)
+static int serial_omap_console_setup(struct console *co, char *options)
 {
 	struct uart_omap_port *up;
 	int baud = 115200;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index ea4ffc2ebb2f..61b3c28e83aa 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1694,7 +1694,7 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
 	local_irq_restore(flags);
 }
 
-static int __init pch_console_setup(struct console *co, char *options)
+static int pch_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = default_baud;
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index e156e39d620c..1292c6c9b9c5 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1991,7 +1991,7 @@ static void pmz_console_write(struct console *con, const char *s, unsigned int c
 /*
  * Setup the serial console
  */
-static int __init pmz_console_setup(struct console *co, char *options)
+static int pmz_console_setup(struct console *co, char *options)
 {
 	struct uart_pmac_port *uap;
 	struct uart_port *port;
diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 7a3bb9cf1f2e..84c4efdde8dc 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -721,8 +721,7 @@ pnx8xxx_console_write(struct console *co, const char *s, unsigned int count)
 	serial_out(sport, PNX8XXX_IEN, old_ien);
 }
 
-static int __init
-pnx8xxx_console_setup(struct console *co, char *options)
+static int pnx8xxx_console_setup(struct console *co, char *options)
 {
 	struct pnx8xxx_port *sport;
 	int baud = 38400;
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 41eab75ba2af..215a1ba687a7 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -727,8 +727,7 @@ static void serial_pxa_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-static int __init
-serial_pxa_console_setup(struct console *co, char *options)
+static int serial_pxa_console_setup(struct console *co, char *options)
 {
 	struct uart_pxa_port *up;
 	int baud = 9600;
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index fd3d1329d48c..2ad0bf2af484 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -745,9 +745,8 @@ sa1100_console_write(struct console *co, const char *s, unsigned int count)
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
-sa1100_console_get_options(struct sa1100_port *sport, int *baud,
-			   int *parity, int *bits)
+static void sa1100_console_get_options(struct sa1100_port *sport, int *baud,
+				       int *parity, int *bits)
 {
 	unsigned int utcr3;
 
@@ -777,8 +776,7 @@ sa1100_console_get_options(struct sa1100_port *sport, int *baud,
 	}
 }
 
-static int __init
-sa1100_console_setup(struct console *co, char *options)
+static int sa1100_console_setup(struct console *co, char *options)
 {
 	struct sa1100_port *sport;
 	int baud = 9600;
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 4d2924f61e0b..2fa86e01bd94 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -2041,9 +2041,8 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
 	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
 }
 
-static void __init
-s3c24xx_serial_get_options(struct uart_port *port, int *baud,
-			   int *parity, int *bits)
+static void s3c24xx_serial_get_options(struct uart_port *port, int *baud,
+				       int *parity, int *bits)
 {
 	struct clk *clk;
 	unsigned int ulcon;
@@ -2109,8 +2108,7 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 
 }
 
-static int __init
-s3c24xx_serial_console_setup(struct console *co, char *options)
+static int s3c24xx_serial_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 771f361c47ea..826c87c1d0c3 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -869,7 +869,7 @@ static void sbd_console_write(struct console *co, const char *s,
 	spin_unlock_irqrestore(&uport->lock, flags);
 }
 
-static int __init sbd_console_setup(struct console *co, char *options)
+static int sbd_console_setup(struct console *co, char *options)
 {
 	int chip = co->index / DUART_MAX_SIDE;
 	int side = co->index % DUART_MAX_SIDE;
diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index 57f152394af5..97c3aa5a27e6 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -575,7 +575,8 @@ static void ks8695_console_write(struct console *co, const char *s, u_int count)
 	uart_console_write(port, s, count, ks8695_console_putchar);
 }
 
-static void __init ks8695_console_get_options(struct uart_port *port, int *baud, int *parity, int *bits)
+static void ks8695_console_get_options(struct uart_port *port, int *baud,
+				       int *parity, int *bits)
 {
 	unsigned int lcr;
 
@@ -611,7 +612,7 @@ static void __init ks8695_console_get_options(struct uart_port *port, int *baud,
 	*baud &= 0xFFFFFFF0;
 }
 
-static int __init ks8695_console_setup(struct console *co, char *options)
+static int ks8695_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 115200;
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index f80312eed4fd..90593c77fe73 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -930,7 +930,7 @@ serial_txx9_console_write(struct console *co, const char *s, unsigned int count)
 	sio_out(up, TXX9_SIDICR, ier);
 }
 
-static int __init serial_txx9_console_setup(struct console *co, char *options)
+static int serial_txx9_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	struct uart_txx9_port *up;
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index b186c9c4f850..ffab1e8fb090 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1081,8 +1081,7 @@ static struct uart_ops sirfsoc_uart_ops = {
 };
 
 #ifdef CONFIG_SERIAL_SIRFSOC_CONSOLE
-static int __init
-sirfsoc_uart_console_setup(struct console *co, char *options)
+static int sirfsoc_uart_console_setup(struct console *co, char *options)
 {
 	unsigned int baud = 115200;
 	unsigned int bits = 8;
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 699447aa8b43..922ca6ed8dca 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -559,7 +559,7 @@ static void sprd_console_write(struct console *co, const char *s,
 		spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static int __init sprd_console_setup(struct console *co, char *options)
+static int sprd_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 115200;
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 9ad98eaa35bf..ffedbc152aa5 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1338,7 +1338,7 @@ static void sunsu_console_write(struct console *co, const char *s,
  *	- initialize the serial port
  *	Return non-zero if we didn't find a serial port.
  */
-static int __init sunsu_console_setup(struct console *co, char *options)
+static int sunsu_console_setup(struct console *co, char *options)
 {
 	static struct ktermios dummy;
 	struct ktermios termios;
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 8b6ace341029..450ae95f9962 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1217,7 +1217,7 @@ sunzilog_console_write(struct console *con, const char *s, unsigned int count)
 		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-static int __init sunzilog_console_setup(struct console *con, char *options)
+static int sunzilog_console_setup(struct console *con, char *options)
 {
 	struct uart_sunzilog_port *up = &sunzilog_port_table[con->index];
 	unsigned long flags;
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 485de53c5d75..306c59aa8687 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -782,7 +782,7 @@ static void siu_console_write(struct console *con, const char *s, unsigned count
 	siu_write(port, UART_IER, ier);
 }
 
-static int __init siu_console_setup(struct console *con, char *options)
+static int siu_console_setup(struct console *con, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index b384060e3b1f..855e612c2bcd 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -527,7 +527,7 @@ static void vt8500_console_write(struct console *co, const char *s,
 	vt8500_write(&vt8500_port->uart, VT8500_URIER, ier);
 }
 
-static int __init vt8500_console_setup(struct console *co, char *options)
+static int vt8500_console_setup(struct console *co, char *options)
 {
 	struct vt8500_port *vt8500_port;
 	int baud = 9600;
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index cd46e64c4255..1d3908628896 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1134,7 +1134,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
  *
  * Return: 0 on success, negative errno otherwise.
  */
-static int __init cdns_uart_console_setup(struct console *co, char *options)
+static int cdns_uart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = &cdns_uart_port[co->index];
 	int baud = 9600;
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index eeefd76a30da..80066ae8cadf 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -1195,7 +1195,7 @@ static void zs_console_write(struct console *co, const char *s,
  * - initialise the serial port
  * Return non-zero if we didn't find a serial port.
  */
-static int __init zs_console_setup(struct console *co, char *options)
+static int zs_console_setup(struct console *co, char *options)
 {
 	int chip = co->index / ZS_NUM_CHAN, side = co->index % ZS_NUM_CHAN;
 	struct zs_port *zport = &zs_sccs[chip].zport[side];
-- 
1.9.1

