From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed, 21 Dec 2016 18:43:38 +0000
Subject: [PATCH] sparc: Fail userspace mmap for disabled PCI I/O and MEM BARs.
Message-Id: <1482345818-6073-1-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Check if the PCI memory starting address is disabled and return -EINVAL.
This will have minimal impact to performance as it is only during the
set up of the mmap and will avoid consequences of a failed load/store.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/sparc/kernel/pci.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 9c1878f..208d7c0 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/types.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -854,6 +855,44 @@ static void __pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vm
 	/* Our io_remap_pfn_range takes care of this, do nothing.  */
 }
 
+/* Ensure the mmap address range is within an enabled resource range. */
+int __pci_mmap_page_invalid(struct pci_dev *dev, unsigned long pfn)
+{
+	int i;
+	unsigned short cmd;
+	phys_addr_t page_start = pfn << PAGE_SHIFT;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *res = &dev->resource[i];
+
+		/* Check if this is the resource in the range.
+		 * Note: Size is not checked, so running off the end of an
+		 * enabled block into a disabled block will still result in
+		 * issues.
+		 */
+		if (res->start <= page_start && res->end >= page_start) {
+			/* Not initialized */
+			if (!res->flags)
+				return -EINVAL;
+
+			/* IO Resource disabled */
+			if ((res->flags & IORESOURCE_IO) &&
+			    !(cmd & PCI_COMMAND_IO))
+				return -EINVAL;
+
+			/* Memory Resource disabled */
+			if ((res->flags & IORESOURCE_MEM) &&
+			    !(cmd & PCI_COMMAND_MEMORY))
+				return -EINVAL;
+
+			/* Looks good */
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 /* Perform the actual remap of the pages for a PCI device mapping, as appropriate
  * for this architecture.  The region in the process to map is described by vm_start
  * and vm_end members of VMA, the base physical address is found in vm_pgoff.
@@ -872,6 +911,9 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	if (ret < 0)
 		return ret;
 
+	if (__pci_mmap_page_invalid(dev, vma->vm_pgoff))
+		return -EINVAL;
+
 	__pci_mmap_set_pgprot(dev, vma, mmap_state);
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-- 
2.1.4

