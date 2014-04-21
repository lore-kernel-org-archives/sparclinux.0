From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:33 +0000
Subject: [PATCH 18/29] sparc32: fix sparse warnings in leon_pci_grpci1.c
Message-Id: <1398109184-3283-18-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
leon_pci_grpci1.c:104:5: warning: symbol 'grpci1_map_irq' was not declared. Should it be static?
leon_pci_grpci1.c:420:6: warning: symbol 'grpci1_hw_init' was not declared. Should it be static?
+ a lot of these:
leon_pci_grpci1.c:693:18: warning: incorrect type in argument 1 (different address spaces)

Added missing static to definitions.
Added __iomem annotations

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_pci_grpci1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index 6df26e3..97cba4d 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -80,7 +80,7 @@ struct grpci1_regs {
 
 struct grpci1_priv {
 	struct leon_pci_info	info; /* must be on top of this structure */
-	struct grpci1_regs	*regs;		/* GRPCI register map */
+	struct grpci1_regs __iomem *regs;		/* GRPCI register map */
 	struct device		*dev;
 	int			pci_err_mask;	/* STATUS register error mask */
 	int			irq;		/* LEON irqctrl GRPCI IRQ */
@@ -101,7 +101,7 @@ static struct grpci1_priv *grpci1priv;
 static int grpci1_cfg_w32(struct grpci1_priv *priv, unsigned int bus,
 				unsigned int devfn, int where, u32 val);
 
-int grpci1_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int grpci1_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct grpci1_priv *priv = dev->bus->sysdata;
 	int irq_group;
@@ -417,10 +417,10 @@ out:
  *  BAR1: peripheral DMA to host's memory (size at least 256MByte)
  *  BAR2..BAR5: not implemented in hardware
  */
-void grpci1_hw_init(struct grpci1_priv *priv)
+static void grpci1_hw_init(struct grpci1_priv *priv)
 {
 	u32 ahbadr, bar_sz, data, pciadr;
-	struct grpci1_regs *regs = priv->regs;
+	struct grpci1_regs __iomem *regs = priv->regs;
 
 	/* set 1:1 mapping between AHB -> PCI memory space */
 	REGSTORE(regs->cfg_stat, priv->pci_area & 0xf0000000);
@@ -509,7 +509,7 @@ static irqreturn_t grpci1_err_interrupt(int irq, void *arg)
 
 static int grpci1_of_probe(struct platform_device *ofdev)
 {
-	struct grpci1_regs *regs;
+	struct grpci1_regs __iomem *regs;
 	struct grpci1_priv *priv;
 	int err, len;
 	const int *tmp;
@@ -690,7 +690,7 @@ err3:
 err2:
 	release_resource(&priv->info.mem_space);
 err1:
-	iounmap((void *)priv->pci_io_va);
+	iounmap((void __iomem *)priv->pci_io_va);
 	grpci1priv = NULL;
 	return err;
 }
-- 
1.8.3.1

