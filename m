From: David Miller <davem@davemloft.net>
Date: Fri, 24 Oct 2014 16:59:54 +0000
Subject: [PATCH] sparc64: Implement __get_user_pages_fast().
Message-Id: <20141024.125954.2150763947929737619.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It is not sufficient to only implement get_user_pages_fast(), you
must also implement the atomic version __get_user_pages_fast()
otherwise you end up using the weak symbol fallback implementation
which simply returns zero.

This is dangerous, because it causes the futex code to loop forever
if transparent hugepages are supported (see get_futex_key()).

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I'll be pushing this to -stable too.

 arch/sparc/mm/gup.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index 1aed043..ae6ce38 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -160,6 +160,36 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	return 1;
 }
 
+int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			  struct page **pages)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, len, end;
+	unsigned long next, flags;
+	pgd_t *pgdp;
+	int nr = 0;
+
+	start &= PAGE_MASK;
+	addr = start;
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+
+	local_irq_save(flags);
+	pgdp = pgd_offset(mm, addr);
+	do {
+		pgd_t pgd = *pgdp;
+
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(pgd))
+			break;
+		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+			break;
+	} while (pgdp++, addr = next, addr != end);
+	local_irq_restore(flags);
+
+	return nr;
+}
+
 int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages)
 {
-- 
1.8.1.2

