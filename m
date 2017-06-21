From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 21 Jun 2017 01:05:55 +0000
Subject: [PATCH 2/4] sparc64: Support huge PUD case in get_user_pages
Message-Id: <1450b5655a5dcd9b9c326a24f359f4a0673fc5a8.1498005968.git.nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1498005968.git.nitin.m.gupta@oracle.com>
In-Reply-To: <cover.1498005968.git.nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Tom Hromatka <tom.hromatka@oracle.com>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Jan Kara <jack@suse.cz>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

get_user_pages() is used to do direct IO. It already
handles the case where the address range is backed
by PMD huge pages. This patch now adds the case where
the range could be backed by PUD huge pages.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/pgtable_64.h | 15 ++++++++++--
 arch/sparc/mm/gup.c                 | 47 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 2444b02..4fefe37 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -692,6 +692,8 @@ static inline unsigned long pmd_write(pmd_t pmd)
 	return pte_write(pte);
 }
 
+#define pud_write(pud)	pte_write(__pte(pud_val(pud)))
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline unsigned long pmd_dirty(pmd_t pmd)
 {
@@ -828,9 +830,18 @@ static inline unsigned long __pmd_page(pmd_t pmd)
 
 	return ((unsigned long) __va(pfn << PAGE_SHIFT));
 }
+
+static inline unsigned long pud_page_vaddr(pud_t pud)
+{
+	pte_t pte = __pte(pud_val(pud));
+	unsigned long pfn;
+
+	pfn = pte_pfn(pte);
+
+	return ((unsigned long) __va(pfn << PAGE_SHIFT));
+}
+
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
-#define pud_page_vaddr(pud)		\
-	((unsigned long) __va(pud_val(pud)))
 #define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)		(pud_val(pud) != 0U)
diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index cd0e32b..7cfa9c5 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -103,6 +103,47 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
 	return 1;
 }
 
+static int gup_huge_pud(pud_t *pudp, pud_t pud, unsigned long addr,
+			unsigned long end, int write, struct page **pages,
+			int *nr)
+{
+	struct page *head, *page;
+	int refs;
+
+	if (!(pud_val(pud) & _PAGE_VALID))
+		return 0;
+
+	if (write && !pud_write(pud))
+		return 0;
+
+	refs = 0;
+	head = pud_page(pud);
+	page = head + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (PageTail(head))
+		head = compound_head(head);
+	do {
+		VM_BUG_ON(compound_head(page) != head);
+		pages[*nr] = page;
+		(*nr)++;
+		page++;
+		refs++;
+	} while (addr += PAGE_SIZE, addr != end);
+
+	if (!page_cache_add_speculative(head, refs)) {
+		*nr -= refs;
+		return 0;
+	}
+
+	if (unlikely(pud_val(pud) != pud_val(*pudp))) {
+		*nr -= refs;
+		while (refs--)
+			put_page(head);
+		return 0;
+	}
+
+	return 1;
+}
+
 static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		int write, struct page **pages, int *nr)
 {
@@ -141,7 +182,11 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
 			return 0;
-		if (!gup_pmd_range(pud, addr, next, write, pages, nr))
+		if (unlikely(pud_large(pud))) {
+			if (!gup_huge_pud(pudp, pud, addr, next,
+					  write, pages, nr))
+				return 0;
+		} else if (!gup_pmd_range(pud, addr, next, write, pages, nr))
 			return 0;
 	} while (pudp++, addr = next, addr != end);
 
-- 
2.9.2

