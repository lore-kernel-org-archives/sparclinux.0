From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 04 Mar 2013 10:24:27 +0000
Subject: [PATCH v2] sparc32,leon: add support for PCI busn resource for GRPCI2
Message-Id: <1362392667-25945-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon_pci.h   |    1 +
 arch/sparc/kernel/leon_pci.c        |    2 ++
 arch/sparc/kernel/leon_pci_grpci2.c |    5 +++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/leon_pci.h b/arch/sparc/include/asm/leon_pci.h
index f48527e..bfd3ab3 100644
--- a/arch/sparc/include/asm/leon_pci.h
+++ b/arch/sparc/include/asm/leon_pci.h
@@ -12,6 +12,7 @@ struct leon_pci_info {
 	struct pci_ops *ops;
 	struct resource	io_space;
 	struct resource	mem_space;
+	struct resource	busn;
 	int (*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
 };
 
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 852dc84..88aaaa5 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -29,6 +29,8 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 	pci_add_resource_offset(&resources, &info->io_space,
 				info->io_space.start - 0x1000);
 	pci_add_resource(&resources, &info->mem_space);
+	info->busn.flags = IORESOURCE_BUS;
+	pci_add_resource(&resources, &info->busn);
 
 	root_bus = pci_scan_root_bus(&ofdev->dev, 0, info->ops, info,
 				     &resources);
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 4d14871..5f0402a 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -799,6 +799,11 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 	if (request_resource(&ioport_resource, &priv->info.io_space) < 0)
 		goto err4;
 
+	/* setup maximum supported PCI buses */
+	priv->info.busn.name = "GRPCI2 busn";
+	priv->info.busn.start = 0;
+	priv->info.busn.end = 255;
+
 	grpci2_hw_init(priv);
 
 	/*
-- 
1.7.0.4

