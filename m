From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 15 Oct 2014 02:29:23 +0000
Subject: [PATCH v3 21/27] Powerpc/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <1413342435-7876-22-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu@l

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
Hi Michael,
   I dropped the Acked-by , because this version has a
lot changes compared to last. So, I guess you may want to check it again.
---
 arch/powerpc/include/asm/pci-bridge.h |   15 +++++++++++++++
 arch/powerpc/kernel/msi.c             |   12 ++++++++++--
 arch/powerpc/kernel/pci-common.c      |    3 +++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 4ca90a3..233553e 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -32,6 +32,10 @@ struct pci_controller {
 	int self_busno;
 	struct resource busn;
 
+#ifdef CONFIG_PCI_MSI
+	struct msi_chip *msi_chip;
+#endif
+
 	void __iomem *io_base_virt;
 #ifdef CONFIG_PPC64
 	void *io_base_alloc;
@@ -94,6 +98,17 @@ struct pci_controller {
 	void *private_data;
 };
 
+#ifdef CONFIG_PCI_MSI
+extern struct msi_chip ppc_msi_chip;
+
+static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	return hose->msi_chip;
+}
+#endif
+
 /* These are used for config access before all the PCI probing
    has been done. */
 extern int early_read_config_byte(struct pci_controller *hose, int bus,
diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 71bd161..f38b67c 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,7 +13,8 @@
 
 #include <asm/machdep.h>
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int ppc_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
 		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
@@ -27,7 +28,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return ppc_md.setup_msi_irqs(dev, nvec, type);
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *dev)
+static void ppc_teardown_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev)
 {
 	ppc_md.teardown_msi_irqs(dev);
 }
+
+struct msi_chip ppc_msi_chip = {
+	.setup_irqs = ppc_setup_msi_irqs,
+	.teardown_irqs = ppc_teardown_msi_irqs,
+};
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b2814e2..9f18b42 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1594,6 +1594,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	/* Wire up PHB bus resources */
 	pcibios_setup_phb_resources(hose, &resources);
 
+#ifdef CONFIG_PCI_MSI
+	hose->msi_chip = &ppc_msi_chip;
+#endif
 	hose->busn.start = hose->first_busno;
 	hose->busn.end	 = hose->last_busno;
 	hose->busn.flags = IORESOURCE_BUS;
-- 
1.7.1

