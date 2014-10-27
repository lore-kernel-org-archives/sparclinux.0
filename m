From: Yijing Wang <wangyijing@huawei.com>
Date: Mon, 27 Oct 2014 12:46:03 +0000
Subject: [PATCH 14/16] Sparc/MSI: Use MSI controller framework to configure MSI/MSI-X irq
Message-Id: <1414416142-31239-15-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use MSI controller framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci.c      |   20 ++++++++++++++++++--
 arch/sparc/kernel/pci_impl.h |    3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index b36365f..c691a10 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -656,6 +656,9 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
+#ifdef CONFIG_PCI_MSI
+	pbm->msi_ctrl = &sparc_msi_ctrl;
+#endif
 	pci_add_resource_offset(&resources, &pbm->io_space,
 				pbm->io_space.start);
 	pci_add_resource_offset(&resources, &pbm->mem_space,
@@ -905,7 +908,15 @@ int pci_domain_nr(struct pci_bus *pbus)
 EXPORT_SYMBOL(pci_domain_nr);
 
 #ifdef CONFIG_PCI_MSI
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+struct msi_controller *pcibios_msi_controller(struct pci_bus *bus)
+{
+	struct pci_pbm_info *pbm = bus->sysdata;
+
+	return pbm->msi_ctrl;
+}
+
+static int sparc_setup_msi_irq(struct msi_controller *ctrl,
+		struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 	unsigned int irq;
@@ -916,7 +927,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 	return pbm->setup_msi_irq(&irq, pdev, desc);
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+static void sparc_teardown_msi_irq(struct msi_controller *ctrl, unsigned int irq)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
 	struct pci_dev *pdev = entry->dev;
@@ -925,6 +936,11 @@ void arch_teardown_msi_irq(unsigned int irq)
 	if (pbm->teardown_msi_irq)
 		pbm->teardown_msi_irq(irq, pdev);
 }
+
+struct msi_controller sparc_msi_ctrl = {
+	.setup_irq = sparc_setup_msi_irq,
+	.teardown_irq = sparc_teardown_msi_irq,
+};
 #endif /* !(CONFIG_PCI_MSI) */
 
 static void ali_sound_dma_hack(struct pci_dev *pdev, int set_bit)
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 75803c7..e02642d 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -55,6 +55,8 @@ struct sparc64_msiq_cookie {
 	struct pci_pbm_info *pbm;
 	unsigned long msiqid;
 };
+
+extern struct msi_controller sparc_msi_ctrl;
 #endif
 
 struct pci_pbm_info {
@@ -132,6 +134,7 @@ struct pci_pbm_info {
 	void				*msi_queues;
 	unsigned long			*msi_bitmap;
 	unsigned int			*msi_irq_table;
+	struct msi_controller *msi_ctrl;
 	int (*setup_msi_irq)(unsigned int *irq_p, struct pci_dev *pdev,
 			     struct msi_desc *entry);
 	void (*teardown_msi_irq)(unsigned int irq, struct pci_dev *pdev);
-- 
1.7.1

