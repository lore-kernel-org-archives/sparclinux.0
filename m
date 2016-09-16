From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 16 Sep 2016 20:01:52 +0000
Subject: [PATCH v14 02/17] PCI: Let pci_mmap_page_range() take resource address
Message-Id: <20160916200207.21439-3-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160916200207.21439-1-yinghai@kernel.org>
In-Reply-To: <20160916200207.21439-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org

Original pci_mmap_page_range() is taking PCI BAR value aka usr_address.

Bjorn found out that it would be much simple to pass resource address
directly and avoid extra those __pci_mmap_make_offset.

In this patch:
1. in proc path: proc_bus_pci_mmap, try convert back to resource
   before calling pci_mmap_page_range
2. in sysfs path: pci_mmap_resource will just offset with resource start.
3. all pci_mmap_page_range will have vma->vm_pgoff with in resource
   range instead of BAR value.
4. skip calling __pci_mmap_make_offset, as the checking is done
   in pci_mmap_fits().

-v2: add pci_user_to_resource and remove __pci_mmap_make_offset
-v3: pass resource pointer with pci_mmap_page_range()
-v4: put __pci_mmap_make_offset() removing to following patch
     separate /sys io access alignment checking to another patch
     updated after Bjorn's pci_resource_to_user() changes.
-v5: update after fix for pci_mmap with proc path according to
     Bjorn.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
---
 arch/microblaze/pci/pci-common.c | 11 +++++---
 arch/powerpc/kernel/pci-common.c | 11 +++++---
 arch/sparc/kernel/pci.c          |  4 ---
 arch/xtensa/kernel/pci.c         | 13 +++++++--
 drivers/pci/pci-sysfs.c          | 32 ++++++++++-----------
 drivers/pci/pci.h                |  2 +-
 drivers/pci/proc.c               | 60 ++++++++++++++++++++++++++++++++++------
 7 files changed, 93 insertions(+), 40 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 81556b8..9e3bc05 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -282,12 +282,15 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 {
 	resource_size_t offset  		((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
-	struct resource *rp;
 	int ret;
 
-	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
-	if (rp = NULL)
-		return -EINVAL;
+	if (mmap_state = pci_mmap_io) {
+		struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+		/* hose should never be NULL */
+		offset += hose->io_base_phys -
+			 ((unsigned long)hose->io_base_virt - _IO_BASE);
+	}
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e589080..67b2e68 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -515,12 +515,15 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 {
 	resource_size_t offset  		((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
-	struct resource *rp;
 	int ret;
 
-	rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
-	if (rp = NULL)
-		return -EINVAL;
+	if (mmap_state = pci_mmap_io) {
+		struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+		/* hose should never be NULL */
+		offset += hose->io_base_phys -
+			  ((unsigned long)hose->io_base_virt - _IO_BASE);
+	}
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
 	if (write_combine)
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 9c1878f..5f2d78e 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -868,10 +868,6 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 {
 	int ret;
 
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
-
 	__pci_mmap_set_pgprot(dev, vma, mmap_state);
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index b848cc3..4c5f1fa 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -366,11 +366,18 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	int ret;
 
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
+	if (mmap_state = pci_mmap_io) {
+		struct pci_controller *pci_ctrl +					 (struct pci_controller *)dev->sysdata;
+
+		/* pci_ctrl should never be NULL */
+		offset += pci_ctrl->io_space.start - pci_ctrl->io_space.base;
+	}
+
+	vma->vm_pgoff = offset >> PAGE_SHIFT;
 
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e907154..d55d93d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -972,22 +972,28 @@ void pci_remove_legacy_files(struct pci_bus *b)
 #ifdef HAVE_PCI_MMAP
 
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
+		  enum pci_mmap_state mmap_type,
 		  enum pci_mmap_api mmap_api)
 {
 	unsigned long nr, start, size, pci_start = 0;
+	int flags;
 
 	if (pci_resource_len(pdev, resno) = 0)
 		return 0;
+
+	if (mmap_type = pci_mmap_mem)
+		flags = IORESOURCE_MEM;
+	else
+		flags = IORESOURCE_IO;
+
+	if (!(pci_resource_flags(pdev, resno) & flags))
+		return 0;
+
 	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
 	size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
-	if (mmap_api = PCI_MMAP_PROCFS) {
-		resource_size_t user_start, user_end;
-
-		pci_resource_to_user(pdev, resno, &pdev->resource[resno],
-					&user_start, &user_end);
-		pci_start = user_start >> PAGE_SHIFT;
-	}
+	pci_start = (mmap_api = PCI_MMAP_PROCFS) ?
+			pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
 	if (start >= pci_start && start < pci_start + size &&
 			start + nr <= pci_start + size)
 		return 1;
@@ -1009,7 +1015,6 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	struct resource *res = attr->private;
 	enum pci_mmap_state mmap_type;
-	resource_size_t start, end;
 	int i;
 
 	for (i = 0; i < PCI_ROM_RESOURCE; i++)
@@ -1021,7 +1026,8 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-	if (!pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)) {
+	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	if (!pci_mmap_fits(pdev, i, vma, mmap_type, PCI_MMAP_SYSFS)) {
 		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
 			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
 			pci_name(pdev), i,
@@ -1030,13 +1036,7 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 		return -EINVAL;
 	}
 
-	/* pci_mmap_page_range() expects the same kind of entry as coming
-	 * from /proc/bus/pci/ which is a "user visible" value. If this is
-	 * different from the resource itself, arch will do necessary fixup.
-	 */
-	pci_resource_to_user(pdev, i, res, &start, &end);
-	vma->vm_pgoff += start >> PAGE_SHIFT;
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	vma->vm_pgoff += res->start >> PAGE_SHIFT;
 	return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9730c47..2b5db4b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -30,7 +30,7 @@ enum pci_mmap_api {
 	PCI_MMAP_PROCFS	/* mmap on /proc/bus/pci/<BDF> */
 };
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
-		  enum pci_mmap_api mmap_api);
+		  enum pci_mmap_state mmap_type, enum pci_mmap_api mmap_api);
 #endif
 int pci_probe_reset_function(struct pci_dev *dev);
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 2408abe..fadab8a 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -227,24 +227,68 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 }
 
 #ifdef HAVE_PCI_MMAP
+
+static int pci_user_to_resource(struct pci_dev *dev, resource_size_t *offset,
+				int flags)
+{
+	int i;
+
+	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+		resource_size_t start, end;
+		struct resource *res = &dev->resource[i];
+
+		if (!(res->flags & flags))
+			continue;
+
+		if (pci_resource_len(dev, i) = 0)
+			continue;
+
+		/*
+		 * here *offset is PAGE_SIZE aligned from caller.
+		 * need align start/end for io port resource that is
+		 * usually not PAGE_SIZE aligned.
+		 * that means we let it go if they falls in same page.
+		 */
+		pci_resource_to_user(dev, i, res, &start, &end);
+		if ((start & PAGE_MASK) <= *offset &&
+		     *offset <= (end & PAGE_MASK)) {
+			*offset = res->start + (*offset - start);
+			return i;
+		}
+	}
+
+	return -ENODEV;
+}
+
 static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
-	int i, ret, write_combine;
+	resource_size_t offset;
+	int i, ret, flags, write_combine;
 
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	/* Make sure the caller is mapping a real resource for this device */
-	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
-		if (pci_mmap_fits(dev, i, vma,  PCI_MMAP_PROCFS))
-			break;
-	}
-
-	if (i >= PCI_ROM_RESOURCE)
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+	if (fpriv->mmap_state = pci_mmap_mem)
+		flags = IORESOURCE_MEM;
+	else
+		flags = IORESOURCE_IO;
+	i = pci_user_to_resource(dev, &offset, flags);
+	if (i < 0)
 		return -ENODEV;
 
+	vma->vm_pgoff = offset >> PAGE_SHIFT;
+	if (!pci_mmap_fits(dev, i, vma, fpriv->mmap_state, PCI_MMAP_PROCFS)) {
+		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
+			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
+			pci_name(dev), i,
+			(u64)pci_resource_start(dev, i),
+			(u64)pci_resource_len(dev, i));
+		return -EINVAL;
+	}
+
 	if (fpriv->mmap_state = pci_mmap_mem)
 		write_combine = fpriv->write_combine;
 	else
-- 
2.8.3

