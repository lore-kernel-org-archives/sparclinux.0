Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753586;
	b=zv9EOejG6Knrkfe8UkiARRoAzhn9QW1ez1g95eP9Q2siV3fziWBK/8HrRDOyLdKwGXCN
	 L+ik/7S6Bnu9q+VnJVjEVw+s4iPByGopjVefP4qMfy9KYpLvntxMDekVNFtf7+HzY8wY5
	 LAK/OFGBDJBNQKAjWP8a8F7HEkCZ+Z4INuQIJaHgFfFp3GN/7O29lWgD+XqSyDFavXmVT
	 pMERj5iBMIs8vSenF7OruXlxLFpE1AOBBXu5tqFT4tCJbyu31CaUG2Yo3jPNnbXEl2gc2
	 pmarrX8af6fLCeb6FFe7i3tyMHaEgqFndFGMA+UhDFbqlUQoQ4qGQJSEGq3zEj05S+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753586;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C36S7WPR2YYhjD8S8SUsmlfuQc7R28qqteWGQjqPDCE=;
	b=OJLLn+D82wVOzI2AfPDfRiZWGr6dP+NB2GGvc6vZxzncN1RqLv5FNoSwg32mTmCkpF16
	 c8WAJnhPVdi0pl4wlJelHPP15ovIMNkMP6tFY0Ev58nFjyJZb85NKWBj9VH4TkVJKd+RS
	 K2AaqXhO9fnTMgwTDd91D1zLfKjkAnZ2FgW3LALKRy3ndS53BC3lOD+UkbcWoCi86wW3c
	 7LcwheMgI6orkFVOfur7sGc68IxmvRLkiS4ptrygcoCeycy/isZb4Piqi6EufT5Bv6J91
	 jl0l5L6WUrq5NfYAl3nl7uLEH1Y0H+AHrnbUtRY/rBNd1x5vZdJ3cKbi232l/xeJu8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dnLp+SXf;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E4606A31D;
	Sun, 15 Nov 2026 14:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8E4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dnLp+SXf
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DFEC1516;
	Sun, 15 Nov 2026 06:39:41 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BAFDA3F85F;
	Sun, 15 Nov 2026 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794753584; bh=JAPamEnS0a1chQgUFkxhCVz/QqaVzoGJWTMnsu0MSow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnLp+SXfNe4kywfpAolf/jEON84hcyW8iFL+ACGxEpijlA0N0hB5cRN8/ArQfUW0Q
	 RalspDqSzsvjkb77Pr9FPhItI4XX8gA7mpwpvLNnqCOrwbroFM/mNG2MiosTgd1tmr
	 Bz03LvLUtHNkUsz0MTwEBeQvEbUI6lX/KgVT2tfA=
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
Subject: [PATCH v4 3/9] mm: move anon-exclusive batch helper to rmap.h
Date: Sun, 15 Nov 2026 14:38:58 +0000
Message-ID: <20261115143905.3045084-4-dev.jain@arm.com>
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

In preparation for optimizing large folio unmapping, we need to reuse
the page_anon_exclusive_batch helper in rmap.c and rmap.h and obey the
existing use in mprotect.c .

Therefore, move it from mprotect.c to rmap.h.

While at it, change return type, start_idx and max_len to unsigned long
type for future proofing against THP support at >= PUD level. Also
make the helper return the anon-exclusivity state via a pointer parameter.

Shorten 'expected_anon_exclusive' to exclusive for brevity.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/rmap.h | 18 ++++++++++++++++++
 mm/mprotect.c        | 25 ++++---------------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 74cca0e3c7264..43d6bbecd2fab 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -106,6 +106,24 @@ enum ttu_flags {
 
 #ifdef CONFIG_MMU
 
+/*
+ * Get max length of consecutive PTEs pointing to PageAnonExclusive() pages or
+ * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
+ * that the PTEs point to consecutive pages of the same anon large folio.
+ */
+static __always_inline unsigned long page_anon_exclusive_batch(unsigned long start_idx,
+		unsigned long max_len, struct page *first_page, bool *exclusive)
+{
+	unsigned long idx;
+
+	*exclusive = PageAnonExclusive(first_page + start_idx);
+	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
+		if (*exclusive != PageAnonExclusive(first_page + idx))
+			break;
+	}
+	return idx - start_idx;
+}
+
 void anon_vma_init(void);	/* create anon_vma_cachep */
 
 #ifdef CONFIG_MM_ID
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ef4e7188e24da..0048a2406ed34 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -30,6 +30,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/rmap.h>
 #include <uapi/linux/mman.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
@@ -138,23 +139,6 @@ static __always_inline void prot_commit_flush_ptes(struct vm_area_struct *vma,
 		tlb_flush_pte_range(tlb, addr, nr_ptes * PAGE_SIZE);
 }
 
-/*
- * Get max length of consecutive ptes pointing to PageAnonExclusive() pages or
- * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
- * that the ptes point to consecutive pages of the same anon large folio.
- */
-static __always_inline int page_anon_exclusive_batch(int start_idx, int max_len,
-		struct page *first_page, bool expected_anon_exclusive)
-{
-	int idx;
-
-	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
-		if (expected_anon_exclusive != PageAnonExclusive(first_page + idx))
-			break;
-	}
-	return idx - start_idx;
-}
-
 /*
  * This function is a result of trying our very best to retain the
  * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
@@ -173,16 +157,15 @@ static __always_inline void commit_anon_folio_batch(struct vm_area_struct *vma,
 		struct folio *folio, struct page *first_page, unsigned long addr, pte_t *ptep,
 		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
 {
-	bool expected_anon_exclusive;
+	bool exclusive;
 	int batch_idx = 0;
 	int len;
 
 	while (nr_ptes) {
-		expected_anon_exclusive = PageAnonExclusive(first_page + batch_idx);
 		len = page_anon_exclusive_batch(batch_idx, nr_ptes,
-					first_page, expected_anon_exclusive);
+					first_page, &exclusive);
 		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, len,
-				       batch_idx, expected_anon_exclusive, tlb);
+				       batch_idx, exclusive, tlb);
 		batch_idx += len;
 		nr_ptes -= len;
 	}
-- 
2.43.0

