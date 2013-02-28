From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 28 Feb 2013 14:30:20 +0000
Subject: [PATCH 1/2] sparc32,leon: add support for PCI busn resource for LEON
Message-Id: <1362061821-31584-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon_pci.h |    1 +
 arch/sparc/kernel/leon_pci.c      |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

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
-- 
1.7.0.4

