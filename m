From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:26:18 +0000
Subject: [PATCH 429/493] tty: remove use of __devexit
Message-Id: <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jiri Slaby <jirislaby@gmail.com> 
Cc: Alan Cox <alan@linux.intel.com> 
Cc: Tobias Klauser <tklauser@distanz.ch> 
Cc: Lucas Tavares <lucaskt@linux.vnet.ibm.com> 
Cc: David Brown <davidb@codeaurora.org> 
Cc: Daniel Walker <dwalker@fifo99.com> 
Cc: Bryan Huntsman <bryanh@codeaurora.org> 
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Peter Korsgaard <jacmet@sunsite.dk> 
Cc: Tony Prisk <linux@prisktech.co.nz> 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-serial@vger.kernel.org 
Cc: nios2-dev@sopc.et.ntust.edu.tw 
Cc: uclinux-dist-devel@blackfin.uclinux.org 
Cc: linux-arm-msm@vger.kernel.org 
Cc: sparclinux@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
---
 drivers/tty/cyclades.c                      |  2 +-
 drivers/tty/hvc/hvc_opal.c                  |  2 +-
 drivers/tty/hvc/hvc_vio.c                   |  2 +-
 drivers/tty/hvc/hvcs.c                      |  4 ++--
 drivers/tty/isicom.c                        |  4 ++--
 drivers/tty/moxa.c                          |  2 +-
 drivers/tty/mxser.c                         |  2 +-
 drivers/tty/nozomi.c                        |  4 ++--
 drivers/tty/serial/8250/8250.c              |  2 +-
 drivers/tty/serial/8250/8250_acorn.c        |  2 +-
 drivers/tty/serial/8250/8250_dw.c           |  2 +-
 drivers/tty/serial/8250/8250_em.c           |  2 +-
 drivers/tty/serial/8250/8250_hp300.c        |  4 ++--
 drivers/tty/serial/8250/8250_pci.c          | 12 ++++++------
 drivers/tty/serial/8250/8250_pnp.c          |  2 +-
 drivers/tty/serial/altera_jtaguart.c        |  2 +-
 drivers/tty/serial/altera_uart.c            |  2 +-
 drivers/tty/serial/ar933x_uart.c            |  2 +-
 drivers/tty/serial/arc_uart.c               |  2 +-
 drivers/tty/serial/atmel_serial.c           |  2 +-
 drivers/tty/serial/bcm63xx_uart.c           |  2 +-
 drivers/tty/serial/bfin_sport_uart.c        |  2 +-
 drivers/tty/serial/bfin_uart.c              |  2 +-
 drivers/tty/serial/clps711x.c               |  2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  2 +-
 drivers/tty/serial/efm32-uart.c             |  2 +-
 drivers/tty/serial/icom.c                   |  2 +-
 drivers/tty/serial/jsm/jsm_driver.c         |  2 +-
 drivers/tty/serial/lpc32xx_hs.c             |  2 +-
 drivers/tty/serial/max3100.c                |  2 +-
 drivers/tty/serial/max310x.c                |  2 +-
 drivers/tty/serial/mcf.c                    |  2 +-
 drivers/tty/serial/mrst_max3110.c           |  2 +-
 drivers/tty/serial/msm_serial.c             |  2 +-
 drivers/tty/serial/msm_serial_hs.c          |  2 +-
 drivers/tty/serial/mux.c                    |  2 +-
 drivers/tty/serial/mxs-auart.c              |  2 +-
 drivers/tty/serial/omap-serial.c            |  2 +-
 drivers/tty/serial/samsung.c                |  2 +-
 drivers/tty/serial/sccnxp.c                 |  2 +-
 drivers/tty/serial/serial_txx9.c            |  6 +++---
 drivers/tty/serial/sunhv.c                  |  2 +-
 drivers/tty/serial/sunsab.c                 |  2 +-
 drivers/tty/serial/sunsu.c                  |  2 +-
 drivers/tty/serial/sunzilog.c               |  4 ++--
 drivers/tty/serial/timbuart.c               |  2 +-
 drivers/tty/serial/uartlite.c               |  4 ++--
 drivers/tty/serial/vr41xx_siu.c             |  2 +-
 drivers/tty/serial/vt8500_serial.c          |  2 +-
 drivers/tty/serial/xilinx_uartps.c          |  2 +-
 drivers/tty/synclink.c                      |  2 +-
 drivers/tty/synclink_gt.c                   |  2 +-
 drivers/tty/synclinkmp.c                    |  2 +-
 53 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 444b544..6fd94aa 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -3931,7 +3931,7 @@ err:
 	return retval;
 }
 
-static void __devexit cy_pci_remove(struct pci_dev *pdev)
+static void cy_pci_remove(struct pci_dev *pdev)
 {
 	struct cyclades_card *cinfo = pci_get_drvdata(pdev);
 	unsigned int i;
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 700fedf..cd69b48 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -222,7 +222,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit hvc_opal_remove(struct platform_device *dev)
+static int hvc_opal_remove(struct platform_device *dev)
 {
 	struct hvc_struct *hp = dev_get_drvdata(&dev->dev);
 	int rc, termno;
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 7f51156..0c62980 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -362,7 +362,7 @@ static int hvc_vio_probe(struct vio_dev *vdev,
 	return 0;
 }
 
-static int __devexit hvc_vio_remove(struct vio_dev *vdev)
+static int hvc_vio_remove(struct vio_dev *vdev)
 {
 	struct hvc_struct *hp = dev_get_drvdata(&vdev->dev);
 	int rc, termno;
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 5afe3b6..8776357 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -332,7 +332,7 @@ static void hvcs_hangup(struct tty_struct * tty);
 
 static int hvcs_probe(struct vio_dev *dev,
 		const struct vio_device_id *id);
-static int __devexit hvcs_remove(struct vio_dev *dev);
+static int hvcs_remove(struct vio_dev *dev);
 static int __init hvcs_module_init(void);
 static void __exit hvcs_module_exit(void);
 static int hvcs_initialize(void);
@@ -835,7 +835,7 @@ static int hvcs_probe(
 	return 0;
 }
 
-static int __devexit hvcs_remove(struct vio_dev *dev)
+static int hvcs_remove(struct vio_dev *dev)
 {
 	struct hvcs_struct *hvcsd = dev_get_drvdata(&dev->dev);
 	unsigned long flags;
diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index d1c1fef..3245c6f 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -148,7 +148,7 @@
 #endif
 
 static int isicom_probe(struct pci_dev *, const struct pci_device_id *);
-static void __devexit isicom_remove(struct pci_dev *);
+static void isicom_remove(struct pci_dev *);
 
 static struct pci_device_id isicom_pci_tbl[] = {
 	{ PCI_DEVICE(VENDOR_ID, 0x2028) },
@@ -1630,7 +1630,7 @@ err:
 	return retval;
 }
 
-static void __devexit isicom_remove(struct pci_dev *pdev)
+static void isicom_remove(struct pci_dev *pdev)
 {
 	struct isi_board *board = pci_get_drvdata(pdev);
 	unsigned int i;
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 0998773..cff4d8d 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1016,7 +1016,7 @@ err:
 	return retval;
 }
 
-static void __devexit moxa_pci_remove(struct pci_dev *pdev)
+static void moxa_pci_remove(struct pci_dev *pdev)
 {
 	struct moxa_board_conf *brd = pci_get_drvdata(pdev);
 
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 9de9753..4d0f7b9 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2645,7 +2645,7 @@ err:
 #endif
 }
 
-static void __devexit mxser_remove(struct pci_dev *pdev)
+static void mxser_remove(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI
 	struct mxser_board *brd = pci_get_drvdata(pdev);
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index e067e5f..711dcde 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1504,7 +1504,7 @@ err:
 	return ret;
 }
 
-static void __devexit tty_exit(struct nozomi *dc)
+static void tty_exit(struct nozomi *dc)
 {
 	unsigned int i;
 
@@ -1525,7 +1525,7 @@ static void __devexit tty_exit(struct nozomi *dc)
 }
 
 /* Deallocate memory for one device */
-static void __devexit nozomi_card_exit(struct pci_dev *pdev)
+static void nozomi_card_exit(struct pci_dev *pdev)
 {
 	int i;
 	struct ctrl_ul ctrl;
diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 40ba8cc..2af83a2 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -3035,7 +3035,7 @@ static int serial8250_probe(struct platform_device *dev)
 /*
  * Remove serial ports registered against a platform device.
  */
-static int __devexit serial8250_remove(struct platform_device *dev)
+static int serial8250_remove(struct platform_device *dev)
 {
 	int i;
 
diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
index ed095eb..549aa07 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -80,7 +80,7 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 	return 0;
 }
 
-static void __devexit serial_card_remove(struct expansion_card *ec)
+static void serial_card_remove(struct expansion_card *ec)
 {
 	struct serial_card_info *info = ecard_get_drvdata(ec);
 	int i;
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7664750..1d0dba2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -152,7 +152,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit dw8250_remove(struct platform_device *pdev)
+static int dw8250_remove(struct platform_device *pdev)
 {
 	struct dw8250_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 430bf42..916cc19 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -152,7 +152,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit serial8250_em_remove(struct platform_device *pdev)
+static int serial8250_em_remove(struct platform_device *pdev)
 {
 	struct serial8250_em_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index 2b94505..5bdaf27 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -38,7 +38,7 @@ static struct hp300_port *hp300_ports;
 
 static int hpdca_init_one(struct dio_dev *d,
 					const struct dio_device_id *ent);
-static void __devexit hpdca_remove_one(struct dio_dev *d);
+static void hpdca_remove_one(struct dio_dev *d);
 
 static struct dio_device_id hpdca_dio_tbl[] = {
 	{ DIO_ID_DCA0 },
@@ -288,7 +288,7 @@ static int __init hp300_8250_init(void)
 }
 
 #ifdef CONFIG_HPDCA
-static void __devexit hpdca_remove_one(struct dio_dev *d)
+static void hpdca_remove_one(struct dio_dev *d)
 {
 	int line;
 
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3252c5d..97058c1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -288,7 +288,7 @@ static int pci_plx9050_init(struct pci_dev *dev)
 	return 0;
 }
 
-static void __devexit pci_plx9050_exit(struct pci_dev *dev)
+static void pci_plx9050_exit(struct pci_dev *dev)
 {
 	u8 __iomem *p;
 
@@ -313,7 +313,7 @@ static void __devexit pci_plx9050_exit(struct pci_dev *dev)
 #define NI8420_INT_ENABLE_REG	0x38
 #define NI8420_INT_ENABLE_BIT	0x2000
 
-static void __devexit pci_ni8420_exit(struct pci_dev *dev)
+static void pci_ni8420_exit(struct pci_dev *dev)
 {
 	void __iomem *p;
 	unsigned long base, len;
@@ -345,7 +345,7 @@ static void __devexit pci_ni8420_exit(struct pci_dev *dev)
 
 #define MITE_LCIMR2_CLR_CPU_IE	(1 << 30)
 
-static void __devexit pci_ni8430_exit(struct pci_dev *dev)
+static void pci_ni8430_exit(struct pci_dev *dev)
 {
 	void __iomem *p;
 	unsigned long base, len;
@@ -422,7 +422,7 @@ static int sbs_init(struct pci_dev *dev)
  * Disables the global interrupt of PMC-OctalPro
  */
 
-static void __devexit sbs_exit(struct pci_dev *dev)
+static void sbs_exit(struct pci_dev *dev)
 {
 	u8 __iomem *p;
 
@@ -991,7 +991,7 @@ static int pci_ite887x_init(struct pci_dev *dev)
 	return ret;
 }
 
-static void __devexit pci_ite887x_exit(struct pci_dev *dev)
+static void pci_ite887x_exit(struct pci_dev *dev)
 {
 	u32 ioport;
 	/* the ioport is bit 0-15 in POSIO0R */
@@ -2988,7 +2988,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 	return rc;
 }
 
-static void __devexit pciserial_remove_one(struct pci_dev *dev)
+static void pciserial_remove_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 71daae9..35d9ab9 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -476,7 +476,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	return 0;
 }
 
-static void __devexit serial_pnp_remove(struct pnp_dev *dev)
+static void serial_pnp_remove(struct pnp_dev *dev)
 {
 	long line = (long)pnp_get_drvdata(dev);
 	if (line)
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index ef5c705..872f14a 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -453,7 +453,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit altera_jtaguart_remove(struct platform_device *pdev)
+static int altera_jtaguart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port;
 	int i = pdev->id;
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 066b503..684a080 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -598,7 +598,7 @@ static int altera_uart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit altera_uart_remove(struct platform_device *pdev)
+static int altera_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index fab0a91..af38b07 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -627,7 +627,7 @@ err_free_up:
 	return ret;
 }
 
-static int __devexit ar933x_uart_remove(struct platform_device *pdev)
+static int ar933x_uart_remove(struct platform_device *pdev)
 {
 	struct ar933x_uart_port *up;
 
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 158d798..3e0b3fa 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -689,7 +689,7 @@ static int arc_serial_probe(struct platform_device *pdev)
 	return uart_add_one_port(&arc_uart_driver, &uart->port);
 }
 
-static int __devexit arc_serial_remove(struct platform_device *pdev)
+static int arc_serial_remove(struct platform_device *pdev)
 {
 	/* This will never be called */
 	return 0;
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c1f6c0b..a6a90d2 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1859,7 +1859,7 @@ err:
 	return ret;
 }
 
-static int __devexit atmel_serial_remove(struct platform_device *pdev)
+static int atmel_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index e54d170..c76a226 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -848,7 +848,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bcm_uart_remove(struct platform_device *pdev)
+static int bcm_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port;
 
diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index a47e00b..f5d1173 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -850,7 +850,7 @@ out_error_free_mem:
 	return ret;
 }
 
-static int __devexit sport_uart_remove(struct platform_device *pdev)
+static int sport_uart_remove(struct platform_device *pdev)
 {
 	struct sport_uart_port *sport = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index aa1f2f0f..5ac90c90 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -1390,7 +1390,7 @@ out_error_free_mem:
 	return ret;
 }
 
-static int __devexit bfin_serial_remove(struct platform_device *pdev)
+static int bfin_serial_remove(struct platform_device *pdev)
 {
 	struct bfin_serial_port *uart = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 006d283..3fd2526 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -491,7 +491,7 @@ err_out:
 	return ret;
 }
 
-static int __devexit uart_clps711x_remove(struct platform_device *pdev)
+static int uart_clps711x_remove(struct platform_device *pdev)
 {
 	struct clps711x_port *s = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index de3f0f6..ad0caf1 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1396,7 +1396,7 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 	return uart_add_one_port(&cpm_reg, &pinfo->port);
 }
 
-static int __devexit cpm_uart_remove(struct platform_device *ofdev)
+static int cpm_uart_remove(struct platform_device *ofdev)
 {
 	struct uart_cpm_port *pinfo = dev_get_drvdata(&ofdev->dev);
 	return uart_remove_one_port(&cpm_reg, &pinfo->port);
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index 833c33a..a8cbb26 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -764,7 +764,7 @@ err_get_base:
 	return ret;
 }
 
-static int __devexit efm32_uart_remove(struct platform_device *pdev)
+static int efm32_uart_remove(struct platform_device *pdev)
 {
 	struct efm32_uart_port *efm_port = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 8c5ad58..72b6334 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1596,7 +1596,7 @@ probe_exit0:
 	return retval;
 }
 
-static void __devexit icom_remove(struct pci_dev *dev)
+static void icom_remove(struct pci_dev *dev)
 {
 	struct icom_adapter *icom_adapter;
 	struct list_head *tmp;
diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 5b57c8e..a47d882 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -178,7 +178,7 @@ static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return rc;
 }
 
-static void __devexit jsm_remove_one(struct pci_dev *pdev)
+static void jsm_remove_one(struct pci_dev *pdev)
 {
 	struct jsm_board *brd = pci_get_drvdata(pdev);
 	int i = 0;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 3651dab..0e86bff 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -740,7 +740,7 @@ static int serial_hs_lpc32xx_probe(struct platform_device *pdev)
 /*
  * Remove serial ports registered against a platform device.
  */
-static int __devexit serial_hs_lpc32xx_remove(struct platform_device *pdev)
+static int serial_hs_lpc32xx_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_hsuart_port *p = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 8dd6189..7ce3197 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -818,7 +818,7 @@ static int max3100_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit max3100_remove(struct spi_device *spi)
+static int max3100_remove(struct spi_device *spi)
 {
 	struct max3100_port *s = dev_get_drvdata(&spi->dev);
 	int i;
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 88a227f..3bb809d 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1202,7 +1202,7 @@ err_out:
 	return ret;
 }
 
-static int __devexit max310x_remove(struct spi_device *spi)
+static int max310x_remove(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct max310x_port *s = dev_get_drvdata(dev);
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index e2b93d2..fcd56ab 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -599,7 +599,7 @@ static int mcf_probe(struct platform_device *pdev)
 
 /****************************************************************************/
 
-static int __devexit mcf_remove(struct platform_device *pdev)
+static int mcf_remove(struct platform_device *pdev)
 {
 	struct uart_port *port;
 	int i;
diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index 41497fd..58734d7 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -855,7 +855,7 @@ err_get_page:
 	return ret;
 }
 
-static int __devexit serial_m3110_remove(struct spi_device *dev)
+static int serial_m3110_remove(struct spi_device *dev)
 {
 	struct uart_max3110 *max = spi_get_drvdata(dev);
 
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 033e0bc..95fd39b 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -917,7 +917,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 	return uart_add_one_port(&msm_uart_driver, port);
 }
 
-static int __devexit msm_serial_remove(struct platform_device *pdev)
+static int msm_serial_remove(struct platform_device *pdev)
 {
 	struct msm_port *msm_port = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/msm_serial_hs.c b/drivers/tty/serial/msm_serial_hs.c
index 02fb63e..1fa9228 100644
--- a/drivers/tty/serial/msm_serial_hs.c
+++ b/drivers/tty/serial/msm_serial_hs.c
@@ -401,7 +401,7 @@ static int msm_hs_request_port(struct uart_port *port)
 	return 0;
 }
 
-static int __devexit msm_hs_remove(struct platform_device *pdev)
+static int msm_hs_remove(struct platform_device *pdev)
 {
 
 	struct msm_hs_port *msm_uport;
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 2783464..e2775b6 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -520,7 +520,7 @@ static int __init mux_probe(struct parisc_device *dev)
 	return 0;
 }
 
-static int __devexit mux_remove(struct parisc_device *dev)
+static int mux_remove(struct parisc_device *dev)
 {
 	int i, j;
 	int port_count = (long)dev_get_drvdata(&dev->dev);
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ed09bd4..7631f3a 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -789,7 +789,7 @@ out:
 	return ret;
 }
 
-static int __devexit mxs_auart_remove(struct platform_device *pdev)
+static int mxs_auart_remove(struct platform_device *pdev)
 {
 	struct mxs_auart_port *s = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1e988f7..23f797e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1510,7 +1510,7 @@ err_port_line:
 	return ret;
 }
 
-static int __devexit serial_omap_remove(struct platform_device *dev)
+static int serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
 
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 6568beb..82b48f6 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1256,7 +1256,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit s3c24xx_serial_remove(struct platform_device *dev)
+static int s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 1ddace8..418b495 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -943,7 +943,7 @@ err_out:
 	return ret;
 }
 
-static int __devexit sccnxp_remove(struct platform_device *pdev)
+static int sccnxp_remove(struct platform_device *pdev)
 {
 	int i;
 	struct sccnxp_port *s = platform_get_drvdata(pdev);
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 23b28b8..b52b21a 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1078,7 +1078,7 @@ static int serial_txx9_register_port(struct uart_port *port)
  *	Remove one serial port.  This may not be called from interrupt
  *	context.  We hand the port back to the our control.
  */
-static void __devexit serial_txx9_unregister_port(int line)
+static void serial_txx9_unregister_port(int line)
 {
 	struct uart_txx9_port *uart = &serial_txx9_ports[line];
 
@@ -1126,7 +1126,7 @@ static int serial_txx9_probe(struct platform_device *dev)
 /*
  * Remove serial ports registered against a platform device.
  */
-static int __devexit serial_txx9_remove(struct platform_device *dev)
+static int serial_txx9_remove(struct platform_device *dev)
 {
 	int i;
 
@@ -1217,7 +1217,7 @@ pciserial_txx9_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 	return 0;
 }
 
-static void __devexit pciserial_txx9_remove_one(struct pci_dev *dev)
+static void pciserial_txx9_remove_one(struct pci_dev *dev)
 {
 	struct uart_txx9_port *up = pci_get_drvdata(dev);
 
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index cb58867..b9bf9c5 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -598,7 +598,7 @@ out_free_port:
 	return err;
 }
 
-static int __devexit hv_remove(struct platform_device *dev)
+static int hv_remove(struct platform_device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(&dev->dev);
 
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 9a13c54..bd8b3b6 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -1063,7 +1063,7 @@ out:
 	return err;
 }
 
-static int __devexit sab_remove(struct platform_device *op)
+static int sab_remove(struct platform_device *op)
 {
 	struct uart_sunsab_port *up = dev_get_drvdata(&op->dev);
 
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 049bbc5..220da3f 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1503,7 +1503,7 @@ out_unmap:
 	return err;
 }
 
-static int __devexit su_remove(struct platform_device *op)
+static int su_remove(struct platform_device *op)
 {
 	struct uart_sunsu_port *up = dev_get_drvdata(&op->dev);
 	bool kbdms = false;
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 02c058f..aef4fab 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1507,7 +1507,7 @@ static int zs_probe(struct platform_device *op)
 	return 0;
 }
 
-static void __devexit zs_remove_one(struct uart_sunzilog_port *up)
+static void zs_remove_one(struct uart_sunzilog_port *up)
 {
 	if (ZS_IS_KEYB(up) || ZS_IS_MOUSE(up)) {
 #ifdef CONFIG_SERIO
@@ -1517,7 +1517,7 @@ static void __devexit zs_remove_one(struct uart_sunzilog_port *up)
 		uart_remove_one_port(&sunzilog_reg, &up->port);
 }
 
-static int __devexit zs_remove(struct platform_device *op)
+static int zs_remove(struct platform_device *op)
 {
 	struct uart_sunzilog_port *up = dev_get_drvdata(&op->dev);
 	struct zilog_layout __iomem *regs;
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index c833f50..5be0d68 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -492,7 +492,7 @@ err_mem:
 	return err;
 }
 
-static int __devexit timbuart_remove(struct platform_device *dev)
+static int timbuart_remove(struct platform_device *dev)
 {
 	struct timbuart_port *uart = platform_get_drvdata(dev);
 
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 2d20b01..89eee43 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -542,7 +542,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq)
  *
  * @dev: pointer to device structure
  */
-static int __devexit ulite_release(struct device *dev)
+static int ulite_release(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	int rc = 0;
@@ -593,7 +593,7 @@ static int ulite_probe(struct platform_device *pdev)
 	return ulite_assign(&pdev->dev, id, res->start, res2->start);
 }
 
-static int __devexit ulite_remove(struct platform_device *pdev)
+static int ulite_remove(struct platform_device *pdev)
 {
 	return ulite_release(&pdev->dev);
 }
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index c046c99..62ee016 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -901,7 +901,7 @@ static int siu_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit siu_remove(struct platform_device *dev)
+static int siu_remove(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int i;
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 80530c7..8fd1814 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -634,7 +634,7 @@ err:
 	return ret;
 }
 
-static int __devexit vt8500_serial_remove(struct platform_device *pdev)
+static int vt8500_serial_remove(struct platform_device *pdev)
 {
 	struct vt8500_port *vt8500_port = platform_get_drvdata(pdev);
 
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e6380a..be8595a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1001,7 +1001,7 @@ static int xuartps_probe(struct platform_device *pdev)
  *
  * Returns 0 on success, negative error otherwise
  **/
-static int __devexit xuartps_remove(struct platform_device *pdev)
+static int xuartps_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 	int rc = 0;
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 87ba4ca..392ae00 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -8116,7 +8116,7 @@ static int synclink_init_one (struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit synclink_remove_one (struct pci_dev *dev)
+static void synclink_remove_one (struct pci_dev *dev)
 {
 }
 
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index cdd1ba7..ff47071 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3708,7 +3708,7 @@ static int init_one(struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit remove_one(struct pci_dev *dev)
+static void remove_one(struct pci_dev *dev)
 {
 }
 
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 17454da..5d34054b 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -5603,6 +5603,6 @@ static int synclinkmp_init_one (struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit synclinkmp_remove_one (struct pci_dev *dev)
+static void synclinkmp_remove_one (struct pci_dev *dev)
 {
 }
-- 
1.8.0

