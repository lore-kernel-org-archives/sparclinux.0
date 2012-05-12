From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 18:04:13 +0000
Subject: [PATCH 5/5] sparc32: drop unused type/extern
Message-Id: <1336845853-30388-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/page_32.h    |    6 ------
 arch/sparc/include/asm/pgtable_32.h |    8 --------
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index bb5c2ac..2afe1e6 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -45,12 +45,6 @@ struct sparc_phys_banks {
 
 extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 
-/* Cache alias structure.  Entry is valid if context != -1. */
-struct cache_palias {
-	unsigned long vaddr;
-	int context;
-};
-
 /* passing structs on the Sparc slow us down tremendously... */
 
 /* #define STRICT_MM_TYPECHECKS */
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 9de855c..4a29b05 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -77,14 +77,6 @@ extern pgd_t swapper_pg_dir[1024];
 
 extern void paging_init(void);
 
-/* Page table for 0-4MB for everybody, on the Sparc this
- * holds the same as on the i386.
- */
-extern pte_t pg0[1024];
-extern pte_t pg1[1024];
-extern pte_t pg2[1024];
-extern pte_t pg3[1024];
-
 extern unsigned long ptr_in_current_pgd;
 
 /* Here is a trick, since mmap.c need the initializer elements for
-- 
1.6.0.6

