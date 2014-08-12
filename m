From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 12 Aug 2014 07:26:11 +0000
Subject: [RFC PATCH 18/20] Sparc/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
Message-Id: <1407828373-24322-19-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Introduce a new struct msi_chip sparc_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/sparc/kernel/pci.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 857ad77..9eabd22 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -839,18 +839,18 @@ int pci_domain_nr(struct pci_bus *pbus)
 EXPORT_SYMBOL(pci_domain_nr);
 
 #ifdef CONFIG_PCI_MSI
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+int sparc_setup_msi_irq(struct device *dev, struct msi_desc *desc)
 {
-	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
+	struct pci_pbm_info *pbm = dev->archdata.host_controller;
 	unsigned int irq;
 
 	if (!pbm->setup_msi_irq)
 		return -EINVAL;
 
-	return pbm->setup_msi_irq(&irq, pdev, desc);
+	return pbm->setup_msi_irq(&irq, to_pci_dev(dev), desc);
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+void sparc_teardown_msi_irq(unsigned int irq)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
 	struct pci_dev *pdev = entry->dev;
@@ -859,6 +859,16 @@ void arch_teardown_msi_irq(unsigned int irq)
 	if (pbm->teardown_msi_irq)
 		pbm->teardown_msi_irq(irq, pdev);
 }
+
+struct msi_chip sparc_msi_chip = {
+	.setup_irq = sparc_setup_msi_irq,
+	.teardown_irq = sparc_teardown_msi_irq,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &sparc_msi_chip;
+}
 #endif /* !(CONFIG_PCI_MSI) */
 
 static void ali_sound_dma_hack(struct pci_dev *pdev, int set_bit)
-- 
1.7.1

