From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 18:04:12 +0000
Subject: [PATCH 4/5] sparc32: drop btfixup for check_pgt_cache
Message-Id: <1336845853-30388-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It is a noop for srmmu - so use a define as sparc64 does.
And drop all sparc callers - no need to confuse our-self
be calling a noop function.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgalloc_32.h |    4 +---
 arch/sparc/kernel/process_32.c      |    2 --
 arch/sparc/mm/init_32.c             |   16 ----------------
 arch/sparc/mm/srmmu.c               |    6 ------
 4 files changed, 1 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index ca2b344..d7ec897 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -21,9 +21,7 @@ extern struct pgtable_cache_struct {
 #define pgtable_cache_size      (pgt_quicklists.pgtable_cache_sz)
 #define pgd_cache_size		(pgt_quicklists.pgd_cache_sz)
 
-extern void check_pgt_cache(void);
-BTFIXUPDEF_CALL(void,	 do_check_pgt_cache, int, int)
-#define do_check_pgt_cache(low,high) BTFIXUP_CALL(do_check_pgt_cache)(low,high)
+#define check_pgt_cache()	do { } while (0)
 
 BTFIXUPDEF_CALL(pgd_t *, get_pgd_fast, void)
 #define get_pgd_fast()		BTFIXUP_CALL(get_pgd_fast)()
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index d8e973d..bb23036 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -82,7 +82,6 @@ void cpu_idle(void)
 				cpu_relax();
 		}
 		schedule_preempt_disabled();
-		check_pgt_cache();
 	}
 }
 
@@ -105,7 +104,6 @@ void cpu_idle(void)
 				cpu_relax();
 		}
 		schedule_preempt_disabled();
-		check_pgt_cache();
 	}
 }
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 753676c..79b215e 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -286,22 +286,6 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 }
 
 /*
- * check_pgt_cache
- *
- * This is called at the end of unmapping of VMA (zap_page_range),
- * to rescan the page cache for architecture specific things.
- * Most architectures define check_pgt_cache empty.
- *
- * We simply copy the 2.4 implementation for now.
- */
-static int pgt_cache_water[2] = { 25, 50 };
-
-void check_pgt_cache(void)
-{
-	do_check_pgt_cache(pgt_cache_water[0], pgt_cache_water[1]);
-}
-
-/*
  * paging_init() sets up the page tables: We call the MMU specific
  * init routine based upon the Sun model type on the Sparc.
  *
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 85d7f82..cb18fa8 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2122,11 +2122,6 @@ static void __init get_srmmu_type(void)
 	srmmu_is_bad();
 }
 
-/* don't laugh, static pagetables */
-static void srmmu_check_pgt_cache(int low, int high)
-{
-}
-
 extern unsigned long spwin_mmu_patchme, fwin_mmu_patchme,
 	tsetup_mmu_patchme, rtrap_mmu_patchme;
 
@@ -2168,7 +2163,6 @@ void __init ld_mmu_srmmu(void)
 #ifndef CONFIG_SMP	
 	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4md, BTFIXUPCALL_SWAPG1G2);
 #endif
-	BTFIXUPSET_CALL(do_check_pgt_cache, srmmu_check_pgt_cache, BTFIXUPCALL_NOP);
 
 	BTFIXUPSET_CALL(set_pte, srmmu_set_pte, BTFIXUPCALL_SWAPO0O1);
 
-- 
1.6.0.6

