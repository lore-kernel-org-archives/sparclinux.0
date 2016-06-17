From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Jun 2016 20:12:18 +0000
Subject: [PATCH v1 4/4] sparc/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()
Message-Id: <20160617201218.11714.38929.stgit@bhelgaas-glaptop2.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

"User" addresses are shown in /sys/devices/pci.../.../resource and
/proc/bus/pci/devices and used as mmap offsets for /proc/bus/pci/BB/DD.F
files.  On sparc, these are PCI bus addresses, i.e., raw BAR values.

Previously pci_resource_to_user() computed the user address by
subtracting either pbm->io_space.start or pbm->mem_space.start from the
resource start.

We've already told the PCI core about those offsets here:

  pci_scan_one_pbm()
    pci_add_resource_offset(&resources, &pbm->io_space, pbm->io_space.start);
    pci_add_resource_offset(&resources, &pbm->mem_space, pbm->mem_space.start);
    pci_add_resource_offset(&resources, &pbm->mem64_space, pbm->mem_space.start);

so pcibios_resource_to_bus() knows how to do that translation.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/sparc/kernel/pci.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c2b202d..9c1878f 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -986,16 +986,18 @@ void pci_resource_to_user(const struct pci_dev *pdev, int bar,
 			  const struct resource *rp, resource_size_t *start,
 			  resource_size_t *end)
 {
-	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-	unsigned long offset;
-
-	if (rp->flags & IORESOURCE_IO)
-		offset = pbm->io_space.start;
-	else
-		offset = pbm->mem_space.start;
+	struct pci_bus_region region;
 
-	*start = rp->start - offset;
-	*end = rp->end - offset;
+	/*
+	 * "User" addresses are shown in /sys/devices/pci.../.../resource
+	 * and /proc/bus/pci/devices and used as mmap offsets for
+	 * /proc/bus/pci/BB/DD.F files (see proc_bus_pci_mmap()).
+	 *
+	 * On sparc, these are PCI bus addresses, i.e., raw BAR values.
+	 */
+	pcibios_resource_to_bus(pdev->bus, &region, (struct resource *) rp);
+	*start = region.start;
+	*end = region.end;
 }
 
 void pcibios_set_master(struct pci_dev *dev)

