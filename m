From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:54:35 +0000
Subject: [PATCH 21/22] arkfb: Compute VGA base iomem pointer explicitly.
Message-Id: <20110111.155435.134120804.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


This allows the driver to work in multi-domain PCI
configurations.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 7a648a7..f63fdf7 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -951,6 +951,8 @@ static struct fb_ops arkfb_ops = {
 /* PCI probe */
 static int __devinit ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	struct pci_bus_region bus_reg;
+	struct resource vga_res;
 	struct fb_info *info;
 	struct arkfb_info *par;
 	int rc;
@@ -1006,6 +1008,15 @@ static int __devinit ark_pci_probe(struct pci_dev *dev, const struct pci_device_
 		goto err_iomap;
 	}
 
+	bus_reg.start = 0;
+	bus_reg.end = 64 * 1024;
+
+	vga_res.flags = IORESOURCE_IO;
+
+	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
+
+	par->state.vgabase = (void __iomem *) vga_res.start;
+
 	/* FIXME get memsize */
 	regval = vga_rseq(par->state.vgabase, 0x10);
 	info->screen_size = (1 << (regval >> 6)) << 20;
-- 
1.7.3.4

