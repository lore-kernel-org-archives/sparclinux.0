From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 12 Aug 2014 07:26:08 +0000
Subject: [RFC PATCH 15/20] s390/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
Message-Id: <1407828373-24322-16-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Introduce a new struct msi_chip zpci_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/s390/pci/pci.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9ddc51e..ee7b05c 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -398,8 +398,9 @@ static void zpci_irq_handler(struct airq_struct *airq)
 	}
 }
 
-int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+int zpci_setup_msi_irqs(struct device *dev, int nvec, int type)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct zpci_dev *zdev = get_zdev(pdev);
 	unsigned int hwirq, msi_vecs;
 	unsigned long aisb;
@@ -474,8 +475,9 @@ out:
 	return rc;
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *pdev)
+void zpci_teardown_msi_irqs(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct zpci_dev *zdev = get_zdev(pdev);
 	struct msi_desc *msi;
 	int rc;
@@ -501,6 +503,16 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
 }
 
+struct msi_chip zpci_msi_chip = {
+	.setup_irqs = zpci_setup_msi_irqs,
+	.teardown_irqs = zpci_teardown_msi_irqs,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &zpci_msi_chip;
+}
+
 static void zpci_map_resources(struct zpci_dev *zdev)
 {
 	struct pci_dev *pdev = zdev->pdev;
-- 
1.7.1

