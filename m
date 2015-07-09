From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Thu, 09 Jul 2015 08:00:42 +0000
Subject: [RFC Patch V1 07/12] sparc, PCI: Use helper functions to access fields in struct msi_desc
Message-Id: <1436428847-8886-8-git-send-email-jiang.liu@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use helper functions to access fields in struct msi_desc, so we could
easily refine struct msi_desc later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sparc/kernel/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c928bc64b4ba..048b406d9e02 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -918,7 +918,7 @@ int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 void arch_teardown_msi_irq(unsigned int irq)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
-	struct pci_dev *pdev = entry->dev;
+	struct pci_dev *pdev = msi_desc_to_pci_dev(entry);
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 
 	if (pbm->teardown_msi_irq)
-- 
1.7.10.4

