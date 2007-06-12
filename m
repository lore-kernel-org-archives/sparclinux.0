From: David Miller <davem@davemloft.net>
Date: Tue, 12 Jun 2007 23:55:34 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070612.165534.108742469.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This should fix the problem, thanks for all of the debugging
information.

Let me know if the X regression is still not fixed.

commit cf58de958f939587637ea74cdc3382bc140a936b
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Tue Jun 12 16:54:08 2007 -0700

    [SPARC64]: Fix IO/MEM space sizing for PCI.
    
    In pci_determine_mem_io_space(), do not hard code the region sizes.
    Instead, use the values given to us in the ranges property.
    
    Thanks goes to Mikael Petterson for the original Xorg failure
    bug repoert, and strace dumps from Mikael and Dmitry Artamonow.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/pci_common.c b/arch/sparc64/kernel/pci_common.c
index f974fef..4249214 100644
--- a/arch/sparc64/kernel/pci_common.c
+++ b/arch/sparc64/kernel/pci_common.c
@@ -291,8 +291,9 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 
 	for (i = 0; i < num_pbm_ranges; i++) {
 		const struct linux_prom_pci_ranges *pr = &pbm_ranges[i];
-		unsigned long a;
+		unsigned long a, size;
 		u32 parent_phys_hi, parent_phys_lo;
+		u32 size_hi, size_lo;
 		int type;
 
 		parent_phys_hi = pr->parent_phys_hi;
@@ -300,9 +301,14 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 		if (tlb_type = hypervisor)
 			parent_phys_hi &= 0x0fffffff;
 
+		size_hi = pr->size_hi;
+		size_lo = pr->size_lo;
+
 		type = (pr->child_phys_hi >> 24) & 0x3;
 		a = (((unsigned long)parent_phys_hi << 32UL) |
 		     ((unsigned long)parent_phys_lo  <<  0UL));
+		size = (((unsigned long)size_hi << 32UL) |
+			((unsigned long)size_lo  <<  0UL));
 
 		switch (type) {
 		case 0:
@@ -313,7 +319,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 		case 1:
 			/* 16-bit IO space, 16MB */
 			pbm->io_space.start = a;
-			pbm->io_space.end = a + ((16UL*1024UL*1024UL) - 1UL);
+			pbm->io_space.end = a + size - 1UL;
 			pbm->io_space.flags = IORESOURCE_IO;
 			saw_io = 1;
 			break;
@@ -321,7 +327,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 		case 2:
 			/* 32-bit MEM space, 2GB */
 			pbm->mem_space.start = a;
-			pbm->mem_space.end = a + (0x80000000UL - 1UL);
+			pbm->mem_space.end = a + size - 1UL;
 			pbm->mem_space.flags = IORESOURCE_MEM;
 			saw_mem = 1;
 			break;
