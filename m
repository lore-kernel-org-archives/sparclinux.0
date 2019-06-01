From: Christoph Hellwig <hch@lst.de>
Date: Sat, 01 Jun 2019 07:49:58 +0000
Subject: [PATCH 15/16] mm: switch gup_hugepte to use try_get_compound_head
Message-Id: <20190601074959.14036-16-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190601074959.14036-1-hch@lst.de>
In-Reply-To: <20190601074959.14036-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

This applies the overflow fixes from 8fde12ca79aff
("mm: prevent get_user_pages() from overflowing page refcount")
to the powerpc hugepd code and brings it back in sync with the
other GUP cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index e03c7e6b1422..6090044227f1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2006,7 +2006,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	if (!page_cache_add_speculative(head, refs)) {
+	head = try_get_compound_head(head, refs);
+	if (!head) {
 		*nr -= refs;
 		return 0;
 	}
-- 
2.20.1
