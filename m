From: Ben Hutchings <ben@decadent.org.uk>
Date: Fri, 19 Feb 2010 02:56:21 +0000
Subject: [PATCH] Additional PCI id for sunxvr500 driver
Message-Id: <1266548181.10567.727.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Intergraph bought 3D Labs and some XVR-500 chips have Intergraph's
vendor id.

Reported-by: Jurij Smakov <jurij@wooyd.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@kernel.org
---
Jurij Smakov wrote on 2008-12-01:
> Hi,
> 
> My SunBlade 1000 has the following graphics chip:
> 
> 0000:00:01.0 VGA compatible controller: Intergraph Corporation Sun Expert3D-Lite Graphics Accelerator
> 
> with PCI ID 1091:07a0 (vendor ID is Intergraph Corporation). I've 
> noticed that XVR-500 framebuffer driver (drivers/video/sunxvr500.c) 
> supports the framebuffer device 3d3d:07a0, which only has the same 
> device ID but a different vendor (3D Labs). Given that 3D Labs bought 
> up Intergraph Corporation at some point, it's probably the same chip, 
> so I tried adding 1091:07a0 to the list of supported PCI IDs for 
> sunxvr500.c and it worked without problems, the console now is much 
> nicer than the default PROM monochrome one. Please consider applying 
> the included patch, which adds this card to the list of supported 
> devices for XVR-500 driver.

Jurij originally posted a patch for sunxvr500 which also touched
pci_ids.h.  This is the same thing without involving pci_ids.h.

Ben.

---
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -400,6 +400,7 @@
 
 static struct pci_device_id e3d_pci_table[] = {
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a0),	},
+	{	PCI_DEVICE(0x1091, 0x7a0),			},
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a2),	},
 	{	.vendor = PCI_VENDOR_ID_3DLABS,
 		.device = PCI_ANY_ID,

-- 
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.
