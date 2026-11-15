Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753627;
	b=MBEFPesqGW2iz6ha0i/W/23jPAeWpO3O5EvClZUu8tTYwBY3BYQ7oCObF2T8fGcXzceX
	 rZi8VProFC1ZvVxj+WGp6R4XElsPuwhpvubIG32V8Vo+6RKzdz8pHfYOwW78LGW0UCzPU
	 FEV9OYvPK6uPxO6obPuYJpQ63nSWchMXCuoXW9GCRZiRM6heGLX92HAZryu5UNl2QayWn
	 jEyRvG340a3CiSeohIG5GDG2LfwSlY8y0HrPIeagD/hi+nJs1mhK2ypjPRfM0JQYV9ZYK
	 jqA2UIyufXYvP5aVcUaVXofkfSlIWeK68gO0+bzo7AIMyF7GVDpNQ8wHIhQJk7N5b0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753627;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hx44ZHmrhNF96yWNr3bPcGAUNP+WpBOTwlC2lOoq7IE=;
	b=dxu5Ql3FsNnt8js5mYt8+oyZoqvbPC9wtSngSa5sfOPKx006vY3AcNk0dKyGkxRW9GkP
	 4kN6g0xlvV1qeypHqYyvw/g9z/BGs+FOfEFnzYVs1wmO7AjihzDSoBzy7kCvsEguD2Qhb
	 jW3vta5uDdmedovJHgtHYEk5w6xHqKn+mMqtSSq8kx6EHIh/5lxdueVT6ncl0EP1AbDOY
	 DoJAinq4YyKMNBTorM3U54htrZPKDVmoIFKwuDRCQtCHuexCiAIbBONxHE0Y84jGgB67o
	 5tKed0kJqjOrrl0OpmgmhzJOssuMm0Pf8ZztDTDk8RSRJL35i2rdybgIgixNOgZEQ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HvBscOVE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EEF606A327;
	Sun, 15 Nov 2026 14:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EEF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HvBscOVE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DCD51476;
	Sun, 15 Nov 2026 06:40:23 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 886413F85F;
	Sun, 15 Nov 2026 06:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794753626; bh=pEGYl0oKaox0/tIpp+Mu8b4JwZHSKDn4/w2uu0eAooI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvBscOVE7Wh1gfLKHZocrujZENq+hZ9WcOEpASJ9TMhQ9BHC2UC6hGPPD+GaX+LUG
	 LUwZQQ7tLQxIJBHyBvChZrz1uf+WPpIxWDYsyXIUimzOey1qyRzDPoCawxEhMKDKjS
	 euu+KycvP/FHpezXUAho7MZITo7YDwKcAHCflI8c=
From: Dev Jain <dev.jain@arm.com>
To: david@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
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
	anshuman.khandual@arm.com,
	geert@linux-m68k.org,
	sparclinux@vger.kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v4 8/9] mm/rmap: batch unmap anonymous swap-backed large folios
Date: Sun, 15 Nov 2026 14:39:03 +0000
Message-ID: <20261115143905.3045084-9-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115143905.3045084-1-dev.jain@arm.com>
References: <20261115143905.3045084-1-dev.jain@arm.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable batch clearing of PTEs and batch swap setting of PTEs for anon
swap-backed folio unmapping.

Processing all PTEs of a large folio in one go helps us batch across
atomics (add_mm_counter() etc), barriers in __folio_try_share_anon_rmap(),
and repeated calls to page_vma_mapped_walk(). In general, batching helps
execute similar code together, making the path more memory and CPU
friendly.

On arm64-contpte, batching also helps avoid redundant ptep_get() calls
and TLB flushes while breaking the contpte mapping.

The handling of anon-exclusivity is very similar to commit cac1db8c3aad
("mm: optimize mprotect() by PTE batching"). Since
folio_unmap_pte_batch() does not look at the bits of the underlying page,
process sub-batches of PTEs pointing to pages with the same exclusivity
state, and batch set only those PTEs to swap PTEs in one go.

Disable batching for sparc (because of arch_unmap_one), we will batch this
later.

Rmap accounting and reference accounting must happen when anon folio unmap
succeeds. If a large folio is only partially batched or a later sub-batch
fails, account only the pages that were actually unmapped.

If the batch length is less than the number of pages in the folio, skip
over this batch. page_vma_mapped_walk() handles this: check_pte() returns
true only if any of [pvmw->pfn, pvmw->pfn + nr_pages) is mapped by the
PTE. Swap PTEs have no underlying PFN, so check_pte() returns false until
the walk reaches the next present PTE to unmap.

Remove the finish_unmap label since no goto callers are left now.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/rmap.c | 118 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 32 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 6a6fb9b56f2cd..a2481323b778a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1981,12 +1981,13 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
 	end_addr = pmd_addr_end(addr, vma->vm_end);
 	max_nr = (end_addr - addr) >> PAGE_SHIFT;
 
-	/* We only support lazyfree or file folios batching for now ... */
-	if (folio_test_anon(folio) && folio_test_swapbacked(folio))
+	if (pte_unused(pte))
 		return 1;
 
-	if (pte_unused(pte))
+#ifdef __HAVE_ARCH_UNMAP_ONE
+	if (folio_test_anon(folio) && folio_test_swapbacked(folio))
 		return 1;
+#endif
 
 	/*
 	 * If unmap fails, we need to restore the ptes. To avoid accidentally
@@ -2156,16 +2157,25 @@ static pte_t swp_pte_prepare(swp_entry_t entry, pte_t old_pte,
 	return swp_pte;
 }
 
-static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
+static void finish_folio_unmap_batch(struct vm_area_struct *vma,
+		struct folio *folio, struct page *page, unsigned long nr_pages)
+{
+	folio_remove_rmap_ptes(folio, page, nr_pages, vma);
+	if (vma_test_any_mask(vma, VMA_LOCKED_MASK))
+		mlock_drain_local();
+	folio_put_refs(folio, nr_pages);
+}
+
+static bool __ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
 		struct folio *folio, struct page *page, unsigned long address,
-		pte_t *ptep, pte_t pteval)
+		pte_t *ptep, pte_t pteval, unsigned long nr_pages,
+		bool anon_exclusive)
 {
-	const bool anon_exclusive = folio_test_anon(folio) &&
-				    PageAnonExclusive(page);
 	swp_entry_t entry = folio_page_swap_entry(folio, page);
 	struct mm_struct *mm = vma->vm_mm;
+	pte_t swp_pte;
 
-	if (folio_dup_swap_pages(folio, page, 1) < 0)
+	if (folio_dup_swap_pages(folio, page, nr_pages) < 0)
 		return false;
 
 	/*
@@ -2174,25 +2184,61 @@ static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
 	 * so we'll not check/care.
 	 */
 	if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-		folio_put_swap_pages(folio, page, 1);
+		VM_WARN_ON(nr_pages != 1);
+		folio_put_swap_pages(folio, page, nr_pages);
 		return false;
 	}
 
 	/* See folio_try_share_anon_rmap(): clear PTE first. */
-	if (anon_exclusive && folio_try_share_anon_rmap_pte(folio, page)) {
-		folio_put_swap_pages(folio, page, 1);
+	if (anon_exclusive &&
+	    folio_try_share_anon_rmap_ptes(folio, page, nr_pages)) {
+		folio_put_swap_pages(folio, page, nr_pages);
 		return false;
 	}
 
 	mm_prepare_for_swap_entries(mm);
-	dec_mm_counter(mm, MM_ANONPAGES);
-	inc_mm_counter(mm, MM_SWAPENTS);
-	set_pte_at(mm, address, ptep,
-		   swp_pte_prepare(entry, pteval, anon_exclusive));
+	add_mm_counter(mm, MM_ANONPAGES, -nr_pages);
+	add_mm_counter(mm, MM_SWAPENTS, nr_pages);
+	swp_pte = swp_pte_prepare(entry, pteval, anon_exclusive);
+	set_softleaf_ptes(mm, address, ptep, swp_pte, nr_pages);
 	return true;
 }
 
-static bool ttu_anon_folio(struct vm_area_struct *vma, struct folio *folio,
+static unsigned long ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
+		struct folio *folio, struct page *first_page,
+		unsigned long address, pte_t *ptep, pte_t pteval,
+		unsigned long nr_pages)
+{
+	unsigned long batch_idx = 0;
+	unsigned long nr_to_unmap = nr_pages;
+
+	while (nr_pages) {
+		bool exclusive;
+		unsigned long len = page_anon_exclusive_batch(batch_idx,
+				nr_pages, first_page, &exclusive);
+
+		if (!__ttu_anon_swapbacked_folio(vma, folio,
+				first_page + batch_idx, address, ptep, pteval,
+				len, exclusive)) {
+			/* Restore the remaining PTEs that were cleared. */
+			set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
+			return nr_to_unmap - nr_pages;
+		}
+
+		nr_pages -= len;
+		if (!nr_pages)
+			break;
+
+		pteval = pte_advance_pfn(pteval, len);
+		address += len * PAGE_SIZE;
+		batch_idx += len;
+		ptep += len;
+	}
+
+	return nr_to_unmap;
+}
+
+static unsigned long ttu_anon_folio(struct vm_area_struct *vma, struct folio *folio,
 		struct page *page, unsigned long address, pte_t *ptep,
 		pte_t pteval, unsigned long nr_pages)
 {
@@ -2201,15 +2247,21 @@ static bool ttu_anon_folio(struct vm_area_struct *vma, struct folio *folio,
 	 * See handle_pte_fault() ...
 	 */
 	if (WARN_ON_ONCE(folio_test_swapbacked(folio) !=
-			 folio_test_swapcache(folio)))
-		return false;
+			 folio_test_swapcache(folio))) {
+		set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
+		return 0;
+	}
 
-	if (!folio_test_swapbacked(folio))
-		return ttu_anon_lazyfree_folio(vma, folio, nr_pages);
+	if (!folio_test_swapbacked(folio)) {
+		if (!ttu_anon_lazyfree_folio(vma, folio, nr_pages)) {
+			set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
+			return 0;
+		}
+		return nr_pages;
+	}
 
-	/* nr_pages > 1 not supported yet */
 	return ttu_anon_swapbacked_folio(vma, folio, page, address, ptep,
-					 pteval);
+					 pteval, nr_pages);
 }
 
 /*
@@ -2378,13 +2430,18 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			dec_mm_counter(mm, mm_counter(folio));
 		} else if (folio_test_anon(folio)) {
-			if (!ttu_anon_folio(vma, folio, page, address,
-					    pvmw.pte, pteval, nr_pages)) {
-				set_ptes(mm, address, pvmw.pte, pteval, nr_pages);
+			unsigned long nr_unmapped = ttu_anon_folio(vma, folio,
+						    page, address, pvmw.pte,
+						    pteval, nr_pages);
+
+			if (!nr_unmapped)
 				goto walk_abort;
-			}
 
-			goto finish_unmap;
+			/* partial success: finish for nr_unmapped and abort. */
+			if (nr_unmapped < nr_pages) {
+				finish_folio_unmap_batch(vma, folio, page, nr_unmapped);
+				goto walk_abort;
+			}
 		} else {
 			/*
 			 * This is a locked file-backed folio,
@@ -2399,11 +2456,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			add_mm_counter(mm, mm_counter_file(folio), -nr_pages);
 		}
-finish_unmap:
-		folio_remove_rmap_ptes(folio, page, nr_pages, vma);
-		if (vma_test_any_mask(vma, VMA_LOCKED_MASK))
-			mlock_drain_local();
-		folio_put_refs(folio, nr_pages);
+
+		finish_folio_unmap_batch(vma, folio, page, nr_pages);
 
 		/*
 		 * If we are sure that we batched the entire folio and cleared
-- 
2.43.0

