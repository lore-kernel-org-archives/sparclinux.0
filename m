Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631A481658;
	Thu, 24 Sep 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255563; cv=none; b=hKdErGnJzZa0RG704f19PilQy0KVYB91550xU23Ql2yWI7+ZK+yEWWl/cQylu15g8V32N3xNwepMg3t8TbT612GolcBlijErtp6g01+IquQTs31Dj9u88pEu25St0r5nW/bdmWS8dwHFn8+dooBe/JW2Nx1HTP3BqekzYoBo2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255563; c=relaxed/simple;
	bh=rKlBajLDFkN2AhByG94LAOJ8WdXEzVoumoEj/FiHf8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpOFnL0fB+QXm0bzGmuEcLkBdqh2xkE+J2KzpMkYXnld4lmANRNKINjDLBLXNeXHU1R6og9rnSquPWYwkZn8JMKgpLtdTP2rSbS1W5Ppio50q1UBI37b+Dcl6212Iy73NKSi3hoe02qq6B8avKhIbgNr5bOG5GxZaWcdzxYn+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jP960BVS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jP960BVS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38E671C14;
	Thu, 24 Sep 2026 06:12:36 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 964643F86F;
	Thu, 24 Sep 2026 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790255559; bh=rKlBajLDFkN2AhByG94LAOJ8WdXEzVoumoEj/FiHf8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jP960BVSqgyxTgDWZPsvCQbDyJePhK8xvAxDnAB52vhEKQOxjZMKBeLajhfcJDwNp
	 T6iYh+Lf0LsI37GDyEv25pgdadsx8eRWwkksQYEbgm6exutQP0v6ATCTsyRNdQEvJN
	 eG+1UldqwEENt1HdcTcUDvYDbjM9nebJVX508sv4=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	hughd@google.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	davem@davemloft.net,
	andreas@gaisler.com
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	baolin.wang@linux.alibaba.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	jgg@ziepe.ca,
	thuth@redhat.com,
	sparclinux@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH v3 9/9] mm, sparc: batch arch_unmap_one()
Date: Thu, 24 Sep 2026 13:09:37 +0000
Message-ID: <20260924131106.1730494-10-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924131106.1730494-1-dev.jain@arm.com>
References: <20260924131106.1730494-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The anonymous large-folio unmap batching path can clear and replace
multiple PTEs at once, but architectures like sparc need arch_unmap_one()
to preserve per-page metadata before swap entries are installed.
sparc uses this hook to save ADI tags.

Extend arch_unmap_one() to operate on a pte range.

sparc uses the count to walk the PTE range and save ADI tags for entries
carrying _PAGE_MCD_4V. There is no reverse operation for a partially
saved range: saving ADI tags only records a copy for later restore, so
if a later entry fails and the core keeps the original PTEs, there is
no architectural state to unsave.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 arch/sparc/include/asm/pgtable_64.h | 10 +++++++---
 arch/sparc/kernel/adi_64.c          | 21 +++++++++++++++++++++
 include/linux/pgtable.h             |  6 +++---
 mm/rmap.c                           | 11 +++--------
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 44d1333065a6a..f7dd1872884e4 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1037,6 +1037,9 @@ void adi_restore_tags(struct mm_struct *mm, struct vm_area_struct *vma,
 int adi_save_tags(struct mm_struct *mm, struct vm_area_struct *vma,
 		  unsigned long addr, pte_t oldpte);
 
+int adi_save_tags_range(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long addr, pte_t oldpte, unsigned long nr);
+
 #define __HAVE_ARCH_DO_SWAP_PAGE
 static inline void arch_do_swap_page(struct mm_struct *mm,
 				     struct vm_area_struct *vma,
@@ -1057,10 +1060,11 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
 #define __HAVE_ARCH_UNMAP_ONE
 static inline int arch_unmap_one(struct mm_struct *mm,
 				 struct vm_area_struct *vma,
-				 unsigned long addr, pte_t oldpte)
+				 unsigned long addr, pte_t oldpte,
+				 unsigned long nr)
 {
-	if (adi_state.enabled && (pte_val(oldpte) & _PAGE_MCD_4V))
-		return adi_save_tags(mm, vma, addr, oldpte);
+	if (adi_state.enabled)
+		return adi_save_tags_range(mm, vma, addr, oldpte, nr);
 	return 0;
 }
 
diff --git a/arch/sparc/kernel/adi_64.c b/arch/sparc/kernel/adi_64.c
index 18036a43cf568..ffa378accefe3 100644
--- a/arch/sparc/kernel/adi_64.c
+++ b/arch/sparc/kernel/adi_64.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/mm_types.h>
+#include <linux/pgtable.h>
 #include <asm/mdesc.h>
 #include <asm/adi_64.h>
 #include <asm/mmu_64.h>
@@ -394,3 +395,23 @@ int adi_save_tags(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	return 0;
 }
+
+int adi_save_tags_range(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long addr, pte_t oldpte, unsigned long nr)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr; i++, addr += PAGE_SIZE,
+	     oldpte = pte_next_pfn(oldpte)) {
+		int ret;
+
+		if (!(pte_val(oldpte) & _PAGE_MCD_4V))
+			continue;
+
+		ret = adi_save_tags(mm, vma, addr, oldpte);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e3c8ab96941c5..d5c78dc938760 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1431,12 +1431,12 @@ static inline void arch_do_swap_page_nr(struct mm_struct *mm,
  * restored when the page is swapped back in. SPARC M7 and newer
  * processors support an ADI (Application Data Integrity) tag for the
  * page as metadata for the page. arch_unmap_one() can save this
- * metadata on a swap-out of a page.
+ * metadata on swap-out of one or more pages.
  */
 static inline int arch_unmap_one(struct mm_struct *mm,
 				  struct vm_area_struct *vma,
-				  unsigned long addr,
-				  pte_t orig_pte)
+				  unsigned long addr, pte_t orig_pte,
+				  unsigned long nr)
 {
 	return 0;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index cdda9efd80bc3..774ddc75194b1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1959,6 +1959,7 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
 
 	if (flags & TTU_HWPOISON)
 		return 1;
+
 	if (!folio_test_large(folio))
 		return 1;
 
@@ -1969,11 +1970,6 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
 	if (pte_unused(pte))
 		return 1;
 
-#ifdef __HAVE_ARCH_UNMAP_ONE
-	if (folio_test_anon(folio) && folio_test_swapbacked(folio))
-		return 1;
-#endif
-
 	/*
 	 * If unmap fails, we need to restore the ptes. To avoid accidentally
 	 * upgrading write permissions for ptes that were not originally
@@ -2168,8 +2164,7 @@ static bool __ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
 	 * architectures where we could have PFN swap PTEs,
 	 * so we'll not check/care.
 	 */
-	if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-		VM_WARN_ON(nr_pages != 1);
+	if (arch_unmap_one(mm, vma, address, pteval, nr_pages) < 0) {
 		folio_put_swap_pages(folio, page, nr_pages);
 		return false;
 	}
@@ -2746,7 +2741,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * architectures where we could have PFN swap PTEs,
 			 * so we'll not check/care.
 			 */
-			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
+			if (arch_unmap_one(mm, vma, address, pteval, 1) < 0) {
 				if (folio_test_hugetlb(folio))
 					set_huge_pte_at(mm, address, pvmw.pte,
 							pteval, hsz);
-- 
2.43.0

