From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Fri, 14 Sep 2012 20:44:15 +0000
Subject: [PATCH 1/2] PCI: Annotate pci_fixup_irqs with __devinit
Message-Id: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In order to keep pci_fixup_irqs() around after init (e.g. for hotplug),
mark it __devinit instead of __init. This requires the same change for
the implementation of the pcibios_update_irq() function on all
architectures.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Note: Ideally these annotations should go away completely in order to
be independent of the HOTPLUG symbol. However, there is work underway
to get rid of HOTPLUG altogether, so I've kept the __devinit for now.

 arch/alpha/kernel/pci.c   | 2 +-
 arch/mips/pci/pci.c       | 2 +-
 arch/sh/drivers/pci/pci.c | 2 +-
 arch/x86/pci/visws.c      | 2 +-
 arch/xtensa/kernel/pci.c  | 2 +-
 drivers/pci/setup-irq.c   | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 9816d5a..6192b35 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -256,7 +256,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-void __init
+void __devinit
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 6903568..af3dc05 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -313,7 +313,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-void __init
+void __devinit
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 40db2d0..d16fabe 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -192,7 +192,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-void __init pcibios_update_irq(struct pci_dev *dev, int irq)
+void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/x86/pci/visws.c b/arch/x86/pci/visws.c
index 6f2f8ee..15bdfbf 100644
--- a/arch/x86/pci/visws.c
+++ b/arch/x86/pci/visws.c
@@ -62,7 +62,7 @@ out:
 	return irq;
 }
 
-void __init pcibios_update_irq(struct pci_dev *dev, int irq)
+void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 69759e9..efc3369 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -212,7 +212,7 @@ void pcibios_set_master(struct pci_dev *dev)
 
 /* the next one is stolen from the alpha port... */
 
-void __init
+void __devinit
 pcibios_update_irq(struct pci_dev *dev, int irq)
 {
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index eb219a1..f0bcd56 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -18,7 +18,7 @@
 #include <linux/cache.h>
 
 
-static void __init
+static void __devinit
 pdev_fixup_irq(struct pci_dev *dev,
 	       u8 (*swizzle)(struct pci_dev *, u8 *),
 	       int (*map_irq)(const struct pci_dev *, u8, u8))
@@ -54,7 +54,7 @@ pdev_fixup_irq(struct pci_dev *dev,
 	pcibios_update_irq(dev, irq);
 }
 
-void __init
+void __devinit
 pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 	       int (*map_irq)(const struct pci_dev *, u8, u8))
 {
-- 
1.7.12

