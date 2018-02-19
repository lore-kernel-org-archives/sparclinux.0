From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 19 Feb 2018 13:04:12 +0000
Subject: [PATCH] sparc: Use generic pci_mmap_resource_range()
Message-Id: <1519045452-22645-1-git-send-email-dwmw@amazon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

Commit f719582435 ("PCI: Add pci_mmap_resource_range() and use it for
ARM64") added this generic function with the intent of using it
everywhere and ultimately killing the old arch-specific implementations.

Let's get on with that eradication...

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/sparc/include/asm/pci_64.h |   1 +
 arch/sparc/kernel/pci.c         | 155 ----------------------------------------
 2 files changed, 1 insertion(+), 155 deletions(-)

diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 671274e..95d41c8 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -43,6 +43,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
 #define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define arch_can_pci_mmap_io()	1
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 220d0f3..1c1f632 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -721,161 +721,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-/* Platform support for /proc/bus/pci/X/Y mmap()s. */
-
-/* If the user uses a host-bridge as the PCI device, he may use
- * this to perform a raw mmap() of the I/O or MEM space behind
- * that controller.
- *
- * This can be useful for execution of x86 PCI bios initialization code
- * on a PCI card, like the xfree86 int10 stuff does.
- */
-static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struct *vma,
-				      enum pci_mmap_state mmap_state)
-{
-	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-	unsigned long space_size, user_offset, user_size;
-
-	if (mmap_state = pci_mmap_io) {
-		space_size = resource_size(&pbm->io_space);
-	} else {
-		space_size = resource_size(&pbm->mem_space);
-	}
-
-	/* Make sure the request is in range. */
-	user_offset = vma->vm_pgoff << PAGE_SHIFT;
-	user_size = vma->vm_end - vma->vm_start;
-
-	if (user_offset >= space_size ||
-	    (user_offset + user_size) > space_size)
-		return -EINVAL;
-
-	if (mmap_state = pci_mmap_io) {
-		vma->vm_pgoff = (pbm->io_space.start +
-				 user_offset) >> PAGE_SHIFT;
-	} else {
-		vma->vm_pgoff = (pbm->mem_space.start +
-				 user_offset) >> PAGE_SHIFT;
-	}
-
-	return 0;
-}
-
-/* Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static int __pci_mmap_make_offset(struct pci_dev *pdev,
-				  struct vm_area_struct *vma,
-				  enum pci_mmap_state mmap_state)
-{
-	unsigned long user_paddr, user_size;
-	int i, err;
-
-	/* First compute the physical address in vma->vm_pgoff,
-	 * making sure the user offset is within range in the
-	 * appropriate PCI space.
-	 */
-	err = __pci_mmap_make_offset_bus(pdev, vma, mmap_state);
-	if (err)
-		return err;
-
-	/* If this is a mapping on a host bridge, any address
-	 * is OK.
-	 */
-	if ((pdev->class >> 8) = PCI_CLASS_BRIDGE_HOST)
-		return err;
-
-	/* Otherwise make sure it's in the range for one of the
-	 * device's resources.
-	 */
-	user_paddr = vma->vm_pgoff << PAGE_SHIFT;
-	user_size = vma->vm_end - vma->vm_start;
-
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &pdev->resource[i];
-		resource_size_t aligned_end;
-
-		/* Active? */
-		if (!rp->flags)
-			continue;
-
-		/* Same type? */
-		if (i = PCI_ROM_RESOURCE) {
-			if (mmap_state != pci_mmap_mem)
-				continue;
-		} else {
-			if ((mmap_state = pci_mmap_io &&
-			     (rp->flags & IORESOURCE_IO) = 0) ||
-			    (mmap_state = pci_mmap_mem &&
-			     (rp->flags & IORESOURCE_MEM) = 0))
-				continue;
-		}
-
-		/* Align the resource end to the next page address.
-		 * PAGE_SIZE intentionally added instead of (PAGE_SIZE - 1),
-		 * because actually we need the address of the next byte
-		 * after rp->end.
-		 */
-		aligned_end = (rp->end + PAGE_SIZE) & PAGE_MASK;
-
-		if ((rp->start <= user_paddr) &&
-		    (user_paddr + user_size) <= aligned_end)
-			break;
-	}
-
-	if (i > PCI_ROM_RESOURCE)
-		return -EINVAL;
-
-	return 0;
-}
-
-/* Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
- * device mapping.
- */
-static void __pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vma,
-					     enum pci_mmap_state mmap_state)
-{
-	/* Our io_remap_pfn_range takes care of this, do nothing.  */
-}
-
-/* Perform the actual remap of the pages for a PCI device mapping, as appropriate
- * for this architecture.  The region in the process to map is described by vm_start
- * and vm_end members of VMA, the base physical address is found in vm_pgoff.
- * The pci device structure is provided so that architectures may make mapping
- * decisions on a per-device or per-bus basis.
- *
- * Returns a negative error code on failure, zero on success.
- */
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	int ret;
-
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
-
-	__pci_mmap_set_pgprot(dev, vma, mmap_state);
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	ret = io_remap_pfn_range(vma, vma->vm_start,
-				 vma->vm_pgoff,
-				 vma->vm_end - vma->vm_start,
-				 vma->vm_page_prot);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 #ifdef CONFIG_NUMA
 int pcibus_to_node(struct pci_bus *pbus)
 {
-- 
2.7.4

