Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6047D477;
	Thu, 24 Sep 2026 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255510; cv=none; b=FMTkiLIaxK0SHFyVLyFlBAqWJMFF4agGb5N7sEq3NIkXLyv6KpzWpKJ0FnQOKldCisKYUXaVBpkoC/oJs+qdMpU61L3oL8ZPLTJBBHfVOU7waYtP9/RjE5+JUCzB2QJ9I8KyRZpf5T++Nw23lmTu0qJLKxpRcVz9DfFHK5YbVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255510; c=relaxed/simple;
	bh=t0y4o1rliThr4hhOhNaBbuyJQwol8ZLmJ5nvLciVyts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbHf2+3tH9pckk4zD6fhNahx946U5+nZoy/D9qsWQ0vB43S2tINVaND+NdAVhKXLhFE1iQ+zjlvUmFhbuCYRd6HVToaQXXAFFAlnYqqYXIXkeU3p7gLjFgJPY/ONzBBXmcBH1Iv+5V6kXX+ujK5sXQqOBhpcV/eznUr+rYT9GCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XWlR09P/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XWlR09P/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38E9B175D;
	Thu, 24 Sep 2026 06:11:44 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92ADC3F86F;
	Thu, 24 Sep 2026 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790255507; bh=t0y4o1rliThr4hhOhNaBbuyJQwol8ZLmJ5nvLciVyts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWlR09P/WJPRcS6Dm9gpe+RbtWMIfPap7pd5WOSclV/6JI/76RijBjK25b3/9uKqd
	 fTLOU5ZWceR9RaKhVrIRYgPg2Z4GkwSYS1zpwFKBMdP5WMLd9dpuwm5sR5qxxqp4gz
	 x06F0kOnPKOd/0/Qsdd9EwEk5xAb65psn5+oPEj0=
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
Subject: [PATCH v3 3/9] mm: move anon-exclusive batch helper to rmap.h
Date: Thu, 24 Sep 2026 13:09:31 +0000
Message-ID: <20260924131106.1730494-4-dev.jain@arm.com>
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

In preparation for optimizing large folio unmapping, we need to reuse
the page_anon_exclusive_batch helper in rmap.c and rmap.h and obey the
existing use in mprotect.c .

Therefore, move it from mprotect.c to rmap.h.

While at it, change return type, start_idx and max_len to unsigned long
type for future proofing against THP support at >= PUD level. Also
shorten expected_anon_exclusive -> anon_exclusive.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/rmap.h | 17 +++++++++++++++++
 mm/mprotect.c        | 18 +-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 74cca0e3c7264..62ef511a6175a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -106,6 +106,23 @@ enum ttu_flags {
 
 #ifdef CONFIG_MMU
 
+/*
+ * Get max length of consecutive PTEs pointing to PageAnonExclusive() pages or
+ * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
+ * that the PTEs point to consecutive pages of the same anon large folio.
+ */
+static __always_inline unsigned long page_anon_exclusive_batch(unsigned long start_idx,
+		unsigned long max_len, struct page *first_page, bool anon_exclusive)
+{
+	unsigned long idx;
+
+	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
+		if (anon_exclusive != PageAnonExclusive(first_page + idx))
+			break;
+	}
+	return idx - start_idx;
+}
+
 void anon_vma_init(void);	/* create anon_vma_cachep */
 
 #ifdef CONFIG_MM_ID
diff --git a/mm/mprotect.c b/mm/mprotect.c
index a1b6d29bf0390..cb996dbd0e525 100644
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
-- 
2.43.0

