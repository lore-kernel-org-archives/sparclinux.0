From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 16:31:47 +0000
Subject: [PATCH 3/9] sparc64: Define PAGE_OFFSET in terms of physical address bits.
Message-Id: <20130930.123147.2184661331750783415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This makes clearer the implications for a given choosen
value.

Based upon patches by Bob Picco.

Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index d959312..9dd0f73 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -117,7 +117,9 @@ typedef pte_t *pgtable_t;
 /* We used to stick this into a hard-coded global register (%g4)
  * but that does not make sense anymore.
  */
-#define PAGE_OFFSET		_AC(0xFFFFF80000000000,UL)
+#define MAX_SUPPORTED_PA_BITS	43
+#define PAGE_OFFSET_BY_BITS(X)	(-(_AC(1,UL) << (X)))
+#define PAGE_OFFSET		PAGE_OFFSET_BY_BITS(MAX_SUPPORTED_PA_BITS)
 
 #ifndef __ASSEMBLY__
 
-- 
1.8.1.2

