From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:55:17 +0000
Subject: [PATCH 22/22] vt8623fb: Compute VGA base iomem pointer explicitly.
Message-Id: <20110111.155517.56364809.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


This allows the driver to work in multi-domain PCI
configurations.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/vt8623fb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 6f6f049..74df7a8 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -661,6 +661,8 @@ static struct fb_ops vt8623fb_ops = {
 
 static int __devinit vt8623_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	struct pci_bus_region bus_reg;
+	struct resource vga_res;
 	struct fb_info *info;
 	struct vt8623fb_info *par;
 	unsigned int memsize1, memsize2;
@@ -719,6 +721,15 @@ static int __devinit vt8623_pci_probe(struct pci_dev *dev, const struct pci_devi
 		goto err_iomap_2;
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
 	/* Find how many physical memory there is on card */
 	memsize1 = (vga_rseq(par->state.vgabase, 0x34) + 1) >> 1;
 	memsize2 = vga_rseq(par->state.vgabase, 0x39) << 2;
-- 
1.7.3.4

