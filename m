Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753569;
	b=TPxwfTUlsclckA6KSgMZiQYfbXJepsiqbjaNXdp5jTZTTUGipn3k8SijTQ1JdO3399lW
	 oEF36BtOD1H4oj5S8QZrx5TMikjB/1u85Z9TnNENNXVuMbLuYn8I/JtS/W4k8wjmJ12ok
	 cZ6u/3BHl/kb1N5UbB9OBFnWthGw0IZ6U9ut2FGv7wXDUQSapN4olVLmWwcMEx+h4v4fW
	 D9zDkx3pWDRL1biQ1KpkGRGk8YSoimfYPb1UKvaAnIEUxdIGCtmp52+Kh7NtPZ8JU9tNw
	 qGCqdqr/3zoc35z6kRxl6ZFVr5qdyPRerc+5wP7kACY0XHcY2uaupqRK7WvRFI/UU4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753569;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TskDAOAWXEo8flmJwWvmjXmj7YUn6WxOmJxYrefk24E=;
	b=cSuQyUN0t6tVbYomeDMmA3vah9KPhsVLbS9nOnu8ImWF4XYuZ+1cuEXed4u213HvdPtT
	 14ERU0Hu5KpclvdgZlORFxveIaTLVztYp61LIOOeKLF8pz2TjbAQRtZTcvV5589NtYI/t
	 q8Vqmdzrhmu8O31jtnjperAZ+UB4NMXPdabgOORe8k/+3yeNLiZIMYK34pKe0pBGL1lrr
	 PcGfVW7aRfOhhgkssZ7WzJ7LZ6saBxpBPw4gYTYQz7+AHBeUPk/px8dXq5S+1UndX76q2
	 rwYMMf5OAfDxwFt3NyZE6tGuBqjI8vnTI1y2daogXhSXIHXZ5Ilj/eTp1whyFtuy8dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dGY+3TkQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B05606A31D;
	Sun, 15 Nov 2026 14:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B05606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dGY+3TkQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88F71476;
	Sun, 15 Nov 2026 06:39:24 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1063F3F85F;
	Sun, 15 Nov 2026 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794753567; bh=IRV0Se7ac+aPU1wxdxXwDgPgVOJdcgTy6K/y0/wG5B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGY+3TkQ+VgGngptslyasnoZpm9Yj8NS4w09ek+LZL0mTIqzRaBpDUc5jGG1Ed2DJ
	 sK0OjKBZDEwa/YRcNoZGJYHYfM12KtRPersett9Qx4i6pCmZCotZU5wPk66mu+m+no
	 xl6d9kcEV3X3vFYAMzmNuk6f62viZZPOPADhEKpY=
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
Subject: [PATCH v4 1/9] mm/swapfile: add batched version of folio_dup_swap
Date: Sun, 15 Nov 2026 14:38:56 +0000
Message-ID: <20261115143905.3045084-2-dev.jain@arm.com>
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

Add folio_dup_swap_pages to handle a batch of consecutive pages. Note
that folio_dup_swap already can handle a subset of this: nr_pages == 1 and
nr_pages == folio_nr_pages(folio). Generalize this to any nr_pages.

Currently we have a not-so-nice logic of passing in subpage == NULL if
we mean to exercise the logic on the entire folio, and subpage != NULL if
we want to exercise the logic on only that subpage. Remove this
indirection: the caller invokes folio_dup_swap_pages() if it wants to
operate on a range of pages in the folio (i.e nr_pages may be anything
between 1 and folio_nr_pages()), and invokes folio_dup_swap() if it
wants to operate on the entire folio.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/rmap.c     |  2 +-
 mm/shmem.c    |  2 +-
 mm/swap.h     | 18 ++++++++++++++++--
 mm/swapfile.c | 18 ++++++++----------
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 0faef46806e5c..512a3a1c63c73 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2165,7 +2165,7 @@ static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
 	swp_entry_t entry = folio_page_swap_entry(folio, page);
 	struct mm_struct *mm = vma->vm_mm;
 
-	if (folio_dup_swap(folio, page) < 0)
+	if (folio_dup_swap_pages(folio, page, 1) < 0)
 		return false;
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 4686875a3adde..e3db6e45cae0c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1958,7 +1958,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
 		 */
 		shmem_disallow_eviction(info);
 
-		folio_dup_swap(folio, NULL);
+		folio_dup_swap(folio);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
 		BUG_ON(folio_mapped(folio));
diff --git a/mm/swap.h b/mm/swap.h
index d488a69c28091..cbcfd587aac1a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -245,7 +245,8 @@ extern int swap_retry_table_alloc(swp_entry_t entry, gfp_t gfp);
  * folio_put_swap(): does the opposite thing of folio_dup_swap().
  */
 int folio_alloc_swap(struct folio *folio);
-int folio_dup_swap(struct folio *folio, struct page *page);
+int folio_dup_swap_pages(struct folio *folio, struct page *page,
+		unsigned long nr_pages);
 void folio_put_swap(struct folio *folio, struct page *page);
 
 /* For internal use */
@@ -387,7 +388,8 @@ static inline int folio_alloc_swap(struct folio *folio)
 	return -EINVAL;
 }
 
-static inline int folio_dup_swap(struct folio *folio, struct page *page)
+static inline int folio_dup_swap_pages(struct folio *folio, struct page *page,
+		unsigned long nr_pages)
 {
 	return -EINVAL;
 }
@@ -489,6 +491,18 @@ static inline void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 }
 #endif /* CONFIG_SWAP */
 
+/**
+ * folio_dup_swap() - Increase swap count of all swap entries of a folio.
+ * @folio: folio with swap entries bound.
+ *
+ * See folio_dup_swap_pages() for more information.
+ */
+static inline int folio_dup_swap(struct folio *folio)
+{
+	return folio_dup_swap_pages(folio, folio_page(folio, 0),
+				    folio_nr_pages(folio));
+}
+
 static inline bool swap_cache_folio_mappable(struct folio *folio,
 		unsigned int nr_pages)
 {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index fcda5eba17140..d46cb1cf6469d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1860,9 +1860,10 @@ int folio_alloc_swap(struct folio *folio)
 }
 
 /**
- * folio_dup_swap() - Increase swap count of swap entries of a folio.
+ * folio_dup_swap_pages() - Increase swap count of swap entries of a folio.
  * @folio: folio with swap entries bounded.
- * @page: if not NULL, only increase the swap count of this page.
+ * @page: the first page in the folio to increase the swap count for.
+ * @nr_pages: the number of pages in the folio to increase the swap count for.
  *
  * Typically called when the folio is unmapped and have its swap entry to
  * take its place: Swap entries allocated to a folio has count == 0 and pinned
@@ -1876,18 +1877,15 @@ int folio_alloc_swap(struct folio *folio)
  * swap_put_entries_direct on its swap entry before this helper returns, or
  * the swap count may underflow.
  */
-int folio_dup_swap(struct folio *folio, struct page *page)
+int folio_dup_swap_pages(struct folio *folio, struct page *page,
+		unsigned long nr_pages)
 {
-	swp_entry_t entry = folio->swap;
-	unsigned long nr_pages = folio_nr_pages(folio);
+	swp_entry_t entry = folio_page_swap_entry(folio, page);
+	unsigned long idx = folio_page_idx(folio, page);
 
 	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_swapcache(folio), folio);
-
-	if (page) {
-		entry = folio_page_swap_entry(folio, page);
-		nr_pages = 1;
-	}
+	VM_WARN_ON_FOLIO(idx + nr_pages > folio_nr_pages(folio), folio);
 
 	return swap_dup_entries_cluster(swap_entry_to_info(entry),
 					swp_offset(entry), nr_pages);
-- 
2.43.0

