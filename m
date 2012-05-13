From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 08:52:16 +0000
Subject: [PATCH 5/2] sparc32: drop btfixup in page_32.h
Message-Id: <20120513085216.GC25608@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 3ae6faacd64842cc4334b53bc31a9156e8bce042 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 10:45:18 +0200
Subject: [PATCH 5/2] sparc32: drop btfixup in page_32.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I know I cannot count.
Anyway - this was all the easy ones in include/asm/..

What left is:
- all the flush variants
- all the smp_ipi variants
- all the dma stuff
- update_mmu_cache (maybe we could drop it - thefunction are both
                    empty. But is contains some sample code I do
                    not know the value of)
- walk through btfixup and drop the now unused stuff

	Sam 

 arch/sparc/include/asm/page_32.h |    5 +----
 arch/sparc/mm/init_32.c          |    1 -
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 2afe1e6..0c902ae 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -110,10 +110,7 @@ typedef unsigned long iopgprot_t;
 typedef struct page *pgtable_t;
 
 extern unsigned long sparc_unmapped_base;
-
-BTFIXUPDEF_SETHI(sparc_unmapped_base)
-
-#define TASK_UNMAPPED_BASE	BTFIXUP_SETHI(sparc_unmapped_base)
+#define TASK_UNMAPPED_BASE	sparc_unmapped_base
 
 #else /* !(__ASSEMBLY__) */
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 61f9b70..a64b0bb 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -300,7 +300,6 @@ void __init paging_init(void)
 	case sun4d:
 		srmmu_paging_init();
 		sparc_unmapped_base = 0x50000000;
-		BTFIXUPSET_SETHI(sparc_unmapped_base, 0x50000000);
 		break;
 	default:
 		prom_printf("paging_init: Cannot init paging on this Sparc\n");
-- 
1.6.0.6

