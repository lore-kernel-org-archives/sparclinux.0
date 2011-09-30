From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 30 Sep 2011 13:47:28 +0000
Subject: [PATCH 2/4] apbuart: add support for virtual KGDB<->GRMON channel
Message-Id: <1317390450-5982-3-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1317381744-24862-2-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317381744-24862-2-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add support for a virtual GRMON<->KGDB channel that
is created using share memory polling by GRMON. Start
GRMON with the option "-vchannel" to enable polling. This
feature enables connecting to KGDB without having an hardware
serial connection, but using GRMON as an tunnel.
Reorder Makefile addition so that apbuart.o gets inserted
before kgdboc.o.
Add Kconfig option SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL to enable
the feature.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 drivers/tty/serial/Kconfig   |   12 +++++
 drivers/tty/serial/Makefile  |    2 +-
 drivers/tty/serial/apbuart.c |  100 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b3692e6..896042b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1526,6 +1526,18 @@ config SERIAL_GRLIB_GAISLER_APBUART_CONSOLE
 	help
 	Support for running a console on the GRLIB APBUART
 
+config SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL
+	bool "Virtual channel created by GRMON to communicate with KGDB"
+	depends on SERIAL_GRLIB_GAISLER_APBUART=y
+	default y
+	help
+	Add support for a virtual GRMON<->KGDB channel that
+	is created using share memory polling by GRMON. Start
+	GRMON with the option "-vchannel" to enable polling. This
+	feature enables connecting to KGDB without having an hardware
+	serial connection, but using GRMON as an tunnel. Also
+	enable KGDB_SERIAL_CONSOLE to use this feature.
+
 config SERIAL_ALTERA_JTAGUART
 	tristate "Altera JTAG UART support"
 	select SERIAL_CORE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index cb2628f..ea3fc05 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -81,10 +81,10 @@ obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL) += nwpserial.o
 obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
 obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
+obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
 obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
-obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
 obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
 obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_SERIAL_VT8500) += vt8500_serial.o
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 153e065..583f41b 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -355,6 +355,83 @@ static struct uart_ops grlib_apbuart_ops = {
 #endif
 };
 
+#undef CONFIG_SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL_HAS
+#if defined(CONFIG_SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL) && defined(CONFIG_SPARC_LEON) && defined(CONFIG_CONSOLE_POLL)
+#define CONFIG_SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL_HAS
+#include <asm/leon.h>
+
+/*
+ * Use a memory array that is continuously read/written by GRMON
+ * as a communication channel. GRMON will test for the existence
+ * of symbol apbuart_grmon_vchannel. If present the "shared memory"
+ * of apbuart_grmon_vchannel will be used to comunicate with linux.
+ * apbuart_grmon_vchannel is only used for KGDB polling communication.
+ */
+unsigned int apbuart_grmon_vchannel[4] = { 0, 0, 0, 0 };
+
+EXPORT_SYMBOL(apbuart_grmon_vchannel);
+
+static void apbuart_set_termios_v(struct uart_port *port,
+				  struct ktermios *termios,
+				  struct ktermios *old)
+{
+	return;
+}
+
+unsigned char apbuart_poll_get_char_v_b[4];
+unsigned char apbuart_poll_get_char_v_c = 0;
+static int apbuart_poll_get_char_v(struct uart_port *port)
+{
+	int c = NO_POLL_CHAR, cnt, i;
+	if (apbuart_poll_get_char_v_c) {
+		apbuart_poll_get_char_v_c--;
+		c = apbuart_poll_get_char_v_b[0] & 0xff;
+		for (i = 0; i < apbuart_poll_get_char_v_c; i++) {
+			apbuart_poll_get_char_v_b[i] +			    apbuart_poll_get_char_v_b[i + 1];
+		}
+	}
+
+	/*
+	 * poll for new char GRMON from. When grmon has a new char it
+	 * will set write it into apbuart_grmon_vchannel[0] and then
+	 * set apbuart_grmon_vchannel[1]
+	 */
+	else if ((cnt = LEON3_BYPASS_LOAD_PA(__pa(&apbuart_grmon_vchannel[1])))) {
+		unsigned int ar +		    LEON3_BYPASS_LOAD_PA(__pa(&apbuart_grmon_vchannel[0]));
+		LEON_BYPASS_STORE_PA(__pa(&apbuart_grmon_vchannel[1]), 0);
+		c = ar & 0xff;
+		for (i = 1; i < cnt; i++) {
+			apbuart_poll_get_char_v_b[apbuart_poll_get_char_v_c++] +			    (ar >> (8 * i)) & 0xff;
+		}
+	}
+
+	return c;
+}
+static void apbuart_console_putchar_v(struct uart_port *port, unsigned char ch)
+{
+	/*
+	 * poll for GRMON readout. When grmon has read apbuart_grmon_vchannel[3]
+	 * it will clear apbuart_grmon_vchannel[2]
+	 */
+	while (LEON3_BYPASS_LOAD_PA(__pa(&apbuart_grmon_vchannel[2]))) {
+	}
+	LEON_BYPASS_STORE_PA(__pa(&apbuart_grmon_vchannel[3]), ch & 0xff);
+	LEON_BYPASS_STORE_PA(__pa(&apbuart_grmon_vchannel[2]), 1);
+	return;
+}
+
+static struct uart_ops grlib_apbuart_v_ops = {
+	.set_termios = apbuart_set_termios_v,
+	.poll_get_char = apbuart_poll_get_char_v,
+	.poll_put_char = apbuart_console_putchar_v,
+};
+
+static struct uart_port grlib_apbuart_vport;
+#endif
+
 static struct uart_port grlib_apbuart_ports[UART_NR];
 static struct device_node *grlib_apbuart_nodes[UART_NR];
 
@@ -671,6 +748,18 @@ static int grlib_apbuart_configure(void)
 			break;
 	}
 
+#ifdef CONFIG_SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL_HAS
+	grlib_apbuart_vport.mapbase = 0;
+	grlib_apbuart_vport.membase = 0;
+	grlib_apbuart_vport.irq = 0;
+	grlib_apbuart_vport.iotype = UPIO_MEM;
+	grlib_apbuart_vport.ops = &grlib_apbuart_v_ops;
+	grlib_apbuart_vport.flags = UPF_BOOT_AUTOCONF;
+	grlib_apbuart_vport.line = line;
+	grlib_apbuart_vport.fifosize = 0;
+	line++;
+#endif
+
 	grlib_apbuart_driver.nr = grlib_apbuart_port_nr = line;
 	return line ? 0 : -ENODEV;
 }
@@ -702,6 +791,17 @@ static int __init grlib_apbuart_init(void)
 		uart_unregister_driver(&grlib_apbuart_driver);
 		return ret;
 	}
+#ifdef CONFIG_SERIAL_GRLIB_GAISLER_APBUART_GRMON_VIRTUAL_HAS
+
+	/* register an extra virtual port that is used for
+	 * GRMON<->KGDB communication */
+	uart_add_one_port(&grlib_apbuart_driver,
+			  (struct uart_port *)&grlib_apbuart_vport);
+	printk(KERN_INFO
+	       "apbuart: virtual KGDB channel for grmon, use cmdline arg \"kgdboc=kms,ttyS%d,38400\".\napbuart: Use option \"-vchannel\" when starting GRMON.\napbuart: apbuart_grmon_vchannel at pa:0x%x\n",
+	       grlib_apbuart_vport.line, (int)__pa(&apbuart_grmon_vchannel));
+
+#endif
 
 	return ret;
 }
-- 
1.6.4.1

