Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136446;
	b=0v1VnSLChmCCTWsB64q+tbSNw0xwLaY7GKmWVwofi9chM+bZ4MX1Kr1tXBU7Qm1rW18P
	 kOMzsy1UyQ+j19h+t06gM7pa9ApqZPkfHjTPDK3T0KAMz73m0mQEiYBirOse6vbP4t53c
	 lsKIUPh/4cEduRHcgND5cjtaeJf8hQlWBvvcnHC/L6yQlIqUSKGlObT7ytyGR8HDhSiE9
	 iAIcMgwDmqd0EL14UAXvR04psKbsmmOMRue/aFOSioMtsg4E+n2rKuo9DjURPecXpHNyB
	 9r4NW5cFhFTa4C+xzGxpnvP7/1xx5x3siiJ8yxCe0sy9mJ0KEiZNCEzJfSna06VVf4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136446;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aIdGfGk78bfglsNu6zDlyEATBzGyUL+pcizfgre/lSI=;
	b=ptszBpOyvq8blw2Rebf7dh1fMu0YSXIe5/C0WT2P3C6VtO04SYZt7FYRYrRUtxy5LMnF
	 2lWpa9dVuKAEy8pEH/e5ArA7uWQkf7oJV28vxKfVwOgQrhbLDPhJNvEvF8l0lhxjMxndk
	 EEwK73PFT6gMLgd3fFK3sHOVg1yVU6yMJWN6lHpBX1y8rqsQOkgTV5AZKJqH5O+ya+gwZ
	 Z25oR7+fTsWH+VPHXDAclHtPVJnk/VNkEqa2s/YmuddmIKkp8DJQHU7+cKGeEcvQ1BhfG
	 P6cwqUARveUdlm9eaIUxS5B0NQhOCPm4etNiMUMpVZ2YdYVvaWQHwEBp5n+UXWyrvwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRpHIkQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCBC606A31D;
	Tue, 27 Oct 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRpHIkQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB8E1F01825;
	Tue, 27 Oct 2026 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136446;
	bh=aIdGfGk78bfglsNu6zDlyEATBzGyUL+pcizfgre/lSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lRpHIkQWFRNurrVhjsPgALh9t20hxZewaZXFTrnBbqVoCqxvjkoa5UPVFhAluTcfd
	 AKrBFLD6WP9DDQbdMINiBRijGcZ6k8IGjAcLgsfuT4Wdhk7Flg7ZmB3bt1HQ5d65fL
	 ribps1QIl8kOIo+QU9VPKS/TUHVRP5bvOZKCmSgK34ElIJ25n9PxAnpcM+ed/DpXxg
	 wTJ9dwOFGp6+vsdTTm3LNFhSrdSQKItJnvVEoLa+4nXRd70m6IQXPjBF5SyoFKlCKq
	 XsL9dbp3wYyM7MPj7uOzvfB8wHBJiFdzw2B18pVKxBLn7NfJSHpAv0MH1QXZ6InclV
	 x8rkMO3GPeHzQ==
From: Imre Kaloz <kaloz@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
Date: Tue, 27 Oct 2026 22:26:09 +0100
Message-ID: <20261027212610.6798-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org> <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org> <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
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

Hi David,

On 10/23/26 22:53, David Hildenbrand (Arm) wrote:
> Is there some way we can avoid this
> helper-that-shouldn't-exist-but-someone-hacked-it-in entirely?
> If it makes sparc64 slightly slower #dontcare.

I tried three ways of doing that on an Ultra 45 (UltraSPARC IIIi, two
CPUs), all with move_pte() removed entirely:

 A) sparc64's flush_cache_range() flushes every present page in the
    range from the D-cache;
 B) sparc64's flush_cache_range() flushes the whole D-cache;
 C) A for ranges of up to 10 pages, B above that.

All three pass a test that moves pages between cache colors with
mremap() and checks for stale data. With no flush at all the same test
finds about 15 million stale words per run, so it does catch the
problem.

Medians of 20 runs over two boots per kernel, against this series'
move_pte() as the baseline:

                            move_pte()        A          B          C
  apt-cache gencaches           6.63 s     +0.2%      +0.3%      +0.1%
  fork+exec                                +0.7%      +3.1%      -0.6%
  mremap 8K, same color          14 us      20 us      43 us      20 us
  mremap 8K, other color         21 us      20 us      43 us      20 us
  mremap 1M, same color          30 us     524 us      60 us      59 us
  mremap 8M, same color         209 us    4152 us     229 us     227 us
  mremap 8M, other color       4176 us    4166 us     236 us     233 us
  mremap 8M THP, same color      14 us    3933 us      43 us      42 us

flush_cache_range() has more callers than mremap(), mostly in rmap,
so I also timed reclaim, migration and writeback (medians of 5):

                                  A          B          C
  MADV_PAGEOUT to swap          +0.4%     +12.9%      -1.3%
  reclaim under memory.max      +1.9%     +17.7%      +2.0%
  msync of shared file mappings -4.4%      -3.4%      -0.4%
  compaction, move_pages()      within 3% for all three

So A pays on large moves, B on reclaim, and C on neither: it costs
the same as A on small ranges and the same as B on large ones. I'd go
with C. It would only flush on Spitfire and Cheetah, which have the
aliasing D-cache, so sun4v and the SPARC64 VII in Magnus's M3000
series skip it.

If that works for you, I'd suggest dropping 4/4 and using C as its
replacement; it's below the scissors, on top of 1/4-3/4.

Pedro, that would also settle the naming and the nr question, since
move_pte() goes away.


Best,
Imre

-- >8 --
Subject: [PATCH] sparc64: replace move_pte() with a flush in flush_cache_range()

mremap() can move a page to an address of the other D-cache color,
leaving lines of the old color in the virtually indexed D-cache of
Spitfire and Cheetah.  move_pte() flushed the page for each PTE moved,
which is only correct while move_ptes() handles one PTE at a time.

Drop move_pte(), which no other architecture defines, and flush the
old range in flush_cache_range(), which mremap() calls before moving
the PTEs.  Flush each mapped page, or the whole D-cache for a range of
more than ten pages, where one whole-cache flush costs about as much
as ten page flushes.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index 54a2d37008e6..1a116b288816 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -21,8 +21,8 @@ void __flushw_user(void);
 #define flush_cache_mm(__mm) \
 	do { if ((__mm) == current->mm) flushw_user(); } while(0)
 #define flush_cache_dup_mm(mm) flush_cache_mm(mm)
-#define flush_cache_range(vma, start, end) \
-	flush_cache_mm((vma)->vm_mm)
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+		       unsigned long end);
 #define flush_cache_page(vma, page, pfn) \
 	flush_cache_mm((vma)->vm_mm)
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1430489b9ac5..2452d959aac1 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -945,27 +945,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
-#ifdef DCACHE_ALIASING_POSSIBLE
-/* This flushes only the page the PTE maps, so it relies on move_ptes()
- * calling it for one PTE at a time, which the default pte_batch_hint()
- * guarantees.
- */
-#define __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, old_addr, new_addr)				\
-({									\
-	pte_t newpte = (pte);						\
-	if (tlb_type != hypervisor && pte_present(pte)) {		\
-		unsigned long this_pfn = pte_pfn(pte);			\
-									\
-		if (pfn_valid(this_pfn) &&				\
-		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
-			flush_dcache_page_all(current->mm,		\
-					      pfn_to_page(this_pfn));	\
-	}								\
-	newpte;								\
-})
-#endif
-
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 void paging_init(void);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index d1f94b8d6312..466a4aa1be60 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3115,6 +3115,95 @@ void flush_cache_vmap(unsigned long start, unsigned long end)
 #endif
 }
 
+static void flush_dcache_pfns(struct mm_struct *mm, unsigned long pfn,
+			      unsigned long nr)
+{
+	for (; nr; nr--, pfn++)
+		if (pfn_valid(pfn))
+			flush_dcache_page_all(mm, pfn_to_page(pfn));
+}
+
+/* A whole-cache flush costs about as much as this many page flushes. */
+#define FLUSH_CACHE_RANGE_ALL_PAGES	10
+
+/*
+ * mremap() moves the PTEs of [start, end) to addresses that may have the
+ * other color, and calls this on the old range first.  Flush every page
+ * mapped in the range from the D-cache, so no line of the old color
+ * outlives the move; a larger range is flushed whole without a walk.
+ * The walk takes no page table lock: mremap() holds the mmap_lock for
+ * writing, and other callers at worst miss a PTE that changes under it.
+ */
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+		       unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long addr, next;
+
+	/* flush_cache_mm() spills the user register windows. */
+	flush_cache_mm(mm);
+#ifdef DCACHE_ALIASING_POSSIBLE
+	/* The D-cache is virtually indexed on Spitfire and Cheetah. */
+	if (tlb_type != spitfire && tlb_type != cheetah &&
+	    tlb_type != cheetah_plus)
+		return;
+
+	if (((end - start) >> PAGE_SHIFT) > FLUSH_CACHE_RANGE_ALL_PAGES) {
+		flush_dcache_all();
+		return;
+	}
+
+	for (addr = start; addr < end; addr = next) {
+		pgd_t *pgd = pgd_offset(mm, addr);
+		p4d_t *p4d;
+		pud_t *pud, pudval;
+		pmd_t *pmd, pmdval;
+		pte_t *start_pte, *ptep, pte;
+
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(pgdp_get(pgd)))
+			continue;
+		p4d = p4d_offset(pgd, addr);
+		next = p4d_addr_end(addr, end);
+		if (p4d_none(p4dp_get(p4d)))
+			continue;
+		pud = pud_offset(p4d, addr);
+		pudval = pudp_get(pud);
+		next = pud_addr_end(addr, end);
+		if (pud_none(pudval))
+			continue;
+		if (pud_leaf(pudval)) {
+			if (pte_present(__pte(pud_val(pudval))))
+				flush_dcache_pfns(mm, pud_pfn(pudval) +
+						  ((addr & ~PUD_MASK) >> PAGE_SHIFT),
+						  (next - addr) >> PAGE_SHIFT);
+			continue;
+		}
+		pmd = pmd_offset(pud, addr);
+		pmdval = pmdp_get_lockless(pmd);
+		next = pmd_addr_end(addr, end);
+		if (pmd_none(pmdval))
+			continue;
+		if (pmd_leaf(pmdval)) {
+			if (pte_present(__pte(pmd_val(pmdval))))
+				flush_dcache_pfns(mm, pmd_pfn(pmdval) +
+						  ((addr & ~PMD_MASK) >> PAGE_SHIFT),
+						  (next - addr) >> PAGE_SHIFT);
+			continue;
+		}
+		start_pte = pte_offset_map(pmd, addr);
+		if (!start_pte)
+			continue;
+		for (ptep = start_pte; addr < next; addr += PAGE_SIZE, ptep++) {
+			pte = ptep_get(ptep);
+			if (pte_present(pte))
+				flush_dcache_pfns(mm, pte_pfn(pte), 1);
+		}
+		pte_unmap(start_pte);
+	}
+#endif
+}
+
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	if (start < HI_OBP_ADDRESS && end > LOW_OBP_ADDRESS) {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a..b95eea612261 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1470,10 +1470,6 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 }
 #endif
 
-#ifndef __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, old_addr, new_addr)	(pte)
-#endif
-
 #ifndef pte_accessible
 # define pte_accessible(mm, pte)	((void)(pte), 1)
 #endif
diff --git a/mm/mremap.c b/mm/mremap.c
index e8df5cdb0ac9..2257e3010f41 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -289,7 +289,6 @@ static int move_ptes(struct pagetable_move_control *pmc,
 			force_flush = true;
 		}
 		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
-		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 
 		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
