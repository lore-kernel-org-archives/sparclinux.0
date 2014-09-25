From: Yijing Wang <wangyijing@huawei.com>
Date: Thu, 25 Sep 2014 02:56:28 +0000
Subject: [PATCH v2 04/22] x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()
Message-Id: <1411614872-4009-5-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David

Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
and arch_msi_mask_irq() to fix a bug found when running xen in x86.
Introduced these two funcntions make MSI code complex. And mask/unmask
is the irq actions related to interrupt controller, should not use
weak arch functions to override mask/unmask interfaces. This patch
reverted commit 0e4ccb150 and export struct irq_chip msi_chip, modify
msi_chip->irq_mask/irq_unmask() in xen init functions to fix this
bug for simplicity. Also this is preparation for using struct
msi_chip instead of weak arch MSI functions in all platforms.
Keep default_msi_mask_irq() and default_msix_mask_irq() in
linux/msi.h to make s390 MSI code compile happy, they wiil be removed
in the later patch.

Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Acked-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/include/asm/apic.h     |    4 ++++
 arch/x86/include/asm/x86_init.h |    3 ---
 arch/x86/kernel/apic/io_apic.c  |    2 +-
 arch/x86/kernel/x86_init.c      |   10 ----------
 arch/x86/pci/xen.c              |   16 ++++++----------
 drivers/pci/msi.c               |   22 ++++++----------------
 include/linux/msi.h             |    6 ++++--
 7 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 465b309..47a5f94 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -43,6 +43,10 @@ static inline void generic_apic_probe(void)
 }
 #endif
 
+#ifdef CONFIG_PCI_MSI
+extern struct irq_chip msi_chip;
+#endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
 
 extern unsigned int apic_verbosity;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index e45e4da..f58a9c7 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -172,7 +172,6 @@ struct x86_platform_ops {
 
 struct pci_dev;
 struct msi_msg;
-struct msi_desc;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
@@ -183,8 +182,6 @@ struct x86_msi_ops {
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 	int  (*setup_hpet_msi)(unsigned int irq, unsigned int id);
-	u32 (*msi_mask_irq)(struct msi_desc *desc, u32 mask, u32 flag);
-	u32 (*msix_mask_irq)(struct msi_desc *desc, u32 flag);
 };
 
 struct IO_APIC_route_entry;
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e877cfb..2a2ec28 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3161,7 +3161,7 @@ msi_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force)
  * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI or MSI-X Capability Structure.
  */
-static struct irq_chip msi_chip = {
+struct irq_chip msi_chip = {
 	.name			= "PCI-MSI",
 	.irq_unmask		= unmask_msi_irq,
 	.irq_mask		= mask_msi_irq,
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e48b674..234b072 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -116,8 +116,6 @@ struct x86_msi_ops x86_msi = {
 	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 	.setup_hpet_msi		= default_setup_hpet_msi,
-	.msi_mask_irq		= default_msi_mask_irq,
-	.msix_mask_irq		= default_msix_mask_irq,
 };
 
 /* MSI arch specific hooks */
@@ -140,14 +138,6 @@ void arch_restore_msi_irqs(struct pci_dev *dev)
 {
 	x86_msi.restore_msi_irqs(dev);
 }
-u32 arch_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return x86_msi.msi_mask_irq(desc, mask, flag);
-}
-u32 arch_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return x86_msi.msix_mask_irq(desc, flag);
-}
 #endif
 
 struct x86_io_apic_ops x86_io_apic_ops = {
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index ad03739..84c2fce 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -394,13 +394,9 @@ static void xen_teardown_msi_irq(unsigned int irq)
 {
 	xen_destroy_irq(irq);
 }
-static u32 xen_nop_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return 0;
-}
-static u32 xen_nop_msix_mask_irq(struct msi_desc *desc, u32 flag)
+
+void xen_nop_msi_mask(struct irq_data *data)
 {
-	return 0;
 }
 #endif
 
@@ -425,8 +421,8 @@ int __init pci_xen_init(void)
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	msi_chip.irq_mask = xen_nop_msi_mask;
+	msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
 	return 0;
 }
@@ -506,8 +502,8 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	msi_chip.irq_mask = xen_nop_msi_mask;
+	msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
 	xen_setup_acpi_sci();
 	__acpi_register_gsi = acpi_register_gsi_xen;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 50f67a3..5f8f3af 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -162,7 +162,7 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 
@@ -176,14 +176,9 @@ u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 	return mask_bits;
 }
 
-__weak u32 arch_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return default_msi_mask_irq(desc, mask, flag);
-}
-
 static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
-	desc->masked = arch_msi_mask_irq(desc, mask, flag);
+	desc->masked = __msi_mask_irq(desc, mask, flag);
 }
 
 /*
@@ -193,7 +188,7 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
  * file.  This saves a few milliseconds when initialising devices with lots
  * of MSI-X interrupts.
  */
-u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 	unsigned offset = desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
@@ -206,14 +201,9 @@ u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
 	return mask_bits;
 }
 
-__weak u32 arch_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return default_msix_mask_irq(desc, flag);
-}
-
 static void msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
-	desc->masked = arch_msix_mask_irq(desc, flag);
+	desc->masked = __msix_mask_irq(desc, flag);
 }
 
 static void msi_set_mask_bit(struct irq_data *data, u32 flag)
@@ -852,7 +842,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI unmasked as initial states */
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	/* Keep cached state to be restored */
-	arch_msi_mask_irq(desc, mask, ~mask);
+	__msi_mask_irq(desc, mask, ~mask);
 
 	/* Restore dev->irq to its default pin-assertion irq */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -950,7 +940,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI-X masked as initial states */
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		/* Keep cached states to be restored */
-		arch_msix_mask_irq(entry, 1);
+		__msix_mask_irq(entry, 1);
 	}
 
 	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 45ef8cb..cc46a62 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -19,6 +19,8 @@ void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag);
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 
 struct msi_desc {
 	struct {
@@ -59,8 +61,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
-u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
-u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag);
+#define default_msi_mask_irq	__msi_mask_irq
+#define default_msix_mask_irq	__msix_mask_irq
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.1

