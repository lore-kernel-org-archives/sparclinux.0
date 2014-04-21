From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:26 +0000
Subject: [PATCH 14/24] sparc32: fix sparse warnings in leon_pci_grpci2.c
Message-Id: <1398100356-19794-14-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
leon_pci_grpci2.c:218:1: warning: symbol 'grpci2_dev_lock' was not declared. Should it be static?
leon_pci_grpci2.c:219:20: warning: symbol 'grpci2priv' was not declared. Should it be static?
leon_pci_grpci2.c:221:5: warning: symbol 'grpci2_map_irq' was not declared. Should it be static?
leon_pci_grpci2.c:564:6: warning: symbol 'grpci2_hw_init' was not declared. Should it be
static?

+ a lot of these:
leon_pci_grpci2.c:252:9: warning: incorrect type in argument 1 (different address spaces)

Declare the symbols static as they are only used in this file.
Added missing __iomem annotations.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_pci_grpci2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 24d6a44..7ef0247 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -191,7 +191,7 @@ struct grpci2_cap_first {
 
 struct grpci2_priv {
 	struct leon_pci_info	info; /* must be on top of this structure */
-	struct grpci2_regs	*regs;
+	struct grpci2_regs __iomem *regs;
 	char			irq;
 	char			irq_mode; /* IRQ Mode from CAPSTS REG */
 	char			bt_enabled;
@@ -215,10 +215,10 @@ struct grpci2_priv {
 	struct grpci2_barcfg	tgtbars[6];
 };
 
-DEFINE_SPINLOCK(grpci2_dev_lock);
-struct grpci2_priv *grpci2priv;
+static DEFINE_SPINLOCK(grpci2_dev_lock);
+static struct grpci2_priv *grpci2priv;
 
-int grpci2_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int grpci2_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct grpci2_priv *priv = dev->bus->sysdata;
 	int irq_group;
@@ -561,10 +561,10 @@ out:
 	return virq;
 }
 
-void grpci2_hw_init(struct grpci2_priv *priv)
+static void grpci2_hw_init(struct grpci2_priv *priv)
 {
 	u32 ahbadr, pciadr, bar_sz, capptr, io_map, data;
-	struct grpci2_regs *regs = priv->regs;
+	struct grpci2_regs __iomem *regs = priv->regs;
 	int i;
 	struct grpci2_barcfg *barcfg = priv->tgtbars;
 
@@ -655,7 +655,7 @@ static irqreturn_t grpci2_jump_interrupt(int irq, void *arg)
 static irqreturn_t grpci2_err_interrupt(int irq, void *arg)
 {
 	struct grpci2_priv *priv = arg;
-	struct grpci2_regs *regs = priv->regs;
+	struct grpci2_regs __iomem *regs = priv->regs;
 	unsigned int status;
 
 	status = REGLOAD(regs->sts_cap);
@@ -682,7 +682,7 @@ static irqreturn_t grpci2_err_interrupt(int irq, void *arg)
 
 static int grpci2_of_probe(struct platform_device *ofdev)
 {
-	struct grpci2_regs *regs;
+	struct grpci2_regs __iomem *regs;
 	struct grpci2_priv *priv;
 	int err, i, len;
 	const int *tmp;
@@ -878,7 +878,7 @@ err4:
 	release_resource(&priv->info.mem_space);
 err3:
 	err = -ENOMEM;
-	iounmap((void *)priv->pci_io_va);
+	iounmap((void __iomem *)priv->pci_io_va);
 err2:
 	kfree(priv);
 err1:
-- 
1.8.3.1

