From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:48:04 +0000
Subject: [PATCH 5/16]: sparc64: Define WANT_PAGE_VIRTUAL
Message-Id: <20080912.144804.175776032.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Define WANT_PAGE_VIRTUAL

As sparse warns, without this struct page pointer subtraction is
extremely expensive, and this is a pretty common operation in
fast paths.

With this define struct page becomes 64 bytes which makes for a
simple subtract and shift, instead of a costly divide or reciprocol
multiply.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/page_64.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index b579b91..4274ed1 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -38,6 +38,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define WANT_PAGE_VIRTUAL
+
 extern void _clear_page(void *page);
 #define clear_page(X)	_clear_page((void *)(X))
 struct page;
-- 
1.5.6.5.GIT

