From: Christoph Hellwig <hch@lst.de>
Date: Sat, 01 Jun 2019 07:49:46 +0000
Subject: [PATCH 03/16] mm: simplify gup_fast_permitted
Message-Id: <20190601074959.14036-4-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de>
In-Reply-To: <20190601074959.14036-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

Pass in the already calculated end value instead of recomputing it, and
leave the end > start check in the callers instead of duplicating them
in the arch code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/include/asm/pgtable.h   |  8 +-------
 arch/x86/include/asm/pgtable_64.h |  8 +-------
 mm/gup.c                          | 17 +++++++----------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9f0195d5fa16..9b274fcaacb6 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1270,14 +1270,8 @@ static inline pte_t *pte_offset(pmd_t *pmd, unsigned long address)
 #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
 #define pte_unmap(pte) do { } while (0)
 
-static inline bool gup_fast_permitted(unsigned long start, int nr_pages)
+static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
 {
-	unsigned long len, end;
-
-	len = (unsigned long) nr_pages << PAGE_SHIFT;
-	end = start + len;
-	if (end < start)
-		return false;
 	return end <= current->mm->context.asce_limit;
 }
 #define gup_fast_permitted gup_fast_permitted
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 0bb566315621..4990d26dfc73 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -259,14 +259,8 @@ extern void init_extra_mapping_uc(unsigned long phys, unsigned long size);
 extern void init_extra_mapping_wb(unsigned long phys, unsigned long size);
 
 #define gup_fast_permitted gup_fast_permitted
-static inline bool gup_fast_permitted(unsigned long start, int nr_pages)
+static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
 {
-	unsigned long len, end;
-
-	len = (unsigned long)nr_pages << PAGE_SHIFT;
-	end = start + len;
-	if (end < start)
-		return false;
 	if (end >> __VIRTUAL_MASK_SHIFT)
 		return false;
 	return true;
diff --git a/mm/gup.c b/mm/gup.c
index 9775f7675653..e7566f5ff9cf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2122,13 +2122,9 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
  * Check if it's allowed to use __get_user_pages_fast() for the range, or
  * we need to fall back to the slow version:
  */
-bool gup_fast_permitted(unsigned long start, int nr_pages)
+static bool gup_fast_permitted(unsigned long start, unsigned long end)
 {
-	unsigned long len, end;
-
-	len = (unsigned long) nr_pages << PAGE_SHIFT;
-	end = start + len;
-	return end >= start;
+	return true;
 }
 #endif
 
@@ -2149,6 +2145,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
+	if (end < start)
+		return 0;
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return 0;
 
@@ -2164,7 +2162,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 * block IPIs that come from THPs splitting.
 	 */
 
-	if (gup_fast_permitted(start, nr_pages)) {
+	if (gup_fast_permitted(start, end)) {
 		local_irq_save(flags);
 		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
 		local_irq_restore(flags);
@@ -2223,13 +2221,12 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
-	if (nr_pages <= 0)
+	if (end < start)
 		return 0;
-
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
 
-	if (gup_fast_permitted(start, nr_pages)) {
+	if (gup_fast_permitted(start, end)) {
 		local_irq_disable();
 		gup_pgd_range(addr, end, gup_flags, pages, &nr);
 		local_irq_enable();
-- 
2.20.1
