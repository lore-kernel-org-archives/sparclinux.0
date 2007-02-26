From: David Miller <davem@davemloft.net>
Date: Mon, 26 Feb 2007 22:08:39 +0000
Subject: Re: E450 and kernel > 2.6.18
Message-Id: <20070226.140839.69219235.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <45D4C105.8020802@mydatex.cz>
In-Reply-To: <45D4C105.8020802@mydatex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Smolik <marvin@mydatex.cz>
Date: Thu, 22 Feb 2007 15:29:45 +0100

> Here are required logs.

Daniel and others seeing this problem, please give this
patch a try, if it fails please provide a new "of_debug=3"
kernel bootup debug log with the patch applied so I can
diagnose this further.

Thanks!

diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index b0f3e00..ad74e5e 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -708,7 +708,7 @@ static unsigned int __init pci_irq_swizzle(struct device_node *dp,
 					   unsigned int irq)
 {
 	struct linux_prom_pci_registers *regs;
-	unsigned int devfn, slot, ret;
+	unsigned int bus, devfn, slot, ret;
 
 	if (irq < 1 || irq > 4)
 		return irq;
@@ -717,10 +717,46 @@ static unsigned int __init pci_irq_swizzle(struct device_node *dp,
 	if (!regs)
 		return irq;
 
+	bus = (regs->phys_hi >> 16) & 0xff;
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	slot = (devfn >> 3) & 0x1f;
 
-	ret = ((irq - 1 + (slot & 3)) & 3) + 1;
+	if (pp->irq_trans) {
+		/* Derived from Table 8-3, U2P User's Manual.  This branch
+		 * is handling a PCI controller that lacks a proper set of
+		 * interrupt-map and interrupt-map-mask properties.  The
+		 * Ultra-E450 is one example.
+		 *
+		 * The bit layout is BSSLL, where:
+		 * B: 0 on bus A, 1 on bus B
+		 * D: 2-bit slot number, derived from PCI device number as
+		 *    (dev - 1) for bus A, or (dev - 2) for bus B
+		 * L: 2-bit line number
+		 *
+		 * Actually, more "portable" way to calculate the funky
+		 * slot number is to subtract pbm->pci_first_slot from the
+		 * device number, and that's exactly what the pre-OF
+		 * sparc64 code did, but we're building this stuff generically
+		 * using the OBP tree, not in the PCI controller layer.
+		 */
+		if (bus & 0x80) {
+			/* PBM-A */
+			bus  = 0x00;
+			slot = (slot - 1) << 2;
+		} else {
+			/* PBM-B */
+			bus  = 0x10;
+			slot = (slot - 2) << 2;
+		}
+		irq -= 1;
+
+		ret = (bus | slot | irq);
+	} else {
+		/* Going through a PCI-PCI bridge that lacks a set of
+		 * interrupt-map and interrupt-map-mask properties.
+		 */
+		ret = ((irq - 1 + (slot & 3)) & 3) + 1;
+	}
 
 	return ret;
 }
