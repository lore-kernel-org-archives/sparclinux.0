From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:23 +0000
Subject: [PATCH 13/18] sparc32: drop quicklist
Message-Id: <1343336548-3879-13-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The quicklist stuff is not used anymore - drop it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgalloc_32.h |   13 -------------
 arch/sparc/mm/init_32.c             |    2 --
 2 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index bf20809..9b1c36d 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -11,22 +11,9 @@
 
 struct page;
 
-extern struct pgtable_cache_struct {
-	unsigned long *pgd_cache;
-	unsigned long *pte_cache;
-	unsigned long pgtable_cache_sz;
-	unsigned long pgd_cache_sz;
-} pgt_quicklists;
-
 void *srmmu_get_nocache(int size, int align);
 void srmmu_free_nocache(void *addr, int size);
 
-#define pgd_quicklist           (pgt_quicklists.pgd_cache)
-#define pmd_quicklist           ((unsigned long *)0)
-#define pte_quicklist           (pgt_quicklists.pte_cache)
-#define pgtable_cache_size      (pgt_quicklists.pgtable_cache_sz)
-#define pgd_cache_size		(pgt_quicklists.pgd_cache_sz)
-
 #define check_pgt_cache()	do { } while (0)
 
 pgd_t *get_pgd_fast(void);
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 6dce086..6d44c2b 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -46,8 +46,6 @@ EXPORT_SYMBOL(pfn_base);
 
 struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 
-struct pgtable_cache_struct pgt_quicklists;
-
 /* Initial ramdisk setup */
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
-- 
1.6.0.6

