Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACC33D6E3;
	Mon, 29 Jun 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741020; cv=none; b=dN04Zuac3xyWQZIsmnTi8iCuQmNqd1WsoPe3qskW99H1G7ZSAocUDroTsWHuZ1gGoGrnkUUjzbyfmrQrjVi5x2ZnXW9KqrcLqi2spMAfhRKHwha1GFXKg6KVJ3kyPRQfELMMutiuO7YVTT1OEhRXDp4yPH+G1u2F+GackIMgLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741020; c=relaxed/simple;
	bh=DxFekZo6vKtzDvPHOBN15+t64n5liLDf79EdU8P6QuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNInTWx1mmYXZvefjnKcdXIvRK7kPArdtVRYNypDwct8GkYWab+d4/CIShrf1xn9U2rQpsp91GihY6Ga0sI5O4lrOLreCqNZ+8Elu/HLNFq1NjPobfzXx90SymhYp82C2rvp9IA41H0SFeq6/2o1tEmj2R/ZwG6qJMMP98EeGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4ySneqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4ySneqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1ED1F00AC4;
	Mon, 29 Jun 2026 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782741018;
	bh=V+Zb5D1Rf+1FzByFCFmRO2vzNlcbsbvoAC0fHg7BI28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l4ySneqfVaUVEMCfMQEsv/syXXvFDUFyU/OEbQPG7GK23ps2xOHHI5/ByjuxKSUwA
	 37nhEhRNCLpGd9Qb8QBNzWQF9TCmTTl+rqj9FbvOXe1uH9RwwKk2PGQVRxGc2bO80W
	 wKoxJDlXstQOsa2LBFZQKGN5krmHA6H8yIrDGCcPA2XNoHIP3jWQsED2ls3PFiiJQ7
	 T6tJ0jpD3wP2eok5IoXzcuZfv6yJ9M54LjZy52CDdjpJjDoUTMxOjmQRBGoawQvrIN
	 ckNxvrizn95vak8z4ZZ8cev0bN0K2dtVv47X1gK7k7pEuqT11sbbA7sEuamvgr9p0r
	 +OgpqP9fI1VpQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 29 Jun 2026 15:49:49 +0200
Subject: [PATCH v2 3/3] mm: cleanup clear_not_present_full_ptes() and
 rename to clear_non_present_ptes()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-clear_not_present_full_ptes-v2-3-96089871a1e7@kernel.org>
References: <20260629-clear_not_present_full_ptes-v2-0-96089871a1e7@kernel.org>
In-Reply-To: <20260629-clear_not_present_full_ptes-v2-0-96089871a1e7@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Oscar Salvador (SUSE)" <osalvador@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.15.2

Let's clean it up a bit:

(1) There is no need to pass "full" anymore.

(2) No architecture overwrites it, and there isn't really a good reason
    to do so when dealing with non-resent PTEs.

(3) While at it, call it "non-present", similar to copy_nonpresent_pte()
    and zap_nonpresent_ptes().

It's a shame that we have clear_non_present_ptes() correspond to
pte_clear() and clear_ptes() correspond to ptep_get_and_clear*().

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/pgtable.h | 14 ++++----------
 mm/madvise.c            |  2 +-
 mm/memory.c             |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0b81e396816a5..d52d2a976e5a2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -988,24 +988,19 @@ static inline void update_mmu_tlb(struct vm_area_struct *vma,
 	update_mmu_tlb_range(vma, address, ptep, 1);
 }
 
-#ifndef clear_not_present_full_ptes
 /**
- * clear_not_present_full_ptes - Clear multiple not present PTEs which are
- *				 consecutive in the pgtable.
+ * clear_nonpresent_ptes - Clear multiple non-present PTEs which are
+ *			    consecutive in the pgtable.
  * @mm: Address space the ptes represent.
  * @addr: Address of the first pte.
  * @ptep: Page table pointer for the first entry.
  * @nr: Number of entries to clear.
- * @full: Whether we are clearing a full mm.
- *
- * May be overridden by the architecture; otherwise, implemented as a simple
- * loop over pte_clear().
  *
  * Context: The caller holds the page table lock.  The PTEs are all not present.
  * The PTEs are all in the same PMD.
  */
-static inline void clear_not_present_full_ptes(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
+static inline void clear_nonpresent_ptes(struct mm_struct *mm,
+		unsigned long addr, pte_t *ptep, unsigned int nr)
 {
 	(void)addr;
 
@@ -1017,7 +1012,6 @@ static inline void clear_not_present_full_ptes(struct mm_struct *mm,
 		addr += PAGE_SIZE;
 	}
 }
-#endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/mm/madvise.c b/mm/madvise.c
index f3cda54c1d6a0..3db143c442eaa 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -695,7 +695,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				nr = swap_pte_batch(pte, max_nr, ptent);
 				nr_swap -= nr;
 				swap_put_entries_direct(entry, nr);
-				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
+				clear_nonpresent_ptes(mm, addr, pte, nr);
 			} else if (softleaf_is_hwpoison(entry) ||
 				   softleaf_is_poison_marker(entry)) {
 				pte_clear(mm, addr, pte);
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe923..a3fcaf8cfe8f8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1797,7 +1797,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
 		WARN_ON_ONCE(1);
 	}
-	clear_not_present_full_ptes(vma->vm_mm, addr, pte, nr, tlb->fullmm);
+	clear_nonpresent_ptes(vma->vm_mm, addr, pte, nr);
 	*any_skipped = zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
 
 	return nr;

-- 
2.43.0

