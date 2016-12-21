From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed, 21 Dec 2016 18:57:04 +0000
Subject: [PATCH] sparc: Clean up pci mmap function.
Message-Id: <1482346624-14378-1-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Simplify logic for call to __pci_mmap_make_offset which only returns
-EINVAL or zero and remove unnecessary if statement & variable from
pci_mmap_page_range.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/sparc/kernel/pci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 208d7c0..e021ae0 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -905,11 +905,9 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state,
 			int write_combine)
 {
-	int ret;
 
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
+	if (__pci_mmap_make_offset(dev, vma, mmap_state))
+		return -EINVAL;
 
 	if (__pci_mmap_page_invalid(dev, vma->vm_pgoff))
 		return -EINVAL;
@@ -917,14 +915,10 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	__pci_mmap_set_pgprot(dev, vma, mmap_state);
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	ret = io_remap_pfn_range(vma, vma->vm_start,
+	return io_remap_pfn_range(vma, vma->vm_start,
 				 vma->vm_pgoff,
 				 vma->vm_end - vma->vm_start,
 				 vma->vm_page_prot);
-	if (ret)
-		return ret;
-
-	return 0;
 }
 
 #ifdef CONFIG_NUMA
-- 
2.1.4

