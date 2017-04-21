From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 21 Apr 2017 05:04:48 +0000
Subject: [PATCH 01/13] sparc/PCI: Use correct offset for bus address to resource
Message-Id: <20170421050500.13957-2-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
In-Reply-To: <20170421050500.13957-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, sparclinux@vger.kernel.org

After we added 64bit mmio parsing, we got some "no compatible bridge window"
warning on anther new model that support 64bit resource.

It turns out that we can not use mem_space.start as 64bit mem space
offset, aka there is mem_space.start != offset.

Use child_phys_addr to calculate exact offset and record offset in
pbm.

After patch we get correct offset.

/pci@305: PCI IO [io  0x2007e00000000-0x2007e0fffffff] offset 2007e00000000
/pci@305: PCI MEM [mem 0x2000000100000-0x200007effffff] offset 2000000000000
/pci@305: PCI MEM64 [mem 0x2000100000000-0x2000dffffffff] offset 2000000000000
...
pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x2000000100000-0x200007effffff] (bus address [0x00100000-0x7effffff])
pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x2000dffffffff] (bus address [0x100000000-0xdffffffff])

-v3: put back mem64_offset, as we found T4 has mem_offset != mem64_offset
     check overlapping between mem64_space and mem_space.
-v7: after new pci_mmap_page_range patches.
-v8: remove change in pci_resource_to_user()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c        |  6 +++---
 arch/sparc/kernel/pci_common.c | 32 ++++++++++++++++++++++++--------
 arch/sparc/kernel/pci_impl.h   |  4 ++++
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 7eceaa1..c5cf813 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -663,12 +663,12 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
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
index 33524c1..76998f8 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -410,13 +410,16 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 
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
 
@@ -426,6 +429,8 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 		type = (pr->child_phys_hi >> 24) & 0x3;
 		a = (((unsigned long)parent_phys_hi << 32UL) |
 		     ((unsigned long)parent_phys_lo  <<  0UL));
+		region_a = (((unsigned long)child_phys_mid << 32UL) |
+		     ((unsigned long)child_phys_lo  <<  0UL));
 		size = (((unsigned long)size_hi << 32UL) |
 			((unsigned long)size_lo  <<  0UL));
 
@@ -440,6 +445,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 			pbm->io_space.start = a;
 			pbm->io_space.end = a + size - 1UL;
 			pbm->io_space.flags = IORESOURCE_IO;
+			pbm->io_offset = a - region_a;
 			saw_io = 1;
 			break;
 
@@ -448,6 +454,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 			pbm->mem_space.start = a;
 			pbm->mem_space.end = a + size - 1UL;
 			pbm->mem_space.flags = IORESOURCE_MEM;
+			pbm->mem_offset = a - region_a;
 			saw_mem = 1;
 			break;
 
@@ -456,6 +463,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 			pbm->mem64_space.start = a;
 			pbm->mem64_space.end = a + size - 1UL;
 			pbm->mem64_space.flags = IORESOURCE_MEM;
+			pbm->mem64_offset = a - region_a;
 			saw_mem = 1;
 			break;
 
@@ -471,14 +479,22 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
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
index 37222ca..2853af7 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -99,6 +99,10 @@ struct pci_pbm_info {
 	struct resource			mem_space;
 	struct resource			mem64_space;
 	struct resource			busn;
+	/* offset */
+	resource_size_t			io_offset;
+	resource_size_t			mem_offset;
+	resource_size_t			mem64_offset;
 
 	/* Base of PCI Config space, can be per-PBM or shared. */
 	unsigned long			config_space;
-- 
2.9.3

