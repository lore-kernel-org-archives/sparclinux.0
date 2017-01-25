From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 25 Jan 2017 19:57:14 +0000
Subject: [PATCH v5 2/4] mm: Add functions to support extra actions on swap in/out
Message-Id: <4706f9a6c626df850d1442f0051395d34ed0b448.1485362562.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1485362562.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1485362562.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de
Cc: Khalid Aziz <khalid.aziz@oracle.com>, kirill.shutemov@linux.intel.com, mhocko@suse.com, jmarchan@redhat.com, vbabka@suse.cz, dan.j.williams@intel.com, lstoakes@gmail.com, dave.hansen@linux.intel.com, hannes@cmpxchg.org, mgorman@suse.de, hughd@google.com, vdavydov.dev@gmail.com, minchan@kernel.org, namit@vmware.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

If a processor supports special metadata for a page, for example ADI
version tags on SPARC M7, this metadata must be saved when the page is
swapped out. The same metadata must be restored when the page is swapped
back in. This patch adds two new architecture specific functions -
arch_do_swap_page() to be called when a page is swapped in,
arch_unmap_one() to be called when a page is being unmapped for swap
out.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
v5:
	- Replaced set_swp_pte() function with new architecture
          functions arch_do_swap_page() and arch_unmap_one()

 include/asm-generic/pgtable.h | 16 ++++++++++++++++
 mm/memory.c                   |  1 +
 mm/rmap.c                     |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index c4f8fd2..cccc4e4 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -282,6 +282,22 @@ static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef __HAVE_ARCH_DO_SWAP_PAGE
+static inline void arch_do_swap_page(struct mm_struct *mm, unsigned long addr,
+				     pte_t pte, pte_t orig_pte)
+{
+
+}
+#endif
+
+#ifndef __HAVE_ARCH_UNMAP_ONE
+static inline void arch_unmap_one(struct mm_struct *mm, unsigned long addr,
+				  pte_t pte, pte_t orig_pte)
+{
+
+}
+#endif
+
 #ifndef __HAVE_ARCH_PGD_OFFSET_GATE
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index e18c57b..10abae2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2643,6 +2643,7 @@ int do_swap_page(struct fault_env *fe, pte_t orig_pte)
 	if (pte_swp_soft_dirty(orig_pte))
 		pte = pte_mksoft_dirty(pte);
 	set_pte_at(vma->vm_mm, fe->address, fe->pte, pte);
+	arch_do_swap_page(vma->vm_mm, fe->address, pte, orig_pte);
 	if (page = swapcache) {
 		do_page_add_anon_rmap(page, vma, fe->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true, false);
diff --git a/mm/rmap.c b/mm/rmap.c
index 1ef3640..940939d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1539,6 +1539,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		swp_pte = swp_entry_to_pte(entry);
 		if (pte_soft_dirty(pteval))
 			swp_pte = pte_swp_mksoft_dirty(swp_pte);
+		arch_unmap_one(mm, address, swp_pte, pteval);
 		set_pte_at(mm, address, pte, swp_pte);
 	} else if (PageAnon(page)) {
 		swp_entry_t entry = { .val = page_private(page) };
@@ -1572,6 +1573,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		swp_pte = swp_entry_to_pte(entry);
 		if (pte_soft_dirty(pteval))
 			swp_pte = pte_swp_mksoft_dirty(swp_pte);
+		arch_unmap_one(mm, address, swp_pte, pteval);
 		set_pte_at(mm, address, pte, swp_pte);
 	} else
 		dec_mm_counter(mm, mm_counter_file(page));
-- 
2.7.4

