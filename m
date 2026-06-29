Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1B282F13;
	Mon, 29 Jun 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741016; cv=none; b=N68PgRakLOrzpFuA+5oqFEJCkdZ6VsTOxwpMqprHG+e9jfD54YoDWDw5LMoHMEzvN3d+Y4nZzLoWHDs8KZ/tQXZyNu6A6ECFrbY3ShEp+g/3boO363YkbOzpuLYJ4d4solMPq+9HKmz5cGn62MrR0SygvvjQBNVjP3gvElW5r0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741016; c=relaxed/simple;
	bh=mDyQw5v6fV2weclpJ2vlqpMGqEnvnOXO264zwWvP5QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNXth3+N+gY4uDDv5GRI1eS8vxV/kriQjenNXrrn7OuveJVuA294tmnhe3PkJmI9UdIob0LGTJ291KFmlEerTau0bWM7yePClJr8y15+Pu1P+UUBrtBAUsfuQlV/VQ1aTgaFeGsGk2PLO7fvTAKlXl9YF4FSujm2wYUYpUh0sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I92ZRMJq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I92ZRMJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1081F000E9;
	Mon, 29 Jun 2026 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782741015;
	bh=i+cZJIOp09dMSw4V2hsqNnLUK/axMUzonrG0MkHxYeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I92ZRMJq75nS6kILiQ6AXqA5GQi202584CnxxXxbFLXGHNUII+jNHHw5FDjnnw4iX
	 yvpiEruTNJWYheMFIpugiQB+jVZPhkbd55yq0UDZYTIhKiEXIzhUgNKVtgJCpVmIqV
	 xd51dzwLl+suxX/2q6Yz8H0vgV9DQDdsMFNHr2NyqzrCZm14q90n8iWGbOvBwnMKtA
	 VA7O9x0iUqRMRNEAvAs2Kc0JrdZ1KL4aCt8X6GBS9YMThQe8nm/RFbl92zqATCUCtk
	 glQT6NuDyA6B++0fXFdaNIaEo16d3RW6ZPsbb0MUwT5mqdGqqYg42QCyTXmjFidUhK
	 NmNq4Bj5LWtyg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 29 Jun 2026 15:49:48 +0200
Subject: [PATCH v2 2/3] mm: drop pte_clear_not_present_full()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-clear_not_present_full_ptes-v2-2-96089871a1e7@kernel.org>
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

In general, there is no good reason to do anything special when clearing
non-present PTEs.

In theory, HW that does have to invalidate TLBs for non-present PTEs could
benefit from a "full" parameter, but fortunately
pte_clear_not_present_full() is not wired up anymore ... and there would
have to be something very convincing for us to care about that to re-add
it.

So, let's just use pte_clear() directly now. To avoid the compiler
complaining on some configs about unused "addr" parameter, silence that
here.

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/pgtable.h | 21 ++++-----------------
 mm/madvise.c            |  4 ++--
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index dc804296d78f7..0b81e396816a5 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -988,21 +988,6 @@ static inline void update_mmu_tlb(struct vm_area_struct *vma,
 	update_mmu_tlb_range(vma, address, ptep, 1);
 }
 
-/*
- * Some architectures may be able to avoid expensive synchronization
- * primitives when modifications are made to PTE's which are already
- * not present, or in the process of an address space destruction.
- */
-#ifndef __HAVE_ARCH_PTE_CLEAR_NOT_PRESENT_FULL
-static inline void pte_clear_not_present_full(struct mm_struct *mm,
-					      unsigned long address,
-					      pte_t *ptep,
-					      int full)
-{
-	pte_clear(mm, address, ptep);
-}
-#endif
-
 #ifndef clear_not_present_full_ptes
 /**
  * clear_not_present_full_ptes - Clear multiple not present PTEs which are
@@ -1014,7 +999,7 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
  * @full: Whether we are clearing a full mm.
  *
  * May be overridden by the architecture; otherwise, implemented as a simple
- * loop over pte_clear_not_present_full().
+ * loop over pte_clear().
  *
  * Context: The caller holds the page table lock.  The PTEs are all not present.
  * The PTEs are all in the same PMD.
@@ -1022,8 +1007,10 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
 static inline void clear_not_present_full_ptes(struct mm_struct *mm,
 		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
 {
+	(void)addr;
+
 	for (;;) {
-		pte_clear_not_present_full(mm, addr, ptep, full);
+		pte_clear(mm, addr, ptep);
 		if (--nr == 0)
 			break;
 		ptep++;
diff --git a/mm/madvise.c b/mm/madvise.c
index cd9bb077072cc..f3cda54c1d6a0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -698,7 +698,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
 			} else if (softleaf_is_hwpoison(entry) ||
 				   softleaf_is_poison_marker(entry)) {
-				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+				pte_clear(mm, addr, pte);
 			}
 			continue;
 		}
@@ -1234,7 +1234,7 @@ static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
 
 	if (is_guard_pte_marker(ptent)) {
 		/* Simply clear the PTE marker. */
-		pte_clear_not_present_full(walk->mm, addr, pte, false);
+		pte_clear(walk->mm, addr, pte);
 		update_mmu_cache(walk->vma, addr, pte);
 	}
 

-- 
2.43.0

