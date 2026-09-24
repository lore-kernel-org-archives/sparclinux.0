Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21001480DFF;
	Thu, 24 Sep 2026 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255534; cv=none; b=ONNOLjNZ9OsvoXuazVa5PXlRHmwc0DcUS1jFJiHHkaJI0alINbrf6FeFhe2yqnqGya0S8r3ySp2e7rEB7qyXcVtmpvGv26SUf1bTvaa1Vcgro59Mk5JiEyxGrU+XAuWX93VKNC/GiVuOqbUglhZgqvcHnyde9VM1e16ekLRjrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255534; c=relaxed/simple;
	bh=g7Rf1C/r+3UV9DV7BimkhOjVMuui/avyxCs3Ib9oOag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ax0MlDhtca19CyiBihzgjDyK2o9aybCEFb8liqA1T3a21LYsVTwEi+SWgP3sY5QI46TNoFCTnuXGBVhjfQjaq8Ukkept9SXNhenQ47rP5Ld1xFEm5AaPQeycnkrfQKgcc3dM4HdskH3SEoh4bqb0eDUPigVusaLmepucGEAMdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Cfo1n7cK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Cfo1n7cK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843B41A25;
	Thu, 24 Sep 2026 06:12:01 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E32D13F86F;
	Thu, 24 Sep 2026 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790255525; bh=g7Rf1C/r+3UV9DV7BimkhOjVMuui/avyxCs3Ib9oOag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cfo1n7cKqSBF0J1b7mKA4hCNrsqXwIm1Qrks7/DPrg9wW4WneiyYMlggjNGGcY5bb
	 9py0RdAWMFugivPBGE7o73xWnJ4s+Dgb1tRRt6NeU2m9uIE6O6IY2Wvbfi9OSN4xnZ
	 IYN0VSofbPnDP8Tn90KOQ49+T4AcqGb26KIDc4lQ=
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
Subject: [PATCH v3 5/9] mm/internal: rename swap offset helpers to softleaf offset
Date: Thu, 24 Sep 2026 13:09:33 +0000
Message-ID: <20260924131106.1730494-6-dev.jain@arm.com>
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

In preparation for adding a helper to set softleaf PTEs in one go,
generalize the helpers that advance a swap-entry offset so they operate
on softleaf entries.

Softleaf entries use the same type/offset layout as swap entries, so
advancing the offset works for swap softleaves and PFN-bearing
softleaves. Preserve soft-dirty and uffd bits across the move. The
swap-exclusive bit is meaningful only for swap softleaves, so guard that
preservation with softleaf_is_swap().

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/internal.h | 31 ++++++++++++++++---------------
 mm/memory.c   |  4 ++--
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3b9fdb826162d..b8ec379b90bb0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -469,16 +469,16 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 		unsigned int max_nr);
 
 /**
- * pte_move_swp_offset - Move the swap entry offset field of a swap pte
- *	 forward or backward by delta
- * @pte: The initial pte state; must be a swap entry
+ * pte_move_softleaf_offset - Move the softleaf entry offset field of a
+ * softleaf pte forward or backward by delta
+ * @pte: The initial pte state; must be a softleaf entry
  * @delta: The direction and the offset we are moving; forward if delta
  *	 is positive; backward if delta is negative
  *
- * Moves the swap offset, while maintaining all other fields, including
- * swap type, and any swp pte bits. The resulting pte is returned.
+ * Moves the softleaf offset, while maintaining all other fields, including
+ * softleaf type, and any softleaf pte bits. The resulting pte is returned.
  */
-static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
+static inline pte_t pte_move_softleaf_offset(pte_t pte, long delta)
 {
 	const softleaf_t entry = softleaf_from_pte(pte);
 	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
@@ -486,7 +486,7 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
-	if (pte_swp_exclusive(pte))
+	if (softleaf_is_swap(entry) && pte_swp_exclusive(pte))
 		new = pte_swp_mkexclusive(new);
 	if (pte_swp_uffd(pte))
 		new = pte_swp_mkuffd(new);
@@ -496,15 +496,16 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 
 /**
- * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
- * @pte: The initial pte state; must be a swap entry.
+ * pte_next_softleaf_offset - Increment the softleaf entry offset field of a
+ * non-present pte.
+ * @pte: The initial pte state; must be a softleaf entry.
  *
- * Increments the swap offset, while maintaining all other fields, including
- * swap type, and any swp pte bits. The resulting pte is returned.
+ * Increments the softleaf offset, while maintaining all other fields, including
+ * softleaf type, and any softleaf pte bits. The resulting pte is returned.
  */
-static inline pte_t pte_next_swp_offset(pte_t pte)
+static inline pte_t pte_next_softleaf_offset(pte_t pte)
 {
-	return pte_move_swp_offset(pte, 1);
+	return pte_move_softleaf_offset(pte, 1);
 }
 
 /**
@@ -524,7 +525,7 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  */
 static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 {
-	pte_t expected_pte = pte_next_swp_offset(pte);
+	pte_t expected_pte = pte_next_softleaf_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t *ptep = start_ptep + 1;
 
@@ -536,7 +537,7 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 
 		if (!pte_same(pte, expected_pte))
 			break;
-		expected_pte = pte_next_swp_offset(expected_pte);
+		expected_pte = pte_next_softleaf_offset(expected_pte);
 		ptep++;
 	}
 
diff --git a/mm/memory.c b/mm/memory.c
index a7e979bfc814b..60fd0a08b35f5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4816,7 +4816,7 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 	idx = (vmf->address - addr) / PAGE_SIZE;
 	pte = ptep_get(ptep);
 
-	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
+	if (!pte_same(pte, pte_move_softleaf_offset(vmf->orig_pte, -idx)))
 		return false;
 	/*
 	 * swap_read_folio() can't handle the case a large folio is hybridly
@@ -5131,7 +5131,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 		folio_ptep = vmf->pte - idx;
 		folio_pte = ptep_get(folio_ptep);
-		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
+		if (!pte_same(folio_pte, pte_move_softleaf_offset(vmf->orig_pte, -idx)) ||
 		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
 			goto check_folio;
 
-- 
2.43.0

