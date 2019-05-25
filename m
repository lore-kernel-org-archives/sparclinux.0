From: Christoph Hellwig <hch@lst.de>
Date: Sat, 25 May 2019 13:32:03 +0000
Subject: [PATCH 6/6] mm: don't allow non-generic get_user_pages_fast implementations
Message-Id: <20190525133203.25853-7-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de>
In-Reply-To: <20190525133203.25853-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

Add an explicit ifdef instead of the weak functions for the stubs
so that we can't let new get_user_pages_fast implementation slip in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/util.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 91682a2090ee..74ae737ffd95 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -300,6 +300,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 }
 #endif
 
+#ifndef CONFIG_HAVE_GENERIC_GUP
 /*
  * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
  * back to the regular GUP.
@@ -308,8 +309,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
  * If the architecture does not support this function, simply return with no
  * pages pinned.
  */
-int __weak __get_user_pages_fast(unsigned long start,
-				 int nr_pages, int write, struct page **pages)
+int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
+		struct page **pages)
 {
 	return 0;
 }
@@ -339,13 +340,13 @@ EXPORT_SYMBOL_GPL(__get_user_pages_fast);
  * requested. If nr_pages is 0 or negative, returns 0. If no pages
  * were pinned, returns -errno.
  */
-int __weak get_user_pages_fast(unsigned long start,
-				int nr_pages, unsigned int gup_flags,
-				struct page **pages)
+int get_user_pages_fast(unsigned long start, int nr_pages,
+		unsigned int gup_flags, struct page **pages)
 {
 	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_fast);
+#endif /* !CONFIG_HAVE_GENERIC_GUP */
 
 unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
-- 
2.20.1
