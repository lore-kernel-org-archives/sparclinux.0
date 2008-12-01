From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 01 Dec 2008 21:05:34 +0000
Subject: [PATCH] Adding additional PCI ID for XVR-500 fb driver
Message-Id: <20081201210534.GA5457@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

My SunBlade 1000 has the following graphics chip:

0000:00:01.0 VGA compatible controller: Intergraph Corporation Sun Expert3D-Lite Graphics Accelerator

with PCI ID 1091:07a0 (vendor ID is Intergraph Corporation). I've 
noticed that XVR-500 framebuffer driver (drivers/video/sunxvr500.c) 
supports the framebuffer device 3d3d:07a0, which only has the same 
device ID but a different vendor (3D Labs). Given that 3D Labs bought 
up Intergraph Corporation at some point, it's probably the same chip, 
so I tried adding 1091:07a0 to the list of supported PCI IDs for 
sunxvr500.c and it worked without problems, the console now is much 
nicer than the default PROM monochrome one. Please consider applying 
the included patch, which adds this card to the list of supported 
devices for XVR-500 driver.

Signed-off-by: Jurij Smakov <jurij@wooyd.org>
Tested-by: Jurij Smakov <jurij@wooyd.org>

diff -aur a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
--- a/drivers/video/sunxvr500.c	2008-11-20 18:02:37.000000000 -0500
+++ b/drivers/video/sunxvr500.c	2008-12-01 15:43:04.000000000 -0500
@@ -396,6 +396,7 @@
 
 static struct pci_device_id e3d_pci_table[] = {
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a0),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_IGRAPH, 0x7a0),	},
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a2),	},
 	{	.vendor = PCI_VENDOR_ID_3DLABS,
 		.device = PCI_ANY_ID,
diff -aur a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2008-11-20 18:02:37.000000000 -0500
+++ b/include/linux/pci_ids.h	2008-12-01 15:43:04.000000000 -0500
@@ -930,6 +930,8 @@
 #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
 #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
 
+#define PCI_VENDOR_ID_IGRAPH		0x1091
+
 #define PCI_VENDOR_ID_CMD		0x1095
 #define PCI_DEVICE_ID_CMD_643		0x0643
 #define PCI_DEVICE_ID_CMD_646		0x0646

-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
