From: Yijing Wang <wangyijing@huawei.com>
Date: Mon, 27 Oct 2014 12:46:02 +0000
Subject: [PATCH 03/16] x86/xen/MSI: Use MSI controller framework to configure MSI/MSI-X irq
Message-Id: <1414416142-31239-4-git-send-email-wangyijing@huawei.com>
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
CC: David Vrabel <david.vrabel@citrix.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 466b978..83d8d50 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -157,7 +157,8 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
 
-static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_setup_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int irq, ret, i;
 	struct msi_desc *msidesc;
@@ -219,7 +220,8 @@ static void xen_msi_compose_msg(struct pci_dev *pdev, unsigned int pirq,
 	msg->data = XEN_PIRQ_MSI_DATA;
 }
 
-static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_hvm_setup_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int irq, pirq;
 	struct msi_desc *msidesc;
@@ -267,7 +269,8 @@ error:
 #ifdef CONFIG_XEN_DOM0
 static bool __read_mostly pci_seg_supported = true;
 
-static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_initdom_setup_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int ret = 0;
 	struct msi_desc *msidesc;
@@ -349,7 +352,8 @@ out:
 	return ret;
 }
 
-static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
+static void xen_initdom_restore_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *dev)
 {
 	int ret = 0;
 
@@ -376,7 +380,13 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 }
 #endif
 
-static void xen_teardown_msi_irqs(struct pci_dev *dev)
+static void xen_teardown_msi_irq(struct msi_controller *ctrl, unsigned int irq)
+{
+	xen_destroy_irq(irq);
+}
+
+static void xen_teardown_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
 
@@ -390,11 +400,7 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 	default_teardown_msi_irqs(dev);
 }
 
-static void xen_teardown_msi_irq(unsigned int irq)
-{
-	xen_destroy_irq(irq);
-}
-
+struct msi_controller xen_msi_ctrl;
 #endif
 
 int __init pci_xen_init(void)
@@ -415,9 +421,10 @@ int __init pci_xen_init(void)
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	xen_msi_ctrl.setup_irqs = xen_setup_msi_irqs;
+	xen_msi_ctrl.teardown_irq = xen_teardown_msi_irq;
+	xen_msi_ctrl.teardown_irqs = xen_teardown_msi_irqs;
+	x86_msi_ctrl = &xen_msi_ctrl;
 	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
@@ -437,8 +444,9 @@ int __init pci_xen_hvm_init(void)
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	xen_msi_ctrl.setup_irqs = xen_hvm_setup_msi_irqs;
+	xen_msi_ctrl.teardown_irq = xen_teardown_msi_irq;
+	x86_msi_ctrl = &xen_msi_ctrl;
 #endif
 	return 0;
 }
@@ -495,9 +503,10 @@ int __init pci_xen_initial_domain(void)
 	int irq;
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
+	xen_msi_ctrl.setup_irqs = xen_initdom_setup_msi_irqs;
+	xen_msi_ctrl.teardown_irq = xen_teardown_msi_irq;
+	xen_msi_ctrl.restore_irqs = xen_initdom_restore_msi_irqs;
+	x86_msi_ctrl = &xen_msi_ctrl;
 	pci_msi_ignore_mask = 1;
 #endif
 	xen_setup_acpi_sci();
-- 
1.7.1

