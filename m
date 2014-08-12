From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 12 Aug 2014 07:25:57 +0000
Subject: [RFC PATCH 04/20] MSI: Remove the redundant irq_set_chip_data()
Message-Id: <1407828373-24322-5-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Currently, pcie-designware, pcie-rcar, pci-tegra drivers
use irq chip_data to the msi_chip pointer. They already call
irq_set_chip_data() in their own MSI irq map functions.
So irq_set_chip_data() in arch_setup_msi_irq() is useless.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 782b242..242d775 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -41,8 +41,6 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (err < 0)
 		return err;
 
-	irq_set_chip_data(desc->irq, chip);
-
 	return 0;
 }
 
-- 
1.7.1

