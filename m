Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843F3BE14D;
	Thu, 11 Jun 2026 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178675; cv=none; b=KmIh6lsHotiUAzG1+bI2iOBW3bTQqbdcARTxPrhlCc++F1zZQwJVvvjfjREragCcZ6SR5aJ62mwkrc+RsNbGWhdMOg7vesWEcSUTRBJc3GJoJS8OX4Kj/c7F3xHPA3kYgqfkVYGpTtXbGYzAGN7UbiBFNwS9ttL68vSPbixGHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178675; c=relaxed/simple;
	bh=BDvHJeDfcf67syfOHGOdhEkLRXmekCM9Z5LErfg3lu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S73ZAdinhTkiJBWqUx7C6LxqxlQWl8sOEEsSbpn1T+aLA+jjSoC6G6gjP4V+47BbEtQMS7V2HY9nohddZgPvFRd20QXujRc3qrdJyqrX0SFj3/czZBvzyUwl4S7lL6FO833+QX9mjFTlbVM5zaVyAYJ/oHJgAvI9hea4FaOe+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqNu915E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqNu915E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8271F00893;
	Thu, 11 Jun 2026 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178672;
	bh=Cd6HE8o5qRluRnnVl/c2b6fi85KlAR03bwglw7I39Yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RqNu915EgPPafxbXg6CAenB9vC152Hg1JweYucDclKCQHRI3hwgNdfvTBXHr3FF1s
	 RHb1G33OPFNwf2trCId6SrER1UFYtYRrl6zeiu963tO4B7Tpz1/ycN3svbCiGu7GUB
	 UHlByfN85czSp6hFKrX1wFutee6czGd7WayLNFXE7tEHI2+F0LkSrDFPrIMyycjYyB
	 g/SA+o+EH6gimPQi2sqDW35LfHyUd0TlA2ljRVq5gbFNbo17ATBpeFZwJuKr3XbEXp
	 nOTyz9ysmOgmMhg99vCgyWiIWnM/Mk3M+rRBmqkCP7ickGBkyBHQKHnyqHKw84CA4p
	 QEd3X/zgqlmtA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 11 Jun 2026 13:50:49 +0200
Subject: [PATCH 3/3] mm: cleanup clear_not_present_full_ptes() and rename
 to clear_non_present_ptes()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-clear_not_present_full_ptes-v1-3-49865fc82629@kernel.org>
References: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
In-Reply-To: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

Let's clean it up a bit:

(1) There is no need to pass "full" anymore.

(2) No architecture overwrites it, and there isn't really a good reason
    to do so when dealing with non-resent PTEs.

(3) While at it, call it "non-present", similar to copy_nonpresent_pte()
    and zap_nonpresent_ptes().

It's a shame that we have clear_non_present_ptes() correspond to
pte_clear() and clear_ptes() correspond to ptep_get_and_clear*().

Likely we should rename pte_clear() to pte_clear_nonpresent() or sth.
like that, to make it clearer that it is usually the wrong interface
for dealing with present PTEs.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/pgtable.h | 14 ++++----------
 mm/madvise.c            |  2 +-
 mm/memory.c             |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cf328f4d1e12..a72c40708461 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -954,24 +954,19 @@ static inline void update_mmu_tlb(struct vm_area_struct *vma,
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
 	for (;;) {
 		pte_clear(mm, addr, ptep);
@@ -981,7 +976,6 @@ static inline void clear_not_present_full_ptes(struct mm_struct *mm,
 		addr += PAGE_SIZE;
 	}
 }
-#endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/mm/madvise.c b/mm/madvise.c
index f3cda54c1d6a..3db143c442ea 100644
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
index 56be920c56d7..d4b3540ae659 100644
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

