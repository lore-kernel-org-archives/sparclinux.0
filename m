From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Apr 2014 19:55:45 +0000
Subject: [PATCH 3/5] sparc32: fix sparse warning in init_32.c
Message-Id: <20140420195545.GC17743@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From beb894608d1b7edb5973e73b0c853228cb48b680 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Apr 2014 19:59:43 +0200
Subject: [PATCH 3/5] sparc32: fix sparse warning in init_32.c

Fix following warning:
init_32.c:112:22: warning: symbol 'bootmem_init' was not declared. Should it be static?

Fix by adding a proper prototype in pgtable_32.h and drop
the local prototype in srmmu.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtable_32.h | 1 +
 arch/sparc/mm/srmmu.c               | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 502f632..7b0c686 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -27,6 +27,7 @@ struct page;
 
 extern void load_mmu(void);
 extern unsigned long calc_highpages(void);
+extern unsigned long __init bootmem_init(unsigned long *pages_avail);
 
 #define pte_ERROR(e)   __builtin_trap()
 #define pmd_ERROR(e)   __builtin_trap()
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index ed0b0b6a..54e834c 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -865,8 +865,6 @@ static void __init map_kernel(void)
 
 void (*poke_srmmu)(void) = NULL;
 
-extern unsigned long bootmem_init(unsigned long *pages_avail);
-
 void __init srmmu_paging_init(void)
 {
 	int i;
-- 
1.8.3.1

