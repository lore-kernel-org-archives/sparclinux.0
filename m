From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 14:37:15 +0000
Subject: [PATCH 16/16] mm: mark the page referenced in gup_hugepte
Message-Id: <20190625143715.1689-17-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de>
In-Reply-To: <20190625143715.1689-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

All other get_user_page_fast cases mark the page referenced, so do
this here as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/gup.c b/mm/gup.c
index e06447cff635..d9d022d835ca 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2020,6 +2020,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
+	SetPageReferenced(head);
 	return 1;
 }
 
-- 
2.20.1
