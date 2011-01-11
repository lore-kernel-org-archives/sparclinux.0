From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:54:21 +0000
Subject: [PATCH 20/22] s3fb: Compute VGA base iomem pointer explicitly.
Message-Id: <20110111.155421.51284798.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


This allows the driver to work in multi-domain PCI
configurations.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/s3fb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 45e1d43..64ef7b3 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -934,6 +934,8 @@ static int __devinit s3_identification(struct s3fb_info *par)
 
 static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	struct pci_bus_region bus_reg;
+	struct resource vga_res;
 	struct fb_info *info;
 	struct s3fb_info *par;
 	int rc;
@@ -983,6 +985,15 @@ static int __devinit s3_pci_probe(struct pci_dev *dev, const struct pci_device_i
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
 	/* Unlock regs */
 	cr38 = vga_rcrt(par->state.vgabase, 0x38);
 	cr39 = vga_rcrt(par->state.vgabase, 0x39);
-- 
1.7.3.4

