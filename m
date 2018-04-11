From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 08:03:36 +0000
Subject: [PATCH v3 2/2] mm: remove odd HAVE_PTE_SPECIAL
Message-Id: <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove the additional define HAVE_PTE_SPECIAL and rely directly on
CONFIG_ARCH_HAS_PTE_SPECIAL.

There is no functional change introduced by this patch

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/memory.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 96910c625daa..7f7dc7b2a341 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -817,17 +817,12 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  * PFNMAP mappings in order to support COWable mappings.
  *
  */
-#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
-# define HAVE_PTE_SPECIAL 1
-#else
-# define HAVE_PTE_SPECIAL 0
-#endif
 struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte, bool with_public_device)
 {
 	unsigned long pfn = pte_pfn(pte);
 
-	if (HAVE_PTE_SPECIAL) {
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
 		if (likely(!pte_special(pte)))
 			goto check_pfn;
 		if (vma->vm_ops && vma->vm_ops->find_special_page)
@@ -862,7 +857,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		return NULL;
 	}
 
-	/* !HAVE_PTE_SPECIAL case follows: */
+	/* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
 
 	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
 		if (vma->vm_flags & VM_MIXEDMAP) {
@@ -881,7 +876,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (is_zero_pfn(pfn))
 		return NULL;
-check_pfn:
+
+check_pfn: __maybe_unused
 	if (unlikely(pfn > highest_memmap_pfn)) {
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
@@ -891,7 +887,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 	 * NOTE! We still have PageReserved() pages in the page tables.
 	 * eg. VDSO mappings can cause them to exist.
 	 */
-out:
+out: __maybe_unused
 	return pfn_to_page(pfn);
 }
 
@@ -904,7 +900,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 	/*
 	 * There is no pmd_special() but there may be special pmds, e.g.
 	 * in a direct-access (dax) mapping, so let's just replicate the
-	 * !HAVE_PTE_SPECIAL case from vm_normal_page() here.
+	 * !CONFIG_ARCH_HAS_PTE_SPECIAL case from vm_normal_page() here.
 	 */
 	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
 		if (vma->vm_flags & VM_MIXEDMAP) {
@@ -1933,7 +1929,8 @@ static int __vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!HAVE_PTE_SPECIAL && !pfn_t_devmap(pfn) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) &&
+	    !pfn_t_devmap(pfn) && pfn_t_valid(pfn)) {
 		struct page *page;
 
 		/*
-- 
2.7.4

