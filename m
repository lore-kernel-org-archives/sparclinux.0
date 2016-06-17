From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Jun 2016 20:12:10 +0000
Subject: [PATCH v1 3/4] powerpc/pci: Implement pci_resource_to_user() with pcibios_resource_to_bus()
Message-Id: <20160617201210.11714.5624.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
files.  For I/O port resources on powerpc, these are PCI bus addresses,
i.e., raw BAR values.

Previously pci_resource_to_user() computed the user address by subtracting
"hose->io_base_virt - _IO_BASE" from the resource start:

  pci_resource_to_user()
    if (IO)
      offset = (unsigned long)hose->io_base_virt - _IO_BASE;
    *start = rsrc->start - offset;

We've already told the PCI core about that "hose->io_base_virt - _IO_BASE"
offset:

  pcibios_setup_phb_resources()
    res = &hose->io_resource;
    offset = pcibios_io_space_offset();
    /* i.e., "offset = hose->io_base_virt - _IO_BASE" */
    pci_add_resource_offset(resources, res, offset);

so pcibios_resource_to_bus() knows how to do that translation.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/powerpc/kernel/pci-common.c |   42 +++++++++++++-------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8c6beb0..6de6e0e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -581,39 +581,25 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
 			  resource_size_t *start, resource_size_t *end)
 {
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	resource_size_t offset = 0;
+	struct pci_bus_region region;
 
-	if (hose = NULL)
+	if (rsrc->flags & IORESOURCE_IO) {
+		pcibios_resource_to_bus(dev->bus, &region,
+					(struct resource *) rsrc);
+		*start = region.start;
+		*end = region.end;
 		return;
+	}
 
-	if (rsrc->flags & IORESOURCE_IO)
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-	/* We pass a fully fixed up address to userland for MMIO instead of
-	 * a BAR value because X is lame and expects to be able to use that
-	 * to pass to /dev/mem !
-	 *
-	 * That means that we'll have potentially 64 bits values where some
-	 * userland apps only expect 32 (like X itself since it thinks only
-	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
-	 * 32 bits CHRPs :-(
-	 *
-	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
-	 * has been fixed (and the fix spread enough), we can re-enable the
-	 * 2 lines below and pass down a BAR value to userland. In that case
-	 * we'll also have to re-enable the matching code in
-	 * __pci_mmap_make_offset().
+	/* We pass a CPU physical address to userland for MMIO instead of a
+	 * BAR value because X is lame and expects to be able to use that
+	 * to pass to /dev/mem!
 	 *
-	 * BenH.
+	 * That means we may have 64-bit values where some apps only expect
+	 * 32 (like X itself since it thinks only Sparc has 64-bit MMIO).
 	 */
-#if 0
-	else if (rsrc->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-#endif
-
-	*start = rsrc->start - offset;
-	*end = rsrc->end - offset;
+	*start = rsrc->start;
+	*end = rsrc->end;
 }
 
 /**

