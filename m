From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sun, 16 Oct 2011 19:12:00 +0000
Subject: [PATCH] sparc: Add alignment flag to PCI expansion resources
Message-Id: <Pine.LNX.4.64.1110162056340.25694@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Currently no type of alignment is specified for PCI expansion roms while 
parsing the openfirmware tree. This causes calls to pci_map_rom() to fail.
IORESOURCE_SIZEALIGN is the default alignment used for rom resouces in 
pci/probe.c, and has been verified to work with various cards on a ultra 10.

Signed-Off-By: Kjetil Oftedal <oftedal@gmail.com>
---

 arch/sparc/kernel/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 1e94f94..8aa0d44 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -230,7 +230,8 @@ static void pci_parse_of_addrs(struct platform_device *op,
 			res = &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
 		} else if (i = dev->rom_base_reg) {
 			res = &dev->resource[PCI_ROM_RESOURCE];
-			flags |= IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
+			flags |= IORESOURCE_READONLY | IORESOURCE_CACHEABLE
+			      | IORESOURCE_SIZEALIGN;
 		} else {
 			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
 			continue;


