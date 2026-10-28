Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182716;
	b=CZf+bJ5L2DtjCc6OyUPtVr1O7a+dqArXBGx3W3OpJ8GQbN+xxrxXSpes/X93aj9NXO/w
	 UlERKr8zk0LDW+ADMYnPwTga5pdECdk+E+g23ELIajLSnDoqd+G0xQgZPvL9ZFK5sl8iw
	 Fg+2p+aWFABoR78lqFuVSyPkJaIYUwCYA7G8X3Rk2laEKZ2aSnqWbOf0QZC7wxvQXtShy
	 iQMjuLd5wAmU6xzMXzn67hi+8STDc7Lu7bRdeLCzKrp8nClHcDSOsWnnH1d4DmX2hbJW6
	 JnuwLSWelzGhRecY5hZui+bIHkCFZJ3LdnqNTUDJ29Jmn0jTXfdxX9hpIdbYGzc4USg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182716;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mliajgUIsx7gJSmBdbK9pXM4vtTIJ/Nw3KYTTaS80N8=;
	b=rkhWu3Wuw2jMbd+rTh5vSIhNZMtppSZj5qIjCwxnBIZta/J4YvdErodwaRrkY2z8AxQF
	 cFgOpwhns+lSz76Fsp4FlpFNBt/5eJH2+G2CSSq5B1BBV2+j0sVNI1ikIfknELMjRLoYp
	 DS3YGPWjiQ+mmgjtAAjTZr5G7D0FQNpeBsEYgxXYr8l7GQNVxfWCNrBiHXQdGHApA1PQm
	 YjtDMSStPGpo8qv+DmyQqXCiZJ2MduE2bog8dVxgidm6PQ5Wlfmx2VQTNxstivRUbQM/B
	 oRnskGAnaOuS5JyTSfeODSDeBijcYM0tekTwHRFbiZ//eN+DAlgre8DR8QU7ngx0B9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7RXDx8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A41606A31A;
	Wed, 28 Oct 2026 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7RXDx8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3491F01825;
	Wed, 28 Oct 2026 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182715;
	bh=mliajgUIsx7gJSmBdbK9pXM4vtTIJ/Nw3KYTTaS80N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7RXDx8M93py2F/2sETg1IElhcHIMffsqzYYF3XlH6Hn1Jyqoq+nT25JkulYj1I3m
	 exLc++HQD7riM5jcQW0DPZmy+t/DF6i440Zu4hAqKNPEfjYHssaLYYnSJ3LTxgwnoA
	 73B26YWLUwUuW/FSjiM4m/nx4JIQb0gTuKT/qUTiPiuc2t257PYUFESdSm471EcfBM
	 p3eacu+5NKkXK8R1lF5JQyU0PdY9DKyzuP1T/2WFeWaElWItr+qylWe6QGRjPDw7dj
	 i6F6XB14Hz6y1Z+WcqrUZINZqH6kMQBun7ew8wv8fLGWhv//b8r+tISOBqLfW675uK
	 xj8AHUuLl0VtA==
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
Date: Wed, 28 Oct 2026 11:17:18 +0100
Message-ID: <20261028101719.11918-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org> <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org> <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org> <20261027212610.6798-1-kaloz@kernel.org> <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org> <20261028091631.8072-1-kaloz@kernel.org> <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org>
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

On 10/28/26 10:22, David Hildenbrand (Arm) wrote:
> Okay, so mremap() and reclaim memory performance concerns make you sleep bad at
> night? :)

Probably less than move_pte() kept you mm folks up at night ;)

> Don't get me wrong, I know that running new kernels on old HW is fun.
> Last week a got upstream Linux running on a 32bit x86 notebook from 2007 with
> the snap of a finger. Everything just works (using Alpine).

Nice, that's exactly the kind of thing I enjoy too.

> The biggest problem all of us with supporting old hardware is the maintanance
> cost. Not just core-mm, but also things like ad-hoc page table walkers you are
> adding we (from core-mm) might have to touch at some point.
>
> If there is no good reason for the complexity, out it goes.
>
> Because otherwise people will push more and more for removing legacy support
> completely, and that's not what you want, right?

Definitely not. Fair point, I was only looking at it from the sparc
side, and keeping these platforms cheap to carry matters more than a
few percent on reclaim. B it is, then; it's below the scissors, on top
of 1/4-3/4. Thanks for taking the time to go through this!

Andreas, if David is happy with it, would you take it in place of 4/4?


Best,
Imre

-- >8 --
Subject: [PATCH] sparc64: replace move_pte() with a D-cache flush in flush_cache_range()

mremap() can move a page to an address of the other D-cache color,
leaving lines of the old color in the virtually indexed D-cache of
Spitfire and Cheetah CPUs.  move_pte() flushed the page for each PTE
moved, which is only correct while move_ptes() handles one PTE at a
time.

Drop move_pte(), which no other architecture defines, and flush the
whole D-cache in flush_cache_range(), which mremap() calls on the old
range before moving the PTEs.  This keeps the fix in sparc64 without
a page table walk.

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
index d1f94b8d6312..d870cfadba21 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3115,6 +3115,24 @@ void flush_cache_vmap(unsigned long start, unsigned long end)
 #endif
 }
 
+/*
+ * mremap() moves the PTEs of [start, end) to addresses that may have the
+ * other color, and calls this on the old range first.  Flush the whole
+ * D-cache so no line of the old color outlives the move.
+ */
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+		       unsigned long end)
+{
+	/* flush_cache_mm() spills the user register windows. */
+	flush_cache_mm(vma->vm_mm);
+#ifdef DCACHE_ALIASING_POSSIBLE
+	/* The D-cache is virtually indexed on Spitfire and Cheetah. */
+	if (tlb_type == spitfire || tlb_type == cheetah ||
+	    tlb_type == cheetah_plus)
+		flush_dcache_all();
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
