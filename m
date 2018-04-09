From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 09 Apr 2018 13:57:08 +0000
Subject: [PATCH 2/3] mm: replace __HAVE_ARCH_PTE_SPECIAL
Message-Id: <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Replace __HAVE_ARCH_PTE_SPECIAL by the new configuration variable
CONFIG_ARCH_HAS_PTE_SPECIAL.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 Documentation/features/vm/pte_special/arch-support.txt | 2 +-
 include/linux/pfn_t.h                                  | 4 ++--
 mm/gup.c                                               | 4 ++--
 mm/memory.c                                            | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 055004f467d2..cd05924ea875 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -1,6 +1,6 @@
 #
 # Feature name:          pte_special
-#         Kconfig:       __HAVE_ARCH_PTE_SPECIAL
+#         Kconfig:       ARCH_HAS_PTE_SPECIAL
 #         description:   arch supports the pte_special()/pte_mkspecial() VM APIs
 #
     -----------------------
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index a03c2642a87c..21713dc14ce2 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -122,7 +122,7 @@ pud_t pud_mkdevmap(pud_t pud);
 #endif
 #endif /* __HAVE_ARCH_PTE_DEVMAP */
 
-#ifdef __HAVE_ARCH_PTE_SPECIAL
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static inline bool pfn_t_special(pfn_t pfn)
 {
 	return (pfn.val & PFN_SPECIAL) = PFN_SPECIAL;
@@ -132,5 +132,5 @@ static inline bool pfn_t_special(pfn_t pfn)
 {
 	return false;
 }
-#endif /* __HAVE_ARCH_PTE_SPECIAL */
+#endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 #endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/gup.c b/mm/gup.c
index 2e2df7f3e92d..9e6a4f70deab 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1354,7 +1354,7 @@ static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
 	}
 }
 
-#ifdef __HAVE_ARCH_PTE_SPECIAL
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 int write, struct page **pages, int *nr)
 {
@@ -1430,7 +1430,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 {
 	return 0;
 }
-#endif /* __HAVE_ARCH_PTE_SPECIAL */
+#endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
 #if defined(__HAVE_ARCH_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 1bb725631ded..6fc7b9edc18f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -817,7 +817,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  * PFNMAP mappings in order to support COWable mappings.
  *
  */
-#ifdef __HAVE_ARCH_PTE_SPECIAL
+#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 # define HAVE_PTE_SPECIAL 1
 #else
 # define HAVE_PTE_SPECIAL 0
-- 
2.7.4

