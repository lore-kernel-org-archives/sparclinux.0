From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:21:34 +0000
Subject: [PATCH 145/493] tty: serial: remove use of __devexit_p
Message-Id: <1353349642-3677-145-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Alan Cox <alan@linux.intel.com> 
Cc: Tobias Klauser <tklauser@distanz.ch> 
Cc: Lucas Tavares <lucaskt@linux.vnet.ibm.com> 
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Peter Korsgaard <jacmet@sunsite.dk> 
Cc: Tony Prisk <linux@prisktech.co.nz> 
Cc: linux-serial@vger.kernel.org 
Cc: nios2-dev@sopc.et.ntust.edu.tw 
Cc: uclinux-dist-devel@blackfin.uclinux.org 
Cc: sparclinux@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
---
 drivers/tty/serial/8250/8250.c       |  2 +-
 drivers/tty/serial/8250/8250_acorn.c |  2 +-
 drivers/tty/serial/8250/8250_dw.c    |  2 +-
 drivers/tty/serial/8250/8250_em.c    |  2 +-
 drivers/tty/serial/8250/8250_hp300.c |  2 +-
 drivers/tty/serial/8250/8250_pci.c   | 50 ++++++++++++++++++------------------
 drivers/tty/serial/8250/8250_pnp.c   |  2 +-
 drivers/tty/serial/altera_jtaguart.c |  2 +-
 drivers/tty/serial/altera_uart.c     |  2 +-
 drivers/tty/serial/ar933x_uart.c     |  2 +-
 drivers/tty/serial/arc_uart.c        |  2 +-
 drivers/tty/serial/atmel_serial.c    |  2 +-
 drivers/tty/serial/bcm63xx_uart.c    |  2 +-
 drivers/tty/serial/bfin_sport_uart.c |  2 +-
 drivers/tty/serial/bfin_uart.c       |  2 +-
 drivers/tty/serial/clps711x.c        |  2 +-
 drivers/tty/serial/efm32-uart.c      |  2 +-
 drivers/tty/serial/icom.c            |  2 +-
 drivers/tty/serial/ifx6x60.c         |  2 +-
 drivers/tty/serial/jsm/jsm_driver.c  |  2 +-
 drivers/tty/serial/lpc32xx_hs.c      |  2 +-
 drivers/tty/serial/max3100.c         |  2 +-
 drivers/tty/serial/max310x.c         |  2 +-
 drivers/tty/serial/mcf.c             |  2 +-
 drivers/tty/serial/mfd.c             |  2 +-
 drivers/tty/serial/mrst_max3110.c    |  2 +-
 drivers/tty/serial/msm_serial_hs.c   |  2 +-
 drivers/tty/serial/mux.c             |  4 +--
 drivers/tty/serial/mxs-auart.c       |  2 +-
 drivers/tty/serial/omap-serial.c     |  2 +-
 drivers/tty/serial/pch_uart.c        |  2 +-
 drivers/tty/serial/samsung.c         |  2 +-
 drivers/tty/serial/sc26xx.c          |  2 +-
 drivers/tty/serial/sccnxp.c          |  2 +-
 drivers/tty/serial/serial_txx9.c     |  4 +--
 drivers/tty/serial/sirfsoc_uart.c    |  2 +-
 drivers/tty/serial/sunhv.c           |  2 +-
 drivers/tty/serial/sunsab.c          |  2 +-
 drivers/tty/serial/sunsu.c           |  2 +-
 drivers/tty/serial/sunzilog.c        |  2 +-
 drivers/tty/serial/timbuart.c        |  2 +-
 drivers/tty/serial/uartlite.c        |  2 +-
 drivers/tty/serial/vr41xx_siu.c      |  2 +-
 drivers/tty/serial/vt8500_serial.c   |  2 +-
 44 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 5ccbd90..870c5f2 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -3078,7 +3078,7 @@ static int serial8250_resume(struct platform_device *dev)
 
 static struct platform_driver serial8250_isa_driver = {
 	.probe		= serial8250_probe,
-	.remove		= __devexit_p(serial8250_remove),
+	.remove		= serial8250_remove,
 	.suspend	= serial8250_suspend,
 	.resume		= serial8250_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
index 8574983..b5e4b49 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -116,7 +116,7 @@ static const struct ecard_id serial_cids[] = {
 
 static struct ecard_driver serial_card_driver = {
 	.probe		= serial_card_probe,
-	.remove 	= __devexit_p(serial_card_remove),
+	.remove		= serial_card_remove,
 	.id_table	= serial_cids,
 	.drv = {
 		.name	= "8250_acorn",
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index b19b8c5..2db80d0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -197,7 +197,7 @@ static struct platform_driver dw8250_platform_driver = {
 		.of_match_table	= dw8250_match,
 	},
 	.probe			= dw8250_probe,
-	.remove			= __devexit_p(dw8250_remove),
+	.remove			= dw8250_remove,
 	.suspend		= dw8250_suspend,
 	.resume			= dw8250_resume,
 };
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 3a0363e..80c0a62 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -176,7 +176,7 @@ static struct platform_driver serial8250_em_platform_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe			= serial8250_em_probe,
-	.remove			= __devexit_p(serial8250_em_remove),
+	.remove			= serial8250_em_remove,
 };
 
 module_platform_driver(serial8250_em_platform_driver);
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index f3d0edf..89e8855 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -52,7 +52,7 @@ static struct dio_driver hpdca_driver = {
 	.name      = "hpdca",
 	.id_table  = hpdca_dio_tbl,
 	.probe     = hpdca_init_one,
-	.remove    = __devexit_p(hpdca_remove_one),
+	.remove    = hpdca_remove_one,
 };
 
 #endif
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 508063b..c049cfa 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1314,7 +1314,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ite887x_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ite887x_exit),
+		.exit		= pci_ite887x_exit,
 	},
 	/*
 	 * National Instruments
@@ -1326,7 +1326,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1335,7 +1335,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1344,7 +1344,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1353,7 +1353,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1362,7 +1362,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1371,7 +1371,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1380,7 +1380,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1389,7 +1389,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1398,7 +1398,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1407,7 +1407,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1416,7 +1416,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1425,7 +1425,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_ni8420_exit),
+		.exit		= pci_ni8420_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_NI,
@@ -1434,7 +1434,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_ni8430_init,
 		.setup		= pci_ni8430_setup,
-		.exit		= __devexit_p(pci_ni8430_exit),
+		.exit		= pci_ni8430_exit,
 	},
 	/*
 	 * Panacom
@@ -1446,7 +1446,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_plx9050_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_plx9050_exit),
+		.exit		= pci_plx9050_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_PANACOM,
@@ -1455,7 +1455,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_plx9050_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_plx9050_exit),
+		.exit		= pci_plx9050_exit,
 	},
 	/*
 	 * PLX
@@ -1474,7 +1474,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_SUBDEVICE_ID_EXSYS_4055,
 		.init		= pci_plx9050_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_plx9050_exit),
+		.exit		= pci_plx9050_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_PLX,
@@ -1483,7 +1483,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_SUBDEVICE_ID_KEYSPAN_SX2,
 		.init		= pci_plx9050_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_plx9050_exit),
+		.exit		= pci_plx9050_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_PLX,
@@ -1492,7 +1492,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_SUBDEVICE_ID_UNKNOWN_0x1584,
 		.init		= pci_plx9050_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_plx9050_exit),
+		.exit		= pci_plx9050_exit,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_PLX,
@@ -1501,7 +1501,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_DEVICE_ID_PLX_ROMULUS,
 		.init		= pci_plx9050_init,
 		.setup		= pci_default_setup,
-		.exit		= __devexit_p(pci_plx9050_exit),
+		.exit		= pci_plx9050_exit,
 	},
 	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 232
@@ -1513,7 +1513,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_SUBDEVICE_ID_OCTPRO232,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= __devexit_p(sbs_exit),
+		.exit		= sbs_exit,
 	},
 	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 422
@@ -1525,7 +1525,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_SUBDEVICE_ID_OCTPRO422,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= __devexit_p(sbs_exit),
+		.exit		= sbs_exit,
 	},
 	/*
 	 * SBS Technologies, Inc., P-Octal 232
@@ -1537,7 +1537,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_SUBDEVICE_ID_POCTAL232,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= __devexit_p(sbs_exit),
+		.exit		= sbs_exit,
 	},
 	/*
 	 * SBS Technologies, Inc., P-Octal 422
@@ -1549,7 +1549,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_SUBDEVICE_ID_POCTAL422,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= __devexit_p(sbs_exit),
+		.exit		= sbs_exit,
 	},
 	/*
 	 * SIIG cards - these may be called via parport_serial
@@ -4323,7 +4323,7 @@ static const struct pci_error_handlers serial8250_err_handler = {
 static struct pci_driver serial_pci_driver = {
 	.name		= "serial",
 	.probe		= pciserial_init_one,
-	.remove		= __devexit_p(pciserial_remove_one),
+	.remove		= pciserial_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= pciserial_suspend_one,
 	.resume		= pciserial_resume_one,
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index f8ee250..e566220 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -511,7 +511,7 @@ static int serial_pnp_resume(struct pnp_dev *dev)
 static struct pnp_driver serial_pnp_driver = {
 	.name		= "serial",
 	.probe		= serial_pnp_probe,
-	.remove		= __devexit_p(serial_pnp_remove),
+	.remove		= serial_pnp_remove,
 	.suspend	= serial_pnp_suspend,
 	.resume		= serial_pnp_resume,
 	.id_table	= pnp_dev_table,
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 530181e..ef16b0a 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -477,7 +477,7 @@ MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
 
 static struct platform_driver altera_jtaguart_platform_driver = {
 	.probe	= altera_jtaguart_probe,
-	.remove	= __devexit_p(altera_jtaguart_remove),
+	.remove	= altera_jtaguart_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.owner		= THIS_MODULE,
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 15d80b9..117ea2c 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -621,7 +621,7 @@ MODULE_DEVICE_TABLE(of, altera_uart_match);
 
 static struct platform_driver altera_uart_platform_driver = {
 	.probe	= altera_uart_probe,
-	.remove	= __devexit_p(altera_uart_remove),
+	.remove	= altera_uart_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.owner		= THIS_MODULE,
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index e4f60e2..33122f9 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -645,7 +645,7 @@ static int __devexit ar933x_uart_remove(struct platform_device *pdev)
 
 static struct platform_driver ar933x_uart_platform_driver = {
 	.probe		= ar933x_uart_probe,
-	.remove		= __devexit_p(ar933x_uart_remove),
+	.remove		= ar933x_uart_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.owner		= THIS_MODULE,
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index e9c61d1..d652569 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -697,7 +697,7 @@ static int __devexit arc_serial_remove(struct platform_device *pdev)
 
 static struct platform_driver arc_platform_driver = {
 	.probe = arc_serial_probe,
-	.remove = __devexit_p(arc_serial_remove),
+	.remove = arc_serial_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5608b6b..7f91d08 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1884,7 +1884,7 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
 
 static struct platform_driver atmel_serial_driver = {
 	.probe		= atmel_serial_probe,
-	.remove		= __devexit_p(atmel_serial_remove),
+	.remove		= atmel_serial_remove,
 	.suspend	= atmel_serial_suspend,
 	.resume		= atmel_serial_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index c0b68b9..7f631d4 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -865,7 +865,7 @@ static int __devexit bcm_uart_remove(struct platform_device *pdev)
  */
 static struct platform_driver bcm_uart_platform_driver = {
 	.probe	= bcm_uart_probe,
-	.remove	= __devexit_p(bcm_uart_remove),
+	.remove	= bcm_uart_remove,
 	.driver	= {
 		.owner = THIS_MODULE,
 		.name  = "bcm63xx_uart",
diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 7fbc3a0..b4a18c7 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -871,7 +871,7 @@ static int __devexit sport_uart_remove(struct platform_device *pdev)
 
 static struct platform_driver sport_uart_driver = {
 	.probe		= sport_uart_probe,
-	.remove		= __devexit_p(sport_uart_remove),
+	.remove		= sport_uart_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 #ifdef CONFIG_PM
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 9b11c3f..aa1f2f0f 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -1410,7 +1410,7 @@ static int __devexit bfin_serial_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_serial_driver = {
 	.probe		= bfin_serial_probe,
-	.remove		= __devexit_p(bfin_serial_remove),
+	.remove		= bfin_serial_remove,
 	.suspend	= bfin_serial_suspend,
 	.resume		= bfin_serial_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index a0a6db5..d631ef5 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -512,7 +512,7 @@ static struct platform_driver clps711x_uart_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= uart_clps711x_probe,
-	.remove	= __devexit_p(uart_clps711x_remove),
+	.remove	= uart_clps711x_remove,
 };
 module_platform_driver(clps711x_uart_driver);
 
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index 615e464..1e8bacf 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -791,7 +791,7 @@ MODULE_DEVICE_TABLE(of, efm32_uart_dt_ids);
 
 static struct platform_driver efm32_uart_driver = {
 	.probe = efm32_uart_probe,
-	.remove = __devexit_p(efm32_uart_remove),
+	.remove = efm32_uart_remove,
 
 	.driver = {
 		.name = DRIVER_NAME,
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 6131516..82671b5 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1617,7 +1617,7 @@ static struct pci_driver icom_pci_driver = {
 	.name = ICOM_DRIVER_NAME,
 	.id_table = icom_pci_table,
 	.probe = icom_probe,
-	.remove = __devexit_p(icom_remove),
+	.remove = icom_remove,
 };
 
 static int __init icom_init(void)
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index fbda374..658a263 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1395,7 +1395,7 @@ static struct spi_driver ifx_spi_driver = {
 		.owner = THIS_MODULE},
 	.probe = ifx_spi_spi_probe,
 	.shutdown = ifx_spi_spi_shutdown,
-	.remove = __devexit_p(ifx_spi_spi_remove),
+	.remove = ifx_spi_spi_remove,
 	.suspend = ifx_spi_spi_suspend,
 	.resume = ifx_spi_spi_resume,
 	.id_table = ifx_id_table
diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 8e05ce9..bbd4592 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -217,7 +217,7 @@ static struct pci_driver jsm_driver = {
 	.name		= "jsm",
 	.id_table	= jsm_pci_tbl,
 	.probe		= jsm_probe_one,
-	.remove		= __devexit_p(jsm_remove_one),
+	.remove		= jsm_remove_one,
 	.err_handler    = &jsm_err_handler,
 };
 
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index ba3af3b..7b0f5b4 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -783,7 +783,7 @@ MODULE_DEVICE_TABLE(of, serial_hs_lpc32xx_dt_ids);
 
 static struct platform_driver serial_hs_lpc32xx_driver = {
 	.probe		= serial_hs_lpc32xx_probe,
-	.remove		= __devexit_p(serial_hs_lpc32xx_remove),
+	.remove		= serial_hs_lpc32xx_remove,
 	.suspend	= serial_hs_lpc32xx_suspend,
 	.resume		= serial_hs_lpc32xx_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 0f24486..2ffd7f0 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -907,7 +907,7 @@ static struct spi_driver max3100_driver = {
 	},
 
 	.probe		= max3100_probe,
-	.remove		= __devexit_p(max3100_remove),
+	.remove		= max3100_remove,
 	.suspend	= max3100_suspend,
 	.resume		= max3100_resume,
 };
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 1ab1d2c..a332327 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1249,7 +1249,7 @@ static struct spi_driver max310x_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= max310x_probe,
-	.remove		= __devexit_p(max310x_remove),
+	.remove		= max310x_remove,
 	.suspend	= max310x_suspend,
 	.resume		= max310x_resume,
 	.id_table	= max310x_id_table,
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 9afca09..e3de785 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -617,7 +617,7 @@ static int __devexit mcf_remove(struct platform_device *pdev)
 
 static struct platform_driver mcf_platform_driver = {
 	.probe		= mcf_probe,
-	.remove		= __devexit_p(mcf_remove),
+	.remove		= mcf_remove,
 	.driver		= {
 		.name	= "mcfuart",
 		.owner	= THIS_MODULE,
diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index c4b50af..71c4c8e 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1468,7 +1468,7 @@ static struct pci_driver hsu_pci_driver = {
 	.name =		"HSU serial",
 	.id_table =	pci_ids,
 	.probe =	serial_hsu_probe,
-	.remove =	__devexit_p(serial_hsu_remove),
+	.remove =	serial_hsu_remove,
 	.suspend =	serial_hsu_suspend,
 	.resume	=	serial_hsu_resume,
 	.driver = {
diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index df2a224..649ce12 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -879,7 +879,7 @@ static struct spi_driver uart_max3110_driver = {
 			.owner	= THIS_MODULE,
 	},
 	.probe		= serial_m3110_probe,
-	.remove		= __devexit_p(serial_m3110_remove),
+	.remove		= serial_m3110_remove,
 	.suspend	= serial_m3110_suspend,
 	.resume		= serial_m3110_resume,
 };
diff --git a/drivers/tty/serial/msm_serial_hs.c b/drivers/tty/serial/msm_serial_hs.c
index fca13dc..1361ad5 100644
--- a/drivers/tty/serial/msm_serial_hs.c
+++ b/drivers/tty/serial/msm_serial_hs.c
@@ -1838,7 +1838,7 @@ static const struct dev_pm_ops msm_hs_dev_pm_ops = {
 
 static struct platform_driver msm_serial_hs_platform_driver = {
 	.probe = msm_hs_probe,
-	.remove = __devexit_p(msm_hs_remove),
+	.remove = msm_hs_remove,
 	.driver = {
 		.name = "msm_serial_hs",
 		.owner = THIS_MODULE,
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 7ea8a26..2783464 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -571,14 +571,14 @@ static struct parisc_driver builtin_serial_mux_driver = {
 	.name =		"builtin_serial_mux",
 	.id_table =	builtin_mux_tbl,
 	.probe =	mux_probe,
-	.remove =       __devexit_p(mux_remove),
+	.remove =       mux_remove,
 };
 
 static struct parisc_driver serial_mux_driver = {
 	.name =		"serial_mux",
 	.id_table =	mux_tbl,
 	.probe =	mux_probe,
-	.remove =       __devexit_p(mux_remove),
+	.remove =       mux_remove,
 };
 
 /**
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db3baa..7554045 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -813,7 +813,7 @@ MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
 
 static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
-	.remove = __devexit_p(mxs_auart_remove),
+	.remove = mxs_auart_remove,
 	.driver = {
 		.name = "mxs-auart",
 		.owner = THIS_MODULE,
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d456321..624e6b5 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1655,7 +1655,7 @@ MODULE_DEVICE_TABLE(of, omap_serial_of_match);
 
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
-	.remove         = __devexit_p(serial_omap_remove),
+	.remove         = serial_omap_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= &serial_omap_dev_pm_ops,
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 4cd6c23..f5fb9bd 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1869,7 +1869,7 @@ static struct pci_driver pch_uart_pci_driver = {
 	.name = "pch_uart",
 	.id_table = pch_uart_pci_id,
 	.probe = pch_uart_pci_probe,
-	.remove = __devexit_p(pch_uart_pci_remove),
+	.remove = pch_uart_pci_remove,
 	.suspend = pch_uart_pci_suspend,
 	.resume = pch_uart_pci_resume,
 };
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 740458c..6568beb 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1712,7 +1712,7 @@ MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
 
 static struct platform_driver samsung_serial_driver = {
 	.probe		= s3c24xx_serial_probe,
-	.remove		= __devexit_p(s3c24xx_serial_remove),
+	.remove		= s3c24xx_serial_remove,
 	.id_table	= s3c24xx_serial_driver_ids,
 	.driver		= {
 		.name	= "samsung-uart",
diff --git a/drivers/tty/serial/sc26xx.c b/drivers/tty/serial/sc26xx.c
index 9d66424..9a40659 100644
--- a/drivers/tty/serial/sc26xx.c
+++ b/drivers/tty/serial/sc26xx.c
@@ -733,7 +733,7 @@ static int __exit sc26xx_driver_remove(struct platform_device *dev)
 
 static struct platform_driver sc26xx_driver = {
 	.probe	= sc26xx_probe,
-	.remove	= __devexit_p(sc26xx_driver_remove),
+	.remove	= sc26xx_driver_remove,
 	.driver	= {
 		.name	= "SC26xx",
 		.owner	= THIS_MODULE,
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index e821068..810853f 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -981,7 +981,7 @@ static struct platform_driver sccnxp_uart_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= sccnxp_probe,
-	.remove		= __devexit_p(sccnxp_remove),
+	.remove		= sccnxp_remove,
 	.id_table	= sccnxp_id_table,
 };
 module_platform_driver(sccnxp_uart_driver);
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 6ae2a58..9d979a9 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1171,7 +1171,7 @@ static int serial_txx9_resume(struct platform_device *dev)
 
 static struct platform_driver serial_txx9_plat_driver = {
 	.probe		= serial_txx9_probe,
-	.remove		= __devexit_p(serial_txx9_remove),
+	.remove		= serial_txx9_remove,
 #ifdef CONFIG_PM
 	.suspend	= serial_txx9_suspend,
 	.resume		= serial_txx9_resume,
@@ -1261,7 +1261,7 @@ static const struct pci_device_id serial_txx9_pci_tbl[] = {
 static struct pci_driver serial_txx9_pci_driver = {
 	.name		= "serial_txx9",
 	.probe		= pciserial_txx9_init_one,
-	.remove		= __devexit_p(pciserial_txx9_remove_one),
+	.remove		= pciserial_txx9_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= pciserial_txx9_suspend_one,
 	.resume		= pciserial_txx9_resume_one,
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index a9e2bd1..4984984 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -735,7 +735,7 @@ MODULE_DEVICE_TABLE(of, sirfsoc_serial_of_match);
 
 static struct platform_driver sirfsoc_uart_driver = {
 	.probe		= sirfsoc_uart_probe,
-	.remove		= __devexit_p(sirfsoc_uart_remove),
+	.remove		= sirfsoc_uart_remove,
 	.suspend	= sirfsoc_uart_suspend,
 	.resume		= sirfsoc_uart_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 505961c..949b2d3 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -636,7 +636,7 @@ static struct platform_driver hv_driver = {
 		.of_match_table = hv_match,
 	},
 	.probe		= hv_probe,
-	.remove		= __devexit_p(hv_remove),
+	.remove		= hv_remove,
 };
 
 static int __init sunhv_init(void)
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index f0d93eb..bbb07bc 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -1100,7 +1100,7 @@ static struct platform_driver sab_driver = {
 		.of_match_table = sab_match,
 	},
 	.probe		= sab_probe,
-	.remove		= __devexit_p(sab_remove),
+	.remove		= sab_remove,
 };
 
 static int __init sunsab_init(void)
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index b97913d..c0658f0 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1556,7 +1556,7 @@ static struct platform_driver su_driver = {
 		.of_match_table = su_match,
 	},
 	.probe		= su_probe,
-	.remove		= __devexit_p(su_remove),
+	.remove		= su_remove,
 };
 
 static int __init sunsu_init(void)
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index babd947..c2ef475 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1548,7 +1548,7 @@ static struct platform_driver zs_driver = {
 		.of_match_table = zs_match,
 	},
 	.probe		= zs_probe,
-	.remove		= __devexit_p(zs_remove),
+	.remove		= zs_remove,
 };
 
 static int __init sunzilog_init(void)
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 70f9749..5fc11f2 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -510,7 +510,7 @@ static struct platform_driver timbuart_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= timbuart_probe,
-	.remove		= __devexit_p(timbuart_remove),
+	.remove		= timbuart_remove,
 };
 
 module_platform_driver(timbuart_platform_driver);
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 6579ffd..1d44383 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -603,7 +603,7 @@ MODULE_ALIAS("platform:uartlite");
 
 static struct platform_driver ulite_platform_driver = {
 	.probe = ulite_probe,
-	.remove = __devexit_p(ulite_remove),
+	.remove = ulite_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name  = "uartlite",
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index cf0d948..9d3bf75 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -952,7 +952,7 @@ static int siu_resume(struct platform_device *dev)
 
 static struct platform_driver siu_device_driver = {
 	.probe		= siu_probe,
-	.remove		= __devexit_p(siu_remove),
+	.remove		= siu_remove,
 	.suspend	= siu_suspend,
 	.resume		= siu_resume,
 	.driver		= {
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 4354fe5..dbcc909 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -652,7 +652,7 @@ static const struct of_device_id wmt_dt_ids[] = {
 
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
-	.remove = __devexit_p(vt8500_serial_remove),
+	.remove = vt8500_serial_remove,
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
-- 
1.8.0

