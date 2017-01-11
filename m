From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 11 Jan 2017 16:12:52 +0000
Subject: [PATCH v4 2/4] mm: Add function to support extra actions on swap in/out
Message-Id: <c24c7a844c61d6f8d57dd3791ad7ab5f05305c6b.1483999591.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1483999591.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1483999591.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de
Cc: Khalid Aziz <khalid.aziz@oracle.com>, kirill.shutemov@linux.intel.com, mhocko@suse.com, jmarchan@redhat.com, vbabka@suse.cz, dan.j.williams@intel.com, lstoakes@gmail.com, dave.hansen@linux.intel.com, hannes@cmpxchg.org, mgorman@suse.de, hughd@google.com, vdavydov.dev@gmail.com, minchan@kernel.org, namit@vmware.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

If a processor supports special metadata for a page, for example ADI
version tags on SPARC M7, this metadata must be saved when the page is
swapped out. The same metadata must be restored when the page is swapped
back in. This patch adds a new function, set_swp_pte_at(), to set pte
upon a swap in/out of page that allows kernel to take special action
like saving and restoring version tags after or before setting a new pte
or saving a swap pte. For architectures that do not need to take special
action on page swap, this function defaults to set_pte_at().

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
 include/asm-generic/pgtable.h | 5 +++++
 mm/memory.c                   | 2 +-
 mm/rmap.c                     | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index c4f8fd2..5043e5a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -294,6 +294,11 @@ static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 # define pte_accessible(mm, pte)	((void)(pte), 1)
 #endif
 
+#ifndef set_swp_pte_at
+#define set_swp_pte_at(mm, addr, ptep, pte, oldpte)	\
+		set_pte_at(mm, addr, ptep, pte)
+#endif
+
 #ifndef flush_tlb_fix_spurious_fault
 #define flush_tlb_fix_spurious_fault(vma, address) flush_tlb_page(vma, address)
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index e18c57b..1cc3b55 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2642,7 +2642,7 @@ int do_swap_page(struct fault_env *fe, pte_t orig_pte)
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(orig_pte))
 		pte = pte_mksoft_dirty(pte);
-	set_pte_at(vma->vm_mm, fe->address, fe->pte, pte);
+	set_swp_pte_at(vma->vm_mm, fe->address, fe->pte, pte, orig_pte);
 	if (page = swapcache) {
 		do_page_add_anon_rmap(page, vma, fe->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true, false);
diff --git a/mm/rmap.c b/mm/rmap.c
index 1ef3640..d58cb94 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1539,7 +1539,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		swp_pte = swp_entry_to_pte(entry);
 		if (pte_soft_dirty(pteval))
 			swp_pte = pte_swp_mksoft_dirty(swp_pte);
-		set_pte_at(mm, address, pte, swp_pte);
+		set_swp_pte_at(mm, address, pte, swp_pte, pteval);
 	} else if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page_private(page) };
 		pte_t swp_pte;
@@ -1572,7 +1572,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		swp_pte = swp_entry_to_pte(entry);
 		if (pte_soft_dirty(pteval))
 			swp_pte = pte_swp_mksoft_dirty(swp_pte);
-		set_pte_at(mm, address, pte, swp_pte);
+		set_swp_pte_at(mm, address, pte, swp_pte, pteval);
 	} else
 		dec_mm_counter(mm, mm_counter_file(page));
 
-- 
2.7.4

