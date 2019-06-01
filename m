From: Christoph Hellwig <hch@lst.de>
Date: Sat, 01 Jun 2019 07:49:45 +0000
Subject: [PATCH 02/16] mm: use untagged_addr() for get_user_pages_fast addresses
Message-Id: <20190601074959.14036-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de>
In-Reply-To: <20190601074959.14036-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

This will allow sparc64 to override its ADI tags for
get_user_pages and get_user_pages_fast.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f173fcbaf1b2..9775f7675653 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2145,7 +2145,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	unsigned long flags;
 	int nr = 0;
 
-	start &= PAGE_MASK;
+	start = untagged_addr(start) & PAGE_MASK;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
@@ -2218,7 +2218,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	unsigned long addr, len, end;
 	int nr = 0, ret = 0;
 
-	start &= PAGE_MASK;
+	start = untagged_addr(start) & PAGE_MASK;
 	addr = start;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
-- 
2.20.1
