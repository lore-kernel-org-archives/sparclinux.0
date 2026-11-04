Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789660;
	b=5Yk6rFMS+mjZz/EChnxG1lJof+j/uXtbvP+ik3UJaJ0Y4a/kVDSsyDlubJCcc0iBSf8s
	 Z6V/ehZi023K7/JJSFu+uEklTaZa0AFLyUaJE5uLyCbVsryGSHU+B5a8MAEpmBOU9ya1m
	 npwipClI/YjfKJocXjJheErsu+I3Oq53Z3dhUINwrk/ff7fV2sZpZJcyhtVuv27rpynxU
	 SGe3v3GSjI9Ta35PhxuyIkMGQcDBSn5hUoHq55+moJDGNxtfCgywEFG5XjKZJPuvH7Dl1
	 7OHeGSw1t/ks26kYW594JCdNESk5OBXhdBIZ7YsOt/k3vxOCtrhZoOYOBSmYSOsDJtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q1WatbcgkUw8K3+oMM+B9PLqn14NjJO7D6DOhhw+67c=;
	b=p/ho5B4oO0J8ytVLuZeGRBxsN36VR0Cd+lFFe/Qvin1ZPNUt9zNzaLH04FY43RHTzm2u
	 xE0MOF+xPz75tVmgLBFizGqMpaObvpDq9NyOdii7V5hl6idH7ULC8nlFmSsLPIlGSpUim
	 /coXdDxkJypi5f3FsGdnPpKu9MaK/vqnNNJGvm+bEMEGOoeyfi/70URW7/3ta/LAJdZGG
	 MtHn4X8zr4gBAVvRsuPOEV4QTd2zvNNz32FFbDpjOh0qVlk0oJO27GNZuVdEtCHRpu4Hw
	 9f46tAA5FeB0oZPICHwal7izZLstv0DOa0BVaWO65y/5hINj1A/uBf+/B/OHmvnC90Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5JLGxhF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2A606A328;
	Wed,  4 Nov 2026 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5JLGxhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD2D1F000C1;
	Wed,  4 Nov 2026 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789659;
	bh=q1WatbcgkUw8K3+oMM+B9PLqn14NjJO7D6DOhhw+67c=;
	h=From:To:Cc:Subject:Date;
	b=E5JLGxhFshDJsH7jtdhBf7Q09tJ70fjxu/TJdoeOyy47tA+x92PQGVxmIWH013sTg
	 K4Tj+bJ87bdXAh2fC3PLPk1xYaMn/7EJ+0oP6HxdADwTV7ZVIM0teDQTVUomziuLkT
	 KjfJCP+Uq781fJA1IXxmPmG5Jx4SS54y8MB//p7fwdnomhKVQzc3AZYRIMH/URFBMv
	 vYocFAj8rj/qgko9XtavbvYgo3+5W/5IIv9luH4h35b8bwyEBl6Xz0YHMwj7ihIBMm
	 JR3ff4Gn7d0kaLjhL6uIwtlfnwYOQ6nHGJ0ulNiiJHg1Rwk7z+Mj9UILA4//67HSB7
	 nOJ1v1cI4pB0g==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] sparc64: replace move_pte() with a D-cache flush in flush_cache_range()
Date: Wed,  4 Nov 2026 11:52:58 +0100
Message-ID: <20261104105300.16260-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
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

mremap() can move a page to an address of the other D-cache color,
leaving lines of the old color in the virtually indexed D-cache of
Spitfire and Cheetah CPUs.  move_pte() flushed the page for each PTE
moved, which is only correct while move_ptes() handles one PTE at a
time.

Drop move_pte(), which no other architecture defines, and flush the
whole D-cache in flush_cache_range(), which mremap() calls on the old
range before moving the PTEs.  This keeps the fix in sparc64 without
a page table walk.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://lore.kernel.org/all/409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org/
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
Andreas asked for this as a separate patch once the merge window was
over [1]. It applies on top of sparc for-next.

[1] https://lore.kernel.org/all/4fba060e-c4f4-4d73-8efe-dbed0b5a7bc3@gaisler.com/

 arch/sparc/include/asm/cacheflush_64.h |  4 ++--
 arch/sparc/include/asm/pgtable_64.h    | 21 ---------------------
 arch/sparc/mm/init_64.c                | 18 ++++++++++++++++++
 include/linux/pgtable.h                |  4 ----
 mm/mremap.c                            |  1 -
 5 files changed, 20 insertions(+), 28 deletions(-)

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
index c26f2888aa18..310b66459521 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -935,27 +935,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
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
index 6a0ba9a01a21..a1ab1eacbf33 100644
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
index 780fe849ff8b..c729c3cc8bda 100644
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
index 0d06d7f37f19..87cb15027bfd 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -289,7 +289,6 @@ static int move_ptes(struct pagetable_move_control *pmc,
 			force_flush = true;
 		}
 		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
-		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 
 		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))

base-commit: c95443b98771a74c6689f5e7bbc56794fe95f550
-- 
2.47.3

