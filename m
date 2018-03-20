From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 20 Mar 2018 20:14:17 +0000
Subject: [PATCH v2 2/2] sparc/PCI: Stop reserving System ROM and Video ROM in PCI space
Message-Id: <152157685713.167463.4236364024847068642.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <152157662729.167463.14127576964193645242.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152157662729.167463.14127576964193645242.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Khalid Aziz <khalid.aziz@oracle.com>
Cc: David Ahern <david.ahern@oracle.com>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, TJ <linux@iam.tj>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, sparclinux@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, pci_register_legacy_regions() reserved PCI address space under
every PCI host bridge for the System ROM and the Video ROM, but these
regions are not part of PCI address space.

Previously, pci_register_legacy_regions() reserved the following areas of
PCI address space under every PCI host bridge:

  [bus 0xa0000-0xbffff]    Video RAM area (VGA frame buffer)
  [bus 0xc0000-0xc7fff]    Video ROM
  [bus 0xf0000-0xfffff]    System ROM

It does need to reserve the [bus 0xa0000-0xbffff] region (at least if
there's a possibility of a VGA device below the bridge) because VGA devices
can respond to that even if they don't describe it with a BAR.

But the Video ROM and System ROM areas don't seem necessary because they
are not areas that legacy PCI devices respond to.

They appear to be copied from x86, where they describe areas of system
memory that depend on BIOS conventions.  On x86, BIOS copies the option ROM
of the primary VGA device to RAM at 0xc0000, and the 0xf0000-0xfffff region
is reserved for the motherboard BIOS.  Neither of these things applies to
sparc.

Stop reserving the System ROM and Video ROM regions in PCI space.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pci_common.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 14fa74f90fdb..38d46bcc8634 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -344,26 +344,6 @@ static void pci_register_legacy_regions(struct resource *io_res,
 	p->end = p->start + 0x1ffffUL;
 	p->flags = IORESOURCE_BUSY;
 	request_resource(mem_res, p);
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	p->name = "System ROM";
-	p->start = mem_res->start + 0xf0000UL;
-	p->end = p->start + 0xffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	p->name = "Video ROM";
-	p->start = mem_res->start + 0xc0000UL;
-	p->end = p->start + 0x7fffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
 }
 
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)

