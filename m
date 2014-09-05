From: Yijing Wang <wangyijing@huawei.com>
Date: Fri, 05 Sep 2014 09:49:10 +0000
Subject: [PATCH v1 11/21] MIPS/Octeon/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <1409911806-10519-12-git-send-email-wangyijing@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wuyun <wuyun.wu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/mips/pci/msi-octeon.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
index ab0c5d1..0335d75 100644
--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -57,7 +57,7 @@ static int msi_irq_size;
  *
  * Returns 0 on success.
  */
-int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+static int octeon_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_msg msg;
 	u16 control;
@@ -133,12 +133,12 @@ msi_irq_allocated:
 	/* Make sure the search for available interrupts didn't fail */
 	if (irq >= 64) {
 		if (request_private_bits) {
-			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying just one",
+			pr_err("octeon_setup_msi_irq: Unable to find %d free interrupts, trying just one",
 			       1 << request_private_bits);
 			request_private_bits = 0;
 			goto try_only_one;
 		} else
-			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
+			panic("octeon_setup_msi_irq: Unable to find a free MSI interrupt");
 	}
 
 	/* MSI interrupts start at logical IRQ OCTEON_IRQ_MSI_BIT0 */
@@ -169,7 +169,7 @@ msi_irq_allocated:
 		msg.address_hi = (0 + CVMX_SLI_PCIE_MSI_RCV) >> 32;
 		break;
 	default:
-		panic("arch_setup_msi_irq: Invalid octeon_dma_bar_type");
+		panic("octeon_setup_msi_irq: Invalid octeon_dma_bar_type");
 	}
 	msg.data = irq - OCTEON_IRQ_MSI_BIT0;
 
@@ -184,7 +184,7 @@ msi_irq_allocated:
 	return 0;
 }
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int octeon_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -203,7 +203,7 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return 1;
 
 	list_for_each_entry(entry, &dev->msi_list, list) {
-		ret = arch_setup_msi_irq(dev, entry);
+		ret = octeon_setup_msi_irq(dev, entry);
 		if (ret < 0)
 			return ret;
 		if (ret > 0)
@@ -212,14 +212,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	return 0;
 }
-
 /**
  * Called when a device no longer needs its MSI interrupts. All
  * MSI interrupts for the device are freed.
  *
  * @irq:    The devices first irq number. There may be multple in sequence.
  */
-void arch_teardown_msi_irq(unsigned int irq)
+static void octeon_teardown_msi_irq(unsigned int irq)
 {
 	int number_irqs;
 	u64 bitmask;
@@ -228,8 +227,8 @@ void arch_teardown_msi_irq(unsigned int irq)
 
 	if ((irq < OCTEON_IRQ_MSI_BIT0)
 		|| (irq > msi_irq_size + OCTEON_IRQ_MSI_BIT0))
-		panic("arch_teardown_msi_irq: Attempted to teardown illegal "
-		      "MSI interrupt (%d)", irq);
+		panic("octeon_teardown_msi_irq: Attempted to teardown illegal "
+			"MSI interrupt (%d)", irq);
 
 	irq -= OCTEON_IRQ_MSI_BIT0;
 	index = irq / 64;
@@ -242,7 +241,7 @@ void arch_teardown_msi_irq(unsigned int irq)
 	 */
 	number_irqs = 0;
 	while ((irq0 + number_irqs < 64) &&
-	       (msi_multiple_irq_bitmask[index]
+		(msi_multiple_irq_bitmask[index]
 		& (1ull << (irq0 + number_irqs))))
 		number_irqs++;
 	number_irqs++;
@@ -251,8 +250,8 @@ void arch_teardown_msi_irq(unsigned int irq)
 	/* Shift the mask to the correct bit location */
 	bitmask <<= irq0;
 	if ((msi_free_irq_bitmask[index] & bitmask) != bitmask)
-		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
-		      "interrupt (%d) not in use", irq);
+		panic("octeon_teardown_msi_irq: Attempted to teardown MSI "
+			"interrupt (%d) not in use", irq);
 
 	/* Checks are done, update the in use bitmask */
 	spin_lock(&msi_free_irq_bitmask_lock);
@@ -261,6 +260,16 @@ void arch_teardown_msi_irq(unsigned int irq)
 	spin_unlock(&msi_free_irq_bitmask_lock);
 }
 
+static struct msi_chip octeon_msi_chip = {
+	.setup_irqs = octeon_setup_msi_irqs,
+	.teardown_irq = octeon_teardown_msi_irq,
+};
+
+struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
+{
+	return &octeon_msi_chip;
+}
+
 static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
 
 static u64 msi_rcv_reg[4];
-- 
1.7.1

