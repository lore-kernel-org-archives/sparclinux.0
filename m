From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 18 Jun 2016 02:24:47 +0000
Subject: [PATCH v13 02/16] PCI: Remove __pci_mmap_make_offset()
Message-Id: <20160618022501.15648-3-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160618022501.15648-1-yinghai@kernel.org>
In-Reply-To: <20160618022501.15648-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org

After
  PCI: Let pci_mmap_page_range() take resource address
No user for __pci_mmap_make_offset in those arch.

Remove them.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
---
 arch/microblaze/pci/pci-common.c |  63 ----------------------
 arch/powerpc/kernel/pci-common.c |  63 ----------------------
 arch/sparc/kernel/pci.c          | 113 ---------------------------------------
 arch/xtensa/kernel/pci.c         |  62 ---------------------
 4 files changed, 301 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 9e3bc05..e7cd0ab 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -156,69 +156,6 @@ void pcibios_set_master(struct pci_dev *dev)
  */
 
 /*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-					       resource_size_t *offset,
-					       enum pci_mmap_state mmap_state)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long io_offset = 0;
-	int i, res_bit;
-
-	if (!hose)
-		return NULL;		/* should never happen */
-
-	/* If memory, add on the PCI bridge address offset */
-	if (mmap_state = pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-		*offset += hose->pci_mem_offset;
-#endif
-		res_bit = IORESOURCE_MEM;
-	} else {
-		io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		*offset += io_offset;
-		res_bit = IORESOURCE_IO;
-	}
-
-	/*
-	 * Check that the offset requested corresponds to one of the
-	 * resources of the device.
-	 */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &dev->resource[i];
-		int flags = rp->flags;
-
-		/* treat ROM as memory (should be already) */
-		if (i = PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) = 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state = pci_mmap_io)
-			*offset += hose->io_base_phys - io_offset;
-		return rp;
-	}
-
-	return NULL;
-}
-
-/*
  * This one is used by /dev/mem and fbdev who have no clue about the
  * PCI device, it tries to find the PCI device first and calls the
  * above routine
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 53ba098..14c183d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -293,69 +293,6 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
  */
 
 /*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-					       resource_size_t *offset,
-					       enum pci_mmap_state mmap_state)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long io_offset = 0;
-	int i, res_bit;
-
-	if (hose = NULL)
-		return NULL;		/* should never happen */
-
-	/* If memory, add on the PCI bridge address offset */
-	if (mmap_state = pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-		*offset += hose->pci_mem_offset;
-#endif
-		res_bit = IORESOURCE_MEM;
-	} else {
-		io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		*offset += io_offset;
-		res_bit = IORESOURCE_IO;
-	}
-
-	/*
-	 * Check that the offset requested corresponds to one of the
-	 * resources of the device.
-	 */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &dev->resource[i];
-		int flags = rp->flags;
-
-		/* treat ROM as memory (should be already) */
-		if (i = PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) = 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state = pci_mmap_io)
-			*offset += hose->io_base_phys - io_offset;
-		return rp;
-	}
-
-	return NULL;
-}
-
-/*
  * This one is used by /dev/mem and fbdev who have no clue about the
  * PCI device, it tries to find the PCI device first and calls the
  * above routine
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 5f2d78e..c7d2ce6 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -732,119 +732,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
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
 /* Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 4c5f1fa..97ad3dd 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -272,68 +272,6 @@ pci_controller_num(struct pci_dev *dev)
  */
 
 /*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static __inline__ int
-__pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
-		       enum pci_mmap_state mmap_state)
-{
-	struct pci_controller *pci_ctrl = (struct pci_controller*) dev->sysdata;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long io_offset = 0;
-	int i, res_bit;
-
-	if (pci_ctrl = 0)
-		return -EINVAL;		/* should never happen */
-
-	/* If memory, add on the PCI bridge address offset */
-	if (mmap_state = pci_mmap_mem) {
-		res_bit = IORESOURCE_MEM;
-	} else {
-		io_offset = (unsigned long)pci_ctrl->io_space.base;
-		offset += io_offset;
-		res_bit = IORESOURCE_IO;
-	}
-
-	/*
-	 * Check that the offset requested corresponds to one of the
-	 * resources of the device.
-	 */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &dev->resource[i];
-		int flags = rp->flags;
-
-		/* treat ROM as memory (should be already) */
-		if (i = PCI_ROM_RESOURCE)
-			flags |= IORESOURCE_MEM;
-
-		/* Active and same type? */
-		if ((flags & res_bit) = 0)
-			continue;
-
-		/* In the range of this resource? */
-		if (offset < (rp->start & PAGE_MASK) || offset > rp->end)
-			continue;
-
-		/* found it! construct the final physical address */
-		if (mmap_state = pci_mmap_io)
-			offset += pci_ctrl->io_space.start - io_offset;
-		vma->vm_pgoff = offset >> PAGE_SHIFT;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-/*
  * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
-- 
2.8.3

