From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 15 Feb 2018 15:18:05 +0000
Subject: [PATCH v1 1/2] sparc/PCI: Support arbitrary host bridge address offset
Message-Id: <20180215151805.196756.22214.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>

Add support for arbitrary bus address offset.  Previously we ignored the
child (PCI) address in the "ranges" property and assumed it was always
zero.  That means every host bridge window mapped to PCI bus address zero,
e.g.,

  pci_bus 0000:00: root bus resource [mem 0x2000000000000-0x200007fffffff] (bus address [0x00000000-0x7fffffff])

But some systems have host bridge windows with non-zero child addresses, so
parse the child address and compute the offset between the parent (CPU) and
child (PCI) addresses.  This allows windows like these:

  /pci@305: PCI MEM [mem 0x2000000100000-0x200007effffff] offset 2000000000000
  pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0x2000000100000-0x200007effffff] (bus address [0x00100000-0x7effffff])

[bhelgaas: changelog]
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c        |    6 +++---
 arch/sparc/kernel/pci_common.c |   34 ++++++++++++++++++++++++++--------
 arch/sparc/kernel/pci_impl.h   |    4 ++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 220d0f36560a..41b20edb427d 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -664,12 +664,12 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
 	pci_add_resource_offset(&resources, &pbm->io_space,
-				pbm->io_space.start);
+				pbm->io_offset);
 	pci_add_resource_offset(&resources, &pbm->mem_space,
-				pbm->mem_space.start);
+				pbm->mem_offset);
 	if (pbm->mem64_space.flags)
 		pci_add_resource_offset(&resources, &pbm->mem64_space,
-					pbm->mem_space.start);
+					pbm->mem64_offset);
 	pbm->busn.start = pbm->pci_first_busno;
 	pbm->busn.end	= pbm->pci_last_busno;
 	pbm->busn.flags	= IORESOURCE_BUS;
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 1e10fb26fa88..14fa74f90fdb 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -397,6 +397,8 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	int i, saw_mem, saw_io;
 	int num_pbm_ranges;
 
+	/* Corresponding generic code in of_pci_get_host_bridge_resources() */
+
 	saw_mem = saw_io = 0;
 	pbm_ranges = of_get_property(pbm->op->dev.of_node, "ranges", &i);
 	if (!pbm_ranges) {
@@ -411,13 +413,16 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 
 	for (i = 0; i < num_pbm_ranges; i++) {
 		const struct linux_prom_pci_ranges *pr = &pbm_ranges[i];
-		unsigned long a, size;
+		unsigned long a, size, region_a;
 		u32 parent_phys_hi, parent_phys_lo;
+		u32 child_phys_mid, child_phys_lo;
 		u32 size_hi, size_lo;
 		int type;
 
 		parent_phys_hi = pr->parent_phys_hi;
 		parent_phys_lo = pr->parent_phys_lo;
+		child_phys_mid = pr->child_phys_mid;
+		child_phys_lo = pr->child_phys_lo;
 		if (tlb_type = hypervisor)
 			parent_phys_hi &= 0x0fffffff;
 
@@ -427,6 +432,8 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 		type = (pr->child_phys_hi >> 24) & 0x3;
 		a = (((unsigned long)parent_phys_hi << 32UL) |
 		     ((unsigned long)parent_phys_lo  <<  0UL));
+		region_a = (((unsigned long)child_phys_mid << 32UL) |
+		     ((unsigned long)child_phys_lo  <<  0UL));
 		size = (((unsigned long)size_hi << 32UL) |
 			((unsigned long)size_lo  <<  0UL));
 
@@ -441,6 +448,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 			pbm->io_space.start = a;
 			pbm->io_space.end = a + size - 1UL;
 			pbm->io_space.flags = IORESOURCE_IO;
+			pbm->io_offset = a - region_a;
 			saw_io = 1;
 			break;
 
@@ -449,6 +457,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 			pbm->mem_space.start = a;
 			pbm->mem_space.end = a + size - 1UL;
 			pbm->mem_space.flags = IORESOURCE_MEM;
+			pbm->mem_offset = a - region_a;
 			saw_mem = 1;
 			break;
 
@@ -457,6 +466,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 			pbm->mem64_space.start = a;
 			pbm->mem64_space.end = a + size - 1UL;
 			pbm->mem64_space.flags = IORESOURCE_MEM;
+			pbm->mem64_offset = a - region_a;
 			saw_mem = 1;
 			break;
 
@@ -472,14 +482,22 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 		prom_halt();
 	}
 
-	printk("%s: PCI IO[%llx] MEM[%llx]",
-	       pbm->name,
-	       pbm->io_space.start,
-	       pbm->mem_space.start);
+	if (pbm->io_space.flags)
+		printk("%s: PCI IO %pR offset %llx\n",
+		       pbm->name, &pbm->io_space, pbm->io_offset);
+	if (pbm->mem_space.flags)
+		printk("%s: PCI MEM %pR offset %llx\n",
+		       pbm->name, &pbm->mem_space, pbm->mem_offset);
+	if (pbm->mem64_space.flags && pbm->mem_space.flags) {
+		if (pbm->mem64_space.start <= pbm->mem_space.end)
+			pbm->mem64_space.start = pbm->mem_space.end + 1;
+		if (pbm->mem64_space.start > pbm->mem64_space.end)
+			pbm->mem64_space.flags = 0;
+	}
+
 	if (pbm->mem64_space.flags)
-		printk(" MEM64[%llx]",
-		       pbm->mem64_space.start);
-	printk("\n");
+		printk("%s: PCI MEM64 %pR offset %llx\n",
+		       pbm->name, &pbm->mem64_space, pbm->mem64_offset);
 
 	pbm->io_space.name = pbm->mem_space.name = pbm->name;
 	pbm->mem64_space.name = pbm->name;
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index ac172961d276..4e3d15189fa9 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -100,6 +100,10 @@ struct pci_pbm_info {
 	struct resource			mem_space;
 	struct resource			mem64_space;
 	struct resource			busn;
+	/* offset */
+	resource_size_t			io_offset;
+	resource_size_t			mem_offset;
+	resource_size_t			mem64_offset;
 
 	/* Base of PCI Config space, can be per-PBM or shared. */
 	unsigned long			config_space;

