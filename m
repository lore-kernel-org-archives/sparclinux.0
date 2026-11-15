Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753602;
	b=ZP0krzLdWPbPlj5iLOc7bUgkgLaxTV+qQKkemB1IsbtFXekvjYjQrGPpGO55QS06YPDe
	 vF3AnIqo9UaxUKgSX7BCqFfTJKHBhKV36mIk/EwOj4+7xuaK7VeZDlZ/5GRKO7kLA4H7a
	 g54wT2ceL6znUAKXebcje4CIm8GBIQui7bhn7ZpY1ExfeAwfo2J8J5xDhcvN2doQ89hTg
	 gKhrUle0qZ/44JRgsErtuk8WF9JX1NV2G61I3tCVtfLVh73vW0Oiyrgr/yqzl2Xe/zW+Y
	 T3Bny2+564N/qMMoas9bnwwshE0ex2jTgcOYrzQPxExOf37sFfor5tJxKQdCG1fRy5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753602;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oWLng5YzApIvQWEE6IJStWoW8rEEtuEQhrOsRVUqFVE=;
	b=RGLHZJSTFZnlaBipr2wWvpsgx7Wi5EXaG1CQ1xBbtpZSEqxaYG548fyebGYyHvDnfjBK
	 9OL249VYWqXCqqr/k/7A+ym0NnTLij9ri4RNSPYduZDZDKfuD3+yPq5Dx+KRxjA+Ybf4p
	 n4ViPUxS+sYXDaGzbpRBIljwZOf700DJyShhVs0kcqHcnz6SplMtJcp72yGB+76IDNLTh
	 d30IIv0Pl4SwHFarUvBXZUmXGzmdebtrfCprz4c8Pyx4wQdZtjd9i9RwaFLJUHulGzD9Q
	 Cvc/B9YopdKGyDGffkxsBr7v3d9h4MpEHmwnnuqpxA0akmvXikwFveHuLu28kD6NBQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rnEl8JfE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87F606A31A;
	Sun, 15 Nov 2026 14:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC87F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rnEl8JfE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EDE1476;
	Sun, 15 Nov 2026 06:39:58 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72A033F85F;
	Sun, 15 Nov 2026 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794753601; bh=pgtQLSdPvGe0ty0udFZuTeEbxrBNucpn5ieVBBoFiSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnEl8JfErrG5vE5i8mspU+V2enh0DZgOVjgz87hQqDpxiUxdICBOLhW9cYCN52Szc
	 WWmxfDeIYEj2WCkGqRGmQFC/9C0yV6yIcuJCQ+WA/Zu/9v9eqKxE728GpHnkkxsvzr
	 coRULWL7f+BcfjmU4Gl61CaY9lNj3XtIUIjkwbv0=
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
Subject: [PATCH v4 5/9] mm/internal: rename swap offset helpers to softleaf offset
Date: Sun, 15 Nov 2026 14:39:00 +0000
Message-ID: <20261115143905.3045084-6-dev.jain@arm.com>
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
index cd3675c044e0a..eaada62a86590 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -473,16 +473,16 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
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
@@ -490,7 +490,7 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
-	if (pte_swp_exclusive(pte))
+	if (softleaf_is_swap(entry) && pte_swp_exclusive(pte))
 		new = pte_swp_mkexclusive(new);
 	if (pte_swp_uffd(pte))
 		new = pte_swp_mkuffd(new);
@@ -500,15 +500,16 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 
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
@@ -528,7 +529,7 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  */
 static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 {
-	pte_t expected_pte = pte_next_swp_offset(pte);
+	pte_t expected_pte = pte_next_softleaf_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t *ptep = start_ptep + 1;
 
@@ -540,7 +541,7 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 
 		if (!pte_same(pte, expected_pte))
 			break;
-		expected_pte = pte_next_swp_offset(expected_pte);
+		expected_pte = pte_next_softleaf_offset(expected_pte);
 		ptep++;
 	}
 
diff --git a/mm/memory.c b/mm/memory.c
index d8466be900d59..5645f42c7152d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4802,7 +4802,7 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 	idx = (vmf->address - addr) / PAGE_SIZE;
 	pte = ptep_get(ptep);
 
-	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
+	if (!pte_same(pte, pte_move_softleaf_offset(vmf->orig_pte, -idx)))
 		return false;
 	/*
 	 * swap_read_folio() can't handle the case a large folio is hybridly
@@ -5154,7 +5154,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 		folio_ptep = vmf->pte - idx;
 		folio_pte = ptep_get(folio_ptep);
-		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
+		if (!pte_same(folio_pte, pte_move_softleaf_offset(vmf->orig_pte, -idx)) ||
 		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
 			goto check_folio;
 
-- 
2.43.0

