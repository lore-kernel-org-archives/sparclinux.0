From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:21 +0000
Subject: [PATCH 11/18] sparc32: drop sparc_unmapped_base
Message-Id: <1343336548-3879-11-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The base is always the same so no need to use a variable for this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/page_32.h |    3 +--
 arch/sparc/mm/init_32.c          |    2 --
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index fab78a3..f82a1f3 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -107,8 +107,7 @@ typedef unsigned long iopgprot_t;
 
 typedef struct page *pgtable_t;
 
-extern unsigned long sparc_unmapped_base;
-#define TASK_UNMAPPED_BASE	sparc_unmapped_base
+#define TASK_UNMAPPED_BASE	0x50000000
 
 #else /* !(__ASSEMBLY__) */
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e8ea360..fc77bb8 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -45,7 +45,6 @@ unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
 
 struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
-unsigned long sparc_unmapped_base;
 
 struct pgtable_cache_struct pgt_quicklists;
 
@@ -297,7 +296,6 @@ void __init paging_init(void)
 	case sun4m:
 	case sun4d:
 		srmmu_paging_init();
-		sparc_unmapped_base = 0x50000000;
 		break;
 	default:
 		prom_printf("paging_init: Cannot init paging on this Sparc\n");
-- 
1.6.0.6

