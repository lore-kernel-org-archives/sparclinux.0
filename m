From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Apr 2012 19:25:17 +0000
Subject: [PATCH] sparc32,leon: fix leon build
Message-Id: <20120404192517.GA15590@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 7ace35687bca1189d1159cba81dda4dd82730ea7 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Apr 2012 21:20:01 +0200
Subject: [PATCH] sparc32,leon: fix leon build

Minimal fix to allow leon to be built.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---

This allows me to build a leon kernel.
It would be nice if the leon kernel at least is build-able
in mainline!

	Sam


 arch/sparc/kernel/leon_pci.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index aba6b95..19f5605 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -45,7 +45,6 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 
 void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
 {
-	struct leon_pci_info *info = pbus->sysdata;
 	struct pci_dev *dev;
 	int i, has_io, has_mem;
 	u16 cmd;
@@ -111,18 +110,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-struct device_node *pci_device_to_OF_node(struct pci_dev *pdev)
-{
-	/*
-	 * Currently the OpenBoot nodes are not connected with the PCI device,
-	 * this is because the LEON PROM does not create PCI nodes. Eventually
-	 * this will change and the same approach as pcic.c can be used to
-	 * match PROM nodes with pci devices.
-	 */
-	return NULL;
-}
-EXPORT_SYMBOL(pci_device_to_OF_node);
-
 void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 #ifdef CONFIG_PCI_DEBUG
-- 
1.6.0.6

