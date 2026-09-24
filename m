Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A18387590;
	Thu, 24 Sep 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255519; cv=none; b=Ja2n3fYc+PyWcvmibkwpdd6Dex3dnezAzZBNK4ro82TnX7oBEuW7yK4e0mcr2x9b8kn1lfGYja1+RL2gW3qgZVxwFt0nlUOc+1W2PLHCfOAgN/gPpA402zwn5gasajAphj7i0Y4TiJ01uM9tti8CxkP1EET7ZU1yIRdk0oxhOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255519; c=relaxed/simple;
	bh=omnc/jiGce2ioWghxdLYMfvILVqD+Qx1+Ygyy+n/n2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDahzF3R2aJwl3YnOAeKORm0nVLqdkdQzxVrSIY1iD7tfDe4r5NUQrQjDkb/FdjdLX82iJxlNEml7ehmZleVoLxecezXRRlP3siqf5Y06q5XtINNmGsKY4afCshgWelgRGlMzyradaUzYDhMxelLzESiAeQWTN8huW2t/Fqe5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Cqw+z1JR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Cqw+z1JR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D57051A32;
	Thu, 24 Sep 2026 06:11:52 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4174C3F86F;
	Thu, 24 Sep 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790255516; bh=omnc/jiGce2ioWghxdLYMfvILVqD+Qx1+Ygyy+n/n2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cqw+z1JRNnoGVg2M6BZ0XIIofy3CKrxfcxsiHv5K+w04E+MA396UFlL/9MTxcEloj
	 ud6CPr2NiTciVXHDU2JreHt0oDkzaKPTyWyHjt7MGCOjQR57BRSR//s31IDbO3h2TW
	 1507rdZMwHyYs34HsTPCcSn5rAfhP9nMsXTEXPHw=
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
Subject: [PATCH v3 4/9] mm/rmap: Add batched version of folio_try_share_anon_rmap_pte
Date: Thu, 24 Sep 2026 13:09:32 +0000
Message-ID: <20260924131106.1730494-5-dev.jain@arm.com>
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

To enable batched unmapping of anonymous folios, we need to handle the
sharing of exclusive pages. Hence, a batched version of
folio_try_share_anon_rmap_pte is required.

Currently, the sole purpose of nr_pages in __folio_try_share_anon_rmap is
to do some rmap sanity checks. Now, clear the PageAnonExclusive bit on a
batch of nr_pages. Refactor the function such that the clearing of the bit
can be done at one place without duplication.

Note that __folio_try_share_anon_rmap can receive nr_pages == HPAGE_PMD_NR
from the PMD path, but currently we only clear the bit on the head page.
Retain this behaviour by setting nr_pages = 1 in case the caller is
folio_try_share_anon_rmap_pmd.

While at it, convert nr_pages to unsigned long to future-proof from
overflow in case P4D-huge mappings etc get supported down the road.
I haven't made such a change in each function receiving nr_pages in
try_to_unmap_one - perhaps this can be done incrementally.

Add two WARN's: check that the batch is entirely exclusive (for PMD
callers, need to check only head page), and that there are only
PTE/PMD paths converging into __folio_try_share_anon_rmap.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/rmap.h | 56 ++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 62ef511a6175a..91b5763ef466f 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -723,17 +723,23 @@ static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
 }
 
 static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
-		struct page *page, int nr_pages, enum pgtable_level level)
+		struct page *page, unsigned long nr_pages, enum pgtable_level level)
 {
+	/* device private folios cannot get pinned via GUP. */
+	const bool pinnable = !folio_is_device_private(folio);
+
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 	VM_WARN_ON_FOLIO(!PageAnonExclusive(page), folio);
+
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
-	/* device private folios cannot get pinned via GUP. */
-	if (unlikely(folio_is_device_private(folio))) {
-		ClearPageAnonExclusive(page);
-		return 0;
-	}
+	VM_WARN_ON_ONCE(level != PGTABLE_LEVEL_PTE && level != PGTABLE_LEVEL_PMD);
+
+	/* We only clear anon-exclusive from head page of PMD folio. */
+	if (level == PGTABLE_LEVEL_PMD)
+		nr_pages = 1;
+
+	VM_WARN_ON_FOLIO(page_anon_exclusive_batch(0, nr_pages, page, true) != nr_pages, folio);
 
 	/*
 	 * We have to make sure that when we clear PageAnonExclusive, that
@@ -777,29 +783,38 @@ static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
 	 * so we use explicit ones here.
 	 */
 
-	/* Paired with the memory barrier in try_grab_folio(). */
-	if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
-		smp_mb();
+	if (likely(pinnable)) {
+		/* Paired with the memory barrier in try_grab_folio(). */
+		if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
+			smp_mb();
 
-	if (unlikely(folio_maybe_dma_pinned(folio)))
-		return -EBUSY;
-	ClearPageAnonExclusive(page);
+		if (unlikely(folio_maybe_dma_pinned(folio)))
+			return -EBUSY;
+	}
+
+	for (;;) {
+		ClearPageAnonExclusive(page);
+		if (--nr_pages == 0)
+			break;
+		page++;
+	}
 
 	/*
 	 * This is conceptually a smp_wmb() paired with the smp_rmb() in
 	 * gup_must_unshare().
 	 */
-	if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
+	if (likely(pinnable) && IS_ENABLED(CONFIG_HAVE_GUP_FAST))
 		smp_mb__after_atomic();
 	return 0;
 }
 
 /**
- * folio_try_share_anon_rmap_pte - try marking an exclusive anonymous page
- *				   mapped by a PTE possibly shared to prepare
+ * folio_try_share_anon_rmap_ptes - try marking exclusive anonymous pages
+ *				   mapped by PTEs possibly shared to prepare
  *				   for KSM or temporary unmapping
  * @folio:	The folio to share a mapping of
- * @page:	The mapped exclusive page
+ * @page:	The first mapped exclusive page of the batch in the folio
+ * @nr_pages:	The number of pages to share in the folio (batch size)
  *
  * The caller needs to hold the page table lock and has to have the page table
  * entries cleared/invalidated.
@@ -815,10 +830,17 @@ static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
  * Returns 0 if marking the mapped page possibly shared succeeded. Returns
  * -EBUSY otherwise.
  */
+static inline int folio_try_share_anon_rmap_ptes(struct folio *folio,
+		struct page *page, unsigned long nr_pages)
+{
+	return __folio_try_share_anon_rmap(folio, page, nr_pages,
+					   PGTABLE_LEVEL_PTE);
+}
+
 static inline int folio_try_share_anon_rmap_pte(struct folio *folio,
 		struct page *page)
 {
-	return __folio_try_share_anon_rmap(folio, page, 1, PGTABLE_LEVEL_PTE);
+	return folio_try_share_anon_rmap_ptes(folio, page, 1);
 }
 
 /**
-- 
2.43.0

