From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 31 May 2017 15:25:22 +0000
Subject: [v1 3/6] sparc64: redefine first version
Message-Id: <1496244325-180257-4-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CTX_FIRST_VERSION defines the first context version, but also it defines
first context. This patch redefines it to only include the first context
version.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/include/asm/mmu_64.h |    2 +-
 arch/sparc/mm/init_64.c         |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index f7de0db..83b36a5 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -52,7 +52,7 @@
 #define CTX_NR_MASK		TAG_CONTEXT_BITS
 #define CTX_HW_MASK		(CTX_NR_MASK | CTX_PGSZ_MASK)
 
-#define CTX_FIRST_VERSION	((_AC(1,UL) << CTX_VERSION_SHIFT) + _AC(1,UL))
+#define CTX_FIRST_VERSION	BIT(CTX_VERSION_SHIFT)
 #define CTX_VALID(__ctx)	\
 	 (!(((__ctx.sparc64_ctx_val) ^ tlb_context_cache) & CTX_VERSION_MASK))
 #define CTX_HWBITS(__ctx)	((__ctx.sparc64_ctx_val) & CTX_HW_MASK)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index e679b14..18f958b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -706,7 +706,7 @@ void __flush_dcache_range(unsigned long start, unsigned long end)
 
 /* get_new_mmu_context() uses "cache + 1".  */
 DEFINE_SPINLOCK(ctx_alloc_lock);
-unsigned long tlb_context_cache = CTX_FIRST_VERSION - 1;
+unsigned long tlb_context_cache = CTX_FIRST_VERSION;
 #define MAX_CTX_NR	(1UL << CTX_NR_BITS)
 #define CTX_BMAP_SLOTS	BITS_TO_LONGS(MAX_CTX_NR)
 DECLARE_BITMAP(mmu_context_bmap, MAX_CTX_NR);
@@ -737,9 +737,9 @@ void get_new_mmu_context(struct mm_struct *mm)
 		if (new_ctx >= ctx) {
 			int i;
 			new_ctx = (tlb_context_cache & CTX_VERSION_MASK) +
-				CTX_FIRST_VERSION;
+				CTX_FIRST_VERSION + 1;
 			if (new_ctx = 1)
-				new_ctx = CTX_FIRST_VERSION;
+				new_ctx = CTX_FIRST_VERSION + 1;
 
 			/* Don't call memset, for 16 entries that's just
 			 * plain silly...
-- 
1.7.1

