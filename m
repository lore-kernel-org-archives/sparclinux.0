From: Christoph Hellwig <hch@lst.de>
Date: Sat, 25 May 2019 13:32:01 +0000
Subject: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
Message-Id: <20190525133203.25853-5-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de>
In-Reply-To: <20190525133203.25853-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

This will allow sparc64 to override its ADI tags for
get_user_pages and get_user_pages_fast.  I have no idea why this
is not required for plain old get_user_pages, but it keeps the
existing sparc64 behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f173fcbaf1b2..1c21ecfbf38b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2117,6 +2117,10 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 	} while (pgdp++, addr = next, addr != end);
 }
 
+#ifndef gup_fixup_start_addr
+#define gup_fixup_start_addr(start)	(start)
+#endif
+
 #ifndef gup_fast_permitted
 /*
  * Check if it's allowed to use __get_user_pages_fast() for the range, or
@@ -2145,7 +2149,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	unsigned long flags;
 	int nr = 0;
 
-	start &= PAGE_MASK;
+	start = gup_fixup_start_addr(start) & PAGE_MASK;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
@@ -2218,7 +2222,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	unsigned long addr, len, end;
 	int nr = 0, ret = 0;
 
-	start &= PAGE_MASK;
+	start = gup_fixup_start_addr(start) & PAGE_MASK;
 	addr = start;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
-- 
2.20.1
