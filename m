From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 04:07:03 +0000
Subject: [PATCH 2.6] sparc module version cleanups
Message-Id: <1109909223.17038.30.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-DFf9eQnO5ekqqW/ykttx"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-DFf9eQnO5ekqqW/ykttx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Minor cleanups for sparc specific drivers (sunbmac, sunqe, sunlance,
sunhme, esp) so that they have a full module version definition that is
consistent with other upstream drivers.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-DFf9eQnO5ekqqW/ykttx
Content-Disposition: attachment; filename=linux-2.6.11-sparc-module_version.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-module_version.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/drivers/net/sunqe.c.BAD	2005-03-03 22:55:00.071843595 -0500
+++ linux-2.6.11/drivers/net/sunqe.c	2005-03-03 22:58:10.113952803 -0500
@@ -7,9 +7,6 @@
  * Copyright (C) 1996, 1999, 2003 David S. Miller (davem@redhat.com)
  */
 
-static char version[] =
-        "sunqe.c:v3.0 8/24/03 David S. Miller (davem@redhat.com)\n";
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -43,6 +40,19 @@ static char version[] =
 
 #include "sunqe.h"
 
+#define DRV_NAME	"sunqe"
+#define DRV_VERSION	"3.0"
+#define DRV_RELDATE	"8/24/03"
+#define DRV_AUTHOR	"David S. Miller (davem@redhat.com)"
+
+static char version[] =
+	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " " DRV_AUTHOR "\n";
+
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION("Sun QuadEthernet 10baseT SBUS card driver");
+MODULE_LICENSE("GPL");
+
 static struct sunqec *root_qec_dev;
 
 static void qe_set_multicast(struct net_device *dev);
@@ -1040,4 +1050,3 @@ static void __exit qec_cleanup(void)
 
 module_init(qec_probe);
 module_exit(qec_cleanup);
-MODULE_LICENSE("GPL");
--- linux-2.6.11/drivers/net/sunbmac.c.BAD	2005-03-03 22:52:07.656054779 -0500
+++ linux-2.6.11/drivers/net/sunbmac.c	2005-03-03 22:54:52.512992715 -0500
@@ -37,8 +37,18 @@
 
 #include "sunbmac.h"
 
+#define DRV_NAME	"sunbmac"
+#define DRV_VERSION	"2.0"
+#define DRV_RELDATE	"11/24/03"
+#define DRV_AUTHOR	"David S. Miller (davem@redhat.com)"
+
 static char version[] __initdata =
-        "sunbmac.c:v2.0 24/Nov/03 David S. Miller (davem@redhat.com)\n";
+	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " " DRV_AUTHOR "\n";
+
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION("Sun BigMAC 100baseT ethernet driver");
+MODULE_LICENSE("GPL");
 
 #undef DEBUG_PROBE
 #undef DEBUG_TX
@@ -1321,4 +1331,3 @@ static void __exit bigmac_cleanup(void)
 
 module_init(bigmac_probe);
 module_exit(bigmac_cleanup);
-MODULE_LICENSE("GPL");
--- linux-2.6.11/drivers/net/sunlance.c.BAD	2005-03-03 23:01:30.048558123 -0500
+++ linux-2.6.11/drivers/net/sunlance.c	2005-03-03 23:03:03.004426683 -0500
@@ -69,9 +69,6 @@
 
 #undef DEBUG_DRIVER
 
-static char version[] =
-	"sunlance.c:v2.02 24/Aug/03 Miguel de Icaza (miguel@nuclecu.unam.mx)\n";
-
 static char lancestr[] = "LANCE";
 
 #include <linux/config.h>
@@ -108,6 +105,19 @@ static char lancestr[] = "LANCE";
 #include <asm/auxio.h>		/* For tpe-link-test? setting */
 #include <asm/irq.h>
 
+#define DRV_NAME	"sunlance"
+#define DRV_VERSION	"2.02"
+#define DRV_RELDATE	"8/24/03"
+#define DRV_AUTHOR	"Miguel de Icaza (miguel@nuclecu.unam.mx)"
+
+static char version[] =
+	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " " DRV_AUTHOR "\n";
+
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION("Sun Lance ethernet driver");
+MODULE_LICENSE("GPL");
+
 /* Define: 2^4 Tx buffers and 2^4 Rx buffers */
 #ifndef LANCE_LOG_TX_BUFFERS
 #define LANCE_LOG_TX_BUFFERS 4
@@ -1611,4 +1621,3 @@ static void __exit sparc_lance_cleanup(v
 
 module_init(sparc_lance_probe);
 module_exit(sparc_lance_cleanup);
-MODULE_LICENSE("GPL");
--- linux-2.6.11/drivers/net/sunhme.c.BAD	2005-03-03 23:03:13.525827187 -0500
+++ linux-2.6.11/drivers/net/sunhme.c	2005-03-03 23:05:15.982210987 -0500
@@ -13,9 +13,6 @@
  *     argument : macaddr=0x00,0x10,0x20,0x30,0x40,0x50
  */
 
-static char version[] =
-        "sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)\n";
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -67,15 +64,24 @@ static char version[] =
 
 #include "sunhme.h"
 
+#define DRV_NAME	"sunhme"
+#define DRV_VERSION	"2.02"
+#define DRV_RELDATE	"8/24/03"
+#define DRV_AUTHOR	"David S. Miller (davem@redhat.com)"
+
+static char version[] =
+	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " " DRV_AUTHOR "\n";
 
-#define DRV_NAME "sunhme"
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION("Sun HappyMealEthernet(HME) 10/100baseT ethernet driver");
+MODULE_LICENSE("GPL");
 
 static int macaddr[6];
 
 /* accept MAC address of the form macaddr=0x08,0x00,0x20,0x30,0x40,0x50 */
 module_param_array(macaddr, int, NULL, 0);
 MODULE_PARM_DESC(macaddr, "Happy Meal MAC address to set");
-MODULE_LICENSE("GPL");
 
 static struct happy_meal *root_happy_dev;
 
--- linux-2.6.11/drivers/scsi/esp.c.BAD	2005-03-03 22:59:41.554051795 -0500
+++ linux-2.6.11/drivers/scsi/esp.c	2005-03-03 23:01:08.986760003 -0500
@@ -49,6 +49,8 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
 
+#define DRV_VERSION "1.101"
+
 #define DEBUG_ESP
 /* #define DEBUG_ESP_HME */
 /* #define DEBUG_ESP_DATA */
@@ -4398,5 +4400,8 @@ static struct scsi_host_template driver_
 
 #include "scsi_module.c"
 
+MODULE_DESCRIPTION("EnhancedScsiProcessor Sun SCSI driver");
+MODULE_AUTHOR("David S. Miller (davem@redhat.com)");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 

--=-DFf9eQnO5ekqqW/ykttx--

