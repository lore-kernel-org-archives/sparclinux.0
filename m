From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 12 Aug 2014 07:26:02 +0000
Subject: [RFC PATCH 09/20] irq_remapping/MSI: Use msi_chip instead of arch func to configure MSI/MSI-X
Message-Id: <1407828373-24322-10-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Introduce a new struct msi_chip remap_msi_chip instead of weak arch
functions to configure irq remapping MSI/MSI-X in x86.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/iommu/irq_remapping.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 33c4395..f494b51 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -139,15 +139,20 @@ error:
 	return ret;
 }
 
-static int irq_remapping_setup_msi_irqs(struct pci_dev *dev,
+static int irq_remapping_setup_msi_irqs(struct device *dev,
 					int nvec, int type)
 {
 	if (type = PCI_CAP_ID_MSI)
-		return do_setup_msi_irqs(dev, nvec);
+		return do_setup_msi_irqs(to_pci_dev(dev), nvec);
 	else
-		return do_setup_msix_irqs(dev, nvec);
+		return do_setup_msix_irqs(to_pci_dev(dev), nvec);
 }
 
+struct msi_chip remap_msi_chip = {
+	.setup_irqs = irq_remapping_setup_msi_irqs,
+	.teardown_irq = native_teardown_msi_irq,
+};
+
 static void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
 {
 	/*
@@ -165,9 +170,9 @@ static void __init irq_remapping_modify_x86_ops(void)
 	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
 	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
 	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
-	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
 	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
 	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
+	x86_msi_chip = &remap_msi_chip;
 }
 
 static __init int setup_nointremap(char *str)
-- 
1.7.1

