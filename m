From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:19 +0000
Subject: [PATCH 1/7]: sparc64: Fix definition of VMEMMAP_SIZE.
Message-Id: <20091124.142119.237150827.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This was the cause of various boot failures on V480, V880, etc.
systems.

Kernel image memory was being overwritten because the vmemmap[]
array was being sized to small.  So if you had physical memory
addresses past a certain point, the early bootup would spam
all over variables in the kernel data section.

The vmemmap mappings map page structs, not page struct pointers.
And that was the key thinko in the macro definition.

This was fixable thanks to the help, reports, and tireless patience
of Hermann Lauer.

Reported-by: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/init_64.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index c2f772d..77d1b31 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -45,7 +45,7 @@ extern void free_initmem(void);
 #define VMEMMAP_ALIGN(x)	(((x)+VMEMMAP_CHUNK-1UL)&VMEMMAP_CHUNK_MASK)
 
 #define VMEMMAP_SIZE	((((1UL << MAX_PHYSADDR_BITS) >> PAGE_SHIFT) * \
-			  sizeof(struct page *)) >> VMEMMAP_CHUNK_SHIFT)
+			  sizeof(struct page)) >> VMEMMAP_CHUNK_SHIFT)
 extern unsigned long vmemmap_table[VMEMMAP_SIZE];
 #endif
 
-- 
1.6.5.3

