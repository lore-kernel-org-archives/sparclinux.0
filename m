From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 15 Oct 2014 02:33:59 +0000
Subject: [PATCH v3 02/27] x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()
Message-Id: <1413342435-7876-3-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu@l

Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
introduced two __weak arch functions arch_msix_mask_irq() and
arch_msi_mask_irq() to work around a bug when running xen in x86.
These two functions made msi code more complex. This patch reverts
the commit and introduces a global flag to control msi mask action to
avoid the bug. The patch is also preparation for using MSI chip framework
instead of weak arch MSI functions in all platforms. Keep default_msi_mask_irq()
and default_msix_mask_irq() in linux/msi.h to make s390 MSI code compile
happy, they will be removed in the later patch.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: David Vrabel <david.vrabel@citrix.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
Hi David and Konrad,
   I dropped the Acked-by and tested-by, because this version has a
lot changes compared to last. So, I guess you may want to check it again.
---
 arch/x86/include/asm/x86_init.h |    3 ---
 arch/x86/kernel/x86_init.c      |   10 ----------
 arch/x86/pci/xen.c              |   14 ++------------
 drivers/pci/msi.c               |   29 ++++++++++++-----------------
 include/linux/msi.h             |    8 ++++++--
 5 files changed, 20 insertions(+), 44 deletions(-)

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
index 093f5f4..e5b8b78 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -394,14 +394,6 @@ static void xen_teardown_msi_irq(unsigned int irq)
 {
 	xen_destroy_irq(irq);
 }
-static u32 xen_nop_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
-{
-	return 0;
-}
-static u32 xen_nop_msix_mask_irq(struct msi_desc *desc, u32 flag)
-{
-	return 0;
-}
 #endif
 
 int __init pci_xen_init(void)
@@ -425,8 +417,7 @@ int __init pci_xen_init(void)
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
 }
@@ -506,8 +497,7 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+	pci_msi_ignore_mask = 1;
 #endif
 	xen_setup_acpi_sci();
 	__acpi_register_gsi = acpi_register_gsi_xen;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ecb92a5..22e413c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -23,6 +23,7 @@
 #include "pci.h"
 
 static int pci_msi_enable = 1;
+int pci_msi_ignore_mask;
 
 #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
 
@@ -162,11 +163,11 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 
-	if (!desc->msi_attrib.maskbit)
+	if (pci_msi_ignore_mask || !desc->msi_attrib.maskbit)
 		return 0;
 
 	mask_bits &= ~mask;
@@ -176,14 +177,9 @@ u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
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
@@ -193,11 +189,15 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
  * file.  This saves a few milliseconds when initialising devices with lots
  * of MSI-X interrupts.
  */
-u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 	unsigned offset = desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
 						PCI_MSIX_ENTRY_VECTOR_CTRL;
+
+	if (pci_msi_ignore_mask)
+		return 0;
+
 	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	if (flag)
 		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
@@ -206,14 +206,9 @@ u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
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
@@ -866,7 +861,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI unmasked as initial states */
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	/* Keep cached state to be restored */
-	arch_msi_mask_irq(desc, mask, ~mask);
+	__msi_mask_irq(desc, mask, ~mask);
 
 	/* Restore dev->irq to its default pin-assertion irq */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -964,7 +959,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI-X masked as initial states */
 	list_for_each_entry(entry, &dev->msi_list, list) {
 		/* Keep cached states to be restored */
-		arch_msix_mask_irq(entry, 1);
+		__msix_mask_irq(entry, 1);
 	}
 
 	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 44f4746..9ac1e3b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -10,6 +10,8 @@ struct msi_msg {
 	u32	data;		/* 16 bits of msi message data */
 };
 
+extern int pci_msi_ignore_mask;
+
 /* Helper functions */
 struct irq_data;
 struct msi_desc;
@@ -21,6 +23,8 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void read_msi_msg(unsigned int irq, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
+u32 __msix_mask_irq(struct msi_desc *desc, u32 flag);
+u32 __msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 
 struct msi_desc {
 	struct {
@@ -61,8 +65,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 
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

