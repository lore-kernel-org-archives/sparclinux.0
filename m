Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625708;
	b=prAUn4wAEgxu//QzYm87uohsR03U+7Em1VJjUvjmx1WX2X9c0k/mqR1C1g3G16uicpGD
	 jnChCs7inmkGPJL5utwJHDHDDkdLvWqdBzyt0ad9hVqfoL/kWj65VSRrNaZqG78IX988g
	 0fDq/hKc8rlrsl1u/vdJkqcq7ISng2qnIwk4Grdnj0IR5KwwYPSscz7aLG9n+im1YfvEv
	 9rtBVHxCZxJBXNELkOYaC0THHbDwPWQFwd4TKwCq+RmbuKxLRDFj6yXdyc9JQf0evHiou
	 SitepykLLXQvBI5tY0ZAHyMi4wVtknihELLp0WQPnO2Bpg90RBj4G3/8vc8K+EZvatA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625708;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UiwpltmOBAEqC1E507in2t/reGPJ/SwkyjEVEuoAspA=;
	b=ihgo4R47LTsqsFdZ27eBMdWyKX2hzjcJ6SWjVKsk9Y6wFQZybPU6wzuD3FfPaSpVeqNc
	 kVbf0vysbBoEWzprQEtZM5/nIVEsTfv4PchCzsROWEQv9lrooOAvtBdT7mz8pZHoVKC8H
	 MaRZ6mvZcjuLx51EKLW7mfC59cZ8df2j6xRDRVUteHw1BMUTETmDggckoL/wHsRVR+QIU
	 bVyGtCXuOPRWXz2eJghAyTf367pTzpsLXUJ1qLsJxotr4DkJ99VPMs1wSqHnBKeF6eR0H
	 c3rDV3bcLV9N+Kw4hY3X/X3m9toaMhg9rGo0tHcoqqIBQUga6QN/aT1T5QjgZ3Yyi+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLU6OErr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27672606A319;
	Wed, 21 Oct 2026 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLU6OErr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295B81F000CD;
	Wed, 21 Oct 2026 23:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625707;
	bh=UiwpltmOBAEqC1E507in2t/reGPJ/SwkyjEVEuoAspA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HLU6OErrutYdmJLqV6sgxwlWNOzyDV0FO0p7+QzyIe4739dv8OYNKwqyytbiDjcLo
	 YtZGqB0nphuc4hbRrg58AW3vskzoE1XcdudEIIdh5Wx6J6CerqjAaOc2tnv9Qj1iar
	 P9GvZNk13xyhf6KOJzb7if6iBT/d0kBMKx5E9xi4k3Zr0ONap9uIQltEyE36vTFXNd
	 VneUbALFVd2ABpxmlOcbku6XmrKA+/MHN73hlFaSgsCpYbBQ1XeDmF2Xl8rRr2u4am
	 W0ilwPVMAnoAW2t4xmauaNUVyPv6Xhln7uJ1uXInPm9HzI8ThYLagzYzR1tTbgYzdP
	 BYfTPz2c9KpeQ==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
Date: Thu, 22 Oct 2026 01:33:40 +0200
Message-ID: <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792609488.git.kaloz@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org>
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

Since commit f822a9a81a31 ("mm: optimize mremap() by PTE batching"),
move_ptes() moves a batch of PTEs mapping consecutive pages of a folio
at a time, but calls move_pte() once per batch with the first PTE
only. sparc64, the only architecture that overrides move_pte(), flushes
from the D-cache the page that PTE maps when the move changes its
colour, so the other pages of a batch would keep lines of the old
colour. This cannot happen today only because sparc64 has no
pte_batch_hint(), and mremap_folio_pte_batch() then never batches.

Pass nr_ptes to move_pte(), as get_and_clear_ptes() takes it. The
generic version ignores it, and sparc64 flushes every page of the
batch.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/include/asm/pgtable_64.h | 16 +++++++++-------
 include/linux/pgtable.h             |  2 +-
 mm/mremap.c                         |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1430489b9ac5..9ca787b3cbfe 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -946,21 +946,23 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
 #ifdef DCACHE_ALIASING_POSSIBLE
-/* This flushes only the page the PTE maps, so it relies on move_ptes()
- * calling it for one PTE at a time, which the default pte_batch_hint()
- * guarantees.
+/* The nr PTEs map consecutive pages of one folio and all move by the
+ * same offset, so either every page of the batch aliases or none does.
  */
 #define __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, old_addr, new_addr)				\
+#define move_pte(pte, old_addr, new_addr, nr)				\
 ({									\
 	pte_t newpte = (pte);						\
 	if (tlb_type != hypervisor && pte_present(pte)) {		\
 		unsigned long this_pfn = pte_pfn(pte);			\
+		unsigned int i;						\
 									\
 		if (pfn_valid(this_pfn) &&				\
-		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
-			flush_dcache_page_all(current->mm,		\
-					      pfn_to_page(this_pfn));	\
+		    (((old_addr) ^ (new_addr)) & (1 << 13))) {		\
+			for (i = 0; i < (nr); i++)			\
+				flush_dcache_page_all(current->mm,	\
+					pfn_to_page(this_pfn + i));	\
+		}							\
 	}								\
 	newpte;								\
 })
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a..b58c0e98994e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1471,7 +1471,7 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #endif
 
 #ifndef __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, old_addr, new_addr)	(pte)
+#define move_pte(pte, old_addr, new_addr, nr)	(pte)
 #endif
 
 #ifndef pte_accessible
diff --git a/mm/mremap.c b/mm/mremap.c
index e8df5cdb0ac9..7fcae7f0082d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -289,7 +289,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 			force_flush = true;
 		}
 		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
-		pte = move_pte(pte, old_addr, new_addr);
+		pte = move_pte(pte, old_addr, new_addr, nr_ptes);
 		pte = move_soft_dirty_pte(pte);
 
 		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
-- 
2.47.3

